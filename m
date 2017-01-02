Received: from eggs.gnu.org ([2001:4830:134:3::10]:33313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cO8oJ-0001r2-EL
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:02:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cO8oH-0003vc-U9
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:02:23 -0500
From: Andrew Jones <drjones@redhat.com>
Date: Mon,  2 Jan 2017 21:01:46 +0100
Message-Id: <20170102200153.28864-10-drjones@redhat.com>
In-Reply-To: <20170102200153.28864-1-drjones@redhat.com>
References: <20170102200153.28864-1-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/16] hw/arm/virt: move
 VirtMachineState/Class to virt.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: imammedo@redhat.com, peter.maydell@linaro.org, zhaoshenglong@huawei.com, shannon.zhao@linaro.org, mst@redhat.com, ehabkost@redhat.com

In preparation to share more Virt machine state than just guest-info
with other mach-virt source files, move the State and Class structures
to virt.h

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/arm/virt.c         | 52 +++++++--------------------------------------------
 include/hw/arm/virt.h | 39 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 45 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e51c1668e16e..51cb094d80f7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -41,7 +41,6 @@
 #include "sysemu/numa.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
-#include "hw/boards.h"
 #include "hw/compat.h"
 #include "hw/loader.h"
 #include "exec/address-spaces.h"
@@ -58,50 +57,6 @@
 #include "qapi/visitor.h"
 #include "standard-headers/linux/input.h"
 
-/* Number of external interrupt lines to configure the GIC with */
-#define NUM_IRQS 256
-
-#define PLATFORM_BUS_NUM_IRQS 64
-
-static ARMPlatformBusSystemParams platform_bus_params;
-
-typedef struct {
-    MachineClass parent;
-    bool disallow_affinity_adjustment;
-    bool no_its;
-    bool no_pmu;
-    bool claim_edge_triggered_timers;
-} VirtMachineClass;
-
-typedef struct {
-    MachineState parent;
-    VirtGuestInfo acpi_guest_info;
-    Notifier machine_done;
-    bool secure;
-    bool highmem;
-    bool virt;
-    int32_t gic_version;
-    struct arm_boot_info bootinfo;
-    const MemMapEntry *memmap;
-    const int *irqmap;
-    int smp_cpus;
-    void *fdt;
-    int fdt_size;
-    uint32_t clock_phandle;
-    uint32_t gic_phandle;
-    uint32_t msi_phandle;
-    int psci_conduit;
-} VirtMachineState;
-
-#define TYPE_VIRT_MACHINE   MACHINE_TYPE_NAME("virt")
-#define VIRT_MACHINE(obj) \
-    OBJECT_CHECK(VirtMachineState, (obj), TYPE_VIRT_MACHINE)
-#define VIRT_MACHINE_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(VirtMachineClass, obj, TYPE_VIRT_MACHINE)
-#define VIRT_MACHINE_CLASS(klass) \
-    OBJECT_CLASS_CHECK(VirtMachineClass, klass, TYPE_VIRT_MACHINE)
-
-
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
                                                     void *data) \
@@ -131,6 +86,13 @@ typedef struct {
     DEFINE_VIRT_MACHINE_LATEST(major, minor, false)
 
 
+/* Number of external interrupt lines to configure the GIC with */
+#define NUM_IRQS 256
+
+#define PLATFORM_BUS_NUM_IRQS 64
+
+static ARMPlatformBusSystemParams platform_bus_params;
+
 /* RAM limit in GB. Since VIRT_MEM starts at the 1GB mark, this means
  * RAM can go up to the 256GB mark, leaving 256GB of the physical
  * address space unallocated and free for future use between 256G and 512G.
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 248ba6f755a3..59ce353f5e71 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -33,6 +33,8 @@
 #include "qemu-common.h"
 #include "exec/hwaddr.h"
 #include "qemu/notify.h"
+#include "hw/boards.h"
+#include "hw/arm/arm.h"
 
 #define NUM_GICV2M_SPIS       64
 #define NUM_VIRTIO_TRANSPORTS 32
@@ -87,6 +89,43 @@ typedef struct VirtGuestInfo {
     bool no_its;
 } VirtGuestInfo;
 
+typedef struct {
+    MachineClass parent;
+    bool disallow_affinity_adjustment;
+    bool no_its;
+    bool no_pmu;
+    bool claim_edge_triggered_timers;
+} VirtMachineClass;
+
+typedef struct {
+    MachineState parent;
+    VirtGuestInfo acpi_guest_info;
+    Notifier machine_done;
+    bool secure;
+    bool highmem;
+    bool virt;
+    int32_t gic_version;
+    struct arm_boot_info bootinfo;
+    const MemMapEntry *memmap;
+    const int *irqmap;
+    int smp_cpus;
+    void *fdt;
+    int fdt_size;
+    uint32_t clock_phandle;
+    uint32_t gic_phandle;
+    uint32_t msi_phandle;
+    int psci_conduit;
+} VirtMachineState;
+
+#define TYPE_VIRT_MACHINE   MACHINE_TYPE_NAME("virt")
+#define VIRT_MACHINE(obj) \
+    OBJECT_CHECK(VirtMachineState, (obj), TYPE_VIRT_MACHINE)
+#define VIRT_MACHINE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(VirtMachineClass, obj, TYPE_VIRT_MACHINE)
+#define VIRT_MACHINE_CLASS(klass) \
+    OBJECT_CLASS_CHECK(VirtMachineClass, klass, TYPE_VIRT_MACHINE)
+
+
 void virt_acpi_setup(VirtGuestInfo *guest_info);
 
 #endif /* QEMU_ARM_VIRT_H */
-- 
2.9.3
