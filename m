Received: from eggs.gnu.org ([2001:4830:134:3::10]:53944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4JZJ-00019O-Re
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:33:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4JZI-0005MO-MG
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:33:29 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 17 Oct 2017 00:32:39 -0400
Message-Id: <7f6025727ff5179d68b356846d2348b43f736cc2.1508213452.git.jcody@redhat.com>
In-Reply-To: <cover.1508213452.git.jcody@redhat.com>
References: <cover.1508213452.git.jcody@redhat.com>
In-Reply-To: <cover.1508213452.git.jcody@redhat.com>
References: <cover.1508213452.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v4 03/10] qemu-iotests: automatically clean up
 bash protocol servers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com, kwolf@redhat.com, eblake@redhat.com

For bash tests, this allows 'check' to reap all launch protocol
servers / processes, after a test has finished running.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/check     | 13 +++++++
 tests/qemu-iotests/common.rc | 93 +++++++++++++++++++++++++++++---------------
 2 files changed, 75 insertions(+), 31 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index c7b9526..45fad05 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -757,6 +757,8 @@ do
         fi
         export OUTPUT_DIR=$PWD
         if $debug; then
+            # Do this in a sub-shell, so we are operating on the right
+            # TEST_DIR / QEMU_TEST_DIR
             (
             export TEST_DIR=$TEST_DIR_SEQ
             . "$source_iotests/common.config"
@@ -766,6 +768,8 @@ do
                     $run_command -d 2>&1 | tee $tmp.out
             )
         else
+            # Do this in a sub-shell, so we are operating on the right
+            # TEST_DIR / QEMU_TEST_DIR
             (
             export TEST_DIR=$TEST_DIR_SEQ
             . "$source_iotests/common.config"
@@ -837,6 +841,15 @@ do
             fi
         fi
 
+        # Do this in a sub-shell, so we are operating on the right
+        # TEST_DIR / QEMU_TEST_DIR
+        (
+        export TEST_DIR=$TEST_DIR_SEQ
+        . "$source_iotests/common.config"
+        . "$source_iotests/common.rc"
+
+        _cleanup_protocols
+        )
         rm -rf "$TEST_DIR_SEQ"
 
     fi
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 0e8a33c..a345ffd 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -101,7 +101,7 @@ _qemu_nbd_wrapper()
 _qemu_vxhs_wrapper()
 {
     (
-        echo $BASHPID > "${TEST_DIR}/qemu-vxhs.pid"
+        echo $BASHPID > "${QEMU_TEST_DIR}/qemu-vxhs.pid"
         exec "$QEMU_VXHS_PROG" $QEMU_VXHS_OPTIONS "$@"
     )
 }
@@ -248,7 +248,7 @@ _make_test_img()
 
     # Start QNIO server on image directory for vxhs protocol
     if [ $IMGPROTO = "vxhs" ]; then
-        eval "$QEMU_VXHS -d  $TEST_DIR > /dev/null &"
+        eval "$QEMU_VXHS -d  $QEMU_TEST_DIR > /dev/null &"
         sleep 1 # Wait for server to come up.
     fi
 }
@@ -264,29 +264,64 @@ _rm_test_img()
     rm -f "$img"
 }
 
+_cleanup_nbd()
+{
+    if [ -f "${QEMU_TEST_DIR}/qemu-nbd.pid" ]; then
+        local QEMU_NBD_PID
+        read QEMU_NBD_PID < "${QEMU_TEST_DIR}/qemu-nbd.pid"
+        rm -f "${QEMU_TEST_DIR}/qemu-nbd.pid"
+        kill ${QEMU_NBD_PID} >/dev/null 2>&1
+     fi
+}
+
+_cleanup_vxhs()
+{
+    if [ -f "${QEMU_TEST_DIR}/qemu-vxhs.pid" ]; then
+        local QEMU_VXHS_PID
+        read QEMU_VXHS_PID < "${QEMU_TEST_DIR}/qemu-vxhs.pid"
+        rm -f "${QEMU_TEST_DIR}/qemu-vxhs.pid"
+        kill ${QEMU_VXHS_PID} >/dev/null 2>&1
+    fi
+}
+
+_cleanup_rbd()
+{
+    rbd --no-progress rm "$QEMU_TEST_DIR/t.$IMGFMT" > /dev/null
+}
+
+_cleanup_sheepdog()
+{
+    collie vdi delete "$QEMU_TEST_DIR/t.$IMGFMT"
+}
+
+
+_cleanup_protocols()
+{
+    # Some tests (e.g. 058) start some protocols
+    # even though the protocol was not specified when running
+    # check.  If the wrappers create pidfiles, go ahead and clean
+    # up without checking $IMGPROTO.
+    _cleanup_nbd
+    _cleanup_vxhs
+
+    case "$IMGPROTO" in
+
+        rbd)
+            _cleanup_rbd
+            ;;
+
+        sheepdog)
+            _cleanup_sheepdog
+            ;;
+
+    esac
+}
+
 _cleanup_test_img()
 {
+    _cleanup_protocols
+
     case "$IMGPROTO" in
-
-        nbd)
-            if [ -f "${QEMU_TEST_DIR}/qemu-nbd.pid" ]; then
-                local QEMU_NBD_PID
-                read QEMU_NBD_PID < "${QEMU_TEST_DIR}/qemu-nbd.pid"
-                kill ${QEMU_NBD_PID}
-                rm -f "${QEMU_TEST_DIR}/qemu-nbd.pid"
-            fi
-            rm -f "$TEST_IMG_FILE"
-            ;;
-        vxhs)
-            if [ -f "${TEST_DIR}/qemu-vxhs.pid" ]; then
-                local QEMU_VXHS_PID
-                read QEMU_VXHS_PID < "${TEST_DIR}/qemu-vxhs.pid"
-                kill ${QEMU_VXHS_PID} >/dev/null 2>&1
-                rm -f "${TEST_DIR}/qemu-vxhs.pid"
-            fi
-            rm -f "$TEST_IMG_FILE"
-            ;;
-
         file)
             _rm_test_img "$TEST_DIR/t.$IMGFMT"
             _rm_test_img "$TEST_DIR/t.$IMGFMT.orig"
@@ -298,16 +333,12 @@ _cleanup_test_img()
                 TEST_IMG="$ORIG_TEST_IMG"
             fi
             ;;
-
-        rbd)
-            rbd --no-progress rm "$TEST_DIR/t.$IMGFMT" > /dev/null
-            ;;
-
-        sheepdog)
-            collie vdi delete "$TEST_DIR/t.$IMGFMT"
-            ;;
-
     esac
+
+    if [ -n "$TEST_IMG_FILE" ]
+    then
+        rm -f "$TEST_IMG_FILE"
+    fi
 }
 
 _check_test_img()
-- 
2.9.5
