Received: from eggs.gnu.org ([2001:4830:134:3::10]:37299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWU-0002Rf-Nt
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:54:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWT-00047y-JD
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:53:58 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cQYWT-00045M-Bn
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:53:57 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWN-0001Qd-Qj
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:53:51 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jan 2017 11:53:37 +0000
Message-Id: <1483962824-29185-15-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
References: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 14/21] hw/arm/virt: move VirtMachineState/Class
 to virt.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrew Jones <drjones@redhat.com>

In preparation to share more Virt machine state than just guest-info
with other mach-virt source files, move the State and Class structures
to virt.h

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20170102200153.28864-10-drjones@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h | 37 +++++++++++++++++++++++++++++++++++++
 hw/arm/virt.c         | 51 +++++++--------------------------------------------
 2 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 69f7847..91dbd69 100644
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
@@ -85,6 +87,41 @@ typedef struct VirtGuestInfo {
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
+    bool using_psci;
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
 void virt_acpi_setup(VirtGuestInfo *guest_info);
 
 #endif /* QEMU_ARM_VIRT_H */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1b88b50..8556ff2 100644
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
@@ -58,49 +57,6 @@
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
-    bool using_psci;
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
@@ -130,6 +86,13 @@ typedef struct {
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
-- 
2.7.4
