Received: from eggs.gnu.org ([209.51.188.92]:56762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLBF1-0003Hc-Om
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLBF0-0002Qa-QX
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:43:03 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Mon, 29 Apr 2019 20:42:37 +0200
Message-Id: <e5e1571c583874454760dc738ef3ea3470ea96e7.1556562150.git.berto@igalia.com>
In-Reply-To: <cover.1556562150.git.berto@igalia.com>
References: <cover.1556562150.git.berto@igalia.com>
In-Reply-To: <cover.1556562150.git.berto@igalia.com>
References: <cover.1556562150.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 2/5] vdi: Replace bdrv_{read,
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
the vdi code, and they can be trivially replaced with the byte-based
bdrv_pread() and bdrv_pwrite().

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/vdi.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index e1c42ad732..8d849b2754 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -384,7 +384,7 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
 
     logout("\n");
 
-    ret = bdrv_read(bs->file, 0, (uint8_t *)&header, 1);
+    ret = bdrv_pread(bs->file, 0, (uint8_t *)&header, sizeof(header));
     if (ret < 0) {
         goto fail;
     }
@@ -484,8 +484,8 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
-    ret = bdrv_read(bs->file, s->bmap_sector, (uint8_t *)s->bmap,
-                    bmap_size);
+    ret = bdrv_pread(bs->file, header.offset_bmap, (uint8_t *)s->bmap,
+                     bmap_size * SECTOR_SIZE);
     if (ret < 0) {
         goto fail_free_bmap;
     }
@@ -704,7 +704,7 @@ nonallocating_write:
         assert(VDI_IS_ALLOCATED(bmap_first));
         *header = s->header;
         vdi_header_to_le(header);
-        ret = bdrv_write(bs->file, 0, block, 1);
+        ret = bdrv_pwrite(bs->file, 0, block, sizeof(*block));
         g_free(block);
         block = NULL;
 
@@ -722,7 +722,8 @@ nonallocating_write:
         base = ((uint8_t *)&s->bmap[0]) + bmap_first * SECTOR_SIZE;
         logout("will write %u block map sectors starting from entry %u\n",
                n_sectors, bmap_first);
-        ret = bdrv_write(bs->file, offset, base, n_sectors);
+        ret = bdrv_pwrite(bs->file, offset * SECTOR_SIZE, base,
+                          n_sectors * SECTOR_SIZE);
     }
 
     return ret;
-- 
2.11.0
