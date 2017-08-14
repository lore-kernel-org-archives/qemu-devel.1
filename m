Received: from eggs.gnu.org ([2001:4830:134:3::10]:38366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhN0Q-0005u7-V8
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhN0P-0006Ra-Os
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:34:38 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 14 Aug 2017 16:34:26 -0500
Message-Id: <20170814213426.24681-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 v2] nbd-client: Fix regression when
 server sends garbage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

When we switched NBD to use coroutines for qemu 2.9 (in particular,
commit a12a712a), we introduced a regression: if a server sends us
garbage (such as a corrupted magic number), we quit the read loop
but do not stop sending further queued commands, resulting in the
client hanging when it never reads the response to those additional
commands.  In qemu 2.8, we properly detected that the server is no
longer reliable, and cancelled all existing pending commands with
EIO, then tore down the socket so that all further command attempts
get EPIPE.

Restore the proper behavior of quitting (almost) all communication
with a broken server: Once we know we are out of sync or otherwise
can't trust the server, we must assume that any further incoming
data is unreliable and therefore end all pending commands with EIO,
and quit trying to send any further commands.  As an exception, we
still (try to) send NBD_CMD_DISC to let the server know we are going
away (in part, because it is easier to do that than to further
refactor nbd_teardown_connection, and in part because it is the
only command where we do not have to wait for a reply).

Based on a patch by Vladimir Sementsov-Ogievskiy.

A malicious server can be created with the following hack,
followed by setting NBD_SERVER_DEBUG to a non-zero value in the
environment when running qemu-nbd:

| --- a/nbd/server.c
| +++ b/nbd/server.c
| @@ -919,6 +919,17 @@ static int nbd_send_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
|      stl_be_p(buf + 4, reply->error);
|      stq_be_p(buf + 8, reply->handle);
|
| +    static int debug;
| +    static int count;
| +    if (!count++) {
| +        const char *str = getenv("NBD_SERVER_DEBUG");
| +        if (str) {
| +            debug = atoi(str);
| +        }
| +    }
| +    if (debug && !(count % debug)) {
| +        buf[0] = 0;
| +    }
|      return nbd_write(ioc, buf, sizeof(buf), errp);
|  }

Reported-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---

Supercedes both Vladimir and my earlier attempts:
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02131.html
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg01501.html

 block/nbd-client.h |  1 +
 block/nbd-client.c | 14 ++++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index df80771357..1935ffbcaa 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -29,6 +29,7 @@ typedef struct NBDClientSession {

     Coroutine *recv_coroutine[MAX_NBD_REQUESTS];
     NBDReply reply;
+    bool quit;
 } NBDClientSession;

 NBDClientSession *nbd_get_client_session(BlockDriverState *bs);
diff --git a/block/nbd-client.c b/block/nbd-client.c
index 25dd28406b..bb17e3da45 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -73,7 +73,7 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
     int ret;
     Error *local_err = NULL;

-    for (;;) {
+    while (!s->quit) {
         assert(s->reply.handle == 0);
         ret = nbd_receive_reply(s->ioc, &s->reply, &local_err);
         if (ret < 0) {
@@ -107,6 +107,9 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
         qemu_coroutine_yield();
     }

+    if (ret < 0) {
+        s->quit = true;
+    }
     nbd_recv_coroutines_enter_all(s);
     s->read_reply_co = NULL;
 }
@@ -135,6 +138,10 @@ static int nbd_co_send_request(BlockDriverState *bs,
     assert(i < MAX_NBD_REQUESTS);
     request->handle = INDEX_TO_HANDLE(s, i);

+    if (s->quit) {
+        qemu_co_mutex_unlock(&s->send_mutex);
+        return -EIO;
+    }
     if (!s->ioc) {
         qemu_co_mutex_unlock(&s->send_mutex);
         return -EPIPE;
@@ -143,7 +150,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
     if (qiov) {
         qio_channel_set_cork(s->ioc, true);
         rc = nbd_send_request(s->ioc, request);
-        if (rc >= 0) {
+        if (rc >= 0 && !s->quit) {
             ret = nbd_rwv(s->ioc, qiov->iov, qiov->niov, request->len, false,
                           NULL);
             if (ret != request->len) {
@@ -168,8 +175,7 @@ static void nbd_co_receive_reply(NBDClientSession *s,
     /* Wait until we're woken up by nbd_read_reply_entry.  */
     qemu_coroutine_yield();
     *reply = s->reply;
-    if (reply->handle != request->handle ||
-        !s->ioc) {
+    if (reply->handle != request->handle || !s->ioc || s->quit) {
         reply->error = EIO;
     } else {
         if (qiov && reply->error == 0) {
-- 
2.13.5
