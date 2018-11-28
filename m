Received: from eggs.gnu.org ([2001:4830:134:3::10]:51666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gRqs8-00034Q-Ia
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 22:50:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gRqs7-00046h-P8
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 22:50:44 -0500
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Wed, 28 Nov 2018 20:12:50 +0800
Message-Id: <1543407172-16175-8-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1543407172-16175-1-git-send-email-peng.hao2@zte.com.cn>
References: <1543407172-16175-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH V10 7/9] hw/misc/pvpanic: preparing for adding
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
 hw/arm/sysbus-fdt.c |  2 ++
 hw/arm/virt.c       |  2 ++
 hw/misc/pvpanic.c   | 11 +++++++++--
 3 files changed, 13 insertions(+), 2 deletions(-)

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
index f2cb5de..1fd5941 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -59,6 +59,7 @@
 #include "qapi/visitor.h"
 #include "standard-headers/linux/input.h"
 #include "hw/arm/smmuv3.h"
+#include "hw/misc/pvpanic.h"
 
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -1783,6 +1784,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_CALXEDA_XGMAC);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_AMD_XGBE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PVPANIC_MMIO);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_PLATFORM);
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index c9382a8..b6b5c89 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -67,7 +67,7 @@ typedef struct PVPanicISAState {
 typedef struct PVPanicMMIOState {
     SysBusDevice parent_obj;
     /*<private>*/
-
+    uint32_t base;
     /* public */
     MemoryRegion mr;
 } PVPanicMMIOState;
@@ -151,10 +151,17 @@ static void pvpanic_mmio_initfn(Object *obj)
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
-
+
+    dc->user_creatable = true;
+    dc->props = pvpanic_mmio_properties;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
-- 
1.8.3.1
