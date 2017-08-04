Received: from eggs.gnu.org ([2001:4830:134:3::10]:54663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJN-0005UX-Un
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJL-0007ES-F6
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:49 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:33097 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1ddeJL-00079O-1X
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:47 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  4 Aug 2017 18:14:40 +0300
Message-Id: <20170804151440.320927-18-vsementsov@virtuozzo.com>
In-Reply-To: <20170804151440.320927-1-vsementsov@virtuozzo.com>
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 17/17] block/nbd-client: always return EIO on
 and after the first io channel error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Do not communicate after the first error to avoid communicating throught
broken channel. The only exclusion is try to send NBD_CMD_DISC anyway on
in nbd_client_close.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 7c151b3dd3..6109abf8a7 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -49,6 +49,8 @@ static void nbd_teardown_connection(BlockDriverState *bs)
 {
     NBDClientSession *client = nbd_get_client_session(bs);
 
+    client->eio_to_all = true;
+
     if (!client->ioc) { /* Already closed */
         return;
     }
@@ -75,11 +77,15 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
     NBDReply reply;
 
     for (;;) {
+        if (s->eio_to_all) {
+            break;
+        }
+
         ret = nbd_receive_reply(s->ioc, &reply, &local_err);
         if (ret < 0) {
             error_report_err(local_err);
         }
-        if (ret <= 0) {
+        if (ret <= 0 || s->eio_to_all) {
             break;
         }
 
@@ -99,7 +105,7 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
             ret = nbd_rwv(s->ioc, s->requests[i].qiov->iov,
                           s->requests[i].qiov->niov,
                           s->requests[i].request->len, true, NULL);
-            if (ret != s->requests[i].request->len) {
+            if (ret != s->requests[i].request->len || s->eio_to_all) {
                 break;
             }
         }
@@ -133,6 +139,10 @@ static int nbd_co_request(BlockDriverState *bs,
     NBDClientSession *s = nbd_get_client_session(bs);
     int rc, ret, i;
 
+    if (s->eio_to_all) {
+        return -EIO;
+    }
+
     qemu_co_mutex_lock(&s->send_mutex);
     while (s->in_flight == MAX_NBD_REQUESTS) {
         qemu_co_queue_wait(&s->free_sema, &s->send_mutex);
@@ -152,16 +162,16 @@ static int nbd_co_request(BlockDriverState *bs,
     s->requests[i].request = request;
     s->requests[i].qiov = qiov;
 
-    if (!s->ioc) {
+    if (s->eio_to_all) {
         qemu_co_mutex_unlock(&s->send_mutex);
-        return -EPIPE;
+        return -EIO;
     }
 
     if (request->type == NBD_CMD_WRITE) {
         assert(qiov != NULL);
         qio_channel_set_cork(s->ioc, true);
         rc = nbd_send_request(s->ioc, request);
-        if (rc >= 0) {
+        if (rc == 0 && !s->eio_to_all) {
             ret = nbd_rwv(s->ioc, qiov->iov, qiov->niov, request->len, false,
                           NULL);
             if (ret != request->len) {
@@ -174,13 +184,16 @@ static int nbd_co_request(BlockDriverState *bs,
     }
     qemu_co_mutex_unlock(&s->send_mutex);
 
+    if (s->eio_to_all) {
+        rc = -EIO;
+    }
     if (rc < 0) {
         goto out;
     }
 
     /* Wait until we're woken up by nbd_read_reply_entry.  */
     qemu_coroutine_yield();
-    if (!s->ioc || s->eio_to_all) {
+    if (s->eio_to_all) {
         rc = -EIO;
         goto out;
     }
@@ -335,6 +348,7 @@ int nbd_client_init(BlockDriverState *bs,
     logout("session init %s\n", export);
     qio_channel_set_blocking(QIO_CHANNEL(sioc), true, NULL);
 
+    client->eio_to_all = false;
     client->info.request_sizes = true;
     ret = nbd_receive_negotiate(QIO_CHANNEL(sioc), export,
                                 tlscreds, hostname,
-- 
2.11.1
