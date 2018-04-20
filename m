Received: from eggs.gnu.org ([2001:4830:134:3::10]:39853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9ahF-0007Ut-GK
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:23:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9ahE-000731-H3
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:23:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f9ahE-00072b-Bh
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:23:44 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 20 Apr 2018 15:19:49 -0300
Message-Id: <20180420181951.7252-23-ehabkost@redhat.com>
In-Reply-To: <20180420181951.7252-1-ehabkost@redhat.com>
References: <20180420181951.7252-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 22/24] avocado_qemu: Tests fixes
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

- Using acell=KVM when we have a guest.
- Better resilience for the cases where live-migration fails.

Signed-off-by: Amador Pahim <apahim@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/avocado/test_nec-usb-xhci.py | 6 +++++-
 tests/avocado/test_numa_hotplug.py | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/avocado/test_nec-usb-xhci.py b/tests/avocado/test_nec-usb-xhci.py
index 1c4822544e..d3a2716eb4 100644
--- a/tests/avocado/test_nec-usb-xhci.py
+++ b/tests/avocado/test_nec-usb-xhci.py
@@ -18,8 +18,10 @@ class TestNecUsbXhci(test.QemuTest):
     """
 
     def setUp(self):
+        self.vm_dst = None
         self.image = vmimage.get()
         self.vm.add_image(self.image.path, cloudinit=True, snapshot=False)
+        self.vm.args.extend(['-machine', 'accel=kvm'])
 
         usbdevice = os.path.join(self.workdir, 'usb.img')
         process.run('dd if=/dev/zero of=%s bs=1M count=10' % usbdevice)
@@ -56,4 +58,6 @@ class TestNecUsbXhci(test.QemuTest):
 
     def tearDown(self):
         self.vm.shutdown()
-        self.vm_dst.shutdown()
+        if self.vm_dst is not None:
+            self.vm_dst.shutdown()
+        os.remove(self.image.path)
diff --git a/tests/avocado/test_numa_hotplug.py b/tests/avocado/test_numa_hotplug.py
index ee43e60089..1993f9b159 100644
--- a/tests/avocado/test_numa_hotplug.py
+++ b/tests/avocado/test_numa_hotplug.py
@@ -24,6 +24,7 @@ class TestNumaHotplug(test.QemuTest):
         self.image = vmimage.get()
         self.vm.add_image(self.image.path, cloudinit=True, snapshot=False)
 
+        self.vm.args.extend(['-machine', 'accel=kvm'])
         self.vm.args.extend(["-m", "4G,slots=208,maxmem=80G"])
         self.vm.args.extend(["-numa", "node"] * 16)
         self.vm.launch()
-- 
2.14.3
