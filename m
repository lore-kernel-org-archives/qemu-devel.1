Received: from eggs.gnu.org ([2001:4830:134:3::10]:39330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gD7zH-00071K-Ax
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gD7z9-0003h3-Os
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:05:13 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu, 18 Oct 2018 15:04:34 +0200
Message-Id: <20181018130434.23237-5-philmd@redhat.com>
In-Reply-To: <20181018130434.23237-1-philmd@redhat.com>
References: <20181018130434.23237-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 4/4] hw/arm/virt: Use the pvpanic device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Wen Congyang <wency@cn.fujitsu.com>, Hu Tao <hutao@cn.fujitsu.com>, "open list:ARM" <qemu-arm@nongnu.org>

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
[PMD: Use TYPE_PVPANIC definition, split in 2 patches]
---
 default-configs/arm-softmmu.mak |  2 +-
 hw/arm/virt.c                   | 21 +++++++++++++++++++++
 include/hw/arm/virt.h           |  1 +
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index 2420491aac..def07fa095 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -43,7 +43,7 @@ CONFIG_USB_MUSB=3Dy
 CONFIG_USB_EHCI_SYSBUS=3Dy
 CONFIG_PLATFORM_BUS=3Dy
 CONFIG_VIRTIO_MMIO=3Dy
-
+CONFIG_PVPANIC=3Dy
 CONFIG_ARM11MPCORE=3Dy
 CONFIG_A9MPCORE=3Dy
 CONFIG_A15MPCORE=3Dy
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9f677825f9..40469e6785 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -59,6 +59,7 @@
 #include "qapi/visitor.h"
 #include "standard-headers/linux/input.h"
 #include "hw/arm/smmuv3.h"
+#include "hw/misc/pvpanic.h"
=20
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -140,6 +141,7 @@ static const MemMapEntry a15memmap[] =3D {
     [VIRT_UART] =3D               { 0x09000000, 0x00001000 },
     [VIRT_RTC] =3D                { 0x09010000, 0x00001000 },
     [VIRT_FW_CFG] =3D             { 0x09020000, 0x00000018 },
+    [VIRT_PVPANIC_MMIO] =3D       { 0x09020018, 0x00000002 },
     [VIRT_GPIO] =3D               { 0x09030000, 0x00001000 },
     [VIRT_SECURE_UART] =3D        { 0x09040000, 0x00001000 },
     [VIRT_SMMU] =3D               { 0x09050000, 0x00020000 },
@@ -802,6 +804,23 @@ static void create_gpio(const VirtMachineState *vms,=
 qemu_irq *pic)
     g_free(nodename);
 }
=20
+static void create_pvpanic_device(const VirtMachineState *vms)
+{
+    char *nodename;
+    hwaddr base =3D vms->memmap[VIRT_PVPANIC_MMIO].base;
+    hwaddr size =3D vms->memmap[VIRT_PVPANIC_MMIO].size;
+
+    sysbus_create_simple(TYPE_PVPANIC, base, NULL);
+
+    nodename =3D g_strdup_printf("/pvpanic-mmio@%" PRIx64, base);
+    qemu_fdt_add_subnode(vms->fdt, nodename);
+    qemu_fdt_setprop_string(vms->fdt, nodename,
+                            "compatible", "pvpanic,mmio");
+    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+                                 2, base, 2, size);
+    g_free(nodename);
+}
+
 static void create_virtio_devices(const VirtMachineState *vms, qemu_irq =
*pic)
 {
     int i;
@@ -1548,6 +1567,8 @@ static void machvirt_init(MachineState *machine)
=20
     create_pcie(vms, pic);
=20
+    create_pvpanic_device(vms);
+
     create_gpio(vms, pic);
=20
     /* Create mmio transports, so the user can create virtio backends
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 4cc57a7ef6..61cc3109b2 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -70,6 +70,7 @@ enum {
     VIRT_MMIO,
     VIRT_RTC,
     VIRT_FW_CFG,
+    VIRT_PVPANIC_MMIO,
     VIRT_PCIE,
     VIRT_PCIE_MMIO,
     VIRT_PCIE_PIO,
--=20
2.17.2
