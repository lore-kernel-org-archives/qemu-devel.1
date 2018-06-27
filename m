Received: from eggs.gnu.org ([2001:4830:134:3::10]:49268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=709ee912d=Alistair.Francis@wdc.com>)
	id 1fYEVK-00042Z-2l
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 13:45:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=709ee912d=Alistair.Francis@wdc.com>)
	id 1fYEVG-0000Yq-TP
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 13:45:18 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:46698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=709ee912d=Alistair.Francis@wdc.com>)
	id 1fYEVG-0000P1-E7
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 13:45:14 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Wed, 27 Jun 2018 10:44:30 -0700
Message-Id: <20180627174435.31800-3-alistair.francis@wdc.com>
In-Reply-To: <20180627174435.31800-1-alistair.francis@wdc.com>
References: <20180627174435.31800-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 2/7] hw/riscv/sifive_e: Create a SiFive E SoC
 object
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Michael Clark <mjc@sifive.com>
---
 hw/riscv/sifive_e.c         | 97 +++++++++++++++++++++++++++----------
 include/hw/riscv/sifive_e.h | 16 +++++-
 2 files changed, 86 insertions(+), 27 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index e4ecb7aa4b..384b456540 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -102,18 +102,12 @@ static void riscv_sifive_e_init(MachineState *machine)
     SiFiveEState *s = g_new0(SiFiveEState, 1);
     MemoryRegion *sys_mem = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
-    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
-    MemoryRegion *xip_mem = g_new(MemoryRegion, 1);
     int i;
 
-    /* Initialize SOC */
-    object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_HART_ARRAY);
+    /* Initialize SoC */
+    object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_E_SOC);
     object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
                               &error_abort);
-    object_property_set_str(OBJECT(&s->soc), SIFIVE_E_CPU, "cpu-type",
-                            &error_abort);
-    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
-                            &error_abort);
     object_property_set_bool(OBJECT(&s->soc), true, "realized",
                             &error_abort);
 
@@ -123,11 +117,57 @@ static void riscv_sifive_e_init(MachineState *machine)
     memory_region_add_subregion(sys_mem,
         memmap[SIFIVE_E_DTIM].base, main_mem);
 
+    /* Mask ROM reset vector */
+    uint32_t reset_vec[2] = {
+        0x204002b7,        /* 0x1000: lui     t0,0x20400 */
+        0x00028067,        /* 0x1004: jr      t0 */
+    };
+
+    /* copy in the reset vector in little_endian byte order */
+    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
+        reset_vec[i] = cpu_to_le32(reset_vec[i]);
+    }
+    rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
+                          memmap[SIFIVE_E_MROM].base, &address_space_memory);
+
+    if (machine->kernel_filename) {
+        load_kernel(machine->kernel_filename);
+    }
+}
+
+static void riscv_sifive_e_soc_init(Object *obj)
+{
+    const struct MemmapEntry *memmap = sifive_e_memmap;
+
+    SiFiveESoCState *s = RISCV_E_SOC(obj);
+    MemoryRegion *sys_mem = get_system_memory();
+    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
+
+    object_initialize(&s->cpus, sizeof(s->cpus), TYPE_RISCV_HART_ARRAY);
+    object_property_add_child(obj, "cpus", OBJECT(&s->cpus),
+                              &error_abort);
+    object_property_set_str(OBJECT(&s->cpus), SIFIVE_E_CPU, "cpu-type",
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->cpus), smp_cpus, "num-harts",
+                            &error_abort);
+
     /* Mask ROM */
     memory_region_init_rom(mask_rom, NULL, "riscv.sifive.e.mrom",
         memmap[SIFIVE_E_MROM].size, &error_fatal);
     memory_region_add_subregion(sys_mem,
         memmap[SIFIVE_E_MROM].base, mask_rom);
+}
+
+static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
+{
+    const struct MemmapEntry *memmap = sifive_e_memmap;
+
+    SiFiveESoCState *s = RISCV_E_SOC(dev);
+    MemoryRegion *sys_mem = get_system_memory();
+    MemoryRegion *xip_mem = g_new(MemoryRegion, 1);
+
+    object_property_set_bool(OBJECT(&s->cpus), true, "realized",
+                            &error_abort);
 
     /* MMIO */
     s->plic = sifive_plic_create(memmap[SIFIVE_E_PLIC].base,
@@ -171,23 +211,6 @@ static void riscv_sifive_e_init(MachineState *machine)
         memmap[SIFIVE_E_XIP].size, &error_fatal);
     memory_region_set_readonly(xip_mem, true);
     memory_region_add_subregion(sys_mem, memmap[SIFIVE_E_XIP].base, xip_mem);
-
-    /* Mask ROM reset vector */
-    uint32_t reset_vec[2] = {
-        0x204002b7,        /* 0x1000: lui     t0,0x20400 */
-        0x00028067,        /* 0x1004: jr      t0 */
-    };
-
-    /* copy in the reset vector in little_endian byte order */
-    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
-        reset_vec[i] = cpu_to_le32(reset_vec[i]);
-    }
-    rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
-                          memmap[SIFIVE_E_MROM].base, &address_space_memory);
-
-    if (machine->kernel_filename) {
-        load_kernel(machine->kernel_filename);
-    }
 }
 
 static void riscv_sifive_e_machine_init(MachineClass *mc)
@@ -198,3 +221,27 @@ static void riscv_sifive_e_machine_init(MachineClass *mc)
 }
 
 DEFINE_MACHINE("sifive_e", riscv_sifive_e_machine_init)
+
+static void riscv_sifive_e_soc_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = riscv_sifive_e_soc_realize;
+    /* Reason: Uses serial_hds in realize function, thus can't be used twice */
+    dc->user_creatable = false;
+}
+
+static const TypeInfo riscv_sifive_e_soc_type_info = {
+    .name = TYPE_RISCV_E_SOC,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(SiFiveESoCState),
+    .instance_init = riscv_sifive_e_soc_init,
+    .class_init = riscv_sifive_e_soc_class_init,
+};
+
+static void riscv_sifive_e_soc_register_types(void)
+{
+    type_register_static(&riscv_sifive_e_soc_type_info);
+}
+
+type_init(riscv_sifive_e_soc_register_types)
diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
index 12ad6d2ebb..7b6d8aed96 100644
--- a/include/hw/riscv/sifive_e.h
+++ b/include/hw/riscv/sifive_e.h
@@ -19,13 +19,25 @@
 #ifndef HW_SIFIVE_E_H
 #define HW_SIFIVE_E_H
 
-typedef struct SiFiveEState {
+#define TYPE_RISCV_E_SOC "riscv.sifive.e.soc"
+#define RISCV_E_SOC(obj) \
+    OBJECT_CHECK(SiFiveESoCState, (obj), TYPE_RISCV_E_SOC)
+
+typedef struct SiFiveESoCState {
     /*< private >*/
     SysBusDevice parent_obj;
 
     /*< public >*/
-    RISCVHartArrayState soc;
+    RISCVHartArrayState cpus;
     DeviceState *plic;
+} SiFiveESoCState;
+
+typedef struct SiFiveEState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    SiFiveESoCState soc;
 } SiFiveEState;
 
 enum {
-- 
2.17.1
