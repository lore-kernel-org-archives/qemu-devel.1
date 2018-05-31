Received: from eggs.gnu.org ([2001:4830:134:3::10]:36827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fOTbj-0001lz-RU
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fOTbj-0006ap-3m
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:51:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35344 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fOTbi-0006af-VY
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:51:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 85DC97D83A
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 19:51:34 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 31 May 2018 21:51:19 +0200
Message-Id: <20180531195119.22021-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180531195119.22021-1-marcandre.lureau@redhat.com>
References: <20180531195119.22021-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/4] usb-hcd-xhci-test: add a test for ccid
 hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, spopovyc@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/usb-hcd-xhci-test.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/usb-hcd-xhci-test.c b/tests/usb-hcd-xhci-test.c
index 9c14e3053a..5b1b681bf2 100644
--- a/tests/usb-hcd-xhci-test.c
+++ b/tests/usb-hcd-xhci-test.c
@@ -35,6 +35,15 @@ static void test_usb_uas_hotplug(void)
     qtest_qmp_device_del("uas");
 }
=20
+static void test_usb_ccid_hotplug(void)
+{
+    qtest_qmp_device_add("usb-ccid", "ccid", NULL);
+    qtest_qmp_device_del("ccid");
+    /* check the device can be added again */
+    qtest_qmp_device_add("usb-ccid", "ccid", NULL);
+    qtest_qmp_device_del("ccid");
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -44,6 +53,7 @@ int main(int argc, char **argv)
     qtest_add_func("/xhci/pci/init", test_xhci_init);
     qtest_add_func("/xhci/pci/hotplug", test_xhci_hotplug);
     qtest_add_func("/xhci/pci/hotplug/usb-uas", test_usb_uas_hotplug);
+    qtest_add_func("/xhci/pci/hotplug/usb-ccid", test_usb_ccid_hotplug);
=20
     qtest_start("-device nec-usb-xhci,id=3Dxhci"
                 " -drive id=3Ddrive0,if=3Dnone,file=3Dnull-co://,format=3D=
raw");
--=20
2.17.1.906.g10fd178552
