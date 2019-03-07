Received: from eggs.gnu.org ([209.51.188.92]:60414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1h1t9w-0002LX-Sw
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:34:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1h1t9v-0003LA-SV
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:34:04 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Thu,  7 Mar 2019 16:33:59 +0300
Message-Id: <1551965640-164939-4-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1551965640-164939-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1551965640-164939-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 3/4] iotests: ask QEMU for supported formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, rkagan@virtuozzo.com, andrey.shinkevich@virtuozzo.com

Supported formats listed by 'qemu' may differ from those listed by
'qemu-img' due to whitelists. Some test cases require specific formats
that may be used with qemu. They can be inquired directly by running
'qemu -drive format=help'. The response takes whitelists into account.
The method supported_formats() serves for that. The method decorator
skip_if_unsupported() checks if all requested formats are whitelisted.
If not, the test case will be skipped. That has been implemented in
the 'check' file in the way similar to the 'test notrun' mechanism.

Suggested-by: Roman Kagan <rkagan@virtuozzo.com>
Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/check      | 13 ++++++++++++-
 tests/qemu-iotests/iotests.py | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 895e1e3..1016887 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -25,6 +25,7 @@ try=0
 n_bad=0
 bad=""
 notrun=""
+casenotrun=""
 interrupt=true
 
 # by default don't output timestamps
@@ -664,6 +665,11 @@ END        { if (NR > 0) {
             echo "Not run:$notrun"
             echo "Not run:$notrun" >>check.log
         fi
+        if [ ! -z "$casenotrun" ]
+        then
+            echo "Some cases not run in:$casenotrun"
+            echo "Some cases not run in:$casenotrun" >>check.log
+        fi
         if [ ! -z "$n_bad" -a $n_bad != 0 ]
         then
             echo "Failures:$bad"
@@ -743,6 +749,7 @@ do
                 printf "        "        # prettier output with timestamps.
         fi
         rm -f core $seq.notrun
+        rm -f $seq.casenotrun
 
         start=$(_wallclock)
         $timestamp && printf %s "        [$(date "+%T")]"
@@ -823,7 +830,11 @@ do
                 fi
             fi
         fi
-
+        if [ -f $seq.casenotrun ]
+        then
+            cat $seq.casenotrun
+            casenotrun="$casenotrun $seq"
+        fi
     fi
 
     # come here for each test, except when $showme is true
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 35b63fc..f2fee9d 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -716,6 +716,14 @@ def notrun(reason):
     print('%s not run: %s' % (seq, reason))
     sys.exit(0)
 
+def case_notrun(reason):
+    '''Skip this test case'''
+    # Each test in qemu-iotests has a number ("seq")
+    seq = os.path.basename(sys.argv[0])
+
+    open('%s/%s.casenotrun' % (output_dir, seq), 'a').write(
+        '    [case not run] ' + reason + '\n')
+
 def verify_image_format(supported_fmts=[], unsupported_fmts=[]):
     assert not (supported_fmts and unsupported_fmts)
 
@@ -756,6 +764,41 @@ def verify_quorum():
     if not supports_quorum():
         notrun('quorum support missing')
 
+def qemu_pipe(*args):
+    '''Run qemu with an option to print something and exit (e.g. a help option),
+    and return its output'''
+    args = [qemu_prog] + qemu_opts + list(args)
+    subp = subprocess.Popen(args, stdout=subprocess.PIPE,
+                            stderr=subprocess.STDOUT,
+                            universal_newlines=True)
+    exitcode = subp.wait()
+    if exitcode < 0:
+        sys.stderr.write('qemu received signal %i: %s\n' % (-exitcode,
+                         ' '.join(args)))
+    return subp.communicate()[0]
+
+def supported_formats(read_only=False):
+    '''Set 'read_only' to True to check ro-whitelist
+       Otherwise, rw-whitelist is checked'''
+    format_message = qemu_pipe("-drive", "format=help")
+    line = 1 if read_only else 0
+    return format_message.splitlines()[line].split(":")[1].split()
+
+def skip_if_unsupported(required_formats=[], read_only=False):
+    '''Skip Test Decorator
+       Runs the test if all the required formats are whitelisted'''
+    def skip_test_decorator(func):
+        def func_wrapper(*args, **kwargs):
+            usf_list = list(set(required_formats) -
+                            set(supported_formats(read_only)))
+            if usf_list:
+                case_notrun('{}: formats {} are not whitelisted'.format(
+                    args[0], usf_list))
+            else:
+                return func(*args, **kwargs)
+        return func_wrapper
+    return skip_test_decorator
+
 def main(supported_fmts=[], supported_oses=['linux'], supported_cache_modes=[],
          unsupported_fmts=[]):
     '''Run tests'''
-- 
1.8.3.1
