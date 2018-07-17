Received: from eggs.gnu.org ([2001:4830:134:3::10]:60628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffZa0-0002ec-RD
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 19:40:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffZZx-0005KN-NO
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 19:40:28 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 17 Jul 2018 20:40:15 -0300
Message-Id: <20180717234015.22700-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-3.1] qemu-iotests: Adapt to moved location
 of StringIO module in py3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>

Since 356dc290f the Fedora image default to Python3.

This fixes:

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
  148         [failed, exit status 1] - output mismatch (see 148.out.bad)
  152         [failed, exit status 1] - output mismatch (see 152.out.bad)

  Failures: 045 132 148 152

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/qemu-iotests/iotests.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 4e67fbbe96..2fc7165fb9 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -679,13 +679,17 @@ def main(supported_fmts=[], supported_oses=['linux'], supported_cache_modes=[],
 
     # We need to filter out the time taken from the output so that qemu-iotest
     # can reliably diff the results against master output.
-    import StringIO
+    try:
+        from StringIO import StringIO
+    except ImportError:
+        from io import StringIO
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
