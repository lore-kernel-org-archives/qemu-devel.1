Received: from eggs.gnu.org ([2001:4830:134:3::10]:46039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVzjh-0003F6-2m
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:58:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVzjf-0005Sm-Jv
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:58:05 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 24 Jan 2017 11:57:45 +0000
Message-Id: <20170124115748.21473-3-berrange@redhat.com>
In-Reply-To: <20170124115748.21473-1-berrange@redhat.com>
References: <20170124115748.21473-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/5] iotests: fix remainining tests to work
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
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The tests 033, 120, 140, 145 and 157 were all broken
when run with LUKS, since they did not correctly use
the required image opts args syntax to specify the
decryption secret.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/qemu-iotests/033     | 16 ++++++++++++----
 tests/qemu-iotests/120     | 25 ++++++++++++++++++++++---
 tests/qemu-iotests/140     | 15 ++++++++++++++-
 tests/qemu-iotests/145     | 18 +++++++++++++++++-
 tests/qemu-iotests/157     | 17 ++++++++++++++---
 tests/qemu-iotests/157.out | 16 ++++++++--------
 6 files changed, 87 insertions(+), 20 deletions(-)

diff --git a/tests/qemu-iotests/033 b/tests/qemu-iotests/033
index 16edcf2..b690b0e 100755
--- a/tests/qemu-iotests/033
+++ b/tests/qemu-iotests/033
@@ -50,14 +50,22 @@ do_test()
 	local align=$1
 	local iocmd=$2
 	local img=$3
+	if test "$IMGOPTSSYNTAX" = "true"
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
-for align in 512 4k; do
+    for align in 512 4k; do
 	echo
 	echo "== preparing image =="
 	do_test $align "write -P 0xa 0x200 0x400" "$TEST_IMG" | _filter_qemu_io
@@ -91,7 +99,7 @@ for align in 512 4k; do
 	do_test $align "read -P 0xb 0x400 0xc00" "$TEST_IMG" | _filter_qemu_io
 
 	echo
-done
+    done
 done
 
 # success, all done
diff --git a/tests/qemu-iotests/120 b/tests/qemu-iotests/120
index 4f88a67..5f80517 100755
--- a/tests/qemu-iotests/120
+++ b/tests/qemu-iotests/120
@@ -44,17 +44,36 @@ _supported_os Linux
 
 _make_test_img 64M
 
+if test "$IMGOPTSSYNTAX" = "true"
+then
+    SYSEMU_DRIVE_ARG=id=drv,if=none,$TEST_IMG
+    SYSEMU_EXTRA_ARGS=""
+    IO_DRIVE_ARG="$TEST_IMG"
+    IO_EXTRA_ARGS="--image-opts"
+    if [ -n "$IMGKEYSECRET" ]; then
+	SECRET_ARG="secret,id=keysec0,data=$IMGKEYSECRET"
+	SYSEMU_EXTRA_ARGS="$SYSEMU_EXTRA_ARGS -object $SECRET_ARG"
+	IO_EXTRA_ARGS="$IO_EXTRA_ARGS --object $SECRET_ARG"
+    fi
+else
+    SYSEMU_DRIVE_ARG=id=drv,if=none,file="$TEST_IMG",driver=raw,file.driver=$IMGFMT
+    SYSEMU_EXTRA_ARGS=""
+    IO_DRIVE_ARG="json:{'driver': 'raw', 'file': {'driver': '$IMGFMT', 'file': {'filename': '$TEST_IMG'}}}"
+    IO_EXTRA_ARGS=""
+fi
+
+
 echo "{'execute': 'qmp_capabilities'}
       {'execute': 'human-monitor-command',
        'arguments': {'command-line': 'qemu-io drv \"write -P 42 0 64k\"'}}
       {'execute': 'quit'}" \
-    | $QEMU -qmp stdio -nographic -nodefaults \
-            -drive id=drv,if=none,file="$TEST_IMG",driver=raw,file.driver=$IMGFMT \
+    | $QEMU -qmp stdio -nographic -nodefaults $SYSEMU_EXTRA_ARGS \
+            -drive $SYSEMU_DRIVE_ARG \
     | _filter_qmp | _filter_qemu_io
 $QEMU_IO -c 'read -P 42 0 64k' "$TEST_IMG" | _filter_qemu_io
 
 $QEMU_IO_PROG -c 'read -P 42 0 64k' \
-    "json:{'driver': 'raw', 'file': {'driver': '$IMGFMT', 'file': {'filename': '$TEST_IMG'}}}" \
+    $IO_EXTRA_ARGS "$IO_DRIVE_ARG" \
     | _filter_qemu_io
 
 # success, all done
diff --git a/tests/qemu-iotests/140 b/tests/qemu-iotests/140
index 49f9df4..afaa418 100755
--- a/tests/qemu-iotests/140
+++ b/tests/qemu-iotests/140
@@ -51,8 +51,21 @@ _make_test_img 64k
 
 $QEMU_IO -c 'write -P 42 0 64k' "$TEST_IMG" | _filter_qemu_io
 
+if test "$IMGOPTSSYNTAX" = "true"
+then
+    SYSEMU_DRIVE_ARG=if=none,media=cdrom,id=drv,$TEST_IMG
+    SYSEMU_EXTRA_ARGS=""
+    if [ -n "$IMGKEYSECRET" ]; then
+	SECRET_ARG="secret,id=keysec0,data=$IMGKEYSECRET"
+	SYSEMU_EXTRA_ARGS="-object $SECRET_ARG"
+    fi
+else
+    SYSEMU_DRIVE_ARG=if=none,media=cdrom,id=drv,file="$TEST_IMG",driver=raw,file.driver=$IMGFMT
+    SYSEMU_EXTRA_ARGS=""
+fi
+
 keep_stderr=y \
-_launch_qemu -drive if=none,media=cdrom,id=drv,file="$TEST_IMG",format=$IMGFMT \
+_launch_qemu $SYSEMU_EXTRA_ARGS -drive $SYSEMU_DRIVE_ARG \
     2> >(_filter_nbd)
 
 _send_qemu_cmd $QEMU_HANDLE \
diff --git a/tests/qemu-iotests/145 b/tests/qemu-iotests/145
index 1eca0e8..ab54972 100755
--- a/tests/qemu-iotests/145
+++ b/tests/qemu-iotests/145
@@ -43,7 +43,23 @@ _supported_proto generic
 _supported_os Linux
 
 _make_test_img 1M
-echo quit | $QEMU -nographic -hda "$TEST_IMG" -incoming 'exec:true' -snapshot -serial none -monitor stdio | _filter_qemu
+
+if test "$IMGOPTSSYNTAX" = "true"
+then
+    SYSEMU_DRIVE_ARG=if=none,$TEST_IMG
+    SYSEMU_EXTRA_ARGS=""
+    if [ -n "$IMGKEYSECRET" ]; then
+	SECRET_ARG="secret,id=keysec0,data=$IMGKEYSECRET"
+	SYSEMU_EXTRA_ARGS="-object $SECRET_ARG"
+    fi
+else
+    SYSEMU_DRIVE_ARG=if=none,file="$TEST_IMG",driver=raw,file.driver=$IMGFMT
+    SYSEMU_EXTRA_ARGS=""
+fi
+
+echo quit | $QEMU -nographic $SYSEMU_EXTRA_ARGS  -drive $SYSEMU_DRIVE_ARG \
+                  -incoming 'exec:true' -snapshot -serial none -monitor stdio \
+          | _filter_qemu
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/157 b/tests/qemu-iotests/157
index 8d939cb..9ba1720 100755
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
+	SECRET_ARG="secret,id=keysec0,data=$IMGKEYSECRET"
+	SYSEMU_EXTRA_ARGS="-object $SECRET_ARG"
+    fi
+else
+    SYSEMU_DRIVE_ARG=if=none,file="$TEST_IMG",driver=raw,file.driver=$IMGFMT
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
-- 
2.9.3
