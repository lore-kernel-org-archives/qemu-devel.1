Received: from eggs.gnu.org ([2001:4830:134:3::10]:39134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9agT-0006mO-MX
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9agR-0004MX-2H
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:22:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f9agQ-0004Kz-R5
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:22:55 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 20 Apr 2018 15:19:42 -0300
Message-Id: <20180420181951.7252-16-ehabkost@redhat.com>
In-Reply-To: <20180420181951.7252-1-ehabkost@redhat.com>
References: <20180420181951.7252-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 15/24] avocado_qemu: Functional test for
 RHBZ#1436616
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

Fixed in commit 243afe858b95765b98d16a1f0dd50dca262858ad.

According to the RHBZ1436616, the issue is: usb-storage device under
pci-bridge is unusable after migration.

Test consists in create a VM with an usb-storage device and check
whether it's still available after a live migration.

A parameters.yaml file is provided in order to customize the guest
image location and credentials. Execute with:

        avocado run test_nec-usb-xhci.py \
        -m test_nec-usb-xhci.py.data/parameters.yaml

Signed-off-by: Amador Pahim <apahim@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/avocado/test_nec-usb-xhci.py                 | 55 ++++++++++++++++++++++
 .../test_nec-usb-xhci.py.data/parameters.yaml      |  4 ++
 2 files changed, 59 insertions(+)
 create mode 100644 tests/avocado/test_nec-usb-xhci.py
 create mode 100644 tests/avocado/test_nec-usb-xhci.py.data/parameters.yaml

diff --git a/tests/avocado/test_nec-usb-xhci.py b/tests/avocado/test_nec-usb-xhci.py
new file mode 100644
index 0000000000..3f0d645032
--- /dev/null
+++ b/tests/avocado/test_nec-usb-xhci.py
@@ -0,0 +1,55 @@
+import copy
+import os
+import tempfile
+
+from avocado_qemu import test
+from avocado.utils import process
+
+class TestNecUsbXhci(test.QemuTest):
+    """
+    Run with:
+
+        avocado run test_nec-usb-xhci.py \
+        -m test_nec-usb-xhci.py.data/parameters.yaml
+
+    :avocado: enable
+    :avocado: tags=usbstorage
+    """
+
+    def setUp(self):
+        usbdevice = os.path.join(self.workdir, 'usb.img')
+        self.request_image()
+        process.run('dd if=/dev/zero of=%s bs=1M count=10' % usbdevice)
+        self.vm.args.extend(['-device', 'pci-bridge,id=bridge1,chassis_nr=1'])
+        self.vm.args.extend(['-device', 'nec-usb-xhci,id=xhci1,bus=bridge1,addr=0x3'])
+        self.vm.args.extend(['-drive', 'file=%s,format=raw,id=drive_usb,if=none' % usbdevice])
+        self.vm.args.extend(['-device', 'usb-storage,drive=drive_usb,id=device_usb,bus=xhci1.0'])
+        self.vm.launch()
+
+    def test_available_after_migration(self):
+        """
+        According to the RHBZ1436616, the issue is: usb-storage device
+        under pci-bridge is unusable after migration.
+
+        Fixed in commit 243afe858b95765b98d16a1f0dd50dca262858ad.
+
+        :avocado: tags=migration,RHBZ1436616
+        """
+        console = self.vm.get_console()
+        console.sendline('fdisk -l')
+        result = console.read_nonblocking()
+        console.close()
+        self.assertIn('Disk /dev/sdb: 10 MiB, 10485760 bytes, 20480 sectors',
+                      result)
+
+        self.vm_dst = self.vm.migrate()
+        console = self.vm_dst.get_console()
+        console.sendline('fdisk -l')
+        result = console.read_nonblocking()
+        console.close()
+        self.assertIn('Disk /dev/sdb: 10 MiB, 10485760 bytes, 20480 sectors',
+                      result)
+
+    def tearDown(self):
+        self.vm.shutdown()
+        self.vm_dst.shutdown()
diff --git a/tests/avocado/test_nec-usb-xhci.py.data/parameters.yaml b/tests/avocado/test_nec-usb-xhci.py.data/parameters.yaml
new file mode 100644
index 0000000000..37a4e9dc37
--- /dev/null
+++ b/tests/avocado/test_nec-usb-xhci.py.data/parameters.yaml
@@ -0,0 +1,4 @@
+machine_accel: kvm
+image_path: /var/lib/images/fedora-25.img
+image_user: root
+image_pass: p4ssw0rd
-- 
2.14.3
