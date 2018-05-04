Received: from eggs.gnu.org ([2001:4830:134:3::10]:44111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6553081d8=Alistair.Francis@wdc.com>)
	id 1fEh4u-0006d3-QY
	for qemu-devel@nongnu.org; Fri, 04 May 2018 16:13:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6553081d8=Alistair.Francis@wdc.com>)
	id 1fEh4r-0006Pc-Kt
	for qemu-devel@nongnu.org; Fri, 04 May 2018 16:13:16 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=6553081d8=Alistair.Francis@wdc.com>)
	id 1fEh4r-0006P0-6g
	for qemu-devel@nongnu.org; Fri, 04 May 2018 16:13:13 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Fri,  4 May 2018 13:12:58 -0700
Message-Id: <107c154303a7f08c452199df250c274f40d274ec.1525464177.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1525464177.git.alistair.francis@wdc.com>
References: <cover.1525464177.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 1/4] hw/riscv/sifive_u: Create a U54 SoC
 object
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

Create a SiFive Unleashed U54 SoC and use that in the sifive_u machine.

We leave the SoC, RAM, device tree and reset/fdt loading as part of the
machine. All the other device creation has been moved to the SoC.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c         | 90 ++++++++++++++++++++++++++++---------
 include/hw/riscv/sifive_u.h | 16 ++++++-
 2 files changed, 82 insertions(+), 24 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 9f3d184b72..4924f92262 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -114,10 +114,10 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, "/cpus", "#size-cells", 0x0);
     qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
 
-    for (cpu = s->soc.num_harts - 1; cpu >= 0; cpu--) {
+    for (cpu = s->soc.cpus.num_harts - 1; cpu >= 0; cpu--) {
         nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
         char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
-        char *isa = riscv_isa_string(&s->soc.harts[cpu]);
+        char *isa = riscv_isa_string(&s->soc.cpus.harts[cpu]);
         qemu_fdt_add_subnode(fdt, nodename);
         qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
                               SIFIVE_U_CLOCK_FREQ);
@@ -138,8 +138,8 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         g_free(nodename);
     }
 
-    cells =  g_new0(uint32_t, s->soc.num_harts * 4);
-    for (cpu = 0; cpu < s->soc.num_harts; cpu++) {
+    cells =  g_new0(uint32_t, s->soc.cpus.num_harts * 4);
+    for (cpu = 0; cpu < s->soc.cpus.num_harts; cpu++) {
         nodename =
             g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
         uint32_t intc_phandle = qemu_fdt_get_phandle(fdt, nodename);
@@ -157,12 +157,12 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         0x0, memmap[SIFIVE_U_CLINT].base,
         0x0, memmap[SIFIVE_U_CLINT].size);
     qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
-        cells, s->soc.num_harts * sizeof(uint32_t) * 4);
+        cells, s->soc.cpus.num_harts * sizeof(uint32_t) * 4);
     g_free(cells);
     g_free(nodename);
 
-    cells =  g_new0(uint32_t, s->soc.num_harts * 4);
-    for (cpu = 0; cpu < s->soc.num_harts; cpu++) {
+    cells =  g_new0(uint32_t, s->soc.cpus.num_harts * 4);
+    for (cpu = 0; cpu < s->soc.cpus.num_harts; cpu++) {
         nodename =
             g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
         uint32_t intc_phandle = qemu_fdt_get_phandle(fdt, nodename);
@@ -179,7 +179,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv,plic0");
     qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
     qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
-        cells, s->soc.num_harts * sizeof(uint32_t) * 4);
+        cells, s->soc.cpus.num_harts * sizeof(uint32_t) * 4);
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
         0x0, memmap[SIFIVE_U_PLIC].base,
         0x0, memmap[SIFIVE_U_PLIC].size);
@@ -215,17 +215,12 @@ static void riscv_sifive_u_init(MachineState *machine)
     SiFiveUState *s = g_new0(SiFiveUState, 1);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
-    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     int i;
 
-    /* Initialize SOC */
-    object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_HART_ARRAY);
+    /* Initialize SoC */
+    object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_U54_SOC);
     object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
                               &error_abort);
-    object_property_set_str(OBJECT(&s->soc), SIFIVE_U_CPU, "cpu-type",
-                            &error_abort);
-    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
-                            &error_abort);
     object_property_set_bool(OBJECT(&s->soc), true, "realized",
                             &error_abort);
 
@@ -233,17 +228,11 @@ static void riscv_sifive_u_init(MachineState *machine)
     memory_region_init_ram(main_mem, NULL, "riscv.sifive.u.ram",
                            machine->ram_size, &error_fatal);
     memory_region_add_subregion(system_memory, memmap[SIFIVE_U_DRAM].base,
-        main_mem);
+                                main_mem);
 
     /* create device tree */
     create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
 
-    /* boot rom */
-    memory_region_init_rom(mask_rom, NULL, "riscv.sifive.u.mrom",
-                           memmap[SIFIVE_U_MROM].size, &error_fatal);
-    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_MROM].base,
-                                mask_rom);
-
     if (machine->kernel_filename) {
         load_kernel(machine->kernel_filename);
     }
@@ -282,6 +271,39 @@ static void riscv_sifive_u_init(MachineState *machine)
     rom_add_blob_fixed_as("mrom.fdt", s->fdt, s->fdt_size,
                           memmap[SIFIVE_U_MROM].base + sizeof(reset_vec),
                           &address_space_memory);
+}
+
+static void riscv_sifive_u54_init(Object *obj)
+{
+    const struct MemmapEntry *memmap = sifive_u_memmap;
+
+    SiFiveU54State *s = RISCV_U54_SOC(obj);
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
+
+    object_initialize(&s->cpus, sizeof(s->cpus), TYPE_RISCV_HART_ARRAY);
+    object_property_add_child(obj, "cpus", OBJECT(&s->cpus),
+                              &error_abort);
+    object_property_set_str(OBJECT(&s->cpus), SIFIVE_U_CPU, "cpu-type",
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->cpus), smp_cpus, "num-harts",
+                            &error_abort);
+
+    /* boot rom */
+    memory_region_init_rom(mask_rom, NULL, "riscv.sifive.u.mrom",
+                           memmap[SIFIVE_U_MROM].size, &error_fatal);
+    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_MROM].base,
+                                mask_rom);
+}
+
+static void riscv_sifive_u54_realize(DeviceState *dev, Error **errp)
+{
+    SiFiveU54State *s = RISCV_U54_SOC(dev);
+    const struct MemmapEntry *memmap = sifive_u_memmap;
+    MemoryRegion *system_memory = get_system_memory();
+
+    object_property_set_bool(OBJECT(&s->cpus), true, "realized",
+                             &error_abort);
 
     /* MMIO */
     s->plic = sifive_plic_create(memmap[SIFIVE_U_PLIC].base,
@@ -312,3 +334,27 @@ static void riscv_sifive_u_machine_init(MachineClass *mc)
 }
 
 DEFINE_MACHINE("sifive_u", riscv_sifive_u_machine_init)
+
+static void riscv_sifive_u54_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = riscv_sifive_u54_realize;
+    /* Reason: Uses serial_hds in realize function, thus can't be used twice */
+    dc->user_creatable = false;
+}
+
+static const TypeInfo riscv_sifive_u54_type_info = {
+    .name = TYPE_RISCV_U54_SOC,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(SiFiveU54State),
+    .instance_init = riscv_sifive_u54_init,
+    .class_init = riscv_sifive_u54_class_init,
+};
+
+static void riscv_sifive_u54_register_types(void)
+{
+    type_register_static(&riscv_sifive_u54_type_info);
+}
+
+type_init(riscv_sifive_u54_register_types)
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 94a390566e..0f8bdd8fab 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -19,13 +19,25 @@
 #ifndef HW_SIFIVE_U_H
 #define HW_SIFIVE_U_H
 
-typedef struct SiFiveUState {
+#define TYPE_RISCV_U54_SOC "riscv.sifive.u54"
+#define RISCV_U54_SOC(obj) \
+    OBJECT_CHECK(SiFiveU54State, (obj), TYPE_RISCV_U54_SOC)
+
+typedef struct SiFiveU54State {
     /*< private >*/
     SysBusDevice parent_obj;
 
     /*< public >*/
-    RISCVHartArrayState soc;
+    RISCVHartArrayState cpus;
     DeviceState *plic;
+} SiFiveU54State;
+
+typedef struct SiFiveUState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    SiFiveU54State soc;
     void *fdt;
     int fdt_size;
 } SiFiveUState;
-- 
2.17.0
