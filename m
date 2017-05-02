Received: from eggs.gnu.org ([2001:4830:134:3::10]:41586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5T1q-0006CG-Cl
	for qemu-devel@nongnu.org; Tue, 02 May 2017 04:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5T1n-0008VN-Ml
	for qemu-devel@nongnu.org; Tue, 02 May 2017 04:19:26 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue,  2 May 2017 16:18:23 +0800
Message-Id: <20170502081832.9546-14-famz@redhat.com>
In-Reply-To: <20170502081832.9546-1-famz@redhat.com>
References: <20170502081832.9546-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v16 13/22] iotests: 172: Use separate images
 for multiple devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

To avoid image lock failures.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/qemu-iotests/172     | 55 +++++++++++++++++++++++++---------------------
 tests/qemu-iotests/172.out | 50 +++++++++++++++++++++--------------------
 2 files changed, 56 insertions(+), 49 deletions(-)

diff --git a/tests/qemu-iotests/172 b/tests/qemu-iotests/172
index 1b7d3a1..826d6fe 100755
--- a/tests/qemu-iotests/172
+++ b/tests/qemu-iotests/172
@@ -30,6 +30,8 @@ status=1	# failure is the default!
 _cleanup()
 {
 	_cleanup_test_img
+    rm -f "$TEST_IMG.2"
+    rm -f "$TEST_IMG.3"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -86,6 +88,9 @@ size=720k
 
 _make_test_img $size
 
+TEST_IMG="$TEST_IMG.2" _make_test_img $size
+TEST_IMG="$TEST_IMG.3" _make_test_img $size
+
 # Default drive semantics:
 #
 # By default you get a single empty floppy drive. You can override it with
@@ -105,7 +110,7 @@ echo === Using -fda/-fdb options ===
 
 check_floppy_qtree -fda "$TEST_IMG"
 check_floppy_qtree -fdb "$TEST_IMG"
-check_floppy_qtree -fda "$TEST_IMG" -fdb "$TEST_IMG"
+check_floppy_qtree -fda "$TEST_IMG" -fdb "$TEST_IMG.2"
 
 
 echo
@@ -114,7 +119,7 @@ echo === Using -drive options ===
 
 check_floppy_qtree -drive if=floppy,file="$TEST_IMG"
 check_floppy_qtree -drive if=floppy,file="$TEST_IMG",index=1
-check_floppy_qtree -drive if=floppy,file="$TEST_IMG" -drive if=floppy,file="$TEST_IMG",index=1
+check_floppy_qtree -drive if=floppy,file="$TEST_IMG" -drive if=floppy,file="$TEST_IMG.2",index=1
 
 echo
 echo
@@ -122,7 +127,7 @@ echo === Using -drive if=none and -global ===
 
 check_floppy_qtree -drive if=none,file="$TEST_IMG" -global isa-fdc.driveA=none0
 check_floppy_qtree -drive if=none,file="$TEST_IMG" -global isa-fdc.driveB=none0
-check_floppy_qtree -drive if=none,file="$TEST_IMG" -drive if=none,file="$TEST_IMG" \
+check_floppy_qtree -drive if=none,file="$TEST_IMG" -drive if=none,file="$TEST_IMG.2" \
                    -global isa-fdc.driveA=none0 -global isa-fdc.driveB=none1
 
 echo
@@ -131,7 +136,7 @@ echo === Using -drive if=none and -device ===
 
 check_floppy_qtree -drive if=none,file="$TEST_IMG" -device floppy,drive=none0
 check_floppy_qtree -drive if=none,file="$TEST_IMG" -device floppy,drive=none0,unit=1
-check_floppy_qtree -drive if=none,file="$TEST_IMG" -drive if=none,file="$TEST_IMG" \
+check_floppy_qtree -drive if=none,file="$TEST_IMG" -drive if=none,file="$TEST_IMG.2" \
                    -device floppy,drive=none0 -device floppy,drive=none1,unit=1
 
 echo
@@ -139,58 +144,58 @@ echo
 echo === Mixing -fdX and -global ===
 
 # Working
-check_floppy_qtree -fda "$TEST_IMG" -drive if=none,file="$TEST_IMG" -global isa-fdc.driveB=none0
-check_floppy_qtree -fdb "$TEST_IMG" -drive if=none,file="$TEST_IMG" -global isa-fdc.driveA=none0
+check_floppy_qtree -fda "$TEST_IMG" -drive if=none,file="$TEST_IMG.2" -global isa-fdc.driveB=none0
+check_floppy_qtree -fdb "$TEST_IMG" -drive if=none,file="$TEST_IMG.2" -global isa-fdc.driveA=none0
 
 # Conflicting (-fdX wins)
-check_floppy_qtree -fda "$TEST_IMG" -drive if=none,file="$TEST_IMG" -global isa-fdc.driveA=none0
-check_floppy_qtree -fdb "$TEST_IMG" -drive if=none,file="$TEST_IMG" -global isa-fdc.driveB=none0
+check_floppy_qtree -fda "$TEST_IMG" -drive if=none,file="$TEST_IMG.2" -global isa-fdc.driveA=none0
+check_floppy_qtree -fdb "$TEST_IMG" -drive if=none,file="$TEST_IMG.2" -global isa-fdc.driveB=none0
 
 echo
 echo
 echo === Mixing -fdX and -device ===
 
 # Working
-check_floppy_qtree -fda "$TEST_IMG" -drive if=none,file="$TEST_IMG" -device floppy,drive=none0
-check_floppy_qtree -fda "$TEST_IMG" -drive if=none,file="$TEST_IMG" -device floppy,drive=none0,unit=1
+check_floppy_qtree -fda "$TEST_IMG" -drive if=none,file="$TEST_IMG.2" -device floppy,drive=none0
+check_floppy_qtree -fda "$TEST_IMG" -drive if=none,file="$TEST_IMG.2" -device floppy,drive=none0,unit=1
 
-check_floppy_qtree -fdb "$TEST_IMG" -drive if=none,file="$TEST_IMG" -device floppy,drive=none0
-check_floppy_qtree -fdb "$TEST_IMG" -drive if=none,file="$TEST_IMG" -device floppy,drive=none0,unit=0
+check_floppy_qtree -fdb "$TEST_IMG" -drive if=none,file="$TEST_IMG.2" -device floppy,drive=none0
+check_floppy_qtree -fdb "$TEST_IMG" -drive if=none,file="$TEST_IMG.2" -device floppy,drive=none0,unit=0
 
 # Conflicting
-check_floppy_qtree -fda "$TEST_IMG" -drive if=none,file="$TEST_IMG" -device floppy,drive=none0,unit=0
-check_floppy_qtree -fdb "$TEST_IMG" -drive if=none,file="$TEST_IMG" -device floppy,drive=none0,unit=1
+check_floppy_qtree -fda "$TEST_IMG" -drive if=none,file="$TEST_IMG.2" -device floppy,drive=none0,unit=0
+check_floppy_qtree -fdb "$TEST_IMG" -drive if=none,file="$TEST_IMG.2" -device floppy,drive=none0,unit=1
 
 echo
 echo
 echo === Mixing -drive and -device ===
 
 # Working
-check_floppy_qtree -drive if=floppy,file="$TEST_IMG" -drive if=none,file="$TEST_IMG" -device floppy,drive=none0
-check_floppy_qtree -drive if=floppy,file="$TEST_IMG" -drive if=none,file="$TEST_IMG" -device floppy,drive=none0,unit=1
+check_floppy_qtree -drive if=floppy,file="$TEST_IMG" -drive if=none,file="$TEST_IMG.2" -device floppy,drive=none0
+check_floppy_qtree -drive if=floppy,file="$TEST_IMG" -drive if=none,file="$TEST_IMG.2" -device floppy,drive=none0,unit=1
 
 # Conflicting
-check_floppy_qtree -drive if=floppy,file="$TEST_IMG" -drive if=none,file="$TEST_IMG" -device floppy,drive=none0,unit=0
+check_floppy_qtree -drive if=floppy,file="$TEST_IMG" -drive if=none,file="$TEST_IMG.2" -device floppy,drive=none0,unit=0
 
 echo
 echo
 echo === Mixing -global and -device ===
 
 # Working
-check_floppy_qtree -drive if=none,file="$TEST_IMG" -drive if=none,file="$TEST_IMG" \
+check_floppy_qtree -drive if=none,file="$TEST_IMG" -drive if=none,file="$TEST_IMG.2" \
                    -global isa-fdc.driveA=none0 -device floppy,drive=none1
-check_floppy_qtree -drive if=none,file="$TEST_IMG" -drive if=none,file="$TEST_IMG" \
+check_floppy_qtree -drive if=none,file="$TEST_IMG" -drive if=none,file="$TEST_IMG.2" \
                    -global isa-fdc.driveA=none0 -device floppy,drive=none1,unit=1
 
-check_floppy_qtree -drive if=none,file="$TEST_IMG" -drive if=none,file="$TEST_IMG" \
+check_floppy_qtree -drive if=none,file="$TEST_IMG" -drive if=none,file="$TEST_IMG.2" \
                    -global isa-fdc.driveB=none0 -device floppy,drive=none1
-check_floppy_qtree -drive if=none,file="$TEST_IMG" -drive if=none,file="$TEST_IMG" \
+check_floppy_qtree -drive if=none,file="$TEST_IMG" -drive if=none,file="$TEST_IMG.2" \
                    -global isa-fdc.driveB=none0 -device floppy,drive=none1,unit=0
 
 # Conflicting
-check_floppy_qtree -drive if=none,file="$TEST_IMG" -drive if=none,file="$TEST_IMG" \
+check_floppy_qtree -drive if=none,file="$TEST_IMG" -drive if=none,file="$TEST_IMG.2" \
                    -global isa-fdc.driveA=none0 -device floppy,drive=none1,unit=0
-check_floppy_qtree -drive if=none,file="$TEST_IMG" -drive if=none,file="$TEST_IMG" \
+check_floppy_qtree -drive if=none,file="$TEST_IMG" -drive if=none,file="$TEST_IMG.2" \
                    -global isa-fdc.driveB=none0 -device floppy,drive=none1,unit=1
 
 echo
@@ -199,8 +204,8 @@ echo === Too many floppy drives ===
 
 # Working
 check_floppy_qtree -drive if=floppy,file="$TEST_IMG" \
-                   -drive if=none,file="$TEST_IMG" \
-                   -drive if=none,file="$TEST_IMG" \
+                   -drive if=none,file="$TEST_IMG.2" \
+                   -drive if=none,file="$TEST_IMG.3" \
                    -global isa-fdc.driveB=none0 \
                    -device floppy,drive=none1
 
diff --git a/tests/qemu-iotests/172.out b/tests/qemu-iotests/172.out
index 54b5329..2732966 100644
--- a/tests/qemu-iotests/172.out
+++ b/tests/qemu-iotests/172.out
@@ -1,5 +1,7 @@
 QA output created by 172
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=737280
+Formatting 'TEST_DIR/t.IMGFMT.2', fmt=IMGFMT size=737280
+Formatting 'TEST_DIR/t.IMGFMT.3', fmt=IMGFMT size=737280
 
 
 === Default ===
@@ -99,7 +101,7 @@ Testing: -fdb TEST_DIR/t.qcow2
                 share-rw = false
                 drive-type = "288"
 
-Testing: -fda TEST_DIR/t.qcow2 -fdb TEST_DIR/t.qcow2
+Testing: -fda TEST_DIR/t.qcow2 -fdb TEST_DIR/t.qcow2.2
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -205,7 +207,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2,index=1
                 share-rw = false
                 drive-type = "288"
 
-Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=floppy,file=TEST_DIR/t.qcow2,index=1
+Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=floppy,file=TEST_DIR/t.qcow2.2,index=1
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -300,7 +302,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveB=none0
                 share-rw = false
                 drive-type = "144"
 
-Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveA=none0 -global isa-fdc.driveB=none1
+Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveA=none0 -global isa-fdc.driveB=none1
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -395,7 +397,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,unit=1
                 share-rw = false
                 drive-type = "144"
 
-Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0 -device floppy,drive=none1,unit=1
+Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device floppy,drive=none0 -device floppy,drive=none1,unit=1
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -436,7 +438,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
 
 === Mixing -fdX and -global ===
 
-Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveB=none0
+Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveB=none0
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -474,7 +476,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-
                 share-rw = false
                 drive-type = "144"
 
-Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveA=none0
+Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveA=none0
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -512,7 +514,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-
                 share-rw = false
                 drive-type = "144"
 
-Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveA=none0
+Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveA=none0
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -539,7 +541,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-
                 share-rw = false
                 drive-type = "144"
 
-Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveB=none0
+Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveB=none0
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -569,7 +571,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-
 
 === Mixing -fdX and -device ===
 
-Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0
+Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device floppy,drive=none0
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -607,7 +609,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device flop
                 share-rw = false
                 drive-type = "144"
 
-Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,unit=1
+Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device floppy,drive=none0,unit=1
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -645,7 +647,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device flop
                 share-rw = false
                 drive-type = "144"
 
-Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0
+Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device floppy,drive=none0
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -683,7 +685,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device flop
                 share-rw = false
                 drive-type = "144"
 
-Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,unit=0
+Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device floppy,drive=none0,unit=0
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -721,18 +723,18 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device flop
                 share-rw = false
                 drive-type = "144"
 
-Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,unit=0
+Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device floppy,drive=none0,unit=0
 QEMU_PROG: -device floppy,drive=none0,unit=0: Floppy unit 0 is in use
 QEMU_PROG: -device floppy,drive=none0,unit=0: Device initialization failed.
 
-Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,unit=1
+Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device floppy,drive=none0,unit=1
 QEMU_PROG: -device floppy,drive=none0,unit=1: Floppy unit 1 is in use
 QEMU_PROG: -device floppy,drive=none0,unit=1: Device initialization failed.
 
 
 === Mixing -drive and -device ===
 
-Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0
+Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device floppy,drive=none0
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -770,7 +772,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 share-rw = false
                 drive-type = "144"
 
-Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,unit=1
+Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device floppy,drive=none0,unit=1
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -808,14 +810,14 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 share-rw = false
                 drive-type = "144"
 
-Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,unit=0
+Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device floppy,drive=none0,unit=0
 QEMU_PROG: -device floppy,drive=none0,unit=0: Floppy unit 0 is in use
 QEMU_PROG: -device floppy,drive=none0,unit=0: Device initialization failed.
 
 
 === Mixing -global and -device ===
 
-Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveA=none0 -device floppy,drive=none1
+Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveA=none0 -device floppy,drive=none1
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -853,7 +855,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 share-rw = false
                 drive-type = "144"
 
-Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveA=none0 -device floppy,drive=none1,unit=1
+Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveA=none0 -device floppy,drive=none1,unit=1
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -891,7 +893,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 share-rw = false
                 drive-type = "144"
 
-Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveB=none0 -device floppy,drive=none1
+Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveB=none0 -device floppy,drive=none1
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -929,7 +931,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 share-rw = false
                 drive-type = "144"
 
-Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveB=none0 -device floppy,drive=none1,unit=0
+Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveB=none0 -device floppy,drive=none1,unit=0
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -967,18 +969,18 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 share-rw = false
                 drive-type = "144"
 
-Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveA=none0 -device floppy,drive=none1,unit=0
+Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveA=none0 -device floppy,drive=none1,unit=0
 QEMU_PROG: -device floppy,drive=none1,unit=0: Floppy unit 0 is in use
 QEMU_PROG: -device floppy,drive=none1,unit=0: Device initialization failed.
 
-Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveB=none0 -device floppy,drive=none1,unit=1
+Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveB=none0 -device floppy,drive=none1,unit=1
 QEMU_PROG: -device floppy,drive=none1,unit=1: Floppy unit 1 is in use
 QEMU_PROG: -device floppy,drive=none1,unit=1: Device initialization failed.
 
 
 === Too many floppy drives ===
 
-Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveB=none0 -device floppy,drive=none1
+Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -drive if=none,file=TEST_DIR/t.qcow2.3 -global isa-fdc.driveB=none0 -device floppy,drive=none1
 QEMU_PROG: -device floppy,drive=none1: Can't create floppy unit 2, bus supports only 2 units
 QEMU_PROG: -device floppy,drive=none1: Device initialization failed.
 
-- 
2.9.3
