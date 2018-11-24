Received: from eggs.gnu.org ([2001:4830:134:3::10]:52498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gQTU8-0002Xf-Bf
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 03:40:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gQTSe-0000QF-G6
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 03:38:45 -0500
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Sun, 25 Nov 2018 01:00:19 +0800
Message-Id: <1543078821-16636-9-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1543078821-16636-1-git-send-email-peng.hao2@zte.com.cn>
References: <1543078821-16636-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH V8 08/10] hw/misc/pvpanic: preparing for adding
 configure interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, drjones@redhat.com, philmd@redhat.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peng Hao <peng.hao2@zte.com.cn>

Prepare for pvpanic-mmio configure interface.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 hw/arm/sysbus-fdt.c       | 2 ++
 hw/arm/virt.c             | 1 +
 hw/misc/pvpanic.c         | 7 +++++++
 include/hw/misc/pvpanic.h | 2 +-
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
index ad698d4..34577f3 100644
--- a/hw/arm/sysbus-fdt.c
+++ b/hw/arm/sysbus-fdt.c
@@ -38,6 +38,7 @@
 #include "hw/vfio/vfio-amd-xgbe.h"
 #include "hw/display/ramfb.h"
 #include "hw/arm/fdt.h"
+#include "hw/misc/pvpanic.h"
 
 /*
  * internal struct that contains the information to create dynamic
@@ -459,6 +460,7 @@ static const BindingEntry bindings[] = {
     VFIO_PLATFORM_BINDING("amd,xgbe-seattle-v1a", add_amd_xgbe_fdt_node),
 #endif
     TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_node),
+    TYPE_BINDING(TYPE_PVPANIC_MMIO, no_fdt_node),
     TYPE_BINDING("", NULL), /* last element */
 };
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 899131a..921220a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1785,6 +1785,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_AMD_XGBE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_PLATFORM);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PVPANIC_MMIO);
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
     mc->pci_allow_0_address = true;
diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index aaa8b0c..6fea162 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -121,10 +121,17 @@ static void pvpanic_mmio_initfn(Object *obj)
     sysbus_init_mmio(sbd, &s->mr);
 }
 
+static Property pvpanic_mmio_properties[] = {
+    DEFINE_PROP_UINT32("mmio", PVPanicMMIOState, base, 0x09070000),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void pvpanic_mmio_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->user_creatable = true;
+    dc->props = pvpanic_mmio_properties;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
index 1f20775..e733e1e 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -37,7 +37,7 @@ typedef struct PVPanicISAState {
 typedef struct PVPanicMMIOState {
     SysBusDevice parent_obj;
     /*<private>*/
-
+    uint32_t base;
     /* public */
     MemoryRegion mr;
 } PVPanicMMIOState;
-- 
1.8.3.1
