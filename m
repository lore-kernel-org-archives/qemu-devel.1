Received: from eggs.gnu.org ([2001:4830:134:3::10]:59326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e80T3-0003vh-1h
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 04:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e80T2-0001hk-BI
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 04:58:17 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Fri, 27 Oct 2017 04:57:54 -0400
Message-Id: <c65b4384161f471c489966d5a98261b7971bce8c.1509094209.git.jcody@redhat.com>
In-Reply-To: <cover.1509094209.git.jcody@redhat.com>
References: <cover.1509094209.git.jcody@redhat.com>
In-Reply-To: <cover.1509094209.git.jcody@redhat.com>
References: <cover.1509094209.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] block/parallels: code movement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, aik@ozlabs.ru, mreitz@redhat.com, den@openvz.org, stefanha@redhat.com

Code movement, to make subsequent patches simpler.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/parallels.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 2b6c6e5709..fed199eccd 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -159,6 +159,18 @@ static int cluster_remainder(BDRVParallelsState *s, int64_t sector_num,
     return MIN(nb_sectors, ret);
 }
 
+static int parallels_update_header(BlockDriverState *bs)
+{
+    BDRVParallelsState *s = bs->opaque;
+    unsigned size = MAX(bdrv_opt_mem_align(bs->file->bs),
+                        sizeof(ParallelsHeader));
+
+    if (size > s->header_size) {
+        size = s->header_size;
+    }
+    return bdrv_pwrite_sync(bs->file, 0, s->header, size);
+}
+
 static int64_t block_status(BDRVParallelsState *s, int64_t sector_num,
                             int nb_sectors, int *pnum)
 {
@@ -575,18 +587,6 @@ static int parallels_probe(const uint8_t *buf, int buf_size,
     return 0;
 }
 
-static int parallels_update_header(BlockDriverState *bs)
-{
-    BDRVParallelsState *s = bs->opaque;
-    unsigned size = MAX(bdrv_opt_mem_align(bs->file->bs),
-                        sizeof(ParallelsHeader));
-
-    if (size > s->header_size) {
-        size = s->header_size;
-    }
-    return bdrv_pwrite_sync(bs->file, 0, s->header, size);
-}
-
 static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
                           Error **errp)
 {
-- 
2.13.6
