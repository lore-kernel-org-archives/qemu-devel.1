Received: from eggs.gnu.org ([2001:4830:134:3::10]:53942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4JZJ-00019N-R2
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:33:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4JZI-0005MD-Hf
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:33:29 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 17 Oct 2017 00:32:41 -0400
Message-Id: <bf3bae6ead4a3dc8f542dc10b08cf40037b3a30a.1508213452.git.jcody@redhat.com>
In-Reply-To: <cover.1508213452.git.jcody@redhat.com>
References: <cover.1508213452.git.jcody@redhat.com>
In-Reply-To: <cover.1508213452.git.jcody@redhat.com>
References: <cover.1508213452.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v4 05/10] qemu-iotests: change qemu pid and fd
 tracking / cleanup
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

So that later patches can cleanup running qemu processes called from
different subshells, track resources to cleanup in pid and fd list
files.

In subsquent patches, ./check will kill all QEMU processes launched with
the common.qemu framework, and the tests will not need to cleanup
manually (unless they want to do so as part of the test, e.g. wait for
a process to end such as migration).

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/common.qemu | 65 +++++++++++++++++++++++++++++++-----------
 tests/qemu-iotests/common.rc   |  2 +-
 2 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/tests/qemu-iotests/common.qemu b/tests/qemu-iotests/common.qemu
index 7b3052d..7bd21ea 100644
--- a/tests/qemu-iotests/common.qemu
+++ b/tests/qemu-iotests/common.qemu
@@ -193,6 +193,8 @@ function _launch_qemu()
     QEMU_OUT[${_QEMU_HANDLE}]=${_out_fd}
     QEMU_IN[${_QEMU_HANDLE}]=${_in_fd}
     QEMU_STATUS[${_QEMU_HANDLE}]=0
+    echo ${_out_fd} >> "$QEMU_TEST_DIR/qemu-out-fd.lst"
+    echo ${_in_fd} >> "$QEMU_TEST_DIR/qemu-in-fd.lst"
 
     if [ "${qemu_comm_method}" == "qmp" ]
     then
@@ -209,35 +211,64 @@ function _launch_qemu()
 
 # Silenty kills the QEMU process
 #
+# This is able to kill and clean up after QEMU processes without the
+# need for any subshell-specific variables, so long as the qemu-pidlist
+# and qemu-out-fd.list and qemu-in-fd.list files are properly maintained.
+#
 # If $wait is set to anything other than the empty string, the process will not
 # be killed but only waited for, and any output will be forwarded to stdout. If
 # $wait is empty, the process will be killed and all output will be suppressed.
 function _cleanup_qemu()
 {
-    # QEMU_PID[], QEMU_IN[], QEMU_OUT[] all use same indices
-    for i in "${!QEMU_OUT[@]}"
+    local PIDFILE="${QEMU_TEST_DIR}"/qemu-pidlist.pid
+    local OUT_FD_FILE="${QEMU_TEST_DIR}"/qemu-out-fd.lst
+    local IN_FD_FILE="${QEMU_TEST_DIR}"/qemu-in-fd.lst
+
+    if [ ! -e "${PIDFILE}" ]; then
+        return
+    fi
+
+    # get line count, and therefore number of processes to kill
+    numproc=$(wc -l "${PIDFILE}" | sed 's/\s.*//')
+
+    for i in $(seq 1 $numproc)
     do
         local QEMU_PID
-        if [ -f "${QEMU_TEST_DIR}/qemu-${i}.pid" ]; then
-            read QEMU_PID < "${QEMU_TEST_DIR}/qemu-${i}.pid"
-            rm -f "${QEMU_TEST_DIR}/qemu-${i}.pid"
-            if [ -z "${wait}" ] && [ -n "${QEMU_PID}" ]; then
-                kill -KILL ${QEMU_PID} 2>/dev/null
-            fi
-            if [ -n "${QEMU_PID}" ]; then
-                wait ${QEMU_PID} 2>/dev/null # silent kill
-            fi
+        local OUT_FD
+        local IN_FD
+
+        QEMU_PID=$(tail -n+${i} "${PIDFILE}" | head -n1)
+        OUT_FD=$(tail -n+${i} "${OUT_FD_FILE}" | head -n1)
+        IN_FD=$(tail -n+${i} "${IN_FD_FILE}" | head -n1)
+
+        if [ -z "${wait}" ] && [ -n "${QEMU_PID}" ]; then
+            kill -KILL ${QEMU_PID} 2>/dev/null
+        fi
+        if [ -n "${QEMU_PID}" ]; then
+            wait ${QEMU_PID} 2>/dev/null # silent kill
+        fi
+
+        if [ -n "${wait}" ] && [ -n "${OUT_FD}" ]; then
+            cat <&${OUT_FD} | _filter_testdir | _filter_qemu \
+                            | _filter_qemu_io | _filter_qmp | _filter_hmp
         fi
 
-        if [ -n "${wait}" ]; then
-            cat <&${QEMU_OUT[$i]} | _filter_testdir | _filter_qemu \
-                                  | _filter_qemu_io | _filter_qmp | _filter_hmp
+        if [ -n "${IN_FD}" ]; then
+            eval "exec ${IN_FD}<&-"   # close file descriptors
+        fi
+        if [ -n "${OUT_FD}" ]; then
+            eval "exec ${OUT_FD}<&-"
+        fi
+        if [ -n "${QEMU_FIFO_IN}" ]; then
+            rm -f "${QEMU_FIFO_IN}_${i}"
+        fi
+        if [ -n "${QEMU_FIFO_OUT}" ]; then
+            rm -f "${QEMU_FIFO_OUT}_${i}"
         fi
-        rm -f "${QEMU_FIFO_IN}_${i}" "${QEMU_FIFO_OUT}_${i}"
-        eval "exec ${QEMU_IN[$i]}<&-"   # close file descriptors
-        eval "exec ${QEMU_OUT[$i]}<&-"
 
         unset QEMU_IN[$i]
         unset QEMU_OUT[$i]
     done
+
+    rm -f "${PIDFILE}" "${OUT_FD_FILE}" "${IN_FD_FILE}"
 }
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index a345ffd..c81f712 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -51,7 +51,7 @@ _qemu_wrapper()
 {
     (
         if [ -n "${QEMU_NEED_PID}" ]; then
-            echo $BASHPID > "${QEMU_TEST_DIR}/qemu-${_QEMU_HANDLE}.pid"
+            echo $BASHPID >> "${QEMU_TEST_DIR}/qemu-pidlist.pid"
         fi
         exec "$QEMU_PROG" $QEMU_OPTIONS "$@"
     )
-- 
2.9.5
