Received: from eggs.gnu.org ([2001:4830:134:3::10]:56345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0UyJ-00014H-1J
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0UyH-0003qb-P2
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:31 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  6 Oct 2017 17:54:03 +0200
Message-Id: <20171006155422.10135-36-kwolf@redhat.com>
In-Reply-To: <20171006155422.10135-1-kwolf@redhat.com>
References: <20171006155422.10135-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 35/54] qemu-iotests: Allow QMP pretty printing
 in common.qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

QMP responses to certain commands can become quite long, which doesn't
only make reading them hard, but also means that the maximum line length
in patch emails can be exceeded. Allow tests to switch to QMP pretty
printing, which results in more, but shorter lines.

We also need to make sure to keep indentation in the response for this
to work as expected.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/common.qemu | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/common.qemu b/tests/qemu-iotests/common.qemu
index 9f9aecc9df..7b3052dc79 100644
--- a/tests/qemu-iotests/common.qemu
+++ b/tests/qemu-iotests/common.qemu
@@ -56,13 +56,13 @@ function _timed_wait_for()
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
@@ -130,6 +130,7 @@ function _send_qemu_cmd()
 # $qemu_comm_method: set this variable to 'monitor' (case insensitive)
 #                    to use the QEMU HMP monitor for communication.
 #                    Otherwise, the default of QMP is used.
+# $qmp_pretty: Set this variable to 'y' to enable QMP pretty printing.
 # $keep_stderr: Set this variable to 'y' to keep QEMU's stderr output on stderr.
 #               If this variable is empty, stderr will be redirected to stdout.
 # Returns:
@@ -146,7 +147,11 @@ function _launch_qemu()
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
@@ -193,6 +198,9 @@ function _launch_qemu()
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
2.13.6
