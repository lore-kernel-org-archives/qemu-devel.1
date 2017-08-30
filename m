Received: from eggs.gnu.org ([2001:4830:134:3::10]:53277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn7Oy-00029P-73
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn7Ou-0001fm-VK
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:07:44 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 30 Aug 2017 13:07:11 -0500
Message-Id: <20170830180711.7974-12-eblake@redhat.com>
In-Reply-To: <20170830180711.7974-1-eblake@redhat.com>
References: <20170830180711.7974-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 11/11] block/nbd-client: refactor request
 send/receive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Add nbd_co_request, to remove code duplications in
nbd_client_co_{pwrite,pread,...} functions. Also this is
needed for further refactoring.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20170804151440.320927-8-vsementsov@virtuozzo.com>
[eblake: make nbd_co_request a wrapper, rather than merging two
existing functions]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd-client.c | 73 +++++++++++++++++++-----------------------------------
 1 file changed, 26 insertions(+), 47 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 322b725ff9..f0dbea24d3 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -220,28 +220,40 @@ static void nbd_co_receive_reply(NBDClientSession *s,
     qemu_co_mutex_unlock(&s->send_mutex);
 }

+static int nbd_co_request(BlockDriverState *bs,
+                          NBDRequest *request,
+                          QEMUIOVector *qiov)
+{
+    NBDClientSession *client = nbd_get_client_session(bs);
+    NBDReply reply;
+    int ret;
+
+    assert(!qiov || request->type == NBD_CMD_WRITE ||
+           request->type == NBD_CMD_READ);
+    ret = nbd_co_send_request(bs, request,
+                              request->type == NBD_CMD_WRITE ? qiov : NULL);
+    if (ret < 0) {
+        reply.error = -ret;
+    } else {
+        nbd_co_receive_reply(client, request, &reply,
+                             request->type == NBD_CMD_READ ? qiov : NULL);
+    }
+    return -reply.error;
+}
+
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
-    return -reply.error;
+    return nbd_co_request(bs, &request, qiov);
 }

 int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
@@ -253,8 +265,6 @@ int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
         .from = offset,
         .len = bytes,
     };
-    NBDReply reply;
-    int ret;

     if (flags & BDRV_REQ_FUA) {
         assert(client->info.flags & NBD_FLAG_SEND_FUA);
@@ -263,26 +273,18 @@ int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,

     assert(bytes <= NBD_MAX_BUFFER_SIZE);

-    ret = nbd_co_send_request(bs, &request, qiov);
-    if (ret < 0) {
-        reply.error = -ret;
-    } else {
-        nbd_co_receive_reply(client, &request, &reply, NULL);
-    }
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
@@ -296,21 +298,13 @@ int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
         request.flags |= NBD_CMD_FLAG_NO_HOLE;
     }

-    ret = nbd_co_send_request(bs, &request, NULL);
-    if (ret < 0) {
-        reply.error = -ret;
-    } else {
-        nbd_co_receive_reply(client, &request, &reply, NULL);
-    }
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
@@ -319,13 +313,7 @@ int nbd_client_co_flush(BlockDriverState *bs)
     request.from = 0;
     request.len = 0;

-    ret = nbd_co_send_request(bs, &request, NULL);
-    if (ret < 0) {
-        reply.error = -ret;
-    } else {
-        nbd_co_receive_reply(client, &request, &reply, NULL);
-    }
-    return -reply.error;
+    return nbd_co_request(bs, &request, NULL);
 }

 int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
@@ -336,21 +324,12 @@ int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
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
-    return -reply.error;
-
+    return nbd_co_request(bs, &request, NULL);
 }

 void nbd_client_detach_aio_context(BlockDriverState *bs)
-- 
2.13.5
