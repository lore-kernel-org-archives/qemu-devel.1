Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3950C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:43:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4E222339D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E222339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i595V-0002F7-7W
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 09:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i58yk-0002Jf-Hg
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i58ye-0006Fs-CY
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:36:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48070)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i58yZ-0006BS-Oe; Tue, 03 Sep 2019 09:36:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F0DA562E9A;
 Tue,  3 Sep 2019 13:36:02 +0000 (UTC)
Received: from localhost (ovpn-204-98.brq.redhat.com [10.40.204.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C63210002B8;
 Tue,  3 Sep 2019 13:36:02 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  3 Sep 2019 15:35:40 +0200
Message-Id: <20190903133553.6500-4-mreitz@redhat.com>
In-Reply-To: <20190903133553.6500-1-mreitz@redhat.com>
References: <20190903133553.6500-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 03 Sep 2019 13:36:03 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 03/16] block: posix: Always allocate the
 first block
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nir Soffer <nirsof@gmail.com>

When creating an image with preallocation "off" or "falloc", the first
block of the image is typically not allocated. When using Gluster
storage backed by XFS filesystem, reading this block using direct I/O
succeeds regardless of request length, fooling alignment detection.

In this case we fallback to a safe value (4096) instead of the optimal
value (512), which may lead to unneeded data copying when aligning
requests.  Allocating the first block avoids the fallback.

Since we allocate the first block even with preallocation=3Doff, we no
longer create images with zero disk size:

    $ ./qemu-img create -f raw test.raw 1g
    Formatting 'test.raw', fmt=3Draw size=3D1073741824

    $ ls -lhs test.raw
    4.0K -rw-r--r--. 1 nsoffer nsoffer 1.0G Aug 16 23:48 test.raw

And converting the image requires additional cluster:

    $ ./qemu-img measure -f raw -O qcow2 test.raw
    required size: 458752
    fully allocated size: 1074135040

When using format like vmdk with multiple files per image, we allocate
one block per file:

    $ ./qemu-img create -f vmdk -o subformat=3DtwoGbMaxExtentFlat test.vm=
dk 4g
    Formatting 'test.vmdk', fmt=3Dvmdk size=3D4294967296 compat6=3Doff hw=
version=3Dundefined subformat=3DtwoGbMaxExtentFlat

    $ ls -lhs test*.vmdk
    4.0K -rw-r--r--. 1 nsoffer nsoffer 2.0G Aug 27 03:23 test-f001.vmdk
    4.0K -rw-r--r--. 1 nsoffer nsoffer 2.0G Aug 27 03:23 test-f002.vmdk
    4.0K -rw-r--r--. 1 nsoffer nsoffer  353 Aug 27 03:23 test.vmdk

I did quick performance test for copying disks with qemu-img convert to
new raw target image to Gluster storage with sector size of 512 bytes:

    for i in $(seq 10); do
        rm -f dst.raw
        sleep 10
        time ./qemu-img convert -f raw -O raw -t none -T none src.raw dst=
.raw
    done

Here is a table comparing the total time spent:

Type    Before(s)   After(s)    Diff(%)
---------------------------------------
real      530.028    469.123      -11.4
user       17.204     10.768      -37.4
sys        17.881      7.011      -60.7

We can see very clear improvement in CPU usage.

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
Message-id: 20190827010528.8818-2-nsoffer@redhat.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/file-posix.c                            | 51 +++++++++++++++++++
 tests/qemu-iotests/059.out                    |  2 +-
 tests/qemu-iotests/{150.out =3D> 150.out.qcow2} |  0
 tests/qemu-iotests/150.out.raw                | 12 +++++
 tests/qemu-iotests/175                        | 19 ++++---
 tests/qemu-iotests/175.out                    |  8 +--
 tests/qemu-iotests/178.out.qcow2              |  4 +-
 tests/qemu-iotests/221.out                    | 12 +++--
 tests/qemu-iotests/253.out                    | 12 +++--
 9 files changed, 99 insertions(+), 21 deletions(-)
 rename tests/qemu-iotests/{150.out =3D> 150.out.qcow2} (100%)
 create mode 100644 tests/qemu-iotests/150.out.raw

diff --git a/block/file-posix.c b/block/file-posix.c
index fbeb0068db..447f937aa1 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1749,6 +1749,43 @@ static int handle_aiocb_discard(void *opaque)
     return ret;
 }
=20
+/*
+ * Help alignment probing by allocating the first block.
+ *
+ * When reading with direct I/O from unallocated area on Gluster backed =
by XFS,
+ * reading succeeds regardless of request length. In this case we fallba=
ck to
+ * safe alignment which is not optimal. Allocating the first block avoid=
s this
+ * fallback.
+ *
+ * fd may be opened with O_DIRECT, but we don't know the buffer alignmen=
t or
+ * request alignment, so we use safe values.
+ *
+ * Returns: 0 on success, -errno on failure. Since this is an optimizati=
on,
+ * caller may ignore failures.
+ */
+static int allocate_first_block(int fd, size_t max_size)
+{
+    size_t write_size =3D (max_size < MAX_BLOCKSIZE)
+        ? BDRV_SECTOR_SIZE
+        : MAX_BLOCKSIZE;
+    size_t max_align =3D MAX(MAX_BLOCKSIZE, getpagesize());
+    void *buf;
+    ssize_t n;
+    int ret;
+
+    buf =3D qemu_memalign(max_align, write_size);
+    memset(buf, 0, write_size);
+
+    do {
+        n =3D pwrite(fd, buf, write_size, 0);
+    } while (n =3D=3D -1 && errno =3D=3D EINTR);
+
+    ret =3D (n =3D=3D -1) ? -errno : 0;
+
+    qemu_vfree(buf);
+    return ret;
+}
+
 static int handle_aiocb_truncate(void *opaque)
 {
     RawPosixAIOData *aiocb =3D opaque;
@@ -1788,6 +1825,17 @@ static int handle_aiocb_truncate(void *opaque)
                 /* posix_fallocate() doesn't set errno. */
                 error_setg_errno(errp, -result,
                                  "Could not preallocate new data");
+            } else if (current_length =3D=3D 0) {
+                /*
+                 * posix_fallocate() uses fallocate() if the filesystem
+                 * supports it, or fallback to manually writing zeroes. =
If
+                 * fallocate() was used, unaligned reads from the falloc=
ated
+                 * area in raw_probe_alignment() will succeed, hence we =
need to
+                 * allocate the first block.
+                 *
+                 * Optimize future alignment probing; ignore failures.
+                 */
+                allocate_first_block(fd, offset);
             }
         } else {
             result =3D 0;
@@ -1849,6 +1897,9 @@ static int handle_aiocb_truncate(void *opaque)
         if (ftruncate(fd, offset) !=3D 0) {
             result =3D -errno;
             error_setg_errno(errp, -result, "Could not resize file");
+        } else if (current_length =3D=3D 0 && offset > current_length) {
+            /* Optimize future alignment probing; ignore failures. */
+            allocate_first_block(fd, offset);
         }
         return result;
     default:
diff --git a/tests/qemu-iotests/059.out b/tests/qemu-iotests/059.out
index 4fab42a28c..fe3f861f3c 100644
--- a/tests/qemu-iotests/059.out
+++ b/tests/qemu-iotests/059.out
@@ -27,7 +27,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D107=
3741824000 subformat=3DtwoGbMax
 image: TEST_DIR/t.vmdk
 file format: vmdk
 virtual size: 0.977 TiB (1073741824000 bytes)
-disk size: 16 KiB
+disk size: 1.97 MiB
 Format specific information:
     cid: XXXXXXXX
     parent cid: XXXXXXXX
diff --git a/tests/qemu-iotests/150.out b/tests/qemu-iotests/150.out.qcow=
2
similarity index 100%
rename from tests/qemu-iotests/150.out
rename to tests/qemu-iotests/150.out.qcow2
diff --git a/tests/qemu-iotests/150.out.raw b/tests/qemu-iotests/150.out.=
raw
new file mode 100644
index 0000000000..3cdc7727a5
--- /dev/null
+++ b/tests/qemu-iotests/150.out.raw
@@ -0,0 +1,12 @@
+QA output created by 150
+
+=3D=3D=3D Mapping sparse conversion =3D=3D=3D
+
+Offset          Length          File
+0               0x1000          TEST_DIR/t.IMGFMT
+
+=3D=3D=3D Mapping non-sparse conversion =3D=3D=3D
+
+Offset          Length          File
+0               0x100000        TEST_DIR/t.IMGFMT
+*** done
diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
index 51e62c8276..7ba28b3c1b 100755
--- a/tests/qemu-iotests/175
+++ b/tests/qemu-iotests/175
@@ -37,14 +37,16 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # the file size.  This function hides the resulting difference in the
 # stat -c '%b' output.
 # Parameter 1: Number of blocks an empty file occupies
-# Parameter 2: Image size in bytes
+# Parameter 2: Minimal number of blocks in an image
+# Parameter 3: Image size in bytes
 _filter_blocks()
 {
     extra_blocks=3D$1
-    img_size=3D$2
+    min_blocks=3D$2
+    img_size=3D$3
=20
-    sed -e "s/blocks=3D$extra_blocks\\(\$\\|[^0-9]\\)/nothing allocated/=
" \
-        -e "s/blocks=3D$((extra_blocks + img_size / 512))\\(\$\\|[^0-9]\=
\)/everything allocated/"
+    sed -e "s/blocks=3D$min_blocks\\(\$\\|[^0-9]\\)/min allocation/" \
+        -e "s/blocks=3D$((extra_blocks + img_size / 512))\\(\$\\|[^0-9]\=
\)/max allocation/"
 }
=20
 # get standard environment, filters and checks
@@ -60,16 +62,21 @@ size=3D$((1 * 1024 * 1024))
 touch "$TEST_DIR/empty"
 extra_blocks=3D$(stat -c '%b' "$TEST_DIR/empty")
=20
+# We always write the first byte; check how many blocks this filesystem
+# allocates to match empty image alloation.
+printf "\0" > "$TEST_DIR/empty"
+min_blocks=3D$(stat -c '%b' "$TEST_DIR/empty")
+
 echo
 echo "=3D=3D creating image with default preallocation =3D=3D"
 _make_test_img $size | _filter_imgfmt
-stat -c "size=3D%s, blocks=3D%b" $TEST_IMG | _filter_blocks $extra_block=
s $size
+stat -c "size=3D%s, blocks=3D%b" $TEST_IMG | _filter_blocks $extra_block=
s $min_blocks $size
=20
 for mode in off full falloc; do
     echo
     echo "=3D=3D creating image with preallocation $mode =3D=3D"
     IMGOPTS=3Dpreallocation=3D$mode _make_test_img $size | _filter_imgfm=
t
-    stat -c "size=3D%s, blocks=3D%b" $TEST_IMG | _filter_blocks $extra_b=
locks $size
+    stat -c "size=3D%s, blocks=3D%b" $TEST_IMG | _filter_blocks $extra_b=
locks $min_blocks $size
 done
=20
 # success, all done
diff --git a/tests/qemu-iotests/175.out b/tests/qemu-iotests/175.out
index 6d9a5ed84e..263e521262 100644
--- a/tests/qemu-iotests/175.out
+++ b/tests/qemu-iotests/175.out
@@ -2,17 +2,17 @@ QA output created by 175
=20
 =3D=3D creating image with default preallocation =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
-size=3D1048576, nothing allocated
+size=3D1048576, min allocation
=20
 =3D=3D creating image with preallocation off =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 preallocatio=
n=3Doff
-size=3D1048576, nothing allocated
+size=3D1048576, min allocation
=20
 =3D=3D creating image with preallocation full =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 preallocatio=
n=3Dfull
-size=3D1048576, everything allocated
+size=3D1048576, max allocation
=20
 =3D=3D creating image with preallocation falloc =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 preallocatio=
n=3Dfalloc
-size=3D1048576, everything allocated
+size=3D1048576, max allocation
  *** done
diff --git a/tests/qemu-iotests/178.out.qcow2 b/tests/qemu-iotests/178.ou=
t.qcow2
index 55a8dc926f..9e7d8c44df 100644
--- a/tests/qemu-iotests/178.out.qcow2
+++ b/tests/qemu-iotests/178.out.qcow2
@@ -101,7 +101,7 @@ converted image file size in bytes: 196608
 =3D=3D raw input image with data (human) =3D=3D
=20
 Formatting 'TEST_DIR/t.qcow2', fmt=3DIMGFMT size=3D1073741824
-required size: 393216
+required size: 458752
 fully allocated size: 1074135040
 wrote 512/512 bytes at offset 512
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -257,7 +257,7 @@ converted image file size in bytes: 196608
=20
 Formatting 'TEST_DIR/t.qcow2', fmt=3DIMGFMT size=3D1073741824
 {
-    "required": 393216,
+    "required": 458752,
     "fully-allocated": 1074135040
 }
 wrote 512/512 bytes at offset 512
diff --git a/tests/qemu-iotests/221.out b/tests/qemu-iotests/221.out
index 9f9dd52bb0..dca024a0c3 100644
--- a/tests/qemu-iotests/221.out
+++ b/tests/qemu-iotests/221.out
@@ -3,14 +3,18 @@ QA output created by 221
 =3D=3D=3D Check mapping of unaligned raw image =3D=3D=3D
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D65537
-[{ "start": 0, "length": 66048, "depth": 0, "zero": true, "data": false,=
 "offset": OFFSET}]
-[{ "start": 0, "length": 66048, "depth": 0, "zero": true, "data": false,=
 "offset": OFFSET}]
+[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true, =
"offset": OFFSET},
+{ "start": 4096, "length": 61952, "depth": 0, "zero": true, "data": fals=
e, "offset": OFFSET}]
+[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true, =
"offset": OFFSET},
+{ "start": 4096, "length": 61952, "depth": 0, "zero": true, "data": fals=
e, "offset": OFFSET}]
 wrote 1/1 bytes at offset 65536
 1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 65536, "depth": 0, "zero": true, "data": false,=
 "offset": OFFSET},
+[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true, =
"offset": OFFSET},
+{ "start": 4096, "length": 61440, "depth": 0, "zero": true, "data": fals=
e, "offset": OFFSET},
 { "start": 65536, "length": 1, "depth": 0, "zero": false, "data": true, =
"offset": OFFSET},
 { "start": 65537, "length": 511, "depth": 0, "zero": true, "data": false=
, "offset": OFFSET}]
-[{ "start": 0, "length": 65536, "depth": 0, "zero": true, "data": false,=
 "offset": OFFSET},
+[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true, =
"offset": OFFSET},
+{ "start": 4096, "length": 61440, "depth": 0, "zero": true, "data": fals=
e, "offset": OFFSET},
 { "start": 65536, "length": 1, "depth": 0, "zero": false, "data": true, =
"offset": OFFSET},
 { "start": 65537, "length": 511, "depth": 0, "zero": true, "data": false=
, "offset": OFFSET}]
 *** done
diff --git a/tests/qemu-iotests/253.out b/tests/qemu-iotests/253.out
index 607c0baa0b..3d08b305d7 100644
--- a/tests/qemu-iotests/253.out
+++ b/tests/qemu-iotests/253.out
@@ -3,12 +3,16 @@ QA output created by 253
 =3D=3D=3D Check mapping of unaligned raw image =3D=3D=3D
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048575
-[{ "start": 0, "length": 1048576, "depth": 0, "zero": true, "data": fals=
e, "offset": OFFSET}]
-[{ "start": 0, "length": 1048576, "depth": 0, "zero": true, "data": fals=
e, "offset": OFFSET}]
+[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true, =
"offset": OFFSET},
+{ "start": 4096, "length": 1044480, "depth": 0, "zero": true, "data": fa=
lse, "offset": OFFSET}]
+[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true, =
"offset": OFFSET},
+{ "start": 4096, "length": 1044480, "depth": 0, "zero": true, "data": fa=
lse, "offset": OFFSET}]
 wrote 65535/65535 bytes at offset 983040
 63.999 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 983040, "depth": 0, "zero": true, "data": false=
, "offset": OFFSET},
+[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true, =
"offset": OFFSET},
+{ "start": 4096, "length": 978944, "depth": 0, "zero": true, "data": fal=
se, "offset": OFFSET},
 { "start": 983040, "length": 65536, "depth": 0, "zero": false, "data": t=
rue, "offset": OFFSET}]
-[{ "start": 0, "length": 983040, "depth": 0, "zero": true, "data": false=
, "offset": OFFSET},
+[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true, =
"offset": OFFSET},
+{ "start": 4096, "length": 978944, "depth": 0, "zero": true, "data": fal=
se, "offset": OFFSET},
 { "start": 983040, "length": 65536, "depth": 0, "zero": false, "data": t=
rue, "offset": OFFSET}]
 *** done
--=20
2.21.0


