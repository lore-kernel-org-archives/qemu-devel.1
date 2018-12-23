Received: from eggs.gnu.org ([2001:4830:134:3::10]:44359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <npes87184@gmail.com>) id 1gau0x-00050g-MV
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 22:01:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <npes87184@gmail.com>) id 1gau0w-0005kj-Km
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 22:01:15 -0500
From: yuchenlin <npes87184@gmail.com>
Date: Sun, 23 Dec 2018 10:59:39 +0800
Message-Id: <20181223025939.15775-4-npes87184@gmail.com>
In-Reply-To: <20181223025939.15775-1-npes87184@gmail.com>
References: <20181223025939.15775-1-npes87184@gmail.com>
Subject: [Qemu-devel] [PATCH v2 3/3] dmg: don't skip zero chunk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, qemu-block@nongnu.org, yuchenlin <npes87184@gmail.com>

The dmg file has many tables which describe: "start from sector XXX to
sector XXX, the compression method is XXX and where the compressed data
resides on".

Each sector in the expanded file should be covered by a table. The table
will describe the offset of compressed data (or raw depends on the type)
in the dmg.

For example:

[-----------The expanded file------------]
[---bzip table ---]/* zeros */[---zlib---]
    ^
    | if we want to read this sector.

we will find bzip table which contains this sector, and get the
compressed data offset, read it from dmg, uncompress it, finally write to
expanded file.

If we skip zero chunk (table), some sector cannot find the table which
will cause search_chunk() return s->n_chunks, dmg_read_chunk() return -1
and finally causing dmg_co_preadv() return EIO.

See:

[-----------The expanded file------------]
[---bzip table ---]/* zeros */[---zlib---]
                    ^
                    | if we want to read this sector.

Oops, we cannot find the table contains it...

In the original implementation, we don't have zero table. When we try to
read sector inside the zero chunk. We will get EIO, and skip reading.

After this patch, we treat zero chunk the same as ignore chunk, it will
directly write zero and avoid some sector may not find the table.

After this patch:

[-----------The expanded file------------]
[---bzip table ---][--zeros--][---zlib---]

Signed-off-by: yuchenlin <npes87184@gmail.com>
---
 block/dmg.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/block/dmg.c b/block/dmg.c
index 6b0a057bf8..137fe9c1ff 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -130,7 +130,8 @@ static void update_max_chunk_size(BDRVDMGState *s, uint32_t chunk,
     case UDRW: /* copy */
         uncompressed_sectors = DIV_ROUND_UP(s->lengths[chunk], 512);
         break;
-    case UDIG: /* zero */
+    case UDZE: /* zero */
+    case UDIG: /* ignore */
         /* as the all-zeroes block may be large, it is treated specially: the
          * sector is not copied from a large buffer, a simple memset is used
          * instead. Therefore uncompressed_sectors does not need to be set. */
@@ -199,8 +200,9 @@ typedef struct DmgHeaderState {
 static bool dmg_is_known_block_type(uint32_t entry_type)
 {
     switch (entry_type) {
+    case UDZE:    /* zeros */
     case UDRW:    /* uncompressed */
-    case UDIG:    /* zeroes */
+    case UDIG:    /* ignore */
     case UDZO:    /* zlib */
         return true;
     case UDBZ:    /* bzip2 */
@@ -265,9 +267,10 @@ static int dmg_read_mish_block(BDRVDMGState *s, DmgHeaderState *ds,
         /* sector count */
         s->sectorcounts[i] = buff_read_uint64(buffer, offset + 0x10);
 
-        /* all-zeroes sector (type 2) does not need to be "uncompressed" and can
-         * therefore be unbounded. */
-        if (s->types[i] != UDIG && s->sectorcounts[i] > DMG_SECTORCOUNTS_MAX) {
+        /* all-zeroes sector (type UDZE and UDIG) does not need to be
+         * "uncompressed" and can therefore be unbounded. */
+        if (s->types[i] != UDZE && s->types[i] != UDIG
+            && s->sectorcounts[i] > DMG_SECTORCOUNTS_MAX) {
             error_report("sector count %" PRIu64 " for chunk %" PRIu32
                          " is larger than max (%u)",
                          s->sectorcounts[i], i, DMG_SECTORCOUNTS_MAX);
@@ -671,7 +674,8 @@ static inline int dmg_read_chunk(BlockDriverState *bs, uint64_t sector_num)
                 return -1;
             }
             break;
-        case UDIG: /* zero */
+        case UDZE: /* zeros */
+        case UDIG: /* ignore */
             /* see dmg_read, it is treated specially. No buffer needs to be
              * pre-filled, the zeroes can be set directly. */
             break;
@@ -706,7 +710,8 @@ dmg_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
         /* Special case: current chunk is all zeroes. Do not perform a memcpy as
          * s->uncompressed_chunk may be too small to cover the large all-zeroes
          * section. dmg_read_chunk is called to find s->current_chunk */
-        if (s->types[s->current_chunk] == UDIG) { /* all zeroes block entry */
+        if (s->types[s->current_chunk] == UDZE
+            || s->types[s->current_chunk] == UDIG) { /* all zeroes block entry */
             qemu_iovec_memset(qiov, i * 512, 0, 512);
             continue;
         }
-- 
2.17.1
