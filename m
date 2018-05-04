Received: from eggs.gnu.org ([2001:4830:134:3::10]:44465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6553081d8=Alistair.Francis@wdc.com>)
	id 1fEh5U-0006iB-2E
	for qemu-devel@nongnu.org; Fri, 04 May 2018 16:13:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6553081d8=Alistair.Francis@wdc.com>)
	id 1fEh5Q-0006or-Mj
	for qemu-devel@nongnu.org; Fri, 04 May 2018 16:13:51 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:20893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=6553081d8=Alistair.Francis@wdc.com>)
	id 1fEh5Q-0006nd-5A
	for qemu-devel@nongnu.org; Fri, 04 May 2018 16:13:48 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Fri,  4 May 2018 13:13:30 -0700
Message-Id: <5655a2ca4e77ca8a0ac7b83b011449989e013981.1525464177.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1525464177.git.alistair.francis@wdc.com>
References: <cover.1525464177.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 3/4] hw/riscv/sifive_u: Connect the Cadence
 GEM Ethernet device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, alistair23@gmail.com, palmer@sifive.com, mjc@sifive.com

Connect the Cadence GEM ethernet device. This also requires us to
expose the plic interrupt lines.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 default-configs/riscv32-softmmu.mak |  1 +
 default-configs/riscv64-softmmu.mak |  1 +
 hw/riscv/sifive_u.c                 | 29 +++++++++++++++++++++++++++++
 include/hw/riscv/sifive_u.h         |  6 +++++-
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
index f9e742120c..9a1c42e8b2 100644
--- a/default-configs/riscv32-softmmu.mak
+++ b/default-configs/riscv32-softmmu.mak
@@ -2,3 +2,4 @@
 
 CONFIG_SERIAL=y
 CONFIG_VIRTIO=y
+CONFIG_CADENCE=y
diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
index f9e742120c..9a1c42e8b2 100644
--- a/default-configs/riscv64-softmmu.mak
+++ b/default-configs/riscv64-softmmu.mak
@@ -2,3 +2,4 @@
 
 CONFIG_SERIAL=y
 CONFIG_VIRTIO=y
+CONFIG_CADENCE=y
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 4924f92262..e4c7539b89 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -58,8 +58,11 @@ static const struct MemmapEntry {
     [SIFIVE_U_UART0] =    { 0x10013000,     0x1000 },
     [SIFIVE_U_UART1] =    { 0x10023000,     0x1000 },
     [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
+    [SIFIVE_U_GEM] =      { 0x100900FC,     0x1000 },
 };
 
+#define GEM_REVISION        0x10070109
+
 static uint64_t load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
@@ -294,6 +297,9 @@ static void riscv_sifive_u54_init(Object *obj)
                            memmap[SIFIVE_U_MROM].size, &error_fatal);
     memory_region_add_subregion(system_memory, memmap[SIFIVE_U_MROM].base,
                                 mask_rom);
+
+    object_initialize(&s->gem, sizeof(s->gem), TYPE_CADENCE_GEM);
+    qdev_set_parent_bus(DEVICE(&s->gem), sysbus_get_default());
 }
 
 static void riscv_sifive_u54_realize(DeviceState *dev, Error **errp)
@@ -301,6 +307,10 @@ static void riscv_sifive_u54_realize(DeviceState *dev, Error **errp)
     SiFiveU54State *s = RISCV_U54_SOC(dev);
     const struct MemmapEntry *memmap = sifive_u_memmap;
     MemoryRegion *system_memory = get_system_memory();
+    qemu_irq plic_gpios[SIFIVE_U_PLIC_NUM_SOURCES];
+    int i;
+    Error *err = NULL;
+    NICInfo *nd = &nd_table[0];
 
     object_property_set_bool(OBJECT(&s->cpus), true, "realized",
                              &error_abort);
@@ -324,6 +334,25 @@ static void riscv_sifive_u54_realize(DeviceState *dev, Error **errp)
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
+                       plic_gpios[53]);
 }
 
 static void riscv_sifive_u_machine_init(MachineClass *mc)
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 0f8bdd8fab..d40d851999 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -19,6 +19,8 @@
 #ifndef HW_SIFIVE_U_H
 #define HW_SIFIVE_U_H
 
+#include "hw/net/cadence_gem.h"
+
 #define TYPE_RISCV_U54_SOC "riscv.sifive.u54"
 #define RISCV_U54_SOC(obj) \
     OBJECT_CHECK(SiFiveU54State, (obj), TYPE_RISCV_U54_SOC)
@@ -30,6 +32,7 @@ typedef struct SiFiveU54State {
     /*< public >*/
     RISCVHartArrayState cpus;
     DeviceState *plic;
+    CadenceGEMState gem;
 } SiFiveU54State;
 
 typedef struct SiFiveUState {
@@ -49,7 +52,8 @@ enum {
     SIFIVE_U_PLIC,
     SIFIVE_U_UART0,
     SIFIVE_U_UART1,
-    SIFIVE_U_DRAM
+    SIFIVE_U_DRAM,
+    SIFIVE_U_GEM
 };
 
 enum {
-- 
2.17.0
