Received: from eggs.gnu.org ([2001:4830:134:3::10]:34182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fd8o9-0004W4-OO
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 02:41:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fd8o8-0004Wc-OF
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 02:41:01 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 11 Jul 2018 14:40:46 +0800
Message-Id: <20180711064046.10989-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2] iotests: nbd: Stop qemu-nbd before remaking
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

197 is one example where _make_test_img is used twice without stopping
the NBD server in between. An error will occur like this:

    @@ -26,9 +26,13 @@

     === Partial final cluster ===

    +qemu-img: TEST_DIR/t.IMGFMT: Failed to get "resize" lock
    +Is another process using the image?
     Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1024
    +Failed to find an available port: Address already in use
     read 1024/1024 bytes at offset 0

Patch _make_test_img to stop the old qemu-nbd before starting a new one,
which fixes this problem, and similarly 215.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/qemu-iotests/common.rc | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index d054cb97fc..44bee16a5e 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -195,6 +195,16 @@ _use_sample_img()
     fi
 }
 
+_stop_nbd_server()
+{
+    if [ -f "${QEMU_TEST_DIR}/qemu-nbd.pid" ]; then
+        local QEMU_NBD_PID
+        read QEMU_NBD_PID < "${QEMU_TEST_DIR}/qemu-nbd.pid"
+        kill ${QEMU_NBD_PID}
+        rm -f "${QEMU_TEST_DIR}/qemu-nbd.pid"
+    fi
+}
+
 _make_test_img()
 {
     # extra qemu-img options can be added by tests
@@ -234,6 +244,10 @@ _make_test_img()
         extra_img_options="-o $optstr $extra_img_options"
     fi
 
+    if [ $IMGPROTO = "nbd" ]; then
+        _stop_nbd_server
+    fi
+
     # XXX(hch): have global image options?
     (
      if [ $use_backing = 1 ]; then
@@ -274,12 +288,7 @@ _cleanup_test_img()
     case "$IMGPROTO" in
 
         nbd)
-            if [ -f "${QEMU_TEST_DIR}/qemu-nbd.pid" ]; then
-                local QEMU_NBD_PID
-                read QEMU_NBD_PID < "${QEMU_TEST_DIR}/qemu-nbd.pid"
-                kill ${QEMU_NBD_PID}
-                rm -f "${QEMU_TEST_DIR}/qemu-nbd.pid"
-            fi
+            _stop_nbd_server
             rm -f "$TEST_IMG_FILE"
             ;;
         vxhs)
-- 
2.17.1
