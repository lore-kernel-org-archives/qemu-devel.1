Received: from eggs.gnu.org ([2001:4830:134:3::10]:58759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmgzm-0002DJ-P5
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmgzk-0002cg-Gs
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cmgzk-0002bh-7V
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:40 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 11 Mar 2017 17:22:45 +0400
Message-Id: <20170311132256.22951-11-marcandre.lureau@redhat.com>
In-Reply-To: <20170311132256.22951-1-marcandre.lureau@redhat.com>
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/21] Use uint property getter/setter where
 appropriate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anderson@redhat.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

All those property usages are associated with unsigned integers, so use
appropriate getter/setter.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/isa/isa.h         |  2 +-
 hw/acpi/memory_hotplug.c     | 10 ++++----
 hw/acpi/nvdimm.c             | 10 ++++----
 hw/acpi/pcihp.c              |  6 ++---
 hw/arm/aspeed.c              |  4 ++--
 hw/arm/bcm2835_peripherals.c |  9 ++++----
 hw/arm/raspi.c               |  4 ++--
 hw/core/platform-bus.c       |  2 +-
 hw/i386/acpi-build.c         | 55 ++++++++++++++++++++++----------------=
------
 hw/i386/pc.c                 |  6 ++---
 hw/intc/arm_gicv3_common.c   |  2 +-
 hw/mem/pc-dimm.c             |  5 ++--
 hw/misc/auxbus.c             |  2 +-
 hw/misc/pvpanic.c            |  2 +-
 hw/ppc/pnv_core.c            |  2 +-
 hw/ppc/spapr.c               |  8 ++++---
 numa.c                       |  6 ++---
 target/i386/cpu.c            |  4 ++--
 ui/console.c                 |  4 ++--
 xen-hvm.c                    |  6 ++---
 20 files changed, 77 insertions(+), 72 deletions(-)

diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index c2fdd70cdc..95593408ef 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -29,7 +29,7 @@ static inline uint16_t applesmc_port(void)
     Object *obj =3D object_resolve_path_type("", TYPE_APPLE_SMC, NULL);
=20
     if (obj) {
-        return object_property_get_int(obj, APPLESMC_PROP_IO_BASE, NULL)=
;
+        return object_property_get_uint(obj, APPLESMC_PROP_IO_BASE, NULL=
);
     }
     return 0;
 }
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 210073d283..db3c89ceab 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -83,11 +83,12 @@ static uint64_t acpi_memory_hotplug_read(void *opaque=
, hwaddr addr,
     o =3D OBJECT(mdev->dimm);
     switch (addr) {
     case 0x0: /* Lo part of phys address where DIMM is mapped */
-        val =3D o ? object_property_get_int(o, PC_DIMM_ADDR_PROP, NULL) =
: 0;
+        val =3D o ? object_property_get_uint(o, PC_DIMM_ADDR_PROP, NULL)=
 : 0;
         trace_mhp_acpi_read_addr_lo(mem_st->selector, val);
         break;
     case 0x4: /* Hi part of phys address where DIMM is mapped */
-        val =3D o ? object_property_get_int(o, PC_DIMM_ADDR_PROP, NULL) =
>> 32 : 0;
+        val =3D
+            o ? object_property_get_uint(o, PC_DIMM_ADDR_PROP, NULL) >> =
32 : 0;
         trace_mhp_acpi_read_addr_hi(mem_st->selector, val);
         break;
     case 0x8: /* Lo part of DIMM size */
@@ -95,11 +96,12 @@ static uint64_t acpi_memory_hotplug_read(void *opaque=
, hwaddr addr,
         trace_mhp_acpi_read_size_lo(mem_st->selector, val);
         break;
     case 0xc: /* Hi part of DIMM size */
-        val =3D o ? object_property_get_int(o, PC_DIMM_SIZE_PROP, NULL) =
>> 32 : 0;
+        val =3D
+            o ? object_property_get_int(o, PC_DIMM_SIZE_PROP, NULL) >> 3=
2 : 0;
         trace_mhp_acpi_read_size_hi(mem_st->selector, val);
         break;
     case 0x10: /* node proximity for _PXM method */
-        val =3D o ? object_property_get_int(o, PC_DIMM_NODE_PROP, NULL) =
: 0;
+        val =3D o ? object_property_get_uint(o, PC_DIMM_NODE_PROP, NULL)=
 : 0;
         trace_mhp_acpi_read_pxm(mem_st->selector, val);
         break;
     case 0x14: /* pack and return is_* fields */
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 8e7d6ec034..e57027149d 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -236,14 +236,14 @@ static void
 nvdimm_build_structure_spa(GArray *structures, DeviceState *dev)
 {
     NvdimmNfitSpa *nfit_spa;
-    uint64_t addr =3D object_property_get_int(OBJECT(dev), PC_DIMM_ADDR_=
PROP,
-                                            NULL);
+    uint64_t addr =3D object_property_get_uint(OBJECT(dev), PC_DIMM_ADDR=
_PROP,
+                                             NULL);
     uint64_t size =3D object_property_get_int(OBJECT(dev), PC_DIMM_SIZE_=
PROP,
                                             NULL);
-    uint32_t node =3D object_property_get_int(OBJECT(dev), PC_DIMM_NODE_=
PROP,
-                                            NULL);
+    uint32_t node =3D object_property_get_uint(OBJECT(dev), PC_DIMM_NODE=
_PROP,
+                                             NULL);
     int slot =3D object_property_get_int(OBJECT(dev), PC_DIMM_SLOT_PROP,
-                                            NULL);
+                                       NULL);
=20
     nfit_spa =3D acpi_data_push(structures, sizeof(*nfit_spa));
=20
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 2b0f3e1bfb..d0e9c4770a 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -63,10 +63,10 @@ typedef struct AcpiPciHpFind {
 static int acpi_pcihp_get_bsel(PCIBus *bus)
 {
     Error *local_err =3D NULL;
-    int64_t bsel =3D object_property_get_int(OBJECT(bus), ACPI_PCIHP_PRO=
P_BSEL,
-                                           &local_err);
+    uint64_t bsel =3D object_property_get_uint(OBJECT(bus), ACPI_PCIHP_P=
ROP_BSEL,
+                                             &local_err);
=20
-    if (local_err || bsel < 0 || bsel >=3D ACPI_PCIHP_MAX_HOTPLUG_BUS) {
+    if (local_err || bsel >=3D ACPI_PCIHP_MAX_HOTPLUG_BUS) {
         if (local_err) {
             error_free(local_err);
         }
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 283c038814..4af422909f 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -187,8 +187,8 @@ static void aspeed_board_init(MachineState *machine,
      * Allocate RAM after the memory controller has checked the size
      * was valid. If not, a default value is used.
      */
-    ram_size =3D object_property_get_int(OBJECT(&bmc->soc), "ram-size",
-                                       &error_abort);
+    ram_size =3D object_property_get_uint(OBJECT(&bmc->soc), "ram-size",
+                                        &error_abort);
=20
     memory_region_allocate_system_memory(&bmc->ram, NULL, "ram", ram_siz=
e);
     memory_region_add_subregion(get_system_memory(), sc->info->sdram_bas=
e,
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 369ef1e3bd..b168c6f83e 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -126,7 +126,7 @@ static void bcm2835_peripherals_realize(DeviceState *=
dev, Error **errp)
     Object *obj;
     MemoryRegion *ram;
     Error *err =3D NULL;
-    uint32_t ram_size, vcram_size;
+    uint64_t ram_size, vcram_size;
     int n;
=20
     obj =3D object_property_get_link(OBJECT(dev), "ram", &err);
@@ -208,15 +208,14 @@ static void bcm2835_peripherals_realize(DeviceState=
 *dev, Error **errp)
                                INTERRUPT_ARM_MAILBOX));
=20
     /* Framebuffer */
-    vcram_size =3D (uint32_t)object_property_get_int(OBJECT(s), "vcram-s=
ize",
-                                                   &err);
+    vcram_size =3D object_property_get_uint(OBJECT(s), "vcram-size", &er=
r);
     if (err) {
         error_propagate(errp, err);
         return;
     }
=20
-    object_property_set_int(OBJECT(&s->fb), ram_size - vcram_size,
-                            "vcram-base", &err);
+    object_property_set_uint(OBJECT(&s->fb), ram_size - vcram_size,
+                             "vcram-base", &err);
     if (err) {
         error_propagate(errp, err);
         return;
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 2b295f14c4..32cdc98c6d 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -153,8 +153,8 @@ static void raspi2_init(MachineState *machine)
     qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
     object_property_set_bool(OBJECT(carddev), true, "realized", &error_f=
atal);
=20
-    vcram_size =3D object_property_get_int(OBJECT(&s->soc), "vcram-size"=
,
-                                         &error_abort);
+    vcram_size =3D object_property_get_uint(OBJECT(&s->soc), "vcram-size=
",
+                                          &error_abort);
     setup_boot(machine, 2, machine->ram_size - vcram_size);
 }
=20
diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index 329ac670c0..33d32fbf22 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -71,7 +71,7 @@ hwaddr platform_bus_get_mmio_addr(PlatformBusDevice *pb=
us, SysBusDevice *sbdev,
         return -1;
     }
=20
-    return object_property_get_int(OBJECT(sbdev_mr), "addr", NULL);
+    return object_property_get_uint(OBJECT(sbdev_mr), "addr", NULL);
 }
=20
 static void platform_bus_count_irqs(SysBusDevice *sbdev, void *opaque)
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 76bff18e3f..d46195b83d 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -138,9 +138,9 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
         obj =3D piix;
         pm->cpu_hp_io_base =3D PIIX4_CPU_HOTPLUG_IO_BASE;
         pm->pcihp_io_base =3D
-            object_property_get_int(obj, ACPI_PCIHP_IO_BASE_PROP, NULL);
+            object_property_get_uint(obj, ACPI_PCIHP_IO_BASE_PROP, NULL)=
;
         pm->pcihp_io_len =3D
-            object_property_get_int(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
+            object_property_get_uint(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
     }
     if (lpc) {
         obj =3D lpc;
@@ -172,20 +172,21 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
     qobject_decref(o);
=20
     /* Fill in mandatory properties */
-    pm->sci_int =3D object_property_get_int(obj, ACPI_PM_PROP_SCI_INT, N=
ULL);
-
-    pm->acpi_enable_cmd =3D object_property_get_int(obj,
-                                                  ACPI_PM_PROP_ACPI_ENAB=
LE_CMD,
-                                                  NULL);
-    pm->acpi_disable_cmd =3D object_property_get_int(obj,
-                                                  ACPI_PM_PROP_ACPI_DISA=
BLE_CMD,
-                                                  NULL);
-    pm->io_base =3D object_property_get_int(obj, ACPI_PM_PROP_PM_IO_BASE=
,
-                                          NULL);
-    pm->gpe0_blk =3D object_property_get_int(obj, ACPI_PM_PROP_GPE0_BLK,
+    pm->sci_int =3D object_property_get_uint(obj, ACPI_PM_PROP_SCI_INT, =
NULL);
+
+    pm->acpi_enable_cmd =3D object_property_get_uint(obj,
+                                                   ACPI_PM_PROP_ACPI_ENA=
BLE_CMD,
+                                                   NULL);
+    pm->acpi_disable_cmd =3D
+        object_property_get_uint(obj,
+                                 ACPI_PM_PROP_ACPI_DISABLE_CMD,
+                                 NULL);
+    pm->io_base =3D object_property_get_uint(obj, ACPI_PM_PROP_PM_IO_BAS=
E,
                                            NULL);
-    pm->gpe0_blk_len =3D object_property_get_int(obj, ACPI_PM_PROP_GPE0_=
BLK_LEN,
-                                               NULL);
+    pm->gpe0_blk =3D object_property_get_uint(obj, ACPI_PM_PROP_GPE0_BLK=
,
+                                            NULL);
+    pm->gpe0_blk_len =3D object_property_get_uint(obj, ACPI_PM_PROP_GPE0=
_BLK_LEN,
+                                                NULL);
     pm->pcihp_bridge_en =3D
         object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-supp=
ort",
                                  NULL);
@@ -238,19 +239,19 @@ static void acpi_get_pci_holes(Range *hole, Range *=
hole64)
     g_assert(pci_host);
=20
     range_set_bounds1(hole,
-                      object_property_get_int(pci_host,
-                                              PCI_HOST_PROP_PCI_HOLE_STA=
RT,
-                                              NULL),
-                      object_property_get_int(pci_host,
-                                              PCI_HOST_PROP_PCI_HOLE_END=
,
-                                              NULL));
+                      object_property_get_uint(pci_host,
+                                               PCI_HOST_PROP_PCI_HOLE_ST=
ART,
+                                               NULL),
+                      object_property_get_uint(pci_host,
+                                               PCI_HOST_PROP_PCI_HOLE_EN=
D,
+                                               NULL));
     range_set_bounds1(hole64,
-                      object_property_get_int(pci_host,
-                                              PCI_HOST_PROP_PCI_HOLE64_S=
TART,
-                                              NULL),
-                      object_property_get_int(pci_host,
-                                              PCI_HOST_PROP_PCI_HOLE64_E=
ND,
-                                              NULL));
+                      object_property_get_uint(pci_host,
+                                               PCI_HOST_PROP_PCI_HOLE64_=
START,
+                                               NULL),
+                      object_property_get_uint(pci_host,
+                                               PCI_HOST_PROP_PCI_HOLE64_=
END,
+                                               NULL));
 }
=20
 #define ACPI_PORT_SMI_CMD           0x00b2 /* TODO: this is APM_CNT_IOPO=
RT */
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d24388e05f..3b3c2dc43c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -347,7 +347,7 @@ static int check_fdc(Object *obj, void *opaque)
         return 0;
     }
=20
-    iobase =3D object_property_get_int(obj, "iobase", &local_err);
+    iobase =3D object_property_get_uint(obj, "iobase", &local_err);
     if (local_err || iobase !=3D 0x3f0) {
         error_free(local_err);
         return 0;
@@ -1100,7 +1100,7 @@ static void pc_new_cpu(const char *typename, int64_=
t apic_id, Error **errp)
=20
     cpu =3D object_new(typename);
=20
-    object_property_set_int(cpu, apic_id, "apic-id", &local_err);
+    object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
     object_property_set_bool(cpu, true, "realized", &local_err);
=20
     object_unref(cpu);
@@ -1562,7 +1562,7 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq=
 *gsi,
              * and earlier, use IRQ2 for compat. Otherwise, use IRQ16~23=
,
              * IRQ8 and IRQ2.
              */
-            uint8_t compat =3D object_property_get_int(OBJECT(hpet),
+            uint8_t compat =3D object_property_get_uint(OBJECT(hpet),
                     HPET_INTCAP, NULL);
             if (!compat) {
                 qdev_prop_set_uint32(hpet, HPET_INTCAP, hpet_irqs);
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index c6493d6c07..e2064cd8c5 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -267,7 +267,7 @@ static void arm_gicv3_common_realize(DeviceState *dev=
, Error **errp)
          *  VLPIS =3D=3D 0 (virtual LPIs not supported)
          *  PLPIS =3D=3D 0 (physical LPIs not supported)
          */
-        cpu_affid =3D object_property_get_int(OBJECT(cpu), "mp-affinity"=
, NULL);
+        cpu_affid =3D object_property_get_uint(OBJECT(cpu), "mp-affinity=
", NULL);
         last =3D (i =3D=3D s->num_cpu - 1);
=20
         /* The CPU mp-affinity property is in MPIDR register format; squ=
ash
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 9e8dab0e89..f6def8c239 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -46,7 +46,8 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplu=
gState *hpms,
     uint64_t existing_dimms_capacity =3D 0;
     uint64_t addr;
=20
-    addr =3D object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PROP, &l=
ocal_err);
+    addr =3D object_property_get_uint(OBJECT(dimm),
+                                    PC_DIMM_ADDR_PROP, &local_err);
     if (local_err) {
         goto out;
     }
@@ -73,7 +74,7 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplu=
gState *hpms,
         goto out;
     }
=20
-    object_property_set_int(OBJECT(dev), addr, PC_DIMM_ADDR_PROP, &local=
_err);
+    object_property_set_uint(OBJECT(dev), addr, PC_DIMM_ADDR_PROP, &loca=
l_err);
     if (local_err) {
         goto out;
     }
diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index e4a7ba41de..8a90ddda84 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -244,7 +244,7 @@ static void aux_slave_dev_print(Monitor *mon, DeviceS=
tate *dev, int indent)
=20
     monitor_printf(mon, "%*smemory " TARGET_FMT_plx "/" TARGET_FMT_plx "=
\n",
                    indent, "",
-                   object_property_get_int(OBJECT(s->mmio), "addr", NULL=
),
+                   object_property_get_uint(OBJECT(s->mmio), "addr", NUL=
L),
                    memory_region_size(s->mmio));
 }
=20
diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 57da7f2199..2b1e9a6450 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -111,7 +111,7 @@ uint16_t pvpanic_port(void)
     if (!o) {
         return 0;
     }
-    return object_property_get_int(o, PVPANIC_IOPORT_PROP, NULL);
+    return object_property_get_uint(o, PVPANIC_IOPORT_PROP, NULL);
 }
=20
 static Property pvpanic_isa_properties[] =3D {
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index d79d530b48..fe3758754b 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -50,7 +50,7 @@ static void powernv_cpu_init(PowerPCCPU *cpu, Error **e=
rrp)
     int thread_index =3D 0; /* TODO: TCG supports only one thread */
     ppc_spr_t *pir =3D &env->spr_cb[SPR_PIR];
=20
-    core_pir =3D object_property_get_int(OBJECT(cpu), "core-pir", &error=
_abort);
+    core_pir =3D object_property_get_uint(OBJECT(cpu), "core-pir", &erro=
r_abort);
=20
     /*
      * The PIR of a thread is the core PIR + the thread index. We will
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c3bb991605..a7fdeab471 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2528,7 +2528,8 @@ static void spapr_memory_plug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
         goto out;
     }
=20
-    addr =3D object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PROP, &l=
ocal_err);
+    addr =3D object_property_get_uint(OBJECT(dimm),
+                                    PC_DIMM_ADDR_PROP, &local_err);
     if (local_err) {
         pc_dimm_memory_unplug(dev, &ms->hotplug_memory, mr);
         goto out;
@@ -2616,7 +2617,8 @@ static void spapr_memory_unplug_request(HotplugHand=
ler *hotplug_dev,
     uint64_t size =3D memory_region_size(mr);
     uint64_t addr;
=20
-    addr =3D object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PROP, &l=
ocal_err);
+    addr =3D object_property_get_uint(OBJECT(dimm),
+                                    PC_DIMM_ADDR_PROP, &local_err);
     if (local_err) {
         goto out;
     }
@@ -2818,7 +2820,7 @@ static void spapr_machine_device_plug(HotplugHandle=
r *hotplug_dev,
             error_setg(errp, "Memory hotplug not supported for this mach=
ine");
             return;
         }
-        node =3D object_property_get_int(OBJECT(dev), PC_DIMM_NODE_PROP,=
 errp);
+        node =3D object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP=
, errp);
         if (*errp) {
             return;
         }
diff --git a/numa.c b/numa.c
index e01cb547a2..d22f3acc8a 100644
--- a/numa.c
+++ b/numa.c
@@ -205,7 +205,7 @@ static void numa_node_parse(NumaNodeOptions *node, Qe=
muOpts *opts, Error **errp)
         }
=20
         object_ref(o);
-        numa_info[nodenr].node_mem =3D object_property_get_int(o, "size"=
, NULL);
+        numa_info[nodenr].node_mem =3D object_property_get_uint(o, "size=
", NULL);
         numa_info[nodenr].node_memdev =3D MEMORY_BACKEND(o);
     }
     numa_info[nodenr].present =3D true;
@@ -527,8 +527,8 @@ static int query_memdev(Object *obj, void *opaque)
         m->value->id =3D object_property_get_str(obj, "id", NULL);
         m->value->has_id =3D !!m->value->id;
=20
-        m->value->size =3D object_property_get_int(obj, "size",
-                                                 &error_abort);
+        m->value->size =3D object_property_get_uint(obj, "size",
+                                                  &error_abort);
         m->value->merge =3D object_property_get_bool(obj, "merge",
                                                    &error_abort);
         m->value->dump =3D object_property_get_bool(obj, "dump",
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 54f859bc8d..261b1002e9 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2309,8 +2309,8 @@ static void x86_cpu_load_def(X86CPU *cpu, X86CPUDef=
inition *def, Error **errp)
      */
=20
     /* CPU models only set _minimum_ values for level/xlevel: */
-    object_property_set_int(OBJECT(cpu), def->level, "min-level", errp);
-    object_property_set_int(OBJECT(cpu), def->xlevel, "min-xlevel", errp=
);
+    object_property_set_uint(OBJECT(cpu), def->level, "min-level", errp)=
;
+    object_property_set_uint(OBJECT(cpu), def->xlevel, "min-xlevel", err=
p);
=20
     object_property_set_int(OBJECT(cpu), def->family, "family", errp);
     object_property_set_int(OBJECT(cpu), def->model, "model", errp);
diff --git a/ui/console.c b/ui/console.c
index d1ff7504ec..c5233c8daf 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1866,8 +1866,8 @@ QemuConsole *qemu_console_lookup_by_device(DeviceSt=
ate *dev, uint32_t head)
         if (DEVICE(obj) !=3D dev) {
             continue;
         }
-        h =3D object_property_get_int(OBJECT(consoles[i]),
-                                    "head", &error_abort);
+        h =3D object_property_get_uint(OBJECT(consoles[i]),
+                                     "head", &error_abort);
         if (h !=3D head) {
             continue;
         }
diff --git a/xen-hvm.c b/xen-hvm.c
index 5043beb98f..16c3a259fa 100644
--- a/xen-hvm.c
+++ b/xen-hvm.c
@@ -183,9 +183,9 @@ static void xen_ram_init(PCMachineState *pcms,
 {
     MemoryRegion *sysmem =3D get_system_memory();
     ram_addr_t block_len;
-    uint64_t user_lowmem =3D object_property_get_int(qdev_get_machine(),
-                                                   PC_MACHINE_MAX_RAM_BE=
LOW_4G,
-                                                   &error_abort);
+    uint64_t user_lowmem =3D object_property_get_uint(qdev_get_machine()=
,
+                                                    PC_MACHINE_MAX_RAM_B=
ELOW_4G,
+                                                    &error_abort);
=20
     /* Handle the machine opt max-ram-below-4g.  It is basically doing
      * min(xen limit, user limit).
--=20
2.12.0.191.gc5d8de91d
