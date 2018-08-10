Received: from eggs.gnu.org ([2001:4830:134:3::10]:55765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcfaracco@gmail.com>) id 1fnyir-0000u0-B0
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 00:08:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcfaracco@gmail.com>) id 1fnyiq-0002iN-Cn
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 00:08:21 -0400
From: Julio Faracco <jcfaracco@gmail.com>
Date: Fri, 10 Aug 2018 01:07:42 -0300
Message-Id: <20180810040743.25424-4-jcfaracco@gmail.com>
In-Reply-To: <20180810040743.25424-1-jcfaracco@gmail.com>
References: <20180810040743.25424-1-jcfaracco@gmail.com>
Subject: [Qemu-devel] [PATCH 3/4] dmg: including dmg-lzfse module inside dmg
 block driver.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

This commit includes the support to new module dmg-lzfse into dmg block
driver. It includes the support for block type ULFO (0x80000007).

Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
---
 block/dmg.c | 28 ++++++++++++++++++++++++++++
 block/dmg.h |  3 +++
 2 files changed, 31 insertions(+)

diff --git a/block/dmg.c b/block/dmg.c
index c9b3c519c4..390ab67e53 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -33,6 +33,9 @@
 int (*dmg_uncompress_bz2)(char *next_in, unsigned int avail_in,
                           char *next_out, unsigned int avail_out);
 
+int (*dmg_uncompress_lzfse)(char *next_in, unsigned int avail_in,
+                            char *next_out, unsigned int avail_out);
+
 enum {
     /* Limit chunk sizes to prevent unreasonable amounts of memory being used
      * or truncating when converting to 32-bit types
@@ -107,6 +110,7 @@ static void update_max_chunk_size(BDRVDMGState *s, uint32_t chunk,
     switch (s->types[chunk]) {
     case 0x80000005: /* zlib compressed */
     case 0x80000006: /* bzip2 compressed */
+    case 0x80000007: /* lzfse compressed */
         compressed_size = s->lengths[chunk];
         uncompressed_sectors = s->sectorcounts[chunk];
         break;
@@ -188,6 +192,8 @@ static bool dmg_is_known_block_type(uint32_t entry_type)
         return true;
     case 0x80000006:    /* bzip2 */
         return !!dmg_uncompress_bz2;
+    case 0x80000007:    /* lzfse */
+	return !!dmg_uncompress_lzfse;
     default:
         return false;
     }
@@ -431,6 +437,7 @@ static int dmg_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     block_module_load_one("dmg-bz2");
+    block_module_load_one("dmg-lzfse");
 
     s->n_chunks = 0;
     s->offsets = s->lengths = s->sectors = s->sectorcounts = NULL;
@@ -629,6 +636,27 @@ static inline int dmg_read_chunk(BlockDriverState *bs, uint64_t sector_num)
                 return ret;
             }
             break;
+	case 0x80000007:
+	    if (!dmg_uncompress_lzfse) {
+                break;
+            }
+            /* we need to buffer, because only the chunk as whole can be
+             * inflated. */
+            ret = bdrv_pread(bs->file, s->offsets[chunk],
+                             s->compressed_chunk, s->lengths[chunk]);
+            if (ret != s->lengths[chunk]) {
+                return -1;
+            }
+
+            ret = dmg_uncompress_lzfse((char *)s->compressed_chunk,
+                                       (unsigned int) s->lengths[chunk],
+                                       (char *)s->uncompressed_chunk,
+                                       (unsigned int)
+                                           (512 * s->sectorcounts[chunk]));
+            if (ret < 0) {
+                return ret;
+            }
+            break;
         case 1: /* copy */
             ret = bdrv_pread(bs->file, s->offsets[chunk],
                              s->uncompressed_chunk, s->lengths[chunk]);
diff --git a/block/dmg.h b/block/dmg.h
index 2ecf239ba5..f28929998f 100644
--- a/block/dmg.h
+++ b/block/dmg.h
@@ -55,4 +55,7 @@ typedef struct BDRVDMGState {
 extern int (*dmg_uncompress_bz2)(char *next_in, unsigned int avail_in,
                                  char *next_out, unsigned int avail_out);
 
+extern int (*dmg_uncompress_lzfse)(char *next_in, unsigned int avail_in,
+                                   char *next_out, unsigned int avail_out);
+
 #endif
-- 
2.17.1
