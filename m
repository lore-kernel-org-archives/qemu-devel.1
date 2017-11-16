Received: from eggs.gnu.org ([2001:4830:134:3::10]:59902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1eFO7g-0007df-PV
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:38:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1eFO7e-0003Up-G7
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:38:44 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 16 Nov 2017 12:38:10 -0500
Message-Id: <20171116173810.16457-11-crosa@redhat.com>
In-Reply-To: <20171116173810.16457-1-crosa@redhat.com>
References: <20171116173810.16457-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 10/10] qemu-iotests: add section on how to
 write a new I/O test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>

This adds some basic information on how to write a new test.  I'm
aware that some of the information in the wiki (Testing/QemuIoTests)
could also belong here.

Since copying content over won't generate much interesting feedback,
the goal here is to get feedback on the sample_test_templates, general
workflow proposed for writing a new test, etc.

After feedback is received, I can go over and sync both sides (wiki
and README).

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/qemu-iotests/README                          | 44 ++++++++++++++--
 tests/qemu-iotests/sample_test_templates/sample.py | 59 ++++++++++++++++++++++
 tests/qemu-iotests/sample_test_templates/sample.sh | 40 +++++++++++++++
 3 files changed, 138 insertions(+), 5 deletions(-)
 create mode 100755 tests/qemu-iotests/sample_test_templates/sample.py
 create mode 100755 tests/qemu-iotests/sample_test_templates/sample.sh

diff --git a/tests/qemu-iotests/README b/tests/qemu-iotests/README
index 6079b401ae..efaf72d5e7 100644
--- a/tests/qemu-iotests/README
+++ b/tests/qemu-iotests/README
@@ -1,20 +1,54 @@
+= This is the QEMU I/O test suite =
 
-=== This is the QEMU I/O test suite ===
-
-* Intro
+== Intro ==
 
 This package contains a simple test suite for the I/O layer of qemu.
 It does not require a guest, but only the qemu, qemu-img and qemu-io
 binaries.  This does limit it to exercise the low-level I/O path only
 but no actual block drivers like ide, scsi or virtio.
 
-* Usage
+== Usage ==
 
 Just run ./check to run all tests for the raw image format, or ./check
 -qcow2 to test the qcow2 image format.  The output of ./check -h explains
 additional options to test further image formats or I/O methods.
 
-* Feedback and patches
+== Writing a QEMU I/O test ==
+
+It's a common practice to start with an existing test that may relate
+to the task you have.  QEMU I/O tests are usually written either in
+shell or Python, so it's also a good idea to pick an existing test
+based on your familiarity with those languages and/or what you
+anticipate about your test.
+
+You can find templates available at "sample_test_templates/", or you
+can start with an existing test, such as 001 (shell based) or 030
+(Python based).
+
+After you pick your template, name it as a three-digits file, starting
+with the next available one.  If `ls -1 ??? | sort -rn | head -1` gives
+you "197", name your test "198".  Finally, add an entry to the "group"
+file, which manages just that, test group classification, allowing a
+user to run all "quick" tests, for instance.
+
+=== Test configuration, expected results and reporting ===
+
+The tests are (mostly) standard executable files, that are executed by
+"./check" as such.  Tests get most of their configuration (directly or
+indirectly) by environment variables.  Some of the framework auxiliary
+code (for instance, "common.rc") defines or changes some of the
+environment variables.  You'll come across tests that reference
+"$TEST_IMG", "$QEMU_IO" and other variables.
+
+The expected results for a test are stored in a file named after the
+(sequential) test number.  For test 001, the expected output (stdout +
+stderr) is stored at 001.out.
+
+Tests that finish successfully should exit with status code 0.  To be
+considered a successful run, a test must also produce output that
+matches what is recorded in the expected output file (say, 001.out).
+
+== Feedback and patches ==
 
 Please send improvements to the test suite, general feedback or just
 reports of failing tests cases to qemu-devel@nongnu.org with a CC:
diff --git a/tests/qemu-iotests/sample_test_templates/sample.py b/tests/qemu-iotests/sample_test_templates/sample.py
new file mode 100755
index 0000000000..35a7410b5c
--- /dev/null
+++ b/tests/qemu-iotests/sample_test_templates/sample.py
@@ -0,0 +1,59 @@
+#!/usr/bin/env python
+#
+# DESCRIPTION HERE, such as "Test a complex thing using a simple thing"
+#
+# COPYRIGHT NOTICE HERE, such as "Copyright (C) YYYY Yourself, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+# Creator/Owner: your.email@example.com
+#
+
+import iotests
+
+
+class Sample(iotests.QMPTestCase):
+
+    def setUp(self):
+        """
+        Method that runs before test method(s).  Use it to prepare the
+        environment that is common to the all tests, but doesn't
+        necessarily mean that is part of the feature testing
+        specifics.
+
+        Remove this docstring unless you have a really good use for it.
+        """
+        pass
+
+    def tearDown(self):
+        """
+        Method that runs after the test method(s).  Use it to clean up
+        the environment created previously in setUp().
+
+        Remove this docstring unless you have a really good use for it.
+        """
+        pass
+
+    def test(self):
+        """
+        Test code goes here, or in any other method whose name starts
+        with "test".
+
+        It's a good idea to describe what it's about.
+        """
+        pass
+
+
+if __name__ == '__main__':
+    iotests.main()
diff --git a/tests/qemu-iotests/sample_test_templates/sample.sh b/tests/qemu-iotests/sample_test_templates/sample.sh
new file mode 100755
index 0000000000..d50e228efc
--- /dev/null
+++ b/tests/qemu-iotests/sample_test_templates/sample.sh
@@ -0,0 +1,40 @@
+#!/bin/bash
+#
+# DESCRIPTION HERE, such as "Test a complex thing using a simple thing"
+#
+# COPYRIGHT NOTICE HERE, such as "Copyright (C) YYYY Yourself, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+# Creator/Owner: your.email@example.com
+#
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+
+# get standard environment, filters and checks
+. ./common.rc
+
+# describe supported environment, and then remove this line.
+ _supported_fmt generic
+ _supported_proto generic
+ _supported_os Linux
+
+# put your test code goes here, and then remove this line.
+
+# success, all done
+echo "*** done"
+status=0
-- 
2.13.6
