Received: from eggs.gnu.org ([2001:4830:134:3::10]:46007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4YT-0002My-Nw
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4YP-0000qi-Nf
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:01 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:26:58 +0100
Message-Id: <20181212132735.16080-5-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/41] dmg: exchanging hardcoded dmg UDIF block
 types to enum.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Julio Faracco <jcfaracco@gmail.com>

This change is better to understand what kind of block type is being
handled by the code. Using a syntax similar to the DMG documentation is
easier than tracking all hex values assigned to a block type.

Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/dmg.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/block/dmg.c b/block/dmg.c
index 86bb2344ea..50e91aef6d 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -44,6 +44,19 @@ enum {
     DMG_SECTORCOUNTS_MAX =3D DMG_LENGTHS_MAX / 512,
 };
=20
+enum {
+    /* DMG Block Type */
+    UDZE =3D 0, /* Zeroes */
+    UDRW,     /* RAW type */
+    UDIG,     /* Ignore */
+    UDCO =3D 0x80000004,
+    UDZO,
+    UDBZ,
+    ULFO,
+    UDCM =3D 0x7ffffffe, /* Comments */
+    UDLE               /* Last Entry */
+};
+
 static int dmg_probe(const uint8_t *buf, int buf_size, const char *filen=
ame)
 {
     int len;
@@ -108,16 +121,16 @@ static void update_max_chunk_size(BDRVDMGState *s, =
uint32_t chunk,
     uint32_t uncompressed_sectors =3D 0;
=20
     switch (s->types[chunk]) {
-    case 0x80000005: /* zlib compressed */
-    case 0x80000006: /* bzip2 compressed */
-    case 0x80000007: /* lzfse compressed */
+    case UDZO: /* zlib compressed */
+    case UDBZ: /* bzip2 compressed */
+    case ULFO: /* lzfse compressed */
         compressed_size =3D s->lengths[chunk];
         uncompressed_sectors =3D s->sectorcounts[chunk];
         break;
-    case 1: /* copy */
+    case UDRW: /* copy */
         uncompressed_sectors =3D DIV_ROUND_UP(s->lengths[chunk], 512);
         break;
-    case 2: /* zero */
+    case UDIG: /* zero */
         /* as the all-zeroes block may be large, it is treated specially=
: the
          * sector is not copied from a large buffer, a simple memset is =
used
          * instead. Therefore uncompressed_sectors does not need to be s=
et. */
@@ -186,13 +199,13 @@ typedef struct DmgHeaderState {
 static bool dmg_is_known_block_type(uint32_t entry_type)
 {
     switch (entry_type) {
-    case 0x00000001:    /* uncompressed */
-    case 0x00000002:    /* zeroes */
-    case 0x80000005:    /* zlib */
+    case UDRW:    /* uncompressed */
+    case UDIG:    /* zeroes */
+    case UDZO:    /* zlib */
         return true;
-    case 0x80000006:    /* bzip2 */
+    case UDBZ:    /* bzip2 */
         return !!dmg_uncompress_bz2;
-    case 0x80000007:    /* lzfse */
+    case ULFO:    /* lzfse */
         return !!dmg_uncompress_lzfse;
     default:
         return false;
@@ -586,7 +599,7 @@ static inline int dmg_read_chunk(BlockDriverState *bs=
, uint64_t sector_num)
=20
         s->current_chunk =3D s->n_chunks;
         switch (s->types[chunk]) { /* block entry type */
-        case 0x80000005: { /* zlib compressed */
+        case UDZO: { /* zlib compressed */
             /* we need to buffer, because only the chunk as whole can be
              * inflated. */
             ret =3D bdrv_pread(bs->file, s->offsets[chunk],
@@ -609,7 +622,7 @@ static inline int dmg_read_chunk(BlockDriverState *bs=
, uint64_t sector_num)
                 return -1;
             }
             break; }
-        case 0x80000006: /* bzip2 compressed */
+        case UDBZ: /* bzip2 compressed */
             if (!dmg_uncompress_bz2) {
                 break;
             }
@@ -630,7 +643,7 @@ static inline int dmg_read_chunk(BlockDriverState *bs=
, uint64_t sector_num)
                 return ret;
             }
             break;
-        case 0x80000007:
+        case ULFO:
             if (!dmg_uncompress_lzfse) {
                 break;
             }
@@ -651,14 +664,14 @@ static inline int dmg_read_chunk(BlockDriverState *=
bs, uint64_t sector_num)
                 return ret;
             }
             break;
-        case 1: /* copy */
+        case UDRW: /* copy */
             ret =3D bdrv_pread(bs->file, s->offsets[chunk],
                              s->uncompressed_chunk, s->lengths[chunk]);
             if (ret !=3D s->lengths[chunk]) {
                 return -1;
             }
             break;
-        case 2: /* zero */
+        case UDIG: /* zero */
             /* see dmg_read, it is treated specially. No buffer needs to=
 be
              * pre-filled, the zeroes can be set directly. */
             break;
--=20
2.19.2
