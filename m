Received: from eggs.gnu.org ([2001:4830:134:3::10]:39809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1djUKy-00045A-Hh
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 13:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1djUKv-00053O-DM
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 13:48:36 -0400
Message-Id: <e6021f12f4e245dc2162a6ab479d416374efc799.1503249785.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1503249785.git.balaton@eik.bme.hu>
References: <cover.1503249785.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sun, 20 Aug 2017 19:23:05 +0200
Subject: [Qemu-devel] [PATCH 04/15] ehci: Add ppc4xx-ehci for the USB 2.0
 controller in embedded PPC SoCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Francois Revol <revol@free.fr>, Gerd Hoffmann <kraxel@redhat.com>

Some PPC SoCs have an EHCI with OHCI companion USB controller. Add a
new type for this similar to types used for other embedded SoCs.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/usb/hcd-ehci-sysbus.c | 25 +++++++++++++++++++++++++
 hw/usb/hcd-ehci.h        |  1 +
 2 files changed, 26 insertions(+)

diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index 6c20604..3b83beb 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -142,6 +142,30 @@ static const TypeInfo ehci_tegra2_type_info = {
     .class_init    = ehci_tegra2_class_init,
 };
 
+static void ehci_ppc4xx_init(Object *o)
+{
+    EHCISysBusState *s = SYS_BUS_EHCI(o);
+
+    s->ehci.companion_enable = true;
+}
+
+static void ehci_ppc4xx_class_init(ObjectClass *oc, void *data)
+{
+    SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    sec->capsbase = 0x0;
+    sec->opregbase = 0x10;
+    set_bit(DEVICE_CATEGORY_USB, dc->categories);
+}
+
+static const TypeInfo ehci_ppc4xx_type_info = {
+    .name          = TYPE_PPC4xx_EHCI,
+    .parent        = TYPE_SYS_BUS_EHCI,
+    .class_init    = ehci_ppc4xx_class_init,
+    .instance_init = ehci_ppc4xx_init,
+};
+
 /*
  * Faraday FUSBH200 USB 2.0 EHCI
  */
@@ -224,6 +248,7 @@ static void ehci_sysbus_register_types(void)
     type_register_static(&ehci_xlnx_type_info);
     type_register_static(&ehci_exynos4210_type_info);
     type_register_static(&ehci_tegra2_type_info);
+    type_register_static(&ehci_ppc4xx_type_info);
     type_register_static(&ehci_fusbh200_type_info);
 }
 
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index 821f1de..0bc364b 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -344,6 +344,7 @@ typedef struct EHCIPCIState {
 #define TYPE_SYS_BUS_EHCI "sysbus-ehci-usb"
 #define TYPE_EXYNOS4210_EHCI "exynos4210-ehci-usb"
 #define TYPE_TEGRA2_EHCI "tegra2-ehci-usb"
+#define TYPE_PPC4xx_EHCI "ppc4xx-ehci-usb"
 #define TYPE_FUSBH200_EHCI "fusbh200-ehci-usb"
 
 #define SYS_BUS_EHCI(obj) \
-- 
2.7.6
