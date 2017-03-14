Received: from eggs.gnu.org ([2001:4830:134:3::10]:47959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnkN3-0005pH-0t
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:12:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnkN1-0005dy-UL
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:12:04 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 14 Mar 2017 12:11:56 +0100
Message-Id: <20170314111157.14464-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] nbd-client: fix handling of hungup connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

After the switch to reading replies in a coroutine, nothing is
reentering pending receive coroutines if the connection hangs.
Move nbd_recv_coroutines_enter_all to the reply read coroutine,
which is the place where hangups are detected.  nbd_teardown_connection
can simply wait for the reply read coroutine to detect the hangup
and clean up after itself.

This wouldn't be enough though because nbd_receive_reply returns 0
(rather than -EPIPE or similar) when reading from a hung connection.
Fix the return value check in nbd_read_reply_entry.

This fixes qemu-iotests 083.

Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/nbd-client.c | 12 ++++++------
 nbd/client.c       |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 0dc12c2..1e2952f 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -33,17 +33,15 @@
 #define HANDLE_TO_INDEX(bs, handle) ((handle) ^ ((uint64_t)(intptr_t)bs))
 #define INDEX_TO_HANDLE(bs, index)  ((index)  ^ ((uint64_t)(intptr_t)bs))
 
-static void nbd_recv_coroutines_enter_all(BlockDriverState *bs)
+static void nbd_recv_coroutines_enter_all(NBDClientSession *s)
 {
-    NBDClientSession *s = nbd_get_client_session(bs);
     int i;
 
     for (i = 0; i < MAX_NBD_REQUESTS; i++) {
         if (s->recv_coroutine[i]) {
-            qemu_coroutine_enter(s->recv_coroutine[i]);
+            aio_co_wake(s->recv_coroutine[i]);
         }
     }
-    BDRV_POLL_WHILE(bs, s->read_reply_co);
 }
 
 static void nbd_teardown_connection(BlockDriverState *bs)
@@ -58,7 +56,7 @@ static void nbd_teardown_connection(BlockDriverState *bs)
     qio_channel_shutdown(client->ioc,
                          QIO_CHANNEL_SHUTDOWN_BOTH,
                          NULL);
-    nbd_recv_coroutines_enter_all(bs);
+    BDRV_POLL_WHILE(bs, client->read_reply_co);
 
     nbd_client_detach_aio_context(bs);
     object_unref(OBJECT(client->sioc));
@@ -76,7 +74,7 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
     for (;;) {
         assert(s->reply.handle == 0);
         ret = nbd_receive_reply(s->ioc, &s->reply);
-        if (ret < 0) {
+        if (ret <= 0) {
             break;
         }
 
@@ -103,6 +101,8 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
         aio_co_wake(s->recv_coroutine[i]);
         qemu_coroutine_yield();
     }
+
+    nbd_recv_coroutines_enter_all(s);
     s->read_reply_co = NULL;
 }
 
diff --git a/nbd/client.c b/nbd/client.c
index 5c9dee3..746e9a7 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -812,6 +812,6 @@ ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply)
         LOG("invalid magic (got 0x%" PRIx32 ")", magic);
         return -EINVAL;
     }
-    return 0;
+    return sizeof(buf);
 }
 
-- 
2.9.3
