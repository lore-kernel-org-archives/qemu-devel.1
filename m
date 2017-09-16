Received: from eggs.gnu.org ([2001:4830:134:3::10]:42170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dtDlp-0006fa-Rx
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 10:08:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dtDln-0003Tj-Uv
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 10:08:33 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:41147)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1dtDln-0003Sp-Lb
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 10:08:31 -0400
Message-Id: <5298dbefd8b22cce599b96979e752c77e32bbad7.1505570561.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1505570561.git.balaton@eik.bme.hu>
References: <cover.1505570561.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sat, 16 Sep 2017 16:02:41 +0200
Subject: [Qemu-devel] [PATCH v2 2/4] ehci: Add ppc4xx-ehci for the USB 2.0
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
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
---
v2: Added R-b from: http://lists.nongnu.org/archive/html/qemu-ppc/2017-08/msg00345.html

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
