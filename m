Received: from eggs.gnu.org ([209.51.188.92]:45620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLtkc-0007NY-Hj
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:14:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLtkb-0002cF-4S
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:14:38 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed,  1 May 2019 21:13:57 +0300
Message-Id: <524e211cb818a20f521d6e271e782ab62b8e5e80.1556732434.git.berto@igalia.com>
In-Reply-To: <cover.1556732434.git.berto@igalia.com>
References: <cover.1556732434.git.berto@igalia.com>
In-Reply-To: <cover.1556732434.git.berto@igalia.com>
References: <cover.1556732434.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 3/5] vvfat: Replace bdrv_{read,
 write}() with bdrv_{pread, pwrite}()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

There's only a couple of bdrv_read() and bdrv_write() calls left in
the vvfat code, and they can be trivially replaced with the byte-based
bdrv_pread() and bdrv_pwrite().

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/vvfat.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 5f66787890..253cc716dd 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1494,8 +1494,8 @@ static int vvfat_read(BlockDriverState *bs, int64_t sector_num,
                 DLOG(fprintf(stderr, "sectors %" PRId64 "+%" PRId64
                              " allocated\n", sector_num,
                              n >> BDRV_SECTOR_BITS));
-                if (bdrv_read(s->qcow, sector_num, buf + i * 0x200,
-                              n >> BDRV_SECTOR_BITS)) {
+                if (bdrv_pread(s->qcow, sector_num * BDRV_SECTOR_SIZE,
+                               buf + i * 0x200, n) < 0) {
                     return -1;
                 }
                 i += (n >> BDRV_SECTOR_BITS) - 1;
@@ -1983,8 +1983,9 @@ static uint32_t get_cluster_count_for_direntry(BDRVVVFATState* s,
                         if (res) {
                             return -1;
                         }
-                        res = bdrv_write(s->qcow, offset, s->cluster_buffer, 1);
-                        if (res) {
+                        res = bdrv_pwrite(s->qcow, offset * BDRV_SECTOR_SIZE,
+                                          s->cluster_buffer, BDRV_SECTOR_SIZE);
+                        if (res < 0) {
                             return -2;
                         }
                     }
@@ -3050,7 +3051,8 @@ DLOG(checkpoint());
      * Use qcow backend. Commit later.
      */
 DLOG(fprintf(stderr, "Write to qcow backend: %d + %d\n", (int)sector_num, nb_sectors));
-    ret = bdrv_write(s->qcow, sector_num, buf, nb_sectors);
+    ret = bdrv_pwrite(s->qcow, sector_num * BDRV_SECTOR_SIZE, buf,
+                      nb_sectors * BDRV_SECTOR_SIZE);
     if (ret < 0) {
         fprintf(stderr, "Error writing to qcow backend\n");
         return ret;
-- 
2.11.0
