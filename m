Received: from eggs.gnu.org ([209.51.188.92]:54727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHh-0001gz-5g
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHg-00013L-1n
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:17 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:44127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1DHf-00012D-NL
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:15 -0500
Received: by mail-wr1-x436.google.com with SMTP id w2so10238180wrt.11
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 08:51:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id 2sm10071495wrg.89.2019.03.05.08.51.13
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Mar 2019 08:51:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Mar 2019 16:50:47 +0000
Message-Id: <20190305165051.26860-19-peter.maydell@linaro.org>
In-Reply-To: <20190305165051.26860-1-peter.maydell@linaro.org>
References: <20190305165051.26860-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/22] hw/arm/virt: Dynamic memory map depending
 on RAM requirements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

Up to now the memory map has been static and the high IO region
base has always been 256GiB.

This patch modifies the virt_set_memmap() function, which freezes
the memory map, so that the high IO range base becomes floating,
located after the initial RAM and the device memory.

The function computes
- the base of the device memory,
- the size of the device memory,
- the high IO region base
- the highest GPA used in the memory map.

Entries of the high IO region are assigned a base address. The
device memory is initialized.

The highest GPA used in the memory map will be used at VM creation
to choose the requested IPA size.

Setting all the existing highmem IO regions beyond the RAM
allows to have a single contiguous RAM region (initial RAM and
possible hotpluggable device memory). That way we do not need
to do invasive changes in the EDK2 FW to support a dynamic
RAM base.

Still the user cannot request an initial RAM size greater than 255GB.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 20190304101339.25970-8-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h |  1 +
 hw/arm/virt.c         | 52 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index f3f7fae4acd..507517c603b 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -131,6 +131,7 @@ typedef struct {
     uint32_t msi_phandle;
     uint32_t iommu_phandle;
     int psci_conduit;
+    hwaddr highest_gpa;
 } VirtMachineState;
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9596c7c7f13..2e788a0361e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -59,6 +59,7 @@
 #include "qapi/visitor.h"
 #include "standard-headers/linux/input.h"
 #include "hw/arm/smmuv3.h"
+#include "hw/acpi/acpi.h"
 
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -107,8 +108,8 @@
  * of a terabyte of RAM will be doing it on a host with more than a
  * terabyte of physical address space.)
  */
-#define RAMLIMIT_GB 255
-#define RAMLIMIT_BYTES (RAMLIMIT_GB * 1024ULL * 1024 * 1024)
+#define LEGACY_RAMLIMIT_GB 255
+#define LEGACY_RAMLIMIT_BYTES (LEGACY_RAMLIMIT_GB * GiB)
 
 /* Addresses and sizes of our components.
  * 0..128MB is space for a flash device so we can run bootrom code such as UEFI.
@@ -149,7 +150,8 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_PCIE_MMIO] =          { 0x10000000, 0x2eff0000 },
     [VIRT_PCIE_PIO] =           { 0x3eff0000, 0x00010000 },
     [VIRT_PCIE_ECAM] =          { 0x3f000000, 0x01000000 },
-    [VIRT_MEM] =                { 0x40000000, RAMLIMIT_BYTES },
+    /* Actual RAM size depends on initial RAM and device memory settings */
+    [VIRT_MEM] =                { GiB, LEGACY_RAMLIMIT_BYTES },
 };
 
 /*
@@ -1370,7 +1372,8 @@ static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
 
 static void virt_set_memmap(VirtMachineState *vms)
 {
-    hwaddr base;
+    MachineState *ms = MACHINE(vms);
+    hwaddr base, device_memory_base, device_memory_size;
     int i;
 
     vms->memmap = extended_memmap;
@@ -1379,7 +1382,32 @@ static void virt_set_memmap(VirtMachineState *vms)
         vms->memmap[i] = base_memmap[i];
     }
 
-    base = 256 * GiB; /* Top of the legacy initial RAM region */
+    if (ms->ram_slots > ACPI_MAX_RAM_SLOTS) {
+        error_report("unsupported number of memory slots: %"PRIu64,
+                     ms->ram_slots);
+        exit(EXIT_FAILURE);
+    }
+
+    /*
+     * We compute the base of the high IO region depending on the
+     * amount of initial and device memory. The device memory start/size
+     * is aligned on 1GiB. We never put the high IO region below 256GiB
+     * so that if maxram_size is < 255GiB we keep the legacy memory map.
+     * The device region size assumes 1GiB page max alignment per slot.
+     */
+    device_memory_base =
+        ROUND_UP(vms->memmap[VIRT_MEM].base + ms->ram_size, GiB);
+    device_memory_size = ms->maxram_size - ms->ram_size + ms->ram_slots * GiB;
+
+    /* Base address of the high IO region */
+    base = device_memory_base + ROUND_UP(device_memory_size, GiB);
+    if (base < device_memory_base) {
+        error_report("maxmem/slots too huge");
+        exit(EXIT_FAILURE);
+    }
+    if (base < vms->memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES) {
+        base = vms->memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES;
+    }
 
     for (i = VIRT_LOWMEMMAP_LAST; i < ARRAY_SIZE(extended_memmap); i++) {
         hwaddr size = extended_memmap[i].size;
@@ -1389,6 +1417,13 @@ static void virt_set_memmap(VirtMachineState *vms)
         vms->memmap[i].size = size;
         base += size;
     }
+    vms->highest_gpa = base - 1;
+    if (device_memory_size > 0) {
+        ms->device_memory = g_malloc0(sizeof(*ms->device_memory));
+        ms->device_memory->base = device_memory_base;
+        memory_region_init(&ms->device_memory->mr, OBJECT(vms),
+                           "device-memory", device_memory_size);
+    }
 }
 
 static void machvirt_init(MachineState *machine)
@@ -1475,7 +1510,8 @@ static void machvirt_init(MachineState *machine)
     vms->smp_cpus = smp_cpus;
 
     if (machine->ram_size > vms->memmap[VIRT_MEM].size) {
-        error_report("mach-virt: cannot model more than %dGB RAM", RAMLIMIT_GB);
+        error_report("mach-virt: cannot model more than %dGB RAM",
+                     LEGACY_RAMLIMIT_GB);
         exit(1);
     }
 
@@ -1569,6 +1605,10 @@ static void machvirt_init(MachineState *machine)
     memory_region_allocate_system_memory(ram, NULL, "mach-virt.ram",
                                          machine->ram_size);
     memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base, ram);
+    if (machine->device_memory) {
+        memory_region_add_subregion(sysmem, machine->device_memory->base,
+                                    &machine->device_memory->mr);
+    }
 
     create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
 
-- 
2.20.1
