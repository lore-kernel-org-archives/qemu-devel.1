Received: from eggs.gnu.org ([2001:4830:134:3::10]:35777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHG6X-0000SH-3X
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 18:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHG6W-0006mN-0G
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 18:33:48 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 29 Oct 2018 23:32:06 +0100
Message-Id: <20181029223207.31878-3-philmd@redhat.com>
In-Reply-To: <20181029223207.31878-1-philmd@redhat.com>
References: <20181029223207.31878-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] usb: ehci: Add support for Allwinner A10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Icenowy Zheng <icenowy@aosc.xyz>, Guenter Roeck <linux@roeck-us.net>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Guenter Roeck <linux@roeck-us.net>

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Gerd: You already review this code here:
https://lists.gnu.org/archive/html/qemu-arm/2017-01/msg00345.html
Can we use your R-b again?

 hw/usb/hcd-ehci-sysbus.c | 17 +++++++++++++++++
 hw/usb/hcd-ehci.h        |  1 +
 2 files changed, 18 insertions(+)

diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index 3b83beb140..87fac9de01 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -110,6 +110,22 @@ static const TypeInfo ehci_xlnx_type_info =3D {
     .class_init    =3D ehci_xlnx_class_init,
 };
=20
+static void ehci_aw_a10_class_init(ObjectClass *oc, void *data)
+{
+    SysBusEHCIClass *sec =3D SYS_BUS_EHCI_CLASS(oc);
+    DeviceClass *dc =3D DEVICE_CLASS(oc);
+
+    sec->capsbase =3D 0x0;
+    sec->opregbase =3D 0x10;
+    set_bit(DEVICE_CATEGORY_USB, dc->categories);
+}
+
+static const TypeInfo ehci_aw_a10_type_info =3D {
+    .name          =3D TYPE_AW_A10_EHCI,
+    .parent        =3D TYPE_SYS_BUS_EHCI,
+    .class_init    =3D ehci_aw_a10_class_init,
+};
+
 static void ehci_exynos4210_class_init(ObjectClass *oc, void *data)
 {
     SysBusEHCIClass *sec =3D SYS_BUS_EHCI_CLASS(oc);
@@ -246,6 +262,7 @@ static void ehci_sysbus_register_types(void)
 {
     type_register_static(&ehci_type_info);
     type_register_static(&ehci_xlnx_type_info);
+    type_register_static(&ehci_aw_a10_type_info);
     type_register_static(&ehci_exynos4210_type_info);
     type_register_static(&ehci_tegra2_type_info);
     type_register_static(&ehci_ppc4xx_type_info);
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index 0bc364b286..8d78864a82 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -342,6 +342,7 @@ typedef struct EHCIPCIState {
=20
=20
 #define TYPE_SYS_BUS_EHCI "sysbus-ehci-usb"
+#define TYPE_AW_A10_EHCI "aw-a10-ehci-usb"
 #define TYPE_EXYNOS4210_EHCI "exynos4210-ehci-usb"
 #define TYPE_TEGRA2_EHCI "tegra2-ehci-usb"
 #define TYPE_PPC4xx_EHCI "ppc4xx-ehci-usb"
--=20
2.17.2
