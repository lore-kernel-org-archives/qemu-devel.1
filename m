Received: from eggs.gnu.org ([208.118.235.92]:35863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1gdBY1-0001Le-7W
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 05:08:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1gdBQd-0006PV-JL
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 05:01:17 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:40196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1gdBQc-0006Mx-VI
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 05:01:11 -0500
Received: by mail-pg1-x543.google.com with SMTP id z10so10994067pgp.7
	for <qemu-devel@nongnu.org>; Sat, 29 Dec 2018 02:01:10 -0800 (PST)
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Sat, 29 Dec 2018 18:00:57 +0800
Message-Id: <1546077657-22637-1-git-send-email-hongbo.zhang@linaro.org>
Subject: [Qemu-devel] [PATCH] hw/usb: Add generic sys-bus EHCI controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ard.biesheuvel@linaro.org, leif.lindholm@linaro.org, radoslaw.biernacki@linaro.org, Hongbo Zhang <hongbo.zhang@linaro.org>

This patch introduces a new system bus generic EHCI controller.
For the system bus EHCI controller, we've already had "xlnx",
"exynos4210", "tegra2", "ppc4xx" and "fusbh200", they are specific and
only suitable for their own platforms, platforms such as an Arm server,
may need a generic system bus EHCI controller, this patch creates it,
and the kernel driver ehci_platform.c works well on it.

Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
---
 hw/usb/hcd-ehci-sysbus.c | 17 +++++++++++++++++
 hw/usb/hcd-ehci.h        |  1 +
 2 files changed, 18 insertions(+)

diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index 3b83beb..331faf8 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -94,6 +94,22 @@ static const TypeInfo ehci_type_info = {
     .class_size    = sizeof(SysBusEHCIClass),
 };
 
+static void ehci_platform_class_init(ObjectClass *oc, void *data)
+{
+    SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    sec->capsbase = 0x0;
+    sec->opregbase = 0x20;
+    set_bit(DEVICE_CATEGORY_USB, dc->categories);
+}
+
+static const TypeInfo ehci_platform_type_info = {
+    .name          = TYPE_PLATFORM_EHCI,
+    .parent        = TYPE_SYS_BUS_EHCI,
+    .class_init    = ehci_platform_class_init,
+};
+
 static void ehci_xlnx_class_init(ObjectClass *oc, void *data)
 {
     SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
@@ -245,6 +261,7 @@ static const TypeInfo ehci_fusbh200_type_info = {
 static void ehci_sysbus_register_types(void)
 {
     type_register_static(&ehci_type_info);
+    type_register_static(&ehci_platform_type_info);
     type_register_static(&ehci_xlnx_type_info);
     type_register_static(&ehci_exynos4210_type_info);
     type_register_static(&ehci_tegra2_type_info);
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index 0bc364b..cd30b5d 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -342,6 +342,7 @@ typedef struct EHCIPCIState {
 
 
 #define TYPE_SYS_BUS_EHCI "sysbus-ehci-usb"
+#define TYPE_PLATFORM_EHCI "platform-ehci-usb"
 #define TYPE_EXYNOS4210_EHCI "exynos4210-ehci-usb"
 #define TYPE_TEGRA2_EHCI "tegra2-ehci-usb"
 #define TYPE_PPC4xx_EHCI "ppc4xx-ehci-usb"
-- 
2.7.4
