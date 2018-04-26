Received: from eggs.gnu.org ([2001:4830:134:3::10]:51010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBhBB-0005M4-QA
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:43:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBhBB-0003mt-0Q
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:43:21 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 26 Apr 2018 08:43:03 -0500
Message-Id: <20180426134305.642080-2-eblake@redhat.com>
In-Reply-To: <20180426134305.642080-1-eblake@redhat.com>
References: <20180426134305.642080-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] vdi: Switch to byte-based calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Make the change for the last few sector-based calls
into the block layer from the vdi driver.

Ideally, the vdi driver should switch to doing everything
byte-based, but that's a more invasive change that requires a
bit more auditing.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/vdi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index 4a2d1ff88d4..fd745982caf 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -379,7 +379,7 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,

     logout("\n");

-    ret = bdrv_read(bs->file, 0, (uint8_t *)&header, 1);
+    ret = bdrv_pread(bs->file, 0, &header, sizeof(header));
     if (ret < 0) {
         goto fail;
     }
@@ -468,15 +468,14 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
     s->header = header;

     bmap_size = header.blocks_in_image * sizeof(uint32_t);
-    bmap_size = DIV_ROUND_UP(bmap_size, SECTOR_SIZE);
-    s->bmap = qemu_try_blockalign(bs->file->bs, bmap_size * SECTOR_SIZE);
+    s->bmap = qemu_try_blockalign(bs->file->bs, bmap_size);
     if (s->bmap == NULL) {
         ret = -ENOMEM;
         goto fail;
     }

-    ret = bdrv_read(bs->file, s->bmap_sector, (uint8_t *)s->bmap,
-                    bmap_size);
+    ret = bdrv_pread(bs->file, s->bmap_sector * SECTOR_SIZE, s->bmap,
+                     bmap_size);
     if (ret < 0) {
         goto fail_free_bmap;
     }
@@ -695,7 +694,7 @@ nonallocating_write:
         assert(VDI_IS_ALLOCATED(bmap_first));
         *header = s->header;
         vdi_header_to_le(header);
-        ret = bdrv_write(bs->file, 0, block, 1);
+        ret = bdrv_pwrite(bs->file, 0, block, SECTOR_SIZE);
         g_free(block);
         block = NULL;

@@ -713,7 +712,8 @@ nonallocating_write:
         base = ((uint8_t *)&s->bmap[0]) + bmap_first * SECTOR_SIZE;
         logout("will write %u block map sectors starting from entry %u\n",
                n_sectors, bmap_first);
-        ret = bdrv_write(bs->file, offset, base, n_sectors);
+        ret = bdrv_pwrite(bs->file, offset * SECTOR_SIZE, base,
+                          n_sectors * SECTOR_SIZE);
     }

     return ret;
-- 
2.14.3
