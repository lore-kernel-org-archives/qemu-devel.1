Received: from eggs.gnu.org ([2001:4830:134:3::10]:52731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d36cV-0007Em-9x
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:59:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d36cU-00045W-DL
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:59:31 -0400
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Wed, 26 Apr 2017 01:29:10 +0530
Message-Id: <1493150351-28918-8-git-send-email-ashijeetacharya@gmail.com>
In-Reply-To: <1493150351-28918-1-git-send-email-ashijeetacharya@gmail.com>
References: <1493150351-28918-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v1 7/8] dmg: Refactor dmg_co_preadv() to start
 reading multiple sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com
Cc: kwolf@redhat.com, jsnow@redhat.com, mreitz@redhat.com, famz@redhat.com, peter@lekensteyn.nl, qemu-devel@nongnu.org, qemu-block@nongnu.org, Ashijeet Acharya <ashijeetacharya@gmail.com>

At the moment, dmg_co_preadv() reads one sector at a time. Make it
read multiple sectors at a time depending on the number of sectors
stored in "drs->sectors_read". This does not provide any significant
optimization in the I/O process of DMG but is still a nicer way.

Adjust the 'data' variable depending on our cached access point
situation to align our read requests appropriately.

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
---
 block/dmg.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/block/dmg.c b/block/dmg.c
index f643e41..b0f3c84 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -718,7 +718,7 @@ dmg_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     BDRVDMGState *s = bs->opaque;
     uint64_t sector_num = offset >> BDRV_SECTOR_BITS;
     int nb_sectors = bytes >> BDRV_SECTOR_BITS;
-    int ret, i;
+    int ret, i = 0;
     DMGReadState *drs = s->drs;
 
     assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
@@ -726,8 +726,7 @@ dmg_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
 
     qemu_co_mutex_lock(&s->lock);
 
-    for (i = 0; i < nb_sectors; i++) {
-        uint32_t sector_offset_in_chunk;
+    while (i < nb_sectors) {
         void *data;
 
         if (dmg_read_chunk(bs, sector_num + i, drs) != 0) {
@@ -738,12 +737,20 @@ dmg_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
          * s->uncompressed_chunk may be too small to cover the large all-zeroes
          * section. dmg_read_chunk is called to find s->current_chunk */
         if (s->types[s->current_chunk] == 2) { /* all zeroes block entry */
-            qemu_iovec_memset(qiov, i * 512, 0, 512);
-            continue;
+            qemu_iovec_memset(qiov, i * 512, 0,
+                                    512 * drs->sectors_read);
+            goto increment;
+        }
+
+        if (drs->saved_next_in == NULL) {
+            data = s->uncompressed_chunk + drs->sector_offset_in_chunk * 512;
+        } else {
+            data = s->uncompressed_chunk;
         }
-        sector_offset_in_chunk = sector_num + i - s->sectors[s->current_chunk];
-        data = s->uncompressed_chunk + sector_offset_in_chunk * 512;
-        qemu_iovec_from_buf(qiov, i * 512, data, 512);
+        qemu_iovec_from_buf(qiov, i * 512, data, drs->sectors_read * 512);
+
+increment:
+        i += drs->sectors_read;
     }
 
     ret = 0;
-- 
2.6.2
