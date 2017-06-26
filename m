Received: from eggs.gnu.org ([2001:4830:134:3::10]:40010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPTEm-0007Mx-OY
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 08:35:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPTEl-0001WW-BN
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 08:35:28 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 26 Jun 2017 13:35:07 +0100
Message-Id: <20170626123510.20134-3-berrange@redhat.com>
In-Reply-To: <20170626123510.20134-1-berrange@redhat.com>
References: <20170626123510.20134-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v6 2/5] iotests: fix remainining tests to work
 with LUKS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The tests 033, 140, 145 and 157 were all broken
when run with LUKS, since they did not correctly use
the required image opts args syntax to specify the
decryption secret. Further, the 120 test simply does
not make sense to run with luks, as the scenario
exercised is not relevant.

The test 181 was broken when run with LUKS because
it didn't take account of fact that $TEST_IMG was
already in image opts syntax. The launch_qemu
helper also didn't register the secret object
providing the LUKS password.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/qemu-iotests/033         | 12 ++++++++++--
 tests/qemu-iotests/120         |  1 +
 tests/qemu-iotests/140         |  9 ++++++++-
 tests/qemu-iotests/145         | 19 +++++++++++++++++--
 tests/qemu-iotests/157         | 17 ++++++++++++++---
 tests/qemu-iotests/157.out     | 16 ++++++++--------
 tests/qemu-iotests/174         |  2 +-
 tests/qemu-iotests/181         | 21 ++++++++++++++++-----
 tests/qemu-iotests/common.qemu |  9 +++++++--
 9 files changed, 82 insertions(+), 24 deletions(-)

diff --git a/tests/qemu-iotests/033 b/tests/qemu-iotests/033
index 16edcf2..2cdfd13 100755
--- a/tests/qemu-iotests/033
+++ b/tests/qemu-iotests/033
@@ -50,10 +50,18 @@ do_test()
 	local align=$1
 	local iocmd=$2
 	local img=$3
+	if [ "$IMGOPTSSYNTAX" = "true" ]
+	then
+	    IO_OPEN_ARG="$img"
+	    IO_EXTRA_ARGS="--image-opts"
+	else
+	    IO_OPEN_ARG="-o driver=$IMGFMT,file.align=$align blkdebug::$img"
+	    IO_EXTRA_ARGS=""
+	fi
 	{
-		echo "open -o driver=$IMGFMT,file.align=$align blkdebug::$img"
+		echo "open $IO_OPEN_ARG"
 		echo $iocmd
-	} | $QEMU_IO
+	} | $QEMU_IO $IO_EXTRA_ARGS
 }
 
 for write_zero_cmd in "write -z" "aio_write -z"; do
diff --git a/tests/qemu-iotests/120 b/tests/qemu-iotests/120
index 4f88a67..f40b97d 100755
--- a/tests/qemu-iotests/120
+++ b/tests/qemu-iotests/120
@@ -41,6 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt generic
 _supported_proto file
 _supported_os Linux
+_unsupported_fmt luks
 
 _make_test_img 64M
 
diff --git a/tests/qemu-iotests/140 b/tests/qemu-iotests/140
index 8c80a5a..f89d0d6 100755
--- a/tests/qemu-iotests/140
+++ b/tests/qemu-iotests/140
@@ -52,8 +52,15 @@ _make_test_img 64k
 
 $QEMU_IO -c 'write -P 42 0 64k' "$TEST_IMG" | _filter_qemu_io
 
+if test "$IMGOPTSSYNTAX" = "true"
+then
+    SYSEMU_DRIVE_ARG=if=none,media=cdrom,id=drv,"$TEST_IMG"
+else
+    SYSEMU_DRIVE_ARG=if=none,media=cdrom,id=drv,file="$TEST_IMG",driver=$IMGFMT
+fi
+
 keep_stderr=y \
-_launch_qemu -drive if=none,media=cdrom,id=drv,file="$TEST_IMG",format=$IMGFMT \
+_launch_qemu -drive $SYSEMU_DRIVE_ARG \
     2> >(_filter_nbd)
 
 _send_qemu_cmd $QEMU_HANDLE \
diff --git a/tests/qemu-iotests/145 b/tests/qemu-iotests/145
index e6c6bc4..c371b3c 100755
--- a/tests/qemu-iotests/145
+++ b/tests/qemu-iotests/145
@@ -43,8 +43,23 @@ _supported_proto generic
 _supported_os Linux
 
 _make_test_img 1M
-echo quit | $QEMU -nographic -hda "$TEST_IMG" -incoming 'exec:true' -snapshot -serial none -monitor stdio |
-    _filter_qemu | _filter_hmp
+
+if test "$IMGOPTSSYNTAX" = "true"
+then
+    SYSEMU_DRIVE_ARG=if=none,$TEST_IMG
+    SYSEMU_EXTRA_ARGS=""
+    if [ -n "$IMGKEYSECRET" ]; then
+        SECRET_ARG="secret,id=keysec0,data=$IMGKEYSECRET"
+        SYSEMU_EXTRA_ARGS="-object $SECRET_ARG"
+    fi
+else
+    SYSEMU_DRIVE_ARG=if=none,file="$TEST_IMG",driver=$IMGFMT
+    SYSEMU_EXTRA_ARGS=""
+fi
+
+echo quit | $QEMU -nographic $SYSEMU_EXTRA_ARGS -drive $SYSEMU_DRIVE_ARG \
+                  -incoming 'exec:true' -snapshot -serial none -monitor stdio \
+          | _filter_qemu | _filter_hmp
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/157 b/tests/qemu-iotests/157
index 8d939cb..2bf02be 100755
--- a/tests/qemu-iotests/157
+++ b/tests/qemu-iotests/157
@@ -43,7 +43,6 @@ _supported_os Linux
 
 function do_run_qemu()
 {
-    echo Testing: "$@"
     (
         if ! test -t 0; then
             while read cmd; do
@@ -63,7 +62,18 @@ function run_qemu()
 
 
 size=128M
-drive="if=none,file=$TEST_IMG,driver=$IMGFMT"
+if test "$IMGOPTSSYNTAX" = "true"
+then
+    SYSEMU_DRIVE_ARG=if=none,$TEST_IMG
+    SYSEMU_EXTRA_ARGS=""
+    if [ -n "$IMGKEYSECRET" ]; then
+        SECRET_ARG="secret,id=keysec0,data=$IMGKEYSECRET"
+        SYSEMU_EXTRA_ARGS="-object $SECRET_ARG"
+    fi
+else
+    SYSEMU_DRIVE_ARG=if=none,file="$TEST_IMG",driver=$IMGFMT
+    SYSEMU_EXTRA_ARGS=""
+fi
 
 _make_test_img $size
 
@@ -76,8 +86,9 @@ echo
 
 for cache in "writeback" "writethrough"; do
     for wce in "" ",write-cache=auto" ",write-cache=on" ",write-cache=off"; do
+        echo "Testing: cache='$cache' wce='$wce'"
         echo "info block" \
-            | run_qemu -drive "$drive,cache=$cache" \
+            | run_qemu $SYSEMU_EXTRA_ARGS -drive "$SYSEMU_DRIVE_ARG,cache=$cache" \
                        -device "virtio-blk,drive=none0$wce" \
             | grep -e "Testing" -e "Cache mode"
     done
diff --git a/tests/qemu-iotests/157.out b/tests/qemu-iotests/157.out
index 77a9c03..fdc807f 100644
--- a/tests/qemu-iotests/157.out
+++ b/tests/qemu-iotests/157.out
@@ -3,20 +3,20 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 
 === Setting WCE with qdev and with manually created BB ===
 
-Testing: -drive if=none,file=TEST_DIR/t.IMGFMT,driver=IMGFMT,cache=writeback -device virtio-blk,drive=none0
+Testing: cache='writeback' wce=''
     Cache mode:       writeback
-Testing: -drive if=none,file=TEST_DIR/t.IMGFMT,driver=IMGFMT,cache=writeback -device virtio-blk,drive=none0,write-cache=auto
+Testing: cache='writeback' wce=',write-cache=auto'
     Cache mode:       writeback
-Testing: -drive if=none,file=TEST_DIR/t.IMGFMT,driver=IMGFMT,cache=writeback -device virtio-blk,drive=none0,write-cache=on
+Testing: cache='writeback' wce=',write-cache=on'
     Cache mode:       writeback
-Testing: -drive if=none,file=TEST_DIR/t.IMGFMT,driver=IMGFMT,cache=writeback -device virtio-blk,drive=none0,write-cache=off
+Testing: cache='writeback' wce=',write-cache=off'
     Cache mode:       writethrough
-Testing: -drive if=none,file=TEST_DIR/t.IMGFMT,driver=IMGFMT,cache=writethrough -device virtio-blk,drive=none0
+Testing: cache='writethrough' wce=''
     Cache mode:       writethrough
-Testing: -drive if=none,file=TEST_DIR/t.IMGFMT,driver=IMGFMT,cache=writethrough -device virtio-blk,drive=none0,write-cache=auto
+Testing: cache='writethrough' wce=',write-cache=auto'
     Cache mode:       writethrough
-Testing: -drive if=none,file=TEST_DIR/t.IMGFMT,driver=IMGFMT,cache=writethrough -device virtio-blk,drive=none0,write-cache=on
+Testing: cache='writethrough' wce=',write-cache=on'
     Cache mode:       writeback
-Testing: -drive if=none,file=TEST_DIR/t.IMGFMT,driver=IMGFMT,cache=writethrough -device virtio-blk,drive=none0,write-cache=off
+Testing: cache='writethrough' wce=',write-cache=off'
     Cache mode:       writethrough
 *** done
diff --git a/tests/qemu-iotests/174 b/tests/qemu-iotests/174
index c1c20a1..552879d 100755
--- a/tests/qemu-iotests/174
+++ b/tests/qemu-iotests/174
@@ -41,7 +41,7 @@ _unsupported_fmt raw
 
 
 size=256K
-IMGFMT=raw IMGOPTS= _make_test_img $size | _filter_imgfmt
+IMGFMT=raw IMGKEYSECRET= IMGOPTS= _make_test_img $size | _filter_imgfmt
 
 echo
 echo "== reading wrong format should fail =="
diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
index e969a2a..b667ea0 100755
--- a/tests/qemu-iotests/181
+++ b/tests/qemu-iotests/181
@@ -55,13 +55,24 @@ echo
 
 qemu_comm_method="monitor"
 
-_launch_qemu \
-    -drive file="${TEST_IMG}",cache=${CACHEMODE},driver=$IMGFMT,id=disk
+if [ "$IMGOPTSSYNTAX" = "true" ]; then
+    _launch_qemu \
+        -drive "${TEST_IMG}",cache=${CACHEMODE},id=disk
+else
+    _launch_qemu \
+        -drive file="${TEST_IMG}",cache=${CACHEMODE},driver=$IMGFMT,id=disk
+fi
 src=$QEMU_HANDLE
 
-_launch_qemu \
-    -drive file="${TEST_IMG}",cache=${CACHEMODE},driver=$IMGFMT,id=disk \
-    -incoming "unix:${MIG_SOCKET}"
+if [ "$IMGOPTSSYNTAX" = "true" ]; then
+    _launch_qemu \
+        -drive "${TEST_IMG}",cache=${CACHEMODE},id=disk \
+        -incoming "unix:${MIG_SOCKET}"
+else
+    _launch_qemu \
+        -drive file="${TEST_IMG}",cache=${CACHEMODE},driver=$IMGFMT,id=disk \
+        -incoming "unix:${MIG_SOCKET}"
+fi
 dest=$QEMU_HANDLE
 
 echo
diff --git a/tests/qemu-iotests/common.qemu b/tests/qemu-iotests/common.qemu
index 76ef298..7645f1d 100644
--- a/tests/qemu-iotests/common.qemu
+++ b/tests/qemu-iotests/common.qemu
@@ -153,14 +153,19 @@ function _launch_qemu()
     mkfifo "${fifo_out}"
     mkfifo "${fifo_in}"
 
+    object_options=
+    if [ -n "$IMGKEYSECRET" ]; then
+        object_options="--object secret,id=keysec0,data=$IMGKEYSECRET"
+    fi
+
     if [ -z "$keep_stderr" ]; then
         QEMU_NEED_PID='y'\
-        ${QEMU} -nographic -serial none ${comm} "${@}" >"${fifo_out}" \
+        ${QEMU} ${object_options} -nographic -serial none ${comm} "${@}" >"${fifo_out}" \
                                                        2>&1 \
                                                        <"${fifo_in}" &
     elif [ "$keep_stderr" = "y" ]; then
         QEMU_NEED_PID='y'\
-        ${QEMU} -nographic -serial none ${comm} "${@}" >"${fifo_out}" \
+        ${QEMU} ${object_options} -nographic -serial none ${comm} "${@}" >"${fifo_out}" \
                                                        <"${fifo_in}" &
     else
         exit 1
-- 
2.9.3
