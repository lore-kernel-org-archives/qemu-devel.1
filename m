Received: from eggs.gnu.org ([209.51.188.92]:49005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUux-00089h-QO
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuo-000256-Hc
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:39 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 30 Apr 2019 17:42:25 +0200
Message-Id: <20190430154244.30083-9-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/27] qemu-img: Saner printing of large file
 sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Disk sizes close to INT64_MAX cause overflow, for some pretty
ridiculous output:

  $ ./nbdkit -U - memory size=3D$((2**63 - 512)) --run 'qemu-img info $nb=
d'
  image: nbd+unix://?socket=3D/tmp/nbdkitHSAzNz/socket
  file format: raw
  virtual size: -8388607T (9223372036854775296 bytes)
  disk size: unavailable

But there's no reason to have two separate implementations of integer
to human-readable abbreviation, where one has overflow and stops at
'T', while the other avoids overflow and goes all the way to 'E'. With
this patch, the output now claims 8EiB instead of -8388607T, which
really is the correct rounding of largest file size supported by qemu
(we could go 511 bytes larger if we used byte-accurate sizing instead
of rounding up to the next sector boundary, but that wouldn't change
the human-readable result).

Quite a few iotests need updates to expected output to match.

Reported-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Tested-by: Richard W.M. Jones <rjones@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Tested-by: Max Reitz <mreitz@redhat.com>
---
 block/qapi.c               | 49 +++++++++-----------------------------
 tests/qemu-iotests/043.out |  6 ++---
 tests/qemu-iotests/053.out |  2 +-
 tests/qemu-iotests/059.out | 10 ++++----
 tests/qemu-iotests/060.out | 10 ++++----
 tests/qemu-iotests/061.out | 12 +++++-----
 tests/qemu-iotests/070.out |  2 +-
 tests/qemu-iotests/082.out | 26 ++++++++++----------
 tests/qemu-iotests/084.out |  8 +++----
 tests/qemu-iotests/089.out |  2 +-
 tests/qemu-iotests/095.out |  4 ++--
 tests/qemu-iotests/104.out |  6 ++---
 tests/qemu-iotests/110.out |  6 ++---
 tests/qemu-iotests/114.out |  2 +-
 tests/qemu-iotests/126.out |  4 ++--
 tests/qemu-iotests/130.out | 10 ++++----
 tests/qemu-iotests/153.out |  2 +-
 tests/qemu-iotests/191.out |  8 +++----
 tests/qemu-iotests/195.out |  4 ++--
 tests/qemu-iotests/198.out |  4 ++--
 tests/qemu-iotests/206.out | 10 ++++----
 tests/qemu-iotests/207.out | 12 +++++-----
 tests/qemu-iotests/210.out |  8 +++----
 tests/qemu-iotests/211.out | 10 ++++----
 tests/qemu-iotests/212.out | 10 ++++----
 tests/qemu-iotests/213.out | 10 ++++----
 tests/qemu-iotests/233.out |  4 ++--
 tests/qemu-iotests/237.out | 22 ++++++++---------
 tests/qemu-iotests/242.out | 10 ++++----
 29 files changed, 123 insertions(+), 150 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index e3e74f898f..0c13c86f4e 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -631,42 +631,13 @@ BlockStatsList *qmp_query_blockstats(bool has_query=
_nodes,
     return head;
 }
=20
-#define NB_SUFFIXES 4
-
-static char *get_human_readable_size(char *buf, int buf_size, int64_t si=
ze)
-{
-    static const char suffixes[NB_SUFFIXES] =3D {'K', 'M', 'G', 'T'};
-    int64_t base;
-    int i;
-
-    if (size <=3D 999) {
-        snprintf(buf, buf_size, "%" PRId64, size);
-    } else {
-        base =3D 1024;
-        for (i =3D 0; i < NB_SUFFIXES; i++) {
-            if (size < (10 * base)) {
-                snprintf(buf, buf_size, "%0.1f%c",
-                         (double)size / base,
-                         suffixes[i]);
-                break;
-            } else if (size < (1000 * base) || i =3D=3D (NB_SUFFIXES - 1=
)) {
-                snprintf(buf, buf_size, "%" PRId64 "%c",
-                         ((size + (base >> 1)) / base),
-                         suffixes[i]);
-                break;
-            }
-            base =3D base * 1024;
-        }
-    }
-    return buf;
-}
-
 void bdrv_snapshot_dump(QEMUSnapshotInfo *sn)
 {
-    char buf1[128], date_buf[128], clock_buf[128];
+    char date_buf[128], clock_buf[128];
     struct tm tm;
     time_t ti;
     int64_t secs;
+    char *sizing =3D NULL;
=20
     if (!sn) {
         qemu_printf("%-10s%-20s%7s%20s%15s",
@@ -683,13 +654,14 @@ void bdrv_snapshot_dump(QEMUSnapshotInfo *sn)
                  (int)((secs / 60) % 60),
                  (int)(secs % 60),
                  (int)((sn->vm_clock_nsec / 1000000) % 1000));
+        sizing =3D size_to_str(sn->vm_state_size);
         qemu_printf("%-10s%-20s%7s%20s%15s",
                     sn->id_str, sn->name,
-                    get_human_readable_size(buf1, sizeof(buf1),
-                                            sn->vm_state_size),
+                    sizing,
                     date_buf,
                     clock_buf);
     }
+    g_free(sizing);
 }
=20
 static void dump_qdict(int indentation, QDict *dict);
@@ -787,14 +759,13 @@ void bdrv_image_info_specific_dump(ImageInfoSpecifi=
c *info_spec)
=20
 void bdrv_image_info_dump(ImageInfo *info)
 {
-    char size_buf[128], dsize_buf[128];
+    char *size_buf, *dsize_buf;
     if (!info->has_actual_size) {
-        snprintf(dsize_buf, sizeof(dsize_buf), "unavailable");
+        dsize_buf =3D g_strdup("unavailable");
     } else {
-        get_human_readable_size(dsize_buf, sizeof(dsize_buf),
-                                info->actual_size);
+        dsize_buf =3D size_to_str(info->actual_size);
     }
-    get_human_readable_size(size_buf, sizeof(size_buf), info->virtual_si=
ze);
+    size_buf =3D size_to_str(info->virtual_size);
     qemu_printf("image: %s\n"
                 "file format: %s\n"
                 "virtual size: %s (%" PRId64 " bytes)\n"
@@ -802,6 +773,8 @@ void bdrv_image_info_dump(ImageInfo *info)
                 info->filename, info->format, size_buf,
                 info->virtual_size,
                 dsize_buf);
+    g_free(size_buf);
+    g_free(dsize_buf);
=20
     if (info->has_encrypted && info->encrypted) {
         qemu_printf("encrypted: yes\n");
diff --git a/tests/qemu-iotests/043.out b/tests/qemu-iotests/043.out
index b37d2a3807..0280f999ce 100644
--- a/tests/qemu-iotests/043.out
+++ b/tests/qemu-iotests/043.out
@@ -22,19 +22,19 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1=
34217728 backing_file=3DTEST_DIR/
 =3D=3D finite chain of length 3 (human) =3D=3D
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 65536
 backing file: TEST_DIR/t.IMGFMT.2.base
=20
 image: TEST_DIR/t.IMGFMT.2.base
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 65536
 backing file: TEST_DIR/t.IMGFMT.1.base
=20
 image: TEST_DIR/t.IMGFMT.1.base
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 65536
=20
 =3D=3D finite chain of length 3 (json) =3D=3D
diff --git a/tests/qemu-iotests/053.out b/tests/qemu-iotests/053.out
index 8e793b6462..8a65881232 100644
--- a/tests/qemu-iotests/053.out
+++ b/tests/qemu-iotests/053.out
@@ -9,7 +9,7 @@ wrote 512/512 bytes at offset 0
 No errors were found on the image.
=20
 =3D=3D Checking compressed image virtual disk size =3D=3D
-virtual size: 512 (512 bytes)
+virtual size: 512 B (512 bytes)
=20
 =3D=3D Verifying the compressed image =3D=3D
 read 512/512 bytes at offset 0
diff --git a/tests/qemu-iotests/059.out b/tests/qemu-iotests/059.out
index f6dce7947c..700ad1f290 100644
--- a/tests/qemu-iotests/059.out
+++ b/tests/qemu-iotests/059.out
@@ -16,7 +16,7 @@ can't open device TEST_DIR/t.vmdk: L1 size too big
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2147483648 subformat=
=3DmonolithicFlat
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 2.0G (2147483648 bytes)
+virtual size: 2 GiB (2147483648 bytes)
=20
 =3D=3D=3D Testing monolithicFlat with zeroed_grain =3D=3D=3D
 qemu-img: TEST_DIR/t.IMGFMT: Flat image can't enable zeroed grain
@@ -26,8 +26,8 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D214=
7483648 subformat=3DmonolithicF
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824000 subfor=
mat=3DtwoGbMaxExtentFlat
 image: TEST_DIR/t.vmdk
 file format: vmdk
-virtual size: 1.0T (1073741824000 bytes)
-disk size: 16K
+virtual size: 0.977 TiB (1073741824000 bytes)
+disk size: 16 KiB
 Format specific information:
     cid: XXXXXXXX
     parent cid: XXXXXXXX
@@ -2055,7 +2055,7 @@ can't open: Cannot use relative extent paths with V=
MDK descriptor file 'json:{"i
 =3D=3D=3D Testing version 3 =3D=3D=3D
 image: TEST_DIR/iotest-version3.IMGFMT
 file format: IMGFMT
-virtual size: 16G (17179869184 bytes)
+virtual size: 16 GiB (17179869184 bytes)
 cluster_size: 65536
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -2262,7 +2262,7 @@ read 512/512 bytes at offset 64931328
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4398046511104 subfor=
mat=3DmonolithicFlat
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 4.0T (4398046511104 bytes)
+virtual size: 4 TiB (4398046511104 bytes)
 wrote 512/512 bytes at offset 966367641600
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 e100000000:  0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a  ..........=
......
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index ad1c18e903..e42bf8c5a9 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -13,7 +13,7 @@ write failed: Input/output error
 incompatible_features     0x2
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -364,10 +364,10 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D=
67108864
 qcow2: Marking image as corrupt: Refblock at 0xffffff00000000 is not cov=
ered by the refcount structures; further corruption events will be suppre=
ssed
 qemu-img: Failed to discard unused refblocks: Input/output error
 --- Checking and retrying ---
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 No errors were found on the image.
 Image resized.
-virtual size: 32M (33554432 bytes)
+virtual size: 32 MiB (33554432 bytes)
=20
 =3D=3D=3D Discarding a non-covered in-bounds refblock =3D=3D=3D
=20
@@ -375,10 +375,10 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D=
67108864
 qcow2: Marking image as corrupt: Refblock at 0x1000000000 is not covered=
 by the refcount structures; further corruption events will be suppressed
 qemu-img: Failed to discard unused refblocks: Input/output error
 --- Checking and retrying ---
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 No errors were found on the image.
 Image resized.
-virtual size: 32M (33554432 bytes)
+virtual size: 32 MiB (33554432 bytes)
=20
 =3D=3D=3D Discarding a refblock covered by an unaligned refblock =3D=3D=3D
=20
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 9fe1ec702f..1aa7d37ff9 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -495,7 +495,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D6=
7108864 data_file=3DTEST_DIR/t.IM
 qemu-img: Cannot downgrade an image with a data file
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -515,7 +515,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D6=
7108864 data_file=3DTEST_DIR/t.IM
 qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Could not open 'foo': No s=
uch file or directory
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -528,7 +528,7 @@ Format specific information:
 qemu-img: Could not open 'TEST_DIR/t.IMGFMT': 'data-file' is required fo=
r this image
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -542,7 +542,7 @@ Format specific information:
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 data_file=3D=
TEST_DIR/t.IMGFMT.data data_file_raw=3Don
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -554,7 +554,7 @@ Format specific information:
 No errors were found on the image.
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -567,7 +567,7 @@ No errors were found on the image.
 qemu-img: data-file-raw cannot be set on existing images
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
diff --git a/tests/qemu-iotests/070.out b/tests/qemu-iotests/070.out
index c7c567344c..2fbfd7eaf3 100644
--- a/tests/qemu-iotests/070.out
+++ b/tests/qemu-iotests/070.out
@@ -22,6 +22,6 @@ read 18874368/18874368 bytes at offset 0
 =3D=3D=3D Verify image created by Disk2VHD can be opened =3D=3D=3D
 image: TEST_DIR/test-disk2vhd.IMGFMT
 file format: IMGFMT
-virtual size: 256M (268435456 bytes)
+virtual size: 256 MiB (268435456 bytes)
 cluster_size: 2097152
 *** done
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index 915640613f..d36938da9b 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -6,14 +6,14 @@ Testing: create -f foo -f qcow2 TEST_DIR/t.qcow2 128M
 Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D134217728 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 65536
=20
 Testing: create -f qcow2 -o cluster_size=3D4k -o lazy_refcounts=3Don TES=
T_DIR/t.qcow2 128M
 Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D134217728 cluster_size=
=3D4096 lazy_refcounts=3Don refcount_bits=3D16
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 4096
 Format specific information:
     compat: 1.1
@@ -25,7 +25,7 @@ Testing: create -f qcow2 -o cluster_size=3D4k -o lazy_r=
efcounts=3Don -o cluster_size
 Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D134217728 cluster_size=
=3D8192 lazy_refcounts=3Don refcount_bits=3D16
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 8192
 Format specific information:
     compat: 1.1
@@ -37,7 +37,7 @@ Testing: create -f qcow2 -o cluster_size=3D4k,cluster_s=
ize=3D8k TEST_DIR/t.qcow2 128
 Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D134217728 cluster_size=
=3D8192 lazy_refcounts=3Doff refcount_bits=3D16
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 8192
=20
 =3D=3D=3D create: help for -o =3D=3D=3D
@@ -278,18 +278,18 @@ Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1=
34217728 cluster_size=3D65536 lazy_
 Testing: convert -f foo -f qcow2 TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 image: TEST_DIR/t.IMGFMT.base
 file format: raw
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
=20
 Testing: convert -O foo -O qcow2 TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 image: TEST_DIR/t.IMGFMT.base
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 65536
=20
 Testing: convert -O qcow2 -o cluster_size=3D4k -o lazy_refcounts=3Don TE=
ST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 image: TEST_DIR/t.IMGFMT.base
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 4096
 Format specific information:
     compat: 1.1
@@ -300,7 +300,7 @@ Format specific information:
 Testing: convert -O qcow2 -o cluster_size=3D4k -o lazy_refcounts=3Don -o=
 cluster_size=3D8k TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 image: TEST_DIR/t.IMGFMT.base
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 8192
 Format specific information:
     compat: 1.1
@@ -311,7 +311,7 @@ Format specific information:
 Testing: convert -O qcow2 -o cluster_size=3D4k,cluster_size=3D8k TEST_DI=
R/t.qcow2 TEST_DIR/t.qcow2.base
 image: TEST_DIR/t.IMGFMT.base
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 8192
=20
 =3D=3D=3D convert: help for -o =3D=3D=3D
@@ -560,7 +560,7 @@ qemu-img: Cannot enable copy offloading when -c is us=
ed
 Testing: amend -f foo -f qcow2 -o lazy_refcounts=3Don TEST_DIR/t.qcow2
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -571,7 +571,7 @@ Format specific information:
 Testing: amend -f qcow2 -o size=3D130M -o lazy_refcounts=3Doff TEST_DIR/=
t.qcow2
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 130M (136314880 bytes)
+virtual size: 130 MiB (136314880 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -582,7 +582,7 @@ Format specific information:
 Testing: amend -f qcow2 -o size=3D8M -o lazy_refcounts=3Don -o size=3D13=
2M TEST_DIR/t.qcow2
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 132M (138412032 bytes)
+virtual size: 132 MiB (138412032 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -593,7 +593,7 @@ Format specific information:
 Testing: amend -f qcow2 -o size=3D4M,size=3D148M TEST_DIR/t.qcow2
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 148M (155189248 bytes)
+virtual size: 148 MiB (155189248 bytes)
 cluster_size: 65536
=20
 =3D=3D=3D amend: help for -o =3D=3D=3D
diff --git a/tests/qemu-iotests/084.out b/tests/qemu-iotests/084.out
index 5c5ab928c9..c2648d963f 100644
--- a/tests/qemu-iotests/084.out
+++ b/tests/qemu-iotests/084.out
@@ -5,7 +5,7 @@ QA output created by 084
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 1048576
 disk image file size in bytes: 67109888
=20
@@ -14,13 +14,13 @@ disk image file size in bytes: 67109888
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 1048576
 disk image file size in bytes: 1024
 Test 1: Maximum size (512 TB - 128 MB):
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 512T (562949819203584 bytes)
+virtual size: 512 TiB (562949819203584 bytes)
 cluster_size: 1048576
=20
 Test 2: Size too large (512 TB - 128 MB + 64 kB)
@@ -35,7 +35,7 @@ qemu-img: Could not open 'TEST_DIR/t.IMGFMT': unsupport=
ed VDI image (too many bl
 Test 5: Valid Image: 64MB, Blocks In Image 64, Block Size 1MB
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 1048576
=20
 Test 6: Block Size !=3D 1MB; too small test (1MB - 1)
diff --git a/tests/qemu-iotests/089.out b/tests/qemu-iotests/089.out
index 89e3e4340a..20c8ce8f0e 100644
--- a/tests/qemu-iotests/089.out
+++ b/tests/qemu-iotests/089.out
@@ -38,7 +38,7 @@ read failed: Input/output error
=20
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
=20
 =3D=3D=3D Testing option merging =3D=3D=3D
diff --git a/tests/qemu-iotests/095.out b/tests/qemu-iotests/095.out
index 8c093dfff3..d2e393fef8 100644
--- a/tests/qemu-iotests/095.out
+++ b/tests/qemu-iotests/095.out
@@ -6,7 +6,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D10485=
7600 backing_file=3DTEST_DIR/
 =3D=3D=3D Base image info before commit and resize =3D=3D=3D
 image: TEST_DIR/t.IMGFMT.base
 file format: IMGFMT
-virtual size: 5.0M (5242880 bytes)
+virtual size: 5 MiB (5242880 bytes)
=20
 =3D=3D=3D Running QEMU Live Commit Test =3D=3D=3D
=20
@@ -23,5 +23,5 @@ virtual size: 5.0M (5242880 bytes)
 =3D=3D=3D Base image info after commit and resize =3D=3D=3D
 image: TEST_DIR/t.IMGFMT.base
 file format: IMGFMT
-virtual size: 100M (104857600 bytes)
+virtual size: 100 MiB (104857600 bytes)
 *** done
diff --git a/tests/qemu-iotests/104.out b/tests/qemu-iotests/104.out
index ab8d892c2a..d854155f5b 100644
--- a/tests/qemu-iotests/104.out
+++ b/tests/qemu-iotests/104.out
@@ -4,9 +4,9 @@ QA output created by 104
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1024
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 1.0K (1024 bytes)
+virtual size: 1 KiB (1024 bytes)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1234
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 1.5K (1536 bytes)
-***done
+virtual size: 1.5 KiB (1536 bytes)
+*** done
diff --git a/tests/qemu-iotests/110.out b/tests/qemu-iotests/110.out
index 46e6a60510..f60b26390e 100644
--- a/tests/qemu-iotests/110.out
+++ b/tests/qemu-iotests/110.out
@@ -6,14 +6,14 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D=
67108864
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_fil=
e=3Dt.IMGFMT.base
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 backing file: t.IMGFMT.base (actual path: TEST_DIR/t.IMGFMT.base)
=20
 =3D=3D=3D Non-reconstructable filename =3D=3D=3D
=20
 image: json:{"driver": "IMGFMT", "file": {"set-state.0.event": "read_aio=
", "image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "driver"=
: "blkdebug", "set-state.0.new_state": 42}}
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 backing file: t.IMGFMT.base (actual path: TEST_DIR/t.IMGFMT.base)
=20
 =3D=3D=3D Backing name is always relative to the backed image =3D=3D=3D
@@ -24,6 +24,6 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D671=
08864 backing_file=3Dt.IMGFMT.b
=20
 image: json:{"driver": "IMGFMT", "file": {"children": [{"driver": "file"=
, "filename": "TEST_DIR/t.IMGFMT"}, {"driver": "file", "filename": "TEST_=
DIR/t.IMGFMT.copy"}], "driver": "quorum", "vote-threshold": 1}}
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 backing file: t.IMGFMT.base (cannot determine actual path)
 *** done
diff --git a/tests/qemu-iotests/114.out b/tests/qemu-iotests/114.out
index 22dc66c633..67adef37a4 100644
--- a/tests/qemu-iotests/114.out
+++ b/tests/qemu-iotests/114.out
@@ -3,7 +3,7 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D=
67108864
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_fil=
e=3DTEST_DIR/t.IMGFMT.base
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 backing file: TEST_DIR/t.IMGFMT.base
 backing file format: foo
diff --git a/tests/qemu-iotests/126.out b/tests/qemu-iotests/126.out
index 17d03d5248..e3c4d61916 100644
--- a/tests/qemu-iotests/126.out
+++ b/tests/qemu-iotests/126.out
@@ -11,13 +11,13 @@ Formatting 'TEST_DIR/image:base.IMGFMT', fmt=3DIMGFMT=
 size=3D67108864
 Formatting 'TEST_DIR/image:top.IMGFMT', fmt=3DIMGFMT size=3D67108864 bac=
king_file=3D./image:base.IMGFMT
 image: TEST_DIR/image:top.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 backing file: ./image:base.IMGFMT (actual path: TEST_DIR/./image:base.IM=
GFMT)
=20
 Formatting 'base.IMGFMT', fmt=3DIMGFMT size=3D67108864
 Formatting 'file:image:top.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing=
_file=3Dbase.IMGFMT
 image: ./image:top.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 backing file: base.IMGFMT (actual path: ./base.IMGFMT)
 *** done
diff --git a/tests/qemu-iotests/130.out b/tests/qemu-iotests/130.out
index 93020c328e..e45285ccc3 100644
--- a/tests/qemu-iotests/130.out
+++ b/tests/qemu-iotests/130.out
@@ -4,7 +4,7 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D=
67108864
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
=20
 =3D=3D=3D HMP commit =3D=3D=3D
=20
@@ -13,14 +13,14 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu)=20
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_fil=
e=3DTEST_DIR/t.IMGFMT.orig backing_fmt=3Draw
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) commit testdisk
 (qemu)=20
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 backing file: TEST_DIR/t.IMGFMT.orig
 backing file format: raw
=20
@@ -31,13 +31,13 @@ wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_fil=
e=3DTEST_DIR/t.IMGFMT.orig backing_fmt=3Draw
 wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 backing file: TEST_DIR/t.IMGFMT.orig
 backing file format: raw
 *** done
diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
index 021c1cb899..e969420006 100644
--- a/tests/qemu-iotests/153.out
+++ b/tests/qemu-iotests/153.out
@@ -449,7 +449,7 @@ _qemu_io_wrapper TEST_DIR/t.qcow2 -c write 0 512
 No conflict:
 image: null-co://
 file format: null-co
-virtual size: 1.0G (1073741824 bytes)
+virtual size: 1 GiB (1073741824 bytes)
 disk size: unavailable
=20
 Conflict:
diff --git a/tests/qemu-iotests/191.out b/tests/qemu-iotests/191.out
index a513ccca0b..3fc92bb56e 100644
--- a/tests/qemu-iotests/191.out
+++ b/tests/qemu-iotests/191.out
@@ -395,13 +395,13 @@ wrote 65536/65536 bytes at offset 1048576
 }
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 backing file: TEST_DIR/t.IMGFMT.base
 backing file format: IMGFMT
 image: TEST_DIR/t.IMGFMT.ovl2
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 backing file: TEST_DIR/t.IMGFMT.base
 backing file format: IMGFMT
@@ -813,13 +813,13 @@ wrote 65536/65536 bytes at offset 1048576
 }
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 backing file: TEST_DIR/t.IMGFMT.base
 backing file format: IMGFMT
 image: TEST_DIR/t.IMGFMT.ovl2
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 backing file: TEST_DIR/t.IMGFMT.base
 backing file format: IMGFMT
diff --git a/tests/qemu-iotests/195.out b/tests/qemu-iotests/195.out
index 1e9330b1be..e6df0d6781 100644
--- a/tests/qemu-iotests/195.out
+++ b/tests/qemu-iotests/195.out
@@ -35,7 +35,7 @@ Testing: -drive if=3Dnone,file=3DTEST_DIR/t.IMGFMT,back=
ing.node-name=3Dmid
=20
 image: TEST_DIR/t.IMGFMT.mid
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 backing file: /dev/null
 backing file format: IMGFMT
@@ -73,7 +73,7 @@ Testing: -drive if=3Dnone,file=3DTEST_DIR/t.IMGFMT,node=
-name=3Dtop
=20
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 backing file: /dev/null
 backing file format: IMGFMT
diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
index adb805cce9..e86b175e39 100644
--- a/tests/qemu-iotests/198.out
+++ b/tests/qemu-iotests/198.out
@@ -34,7 +34,7 @@ read 16777216/16777216 bytes at offset 0
 =3D=3D checking image base =3D=3D
 image: json:{"encrypt.key-secret": "sec0", "driver": "IMGFMT", "file": {=
"driver": "file", "filename": "TEST_DIR/t.IMGFMT.base"}}
 file format: IMGFMT
-virtual size: 16M (16777216 bytes)
+virtual size: 16 MiB (16777216 bytes)
 Format specific information:
     encrypt:
         ivgen alg: plain64
@@ -76,7 +76,7 @@ Format specific information:
 =3D=3D checking image layer =3D=3D
 image: json:{"encrypt.key-secret": "sec1", "driver": "IMGFMT", "file": {=
"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}}
 file format: IMGFMT
-virtual size: 16M (16777216 bytes)
+virtual size: 16 MiB (16777216 bytes)
 backing file: TEST_DIR/t.IMGFMT.base
 Format specific information:
     encrypt:
diff --git a/tests/qemu-iotests/206.out b/tests/qemu-iotests/206.out
index 0f1c23babb..61e7241e0b 100644
--- a/tests/qemu-iotests/206.out
+++ b/tests/qemu-iotests/206.out
@@ -14,7 +14,7 @@
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -36,7 +36,7 @@ Format specific information:
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -58,7 +58,7 @@ Format specific information:
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 32M (33554432 bytes)
+virtual size: 32 MiB (33554432 bytes)
 cluster_size: 2097152
 Format specific information:
     compat: 1.1
@@ -80,7 +80,7 @@ Format specific information:
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 32M (33554432 bytes)
+virtual size: 32 MiB (33554432 bytes)
 cluster_size: 512
 backing file: TEST_IMG.base
 backing file format: IMGFMT
@@ -97,7 +97,7 @@ Format specific information:
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 32M (33554432 bytes)
+virtual size: 32 MiB (33554432 bytes)
 encrypted: yes
 cluster_size: 65536
 Format specific information:
diff --git a/tests/qemu-iotests/207.out b/tests/qemu-iotests/207.out
index 568e8619d0..979d5cf745 100644
--- a/tests/qemu-iotests/207.out
+++ b/tests/qemu-iotests/207.out
@@ -7,12 +7,12 @@
=20
 image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "s=
erver.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
 file format: IMGFMT
-virtual size: 4.0M (4194304 bytes)
+virtual size: 4 MiB (4194304 bytes)
=20
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 4.0M (4194304 bytes)
+virtual size: 4 MiB (4194304 bytes)
=20
 =3D=3D=3D Test host-key-check options =3D=3D=3D
=20
@@ -23,7 +23,7 @@ virtual size: 4.0M (4194304 bytes)
=20
 image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "s=
erver.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
 file format: IMGFMT
-virtual size: 8.0M (8388608 bytes)
+virtual size: 8 MiB (8388608 bytes)
=20
 {"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "ssh", "location": {"host-key-check": {"mode": "known_hosts"=
}, "path": "TEST_DIR/PID-t.img", "server": {"host": "127.0.0.1", "port": =
"22"}}, "size": 4194304}}}
 {"return": {}}
@@ -32,7 +32,7 @@ virtual size: 8.0M (8388608 bytes)
=20
 image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "s=
erver.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
 file format: IMGFMT
-virtual size: 4.0M (4194304 bytes)
+virtual size: 4 MiB (4194304 bytes)
=20
 {"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "ssh", "location": {"host-key-check": {"hash": "wrong", "mod=
e": "hash", "type": "md5"}, "path": "TEST_DIR/PID-t.img", "server": {"hos=
t": "127.0.0.1", "port": "22"}}, "size": 2097152}}}
 {"return": {}}
@@ -47,7 +47,7 @@ Job failed: remote host key does not match host_key_che=
ck 'wrong'
=20
 image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "s=
erver.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
 file format: IMGFMT
-virtual size: 8.0M (8388608 bytes)
+virtual size: 8 MiB (8388608 bytes)
=20
 {"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "ssh", "location": {"host-key-check": {"hash": "wrong", "mod=
e": "hash", "type": "sha1"}, "path": "TEST_DIR/PID-t.img", "server": {"ho=
st": "127.0.0.1", "port": "22"}}, "size": 2097152}}}
 {"return": {}}
@@ -62,7 +62,7 @@ Job failed: remote host key does not match host_key_che=
ck 'wrong'
=20
 image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "s=
erver.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
 file format: IMGFMT
-virtual size: 4.0M (4194304 bytes)
+virtual size: 4 MiB (4194304 bytes)
=20
 =3D=3D=3D Invalid path and user =3D=3D=3D
=20
diff --git a/tests/qemu-iotests/210.out b/tests/qemu-iotests/210.out
index a3692ce00d..a5e88e2a82 100644
--- a/tests/qemu-iotests/210.out
+++ b/tests/qemu-iotests/210.out
@@ -14,7 +14,7 @@
=20
 image: json:{"driver": "IMGFMT", "file": {"driver": "file", "filename": =
"TEST_IMG"}, "key-secret": "keysec0"}
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 encrypted: yes
 Format specific information:
     ivgen alg: plain64
@@ -66,7 +66,7 @@ Format specific information:
=20
 image: json:{"driver": "IMGFMT", "file": {"driver": "file", "filename": =
"TEST_IMG"}, "key-secret": "keysec0"}
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 encrypted: yes
 Format specific information:
     ivgen alg: plain64
@@ -121,7 +121,7 @@ Job failed: Cannot find device=3Dthis doesn't exist n=
or node_name=3Dthis doesn't exi
=20
 image: json:{"driver": "IMGFMT", "file": {"driver": "file", "filename": =
"TEST_IMG"}, "key-secret": "keysec0"}
 file format: IMGFMT
-virtual size: 0 (0 bytes)
+virtual size: 0 B (0 bytes)
 encrypted: yes
 Format specific information:
     ivgen alg: plain64
@@ -191,7 +191,7 @@ Job failed: The requested file size is too large
 {"error": {"class": "GenericError", "desc": "Parameter 'size' expects a =
>0 size"}}
 image: json:{"driver": "IMGFMT", "file": {"driver": "file", "filename": =
"TEST_IMG"}, "key-secret": "keysec0"}
 file format: IMGFMT
-virtual size: 0 (0 bytes)
+virtual size: 0 B (0 bytes)
 encrypted: yes
 Format specific information:
     ivgen alg: plain64
diff --git a/tests/qemu-iotests/211.out b/tests/qemu-iotests/211.out
index 682adc2a10..b83384deea 100644
--- a/tests/qemu-iotests/211.out
+++ b/tests/qemu-iotests/211.out
@@ -14,7 +14,7 @@
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 1048576
=20
 [{ "start": 0, "length": 134217728, "depth": 0, "zero": true, "data": fa=
lse}]
@@ -33,7 +33,7 @@ cluster_size: 1048576
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 1048576
=20
 [{ "start": 0, "length": 67108864, "depth": 0, "zero": true, "data": fal=
se}]
@@ -52,7 +52,7 @@ cluster_size: 1048576
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 32M (33554432 bytes)
+virtual size: 32 MiB (33554432 bytes)
 cluster_size: 1048576
=20
 [{ "start": 0, "length": 3072, "depth": 0, "zero": false, "data": true, =
"offset": 1024},
@@ -75,7 +75,7 @@ Job failed: Cannot find device=3Dthis doesn't exist nor=
 node_name=3Dthis doesn't exi
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 0 (0 bytes)
+virtual size: 0 B (0 bytes)
 cluster_size: 1048576
=20
 =3D=3D=3D Maximum size =3D=3D=3D
@@ -87,7 +87,7 @@ cluster_size: 1048576
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 512T (562949819203584 bytes)
+virtual size: 512 TiB (562949819203584 bytes)
 cluster_size: 1048576
=20
 =3D=3D=3D Invalid sizes =3D=3D=3D
diff --git a/tests/qemu-iotests/212.out b/tests/qemu-iotests/212.out
index 22810720cf..1538d679be 100644
--- a/tests/qemu-iotests/212.out
+++ b/tests/qemu-iotests/212.out
@@ -14,7 +14,7 @@
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
=20
 =3D=3D=3D Successful image creation (explicit defaults) =3D=3D=3D
=20
@@ -30,7 +30,7 @@ virtual size: 128M (134217728 bytes)
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
=20
 =3D=3D=3D Successful image creation (with non-default options) =3D=3D=3D
=20
@@ -46,7 +46,7 @@ virtual size: 64M (67108864 bytes)
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 32M (33554432 bytes)
+virtual size: 32 MiB (33554432 bytes)
=20
 =3D=3D=3D Invalid BlockdevRef =3D=3D=3D
=20
@@ -65,7 +65,7 @@ Job failed: Cannot find device=3Dthis doesn't exist nor=
 node_name=3Dthis doesn't exi
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 0 (0 bytes)
+virtual size: 0 B (0 bytes)
=20
 =3D=3D=3D Maximum size =3D=3D=3D
=20
@@ -76,7 +76,7 @@ virtual size: 0 (0 bytes)
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 4096T (4503599627369984 bytes)
+virtual size: 4 PiB (4503599627369984 bytes)
=20
 =3D=3D=3D Invalid sizes =3D=3D=3D
=20
diff --git a/tests/qemu-iotests/213.out b/tests/qemu-iotests/213.out
index 169083e08e..be4ae85180 100644
--- a/tests/qemu-iotests/213.out
+++ b/tests/qemu-iotests/213.out
@@ -14,7 +14,7 @@
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 128M (134217728 bytes)
+virtual size: 128 MiB (134217728 bytes)
 cluster_size: 8388608
=20
 =3D=3D=3D Successful image creation (explicit defaults) =3D=3D=3D
@@ -31,7 +31,7 @@ cluster_size: 8388608
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 8388608
=20
 =3D=3D=3D Successful image creation (with non-default options) =3D=3D=3D
@@ -48,7 +48,7 @@ cluster_size: 8388608
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 32M (33554432 bytes)
+virtual size: 32 MiB (33554432 bytes)
 cluster_size: 268435456
=20
 =3D=3D=3D Invalid BlockdevRef =3D=3D=3D
@@ -68,7 +68,7 @@ Job failed: Cannot find device=3Dthis doesn't exist nor=
 node_name=3Dthis doesn't exi
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 0 (0 bytes)
+virtual size: 0 B (0 bytes)
 cluster_size: 8388608
=20
 =3D=3D=3D Maximum size =3D=3D=3D
@@ -80,7 +80,7 @@ cluster_size: 8388608
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 64T (70368744177664 bytes)
+virtual size: 64 TiB (70368744177664 bytes)
 cluster_size: 67108864
=20
 =3D=3D=3D Invalid sizes =3D=3D=3D
diff --git a/tests/qemu-iotests/233.out b/tests/qemu-iotests/233.out
index 9511b6ea65..4edc2dd5cf 100644
--- a/tests/qemu-iotests/233.out
+++ b/tests/qemu-iotests/233.out
@@ -28,11 +28,11 @@ server reported: Option 0x8 not permitted before TLS
 =3D=3D check TLS works =3D=3D
 image: nbd://127.0.0.1:PORT
 file format: nbd
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 disk size: unavailable
 image: nbd://127.0.0.1:PORT
 file format: nbd
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 disk size: unavailable
 exports available: 1
  export: ''
diff --git a/tests/qemu-iotests/237.out b/tests/qemu-iotests/237.out
index 2aaa68f672..a8c800bfad 100644
--- a/tests/qemu-iotests/237.out
+++ b/tests/qemu-iotests/237.out
@@ -14,7 +14,7 @@
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 5.0G (5368709120 bytes)
+virtual size: 5 GiB (5368709120 bytes)
 cluster_size: 65536
 Format specific information:
     cid: XXXXXXXXXX
@@ -41,7 +41,7 @@ Format specific information:
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 64M (67108864 bytes)
+virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     cid: XXXXXXXXXX
@@ -68,7 +68,7 @@ Format specific information:
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 32M (33554432 bytes)
+virtual size: 32 MiB (33554432 bytes)
 cluster_size: 65536
 Format specific information:
     cid: XXXXXXXXXX
@@ -169,7 +169,7 @@ Job failed: List of extents contains unused extents
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 512 (512 bytes)
+virtual size: 512 B (512 bytes)
 Format specific information:
     cid: XXXXXXXXXX
     parent cid: XXXXXXXXXX
@@ -189,7 +189,7 @@ Format specific information:
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 512 (512 bytes)
+virtual size: 512 B (512 bytes)
 cluster_size: 65536
 Format specific information:
     cid: XXXXXXXXXX
@@ -211,7 +211,7 @@ Format specific information:
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 1.0G (1073741824 bytes)
+virtual size: 1 GiB (1073741824 bytes)
 Format specific information:
     cid: XXXXXXXXXX
     parent cid: XXXXXXXXXX
@@ -231,7 +231,7 @@ Format specific information:
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 1.0G (1073741824 bytes)
+virtual size: 1 GiB (1073741824 bytes)
 cluster_size: 65536
 Format specific information:
     cid: XXXXXXXXXX
@@ -253,7 +253,7 @@ Format specific information:
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 2.0G (2147483648 bytes)
+virtual size: 2 GiB (2147483648 bytes)
 Format specific information:
     cid: XXXXXXXXXX
     parent cid: XXXXXXXXXX
@@ -273,7 +273,7 @@ Format specific information:
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 2.0G (2147483648 bytes)
+virtual size: 2 GiB (2147483648 bytes)
 cluster_size: 65536
 Format specific information:
     cid: XXXXXXXXXX
@@ -295,7 +295,7 @@ Format specific information:
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 5.0G (5368709120 bytes)
+virtual size: 5 GiB (5368709120 bytes)
 Format specific information:
     cid: XXXXXXXXXX
     parent cid: XXXXXXXXXX
@@ -323,7 +323,7 @@ Format specific information:
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 5.0G (5368709120 bytes)
+virtual size: 5 GiB (5368709120 bytes)
 cluster_size: 65536
 Format specific information:
     cid: XXXXXXXXXX
diff --git a/tests/qemu-iotests/242.out b/tests/qemu-iotests/242.out
index fbe05d71c0..7ac8404d11 100644
--- a/tests/qemu-iotests/242.out
+++ b/tests/qemu-iotests/242.out
@@ -8,7 +8,7 @@ qemu-img info dump:
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 1.0M (1048576 bytes)
+virtual size: 1 MiB (1048576 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -28,7 +28,7 @@ qemu-img info dump:
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 1.0M (1048576 bytes)
+virtual size: 1 MiB (1048576 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -60,7 +60,7 @@ qemu-img info dump:
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 1.0M (1048576 bytes)
+virtual size: 1 MiB (1048576 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -100,7 +100,7 @@ qemu-img info dump:
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 1.0M (1048576 bytes)
+virtual size: 1 MiB (1048576 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
@@ -149,7 +149,7 @@ Unset the unknown bitmap flag '0x4' in the bitmap dir=
ectory entry:
=20
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 1.0M (1048576 bytes)
+virtual size: 1 MiB (1048576 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
--=20
2.20.1
