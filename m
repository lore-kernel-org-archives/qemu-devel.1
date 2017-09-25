Received: from eggs.gnu.org ([2001:4830:134:3::10]:47284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwSUs-0003eO-4Y
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 08:28:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwSUm-000650-Gy
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 08:28:26 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Sep 2017 14:28:06 +0200
Message-Id: <20170925122808.14561-4-kwolf@redhat.com>
In-Reply-To: <20170925122808.14561-1-kwolf@redhat.com>
References: <20170925122808.14561-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 3/5] qemu-iotests: Allow QMP pretty printing in
 common.qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

QMP responses to certain commands can become quite long, which doesn't
only make reading them hard, but also means that the maximum line length
in patch emails can be exceeded. Allow tests to switch to QMP pretty
printing, which results in more, but shorter lines.

We also need to make sure to keep indentation in the response for this
to work as expected.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/common.qemu | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/common.qemu b/tests/qemu-iotests/common.qemu
index 7645f1dc72..92739a1eac 100644
--- a/tests/qemu-iotests/common.qemu
+++ b/tests/qemu-iotests/common.qemu
@@ -55,13 +55,13 @@ function _timed_wait_for()
     shift
 
     QEMU_STATUS[$h]=0
-    while read -t ${QEMU_COMM_TIMEOUT} resp <&${QEMU_OUT[$h]}
+    while IFS= read -t ${QEMU_COMM_TIMEOUT} resp <&${QEMU_OUT[$h]}
     do
         if [ -z "${silent}" ]; then
             echo "${resp}" | _filter_testdir | _filter_qemu \
                            | _filter_qemu_io | _filter_qmp | _filter_hmp
         fi
-        grep -q "${*}" < <(echo ${resp})
+        grep -q "${*}" < <(echo "${resp}")
         if [ $? -eq 0 ]; then
             return
         fi
@@ -129,6 +129,7 @@ function _send_qemu_cmd()
 # $qemu_comm_method: set this variable to 'monitor' (case insensitive)
 #                    to use the QEMU HMP monitor for communication.
 #                    Otherwise, the default of QMP is used.
+# $qmp_pretty: Set this variable to 'y' to enable QMP pretty printing.
 # $keep_stderr: Set this variable to 'y' to keep QEMU's stderr output on stderr.
 #               If this variable is empty, stderr will be redirected to stdout.
 # Returns:
@@ -145,7 +146,11 @@ function _launch_qemu()
         comm="-monitor stdio"
     else
         local qemu_comm_method="qmp"
-        comm="-monitor none -qmp stdio"
+        if [ "$qmp_pretty" = "y" ]; then
+            comm="-monitor none -qmp-pretty stdio"
+        else
+            comm="-monitor none -qmp stdio"
+        fi
     fi
 
     fifo_out=${QEMU_FIFO_OUT}_${_QEMU_HANDLE}
@@ -192,6 +197,9 @@ function _launch_qemu()
     then
         # Don't print response, since it has version information in it
         silent=yes _timed_wait_for ${_QEMU_HANDLE} "capabilities"
+        if [ "$qmp_pretty" = "y" ]; then
+            silent=yes _timed_wait_for ${_QEMU_HANDLE} "^}"
+        fi
     fi
     QEMU_HANDLE=${_QEMU_HANDLE}
     let _QEMU_HANDLE++
-- 
2.13.5
