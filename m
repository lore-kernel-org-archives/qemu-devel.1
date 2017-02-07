Received: from eggs.gnu.org ([2001:4830:134:3::10]:33174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cb6DO-0000Np-T8
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:53:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cb6DK-0000AN-8s
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:53:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cb6DK-00009Z-3N
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:53:46 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3850480F7C
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 13:53:46 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  7 Feb 2017 17:52:08 +0400
Message-Id: <20170207135211.15870-26-marcandre.lureau@redhat.com>
In-Reply-To: <20170207135211.15870-1-marcandre.lureau@redhat.com>
References: <20170207135211.15870-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 25/28] tests: allows to run single test in
 usb-hcd-ehci-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

pci_init() shouldn't be a test function, but instead called before any
test. This allows to run a single test with -p /x86_64/ehci/....

Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/usb-hcd-ehci-test.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/usb-hcd-ehci-test.c b/tests/usb-hcd-ehci-test.c
index 57af8a034e..fba84b4bee 100644
--- a/tests/usb-hcd-ehci-test.c
+++ b/tests/usb-hcd-ehci-test.c
@@ -50,11 +50,8 @@ static void ehci_port_test(struct qhc *hc, int port, u=
int32_t expect)
=20
 /* tests */
=20
-static void pci_init(void)
+static void test_init(void)
 {
-    if (pcibus) {
-        return;
-    }
     pcibus =3D qpci_init_pc(NULL);
     g_assert(pcibus !=3D NULL);
=20
@@ -142,7 +139,7 @@ int main(int argc, char **argv)
     int ret;
=20
     g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/ehci/pci/init", pci_init);
+
     qtest_add_func("/ehci/pci/uhci-port-1", pci_uhci_port_1);
     qtest_add_func("/ehci/pci/ehci-port-1", pci_ehci_port_1);
     qtest_add_func("/ehci/pci/ehci-config", pci_ehci_config);
@@ -161,6 +158,8 @@ int main(int argc, char **argv)
                 "-drive if=3Dnone,id=3Dusbcdrom,media=3Dcdrom "
                 "-device usb-tablet,bus=3Dich9-ehci-1.0,port=3D1,usb_ver=
sion=3D1 "
                 "-device usb-storage,bus=3Dich9-ehci-1.0,port=3D2,drive=3D=
usbcdrom ");
+
+    test_init();
     ret =3D g_test_run();
=20
     qtest_end();
--=20
2.11.0.295.gd7dffce1c.dirty
