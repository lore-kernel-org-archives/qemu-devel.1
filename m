Received: from eggs.gnu.org ([209.51.188.92]:35051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gmFaT-0002Hu-09
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:16:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gmFaS-0007p7-1a
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:16:48 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 23 Jan 2019 11:14:54 +0100
Message-Id: <20190123101458.12478-15-eric.auger@redhat.com>
In-Reply-To: <20190123101458.12478-1-eric.auger@redhat.com>
References: <20190123101458.12478-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 14/18] hw/arm/virt: Allocate device_memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com
Cc: dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com

The device memory region is located after the initial RAM.
its start/size are 1GB aligned.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>

---
v4 -> v5:
- device memory set after the initial RAM

v3 -> v4:
- remove bootinfo.device_memory_start/device_memory_size
- rename VIRT_HOTPLUG_MEM into VIRT_DEVICE_MEM
---
 hw/arm/virt.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index aad7e0f095..c74a622412 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -61,6 +61,7 @@
 #include "hw/arm/smmuv3.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
+#include "hw/acpi/acpi.h"
=20
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -1255,6 +1256,37 @@ static void create_secure_ram(VirtMachineState *vm=
s,
     g_free(nodename);
 }
=20
+static void create_device_memory(VirtMachineState *vms, MemoryRegion *sy=
smem)
+{
+    MachineState *ms =3D MACHINE(vms);
+    uint64_t device_memory_size =3D ms->maxram_size - ms->ram_size;
+    uint64_t align =3D GiB;
+
+    if (!device_memory_size) {
+        return;
+    }
+
+    if (ms->ram_slots > ACPI_MAX_RAM_SLOTS) {
+        error_report("unsupported number of memory slots: %"PRIu64,
+                     ms->ram_slots);
+        exit(EXIT_FAILURE);
+    }
+
+    if (QEMU_ALIGN_UP(ms->maxram_size, align) !=3D ms->maxram_size) {
+        error_report("maximum memory size must be aligned to multiple of=
 0x%"
+                     PRIx64, align);
+        exit(EXIT_FAILURE);
+    }
+
+    ms->device_memory =3D g_malloc0(sizeof(*ms->device_memory));
+    ms->device_memory->base =3D QEMU_ALIGN_UP(GiB + ms->ram_size, GiB);
+
+    memory_region_init(&ms->device_memory->mr, OBJECT(vms),
+                       "device-memory", device_memory_size);
+    memory_region_add_subregion(sysmem, ms->device_memory->base,
+                                &ms->device_memory->mr);
+}
+
 static void *machvirt_dtb(const struct arm_boot_info *binfo, int *fdt_si=
ze)
 {
     const VirtMachineState *board =3D container_of(binfo, VirtMachineSta=
te,
@@ -1542,6 +1574,10 @@ static void machvirt_init(MachineState *machine)
                                          machine->ram_size);
     memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base, ram)=
;
=20
+    if (vms->extended_memmap) {
+        create_device_memory(vms, sysmem);
+    }
+
     create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
=20
     create_gic(vms, pic);
--=20
2.20.1
