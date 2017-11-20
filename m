Received: from eggs.gnu.org ([2001:4830:134:3::10]:56967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eGc76-0000dh-5u
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 21:47:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eGc75-0008PX-Fi
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 21:47:12 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Sun, 19 Nov 2017 21:46:45 -0500
Message-Id: <5874110009542356a7d3d19cec48751f2ccdf05b.1511145863.git.jcody@redhat.com>
In-Reply-To: <cover.1511145863.git.jcody@redhat.com>
References: <cover.1511145863.git.jcody@redhat.com>
In-Reply-To: <cover.1511145863.git.jcody@redhat.com>
References: <cover.1511145863.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] qemu-iotests: add option in common.qemu
 for mismatch only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, pbonzini@redhat.com, kwolf@redhat.com

Add option to echo response to QMP / HMP command only on mismatch.

Useful for ignore all normal responses, but catching things like
segfaults.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/common.qemu | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/common.qemu b/tests/qemu-iotests/common.qemu
index 7b3052d..85f66b8 100644
--- a/tests/qemu-iotests/common.qemu
+++ b/tests/qemu-iotests/common.qemu
@@ -50,6 +50,8 @@ _in_fd=4
 #
 # If $silent is set to anything but an empty string, then
 # response is not echoed out.
+# If $mismatch_only is set, only non-matching responses will
+# be echoed.
 function _timed_wait_for()
 {
     local h=${1}
@@ -58,14 +60,18 @@ function _timed_wait_for()
     QEMU_STATUS[$h]=0
     while IFS= read -t ${QEMU_COMM_TIMEOUT} resp <&${QEMU_OUT[$h]}
     do
-        if [ -z "${silent}" ]; then
+        if [ -z "${silent}" ] && [ -z "${mismatch_only}" ]; then
             echo "${resp}" | _filter_testdir | _filter_qemu \
                            | _filter_qemu_io | _filter_qmp | _filter_hmp
         fi
         grep -q "${*}" < <(echo "${resp}")
         if [ $? -eq 0 ]; then
             return
+        elif [ -z "${silent}" ] && [ -n "${mismatch_only}" ]; then
+            echo "${resp}" | _filter_testdir | _filter_qemu \
+                           | _filter_qemu_io | _filter_qmp | _filter_hmp
         fi
+
     done
     QEMU_STATUS[$h]=-1
     if [ -z "${qemu_error_no_exit}" ]; then
-- 
2.9.5
