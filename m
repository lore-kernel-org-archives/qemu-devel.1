Received: from eggs.gnu.org ([2001:4830:134:3::10]:53800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cGutJ-0002UI-6Y
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:45:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cGutI-0007Yf-4B
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:45:41 -0500
From: Andrew Jones <drjones@redhat.com>
Date: Tue, 13 Dec 2016 22:45:14 +0100
Message-Id: <20161213214522.25548-4-drjones@redhat.com>
In-Reply-To: <20161213214522.25548-1-drjones@redhat.com>
References: <20161213214522.25548-1-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH 03/11] hw/arm/virt: use
 VirtMachineState.smp_cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, zhaoshenglong@huawei.com, mst@redhat.com, imammedo@redhat.com, ehabkost@redhat.com

Most places we need smp_cpus we use vms->smp_cpus already. This
cleanup makes sure we do everywhere, preparing for the removal
of the global smp_cpus someday.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 hw/arm/virt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 67c0abb30b5b..18aa3672739d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -583,7 +583,7 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
 
     gicdev = qdev_create(NULL, gictype);
     qdev_prop_set_uint32(gicdev, "revision", type);
-    qdev_prop_set_uint32(gicdev, "num-cpu", smp_cpus);
+    qdev_prop_set_uint32(gicdev, "num-cpu", vms->smp_cpus);
     /* Note that the num-irq property counts both internal and external
      * interrupts; there are always 32 of the former (mandated by GIC spec).
      */
@@ -604,7 +604,7 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
      * maintenance interrupt signal to the appropriate GIC PPI inputs,
      * and the GIC's IRQ/FIQ/VIRQ/VFIQ interrupt outputs to the CPU's inputs.
      */
-    for (i = 0; i < smp_cpus; i++) {
+    for (i = 0; i < vms->smp_cpus; i++) {
         DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
         int ppibase = NUM_IRQS + i * GIC_INTERNAL + GIC_NR_SGIS;
         int irq;
@@ -629,7 +629,7 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
                                                      + ARCH_GICV3_MAINT_IRQ));
 
         sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
-        sysbus_connect_irq(gicbusdev, i + smp_cpus,
+        sysbus_connect_irq(gicbusdev, i + vms->smp_cpus,
                            qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
         sysbus_connect_irq(gicbusdev, i + 2 * smp_cpus,
                            qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
@@ -958,7 +958,7 @@ static void create_fw_cfg(const VirtMachineState *vms, AddressSpace *as)
     char *nodename;
 
     fw_cfg = fw_cfg_init_mem_wide(base + 8, base, 8, base + 16, as);
-    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)smp_cpus);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)vms->smp_cpus);
 
     nodename = g_strdup_printf("/fw-cfg@%" PRIx64, base);
     qemu_fdt_add_subnode(vms->fdt, nodename);
@@ -1362,7 +1362,7 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    for (n = 0; n < smp_cpus; n++) {
+    for (n = 0; n < vms->smp_cpus; n++) {
         Object *cpuobj = object_new(typename);
         if (!vmc->disallow_affinity_adjustment) {
             /* Adjust MPIDR like 64-bit KVM hosts, which incorporate the
@@ -1452,7 +1452,7 @@ static void machvirt_init(MachineState *machine)
     create_fw_cfg(vms, &address_space_memory);
     rom_set_fw(fw_cfg_find());
 
-    guest_info->smp_cpus = smp_cpus;
+    guest_info->smp_cpus = vms->smp_cpus;
     guest_info->fw_cfg = fw_cfg_find();
     guest_info->memmap = vms->memmap;
     guest_info->irqmap = vms->irqmap;
@@ -1466,7 +1466,7 @@ static void machvirt_init(MachineState *machine)
     vms->bootinfo.kernel_filename = machine->kernel_filename;
     vms->bootinfo.kernel_cmdline = machine->kernel_cmdline;
     vms->bootinfo.initrd_filename = machine->initrd_filename;
-    vms->bootinfo.nb_cpus = smp_cpus;
+    vms->bootinfo.nb_cpus = vms->smp_cpus;
     vms->bootinfo.board_id = -1;
     vms->bootinfo.loader_start = vms->memmap[VIRT_MEM].base;
     vms->bootinfo.get_dtb = machvirt_dtb;
-- 
2.9.3
