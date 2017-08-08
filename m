Received: from eggs.gnu.org ([2001:4830:134:3::10]:59551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1df6Oh-0007rx-29
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:26:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1df6Oc-0004eq-44
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:26:19 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:13082 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1df6Ob-0004d2-GB
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:26:14 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  8 Aug 2017 18:26:07 +0300
Message-Id: <20170808152607.147691-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 for 2.10] block/nbd-client: always return
 EIO on and after the first io channel error
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

Hi all. Here is a patch, fixing a problem noted in
[PATCH 06/17] block/nbd-client: fix nbd_read_reply_entry
and
[PATCH 17/17] block/nbd-client: always return EIO on and after the first io channel error
and discussed on list.

If it will be applied to 2.10, then I'll rebase my 'nbd client refactoring and fixing'
on it (for 2.11). If not - I'll prefer not rebase the series, so, do not apply this
patch for 2.11.

v2: set eio_to_all in nbd_co_send_request and nbd_co_receive_reply in case of error

 block/nbd-client.h |  1 +
 block/nbd-client.c | 65 +++++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 48 insertions(+), 18 deletions(-)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index df80771357..28db9922c8 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -29,6 +29,7 @@ typedef struct NBDClientSession {
 
     Coroutine *recv_coroutine[MAX_NBD_REQUESTS];
     NBDReply reply;
+    bool eio_to_all;
 } NBDClientSession;
 
 NBDClientSession *nbd_get_client_session(BlockDriverState *bs);
diff --git a/block/nbd-client.c b/block/nbd-client.c
index 25dd28406b..a72cb7690a 100644
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
@@ -74,12 +76,16 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
     Error *local_err = NULL;
 
     for (;;) {
+        if (s->eio_to_all) {
+            break;
+        }
+
         assert(s->reply.handle == 0);
         ret = nbd_receive_reply(s->ioc, &s->reply, &local_err);
         if (ret < 0) {
             error_report_err(local_err);
         }
-        if (ret <= 0) {
+        if (ret <= 0 || s->eio_to_all) {
             break;
         }
 
@@ -107,6 +113,7 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
         qemu_coroutine_yield();
     }
 
+    s->eio_to_all = true;
     nbd_recv_coroutines_enter_all(s);
     s->read_reply_co = NULL;
 }
@@ -118,6 +125,10 @@ static int nbd_co_send_request(BlockDriverState *bs,
     NBDClientSession *s = nbd_get_client_session(bs);
     int rc, ret, i;
 
+    if (s->eio_to_all) {
+        return -EIO;
+    }
+
     qemu_co_mutex_lock(&s->send_mutex);
     while (s->in_flight == MAX_NBD_REQUESTS) {
         qemu_co_queue_wait(&s->free_sema, &s->send_mutex);
@@ -135,15 +146,15 @@ static int nbd_co_send_request(BlockDriverState *bs,
     assert(i < MAX_NBD_REQUESTS);
     request->handle = INDEX_TO_HANDLE(s, i);
 
-    if (!s->ioc) {
+    if (s->eio_to_all) {
         qemu_co_mutex_unlock(&s->send_mutex);
-        return -EPIPE;
+        return -EIO;
     }
 
     if (qiov) {
         qio_channel_set_cork(s->ioc, true);
         rc = nbd_send_request(s->ioc, request);
-        if (rc >= 0) {
+        if (rc >= 0 && !s->eio_to_all) {
             ret = nbd_rwv(s->ioc, qiov->iov, qiov->niov, request->len, false,
                           NULL);
             if (ret != request->len) {
@@ -155,7 +166,13 @@ static int nbd_co_send_request(BlockDriverState *bs,
         rc = nbd_send_request(s->ioc, request);
     }
     qemu_co_mutex_unlock(&s->send_mutex);
-    return rc;
+
+    if (rc < 0 || s->eio_to_all) {
+        s->eio_to_all = true;
+        return -EIO;
+    }
+
+    return 0;
 }
 
 static void nbd_co_receive_reply(NBDClientSession *s,
@@ -169,14 +186,16 @@ static void nbd_co_receive_reply(NBDClientSession *s,
     qemu_coroutine_yield();
     *reply = s->reply;
     if (reply->handle != request->handle ||
-        !s->ioc) {
+        !s->ioc || s->eio_to_all) {
         reply->error = EIO;
+        s->eio_to_all = true;
     } else {
         if (qiov && reply->error == 0) {
             ret = nbd_rwv(s->ioc, qiov->iov, qiov->niov, request->len, true,
                           NULL);
-            if (ret != request->len) {
+            if (ret != request->len || s->eio_to_all) {
                 reply->error = EIO;
+                s->eio_to_all = true;
             }
         }
 
@@ -225,8 +244,10 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
     } else {
         nbd_co_receive_reply(client, &request, &reply, qiov);
     }
-    nbd_coroutine_end(bs, &request);
-    return -reply.error;
+    if (request.handle != 0) {
+        nbd_coroutine_end(bs, &request);
+    }
+    return client->eio_to_all ? -EIO : -reply.error;
 }
 
 int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
@@ -254,8 +275,10 @@ int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
     } else {
         nbd_co_receive_reply(client, &request, &reply, NULL);
     }
-    nbd_coroutine_end(bs, &request);
-    return -reply.error;
+    if (request.handle != 0) {
+        nbd_coroutine_end(bs, &request);
+    }
+    return client->eio_to_all ? -EIO : -reply.error;
 }
 
 int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
@@ -288,8 +311,10 @@ int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
     } else {
         nbd_co_receive_reply(client, &request, &reply, NULL);
     }
-    nbd_coroutine_end(bs, &request);
-    return -reply.error;
+    if (request.handle != 0) {
+        nbd_coroutine_end(bs, &request);
+    }
+    return client->eio_to_all ? -EIO : -reply.error;
 }
 
 int nbd_client_co_flush(BlockDriverState *bs)
@@ -312,8 +337,10 @@ int nbd_client_co_flush(BlockDriverState *bs)
     } else {
         nbd_co_receive_reply(client, &request, &reply, NULL);
     }
-    nbd_coroutine_end(bs, &request);
-    return -reply.error;
+    if (request.handle != 0) {
+        nbd_coroutine_end(bs, &request);
+    }
+    return client->eio_to_all ? -EIO : -reply.error;
 }
 
 int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
@@ -337,9 +364,10 @@ int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
     } else {
         nbd_co_receive_reply(client, &request, &reply, NULL);
     }
-    nbd_coroutine_end(bs, &request);
-    return -reply.error;
-
+    if (request.handle != 0) {
+        nbd_coroutine_end(bs, &request);
+    }
+    return client->eio_to_all ? -EIO : -reply.error;
 }
 
 void nbd_client_detach_aio_context(BlockDriverState *bs)
@@ -384,6 +412,7 @@ int nbd_client_init(BlockDriverState *bs,
     logout("session init %s\n", export);
     qio_channel_set_blocking(QIO_CHANNEL(sioc), true, NULL);
 
+    client->eio_to_all = false;
     client->info.request_sizes = true;
     ret = nbd_receive_negotiate(QIO_CHANNEL(sioc), export,
                                 tlscreds, hostname,
-- 
2.11.1
