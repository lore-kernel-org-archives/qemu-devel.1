Received: from eggs.gnu.org ([209.51.188.92]:45611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLtkc-0007NH-4u
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:14:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLtkb-0002cK-4k
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:14:38 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed,  1 May 2019 21:13:56 +0300
Message-Id: <f64d9b6b1bc90d45c9be5aae63176b34879182c2.1556732434.git.berto@igalia.com>
In-Reply-To: <cover.1556732434.git.berto@igalia.com>
References: <cover.1556732434.git.berto@igalia.com>
In-Reply-To: <cover.1556732434.git.berto@igalia.com>
References: <cover.1556732434.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 2/5] vdi: Replace bdrv_{read,
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
 block/vdi.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index e1c42ad732..9caeb50dd1 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -171,6 +171,8 @@ typedef struct {
     uint64_t unused2[7];
 } QEMU_PACKED VdiHeader;
 
+QEMU_BUILD_BUG_ON(sizeof(VdiHeader) != 512);
+
 typedef struct {
     /* The block map entries are little endian (even in memory). */
     uint32_t *bmap;
@@ -384,7 +386,7 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
 
     logout("\n");
 
-    ret = bdrv_read(bs->file, 0, (uint8_t *)&header, 1);
+    ret = bdrv_pread(bs->file, 0, (uint8_t *)&header, sizeof(header));
     if (ret < 0) {
         goto fail;
     }
@@ -484,8 +486,8 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
-    ret = bdrv_read(bs->file, s->bmap_sector, (uint8_t *)s->bmap,
-                    bmap_size);
+    ret = bdrv_pread(bs->file, header.offset_bmap, (uint8_t *)s->bmap,
+                     bmap_size * SECTOR_SIZE);
     if (ret < 0) {
         goto fail_free_bmap;
     }
@@ -704,7 +706,7 @@ nonallocating_write:
         assert(VDI_IS_ALLOCATED(bmap_first));
         *header = s->header;
         vdi_header_to_le(header);
-        ret = bdrv_write(bs->file, 0, block, 1);
+        ret = bdrv_pwrite(bs->file, 0, block, sizeof(VdiHeader));
         g_free(block);
         block = NULL;
 
@@ -722,10 +724,11 @@ nonallocating_write:
         base = ((uint8_t *)&s->bmap[0]) + bmap_first * SECTOR_SIZE;
         logout("will write %u block map sectors starting from entry %u\n",
                n_sectors, bmap_first);
-        ret = bdrv_write(bs->file, offset, base, n_sectors);
+        ret = bdrv_pwrite(bs->file, offset * SECTOR_SIZE, base,
+                          n_sectors * SECTOR_SIZE);
     }
 
-    return ret;
+    return ret < 0 ? ret : 0;
 }
 
 static int coroutine_fn vdi_co_do_create(BlockdevCreateOptions *create_options,
-- 
2.11.0
