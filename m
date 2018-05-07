Received: from eggs.gnu.org ([2001:4830:134:3::10]:38716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFjYV-0006lD-TS
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:04:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFjYU-0007zD-Kz
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:04:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fFjYU-0007yu-De
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:04:06 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  7 May 2018 14:03:13 -0300
Message-Id: <20180507170315.11497-11-ehabkost@redhat.com>
In-Reply-To: <20180507170315.11497-1-ehabkost@redhat.com>
References: <20180507170315.11497-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 10/12] spapr: rename "hotplug memory"
 terminology to "device memory"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

Let's make it clear at relevant places that we are dealing with device
memory. That it can be used for memory hotplug is just a special case.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180423165126.15441-11-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
[ehabkost: rebased series, solved conflicts at spapr.c]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/ppc/spapr.h |  4 ++--
 hw/ppc/spapr.c         | 26 +++++++++++++-------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 56ff02d32a..3388750fc7 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -747,8 +747,8 @@ int spapr_rng_populate_dt(void *fdt);
  */
 #define SPAPR_MAX_RAM_SLOTS     32
 
-/* 1GB alignment for hotplug memory region */
-#define SPAPR_HOTPLUG_MEM_ALIGN (1ULL << 30)
+/* 1GB alignment for device memory region */
+#define SPAPR_DEVICE_MEM_ALIGN (1ULL << 30)
 
 /*
  * Number of 32 bit words in each LMB list entry in ibm,dynamic-memory
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4576ad63bc..a1abcba6ad 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -791,7 +791,7 @@ static int spapr_populate_drmem_v1(sPAPRMachineState *spapr, void *fdt,
     MachineState *machine = MACHINE(spapr);
     int i, ret;
     uint64_t lmb_size = SPAPR_MEMORY_BLOCK_SIZE;
-    uint32_t hotplug_lmb_start = machine->device_memory->base / lmb_size;
+    uint32_t device_lmb_start = machine->device_memory->base / lmb_size;
     uint32_t nr_lmbs = (machine->device_memory->base +
                        memory_region_size(&machine->device_memory->mr)) /
                        lmb_size;
@@ -808,7 +808,7 @@ static int spapr_populate_drmem_v1(sPAPRMachineState *spapr, void *fdt,
         uint64_t addr = i * lmb_size;
         uint32_t *dynamic_memory = cur_index;
 
-        if (i >= hotplug_lmb_start) {
+        if (i >= device_lmb_start) {
             sPAPRDRConnector *drc;
 
             drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, i);
@@ -827,7 +827,7 @@ static int spapr_populate_drmem_v1(sPAPRMachineState *spapr, void *fdt,
         } else {
             /*
              * LMB information for RMA, boot time RAM and gap b/n RAM and
-             * hotplug memory region -- all these are marked as reserved
+             * device memory region -- all these are marked as reserved
              * and as having no valid DRC.
              */
             dynamic_memory[0] = cpu_to_be32(addr >> 32);
@@ -865,7 +865,7 @@ static int spapr_populate_drconf_memory(sPAPRMachineState *spapr, void *fdt)
     MemoryDeviceInfoList *dimms = NULL;
 
     /*
-     * Don't create the node if there is no hotpluggable memory
+     * Don't create the node if there is no device memory
      */
     if (machine->ram_size == machine->maxram_size) {
         return 0;
@@ -1036,11 +1036,11 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, void *fdt)
     GString *hypertas = g_string_sized_new(256);
     GString *qemu_hypertas = g_string_sized_new(256);
     uint32_t refpoints[] = { cpu_to_be32(0x4), cpu_to_be32(0x4) };
-    uint64_t max_hotplug_addr = MACHINE(spapr)->device_memory->base +
+    uint64_t max_device_addr = MACHINE(spapr)->device_memory->base +
         memory_region_size(&MACHINE(spapr)->device_memory->mr);
     uint32_t lrdr_capacity[] = {
-        cpu_to_be32(max_hotplug_addr >> 32),
-        cpu_to_be32(max_hotplug_addr & 0xffffffff),
+        cpu_to_be32(max_device_addr >> 32),
+        cpu_to_be32(max_device_addr & 0xffffffff),
         0, cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE),
         cpu_to_be32(max_cpus / smp_threads),
     };
@@ -2641,7 +2641,7 @@ static void spapr_machine_init(MachineState *machine)
 
     /* initialize hotplug memory address space */
     if (machine->ram_size < machine->maxram_size) {
-        ram_addr_t hotplug_mem_size = machine->maxram_size - machine->ram_size;
+        ram_addr_t device_mem_size = machine->maxram_size - machine->ram_size;
         /*
          * Limit the number of hotpluggable memory slots to half the number
          * slots that KVM supports, leaving the other half for PCI and other
@@ -2661,9 +2661,9 @@ static void spapr_machine_init(MachineState *machine)
         }
 
         machine->device_memory->base = ROUND_UP(machine->ram_size,
-                                              SPAPR_HOTPLUG_MEM_ALIGN);
+                                                SPAPR_DEVICE_MEM_ALIGN);
         memory_region_init(&machine->device_memory->mr, OBJECT(spapr),
-                           "hotplug-memory", hotplug_mem_size);
+                           "device-memory", device_mem_size);
         memory_region_add_subregion(sysmem, machine->device_memory->base,
                                     &machine->device_memory->mr);
     }
@@ -4262,11 +4262,11 @@ static void phb_placement_2_7(sPAPRMachineState *spapr, uint32_t index,
     hwaddr phb0_base, phb_base;
     int i;
 
-    /* Do we have hotpluggable memory? */
+    /* Do we have device memory? */
     if (MACHINE(spapr)->maxram_size > ram_top) {
         /* Can't just use maxram_size, because there may be an
-         * alignment gap between normal and hotpluggable memory
-         * regions */
+         * alignment gap between normal and device memory regions
+         */
         ram_top = MACHINE(spapr)->device_memory->base +
             memory_region_size(&MACHINE(spapr)->device_memory->mr);
     }
-- 
2.14.3
