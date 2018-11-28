Received: from eggs.gnu.org ([2001:4830:134:3::10]:51462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gRqra-0002Z7-0u
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 22:50:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gRqrZ-0003Yz-1m
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 22:50:09 -0500
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Wed, 28 Nov 2018 20:12:47 +0800
Message-Id: <1543407172-16175-5-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1543407172-16175-1-git-send-email-peng.hao2@zte.com.cn>
References: <1543407172-16175-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH V10 4/9]  hw/arm/virt: Use the pvpanic device
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

Add pvpanic device in arm virt machine.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 default-configs/arm-softmmu.mak |  1 +
 hw/arm/virt.c                   | 21 +++++++++++++++++++++
 include/hw/arm/virt.h           |  1 +
 3 files changed, 23 insertions(+)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 2420491..50345df 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -159,3 +159,4 @@ CONFIG_PCI_DESIGNWARE=y
 CONFIG_STRONGARM=y
 CONFIG_HIGHBANK=y
 CONFIG_MUSICPAL=y
+CONFIG_PVPANIC=y
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a2b8d8f..f2cb5de 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -143,6 +143,7 @@ static const MemMapEntry a15memmap[] = {
     [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
     [VIRT_SECURE_UART] =        { 0x09040000, 0x00001000 },
     [VIRT_SMMU] =               { 0x09050000, 0x00020000 },
+    [VIRT_PVPANIC] =            { 0x09070000, 0x00000002 },
     [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
     [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
@@ -190,6 +191,24 @@ static bool cpu_type_valid(const char *cpu)
     return false;
 }
 
+static void create_pvpanic_device(const VirtMachineState *vms)
+{
+     char *nodename;
+     hwaddr base = vms->memmap[VIRT_PVPANIC].base;
+     hwaddr size = vms->memmap[VIRT_PVPANIC].size;
+
+     sysbus_create_simple(TYPE_PVPANIC_MMIO, base, NULL);
+
+     nodename = g_strdup_printf("/pvpanic-mmio@%" PRIx64, base);
+     qemu_fdt_add_subnode(vms->fdt, nodename);
+     qemu_fdt_setprop_string(vms->fdt, nodename,
+                             "compatible", "qemu,pvpanic-mmio");
+     qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+                                  2, base, 2, size);
+
+     g_free(nodename);
+}
+
 static void create_fdt(VirtMachineState *vms)
 {
     void *fdt = create_device_tree(&vms->fdt_size);
@@ -1531,6 +1550,8 @@ static void machvirt_init(MachineState *machine)
 
     create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
 
+    create_pvpanic_device(vms);
+
     create_gic(vms, pic);
 
     fdt_add_pmu_nodes(vms);
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 4cc57a7..937c124 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -66,6 +66,7 @@ enum {
     VIRT_GIC_REDIST,
     VIRT_GIC_REDIST2,
     VIRT_SMMU,
+    VIRT_PVPANIC,
     VIRT_UART,
     VIRT_MMIO,
     VIRT_RTC,
-- 
1.8.3.1
