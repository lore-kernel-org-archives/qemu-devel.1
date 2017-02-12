Received: from eggs.gnu.org ([2001:4830:134:3::10]:47324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj8A-0007GD-NU
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:39:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj86-0007Mx-No
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:39:10 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Sun, 12 Feb 2017 02:38:38 +0100
Message-Id: <20170212013844.6560-6-mreitz@redhat.com>
In-Reply-To: <20170212013440.5919-1-mreitz@redhat.com>
References: <20170212013440.5919-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 15/21] qemu-io: Return non-zero exit code on
 failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Nir Soffer <nirsof@gmail.com>

The result of openfile was not checked, leading to failure deep in the
actual command with confusing error message, and exiting with exit code 0.

Here is a simple example - trying to read with the wrong format:

    $ touch file
    $ qemu-io -f qcow2 -c 'read -P 1 0 1024' file; echo $?
    can't open device file: Image is not in qcow2 format
    no file open, try 'help open'
    0

With this patch, we fail earlier with exit code 1:

    $ ./qemu-io -f qcow2 -c 'read -P 1 0 1024' file; echo $?
    can't open device file: Image is not in qcow2 format
    1

Failing earlier, we don't log this error now:

    no file open, try 'help open'

But some tests expected it; the line was removed from the test output.

Signed-off-by: Nir Soffer <nirsof@gmail.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20170201003120.23378-2-nirsof@gmail.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-io.c                  |  8 ++++++--
 tests/qemu-iotests/059.out |  3 ---
 tests/qemu-iotests/070.out |  1 -
 tests/qemu-iotests/075.out |  7 -------
 tests/qemu-iotests/076.out |  3 ---
 tests/qemu-iotests/078.out |  6 ------
 tests/qemu-iotests/080.out | 18 ------------------
 tests/qemu-iotests/083.out | 17 -----------------
 tests/qemu-iotests/088.out |  6 ------
 tests/qemu-iotests/092.out | 12 ------------
 tests/qemu-iotests/116.out |  7 -------
 tests/qemu-iotests/131.out |  1 -
 tests/qemu-iotests/140.out |  1 -
 13 files changed, 6 insertions(+), 84 deletions(-)

diff --git a/qemu-io.c b/qemu-io.c
index 23a229f880..427cbaef57 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -595,13 +595,17 @@ int main(int argc, char **argv)
                 exit(1);
             }
             opts = qemu_opts_to_qdict(qopts, NULL);
-            openfile(NULL, flags, writethrough, opts);
+            if (openfile(NULL, flags, writethrough, opts)) {
+                exit(1);
+            }
         } else {
             if (format) {
                 opts = qdict_new();
                 qdict_put(opts, "driver", qstring_from_str(format));
             }
-            openfile(argv[optind], flags, writethrough, opts);
+            if (openfile(argv[optind], flags, writethrough, opts)) {
+                exit(1);
+            }
         }
     }
     command_loop();
diff --git a/tests/qemu-iotests/059.out b/tests/qemu-iotests/059.out
index 19bd50de1e..6154509bc3 100644
--- a/tests/qemu-iotests/059.out
+++ b/tests/qemu-iotests/059.out
@@ -3,17 +3,14 @@ QA output created by 059
 === Testing invalid granularity ===
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.vmdk: Invalid granularity, image may be corrupt
-no file open, try 'help open'
 
 === Testing too big L2 table size ===
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.vmdk: L2 table size too big
-no file open, try 'help open'
 
 === Testing too big L1 table size ===
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.vmdk: L1 size too big
-no file open, try 'help open'
 
 === Testing monolithicFlat creation and opening ===
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2147483648 subformat=monolithicFlat
diff --git a/tests/qemu-iotests/070.out b/tests/qemu-iotests/070.out
index 131a5b17dc..c269d99483 100644
--- a/tests/qemu-iotests/070.out
+++ b/tests/qemu-iotests/070.out
@@ -4,7 +4,6 @@ QA output created by 070
 can't open device TEST_DIR/iotest-dirtylog-10G-4M.vhdx: VHDX image file 'TEST_DIR/iotest-dirtylog-10G-4M.vhdx' opened read-only, but contains a log that needs to be replayed
 To replay the log, run:
 qemu-img check -r all 'TEST_DIR/iotest-dirtylog-10G-4M.vhdx'
- no file open, try 'help open'
 === Verify open image replays log  ===
 read 18874368/18874368 bytes at offset 0
 18 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/075.out b/tests/qemu-iotests/075.out
index 87beae4e3c..b234b758e0 100644
--- a/tests/qemu-iotests/075.out
+++ b/tests/qemu-iotests/075.out
@@ -10,29 +10,22 @@ read 512/512 bytes at offset 1048064
 
 == block_size must be a multiple of 512 ==
 can't open device TEST_DIR/simple-pattern.cloop: block_size 513 must be a multiple of 512
-no file open, try 'help open'
 
 == block_size cannot be zero ==
 can't open device TEST_DIR/simple-pattern.cloop: block_size cannot be zero
-no file open, try 'help open'
 
 == huge block_size ===
 can't open device TEST_DIR/simple-pattern.cloop: block_size 4294966784 must be 64 MB or less
-no file open, try 'help open'
 
 == offsets_size overflow ===
 can't open device TEST_DIR/simple-pattern.cloop: n_blocks 4294967295 must be 536870911 or less
-no file open, try 'help open'
 
 == refuse images that require too many offsets ===
 can't open device TEST_DIR/simple-pattern.cloop: image requires too many offsets, try increasing block size
-no file open, try 'help open'
 
 == refuse images with non-monotonically increasing offsets ==
 can't open device TEST_DIR/simple-pattern.cloop: offsets not monotonically increasing at index 1, image file is corrupt
-no file open, try 'help open'
 
 == refuse images with invalid compressed block size ==
 can't open device TEST_DIR/simple-pattern.cloop: invalid compressed block size at index 1, image file is corrupt
-no file open, try 'help open'
 *** done
diff --git a/tests/qemu-iotests/076.out b/tests/qemu-iotests/076.out
index 72645b2522..9c66c5fb46 100644
--- a/tests/qemu-iotests/076.out
+++ b/tests/qemu-iotests/076.out
@@ -6,15 +6,12 @@ read 65536/65536 bytes at offset 0
 
 == Negative catalog size ==
 can't open device TEST_DIR/parallels-v1: Catalog too large
-no file open, try 'help open'
 
 == Overflow in catalog allocation ==
 can't open device TEST_DIR/parallels-v1: Catalog too large
-no file open, try 'help open'
 
 == Zero sectors per track ==
 can't open device TEST_DIR/parallels-v1: Invalid image: Zero sectors per track
-no file open, try 'help open'
 
 == Read from a valid v2 image ==
 read 65536/65536 bytes at offset 0
diff --git a/tests/qemu-iotests/078.out b/tests/qemu-iotests/078.out
index 42b8a83015..c3d6aa4fe4 100644
--- a/tests/qemu-iotests/078.out
+++ b/tests/qemu-iotests/078.out
@@ -6,23 +6,17 @@ read 512/512 bytes at offset 0
 
 == Negative catalog size ==
 can't open device TEST_DIR/empty.bochs: Catalog size is too large
-no file open, try 'help open'
 
 == Overflow for catalog size * sizeof(uint32_t) ==
 can't open device TEST_DIR/empty.bochs: Catalog size is too large
-no file open, try 'help open'
 
 == Too small catalog bitmap for image size ==
 can't open device TEST_DIR/empty.bochs: Catalog size is too small for this disk size
-no file open, try 'help open'
 can't open device TEST_DIR/empty.bochs: Catalog size is too small for this disk size
-no file open, try 'help open'
 
 == Negative extent size ==
 can't open device TEST_DIR/empty.bochs: Extent size 2147483648 is too large
-no file open, try 'help open'
 
 == Zero extent size ==
 can't open device TEST_DIR/empty.bochs: Extent size must be at least 512
-no file open, try 'help open'
 *** done
diff --git a/tests/qemu-iotests/080.out b/tests/qemu-iotests/080.out
index 0daac48b12..6a7fda1356 100644
--- a/tests/qemu-iotests/080.out
+++ b/tests/qemu-iotests/080.out
@@ -3,46 +3,33 @@ QA output created by 080
 == Huge header size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.qcow2: qcow2 header exceeds cluster size
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow2: qcow2 header exceeds cluster size
-no file open, try 'help open'
 
 == Huge unknown header extension ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.qcow2: Invalid backing file offset
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow2: Header extension too large
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow2: Header extension too large
-no file open, try 'help open'
 
 == Huge refcount table size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.qcow2: Reference count table too large
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow2: Reference count table too large
-no file open, try 'help open'
 
 == Misaligned refcount table ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.qcow2: Invalid reference count table offset
-no file open, try 'help open'
 
 == Huge refcount offset ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.qcow2: Invalid reference count table offset
-no file open, try 'help open'
 
 == Invalid snapshot table ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.qcow2: Too many snapshots
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow2: Too many snapshots
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow2: Invalid snapshot table offset
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow2: Invalid snapshot table offset
-no file open, try 'help open'
 
 == Hitting snapshot table size limit ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
@@ -53,13 +40,9 @@ read 512/512 bytes at offset 0
 == Invalid L1 table ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.qcow2: Active L1 table too large
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow2: Active L1 table too large
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow2: Invalid L1 table offset
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow2: Invalid L1 table offset
-no file open, try 'help open'
 
 == Invalid L1 table (with internal snapshot in the image) ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
@@ -68,7 +51,6 @@ qemu-img: Could not open 'TEST_DIR/t.IMGFMT': L1 table is too small
 == Invalid backing file size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.qcow2: Backing file name too long
-no file open, try 'help open'
 
 == Invalid L2 entry (huge physical offset) ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
diff --git a/tests/qemu-iotests/083.out b/tests/qemu-iotests/083.out
index ef3d1e32a5..0c13888ba1 100644
--- a/tests/qemu-iotests/083.out
+++ b/tests/qemu-iotests/083.out
@@ -2,52 +2,42 @@ QA output created by 083
 === Check disconnect before neg1 ===
 
 can't open device nbd:127.0.0.1:PORT:exportname=foo
-no file open, try 'help open'
 
 === Check disconnect after neg1 ===
 
 can't open device nbd:127.0.0.1:PORT:exportname=foo
-no file open, try 'help open'
 
 === Check disconnect 8 neg1 ===
 
 can't open device nbd:127.0.0.1:PORT:exportname=foo
-no file open, try 'help open'
 
 === Check disconnect 16 neg1 ===
 
 can't open device nbd:127.0.0.1:PORT:exportname=foo
-no file open, try 'help open'
 
 === Check disconnect before export ===
 
 can't open device nbd:127.0.0.1:PORT:exportname=foo
-no file open, try 'help open'
 
 === Check disconnect after export ===
 
 can't open device nbd:127.0.0.1:PORT:exportname=foo
-no file open, try 'help open'
 
 === Check disconnect 4 export ===
 
 can't open device nbd:127.0.0.1:PORT:exportname=foo
-no file open, try 'help open'
 
 === Check disconnect 12 export ===
 
 can't open device nbd:127.0.0.1:PORT:exportname=foo
-no file open, try 'help open'
 
 === Check disconnect 16 export ===
 
 can't open device nbd:127.0.0.1:PORT:exportname=foo
-no file open, try 'help open'
 
 === Check disconnect before neg2 ===
 
 can't open device nbd:127.0.0.1:PORT:exportname=foo
-no file open, try 'help open'
 
 === Check disconnect after neg2 ===
 
@@ -56,12 +46,10 @@ read failed: Input/output error
 === Check disconnect 8 neg2 ===
 
 can't open device nbd:127.0.0.1:PORT:exportname=foo
-no file open, try 'help open'
 
 === Check disconnect 10 neg2 ===
 
 can't open device nbd:127.0.0.1:PORT:exportname=foo
-no file open, try 'help open'
 
 === Check disconnect before request ===
 
@@ -99,27 +87,22 @@ read 512/512 bytes at offset 0
 === Check disconnect before neg-classic ===
 
 can't open device nbd:127.0.0.1:PORT
-no file open, try 'help open'
 
 === Check disconnect 8 neg-classic ===
 
 can't open device nbd:127.0.0.1:PORT
-no file open, try 'help open'
 
 === Check disconnect 16 neg-classic ===
 
 can't open device nbd:127.0.0.1:PORT
-no file open, try 'help open'
 
 === Check disconnect 24 neg-classic ===
 
 can't open device nbd:127.0.0.1:PORT
-no file open, try 'help open'
 
 === Check disconnect 28 neg-classic ===
 
 can't open device nbd:127.0.0.1:PORT
-no file open, try 'help open'
 
 === Check disconnect after neg-classic ===
 
diff --git a/tests/qemu-iotests/088.out b/tests/qemu-iotests/088.out
index a2a83b8a1c..1f6bcf0abc 100644
--- a/tests/qemu-iotests/088.out
+++ b/tests/qemu-iotests/088.out
@@ -3,15 +3,9 @@ QA output created by 088
 == Invalid block size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.vpc: Invalid block size 0
-no file open, try 'help open'
 can't open device TEST_DIR/t.vpc: Invalid block size 0
-no file open, try 'help open'
 can't open device TEST_DIR/t.vpc: Invalid block size 128
-no file open, try 'help open'
 can't open device TEST_DIR/t.vpc: Invalid block size 128
-no file open, try 'help open'
 can't open device TEST_DIR/t.vpc: Invalid block size 305419896
-no file open, try 'help open'
 can't open device TEST_DIR/t.vpc: Invalid block size 305419896
-no file open, try 'help open'
 *** done
diff --git a/tests/qemu-iotests/092.out b/tests/qemu-iotests/092.out
index e18f54c200..6eda321fc6 100644
--- a/tests/qemu-iotests/092.out
+++ b/tests/qemu-iotests/092.out
@@ -3,36 +3,24 @@ QA output created by 092
 == Invalid cluster size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.qcow: Cluster size must be between 512 and 64k
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow: Cluster size must be between 512 and 64k
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow: Cluster size must be between 512 and 64k
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow: Cluster size must be between 512 and 64k
-no file open, try 'help open'
 
 == Invalid L2 table size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.qcow: L2 table size must be between 512 and 64k
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow: L2 table size must be between 512 and 64k
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow: L2 table size must be between 512 and 64k
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow: L2 table size must be between 512 and 64k
-no file open, try 'help open'
 
 == Invalid size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.qcow: Image too large
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow: Image too large
-no file open, try 'help open'
 
 == Invalid backing file length ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.qcow: Backing file name too long
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow: Backing file name too long
-no file open, try 'help open'
 *** done
diff --git a/tests/qemu-iotests/116.out b/tests/qemu-iotests/116.out
index 1f11d4446d..24bee57783 100644
--- a/tests/qemu-iotests/116.out
+++ b/tests/qemu-iotests/116.out
@@ -3,35 +3,28 @@ QA output created by 116
 == truncated header cluster ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 can't open device TEST_DIR/t.qed: Could not open 'TEST_DIR/t.qed': Invalid argument
-no file open, try 'help open'
 
 == invalid header magic ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 can't open device TEST_DIR/t.qed: Image not in QED format
-no file open, try 'help open'
 
 == invalid cluster size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 can't open device TEST_DIR/t.qed: Could not open 'TEST_DIR/t.qed': Invalid argument
-no file open, try 'help open'
 
 == invalid table size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 can't open device TEST_DIR/t.qed: Could not open 'TEST_DIR/t.qed': Invalid argument
-no file open, try 'help open'
 
 == invalid header size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 can't open device TEST_DIR/t.qed: Could not open 'TEST_DIR/t.qed': Invalid argument
-no file open, try 'help open'
 
 == invalid L1 table offset ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 can't open device TEST_DIR/t.qed: Could not open 'TEST_DIR/t.qed': Invalid argument
-no file open, try 'help open'
 
 == invalid image size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 can't open device TEST_DIR/t.qed: Could not open 'TEST_DIR/t.qed': Invalid argument
-no file open, try 'help open'
 *** done
diff --git a/tests/qemu-iotests/131.out b/tests/qemu-iotests/131.out
index ae2412ebf7..27c2c5389b 100644
--- a/tests/qemu-iotests/131.out
+++ b/tests/qemu-iotests/131.out
@@ -23,7 +23,6 @@ read 32768/32768 bytes at offset 0
 32 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == Corrupt image ==
 can't open device TEST_DIR/t.parallels: parallels: Image was not closed correctly; cannot be opened read/write
-no file open, try 'help open'
 ERROR image was not closed correctly
 
 1 errors were found on the image.
diff --git a/tests/qemu-iotests/140.out b/tests/qemu-iotests/140.out
index 0409cd0174..6c0445603a 100644
--- a/tests/qemu-iotests/140.out
+++ b/tests/qemu-iotests/140.out
@@ -9,7 +9,6 @@ read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
 can't open device nbd+unix:///drv?socket=TEST_DIR/nbd: No export with name 'drv' available
-no file open, try 'help open'
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN"}
 *** done
-- 
2.11.0
