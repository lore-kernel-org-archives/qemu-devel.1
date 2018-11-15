Received: from eggs.gnu.org ([2001:4830:134:3::10]:53505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN70e-0002CR-AV
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 21:03:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN70c-0005d5-7J
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 21:03:56 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed, 14 Nov 2018 20:03:23 -0600
Message-Id: <20181115020334.1189829-3-eblake@redhat.com>
In-Reply-To: <20181115020334.1189829-1-eblake@redhat.com>
References: <20181115020334.1189829-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 02/13] vdi: Switch to byte-based calls
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
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/vdi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index 2380daa583e..b5d699f62c2 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -377,7 +377,7 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,

     logout("\n");

-    ret = bdrv_read(bs->file, 0, (uint8_t *)&header, 1);
+    ret = bdrv_pread(bs->file, 0, &header, sizeof(header));
     if (ret < 0) {
         goto fail;
     }
@@ -467,15 +467,14 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
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
@@ -694,7 +693,7 @@ nonallocating_write:
         assert(VDI_IS_ALLOCATED(bmap_first));
         *header = s->header;
         vdi_header_to_le(header);
-        ret = bdrv_write(bs->file, 0, block, 1);
+        ret = bdrv_pwrite(bs->file, 0, block, SECTOR_SIZE);
         g_free(block);
         block = NULL;

@@ -712,7 +711,8 @@ nonallocating_write:
         base = ((uint8_t *)&s->bmap[0]) + bmap_first * SECTOR_SIZE;
         logout("will write %u block map sectors starting from entry %u\n",
                n_sectors, bmap_first);
-        ret = bdrv_write(bs->file, offset, base, n_sectors);
+        ret = bdrv_pwrite(bs->file, offset * SECTOR_SIZE, base,
+                          n_sectors * SECTOR_SIZE);
     }

     return ret;
-- 
2.17.2
