Received: from eggs.gnu.org ([2001:4830:134:3::10]:50256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fcmC8-0001ig-Ui
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:32:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fcmC8-0007sp-14
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:32:16 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 10 Jul 2018 14:31:18 +0800
Message-Id: <20180710063124.2263-5-famz@redhat.com>
In-Reply-To: <20180710063124.2263-1-famz@redhat.com>
References: <20180710063124.2263-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 04/10] block: Use uint64_t for
 BdrvTrackedRequest byte fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This matches the types used for bytes in the rest parts of block layer.
In the case of bdrv_co_truncate, new_bytes can be the image size which
probably doesn't fit in a 32 bit int.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/io.c                | 8 +++++---
 include/block/block_int.h | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/io.c b/block/io.c
index 77f35b1013..c56e329bb5 100644
--- a/block/io.c
+++ b/block/io.c
@@ -587,9 +587,11 @@ static void tracked_request_end(BdrvTrackedRequest *req)
 static void tracked_request_begin(BdrvTrackedRequest *req,
                                   BlockDriverState *bs,
                                   int64_t offset,
-                                  unsigned int bytes,
+                                  uint64_t bytes,
                                   enum BdrvTrackedRequestType type)
 {
+    assert(bytes <= INT64_MAX && offset <= INT64_MAX - bytes);
+
     *req = (BdrvTrackedRequest){
         .bs = bs,
         .offset         = offset,
@@ -611,7 +613,7 @@ static void tracked_request_begin(BdrvTrackedRequest *req,
 static void mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
 {
     int64_t overlap_offset = req->offset & ~(align - 1);
-    unsigned int overlap_bytes = ROUND_UP(req->offset + req->bytes, align)
+    uint64_t overlap_bytes = ROUND_UP(req->offset + req->bytes, align)
                                - overlap_offset;
 
     if (!req->serialising) {
@@ -667,7 +669,7 @@ static int bdrv_get_cluster_size(BlockDriverState *bs)
 }
 
 static bool tracked_request_overlaps(BdrvTrackedRequest *req,
-                                     int64_t offset, unsigned int bytes)
+                                     int64_t offset, uint64_t bytes)
 {
     /*        aaaa   bbbb */
     if (offset >= req->overlap_offset + req->overlap_bytes) {
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 119b6e4ea5..90a33e4b0e 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -69,12 +69,12 @@ enum BdrvTrackedRequestType {
 typedef struct BdrvTrackedRequest {
     BlockDriverState *bs;
     int64_t offset;
-    unsigned int bytes;
+    uint64_t bytes;
     enum BdrvTrackedRequestType type;
 
     bool serialising;
     int64_t overlap_offset;
-    unsigned int overlap_bytes;
+    uint64_t overlap_bytes;
 
     QLIST_ENTRY(BdrvTrackedRequest) list;
     Coroutine *co; /* owner, used for deadlock detection */
-- 
2.17.1
