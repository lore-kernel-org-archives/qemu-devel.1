Received: from eggs.gnu.org ([209.51.188.92]:59346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5V-0008BZ-I3
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5S-0005k1-Gi
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:58:57 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  8 Mar 2019 13:57:55 +0100
Message-Id: <20190308125823.32535-6-kwolf@redhat.com>
In-Reply-To: <20190308125823.32535-1-kwolf@redhat.com>
References: <20190308125823.32535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/33] iotests: ask QEMU for supported formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

Supported formats listed by 'qemu' may differ from those listed by
'qemu-img' due to whitelists. Some test cases require specific formats
that may be used with qemu. They can be inquired directly by running
'qemu -drive format=3Dhelp'. The response takes whitelists into account.
The method supported_formats() serves for that. The method decorator
skip_if_unsupported() checks if all requested formats are whitelisted.
If not, the test case will be skipped. That has been implemented in
the 'check' file in the way similar to the 'test notrun' mechanism.

Suggested-by: Roman Kagan <rkagan@virtuozzo.com>
Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/check      | 13 ++++++++++-
 tests/qemu-iotests/iotests.py | 43 +++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 895e1e3dcb..1016887438 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -25,6 +25,7 @@ try=3D0
 n_bad=3D0
 bad=3D""
 notrun=3D""
+casenotrun=3D""
 interrupt=3Dtrue
=20
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
         if [ ! -z "$n_bad" -a $n_bad !=3D 0 ]
         then
             echo "Failures:$bad"
@@ -743,6 +749,7 @@ do
                 printf "        "        # prettier output with timestam=
ps.
         fi
         rm -f core $seq.notrun
+        rm -f $seq.casenotrun
=20
         start=3D$(_wallclock)
         $timestamp && printf %s "        [$(date "+%T")]"
@@ -823,7 +830,11 @@ do
                 fi
             fi
         fi
-
+        if [ -f $seq.casenotrun ]
+        then
+            cat $seq.casenotrun
+            casenotrun=3D"$casenotrun $seq"
+        fi
     fi
=20
     # come here for each test, except when $showme is true
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 46fad4ce81..997dc910cb 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -716,6 +716,14 @@ def notrun(reason):
     print('%s not run: %s' % (seq, reason))
     sys.exit(0)
=20
+def case_notrun(reason):
+    '''Skip this test case'''
+    # Each test in qemu-iotests has a number ("seq")
+    seq =3D os.path.basename(sys.argv[0])
+
+    open('%s/%s.casenotrun' % (output_dir, seq), 'a').write(
+        '    [case not run] ' + reason + '\n')
+
 def verify_image_format(supported_fmts=3D[], unsupported_fmts=3D[]):
     assert not (supported_fmts and unsupported_fmts)
=20
@@ -756,6 +764,41 @@ def verify_quorum():
     if not supports_quorum():
         notrun('quorum support missing')
=20
+def qemu_pipe(*args):
+    '''Run qemu with an option to print something and exit (e.g. a help =
option),
+    and return its output'''
+    args =3D [qemu_prog] + qemu_opts + list(args)
+    subp =3D subprocess.Popen(args, stdout=3Dsubprocess.PIPE,
+                            stderr=3Dsubprocess.STDOUT,
+                            universal_newlines=3DTrue)
+    exitcode =3D subp.wait()
+    if exitcode < 0:
+        sys.stderr.write('qemu received signal %i: %s\n' % (-exitcode,
+                         ' '.join(args)))
+    return subp.communicate()[0]
+
+def supported_formats(read_only=3DFalse):
+    '''Set 'read_only' to True to check ro-whitelist
+       Otherwise, rw-whitelist is checked'''
+    format_message =3D qemu_pipe("-drive", "format=3Dhelp")
+    line =3D 1 if read_only else 0
+    return format_message.splitlines()[line].split(":")[1].split()
+
+def skip_if_unsupported(required_formats=3D[], read_only=3DFalse):
+    '''Skip Test Decorator
+       Runs the test if all the required formats are whitelisted'''
+    def skip_test_decorator(func):
+        def func_wrapper(*args, **kwargs):
+            usf_list =3D list(set(required_formats) -
+                            set(supported_formats(read_only)))
+            if usf_list:
+                case_notrun('{}: formats {} are not whitelisted'.format(
+                    args[0], usf_list))
+            else:
+                return func(*args, **kwargs)
+        return func_wrapper
+    return skip_test_decorator
+
 def main(supported_fmts=3D[], supported_oses=3D['linux'], supported_cach=
e_modes=3D[],
          unsupported_fmts=3D[]):
     '''Run tests'''
--=20
2.20.1
