Received: from eggs.gnu.org ([2001:4830:134:3::10]:33304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fI0-0003Ud-6e
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fHx-00035m-30
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:40:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f1fHw-00034j-Qs
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:40:53 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 29 Mar 2018 18:38:57 -0300
Message-Id: <20180329213857.15499-19-ehabkost@redhat.com>
In-Reply-To: <20180329213857.15499-1-ehabkost@redhat.com>
References: <20180329213857.15499-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 18/18] Collection of validator.py test cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel@redhat.com>, Amador Pahim <apahim@redhat.com>

These test case specifications demonstrate what kind of tests can
be specified using validator.py.

Most of them can replace existing unit tests written in C, and
device-crash-test.yaml can replace most of the functionality of
scripts/device-crash-test.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/validator/cpu.yaml               |  5 +++++
 tests/validator/device-add.yaml        | 17 +++++++++++++++++
 tests/validator/device-crash-test.yaml |  7 +++++++
 tests/validator/device-help.yaml       |  3 +++
 tests/validator/device-introspect.yaml | 23 +++++++++++++++++++++++
 tests/validator/device-list.yaml       | 10 ++++++++++
 tests/validator/just-help.yaml         |  3 +++
 7 files changed, 68 insertions(+)
 create mode 100644 tests/validator/cpu.yaml
 create mode 100644 tests/validator/device-add.yaml
 create mode 100644 tests/validator/device-crash-test.yaml
 create mode 100644 tests/validator/device-help.yaml
 create mode 100644 tests/validator/device-introspect.yaml
 create mode 100644 tests/validator/device-list.yaml
 create mode 100644 tests/validator/just-help.yaml

diff --git a/tests/validator/cpu.yaml b/tests/validator/cpu.yaml
new file mode 100644
index 0000000000..48032995ff
--- /dev/null
+++ b/tests/validator/cpu.yaml
@@ -0,0 +1,5 @@
+# Simply check if QEMU will run without errors using a CPU model:
+command-line: '$QEMU -S -cpu $CPU'
+expected-failures:
+    # "host" doesn't always work
+    - CPU: 'host'
diff --git a/tests/validator/device-add.yaml b/tests/validator/device-add.yaml
new file mode 100644
index 0000000000..b4c0daf70c
--- /dev/null
+++ b/tests/validator/device-add.yaml
@@ -0,0 +1,17 @@
+# This test specification will try device_add with all device types
+command-line: '$QEMU -S -machine $MACHINE,accel=$ACCEL'
+monitor-commands:
+- qmp:
+  - execute: 'device_add'
+    arguments:
+      driver: '$DEVICE'
+      id: 'test-device-for-$DEVICE'
+  - execute: 'device_del'
+    arguments:
+      id: 'test-device-for-$DEVICE'
+defaults:
+  MACHINE: 'none'
+  ACCEL: 'kvm:tcg'
+expected-failures:
+  - MACHINE: 'xenpv'
+  - MACHINE: 'xenfv'
diff --git a/tests/validator/device-crash-test.yaml b/tests/validator/device-crash-test.yaml
new file mode 100644
index 0000000000..edaab0ee8f
--- /dev/null
+++ b/tests/validator/device-crash-test.yaml
@@ -0,0 +1,7 @@
+# this is a very simple test case generator that will run QEMU
+# using all combinations of -machine and -device.
+# This replaces scripts/device-crash-test.
+# TODO: use a $MACHINE_OPT variable to make -machine optional
+command-line: '$QEMU -S -machine $MACHINE,accel=$ACCEL -device $DEVICE'
+
+#TODO: represent the whitelist from device-crash-test script somehow
diff --git a/tests/validator/device-help.yaml b/tests/validator/device-help.yaml
new file mode 100644
index 0000000000..95aa5c9f5b
--- /dev/null
+++ b/tests/validator/device-help.yaml
@@ -0,0 +1,3 @@
+# Just check if -device ...,help works:
+command-line: '$QEMU -device $DEVICE,help'
+qmp: false
diff --git a/tests/validator/device-introspect.yaml b/tests/validator/device-introspect.yaml
new file mode 100644
index 0000000000..f5b10aff9a
--- /dev/null
+++ b/tests/validator/device-introspect.yaml
@@ -0,0 +1,23 @@
+# This test specification is equivalent to "device/introspect/concrete" in
+# tests/device-introspect-test.c
+command-line: '$QEMU -S -machine $MACHINE,accel=$ACCEL'
+monitor-commands:
+- qmp:
+  - execute: 'device-list-properties'
+    arguments:
+      typename: '$DEVICE'
+- hmp: 'device_add $DEVICE,help'
+- hmp: 'info qom-tree'
+defaults:
+  MACHINE: 'none'
+  ACCEL: 'kvm:tcg'
+expected-failures:
+  - MACHINE: 'xenpv'
+  - MACHINE: 'xenfv'
+
+#TODO: the test runner could support something like:
+# extra-cases:
+#   # like "device/introspect/none":
+#   - DEVICE: 'nonexistent'
+#   # like "device/introspect/abstract":
+#   - DEVICE: 'device'
diff --git a/tests/validator/device-list.yaml b/tests/validator/device-list.yaml
new file mode 100644
index 0000000000..ac0004c05d
--- /dev/null
+++ b/tests/validator/device-list.yaml
@@ -0,0 +1,10 @@
+# this test specification is equivalent to the
+# "device/introspect/list" test case in device-introspect-test.c
+command-line: '$QEMU -nodefaults -machine none'
+monitor-commands:
+- qmp:
+  - execute: qom-list-types
+    arguments:
+      implements: 'device'
+      abstract: true
+- hmp: 'device_add help'
diff --git a/tests/validator/just-help.yaml b/tests/validator/just-help.yaml
new file mode 100644
index 0000000000..84ec8d7090
--- /dev/null
+++ b/tests/validator/just-help.yaml
@@ -0,0 +1,3 @@
+# just run $QEMU -help and ensure it won't crash
+command-line: '$QEMU -help'
+qmp: false
-- 
2.14.3
