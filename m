Received: from eggs.gnu.org ([2001:4830:134:3::10]:38807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ePjJk-0006jL-PU
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 01:17:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ePjJf-00083k-Vi
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 01:17:56 -0500
Received: from 8.mo5.mail-out.ovh.net ([178.32.116.78]:60572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ePjJf-00081C-LM
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 01:17:51 -0500
Received: from player773.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 2682D15B6D2
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 07:17:48 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 15 Dec 2017 07:17:39 +0100
Message-Id: <20171215061739.9494-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] ppc/pnv: change powernv_ prefix to pnv_ for
 overall naming consistency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv.c         | 84 ++++++++++++++++++++++++++--------------------=
------
 hw/ppc/pnv_core.c    |  8 ++---
 hw/ppc/pnv_lpc.c     |  2 +-
 include/hw/ppc/pnv.h |  8 ++---
 4 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index c35c439d816b..4bc5f61d0da7 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -77,7 +77,7 @@ static const char *pnv_chip_core_typename(const PnvChip=
 *o)
  * that has a different "affinity". In practice, it means one range
  * per chip.
  */
-static void powernv_populate_memory_node(void *fdt, int chip_id, hwaddr =
start,
+static void pnv_populate_memory_node(void *fdt, int chip_id, hwaddr star=
t,
                                          hwaddr size)
 {
     char *mem_name;
@@ -119,7 +119,7 @@ static int get_cpus_node(void *fdt)
  * device tree, used in XSCOM to address cores and in interrupt
  * servers.
  */
-static void powernv_create_core_node(PnvChip *chip, PnvCore *pc, void *f=
dt)
+static void pnv_create_core_node(PnvChip *chip, PnvCore *pc, void *fdt)
 {
     CPUState *cs =3D CPU(DEVICE(pc->threads));
     DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
@@ -228,7 +228,7 @@ static void powernv_create_core_node(PnvChip *chip, P=
nvCore *pc, void *fdt)
                        servers_prop, sizeof(servers_prop))));
 }
=20
-static void powernv_populate_icp(PnvChip *chip, void *fdt, uint32_t pir,
+static void pnv_populate_icp(PnvChip *chip, void *fdt, uint32_t pir,
                                  uint32_t nr_threads)
 {
     uint64_t addr =3D PNV_ICP_BASE(chip) | (pir << 12);
@@ -277,7 +277,7 @@ static int pnv_chip_lpc_offset(PnvChip *chip, void *f=
dt)
     return offset;
 }
=20
-static void powernv_populate_chip(PnvChip *chip, void *fdt)
+static void pnv_populate_chip(PnvChip *chip, void *fdt)
 {
     const char *typename =3D pnv_chip_core_typename(chip);
     size_t typesize =3D object_type_get_instance_size(typename);
@@ -298,20 +298,20 @@ static void powernv_populate_chip(PnvChip *chip, vo=
id *fdt)
     for (i =3D 0; i < chip->nr_cores; i++) {
         PnvCore *pnv_core =3D PNV_CORE(chip->cores + i * typesize);
=20
-        powernv_create_core_node(chip, pnv_core, fdt);
+        pnv_create_core_node(chip, pnv_core, fdt);
=20
         /* Interrupt Control Presenters (ICP). One per core. */
-        powernv_populate_icp(chip, fdt, pnv_core->pir,
+        pnv_populate_icp(chip, fdt, pnv_core->pir,
                              CPU_CORE(pnv_core)->nr_threads);
     }
=20
     if (chip->ram_size) {
-        powernv_populate_memory_node(fdt, chip->chip_id, chip->ram_start=
,
+        pnv_populate_memory_node(fdt, chip->chip_id, chip->ram_start,
                                      chip->ram_size);
     }
 }
=20
-static void powernv_populate_rtc(ISADevice *d, void *fdt, int lpc_off)
+static void pnv_populate_rtc(ISADevice *d, void *fdt, int lpc_off)
 {
     uint32_t io_base =3D d->ioport_id;
     uint32_t io_regs[] =3D {
@@ -331,7 +331,7 @@ static void powernv_populate_rtc(ISADevice *d, void *=
fdt, int lpc_off)
     _FDT((fdt_setprop_string(fdt, node, "compatible", "pnpPNP,b00")));
 }
=20
-static void powernv_populate_serial(ISADevice *d, void *fdt, int lpc_off=
)
+static void pnv_populate_serial(ISADevice *d, void *fdt, int lpc_off)
 {
     const char compatible[] =3D "ns16550\0pnpPNP,501";
     uint32_t io_base =3D d->ioport_id;
@@ -362,7 +362,7 @@ static void powernv_populate_serial(ISADevice *d, voi=
d *fdt, int lpc_off)
     _FDT((fdt_setprop_string(fdt, node, "device_type", "serial")));
 }
=20
-static void powernv_populate_ipmi_bt(ISADevice *d, void *fdt, int lpc_of=
f)
+static void pnv_populate_ipmi_bt(ISADevice *d, void *fdt, int lpc_off)
 {
     const char compatible[] =3D "bt\0ipmi-bt";
     uint32_t io_base;
@@ -401,17 +401,17 @@ typedef struct ForeachPopulateArgs {
     int offset;
 } ForeachPopulateArgs;
=20
-static int powernv_populate_isa_device(DeviceState *dev, void *opaque)
+static int pnv_populate_isa_device(DeviceState *dev, void *opaque)
 {
     ForeachPopulateArgs *args =3D opaque;
     ISADevice *d =3D ISA_DEVICE(dev);
=20
     if (object_dynamic_cast(OBJECT(dev), TYPE_MC146818_RTC)) {
-        powernv_populate_rtc(d, args->fdt, args->offset);
+        pnv_populate_rtc(d, args->fdt, args->offset);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_ISA_SERIAL)) {
-        powernv_populate_serial(d, args->fdt, args->offset);
+        pnv_populate_serial(d, args->fdt, args->offset);
     } else if (object_dynamic_cast(OBJECT(dev), "isa-ipmi-bt")) {
-        powernv_populate_ipmi_bt(d, args->fdt, args->offset);
+        pnv_populate_ipmi_bt(d, args->fdt, args->offset);
     } else {
         error_report("unknown isa device %s@i%x", qdev_fw_name(dev),
                      d->ioport_id);
@@ -420,7 +420,7 @@ static int powernv_populate_isa_device(DeviceState *d=
ev, void *opaque)
     return 0;
 }
=20
-static void powernv_populate_isa(ISABus *bus, void *fdt, int lpc_offset)
+static void pnv_populate_isa(ISABus *bus, void *fdt, int lpc_offset)
 {
     ForeachPopulateArgs args =3D {
         .fdt =3D fdt,
@@ -429,14 +429,14 @@ static void powernv_populate_isa(ISABus *bus, void =
*fdt, int lpc_offset)
=20
     /* ISA devices are not necessarily parented to the ISA bus so we
      * can not use object_child_foreach() */
-    qbus_walk_children(BUS(bus), powernv_populate_isa_device,
+    qbus_walk_children(BUS(bus), pnv_populate_isa_device,
                        NULL, NULL, NULL, &args);
 }
=20
-static void *powernv_create_fdt(MachineState *machine)
+static void *pnv_create_fdt(MachineState *machine)
 {
     const char plat_compat[] =3D "qemu,powernv\0ibm,powernv";
-    PnvMachineState *pnv =3D POWERNV_MACHINE(machine);
+    PnvMachineState *pnv =3D PNV_MACHINE(machine);
     void *fdt;
     char *buf;
     int off;
@@ -479,12 +479,12 @@ static void *powernv_create_fdt(MachineState *machi=
ne)
=20
     /* Populate device tree for each chip */
     for (i =3D 0; i < pnv->num_chips; i++) {
-        powernv_populate_chip(pnv->chips[i], fdt);
+        pnv_populate_chip(pnv->chips[i], fdt);
     }
=20
     /* Populate ISA devices on chip 0 */
     lpc_offset =3D pnv_chip_lpc_offset(pnv->chips[0], fdt);
-    powernv_populate_isa(pnv->isa_bus, fdt, lpc_offset);
+    pnv_populate_isa(pnv->isa_bus, fdt, lpc_offset);
=20
     if (pnv->bmc) {
         pnv_bmc_populate_sensors(pnv->bmc, fdt);
@@ -495,17 +495,17 @@ static void *powernv_create_fdt(MachineState *machi=
ne)
=20
 static void pnv_powerdown_notify(Notifier *n, void *opaque)
 {
-    PnvMachineState *pnv =3D POWERNV_MACHINE(qdev_get_machine());
+    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
=20
     if (pnv->bmc) {
         pnv_bmc_powerdown(pnv->bmc);
     }
 }
=20
-static void ppc_powernv_reset(void)
+static void pnv_reset(void)
 {
     MachineState *machine =3D MACHINE(qdev_get_machine());
-    PnvMachineState *pnv =3D POWERNV_MACHINE(machine);
+    PnvMachineState *pnv =3D PNV_MACHINE(machine);
     void *fdt;
     Object *obj;
=20
@@ -524,7 +524,7 @@ static void ppc_powernv_reset(void)
         pnv->bmc =3D IPMI_BMC(obj);
     }
=20
-    fdt =3D powernv_create_fdt(machine);
+    fdt =3D pnv_create_fdt(machine);
=20
     /* Pack resulting tree */
     _FDT((fdt_pack(fdt)));
@@ -552,9 +552,9 @@ static ISABus *pnv_isa_create(PnvChip *chip)
     return isa_bus;
 }
=20
-static void ppc_powernv_init(MachineState *machine)
+static void pnv_init(MachineState *machine)
 {
-    PnvMachineState *pnv =3D POWERNV_MACHINE(machine);
+    PnvMachineState *pnv =3D PNV_MACHINE(machine);
     MemoryRegion *ram;
     char *fw_filename;
     long fw_size;
@@ -567,7 +567,7 @@ static void ppc_powernv_init(MachineState *machine)
     }
=20
     ram =3D g_new(MemoryRegion, 1);
-    memory_region_allocate_system_memory(ram, NULL, "ppc_powernv.ram",
+    memory_region_allocate_system_memory(ram, NULL, "pnv.ram",
                                          machine->ram_size);
     memory_region_add_subregion(get_system_memory(), 0, ram);
=20
@@ -974,7 +974,7 @@ static void pnv_chip_class_init(ObjectClass *klass, v=
oid *data)
=20
 static ICSState *pnv_ics_get(XICSFabric *xi, int irq)
 {
-    PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
+    PnvMachineState *pnv =3D PNV_MACHINE(xi);
     int i;
=20
     for (i =3D 0; i < pnv->num_chips; i++) {
@@ -987,7 +987,7 @@ static ICSState *pnv_ics_get(XICSFabric *xi, int irq)
=20
 static void pnv_ics_resend(XICSFabric *xi)
 {
-    PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
+    PnvMachineState *pnv =3D PNV_MACHINE(xi);
     int i;
=20
     for (i =3D 0; i < pnv->num_chips; i++) {
@@ -1021,7 +1021,7 @@ static ICPState *pnv_icp_get(XICSFabric *xi, int pi=
r)
 static void pnv_pic_print_info(InterruptStatsProvider *obj,
                                Monitor *mon)
 {
-    PnvMachineState *pnv =3D POWERNV_MACHINE(obj);
+    PnvMachineState *pnv =3D PNV_MACHINE(obj);
     int i;
     CPUState *cs;
=20
@@ -1039,13 +1039,13 @@ static void pnv_pic_print_info(InterruptStatsProv=
ider *obj,
 static void pnv_get_num_chips(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
-    visit_type_uint32(v, name, &POWERNV_MACHINE(obj)->num_chips, errp);
+    visit_type_uint32(v, name, &PNV_MACHINE(obj)->num_chips, errp);
 }
=20
 static void pnv_set_num_chips(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
-    PnvMachineState *pnv =3D POWERNV_MACHINE(obj);
+    PnvMachineState *pnv =3D PNV_MACHINE(obj);
     uint32_t num_chips;
     Error *local_err =3D NULL;
=20
@@ -1067,13 +1067,13 @@ static void pnv_set_num_chips(Object *obj, Visito=
r *v, const char *name,
     pnv->num_chips =3D num_chips;
 }
=20
-static void powernv_machine_initfn(Object *obj)
+static void pnv_machine_initfn(Object *obj)
 {
-    PnvMachineState *pnv =3D POWERNV_MACHINE(obj);
+    PnvMachineState *pnv =3D PNV_MACHINE(obj);
     pnv->num_chips =3D 1;
 }
=20
-static void powernv_machine_class_props_init(ObjectClass *oc)
+static void pnv_machine_class_props_init(ObjectClass *oc)
 {
     object_class_property_add(oc, "num-chips", "uint32",
                               pnv_get_num_chips, pnv_set_num_chips,
@@ -1083,15 +1083,15 @@ static void powernv_machine_class_props_init(Obje=
ctClass *oc)
                               NULL);
 }
=20
-static void powernv_machine_class_init(ObjectClass *oc, void *data)
+static void pnv_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
     XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
     InterruptStatsProviderClass *ispc =3D INTERRUPT_STATS_PROVIDER_CLASS=
(oc);
=20
     mc->desc =3D "IBM PowerNV (Non-Virtualized)";
-    mc->init =3D ppc_powernv_init;
-    mc->reset =3D ppc_powernv_reset;
+    mc->init =3D pnv_init;
+    mc->reset =3D pnv_reset;
     mc->max_cpus =3D MAX_CPUS;
     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
     mc->block_default_type =3D IF_IDE; /* Pnv provides a AHCI device for
@@ -1104,7 +1104,7 @@ static void powernv_machine_class_init(ObjectClass =
*oc, void *data)
     xic->ics_resend =3D pnv_ics_resend;
     ispc->print_info =3D pnv_pic_print_info;
=20
-    powernv_machine_class_props_init(oc);
+    pnv_machine_class_props_init(oc);
 }
=20
 #define DEFINE_PNV_CHIP_TYPE(type, class_initfn) \
@@ -1116,11 +1116,11 @@ static void powernv_machine_class_init(ObjectClas=
s *oc, void *data)
=20
 static const TypeInfo types[] =3D {
     {
-        .name          =3D TYPE_POWERNV_MACHINE,
+        .name          =3D TYPE_PNV_MACHINE,
         .parent        =3D TYPE_MACHINE,
         .instance_size =3D sizeof(PnvMachineState),
-        .instance_init =3D powernv_machine_initfn,
-        .class_init    =3D powernv_machine_class_init,
+        .instance_init =3D pnv_machine_initfn,
+        .class_init    =3D pnv_machine_class_init,
         .interfaces =3D (InterfaceInfo[]) {
             { TYPE_XICS_FABRIC },
             { TYPE_INTERRUPT_STATS_PROVIDER },
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 82ff440b3334..78eeadbbb6a4 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -37,7 +37,7 @@ static const char *pnv_core_cpu_typename(PnvCore *pc)
     return cpu_type;
 }
=20
-static void powernv_cpu_reset(void *opaque)
+static void pnv_cpu_reset(void *opaque)
 {
     PowerPCCPU *cpu =3D opaque;
     CPUState *cs =3D CPU(cpu);
@@ -54,7 +54,7 @@ static void powernv_cpu_reset(void *opaque)
     env->msr |=3D MSR_HVB; /* Hypervisor mode */
 }
=20
-static void powernv_cpu_init(PowerPCCPU *cpu, Error **errp)
+static void pnv_cpu_init(PowerPCCPU *cpu, Error **errp)
 {
     CPUPPCState *env =3D &cpu->env;
     int core_pir;
@@ -73,7 +73,7 @@ static void powernv_cpu_init(PowerPCCPU *cpu, Error **e=
rrp)
     /* Set time-base frequency to 512 MHz */
     cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
=20
-    qemu_register_reset(powernv_cpu_reset, cpu);
+    qemu_register_reset(pnv_cpu_reset, cpu);
 }
=20
 /*
@@ -146,7 +146,7 @@ static void pnv_core_realize_child(Object *child, XIC=
SFabric *xi, Error **errp)
         return;
     }
=20
-    powernv_cpu_init(cpu, &local_err);
+    pnv_cpu_init(cpu, &local_err);
     if (local_err) {
         object_unparent(obj);
         error_propagate(errp, local_err);
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index f03a80a29bf6..27f0552b1e86 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -515,7 +515,7 @@ type_init(pnv_lpc_register_types)
  */
 static void pnv_lpc_isa_irq_handler_cpld(void *opaque, int n, int level)
 {
-    PnvMachineState *pnv =3D POWERNV_MACHINE(qdev_get_machine());
+    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
     uint32_t old_state =3D pnv->cpld_irqstate;
     PnvLpcController *lpc =3D PNV_LPC(opaque);
=20
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 59524cd42b61..6b262202c9e6 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -26,7 +26,7 @@
 #include "hw/ppc/pnv_psi.h"
 #include "hw/ppc/pnv_occ.h"
=20
-#define TYPE_PNV_CHIP "powernv-chip"
+#define TYPE_PNV_CHIP "pnv-chip"
 #define PNV_CHIP(obj) OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP)
 #define PNV_CHIP_CLASS(klass) \
      OBJECT_CLASS_CHECK(PnvChipClass, (klass), TYPE_PNV_CHIP)
@@ -117,9 +117,9 @@ typedef struct PnvChipClass {
 #define PNV_CHIP_INDEX(chip)                                    \
     (((chip)->chip_id >> 2) * 2 + ((chip)->chip_id & 0x3))
=20
-#define TYPE_POWERNV_MACHINE       MACHINE_TYPE_NAME("powernv")
-#define POWERNV_MACHINE(obj) \
-    OBJECT_CHECK(PnvMachineState, (obj), TYPE_POWERNV_MACHINE)
+#define TYPE_PNV_MACHINE       MACHINE_TYPE_NAME("powernv")
+#define PNV_MACHINE(obj) \
+    OBJECT_CHECK(PnvMachineState, (obj), TYPE_PNV_MACHINE)
=20
 typedef struct PnvMachineState {
     /*< private >*/
--=20
2.13.6
