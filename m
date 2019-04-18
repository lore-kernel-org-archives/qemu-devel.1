Received: from eggs.gnu.org ([209.51.188.92]:55065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGxzD-0005pE-BD
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 23:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGxz5-0005Ct-0l
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 23:45:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hGxz4-0005BF-7L
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 23:45:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 220F930992B8
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 03:45:07 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 18 Apr 2019 00:45:01 -0300
Message-Id: <20190418034501.5038-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] cpu: Fix crash with empty -cpu option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Fix the following crash:

  $ qemu-system-x86_64 -cpu ''
  qemu-system-x86_64: qom/cpu.c:291: cpu_class_by_name: \
      Assertion `cpu_model && cc->class_by_name' failed.

Regression test script included.

Fixes: commit 99193d8f2ef5 ("cpu: drop unnecessary NULL check and cpu_common_class_by_name()")
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 exec.c                              |  4 ++++
 tests/acceptance/empty_cpu_model.py | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 tests/acceptance/empty_cpu_model.py

diff --git a/exec.c b/exec.c
index 1ca95df9d8..d816b38863 100644
--- a/exec.c
+++ b/exec.c
@@ -999,6 +999,10 @@ const char *parse_cpu_option(MachineState *machine, const char *cpu_option)
     const char *cpu_type;
 
     model_pieces = g_strsplit(cpu_option, ",", 2);
+    if (!model_pieces[0]) {
+        error_report("-cpu option cannot be empty");
+        exit(1);
+    }
 
     cc = lookup_cpu_class(model_pieces[0], &error_fatal);
     cpu_type = object_class_get_name(OBJECT_CLASS(cc));
diff --git a/tests/acceptance/empty_cpu_model.py b/tests/acceptance/empty_cpu_model.py
new file mode 100644
index 0000000000..3f4f663582
--- /dev/null
+++ b/tests/acceptance/empty_cpu_model.py
@@ -0,0 +1,19 @@
+# Check for crash when using empty -cpu option
+#
+# Copyright (c) 2019 Red Hat, Inc.
+#
+# Author:
+#  Eduardo Habkost <ehabkost@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+import subprocess
+from avocado_qemu import Test
+
+class EmptyCPUModel(Test):
+    def test(self):
+        cmd = [self.qemu_bin, '-S', '-display', 'none', '-machine', 'none', '-cpu', '']
+        r = subprocess.run(cmd, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
+        self.assertEquals(r.returncode, 1, "QEMU exit code should be 1")
+        self.assertEquals(r.stdout, b'', "QEMU stdout should be empty")
+        self.assertNotEquals(r.stderr, b'', "QEMU stderr shouldn't be empty")
-- 
2.18.0.rc1.1.g3f1ff2140
