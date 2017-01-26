Received: from eggs.gnu.org ([2001:4830:134:3::10]:42727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cWYYC-0006Um-7C
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 20:08:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cWYYB-0007BA-5j
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 20:08:32 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 25 Jan 2017 20:08:21 -0500
Message-Id: <bb4a731a35bc4ac81fe3db17479dd686315317c7.1485392617.git.jcody@redhat.com>
In-Reply-To: <cover.1485392617.git.jcody@redhat.com>
References: <cover.1485392617.git.jcody@redhat.com>
In-Reply-To: <cover.1485392617.git.jcody@redhat.com>
References: <cover.1485392617.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/3] qemu-iotests: Don't create fifos /
 pidfiles with protocol paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com

Trying to create, use, and remove fifos and pidfiles on protocol paths
(e.g. nfs://localhost/scratch/qemu-nbd.pid) is obviously broken.

Use the local $TEST_DIR path before it is 'protocolized' for these
files.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/common.config |  6 ++++--
 tests/qemu-iotests/common.qemu   | 10 +++++-----
 tests/qemu-iotests/common.rc     |  6 +++---
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/common.config
index f6384fb..55527aa 100644
--- a/tests/qemu-iotests/common.config
+++ b/tests/qemu-iotests/common.config
@@ -109,7 +109,7 @@ _qemu_wrapper()
 {
     (
         if [ -n "${QEMU_NEED_PID}" ]; then
-            echo $BASHPID > "${TEST_DIR}/qemu-${_QEMU_HANDLE}.pid"
+            echo $BASHPID > "${QEMU_TEST_DIR}/qemu-${_QEMU_HANDLE}.pid"
         fi
         exec "$QEMU_PROG" $QEMU_OPTIONS "$@"
     )
@@ -151,7 +151,7 @@ _qemu_io_wrapper()
 _qemu_nbd_wrapper()
 {
     (
-        echo $BASHPID > "${TEST_DIR}/qemu-nbd.pid"
+        echo $BASHPID > "${QEMU_TEST_DIR}/qemu-nbd.pid"
         exec "$QEMU_NBD_PROG" $QEMU_NBD_OPTIONS "$@"
     )
 }
@@ -186,6 +186,8 @@ if [ -z "$TEST_DIR" ]; then
         TEST_DIR=`pwd`/scratch
 fi
 
+QEMU_TEST_DIR="${TEST_DIR}"
+
 if [ ! -e "$TEST_DIR" ]; then
         mkdir "$TEST_DIR"
 fi
diff --git a/tests/qemu-iotests/common.qemu b/tests/qemu-iotests/common.qemu
index e657361..4278789 100644
--- a/tests/qemu-iotests/common.qemu
+++ b/tests/qemu-iotests/common.qemu
@@ -27,8 +27,8 @@
 
 QEMU_COMM_TIMEOUT=10
 
-QEMU_FIFO_IN="${TEST_DIR}/qmp-in-$$"
-QEMU_FIFO_OUT="${TEST_DIR}/qmp-out-$$"
+QEMU_FIFO_IN="${QEMU_TEST_DIR}/qmp-in-$$"
+QEMU_FIFO_OUT="${QEMU_TEST_DIR}/qmp-out-$$"
 
 QEMU_HANDLE=0
 
@@ -204,9 +204,9 @@ function _cleanup_qemu()
     for i in "${!QEMU_OUT[@]}"
     do
         local QEMU_PID
-        if [ -f "${TEST_DIR}/qemu-${i}.pid" ]; then
-            read QEMU_PID < "${TEST_DIR}/qemu-${i}.pid"
-            rm -f "${TEST_DIR}/qemu-${i}.pid"
+        if [ -f "${QEMU_TEST_DIR}/qemu-${i}.pid" ]; then
+            read QEMU_PID < "${QEMU_TEST_DIR}/qemu-${i}.pid"
+            rm -f "${QEMU_TEST_DIR}/qemu-${i}.pid"
             if [ -z "${wait}" ] && [ -n "${QEMU_PID}" ]; then
                 kill -KILL ${QEMU_PID} 2>/dev/null
             fi
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 3213765..4bb9b77 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -193,11 +193,11 @@ _cleanup_test_img()
     case "$IMGPROTO" in
 
         nbd)
-            if [ -f "${TEST_DIR}/qemu-nbd.pid" ]; then
+            if [ -f "${QEMU_TEST_DIR}/qemu-nbd.pid" ]; then
                 local QEMU_NBD_PID
-                read QEMU_NBD_PID < "${TEST_DIR}/qemu-nbd.pid"
+                read QEMU_NBD_PID < "${QEMU_TEST_DIR}/qemu-nbd.pid"
                 kill ${QEMU_NBD_PID}
-                rm -f "${TEST_DIR}/qemu-nbd.pid"
+                rm -f "${QEMU_TEST_DIR}/qemu-nbd.pid"
             fi
             rm -f "$TEST_IMG_FILE"
             ;;
-- 
2.9.3
