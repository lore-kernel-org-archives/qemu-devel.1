Received: from eggs.gnu.org ([2001:4830:134:3::10]:33181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cb6DP-0000Nw-2V
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:53:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cb6DO-0000Cy-0j
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:53:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cb6DN-0000CX-R3
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:53:49 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F021D4E4CF
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 13:53:49 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  7 Feb 2017 17:52:09 +0400
Message-Id: <20170207135211.15870-27-marcandre.lureau@redhat.com>
In-Reply-To: <20170207135211.15870-1-marcandre.lureau@redhat.com>
References: <20170207135211.15870-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 26/28] tests: fix usb-test leaks
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

Fix the usb tests leaks.

Spotted by ASAN.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/libqos/usb.h        |  1 +
 tests/libqos/usb.c        |  5 +++++
 tests/usb-hcd-ehci-test.c | 10 ++++++++++
 tests/usb-hcd-uhci-test.c |  1 +
 4 files changed, 17 insertions(+)

diff --git a/tests/libqos/usb.h b/tests/libqos/usb.h
index 423dcfd82f..297cfc564d 100644
--- a/tests/libqos/usb.h
+++ b/tests/libqos/usb.h
@@ -11,6 +11,7 @@ struct qhc {
 void qusb_pci_init_one(QPCIBus *pcibus, struct qhc *hc,
                        uint32_t devfn, int bar);
 void uhci_port_test(struct qhc *hc, int port, uint16_t expect);
+void uhci_deinit(struct qhc *hc);
=20
 void usb_test_hotplug(const char *bus_name, const int port,
                       void (*port_check)(void));
diff --git a/tests/libqos/usb.c b/tests/libqos/usb.c
index 98408d93f3..0cdfaecda7 100644
--- a/tests/libqos/usb.c
+++ b/tests/libqos/usb.c
@@ -24,6 +24,11 @@ void qusb_pci_init_one(QPCIBus *pcibus, struct qhc *hc=
, uint32_t devfn, int bar)
     hc->bar =3D qpci_iomap(hc->dev, bar, NULL);
 }
=20
+void uhci_deinit(struct qhc *hc)
+{
+    g_free(hc->dev);
+}
+
 void uhci_port_test(struct qhc *hc, int port, uint16_t expect)
 {
     uint16_t value =3D qpci_io_readw(hc->dev, hc->bar, 0x10 + 2 * port);
diff --git a/tests/usb-hcd-ehci-test.c b/tests/usb-hcd-ehci-test.c
index fba84b4bee..944eb1c088 100644
--- a/tests/usb-hcd-ehci-test.c
+++ b/tests/usb-hcd-ehci-test.c
@@ -61,6 +61,15 @@ static void test_init(void)
     qusb_pci_init_one(pcibus, &ehci1, QPCI_DEVFN(0x1d, 7), 0);
 }
=20
+static void test_deinit(void)
+{
+    uhci_deinit(&uhci1);
+    uhci_deinit(&uhci2);
+    uhci_deinit(&uhci3);
+    uhci_deinit(&ehci1);
+    qpci_free_pc(pcibus);
+}
+
 static void pci_uhci_port_1(void)
 {
     g_assert(pcibus !=3D NULL);
@@ -161,6 +170,7 @@ int main(int argc, char **argv)
=20
     test_init();
     ret =3D g_test_run();
+    test_deinit();
=20
     qtest_end();
=20
diff --git a/tests/usb-hcd-uhci-test.c b/tests/usb-hcd-uhci-test.c
index e956b9ccb7..f25bae5e6c 100644
--- a/tests/usb-hcd-uhci-test.c
+++ b/tests/usb-hcd-uhci-test.c
@@ -28,6 +28,7 @@ static void test_port(int port)
     g_assert(port > 0);
     qusb_pci_init_one(qs->pcibus, &uhci, QPCI_DEVFN(0x1d, 0), 4);
     uhci_port_test(&uhci, port - 1, UHCI_PORT_CCS);
+    uhci_deinit(&uhci);
 }
=20
 static void test_port_1(void)
--=20
2.11.0.295.gd7dffce1c.dirty
