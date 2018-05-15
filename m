Received: from eggs.gnu.org ([2001:4830:134:3::10]:38941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4Z-0006pI-BO
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4V-0001Z9-5w
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:07 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 15 May 2018 17:40:18 +0200
Message-Id: <20180515154033.19899-23-kwolf@redhat.com>
In-Reply-To: <20180515154033.19899-1-kwolf@redhat.com>
References: <20180515154033.19899-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 22/37] iotests: Add failure matching to
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

Currently, common.qemu only allows to match for results indicating
success.  The only way to fail is by provoking a timeout.  However,
sometimes we do have a defined failure output and can match for that,
which saves us from having to wait for the timeout in case of failure.
Because failure can sometimes just result in a _notrun in the test, it
is actually important to care about being able to fail quickly.

Also, sometimes we simply do not get any specific output in case of
success.  The only way to handle this currently would be to define an
error message as the string to look for, which means that actual success
results in a timeout.  This is really bad because it unnecessarily slows
down a succeeding test.

Therefore, this patch adds a new parameter $success_or_failure to
_timed_wait_for and _send_qemu_cmd.  Setting this to a non-empty string
makes both commands expect two match parameters: If the first matches,
the function succeeds.  If the second matches, the function fails.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20180406151731.4285-2-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/common.qemu | 58 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/common.qemu b/tests/qemu-iotests/common.qemu
index 85f66b852c..f285484951 100644
--- a/tests/qemu-iotests/common.qemu
+++ b/tests/qemu-iotests/common.qemu
@@ -52,11 +52,29 @@ _in_fd=4
 # response is not echoed out.
 # If $mismatch_only is set, only non-matching responses will
 # be echoed.
+#
+# If $success_or_failure is set, the meaning of the arguments is
+# changed as follows:
+# $2: A string to search for in the response; if found, this indicates
+#     success and ${QEMU_STATUS[$1]} is set to 0.
+# $3: A string to search for in the response; if found, this indicates
+#     failure and the test is either aborted (if $qemu_error_no_exit
+#     is not set) or ${QEMU_STATUS[$1]} is set to -1 (otherwise).
 function _timed_wait_for()
 {
     local h=${1}
     shift
 
+    if [ -z "${success_or_failure}" ]; then
+        success_match=${*}
+        failure_match=
+    else
+        success_match=${1}
+        failure_match=${2}
+    fi
+
+    timeout=yes
+
     QEMU_STATUS[$h]=0
     while IFS= read -t ${QEMU_COMM_TIMEOUT} resp <&${QEMU_OUT[$h]}
     do
@@ -64,10 +82,18 @@ function _timed_wait_for()
             echo "${resp}" | _filter_testdir | _filter_qemu \
                            | _filter_qemu_io | _filter_qmp | _filter_hmp
         fi
-        grep -q "${*}" < <(echo "${resp}")
+        if [ -n "${failure_match}" ]; then
+            grep -q "${failure_match}" < <(echo "${resp}")
+            if [ $? -eq 0 ]; then
+                timeout=
+                break
+            fi
+        fi
+        grep -q "${success_match}" < <(echo "${resp}")
         if [ $? -eq 0 ]; then
             return
-        elif [ -z "${silent}" ] && [ -n "${mismatch_only}" ]; then
+        fi
+        if [ -z "${silent}" ] && [ -n "${mismatch_only}" ]; then
             echo "${resp}" | _filter_testdir | _filter_qemu \
                            | _filter_qemu_io | _filter_qmp | _filter_hmp
         fi
@@ -75,8 +101,12 @@ function _timed_wait_for()
     done
     QEMU_STATUS[$h]=-1
     if [ -z "${qemu_error_no_exit}" ]; then
-        echo "Timeout waiting for ${*} on handle ${h}"
-        exit 1  # Timeout means the test failed
+        if [ -n "${timeout}" ]; then
+            echo "Timeout waiting for ${success_match} on handle ${h}"
+        else
+            echo "Wrong response matching ${failure_match} on handle ${h}"
+        fi
+        exit 1  # Timeout or wrong match mean the test failed
     fi
 }
 
@@ -96,6 +126,11 @@ function _timed_wait_for()
 # If $qemu_error_no_exit is set, then even if the expected response
 # is not seen, we will not exit.  $QEMU_STATUS[$1] will be set it -1 in
 # that case.
+#
+# If $success_or_failure is set, then the last two strings are the
+# strings the response will be scanned for.  The first of the two
+# indicates success, the latter indicates failure.  Failure is handled
+# like a timeout.
 function _send_qemu_cmd()
 {
     local h=${1}
@@ -109,14 +144,23 @@ function _send_qemu_cmd()
         use_error="no"
     fi
     # This array element extraction is done to accommodate pathnames with spaces
-    cmd=${@: 1:${#@}-1}
-    shift $(($# - 1))
+    if [ -z "${success_or_failure}" ]; then
+        cmd=${@: 1:${#@}-1}
+        shift $(($# - 1))
+    else
+        cmd=${@: 1:${#@}-2}
+        shift $(($# - 2))
+    fi
 
     while [ ${count} -gt 0 ]
     do
         echo "${cmd}" >&${QEMU_IN[${h}]}
         if [ -n "${1}" ]; then
-            qemu_error_no_exit=${use_error} _timed_wait_for ${h} "${1}"
+            if [ -z "${success_or_failure}" ]; then
+                qemu_error_no_exit=${use_error} _timed_wait_for ${h} "${1}"
+            else
+                qemu_error_no_exit=${use_error} _timed_wait_for ${h} "${1}" "${2}"
+            fi
             if [ ${QEMU_STATUS[$h]} -eq 0 ]; then
                 return
             fi
-- 
2.13.6
