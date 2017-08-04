Received: from eggs.gnu.org ([2001:4830:134:3::10]:54625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJN-0005UG-3g
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJK-0007CJ-N3
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:48 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:18224 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1ddeJK-00077p-BJ
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:46 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  4 Aug 2017 18:14:28 +0300
Message-Id: <20170804151440.320927-6-vsementsov@virtuozzo.com>
In-Reply-To: <20170804151440.320927-1-vsementsov@virtuozzo.com>
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 05/17] block/nbd-client: get rid of ssize_t
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

Use int variable for nbd_co_send_request return value (as
nbd_co_send_request returns int).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 25dd28406b..dc19894a7c 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -214,7 +214,7 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
         .len = bytes,
     };
     NBDReply reply;
-    ssize_t ret;
+    int ret;
 
     assert(bytes <= NBD_MAX_BUFFER_SIZE);
     assert(!flags);
@@ -239,7 +239,7 @@ int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
         .len = bytes,
     };
     NBDReply reply;
-    ssize_t ret;
+    int ret;
 
     if (flags & BDRV_REQ_FUA) {
         assert(client->info.flags & NBD_FLAG_SEND_FUA);
@@ -261,7 +261,7 @@ int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
 int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
                                 int bytes, BdrvRequestFlags flags)
 {
-    ssize_t ret;
+    int ret;
     NBDClientSession *client = nbd_get_client_session(bs);
     NBDRequest request = {
         .type = NBD_CMD_WRITE_ZEROES,
@@ -297,7 +297,7 @@ int nbd_client_co_flush(BlockDriverState *bs)
     NBDClientSession *client = nbd_get_client_session(bs);
     NBDRequest request = { .type = NBD_CMD_FLUSH };
     NBDReply reply;
-    ssize_t ret;
+    int ret;
 
     if (!(client->info.flags & NBD_FLAG_SEND_FLUSH)) {
         return 0;
@@ -325,7 +325,7 @@ int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
         .len = bytes,
     };
     NBDReply reply;
-    ssize_t ret;
+    int ret;
 
     if (!(client->info.flags & NBD_FLAG_SEND_TRIM)) {
         return 0;
-- 
2.11.1
