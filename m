Received: from eggs.gnu.org ([2001:4830:134:3::10]:54960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOiX-0005eu-5R
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOiT-0007In-1P
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39328 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffOiS-0007Hk-S9
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 702DB77885
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:04:28 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 17 Jul 2018 14:04:07 +0200
Message-Id: <20180717120414.5852-8-quintela@redhat.com>
In-Reply-To: <20180717120414.5852-1-quintela@redhat.com>
References: <20180717120414.5852-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 07/14] check: Only test usb storage when it is
 compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/Makefile.include    | 2 +-
 tests/usb-hcd-uhci-test.c | 5 ++++-
 tests/usb-hcd-xhci-test.c | 4 ++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 6565206a78..9193945c24 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -284,7 +284,7 @@ check-qtest-i386-$(CONFIG_USB_OHCI) += tests/usb-hcd-ohci-test$(EXESUF)
 gcov-files-i386-$(CONFIG_USB_OHCI) += hw/usb/hcd-ohci.c
 check-qtest-i386-$(CONFIG_USB_UHCI) += tests/usb-hcd-uhci-test$(EXESUF)
 gcov-files-i386-$(CONFIG_USB_UHCI) += hw/usb/hcd-uhci.c
-check-qtest-i386-$(CONFIG_USB_EHCI) += tests/usb-hcd-ehci-test$(EXESUF)
+check-qtest-i386-$(call land, $(CONFIG_USB_EHCI), $(CONFIG_USB_STORAGE_BOT)) += tests/usb-hcd-ehci-test$(EXESUF)
 gcov-files-i386-$(CONFIG_USB_EHCI) += hw/usb/hcd-ehci.c
 gcov-files-i386-y += hw/usb/dev-hid.c
 gcov-files-i386-y += hw/usb/dev-storage.c
diff --git a/tests/usb-hcd-uhci-test.c b/tests/usb-hcd-uhci-test.c
index 6a7e5a2fed..bf996af6c6 100644
--- a/tests/usb-hcd-uhci-test.c
+++ b/tests/usb-hcd-uhci-test.c
@@ -46,12 +46,14 @@ static void test_uhci_hotplug(void)
     usb_test_hotplug("uhci", 2, test_port_2);
 }
 
+#ifdef CONFIG_USB_STORAGE_BOT
 static void test_usb_storage_hotplug(void)
 {
     qtest_qmp_device_add("usb-storage", "usbdev0", "'drive': 'drive0'");
 
     qtest_qmp_device_del("usbdev0");
 }
+#endif
 
 int main(int argc, char **argv)
 {
@@ -66,8 +68,9 @@ int main(int argc, char **argv)
     qtest_add_func("/uhci/pci/init", test_uhci_init);
     qtest_add_func("/uhci/pci/port1", test_port_1);
     qtest_add_func("/uhci/pci/hotplug", test_uhci_hotplug);
+#ifdef CONFIG_USB_STORAGE_BOT
     qtest_add_func("/uhci/pci/hotplug/usb-storage", test_usb_storage_hotplug);
-
+#endif
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         qs = qtest_pc_boot(cmd);
     } else if (strcmp(arch, "ppc64") == 0) {
diff --git a/tests/usb-hcd-xhci-test.c b/tests/usb-hcd-xhci-test.c
index be80c5f032..a8996800b2 100644
--- a/tests/usb-hcd-xhci-test.c
+++ b/tests/usb-hcd-xhci-test.c
@@ -21,6 +21,7 @@ static void test_xhci_hotplug(void)
     usb_test_hotplug("xhci", 1, NULL);
 }
 
+#ifdef CONFIG_USB_STORAGE_UAS
 static void test_usb_uas_hotplug(void)
 {
     qtest_qmp_device_add("usb-uas", "uas", NULL);
@@ -34,6 +35,7 @@ static void test_usb_uas_hotplug(void)
     qtest_qmp_device_del("scsihd");
     qtest_qmp_device_del("uas");
 }
+#endif
 
 #ifdef CONFIG_USB_SMARTCARD
 static void test_usb_ccid_hotplug(void)
@@ -54,7 +56,9 @@ int main(int argc, char **argv)
 
     qtest_add_func("/xhci/pci/init", test_xhci_init);
     qtest_add_func("/xhci/pci/hotplug", test_xhci_hotplug);
+#ifdef CONFIG_USB_STORAGE_UAS
     qtest_add_func("/xhci/pci/hotplug/usb-uas", test_usb_uas_hotplug);
+#endif
 #ifdef CONFIG_USB_SMARTCARD
     qtest_add_func("/xhci/pci/hotplug/usb-ccid", test_usb_ccid_hotplug);
 #endif
-- 
2.17.1
