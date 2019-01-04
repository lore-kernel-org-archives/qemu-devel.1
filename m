Received: from eggs.gnu.org ([208.118.235.92]:51752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gfNYp-0003BV-GN
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:22:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gfNYo-0005fm-IM
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:22:43 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  4 Jan 2019 11:21:45 +0000
Message-Id: <20190104112145.12413-5-stefanha@redhat.com>
In-Reply-To: <20190104112145.12413-1-stefanha@redhat.com>
References: <20190104112145.12413-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/4] dmg: don't skip zero chunk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, yuchenlin <npes87184@gmail.com>, Julio Faracco <jcfaracco@gmail.com>

From: yuchenlin <npes87184@gmail.com>

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
Reviewed-by: Julio Faracco <jcfaracco@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190103114700.9686-4-npes87184@gmail.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/dmg.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/block/dmg.c b/block/dmg.c
index 84732a64c1..43497bf343 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -130,7 +130,8 @@ static void update_max_chunk_size(BDRVDMGState *s, ui=
nt32_t chunk,
     case UDRW: /* copy */
         uncompressed_sectors =3D DIV_ROUND_UP(s->lengths[chunk], 512);
         break;
-    case UDIG: /* zero */
+    case UDZE: /* zero */
+    case UDIG: /* ignore */
         /* as the all-zeroes block may be large, it is treated specially=
: the
          * sector is not copied from a large buffer, a simple memset is =
used
          * instead. Therefore uncompressed_sectors does not need to be s=
et. */
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
@@ -265,9 +267,10 @@ static int dmg_read_mish_block(BDRVDMGState *s, DmgH=
eaderState *ds,
         /* sector count */
         s->sectorcounts[i] =3D buff_read_uint64(buffer, offset + 0x10);
=20
-        /* all-zeroes sector (type 2) does not need to be "uncompressed"=
 and can
-         * therefore be unbounded. */
-        if (s->types[i] !=3D UDIG && s->sectorcounts[i] > DMG_SECTORCOUN=
TS_MAX) {
+        /* all-zeroes sector (type UDZE and UDIG) does not need to be
+         * "uncompressed" and can therefore be unbounded. */
+        if (s->types[i] !=3D UDZE && s->types[i] !=3D UDIG
+            && s->sectorcounts[i] > DMG_SECTORCOUNTS_MAX) {
             error_report("sector count %" PRIu64 " for chunk %" PRIu32
                          " is larger than max (%u)",
                          s->sectorcounts[i], i, DMG_SECTORCOUNTS_MAX);
@@ -675,7 +678,8 @@ static inline int dmg_read_chunk(BlockDriverState *bs=
, uint64_t sector_num)
                 return -1;
             }
             break;
-        case UDIG: /* zero */
+        case UDZE: /* zeros */
+        case UDIG: /* ignore */
             /* see dmg_read, it is treated specially. No buffer needs to=
 be
              * pre-filled, the zeroes can be set directly. */
             break;
@@ -710,7 +714,8 @@ dmg_co_preadv(BlockDriverState *bs, uint64_t offset, =
uint64_t bytes,
         /* Special case: current chunk is all zeroes. Do not perform a m=
emcpy as
          * s->uncompressed_chunk may be too small to cover the large all=
-zeroes
          * section. dmg_read_chunk is called to find s->current_chunk */
-        if (s->types[s->current_chunk] =3D=3D UDIG) { /* all zeroes bloc=
k entry */
+        if (s->types[s->current_chunk] =3D=3D UDZE
+            || s->types[s->current_chunk] =3D=3D UDIG) { /* all zeroes b=
lock entry */
             qemu_iovec_memset(qiov, i * 512, 0, 512);
             continue;
         }
--=20
2.20.1
