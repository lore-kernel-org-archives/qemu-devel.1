Received: from eggs.gnu.org ([2001:4830:134:3::10]:54759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJP-0005Wp-Se
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJM-0007GW-R8
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:51 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:47517 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1ddeJM-00078e-Aq
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:48 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  4 Aug 2017 18:14:30 +0300
Message-Id: <20170804151440.320927-8-vsementsov@virtuozzo.com>
In-Reply-To: <20170804151440.320927-1-vsementsov@virtuozzo.com>
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 07/17] block/nbd-client: refactor request
 send/receive
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

Move nbd_co_receive_reply and nbd_coroutine_end calls into
nbd_co_send_request and rename the latter to just nbd_co_request.

This removes code duplications in nbd_client_co_{pwrite,pread,...}
functions. Also this is needed for further refactoring.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 89 ++++++++++++++++++++----------------------------------
 1 file changed, 33 insertions(+), 56 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 0c88d84de6..c9ade9b517 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -112,12 +112,20 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
     s->read_reply_co = NULL;
 }
 
-static int nbd_co_send_request(BlockDriverState *bs,
-                               NBDRequest *request,
-                               QEMUIOVector *qiov)
+static void nbd_co_receive_reply(NBDClientSession *s,
+                                 NBDRequest *request,
+                                 NBDReply *reply,
+                                 QEMUIOVector *qiov);
+static void nbd_coroutine_end(BlockDriverState *bs,
+                              NBDRequest *request);
+
+static int nbd_co_request(BlockDriverState *bs,
+                          NBDRequest *request,
+                          QEMUIOVector *qiov)
 {
     NBDClientSession *s = nbd_get_client_session(bs);
     int rc, ret, i;
+    NBDReply reply;
 
     qemu_co_mutex_lock(&s->send_mutex);
     while (s->in_flight == MAX_NBD_REQUESTS) {
@@ -141,7 +149,8 @@ static int nbd_co_send_request(BlockDriverState *bs,
         return -EPIPE;
     }
 
-    if (qiov) {
+    if (request->type == NBD_CMD_WRITE) {
+        assert(qiov != NULL);
         qio_channel_set_cork(s->ioc, true);
         rc = nbd_send_request(s->ioc, request);
         if (rc >= 0) {
@@ -156,6 +165,21 @@ static int nbd_co_send_request(BlockDriverState *bs,
         rc = nbd_send_request(s->ioc, request);
     }
     qemu_co_mutex_unlock(&s->send_mutex);
+
+    if (rc < 0) {
+        goto out;
+    }
+
+    if (request->type == NBD_CMD_READ) {
+        assert(qiov != NULL);
+    } else {
+        qiov = NULL;
+    }
+    nbd_co_receive_reply(s, request, &reply, qiov);
+    rc = -reply.error;
+
+out:
+    nbd_coroutine_end(bs, request);
     return rc;
 }
 
@@ -208,26 +232,16 @@ static void nbd_coroutine_end(BlockDriverState *bs,
 int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
                          uint64_t bytes, QEMUIOVector *qiov, int flags)
 {
-    NBDClientSession *client = nbd_get_client_session(bs);
     NBDRequest request = {
         .type = NBD_CMD_READ,
         .from = offset,
         .len = bytes,
     };
-    NBDReply reply;
-    int ret;
 
     assert(bytes <= NBD_MAX_BUFFER_SIZE);
     assert(!flags);
 
-    ret = nbd_co_send_request(bs, &request, NULL);
-    if (ret < 0) {
-        reply.error = -ret;
-    } else {
-        nbd_co_receive_reply(client, &request, &reply, qiov);
-    }
-    nbd_coroutine_end(bs, &request);
-    return -reply.error;
+    return nbd_co_request(bs, &request, qiov);
 }
 
 int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
@@ -239,8 +253,6 @@ int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
         .from = offset,
         .len = bytes,
     };
-    NBDReply reply;
-    int ret;
 
     if (flags & BDRV_REQ_FUA) {
         assert(client->info.flags & NBD_FLAG_SEND_FUA);
@@ -249,27 +261,18 @@ int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
 
     assert(bytes <= NBD_MAX_BUFFER_SIZE);
 
-    ret = nbd_co_send_request(bs, &request, qiov);
-    if (ret < 0) {
-        reply.error = -ret;
-    } else {
-        nbd_co_receive_reply(client, &request, &reply, NULL);
-    }
-    nbd_coroutine_end(bs, &request);
-    return -reply.error;
+    return nbd_co_request(bs, &request, qiov);
 }
 
 int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
                                 int bytes, BdrvRequestFlags flags)
 {
-    int ret;
     NBDClientSession *client = nbd_get_client_session(bs);
     NBDRequest request = {
         .type = NBD_CMD_WRITE_ZEROES,
         .from = offset,
         .len = bytes,
     };
-    NBDReply reply;
 
     if (!(client->info.flags & NBD_FLAG_SEND_WRITE_ZEROES)) {
         return -ENOTSUP;
@@ -283,22 +286,13 @@ int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
         request.flags |= NBD_CMD_FLAG_NO_HOLE;
     }
 
-    ret = nbd_co_send_request(bs, &request, NULL);
-    if (ret < 0) {
-        reply.error = -ret;
-    } else {
-        nbd_co_receive_reply(client, &request, &reply, NULL);
-    }
-    nbd_coroutine_end(bs, &request);
-    return -reply.error;
+    return nbd_co_request(bs, &request, NULL);
 }
 
 int nbd_client_co_flush(BlockDriverState *bs)
 {
     NBDClientSession *client = nbd_get_client_session(bs);
     NBDRequest request = { .type = NBD_CMD_FLUSH };
-    NBDReply reply;
-    int ret;
 
     if (!(client->info.flags & NBD_FLAG_SEND_FLUSH)) {
         return 0;
@@ -307,14 +301,7 @@ int nbd_client_co_flush(BlockDriverState *bs)
     request.from = 0;
     request.len = 0;
 
-    ret = nbd_co_send_request(bs, &request, NULL);
-    if (ret < 0) {
-        reply.error = -ret;
-    } else {
-        nbd_co_receive_reply(client, &request, &reply, NULL);
-    }
-    nbd_coroutine_end(bs, &request);
-    return -reply.error;
+    return nbd_co_request(bs, &request, NULL);
 }
 
 int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
@@ -325,22 +312,12 @@ int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
         .from = offset,
         .len = bytes,
     };
-    NBDReply reply;
-    int ret;
 
     if (!(client->info.flags & NBD_FLAG_SEND_TRIM)) {
         return 0;
     }
 
-    ret = nbd_co_send_request(bs, &request, NULL);
-    if (ret < 0) {
-        reply.error = -ret;
-    } else {
-        nbd_co_receive_reply(client, &request, &reply, NULL);
-    }
-    nbd_coroutine_end(bs, &request);
-    return -reply.error;
-
+    return nbd_co_request(bs, &request, NULL);
 }
 
 void nbd_client_detach_aio_context(BlockDriverState *bs)
-- 
2.11.1
