Received: from eggs.gnu.org ([2001:4830:134:3::10]:54731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fT1Lp-0005i1-DL
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fT1Lo-00017g-7l
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:41:57 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 13 Jun 2018 10:41:48 +0200
Message-Id: <20180613084149.14523-3-kraxel@redhat.com>
In-Reply-To: <20180613084149.14523-1-kraxel@redhat.com>
References: <20180613084149.14523-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/3] hw/display: add standalone ramfb device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?L=C3=A1szl=C3=B3=20=C3=89rsek?= <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/display/ramfb.h    |  3 +++
 hw/arm/sysbus-fdt.c           |  7 +++++
 hw/arm/virt.c                 |  2 ++
 hw/display/ramfb-standalone.c | 62 +++++++++++++++++++++++++++++++++++++++++++
 hw/i386/pc_piix.c             |  2 ++
 hw/i386/pc_q35.c              |  2 ++
 hw/display/Makefile.objs      |  1 +
 7 files changed, 79 insertions(+)
 create mode 100644 hw/display/ramfb-standalone.c

diff --git a/include/hw/display/ramfb.h b/include/hw/display/ramfb.h
index a3d4c79942..b33a2c467b 100644
--- a/include/hw/display/ramfb.h
+++ b/include/hw/display/ramfb.h
@@ -6,4 +6,7 @@ typedef struct RAMFBState RAMFBState;
 void ramfb_display_update(QemuConsole *con, RAMFBState *s);
 RAMFBState *ramfb_setup(Error **errp);
 
+/* ramfb-standalone.c */
+#define TYPE_RAMFB_DEVICE "ramfb"
+
 #endif /* RAMFB_H */
diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
index e4c492ea44..277ed872e7 100644
--- a/hw/arm/sysbus-fdt.c
+++ b/hw/arm/sysbus-fdt.c
@@ -36,6 +36,7 @@
 #include "hw/vfio/vfio-platform.h"
 #include "hw/vfio/vfio-calxeda-xgmac.h"
 #include "hw/vfio/vfio-amd-xgbe.h"
+#include "hw/display/ramfb.h"
 #include "hw/arm/fdt.h"
 
 /*
@@ -406,12 +407,18 @@ static int add_amd_xgbe_fdt_node(SysBusDevice *sbdev, void *opaque)
 
 #endif /* CONFIG_LINUX */
 
+static int no_fdt_node(SysBusDevice *sbdev, void *opaque)
+{
+    return 0;
+}
+
 /* list of supported dynamic sysbus devices */
 static const NodeCreationPair add_fdt_node_functions[] = {
 #ifdef CONFIG_LINUX
     {TYPE_VFIO_CALXEDA_XGMAC, add_calxeda_midway_xgmac_fdt_node},
     {TYPE_VFIO_AMD_XGBE, add_amd_xgbe_fdt_node},
 #endif
+    {TYPE_RAMFB_DEVICE, no_fdt_node},
     {"", NULL}, /* last element */
 };
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f0a4fa004c..98b99cf236 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -36,6 +36,7 @@
 #include "hw/arm/virt.h"
 #include "hw/vfio/vfio-calxeda-xgmac.h"
 #include "hw/vfio/vfio-amd-xgbe.h"
+#include "hw/display/ramfb.h"
 #include "hw/devices.h"
 #include "net/net.h"
 #include "sysemu/device_tree.h"
@@ -1659,6 +1660,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 255;
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_CALXEDA_XGMAC);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_AMD_XGBE);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
     mc->pci_allow_0_address = true;
diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
new file mode 100644
index 0000000000..c0d241ba01
--- /dev/null
+++ b/hw/display/ramfb-standalone.c
@@ -0,0 +1,62 @@
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/loader.h"
+#include "hw/isa/isa.h"
+#include "hw/display/ramfb.h"
+#include "ui/console.h"
+#include "sysemu/sysemu.h"
+
+#define RAMFB(obj) OBJECT_CHECK(RAMFBStandaloneState, (obj), TYPE_RAMFB_DEVICE)
+
+typedef struct RAMFBStandaloneState {
+    SysBusDevice parent_obj;
+    QemuConsole *con;
+    RAMFBState *state;
+} RAMFBStandaloneState;
+
+static void display_update_wrapper(void *dev)
+{
+    RAMFBStandaloneState *ramfb = RAMFB(dev);
+
+    if (0 /* native driver active */) {
+        /* non-standalone device would run native display update here */;
+    } else {
+        ramfb_display_update(ramfb->con, ramfb->state);
+    }
+}
+
+static const GraphicHwOps wrapper_ops = {
+    .gfx_update = display_update_wrapper,
+};
+
+static void ramfb_realizefn(DeviceState *dev, Error **errp)
+{
+    RAMFBStandaloneState *ramfb = RAMFB(dev);
+
+    ramfb->con = graphic_console_init(dev, 0, &wrapper_ops, dev);
+    ramfb->state = ramfb_setup(errp);
+}
+
+static void ramfb_class_initfn(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
+    dc->realize = ramfb_realizefn;
+    dc->desc = "ram framebuffer standalone device";
+    dc->user_creatable = true;
+}
+
+static const TypeInfo ramfb_info = {
+    .name          = TYPE_RAMFB_DEVICE,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RAMFBStandaloneState),
+    .class_init    = ramfb_class_initfn,
+};
+
+static void ramfb_register_types(void)
+{
+    type_register_static(&ramfb_info);
+}
+
+type_init(ramfb_register_types)
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 3b87f3cedb..e9b6f064fb 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -28,6 +28,7 @@
 #include "hw/loader.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/apic.h"
+#include "hw/display/ramfb.h"
 #include "hw/smbios/smbios.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_ids.h"
@@ -423,6 +424,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
     m->desc = "Standard PC (i440FX + PIIX, 1996)";
     m->default_machine_opts = "firmware=bios-256k.bin";
     m->default_display = "std";
+    machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
 }
 
 static void pc_i440fx_3_0_machine_options(MachineClass *m)
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 087f2630f9..1a73e1848a 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -45,6 +45,7 @@
 #include "hw/i386/ich9.h"
 #include "hw/i386/amd_iommu.h"
 #include "hw/i386/intel_iommu.h"
+#include "hw/display/ramfb.h"
 #include "hw/smbios/smbios.h"
 #include "hw/ide/pci.h"
 #include "hw/ide/ahci.h"
@@ -305,6 +306,7 @@ static void pc_q35_machine_options(MachineClass *m)
     m->no_floppy = 1;
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
+    machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
     m->max_cpus = 288;
 }
 
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index 0af04985d2..fb8408c6d0 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -1,4 +1,5 @@
 common-obj-y += ramfb.o
+common-obj-y += ramfb-standalone.o
 
 common-obj-$(CONFIG_ADS7846) += ads7846.o
 common-obj-$(CONFIG_VGA_CIRRUS) += cirrus_vga.o
-- 
2.9.3
