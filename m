Received: from eggs.gnu.org ([2001:4830:134:3::10]:56430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d3eRP-0003Kb-1S
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d3eRN-0008Ih-Bd
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:06:19 -0400
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Thu, 27 Apr 2017 13:36:33 +0530
Message-Id: <1493280397-9622-4-git-send-email-ashijeetacharya@gmail.com>
In-Reply-To: <1493280397-9622-1-git-send-email-ashijeetacharya@gmail.com>
References: <1493280397-9622-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v2 3/7] dmg: Refactor and prepare
 dmg_read_chunk() to cache random access points
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

Refactor dmg_read_chunk() to start making use of the new DMGReadState
structure and do chunk and sector related calculations based on it.
Add a new argument "DMGReadState *drs" to it.

Also, rename DMG_SECTORCOUNTS_MAX to DMG_SECTOR_MAX to avoid indentaion
problems at some places inside dmg_read_chunk()

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
---
 block/dmg.c | 159 +++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 94 insertions(+), 65 deletions(-)

diff --git a/block/dmg.c b/block/dmg.c
index c6fe8b0..32623e2 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -38,7 +38,7 @@ enum {
      * or truncating when converting to 32-bit types
      */
     DMG_LENGTHS_MAX = 64 * 1024 * 1024, /* 64 MB */
-    DMG_SECTORCOUNTS_MAX = DMG_LENGTHS_MAX / 512,
+    DMG_SECTOR_MAX = DMG_LENGTHS_MAX / 512,
 };
 
 static int dmg_probe(const uint8_t *buf, int buf_size, const char *filename)
@@ -260,10 +260,10 @@ static int dmg_read_mish_block(BDRVDMGState *s, DmgHeaderState *ds,
 
         /* all-zeroes sector (type 2) does not need to be "uncompressed" and can
          * therefore be unbounded. */
-        if (s->types[i] != 2 && s->sectorcounts[i] > DMG_SECTORCOUNTS_MAX) {
+        if (s->types[i] != 2 && s->sectorcounts[i] > DMG_SECTOR_MAX) {
             error_report("sector count %" PRIu64 " for chunk %" PRIu32
                          " is larger than max (%u)",
-                         s->sectorcounts[i], i, DMG_SECTORCOUNTS_MAX);
+                         s->sectorcounts[i], i, DMG_SECTOR_MAX);
             ret = -EINVAL;
             goto fail;
         }
@@ -578,78 +578,106 @@ static inline uint32_t search_chunk(BDRVDMGState *s, uint64_t sector_num)
     return s->n_chunks; /* error */
 }
 
-static inline int dmg_read_chunk(BlockDriverState *bs, uint64_t sector_num)
+static inline int dmg_read_chunk(BlockDriverState *bs, uint64_t sector_num,
+                                 DMGReadState *drs)
 {
     BDRVDMGState *s = bs->opaque;
 
+    int ret;
+    uint32_t sector_offset;
+    uint64_t sectors_read;
+    uint32_t chunk;
+
     if (!is_sector_in_chunk(s, s->current_chunk, sector_num)) {
-        int ret;
-        uint32_t chunk = search_chunk(s, sector_num);
+        chunk = search_chunk(s, sector_num);
+    } else {
+        chunk = drs->saved_chunk_type;
+    }
 
-        if (chunk >= s->n_chunks) {
+    if (chunk >= s->n_chunks) {
+            return -1;
+    }
+
+    /* reset our access point cache if we had a change in current chunk */
+    if (chunk != drs->saved_chunk_type) {
+        cache_access_point(drs, NULL, -1, -1, -1, -1);
+    }
+
+    sector_offset = sector_num - s->sectors[chunk];
+
+    if ((s->sectorcounts[chunk] - sector_offset) > DMG_SECTOR_MAX) {
+        sectors_read = DMG_SECTOR_MAX;
+    } else {
+        sectors_read = s->sectorcounts[chunk] - sector_offset;
+    }
+
+    /* truncate sectors read if it exceeds the 2MB buffer of qemu-img
+     * convert */
+    if ((sector_num % DMG_SECTOR_MAX) + sectors_read > DMG_SECTOR_MAX) {
+        sectors_read = DMG_SECTOR_MAX - (sector_num % DMG_SECTOR_MAX);
+    }
+
+    s->current_chunk = s->n_chunks;
+
+    switch (s->types[chunk]) { /* block entry type */
+    case 0x80000005: { /* zlib compressed */
+        /* we need to buffer, because only the chunk as whole can be
+         * inflated. */
+        ret = bdrv_pread(bs->file, s->offsets[chunk],
+                         s->compressed_chunk, s->lengths[chunk]);
+        if (ret != s->lengths[chunk]) {
             return -1;
         }
 
-        s->current_chunk = s->n_chunks;
-        switch (s->types[chunk]) { /* block entry type */
-        case 0x80000005: { /* zlib compressed */
-            /* we need to buffer, because only the chunk as whole can be
-             * inflated. */
-            ret = bdrv_pread(bs->file, s->offsets[chunk],
-                             s->compressed_chunk, s->lengths[chunk]);
-            if (ret != s->lengths[chunk]) {
-                return -1;
-            }
-
-            s->zstream.next_in = s->compressed_chunk;
-            s->zstream.avail_in = s->lengths[chunk];
-            s->zstream.next_out = s->uncompressed_chunk;
-            s->zstream.avail_out = 512 * s->sectorcounts[chunk];
-            ret = inflateReset(&s->zstream);
-            if (ret != Z_OK) {
-                return -1;
-            }
-            ret = inflate(&s->zstream, Z_FINISH);
-            if (ret != Z_STREAM_END ||
-                s->zstream.total_out != 512 * s->sectorcounts[chunk]) {
-                return -1;
-            }
-            break; }
-        case 0x80000006: /* bzip2 compressed */
-            if (!dmg_uncompress_bz2) {
-                break;
-            }
-            /* we need to buffer, because only the chunk as whole can be
-             * inflated. */
-            ret = bdrv_pread(bs->file, s->offsets[chunk],
-                             s->compressed_chunk, s->lengths[chunk]);
-            if (ret != s->lengths[chunk]) {
-                return -1;
-            }
-
-            ret = dmg_uncompress_bz2((char *)s->compressed_chunk,
-                                     (unsigned int) s->lengths[chunk],
-                                     (char *)s->uncompressed_chunk,
-                                     (unsigned int)
-                                         (512 * s->sectorcounts[chunk]));
-            if (ret < 0) {
-                return ret;
-            }
-            break;
-        case 1: /* copy */
-            ret = bdrv_pread(bs->file, s->offsets[chunk],
-                             s->uncompressed_chunk, s->lengths[chunk]);
-            if (ret != s->lengths[chunk]) {
-                return -1;
-            }
-            break;
-        case 2: /* zero */
-            /* see dmg_read, it is treated specially. No buffer needs to be
-             * pre-filled, the zeroes can be set directly. */
+        s->zstream.next_in = s->compressed_chunk;
+        s->zstream.avail_in = s->lengths[chunk];
+        s->zstream.next_out = s->uncompressed_chunk;
+        s->zstream.avail_out = 512 * s->sectorcounts[chunk];
+        ret = inflateReset(&s->zstream);
+        if (ret != Z_OK) {
+            return -1;
+        }
+        ret = inflate(&s->zstream, Z_FINISH);
+        if (ret != Z_STREAM_END ||
+            s->zstream.total_out != 512 * s->sectorcounts[chunk]) {
+            return -1;
+        }
+        break; }
+    case 0x80000006: /* bzip2 compressed */
+        if (!dmg_uncompress_bz2) {
             break;
         }
-        s->current_chunk = chunk;
+        /* we need to buffer, because only the chunk as whole can be
+         * inflated. */
+        ret = bdrv_pread(bs->file, s->offsets[chunk],
+                         s->compressed_chunk, s->lengths[chunk]);
+        if (ret != s->lengths[chunk]) {
+            return -1;
+        }
+
+        ret = dmg_uncompress_bz2((char *)s->compressed_chunk,
+                                 (unsigned int) s->lengths[chunk],
+                                 (char *)s->uncompressed_chunk,
+                                 (unsigned int)
+                                    (512 * s->sectorcounts[chunk]));
+        if (ret < 0) {
+            return ret;
+        }
+        break;
+    case 1: /* copy */
+        ret = bdrv_pread(bs->file, s->offsets[chunk],
+                         s->uncompressed_chunk, s->lengths[chunk]);
+        if (ret != s->lengths[chunk]) {
+            return -1;
+        }
+        break;
+    case 2: /* zero */
+        /* see dmg_read, it is treated specially. No buffer needs to be
+         * pre-filled, the zeroes can be set directly. */
+        break;
     }
+    s->current_chunk = chunk;
+
     return 0;
 }
 
@@ -661,6 +689,7 @@ dmg_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     uint64_t sector_num = offset >> BDRV_SECTOR_BITS;
     int nb_sectors = bytes >> BDRV_SECTOR_BITS;
     int ret, i;
+    DMGReadState *drs = s->drs;
 
     assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
     assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
@@ -671,7 +700,7 @@ dmg_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
         uint32_t sector_offset_in_chunk;
         void *data;
 
-        if (dmg_read_chunk(bs, sector_num + i) != 0) {
+        if (dmg_read_chunk(bs, sector_num + i, drs) != 0) {
             ret = -EIO;
             goto fail;
         }
-- 
2.6.2
