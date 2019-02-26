Received: from eggs.gnu.org ([209.51.188.92]:47782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gyd9O-0000vu-6o
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:52:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gyd9E-0007fR-6X
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:52:00 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 26 Feb 2019 14:50:11 +0100
Message-Id: <20190226135014.31854-16-eric.auger@redhat.com>
In-Reply-To: <20190226135014.31854-1-eric.auger@redhat.com>
References: <20190226135014.31854-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 15/18] machine: Move acpi_nvdimm_state into
 struct MachineState
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

As NVDIMM support is looming for ARM and SPAPR, let's
move the acpi_nvdimm_state to the generic machine struct
instead of duplicating the same code in several machines.

nvdimm and nvdimm-persistence becomes generic machine options.
We also add a description for those options.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/core/machine.c        | 57 ++++++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c     |  6 ++---
 hw/i386/pc.c             | 56 +++------------------------------------
 hw/i386/pc_piix.c        |  4 +--
 hw/i386/pc_q35.c         |  4 +--
 include/hw/boards.h      |  2 ++
 include/hw/i386/pc.h     |  4 ---
 include/hw/mem/pc-dimm.h |  1 -
 8 files changed, 70 insertions(+), 64 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 077fbd182a..77c5bf7fe5 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -479,6 +479,47 @@ static void machine_set_memory_encryption(Object *ob=
j, const char *value,
     ms->memory_encryption =3D g_strdup(value);
 }
=20
+static bool machine_get_nvdimm(Object *obj, Error **errp)
+{
+    MachineState *ms =3D MACHINE(obj);
+
+    return ms->acpi_nvdimm_state.is_enabled;
+}
+
+static void machine_set_nvdimm(Object *obj, bool value, Error **errp)
+{
+    MachineState *ms =3D MACHINE(obj);
+
+    ms->acpi_nvdimm_state.is_enabled =3D value;
+}
+
+static char *machine_get_nvdimm_persistence(Object *obj, Error **errp)
+{
+    MachineState *ms =3D MACHINE(obj);
+
+    return g_strdup(ms->acpi_nvdimm_state.persistence_string);
+}
+
+static void machine_set_nvdimm_persistence(Object *obj, const char *valu=
e,
+                                               Error **errp)
+{
+    MachineState *ms =3D MACHINE(obj);
+    AcpiNVDIMMState *nvdimm_state =3D &ms->acpi_nvdimm_state;
+
+    if (strcmp(value, "cpu") =3D=3D 0)
+        nvdimm_state->persistence =3D 3;
+    else if (strcmp(value, "mem-ctrl") =3D=3D 0)
+        nvdimm_state->persistence =3D 2;
+    else {
+        error_setg(errp, "-machine nvdimm-persistence=3D%s: unsupported =
option",
+                   value);
+        return;
+    }
+
+    g_free(nvdimm_state->persistence_string);
+    nvdimm_state->persistence_string =3D g_strdup(value);
+}
+
 void machine_class_allow_dynamic_sysbus_dev(MachineClass *mc, const char=
 *type)
 {
     strList *item =3D g_new0(strList, 1);
@@ -763,6 +804,20 @@ static void machine_class_init(ObjectClass *oc, void=
 *data)
         &error_abort);
     object_class_property_set_description(oc, "memory-encryption",
         "Set memory encryption object to use", &error_abort);
+
+    object_class_property_add_bool(oc, "nvdimm",
+        machine_get_nvdimm, machine_set_nvdimm, &error_abort);
+    object_class_property_set_description(oc, "nvdimm",
+                                         "Set on/off to enable/disable N=
VDIMM "
+                                         "instantiation", NULL);
+
+    object_class_property_add_str(oc, "nvdimm-persistence",
+                                  machine_get_nvdimm_persistence,
+                                  machine_set_nvdimm_persistence, &error=
_abort);
+    object_class_property_set_description(oc, "nvdimm-persistence",
+                                          "Set NVDIMM persistence"
+                                          "Valid values are cpu and mem-=
ctrl",
+                                          NULL);
 }
=20
 static void machine_class_base_init(ObjectClass *oc, void *data)
@@ -788,6 +843,8 @@ static void machine_initfn(Object *obj)
     ms->dump_guest_core =3D true;
     ms->mem_merge =3D true;
     ms->enable_graphics =3D true;
+    /* nvdimm is disabled on default. */
+    ms->acpi_nvdimm_state.is_enabled =3D false;
=20
     /* Register notifier when init is done for sysbus sanity checks */
     ms->sysbus_notifier.notify =3D machine_init_notify;
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 4809abf23d..36fe8057fc 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1873,7 +1873,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             aml_append(scope, method);
         }
=20
-        if (pcms->acpi_nvdimm_state.is_enabled) {
+        if (machine->acpi_nvdimm_state.is_enabled) {
             method =3D aml_method("_E04", 0, AML_NOTSERIALIZED);
             aml_append(method, aml_notify(aml_name("\\_SB.NVDR"),
                                           aml_int(0x80)));
@@ -2710,9 +2710,9 @@ void acpi_build(AcpiBuildTables *tables, MachineSta=
te *machine)
             build_dmar_q35(tables_blob, tables->linker);
         }
     }
-    if (pcms->acpi_nvdimm_state.is_enabled) {
+    if (machine->acpi_nvdimm_state.is_enabled) {
         nvdimm_build_acpi(table_offsets, tables_blob, tables->linker,
-                          &pcms->acpi_nvdimm_state, machine->ram_slots);
+                          &machine->acpi_nvdimm_state, machine->ram_slot=
s);
     }
=20
     /* Add tables supplied by user (if any) */
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3889eccdc3..356213e0b8 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2096,6 +2096,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
 {
     const PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
     const PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
+    const MachineState *ms =3D MACHINE(hotplug_dev);
     const bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIM=
M);
     const uint64_t legacy_align =3D TARGET_PAGE_SIZE;
=20
@@ -2110,7 +2111,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
         return;
     }
=20
-    if (is_nvdimm && !pcms->acpi_nvdimm_state.is_enabled) {
+    if (is_nvdimm && !ms->acpi_nvdimm_state.is_enabled) {
         error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M=
'");
         return;
     }
@@ -2124,6 +2125,7 @@ static void pc_memory_plug(HotplugHandler *hotplug_=
dev,
 {
     Error *local_err =3D NULL;
     PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
+    MachineState *ms =3D MACHINE(hotplug_dev);
     bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
=20
     pc_dimm_plug(PC_DIMM(dev), MACHINE(pcms), &local_err);
@@ -2132,7 +2134,7 @@ static void pc_memory_plug(HotplugHandler *hotplug_=
dev,
     }
=20
     if (is_nvdimm) {
-        nvdimm_plug(&pcms->acpi_nvdimm_state);
+        nvdimm_plug(&ms->acpi_nvdimm_state);
     }
=20
     hotplug_handler_plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &error_ab=
ort);
@@ -2574,47 +2576,6 @@ static void pc_machine_set_smm(Object *obj, Visito=
r *v, const char *name,
     visit_type_OnOffAuto(v, name, &pcms->smm, errp);
 }
=20
-static bool pc_machine_get_nvdimm(Object *obj, Error **errp)
-{
-    PCMachineState *pcms =3D PC_MACHINE(obj);
-
-    return pcms->acpi_nvdimm_state.is_enabled;
-}
-
-static void pc_machine_set_nvdimm(Object *obj, bool value, Error **errp)
-{
-    PCMachineState *pcms =3D PC_MACHINE(obj);
-
-    pcms->acpi_nvdimm_state.is_enabled =3D value;
-}
-
-static char *pc_machine_get_nvdimm_persistence(Object *obj, Error **errp=
)
-{
-    PCMachineState *pcms =3D PC_MACHINE(obj);
-
-    return g_strdup(pcms->acpi_nvdimm_state.persistence_string);
-}
-
-static void pc_machine_set_nvdimm_persistence(Object *obj, const char *v=
alue,
-                                               Error **errp)
-{
-    PCMachineState *pcms =3D PC_MACHINE(obj);
-    AcpiNVDIMMState *nvdimm_state =3D &pcms->acpi_nvdimm_state;
-
-    if (strcmp(value, "cpu") =3D=3D 0)
-        nvdimm_state->persistence =3D 3;
-    else if (strcmp(value, "mem-ctrl") =3D=3D 0)
-        nvdimm_state->persistence =3D 2;
-    else {
-        error_setg(errp, "-machine nvdimm-persistence=3D%s: unsupported =
option",
-                   value);
-        return;
-    }
-
-    g_free(nvdimm_state->persistence_string);
-    nvdimm_state->persistence_string =3D g_strdup(value);
-}
-
 static bool pc_machine_get_smbus(Object *obj, Error **errp)
 {
     PCMachineState *pcms =3D PC_MACHINE(obj);
@@ -2664,8 +2625,6 @@ static void pc_machine_initfn(Object *obj)
     pcms->max_ram_below_4g =3D 0; /* use default */
     pcms->smm =3D ON_OFF_AUTO_AUTO;
     pcms->vmport =3D ON_OFF_AUTO_AUTO;
-    /* nvdimm is disabled on default. */
-    pcms->acpi_nvdimm_state.is_enabled =3D false;
     /* acpi build is enabled by default if machine supports it */
     pcms->acpi_build_enabled =3D PC_MACHINE_GET_CLASS(pcms)->has_acpi_bu=
ild;
     pcms->smbus_enabled =3D true;
@@ -2826,13 +2785,6 @@ static void pc_machine_class_init(ObjectClass *oc,=
 void *data)
     object_class_property_set_description(oc, PC_MACHINE_VMPORT,
         "Enable vmport (pc & q35)", &error_abort);
=20
-    object_class_property_add_bool(oc, PC_MACHINE_NVDIMM,
-        pc_machine_get_nvdimm, pc_machine_set_nvdimm, &error_abort);
-
-    object_class_property_add_str(oc, PC_MACHINE_NVDIMM_PERSIST,
-        pc_machine_get_nvdimm_persistence,
-        pc_machine_set_nvdimm_persistence, &error_abort);
-
     object_class_property_add_bool(oc, PC_MACHINE_SMBUS,
         pc_machine_get_smbus, pc_machine_set_smbus, &error_abort);
=20
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index e8988f6669..4277ac429b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -298,8 +298,8 @@ static void pc_init1(MachineState *machine,
                                  PC_MACHINE_ACPI_DEVICE_PROP, &error_abo=
rt);
     }
=20
-    if (pcms->acpi_nvdimm_state.is_enabled) {
-        nvdimm_init_acpi_state(&pcms->acpi_nvdimm_state, system_io,
+    if (machine->acpi_nvdimm_state.is_enabled) {
+        nvdimm_init_acpi_state(&machine->acpi_nvdimm_state, system_io,
                                x86_nvdimm_acpi_dsmio,
                                pcms->fw_cfg, OBJECT(pcms));
     }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 3dddf6e1b2..1dd747d1ab 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -330,8 +330,8 @@ static void pc_q35_init(MachineState *machine)
     pc_vga_init(isa_bus, host_bus);
     pc_nic_init(pcmc, isa_bus, host_bus);
=20
-    if (pcms->acpi_nvdimm_state.is_enabled) {
-        nvdimm_init_acpi_state(&pcms->acpi_nvdimm_state, system_io,
+    if (machine->acpi_nvdimm_state.is_enabled) {
+        nvdimm_init_acpi_state(&machine->acpi_nvdimm_state, system_io,
                                x86_nvdimm_acpi_dsmio,
                                pcms->fw_cfg, OBJECT(pcms));
     }
diff --git a/include/hw/boards.h b/include/hw/boards.h
index ed2fec82d5..f7ce553aa1 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -8,6 +8,7 @@
 #include "hw/qdev.h"
 #include "qom/object.h"
 #include "qom/cpu.h"
+#include "hw/mem/nvdimm.h"
=20
 /**
  * memory_region_allocate_system_memory - Allocate a board's main memory
@@ -271,6 +272,7 @@ struct MachineState {
     const char *cpu_type;
     AccelState *accelerator;
     CPUArchIdList *possible_cpus;
+    AcpiNVDIMMState acpi_nvdimm_state;
 };
=20
 #define DEFINE_MACHINE(namestr, machine_initfn) \
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 3ff127ebd0..f7c59743e0 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -45,8 +45,6 @@ struct PCMachineState {
     OnOffAuto vmport;
     OnOffAuto smm;
=20
-    AcpiNVDIMMState acpi_nvdimm_state;
-
     bool acpi_build_enabled;
     bool smbus_enabled;
     bool sata_enabled;
@@ -74,8 +72,6 @@ struct PCMachineState {
 #define PC_MACHINE_MAX_RAM_BELOW_4G "max-ram-below-4g"
 #define PC_MACHINE_VMPORT           "vmport"
 #define PC_MACHINE_SMM              "smm"
-#define PC_MACHINE_NVDIMM           "nvdimm"
-#define PC_MACHINE_NVDIMM_PERSIST   "nvdimm-persistence"
 #define PC_MACHINE_SMBUS            "smbus"
 #define PC_MACHINE_SATA             "sata"
 #define PC_MACHINE_PIT              "pit"
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index 01436b9f50..3e5489d3a1 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -19,7 +19,6 @@
 #include "exec/memory.h"
 #include "sysemu/hostmem.h"
 #include "hw/qdev.h"
-#include "hw/boards.h"
=20
 #define TYPE_PC_DIMM "pc-dimm"
 #define PC_DIMM(obj) \
--=20
2.20.1
