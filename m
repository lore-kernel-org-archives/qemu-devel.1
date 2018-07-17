Received: from eggs.gnu.org ([2001:4830:134:3::10]:54959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOiX-0005ep-5G
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOiR-0007Fp-J3
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39326 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffOiR-0007FB-Fb
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F42D77885
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:04:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 17 Jul 2018 14:04:06 +0200
Message-Id: <20180717120414.5852-7-quintela@redhat.com>
In-Reply-To: <20180717120414.5852-1-quintela@redhat.com>
References: <20180717120414.5852-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 06/14] check: Only test usb smartcard when it
 is compiled in
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
 tests/usb-hcd-xhci-test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/usb-hcd-xhci-test.c b/tests/usb-hcd-xhci-test.c
index 5b1b681bf2..be80c5f032 100644
--- a/tests/usb-hcd-xhci-test.c
+++ b/tests/usb-hcd-xhci-test.c
@@ -35,6 +35,7 @@ static void test_usb_uas_hotplug(void)
     qtest_qmp_device_del("uas");
 }
 
+#ifdef CONFIG_USB_SMARTCARD
 static void test_usb_ccid_hotplug(void)
 {
     qtest_qmp_device_add("usb-ccid", "ccid", NULL);
@@ -43,6 +44,7 @@ static void test_usb_ccid_hotplug(void)
     qtest_qmp_device_add("usb-ccid", "ccid", NULL);
     qtest_qmp_device_del("ccid");
 }
+#endif
 
 int main(int argc, char **argv)
 {
@@ -53,8 +55,9 @@ int main(int argc, char **argv)
     qtest_add_func("/xhci/pci/init", test_xhci_init);
     qtest_add_func("/xhci/pci/hotplug", test_xhci_hotplug);
     qtest_add_func("/xhci/pci/hotplug/usb-uas", test_usb_uas_hotplug);
+#ifdef CONFIG_USB_SMARTCARD
     qtest_add_func("/xhci/pci/hotplug/usb-ccid", test_usb_ccid_hotplug);
-
+#endif
     qtest_start("-device nec-usb-xhci,id=xhci"
                 " -drive id=drive0,if=none,file=null-co://,format=raw");
     ret = g_test_run();
-- 
2.17.1
