Received: from eggs.gnu.org ([2001:4830:134:3::10]:39395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1cbJif-0005k5-Nx
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 23:19:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1cbJid-0004eZ-1y
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 23:19:01 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:32810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashmit602@gmail.com>) id 1cbJic-0004eR-QR
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 23:18:58 -0500
Received: by mail-pg0-x242.google.com with SMTP id 194so13946875pgd.0
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 20:18:58 -0800 (PST)
From: Ashish Mittal <ashmit602@gmail.com>
Date: Tue,  7 Feb 2017 20:18:14 -0800
Message-Id: <1486527494-3387-2-git-send-email-Ashish.Mittal@veritas.com>
In-Reply-To: <1486527494-3387-1-git-send-email-Ashish.Mittal@veritas.com>
References: <1486527494-3387-1-git-send-email-Ashish.Mittal@veritas.com>
Subject: [Qemu-devel] [PATCH v7 2/2] block/vxhs.c: Add qemu-iotests for new
 block device type "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com, jcody@redhat.com, famz@redhat.com, ashish.mittal@veritas.com, stefanha@gmail.com, jferlan@redhat.com, Buddhi.Madhav@veritas.com, Suraj.Singh@veritas.com, Nitin.Jerath@veritas.com, peter.maydell@linaro.org
Cc: Ketan.Nilangekar@veritas.com, Abhijit.Dey@veritas.com

From: Ashish Mittal <ashish.mittal@veritas.com>

These changes use a vxhs test server that is a part of the following
repository:
https://github.com/VeritasHyperScale/libqnio.git

Signed-off-by: Ashish Mittal <ashish.mittal@veritas.com>
---
v7 changelog:
(1) No changes.

v6 changelog:
(1) Added iotests for VxHS block device.

 tests/qemu-iotests/common        |  6 ++++++
 tests/qemu-iotests/common.config | 13 +++++++++++++
 tests/qemu-iotests/common.filter |  1 +
 tests/qemu-iotests/common.rc     | 19 +++++++++++++++++++
 4 files changed, 39 insertions(+)

diff --git a/tests/qemu-iotests/common b/tests/qemu-iotests/common
index b6274be..318a81d 100644
--- a/tests/qemu-iotests/common
+++ b/tests/qemu-iotests/common
@@ -158,6 +158,7 @@ check options
     -nfs                test nfs
     -archipelago        test archipelago
     -luks               test luks
+    -vxhs               test vxhs
     -xdiff              graphical mode diff
     -nocache            use O_DIRECT on backing file
     -misalign           misalign memory allocations
@@ -261,6 +262,11 @@ testlist options
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
index f6384fb..c7a80c0 100644
--- a/tests/qemu-iotests/common.config
+++ b/tests/qemu-iotests/common.config
@@ -105,6 +105,10 @@ if [ -z "$QEMU_NBD_PROG" ]; then
     export QEMU_NBD_PROG="`set_prog_path qemu-nbd`"
 fi
 
+if [ -z "$QEMU_VXHS_PROG" ]; then
+    export QEMU_VXHS_PROG="`set_prog_path qnio_server /usr/local/bin`"
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
index 240ed06..a8a4d0e 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -123,6 +123,7 @@ _filter_img_info()
         -e "s#$TEST_DIR#TEST_DIR#g" \
         -e "s#$IMGFMT#IMGFMT#g" \
         -e 's#nbd://127.0.0.1:10810$#TEST_DIR/t.IMGFMT#g' \
+        -e 's#json.*vdisk-id.*vxhs"}}#TEST_DIR/t.IMGFMT#' \
         -e "/encrypted: yes/d" \
         -e "/cluster_size: [0-9]\\+/d" \
         -e "/table_size: [0-9]\\+/d" \
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 3213765..06a3164 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -89,6 +89,9 @@ else
         TEST_IMG=$TEST_DIR/t.$IMGFMT
     elif [ "$IMGPROTO" = "archipelago" ]; then
         TEST_IMG="archipelago:at.$IMGFMT"
+    elif [ "$IMGPROTO" = "vxhs" ]; then
+        TEST_IMG_FILE=$TEST_DIR/t.$IMGFMT
+        TEST_IMG="vxhs://127.0.0.1:9999/t.$IMGFMT"
     else
         TEST_IMG=$IMGPROTO:$TEST_DIR/t.$IMGFMT
     fi
@@ -175,6 +178,12 @@ _make_test_img()
         eval "$QEMU_NBD -v -t -b 127.0.0.1 -p 10810 -f $IMGFMT  $TEST_IMG_FILE &"
         sleep 1 # FIXME: qemu-nbd needs to be listening before we continue
     fi
+
+    # Start QNIO server on image directory for vxhs protocol
+    if [ $IMGPROTO = "vxhs" ]; then
+        eval "$QEMU_VXHS -d  $TEST_DIR &"
+        sleep 1 # Wait for server to come up.
+    fi
 }
 
 _rm_test_img()
@@ -201,6 +210,16 @@ _cleanup_test_img()
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
1.8.3.1
