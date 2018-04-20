Received: from eggs.gnu.org ([2001:4830:134:3::10]:38939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9agI-0006b7-G5
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:22:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9agD-0003k7-Ho
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:22:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f9agD-0003i4-9P
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:22:41 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 20 Apr 2018 15:19:41 -0300
Message-Id: <20180420181951.7252-15-ehabkost@redhat.com>
In-Reply-To: <20180420181951.7252-1-ehabkost@redhat.com>
References: <20180420181951.7252-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 14/24] avocado_qemu: Functional test for
 RHBZ#1447027
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Alistair Francis <alistair23@gmail.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>

From: Amador Pahim <apahim@redhat.com>

Fixed in commit e85c0d1.

According to the RHBZ1447027, the issue is: guest cannot boot with 240
or above vcpus when using ovmf.

Test consists in set the VM with 240 vcpus and the OVMF device to then
check whether the VM can be started.

A parameters.yaml file is provided in order to customize the OVMF files
locations. Execute with:

    $ avocado run test_ovmf_with_240_vcpus.py -m \
     test_ovmf_with_240_vcpus.py.data/parameters.yaml

Signed-off-by: Amador Pahim <apahim@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/avocado/test_ovmf_with_240_vcpus.py          | 70 ++++++++++++++++++++++
 .../parameters.yaml                                |  2 +
 2 files changed, 72 insertions(+)
 create mode 100644 tests/avocado/test_ovmf_with_240_vcpus.py
 create mode 100644 tests/avocado/test_ovmf_with_240_vcpus.py.data/parameters.yaml

diff --git a/tests/avocado/test_ovmf_with_240_vcpus.py b/tests/avocado/test_ovmf_with_240_vcpus.py
new file mode 100644
index 0000000000..da688dbc76
--- /dev/null
+++ b/tests/avocado/test_ovmf_with_240_vcpus.py
@@ -0,0 +1,70 @@
+import os
+import shutil
+import sys
+
+from avocado import main
+from avocado_qemu import test
+
+
+class TestOvmfVcpus(test.QemuTest):
+    """
+    Run with:
+
+        avocado run test_ovmf_with_240_vcpus.py \
+        -m test_ovmf_with_240_vcpus.py.data/parameters.yaml
+
+    :avocado: enable
+    :avocado: tags=ovmf
+    """
+
+    def setUp(self):
+        ovmf_code_path = self.params.get('OVMF_CODE',
+                                         default='/usr/share/edk2/ovmf/OVMF_CODE.secboot.fd')
+        ovmf_vars_path = self.params.get('OVMF_VARS',
+                                         default='/usr/share/edk2/ovmf/OVMF_VARS.fd')
+        if not ovmf_code_path or not os.path.exists(ovmf_code_path):
+            basename = os.path.basename(__file__)
+            self.cancel('OVMF_CODE file not found. Set the correct '
+                        'path on "%s.data/parameters.yaml" and run this test '
+                        'with: "avocado run %s -m %s.data/parameters.yaml"' %
+                        (basename, basename, basename))
+        if not ovmf_vars_path or not os.path.exists(ovmf_vars_path):
+            basename = os.path.basename(__file__)
+            self.cancel('OVMF_VARS file not found. Set the correct '
+                        'path on "%s.data/parameters.yaml" and run this test '
+                        'with: "avocado run %s -m %s.data/parameters.yaml"' %
+                        (basename, basename, basename))
+
+        ovmf_vars_tmp = os.path.join(self.workdir,
+                                     os.path.basename(ovmf_vars_path))
+        if not os.path.exists(ovmf_vars_tmp):
+            shutil.copy(ovmf_vars_path, self.workdir)
+
+        self.vm.args.extend(['-drive',
+                             'file=%s,if=pflash,format=raw,readonly=on,unit=0' %
+                             ovmf_code_path])
+        self.vm.args.extend(['-drive',
+                             'file=%s,if=pflash,format=raw,unit=1' %
+                             ovmf_vars_tmp])
+
+        self.vm.args.extend(['-smp', '240'])
+
+    def test_run_vm(self):
+        """
+        According to the RHBZ1447027, the issue is: Guest cannot boot
+        with 240 or above vcpus when using ovmf.
+        Fixed in commit e85c0d14014514a2f0faeae5b4c23fab5b234de4.
+
+        :avocado: tags=RHBZ1447027
+        """
+
+        try:
+            self.vm.launch()
+        except Exception as details:
+            self.fail(details)
+
+    def tearDown(self):
+        self.vm.shutdown()
+
+if __name__ == "__main__":
+    avocado.main()
diff --git a/tests/avocado/test_ovmf_with_240_vcpus.py.data/parameters.yaml b/tests/avocado/test_ovmf_with_240_vcpus.py.data/parameters.yaml
new file mode 100644
index 0000000000..79f6da1d29
--- /dev/null
+++ b/tests/avocado/test_ovmf_with_240_vcpus.py.data/parameters.yaml
@@ -0,0 +1,2 @@
+OVMF_CODE: /usr/share/edk2/ovmf/OVMF_CODE.secboot.fd
+OVMF_VARS: /usr/share/edk2/ovmf/OVMF_VARS.fd
-- 
2.14.3
