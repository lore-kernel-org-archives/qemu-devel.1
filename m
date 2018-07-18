Received: from eggs.gnu.org ([2001:4830:134:3::10]:54576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffv3u-0007NK-Em
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 18:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffv3q-0007Yg-72
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 18:36:46 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 18 Jul 2018 19:36:28 -0300
Message-Id: <20180718223628.5062-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-3.1 v2] python: Use io.StringIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Daniel P . Berrange" <berrange@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

Both Python 2.7 and 3 support the same io.StringIO to
handle unicode strings.

Python 2.6 requires special care, but since 7f2b55443a his
support was removed. Stop caring, drop the ImportError check.

Use the common form to use indistinctly Python 2.7 or 3.

http://python-future.org/compatible_idioms.html#stringio

This fixes running tests on the Fedora Docker image,
which uses Python3 since 356dc290f:

  $ make docker-test-block@fedora
  [...]
  045         [failed, exit status 1] - output mismatch (see 045.out.bad)
  --- /tmp/qemu-test/src/tests/qemu-iotests/045.out       2018-07-17 16:56:18.000000000 +0000
  +++ /tmp/qemu-test/build/tests/qemu-iotests/045.out.bad 2018-07-17 17:19:22.448409007 +0000
  @@ -1,5 +1,6 @@
  -...........
  -----------------------------------------------------------------------
  -Ran 11 tests
  -
  -OK
  +Traceback (most recent call last):
  +  File "045", line 178, in <module>
  +    iotests.main(supported_fmts=['raw'])
  +  File "/tmp/qemu-test/src/tests/qemu-iotests/iotests.py", line 682, in main
  +    import StringIO
  +ModuleNotFoundError: No module named 'StringIO'
  132         [failed, exit status 1] - output mismatch (see 132.out.bad)
  152         [failed, exit status 1] - output mismatch (see 152.out.bad)

  Failures: 045 132 152

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/docker.py        | 5 +----
 tests/image-fuzzer/runner.py  | 6 +++---
 tests/qemu-iotests/iotests.py | 5 +++--
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 69e7130db7..9d53b868db 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -26,10 +26,7 @@ import tempfile
 import re
 import signal
 from tarfile import TarFile, TarInfo
-try:
-    from StringIO import StringIO
-except ImportError:
-    from io import StringIO
+from io import StringIO
 from shutil import copy, rmtree
 from pwd import getpwuid
 from datetime import datetime,timedelta
diff --git a/tests/image-fuzzer/runner.py b/tests/image-fuzzer/runner.py
index 95d84f38f3..4462d84f45 100755
--- a/tests/image-fuzzer/runner.py
+++ b/tests/image-fuzzer/runner.py
@@ -28,7 +28,7 @@ import shutil
 from itertools import count
 import time
 import getopt
-import StringIO
+from io import StringIO
 import resource
 
 try:
@@ -183,7 +183,7 @@ class TestEnv(object):
                                            MAX_BACKING_FILE_SIZE) * (1 << 20)
         cmd = self.qemu_img + ['create', '-f', backing_file_fmt,
                                backing_file_name, str(backing_file_size)]
-        temp_log = StringIO.StringIO()
+        temp_log = StringIO()
         retcode = run_app(temp_log, cmd)
         if retcode == 0:
             temp_log.close()
@@ -240,7 +240,7 @@ class TestEnv(object):
                            "Backing file: %s\n" \
                            % (self.seed, " ".join(current_cmd),
                               self.current_dir, backing_file_name)
-            temp_log = StringIO.StringIO()
+            temp_log = StringIO()
             try:
                 retcode = run_app(temp_log, current_cmd)
             except OSError as e:
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 4e67fbbe96..c95dd17190 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -679,13 +679,14 @@ def main(supported_fmts=[], supported_oses=['linux'], supported_cache_modes=[],
 
     # We need to filter out the time taken from the output so that qemu-iotest
     # can reliably diff the results against master output.
-    import StringIO
+    from io import StringIO
+
     if debug:
         output = sys.stdout
         verbosity = 2
         sys.argv.remove('-d')
     else:
-        output = StringIO.StringIO()
+        output = StringIO()
 
     logging.basicConfig(level=(logging.DEBUG if debug else logging.WARN))
 
-- 
2.18.0
