Received: from eggs.gnu.org ([2001:4830:134:3::10]:44558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcunm-0005Lf-6E
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcunl-0001lI-7g
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:42 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 10 Jul 2018 17:42:58 +0200
Message-Id: <20180710154304.18304-19-kwolf@redhat.com>
In-Reply-To: <20180710154304.18304-1-kwolf@redhat.com>
References: <20180710154304.18304-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 18/24] block: Use uint64_t for
 BdrvTrackedRequest byte fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

This matches the types used for bytes in the rest parts of block layer.
In the case of bdrv_co_truncate, new_bytes can be the image size which
probably doesn't fit in a 32 bit int.

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h | 4 ++--
 block/io.c                | 8 +++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 920d3d122b..903b9c1034 100644
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
diff --git a/block/io.c b/block/io.c
index fbcd93304b..6293612e73 100644
--- a/block/io.c
+++ b/block/io.c
@@ -601,9 +601,11 @@ static void tracked_request_end(BdrvTrackedRequest *req)
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
@@ -625,7 +627,7 @@ static void tracked_request_begin(BdrvTrackedRequest *req,
 static void mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
 {
     int64_t overlap_offset = req->offset & ~(align - 1);
-    unsigned int overlap_bytes = ROUND_UP(req->offset + req->bytes, align)
+    uint64_t overlap_bytes = ROUND_UP(req->offset + req->bytes, align)
                                - overlap_offset;
 
     if (!req->serialising) {
@@ -683,7 +685,7 @@ static int bdrv_get_cluster_size(BlockDriverState *bs)
 }
 
 static bool tracked_request_overlaps(BdrvTrackedRequest *req,
-                                     int64_t offset, unsigned int bytes)
+                                     int64_t offset, uint64_t bytes)
 {
     /*        aaaa   bbbb */
     if (offset >= req->overlap_offset + req->overlap_bytes) {
-- 
2.13.6
