Received: from eggs.gnu.org ([209.51.188.92]:41835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hBWDk-0000eG-Ks
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hBWDi-0005Vz-H2
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:05:48 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue,  2 Apr 2019 22:05:24 -0500
Message-Id: <20190403030526.12258-6-eblake@redhat.com>
In-Reply-To: <20190403030526.12258-1-eblake@redhat.com>
References: <20190403030526.12258-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 5/7] block: Fix BDRV_BLOCK_RAW status to honor
 alignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Previous patches mentioned how the blkdebug filter driver demonstrates
a bug present in our NBD server; the bug is also present with the raw
format driver when probing occurs. Basically, if we specify a
particular alignment > 1, but defer the actual block status to the
underlying file, and the underlying file has a smaller alignment, then
the use of BDRV_BLOCK_RAW to defer to the underlying file can end up
with status split at an alignment unacceptable to our layer.  Many
callers don't care, but NBD does - it is a violation of the NBD
protocol to send status or read results split on an unaligned boundary
(we've taught our client to be tolerant of such violations because of
qemu 3.1; but we still need to fix our server for the sake of other
stricter clients).

This patch lays the groundwork - it adjusts bdrv_block_status to
ensure that any time one layer defers to another via BDRV_BLOCK_RAW,
the deferral is either truncated down to an aligned boundary, or
multiple sub-aligned requests are coalesced into a single
representative answer (using an implicit hole beyond EOF as
needed). Iotest 241 exposes the effect (when format probing occurred,
we don't want block status to subdivide the initial sector, and thus
not any other sector either). Similarly, iotest 221 is a good
candidate to amend to specifically track the effects; a change to a
hole at EOF is not visible if an upper layer does not want alignment
smaller than 512. However, this patch alone is not a complete fix - it
is still possible to have an active layer with large alignment
constraints backed by another layer with smaller constraints; so the
next patch will complete the task.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/io.c                 | 108 +++++++++++++++++++++++++++++++++++--
 tests/qemu-iotests/221     |  10 ++++
 tests/qemu-iotests/221.out |   6 +++
 tests/qemu-iotests/241.out |   3 +-
 4 files changed, 122 insertions(+), 5 deletions(-)

diff --git a/block/io.c b/block/io.c
index dfc153b8d82..936877d3745 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2021,6 +2021,97 @@ int coroutine_fn bdrv_co_block_status_from_backing=
(BlockDriverState *bs,
     return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID;
 }

+static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
+                                             bool want_zero,
+                                             int64_t offset, int64_t byt=
es,
+                                             int64_t *pnum, int64_t *map=
,
+                                             BlockDriverState **file);
+
+/*
+ * Returns an aligned allocation status of the specified sectors.
+ * Wrapper around bdrv_co_block_status() which requires the initial
+ * offset and count to be aligned, and guarantees the result will also
+ * be aligned (even if it requires piecing together multiple
+ * sub-aligned queries into an appropriate coalesced answer).
+ */
+static int coroutine_fn bdrv_co_block_status_aligned(BlockDriverState *b=
s,
+                                                     uint32_t align,
+                                                     bool want_zero,
+                                                     int64_t offset,
+                                                     int64_t bytes,
+                                                     int64_t *pnum,
+                                                     int64_t *map,
+                                                     BlockDriverState **=
file)
+{
+    int ret;
+
+    assert(is_power_of_2(align) && QEMU_IS_ALIGNED(offset | bytes, align=
));
+    ret =3D bdrv_co_block_status(bs, want_zero, offset, bytes, pnum, map=
, file);
+    if (ret < 0) {
+        return ret;
+    }
+    if (!*pnum) {
+        assert(!bytes || ret & BDRV_BLOCK_EOF);
+        return ret;
+    }
+    if (*pnum >=3D align) {
+        if (!QEMU_IS_ALIGNED(*pnum, align)) {
+            ret &=3D ~BDRV_BLOCK_EOF;
+            *pnum =3D QEMU_ALIGN_DOWN(*pnum, align);
+        }
+        return ret;
+    }
+    /* Merge in status for the rest of align */
+    while (*pnum < align) {
+        int ret2;
+        int64_t pnum2;
+        int64_t map2;
+        BlockDriverState *file2;
+
+        ret2 =3D bdrv_co_block_status(bs, want_zero, offset + *pnum,
+                                    align - *pnum, &pnum2,
+                                    map ? &map2 : NULL, file ? &file2 : =
NULL);
+        if (ret2 < 0) {
+            return ret2;
+        }
+        if (ret2 & BDRV_BLOCK_EOF) {
+            ret |=3D BDRV_BLOCK_EOF;
+            if (!pnum2) {
+                pnum2 =3D align - *pnum;
+                ret2 |=3D BDRV_BLOCK_ZERO;
+            }
+        } else {
+            assert(pnum2);
+        }
+        if (ret2 & BDRV_BLOCK_DATA) {
+            ret |=3D BDRV_BLOCK_DATA;
+        }
+        if (!(ret2 & BDRV_BLOCK_ZERO)) {
+            ret &=3D ~BDRV_BLOCK_ZERO;
+        }
+        if ((ret & BDRV_BLOCK_OFFSET_VALID) &&
+            (!(ret2 & BDRV_BLOCK_OFFSET_VALID) ||
+             (map && *map + *pnum !=3D map2) || (file && *file !=3D file=
2))) {
+            ret &=3D ~BDRV_BLOCK_OFFSET_VALID;
+            if (map) {
+                *map =3D 0;
+            }
+            if (file) {
+                *file =3D NULL;
+            }
+        }
+        if (ret2 & BDRV_BLOCK_ALLOCATED) {
+            ret |=3D BDRV_BLOCK_ALLOCATED;
+        }
+        if (ret2 & BDRV_BLOCK_RAW) {
+            assert(ret & BDRV_BLOCK_RAW);
+            assert(ret & BDRV_BLOCK_OFFSET_VALID);
+        }
+        *pnum +=3D pnum2;
+    }
+    return ret;
+}
+
 /*
  * Returns the allocation status of the specified sectors.
  * Drivers not implementing the functionality are assumed to not support
@@ -2121,6 +2212,19 @@ static int coroutine_fn bdrv_co_block_status(Block=
DriverState *bs,
      */
     assert(*pnum && QEMU_IS_ALIGNED(*pnum, align) &&
            align > offset - aligned_offset);
+
+    if (ret & BDRV_BLOCK_RAW) {
+        assert(ret & BDRV_BLOCK_OFFSET_VALID && local_file);
+        ret =3D bdrv_co_block_status_aligned(local_file, align, want_zer=
o,
+                                           local_map, *pnum, pnum, &loca=
l_map,
+                                           &local_file);
+        if (ret < 0) {
+            goto out;
+        }
+        assert(!(ret & BDRV_BLOCK_RAW));
+        ret |=3D BDRV_BLOCK_RAW;
+    }
+
     *pnum -=3D offset - aligned_offset;
     if (*pnum > bytes) {
         *pnum =3D bytes;
@@ -2130,9 +2234,7 @@ static int coroutine_fn bdrv_co_block_status(BlockD=
riverState *bs,
     }

     if (ret & BDRV_BLOCK_RAW) {
-        assert(ret & BDRV_BLOCK_OFFSET_VALID && local_file);
-        ret =3D bdrv_co_block_status(local_file, want_zero, local_map,
-                                   *pnum, pnum, &local_map, &local_file)=
;
+        ret &=3D ~BDRV_BLOCK_RAW;
         goto out;
     }

diff --git a/tests/qemu-iotests/221 b/tests/qemu-iotests/221
index 808cd9a289c..3f60fd0fdc8 100755
--- a/tests/qemu-iotests/221
+++ b/tests/qemu-iotests/221
@@ -41,17 +41,27 @@ echo
 echo "=3D=3D=3D Check mapping of unaligned raw image =3D=3D=3D"
 echo

+# Note that when we enable format probing by omitting -f, the raw
+# layer forces 512-byte alignment and the bytes past EOF take on the
+# same status as the rest of the sector; otherwise, we can see the
+# implicit hole visible past EOF thanks to the block layer rounding
+# sizes up.
+
 _make_test_img 43009 # qemu-img create rounds size up
 $QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
+$QEMU_IMG map -f $IMGFMT --output=3Djson "$TEST_IMG" | _filter_qemu_img_=
map

 truncate --size=3D43009 "$TEST_IMG" # so we resize it and check again
 $QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
+$QEMU_IMG map -f $IMGFMT --output=3Djson "$TEST_IMG" | _filter_qemu_img_=
map

 $QEMU_IO -c 'w 43008 1' "$TEST_IMG" | _filter_qemu_io # writing also rou=
nds up
 $QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
+$QEMU_IMG map -f $IMGFMT --output=3Djson "$TEST_IMG" | _filter_qemu_img_=
map

 truncate --size=3D43009 "$TEST_IMG" # so we resize it and check again
 $QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
+$QEMU_IMG map -f $IMGFMT --output=3Djson "$TEST_IMG" | _filter_qemu_img_=
map

 # success, all done
 echo '*** done'
diff --git a/tests/qemu-iotests/221.out b/tests/qemu-iotests/221.out
index a9c0190aadc..723e94037fe 100644
--- a/tests/qemu-iotests/221.out
+++ b/tests/qemu-iotests/221.out
@@ -5,12 +5,18 @@ QA output created by 221
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D43009
 [{ "start": 0, "length": 43520, "depth": 0, "zero": true, "data": false,=
 "offset": OFFSET}]
 [{ "start": 0, "length": 43520, "depth": 0, "zero": true, "data": false,=
 "offset": OFFSET}]
+[{ "start": 0, "length": 43520, "depth": 0, "zero": true, "data": false,=
 "offset": OFFSET}]
+[{ "start": 0, "length": 43520, "depth": 0, "zero": true, "data": false,=
 "offset": OFFSET}]
 wrote 1/1 bytes at offset 43008
 1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 [{ "start": 0, "length": 40960, "depth": 0, "zero": true, "data": false,=
 "offset": OFFSET},
+{ "start": 40960, "length": 2560, "depth": 0, "zero": false, "data": tru=
e, "offset": OFFSET}]
+[{ "start": 0, "length": 40960, "depth": 0, "zero": true, "data": false,=
 "offset": OFFSET},
 { "start": 40960, "length": 2049, "depth": 0, "zero": false, "data": tru=
e, "offset": OFFSET},
 { "start": 43009, "length": 511, "depth": 0, "zero": true, "data": false=
, "offset": OFFSET}]
 [{ "start": 0, "length": 40960, "depth": 0, "zero": true, "data": false,=
 "offset": OFFSET},
+{ "start": 40960, "length": 2560, "depth": 0, "zero": false, "data": tru=
e, "offset": OFFSET}]
+[{ "start": 0, "length": 40960, "depth": 0, "zero": true, "data": false,=
 "offset": OFFSET},
 { "start": 40960, "length": 2049, "depth": 0, "zero": false, "data": tru=
e, "offset": OFFSET},
 { "start": 43009, "length": 511, "depth": 0, "zero": true, "data": false=
, "offset": OFFSET}]
 *** done
diff --git a/tests/qemu-iotests/241.out b/tests/qemu-iotests/241.out
index ef7de1205d2..fd856bb0c8d 100644
--- a/tests/qemu-iotests/241.out
+++ b/tests/qemu-iotests/241.out
@@ -22,8 +22,7 @@ WARNING: Image format was not specified for '/home/ebla=
ke/qemu/tests/qemu-iotest

   size:  1024
   min block: 1
-[{ "start": 0, "length": 1000, "depth": 0, "zero": false, "data": true, =
"offset": OFFSET},
-{ "start": 1000, "length": 24, "depth": 0, "zero": true, "data": true, "=
offset": OFFSET}]
+[{ "start": 0, "length": 1024, "depth": 0, "zero": false, "data": true, =
"offset": OFFSET}]
 1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)

 =3D=3D=3D Encrypted qcow2 file backed by unaligned raw image  =3D=3D=3D
--=20
2.20.1
