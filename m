Received: from eggs.gnu.org ([2001:4830:134:3::10]:40051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diEFx-000299-6s
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 02:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diEFu-0007F9-2J
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 02:26:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1diEFt-0007Ei-PG
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 02:26:09 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 17 Aug 2017 08:25:13 +0200
Message-Id: <1502951113-4246-7-git-send-email-thuth@redhat.com>
In-Reply-To: <1502951113-4246-1-git-send-email-thuth@redhat.com>
References: <1502951113-4246-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 6/6] tests: Enable the simple virtio tests on
 s390x, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Eric Farman <farman@linux.vnet.ibm.com>, Fan Zhang <zhangfan@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Marc Mari <markmb@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael S Tsirkin <mst@redhat.com>

Most of the simple virtio test can be used on virtio-ccw on
s390x, too, by simply using the bus-independent alias names
of the devices instead of the device names ending in "-pci".
Hot-plugging can also be tested here - we just have to use
the generic hot plug function instead of the PCI hot plug
function in the qvirtio_plug_device_test() function.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include      |  4 ++++
 tests/libqos/virtio.c       |  4 +++-
 tests/virtio-balloon-test.c |  6 +++---
 tests/virtio-console-test.c | 12 ++++++------
 tests/virtio-rng-test.c     | 10 +++++-----
 tests/virtio-serial-test.c  |  8 ++++----
 6 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index e3acdff..ac24aa6 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -364,6 +364,10 @@ check-qtest-s390x-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
 check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
 check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
 check-qtest-s390x-y += tests/drive_del-test$(EXESUF)
+check-qtest-s390x-y += tests/virtio-balloon-test$(EXESUF)
+check-qtest-s390x-y += tests/virtio-console-test$(EXESUF)
+check-qtest-s390x-y += tests/virtio-rng-test$(EXESUF)
+check-qtest-s390x-y += tests/virtio-serial-test$(EXESUF)
 
 check-qtest-generic-y += tests/qom-test$(EXESUF)
 check-qtest-generic-y += tests/test-hmp$(EXESUF)
diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index 87d2e65..5ff9ad6 100644
--- a/tests/libqos/virtio.c
+++ b/tests/libqos/virtio.c
@@ -349,6 +349,8 @@ void qvirtio_plug_device_test(const char *driver, const char *id,
     if (g_str_equal(arch, "i386") || g_str_equal(arch, "x86_64") ||
         g_str_equal(arch, "ppc64")) {
         qpci_plug_device_test(driver, id, addr, opts);
+    } else if (g_str_equal(arch, "s390x")) {
+        qtest_hot_plug_device(driver, id, opts ? "%s" : NULL,  opts);
     } else {
         g_assert_not_reached();
     }
@@ -360,7 +362,7 @@ void qvirtio_unplug_device_test(const char *id, uint8_t addr)
 
     if (g_str_equal(arch, "i386") || g_str_equal(arch, "x86_64")) {
         qpci_unplug_acpi_device_test(id, addr);
-    } else if (g_str_equal(arch, "ppc64")) {
+    } else if (g_str_equal(arch, "ppc64") || g_str_equal(arch, "s390x")) {
         qtest_hot_unplug_device(id);
     } else {
         g_assert_not_reached();
diff --git a/tests/virtio-balloon-test.c b/tests/virtio-balloon-test.c
index 0d0046b..45c95dd 100644
--- a/tests/virtio-balloon-test.c
+++ b/tests/virtio-balloon-test.c
@@ -11,7 +11,7 @@
 #include "libqtest.h"
 
 /* Tests only initialization so far. TODO: Replace with functional tests */
-static void pci_nop(void)
+static void balloon_nop(void)
 {
 }
 
@@ -20,9 +20,9 @@ int main(int argc, char **argv)
     int ret;
 
     g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/virtio/balloon/pci/nop", pci_nop);
+    qtest_add_func("/virtio/balloon/nop", balloon_nop);
 
-    qtest_start("-device virtio-balloon-pci");
+    qtest_start("-device virtio-balloon");
     ret = g_test_run();
 
     qtest_end();
diff --git a/tests/virtio-console-test.c b/tests/virtio-console-test.c
index 1c3de07..d15e182 100644
--- a/tests/virtio-console-test.c
+++ b/tests/virtio-console-test.c
@@ -11,16 +11,16 @@
 #include "libqtest.h"
 
 /* Tests only initialization so far. TODO: Replace with functional tests */
-static void console_pci_nop(void)
+static void console_nop(void)
 {
-    qtest_start("-device virtio-serial-pci,id=vser0 "
+    qtest_start("-device virtio-serial,id=vser0 "
                 "-device virtconsole,bus=vser0.0");
     qtest_end();
 }
 
-static void serialport_pci_nop(void)
+static void serialport_nop(void)
 {
-    qtest_start("-device virtio-serial-pci,id=vser0 "
+    qtest_start("-device virtio-serial,id=vser0 "
                 "-device virtserialport,bus=vser0.0");
     qtest_end();
 }
@@ -28,8 +28,8 @@ static void serialport_pci_nop(void)
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/virtio/console/pci/nop", console_pci_nop);
-    qtest_add_func("/virtio/serialport/pci/nop", serialport_pci_nop);
+    qtest_add_func("/virtio/console/nop", console_nop);
+    qtest_add_func("/virtio/serialport/nop", serialport_nop);
 
     return g_test_run();
 }
diff --git a/tests/virtio-rng-test.c b/tests/virtio-rng-test.c
index 04c4279..b58352e 100644
--- a/tests/virtio-rng-test.c
+++ b/tests/virtio-rng-test.c
@@ -15,13 +15,13 @@
 #define PCI_SLOT_HP             0x06
 
 /* Tests only initialization so far. TODO: Replace with functional tests */
-static void pci_nop(void)
+static void rng_nop(void)
 {
 }
 
 static void hotplug(void)
 {
-    qvirtio_plug_device_test("virtio-rng-pci", "rng1", PCI_SLOT_HP, NULL);
+    qvirtio_plug_device_test("virtio-rng", "rng1", PCI_SLOT_HP, NULL);
 
     qvirtio_unplug_device_test("rng1", PCI_SLOT_HP);
 }
@@ -31,10 +31,10 @@ int main(int argc, char **argv)
     int ret;
 
     g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/virtio/rng/pci/nop", pci_nop);
-    qtest_add_func("/virtio/rng/pci/hotplug", hotplug);
+    qtest_add_func("/virtio/rng/nop", rng_nop);
+    qtest_add_func("/virtio/rng/hotplug", hotplug);
 
-    qtest_start("-device virtio-rng-pci");
+    qtest_start("-device virtio-rng");
     ret = g_test_run();
 
     qtest_end();
diff --git a/tests/virtio-serial-test.c b/tests/virtio-serial-test.c
index 97f8f52..059f211 100644
--- a/tests/virtio-serial-test.c
+++ b/tests/virtio-serial-test.c
@@ -11,7 +11,7 @@
 #include "libqtest.h"
 
 /* Tests only initialization so far. TODO: Replace with functional tests */
-static void pci_nop(void)
+static void virtioserial_nop(void)
 {
 }
 
@@ -27,10 +27,10 @@ int main(int argc, char **argv)
     int ret;
 
     g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/virtio/serial/pci/nop", pci_nop);
-    qtest_add_func("/virtio/serial/pci/hotplug", hotplug);
+    qtest_add_func("/virtio/serial/nop", virtioserial_nop);
+    qtest_add_func("/virtio/serial/hotplug", hotplug);
 
-    qtest_start("-device virtio-serial-pci");
+    qtest_start("-device virtio-serial");
     ret = g_test_run();
 
     qtest_end();
-- 
1.8.3.1
