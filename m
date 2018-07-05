Received: from eggs.gnu.org ([2001:4830:134:3::10]:53279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1faype-0001YF-GW
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 03:37:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1faypd-0000ei-Kd
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 03:37:38 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu,  5 Jul 2018 15:36:55 +0800
Message-Id: <20180705073701.10558-4-famz@redhat.com>
In-Reply-To: <20180705073701.10558-1-famz@redhat.com>
References: <20180705073701.10558-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/9] block: Use uint64_t for
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
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This matches the types used for bytes in the rest parts of block layer.
In the case of bdrv_co_truncate, new_bytes can be the image size which
probably doesn't fit in a 32 bit int.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/io.c                | 2 +-
 include/block/block_int.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/io.c b/block/io.c
index 3e00667a2a..443a8584c4 100644
--- a/block/io.c
+++ b/block/io.c
@@ -587,7 +587,7 @@ static void tracked_request_end(BdrvTrackedRequest *req)
 static void tracked_request_begin(BdrvTrackedRequest *req,
                                   BlockDriverState *bs,
                                   int64_t offset,
-                                  unsigned int bytes,
+                                  uint64_t bytes,
                                   enum BdrvTrackedRequestType type)
 {
     *req = (BdrvTrackedRequest){
diff --git a/include/block/block_int.h b/include/block/block_int.h
index af71b414be..66c0e50d82 100644
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
