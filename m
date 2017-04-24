Received: from eggs.gnu.org ([2001:4830:134:3::10]:46498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d2jWx-0001Wg-9f
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 15:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d2jWv-0002fU-QJ
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 15:20:15 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Mon, 24 Apr 2017 15:19:52 -0400
Message-Id: <20170424192002.18622-3-jcody@redhat.com>
In-Reply-To: <20170424192002.18622-1-jcody@redhat.com>
References: <20170424192002.18622-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL v2 02/12] block/vxhs.c: Add qemu-iotests for new
 block device type "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, Ashish Mittal <ashmit602@gmail.com>, Ashish Mittal <Ashish.Mittal@veritas.com>

From: Ashish Mittal <ashmit602@gmail.com>

These changes use a vxhs test server that is a part of the following
repository:
https://github.com/VeritasHyperScale/libqnio.git

Signed-off-by: Ashish Mittal <Ashish.Mittal@veritas.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
Message-id: 1491277689-24949-3-git-send-email-Ashish.Mittal@veritas.com
---
 tests/qemu-iotests/common        |  6 ++++++
 tests/qemu-iotests/common.config | 13 +++++++++++++
 tests/qemu-iotests/common.filter |  1 +
 tests/qemu-iotests/common.rc     | 19 +++++++++++++++++++
 4 files changed, 39 insertions(+)

diff --git a/tests/qemu-iotests/common b/tests/qemu-iotests/common
index 4d5650d..9c6f972 100644
--- a/tests/qemu-iotests/common
+++ b/tests/qemu-iotests/common
@@ -157,6 +157,7 @@ check options
     -ssh                test ssh
     -nfs                test nfs
     -luks               test luks
+    -vxhs               test vxhs
     -xdiff              graphical mode diff
     -nocache            use O_DIRECT on backing file
     -misalign           misalign memory allocations
@@ -260,6 +261,11 @@ testlist options
             xpand=false
             ;;
 
+        -vxhs)
+            IMGPROTO=vxhs
+            xpand=false
+            ;;
+
         -ssh)
             IMGPROTO=ssh
             xpand=false
diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/common.config
index 55527aa..c4b51b3 100644
--- a/tests/qemu-iotests/common.config
+++ b/tests/qemu-iotests/common.config
@@ -105,6 +105,10 @@ if [ -z "$QEMU_NBD_PROG" ]; then
     export QEMU_NBD_PROG="`set_prog_path qemu-nbd`"
 fi
 
+if [ -z "$QEMU_VXHS_PROG" ]; then
+    export QEMU_VXHS_PROG="`set_prog_path qnio_server`"
+fi
+
 _qemu_wrapper()
 {
     (
@@ -156,10 +160,19 @@ _qemu_nbd_wrapper()
     )
 }
 
+_qemu_vxhs_wrapper()
+{
+    (
+        echo $BASHPID > "${TEST_DIR}/qemu-vxhs.pid"
+        exec "$QEMU_VXHS_PROG" $QEMU_VXHS_OPTIONS "$@"
+    )
+}
+
 export QEMU=_qemu_wrapper
 export QEMU_IMG=_qemu_img_wrapper
 export QEMU_IO=_qemu_io_wrapper
 export QEMU_NBD=_qemu_nbd_wrapper
+export QEMU_VXHS=_qemu_vxhs_wrapper
 
 QEMU_IMG_EXTRA_ARGS=
 if [ "$IMGOPTSSYNTAX" = "true" ]; then
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index 1040013..c9a2d5c 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -122,6 +122,7 @@ _filter_img_info()
         -e "s#$TEST_DIR#TEST_DIR#g" \
         -e "s#$IMGFMT#IMGFMT#g" \
         -e 's#nbd://127.0.0.1:10810$#TEST_DIR/t.IMGFMT#g' \
+        -e 's#json.*vdisk-id.*vxhs"}}#TEST_DIR/t.IMGFMT#' \
         -e "/encrypted: yes/d" \
         -e "/cluster_size: [0-9]\\+/d" \
         -e "/table_size: [0-9]\\+/d" \
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 7d4781d..62529ee 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -85,6 +85,9 @@ else
     elif [ "$IMGPROTO" = "nfs" ]; then
         TEST_DIR="nfs://127.0.0.1/$TEST_DIR"
         TEST_IMG=$TEST_DIR/t.$IMGFMT
+    elif [ "$IMGPROTO" = "vxhs" ]; then
+        TEST_IMG_FILE=$TEST_DIR/t.$IMGFMT
+        TEST_IMG="vxhs://127.0.0.1:9999/t.$IMGFMT"
     else
         TEST_IMG=$IMGPROTO:$TEST_DIR/t.$IMGFMT
     fi
@@ -171,6 +174,12 @@ _make_test_img()
         eval "$QEMU_NBD -v -t -b 127.0.0.1 -p 10810 -f $IMGFMT  $TEST_IMG_FILE >/dev/null &"
         sleep 1 # FIXME: qemu-nbd needs to be listening before we continue
     fi
+
+    # Start QNIO server on image directory for vxhs protocol
+    if [ $IMGPROTO = "vxhs" ]; then
+        eval "$QEMU_VXHS -d  $TEST_DIR > /dev/null &"
+        sleep 1 # Wait for server to come up.
+    fi
 }
 
 _rm_test_img()
@@ -197,6 +206,16 @@ _cleanup_test_img()
             fi
             rm -f "$TEST_IMG_FILE"
             ;;
+        vxhs)
+            if [ -f "${TEST_DIR}/qemu-vxhs.pid" ]; then
+                local QEMU_VXHS_PID
+                read QEMU_VXHS_PID < "${TEST_DIR}/qemu-vxhs.pid"
+                kill ${QEMU_VXHS_PID} >/dev/null 2>&1
+                rm -f "${TEST_DIR}/qemu-vxhs.pid"
+            fi
+            rm -f "$TEST_IMG_FILE"
+            ;;
+
         file)
             _rm_test_img "$TEST_DIR/t.$IMGFMT"
             _rm_test_img "$TEST_DIR/t.$IMGFMT.orig"
-- 
2.9.3
