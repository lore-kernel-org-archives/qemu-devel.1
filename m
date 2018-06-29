Received: from eggs.gnu.org ([2001:4830:134:3::10]:42257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=711c09436=Alistair.Francis@wdc.com>)
	id 1fYx6Z-00047g-34
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=711c09436=Alistair.Francis@wdc.com>)
	id 1fYx6V-0003X7-5V
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:22:43 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:49096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=711c09436=Alistair.Francis@wdc.com>)
	id 1fYx6U-0003Uq-Sk
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:22:39 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Fri, 29 Jun 2018 10:22:15 -0700
Message-Id: <20180629172215.29475-8-alistair.francis@wdc.com>
In-Reply-To: <20180629172215.29475-1-alistair.francis@wdc.com>
References: <20180629172215.29475-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL v2 7/7] hw/riscv/sifive_u: Connect the Cadence
 GEM Ethernet device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, mjc@sifive.com
Cc: f4bug@amsat.org, alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>

Connect the Cadence GEM ethernet device. This also requires us to
expose the plic interrupt lines.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Michael Clark <mjc@sifive.com>
---
 default-configs/riscv32-softmmu.mak |  3 +-
 default-configs/riscv64-softmmu.mak |  3 +-
 hw/riscv/sifive_u.c                 | 50 +++++++++++++++++++++++++++++
 include/hw/riscv/sifive_u.h         |  9 ++++--
 4 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
index 20e670d99c..7a003eb5e2 100644
--- a/default-configs/riscv32-softmmu.mak
+++ b/default-configs/riscv32-softmmu.mak
@@ -2,4 +2,5 @@
 
 CONFIG_SERIAL=y
 CONFIG_VIRTIO_MMIO=y
-include virtio.mak
+CONFIG_VIRTIO=y
+CONFIG_CADENCE=y
diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
index 20e670d99c..7a003eb5e2 100644
--- a/default-configs/riscv64-softmmu.mak
+++ b/default-configs/riscv64-softmmu.mak
@@ -2,4 +2,5 @@
 
 CONFIG_SERIAL=y
 CONFIG_VIRTIO_MMIO=y
-include virtio.mak
+CONFIG_VIRTIO=y
+CONFIG_CADENCE=y
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 46459cd368..1a06384367 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -60,8 +60,11 @@ static const struct MemmapEntry {
     [SIFIVE_U_UART0] =    { 0x10013000,     0x1000 },
     [SIFIVE_U_UART1] =    { 0x10023000,     0x1000 },
     [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
+    [SIFIVE_U_GEM] =      { 0x100900FC,     0x2000 },
 };
 
+#define GEM_REVISION        0x10070109
+
 static uint64_t load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
@@ -194,6 +197,27 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     g_free(cells);
     g_free(nodename);
 
+    nodename = g_strdup_printf("/soc/ethernet@%lx",
+        (long)memmap[SIFIVE_U_GEM].base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "cdns,macb");
+    qemu_fdt_setprop_cells(fdt, nodename, "reg",
+        0x0, memmap[SIFIVE_U_GEM].base,
+        0x0, memmap[SIFIVE_U_GEM].size);
+    qemu_fdt_setprop_string(fdt, nodename, "reg-names", "control");
+    qemu_fdt_setprop_string(fdt, nodename, "phy-mode", "gmii");
+    qemu_fdt_setprop_cells(fdt, nodename, "interrupt-parent", plic_phandle);
+    qemu_fdt_setprop_cells(fdt, nodename, "interrupts", SIFIVE_U_GEM_IRQ);
+    qemu_fdt_setprop_cells(fdt, nodename, "#address-cells", 1);
+    qemu_fdt_setprop_cells(fdt, nodename, "#size-cells", 0);
+    g_free(nodename);
+
+    nodename = g_strdup_printf("/soc/ethernet@%lx/ethernet-phy@0",
+        (long)memmap[SIFIVE_U_GEM].base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cells(fdt, nodename, "reg", 0x0);
+    g_free(nodename);
+
     nodename = g_strdup_printf("/soc/uart@%lx",
         (long)memmap[SIFIVE_U_UART0].base);
     qemu_fdt_add_subnode(fdt, nodename);
@@ -296,6 +320,9 @@ static void riscv_sifive_u_soc_init(Object *obj)
                            memmap[SIFIVE_U_MROM].size, &error_fatal);
     memory_region_add_subregion(system_memory, memmap[SIFIVE_U_MROM].base,
                                 mask_rom);
+
+    object_initialize(&s->gem, sizeof(s->gem), TYPE_CADENCE_GEM);
+    qdev_set_parent_bus(DEVICE(&s->gem), sysbus_get_default());
 }
 
 static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
@@ -303,6 +330,10 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     SiFiveUSoCState *s = RISCV_U_SOC(dev);
     const struct MemmapEntry *memmap = sifive_u_memmap;
     MemoryRegion *system_memory = get_system_memory();
+    qemu_irq plic_gpios[SIFIVE_U_PLIC_NUM_SOURCES];
+    int i;
+    Error *err = NULL;
+    NICInfo *nd = &nd_table[0];
 
     object_property_set_bool(OBJECT(&s->cpus), true, "realized",
                              &error_abort);
@@ -327,6 +358,25 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     sifive_clint_create(memmap[SIFIVE_U_CLINT].base,
         memmap[SIFIVE_U_CLINT].size, smp_cpus,
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
+
+    for (i = 0; i < SIFIVE_U_PLIC_NUM_SOURCES; i++) {
+        plic_gpios[i] = qdev_get_gpio_in(DEVICE(s->plic), i);
+    }
+
+    if (nd->used) {
+        qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
+        qdev_set_nic_properties(DEVICE(&s->gem), nd);
+    }
+    object_property_set_int(OBJECT(&s->gem), GEM_REVISION, "revision",
+                            &error_abort);
+    object_property_set_bool(OBJECT(&s->gem), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem), 0, memmap[SIFIVE_U_GEM].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem), 0,
+                       plic_gpios[SIFIVE_U_GEM_IRQ]);
 }
 
 static void riscv_sifive_u_machine_init(MachineClass *mc)
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 49f1946539..e8b4d9ffa3 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -19,6 +19,8 @@
 #ifndef HW_SIFIVE_U_H
 #define HW_SIFIVE_U_H
 
+#include "hw/net/cadence_gem.h"
+
 #define TYPE_RISCV_U_SOC "riscv.sifive.u.soc"
 #define RISCV_U_SOC(obj) \
     OBJECT_CHECK(SiFiveUSoCState, (obj), TYPE_RISCV_U_SOC)
@@ -30,6 +32,7 @@ typedef struct SiFiveUSoCState {
     /*< public >*/
     RISCVHartArrayState cpus;
     DeviceState *plic;
+    CadenceGEMState gem;
 } SiFiveUSoCState;
 
 typedef struct SiFiveUState {
@@ -49,12 +52,14 @@ enum {
     SIFIVE_U_PLIC,
     SIFIVE_U_UART0,
     SIFIVE_U_UART1,
-    SIFIVE_U_DRAM
+    SIFIVE_U_DRAM,
+    SIFIVE_U_GEM
 };
 
 enum {
     SIFIVE_U_UART0_IRQ = 3,
-    SIFIVE_U_UART1_IRQ = 4
+    SIFIVE_U_UART1_IRQ = 4,
+    SIFIVE_U_GEM_IRQ = 0x35
 };
 
 enum {
-- 
2.17.1
