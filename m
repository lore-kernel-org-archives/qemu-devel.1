Received: from eggs.gnu.org ([2001:4830:134:3::10]:41482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cVdnv-0004r1-SV
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:33:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cVdnt-0006FL-Fb
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:32:59 -0500
From: Fam Zheng <famz@redhat.com>
Date: Mon, 23 Jan 2017 20:30:51 +0800
Message-Id: <20170123123056.30383-12-famz@redhat.com>
In-Reply-To: <20170123123056.30383-1-famz@redhat.com>
References: <20170123123056.30383-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v12 11/16] iotests: 172: Use separate images
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com, Max Reitz <mreitz@redhat.com>

To avoid image lock failures.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/qemu-iotests/172     | 53 ++++++++++++++++++++++++----------------------
 tests/qemu-iotests/172.out | 50 ++++++++++++++++++++++---------------------
 2 files changed, 54 insertions(+), 49 deletions(-)

diff --git a/tests/qemu-iotests/172 b/tests/qemu-iotests/172
index 1b7d3a1..f9d4cff 100755
--- a/tests/qemu-iotests/172
+++ b/tests/qemu-iotests/172
@@ -86,6 +86,9 @@ size=720k
 
 _make_test_img $size
 
+TEST_IMG="$TEST_IMG.2" _make_test_img $size
+TEST_IMG="$TEST_IMG.3" _make_test_img $size
+
 # Default drive semantics:
 #
 # By default you get a single empty floppy drive. You can override it with
@@ -105,7 +108,7 @@ echo === Using -fda/-fdb options ===
 
 check_floppy_qtree -fda "$TEST_IMG"
 check_floppy_qtree -fdb "$TEST_IMG"
-check_floppy_qtree -fda "$TEST_IMG" -fdb "$TEST_IMG"
+check_floppy_qtree -fda "$TEST_IMG" -fdb "$TEST_IMG.2"
 
 
 echo
@@ -114,7 +117,7 @@ echo === Using -drive options ===
 
 check_floppy_qtree -drive if=floppy,file="$TEST_IMG"
 check_floppy_qtree -drive if=floppy,file="$TEST_IMG",index=1
-check_floppy_qtree -drive if=floppy,file="$TEST_IMG" -drive if=floppy,file="$TEST_IMG",index=1
+check_floppy_qtree -drive if=floppy,file="$TEST_IMG" -drive if=floppy,file="$TEST_IMG.2",index=1
 
 echo
 echo
@@ -122,7 +125,7 @@ echo === Using -drive if=none and -global ===
 
 check_floppy_qtree -drive if=none,file="$TEST_IMG" -global isa-fdc.driveA=none0
 check_floppy_qtree -drive if=none,file="$TEST_IMG" -global isa-fdc.driveB=none0
-check_floppy_qtree -drive if=none,file="$TEST_IMG" -drive if=none,file="$TEST_IMG" \
+check_floppy_qtree -drive if=none,file="$TEST_IMG" -drive if=none,file="$TEST_IMG.2" \
                    -global isa-fdc.driveA=none0 -global isa-fdc.driveB=none1
 
 echo
@@ -131,7 +134,7 @@ echo === Using -drive if=none and -device ===
 
 check_floppy_qtree -drive if=none,file="$TEST_IMG" -device floppy,drive=none0
 check_floppy_qtree -drive if=none,file="$TEST_IMG" -device floppy,drive=none0,unit=1
-check_floppy_qtree -drive if=none,file="$TEST_IMG" -drive if=none,file="$TEST_IMG" \
+check_floppy_qtree -drive if=none,file="$TEST_IMG",file.disable-lock=on -drive if=none,file="$TEST_IMG.2" \
                    -device floppy,drive=none0 -device floppy,drive=none1,unit=1
 
 echo
@@ -139,58 +142,58 @@ echo
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
@@ -199,8 +202,8 @@ echo === Too many floppy drives ===
 
 # Working
 check_floppy_qtree -drive if=floppy,file="$TEST_IMG" \
-                   -drive if=none,file="$TEST_IMG" \
-                   -drive if=none,file="$TEST_IMG" \
+                   -drive if=none,file="$TEST_IMG.2" \
+                   -drive if=none,file="$TEST_IMG.3" \
                    -global isa-fdc.driveB=none0 \
                    -device floppy,drive=none1
 
diff --git a/tests/qemu-iotests/172.out b/tests/qemu-iotests/172.out
index 6b7edaf..7f557ac 100644
--- a/tests/qemu-iotests/172.out
+++ b/tests/qemu-iotests/172.out
@@ -1,5 +1,7 @@
 QA output created by 172
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=737280
+Formatting 'TEST_DIR/t.IMGFMT.2', fmt=IMGFMT size=737280
+Formatting 'TEST_DIR/t.IMGFMT.3', fmt=IMGFMT size=737280
 
 
 === Default ===
@@ -95,7 +97,7 @@ Testing: -fdb TEST_DIR/t.qcow2
                 write-cache = "auto"
                 drive-type = "288"
 
-Testing: -fda TEST_DIR/t.qcow2 -fdb TEST_DIR/t.qcow2
+Testing: -fda TEST_DIR/t.qcow2 -fdb TEST_DIR/t.qcow2.2
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -196,7 +198,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2,index=1
                 write-cache = "auto"
                 drive-type = "288"
 
-Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=floppy,file=TEST_DIR/t.qcow2,index=1
+Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=floppy,file=TEST_DIR/t.qcow2.2,index=1
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -287,7 +289,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveB=none0
                 write-cache = "auto"
                 drive-type = "144"
 
-Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveA=none0 -global isa-fdc.driveB=none1
+Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveA=none0 -global isa-fdc.driveB=none1
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -378,7 +380,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,unit=1
                 write-cache = "auto"
                 drive-type = "144"
 
-Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0 -device floppy,drive=none1,unit=1
+Testing: -drive if=none,file=TEST_DIR/t.qcow2,file.disable-lock=on -drive if=none,file=TEST_DIR/t.qcow2.2 -device floppy,drive=none0 -device floppy,drive=none1,unit=1
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -417,7 +419,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
 
 === Mixing -fdX and -global ===
 
-Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveB=none0
+Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveB=none0
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -453,7 +455,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-
                 write-cache = "auto"
                 drive-type = "144"
 
-Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveA=none0
+Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveA=none0
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -489,7 +491,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-
                 write-cache = "auto"
                 drive-type = "144"
 
-Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveA=none0
+Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveA=none0
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -515,7 +517,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-
                 write-cache = "auto"
                 drive-type = "144"
 
-Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveB=none0
+Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveB=none0
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -544,7 +546,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-
 
 === Mixing -fdX and -device ===
 
-Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0
+Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device floppy,drive=none0
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -580,7 +582,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device flop
                 write-cache = "auto"
                 drive-type = "144"
 
-Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,unit=1
+Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device floppy,drive=none0,unit=1
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -616,7 +618,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device flop
                 write-cache = "auto"
                 drive-type = "144"
 
-Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0
+Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device floppy,drive=none0
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -652,7 +654,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device flop
                 write-cache = "auto"
                 drive-type = "144"
 
-Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,unit=0
+Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device floppy,drive=none0,unit=0
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -688,18 +690,18 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device flop
                 write-cache = "auto"
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
@@ -735,7 +737,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 write-cache = "auto"
                 drive-type = "144"
 
-Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,unit=1
+Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device floppy,drive=none0,unit=1
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -771,14 +773,14 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 write-cache = "auto"
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
@@ -814,7 +816,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 write-cache = "auto"
                 drive-type = "144"
 
-Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveA=none0 -device floppy,drive=none1,unit=1
+Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveA=none0 -device floppy,drive=none1,unit=1
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -850,7 +852,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 write-cache = "auto"
                 drive-type = "144"
 
-Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveB=none0 -device floppy,drive=none1
+Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveB=none0 -device floppy,drive=none1
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -886,7 +888,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 write-cache = "auto"
                 drive-type = "144"
 
-Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveB=none0 -device floppy,drive=none1,unit=0
+Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveB=none0 -device floppy,drive=none1,unit=0
 
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
@@ -922,18 +924,18 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 write-cache = "auto"
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
