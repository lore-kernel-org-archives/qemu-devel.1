Received: from eggs.gnu.org ([209.51.188.92]:47511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gyd8Y-0000EH-9v
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:51:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gyd8X-000776-4C
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:51:10 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 26 Feb 2019 14:50:03 +0100
Message-Id: <20190226135014.31854-8-eric.auger@redhat.com>
In-Reply-To: <20190226135014.31854-1-eric.auger@redhat.com>
References: <20190226135014.31854-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 07/18] hw/arm/virt: Dynamic memory map
 depending on RAM requirements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com
Cc: dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com, pbonzini@redhat.com

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

---

v7 -> v8:
- allocate ms->device_memory and removes vms->device_memory_base and
  vms->device_memory_storage
- remove (ms->maxram_size > ms->ram_size || ms->ram_slots > 0) and
  (ms->ram_size > (ram_addr_t)LEGACY_RAMLIMIT_BYTES) checks
- initialize the device memory
- move the slots nb check and maxram_size alignment checks in this
  patch
---
 hw/arm/virt.c         | 52 ++++++++++++++++++++++++++++++++++++++-----
 include/hw/arm/virt.h |  1 +
 2 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7297b69d93..172bb6c140 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -59,6 +59,7 @@
 #include "qapi/visitor.h"
 #include "standard-headers/linux/input.h"
 #include "hw/arm/smmuv3.h"
+#include "hw/acpi/acpi.h"
=20
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -107,8 +108,9 @@
  * of a terabyte of RAM will be doing it on a host with more than a
  * terabyte of physical address space.)
  */
-#define RAMLIMIT_GB 255
-#define RAMLIMIT_BYTES (RAMLIMIT_GB * 1024ULL * 1024 * 1024)
+#define RAMBASE GiB
+#define LEGACY_RAMLIMIT_GB 255
+#define LEGACY_RAMLIMIT_BYTES (LEGACY_RAMLIMIT_GB * GiB)
=20
 /* Addresses and sizes of our components.
  * 0..128MB is space for a flash device so we can run bootrom code such =
as UEFI.
@@ -149,7 +151,7 @@ static const MemMapEntry base_memmap[] =3D {
     [VIRT_PCIE_MMIO] =3D          { 0x10000000, 0x2eff0000 },
     [VIRT_PCIE_PIO] =3D           { 0x3eff0000, 0x00010000 },
     [VIRT_PCIE_ECAM] =3D          { 0x3f000000, 0x01000000 },
-    [VIRT_MEM] =3D                { 0x40000000, RAMLIMIT_BYTES },
+    [VIRT_MEM] =3D                { RAMBASE, LEGACY_RAMLIMIT_BYTES },
 };
=20
 /*
@@ -1370,7 +1372,8 @@ static uint64_t virt_cpu_mp_affinity(VirtMachineSta=
te *vms, int idx)
=20
 static void virt_set_memmap(VirtMachineState *vms)
 {
-    hwaddr base;
+    MachineState *ms =3D MACHINE(vms);
+    hwaddr base, device_memory_base, device_memory_size;
     int i;
=20
     vms->memmap =3D extended_memmap;
@@ -1379,7 +1382,34 @@ static void virt_set_memmap(VirtMachineState *vms)
         vms->memmap[i] =3D base_memmap[i];
     }
=20
-    vms->high_io_base =3D 256 * GiB; /* Top of the legacy initial RAM re=
gion */
+    if (ms->ram_slots > ACPI_MAX_RAM_SLOTS) {
+        error_report("unsupported number of memory slots: %"PRIu64,
+                     ms->ram_slots);
+        exit(EXIT_FAILURE);
+    }
+
+    if (QEMU_ALIGN_UP(ms->maxram_size, GiB) !=3D ms->maxram_size) {
+        error_report("maximum memory size must be GiB aligned");
+    }
+
+    /*
+     * We compute the base of the high IO region depending on the
+     * amount of initial and device memory. The device memory start/size
+     * is aligned on 1GiB. We never put the high IO region below 256GiB
+     * so that if maxram_size is < 255GiB we keep the legacy memory map.
+     * The device region size assumes 1GiB page max alignment per slot.
+     */
+    device_memory_base =3D ROUND_UP(RAMBASE + ms->ram_size, GiB);
+    device_memory_size =3D ms->maxram_size - ms->ram_size + ms->ram_slot=
s * GiB;
+
+    vms->high_io_base =3D device_memory_base + ROUND_UP(device_memory_si=
ze, GiB);
+    if (vms->high_io_base < device_memory_base) {
+        error_report("maxmem/slots too huge");
+        exit(EXIT_FAILURE);
+    }
+    if (vms->high_io_base < 256 * GiB) {
+        vms->high_io_base =3D 256 * GiB;
+    }
     base =3D vms->high_io_base;
=20
     for (i =3D VIRT_LOWMEMMAP_LAST; i < ARRAY_SIZE(extended_memmap); i++=
) {
@@ -1390,6 +1420,13 @@ static void virt_set_memmap(VirtMachineState *vms)
         vms->memmap[i].size =3D size;
         base +=3D size;
     }
+    vms->highest_gpa =3D base - 1;
+    if (device_memory_size > 0) {
+        ms->device_memory =3D g_malloc0(sizeof(*ms->device_memory));
+        ms->device_memory->base =3D device_memory_base;
+        memory_region_init(&ms->device_memory->mr, OBJECT(vms),
+                           "device-memory", device_memory_size);
+    }
 }
=20
 static void machvirt_init(MachineState *machine)
@@ -1474,7 +1511,8 @@ static void machvirt_init(MachineState *machine)
     vms->smp_cpus =3D smp_cpus;
=20
     if (machine->ram_size > vms->memmap[VIRT_MEM].size) {
-        error_report("mach-virt: cannot model more than %dGB RAM", RAMLI=
MIT_GB);
+        error_report("mach-virt: cannot model more than %dGB RAM",
+                     LEGACY_RAMLIMIT_GB);
         exit(1);
     }
=20
@@ -1568,6 +1606,8 @@ static void machvirt_init(MachineState *machine)
     memory_region_allocate_system_memory(ram, NULL, "mach-virt.ram",
                                          machine->ram_size);
     memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base, ram)=
;
+    memory_region_add_subregion(sysmem, machine->device_memory->base,
+                                &machine->device_memory->mr);
=20
     create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
=20
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 3dc7a6c5d5..326a26b6d6 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -132,6 +132,7 @@ typedef struct {
     uint32_t iommu_phandle;
     int psci_conduit;
     hwaddr high_io_base;
+    hwaddr highest_gpa;
 } VirtMachineState;
=20
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
--=20
2.20.1
