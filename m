Received: from eggs.gnu.org ([209.51.188.92]:49256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1h2K7a-0000X6-Bk
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:21:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1h2K7Y-0008Gy-QQ
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:21:26 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Fri,  8 Mar 2019 19:20:53 +0100
Message-Id: <20190308182053.5487-3-eric.auger@redhat.com>
In-Reply-To: <20190308182053.5487-1-eric.auger@redhat.com>
References: <20190308182053.5487-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 2/2] machine: Move nvdimms state into struct
 MachineState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com, richard.henderson@linaro.org, sbhat@linux.ibm.com, philmd@redhat.com

As NVDIMM support is looming for ARM and SPAPR, let's
move the acpi_nvdimm_state to the generic machine struct
instead of duplicating the same code in several machines.
It is also renamed into nvdimms_state and becomes a pointer.

nvdimm and nvdimm-persistence become generic machine options.
They become guarded by a nvdimm_supported machine class member.
We also add a description for those options.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>

---
v3 -> v4:
- s/object_class_property_*/object_property_*
v2 -> v3
- nvdimms_state becomes a pointer
- add machine class nvdimm_supported

v1 -> v2:
- s/acpi_nvdimm_state/nvdimms_state
- remove ms->nvdimms_state.is_enabled initialization to false.
---
 hw/core/machine.c    | 65 ++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c |  6 ++--
 hw/i386/pc.c         | 57 ++++----------------------------------
 hw/i386/pc_piix.c    |  4 +--
 hw/i386/pc_q35.c     |  4 +--
 include/hw/boards.h  |  2 ++
 include/hw/i386/pc.h |  4 ---
 7 files changed, 79 insertions(+), 63 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 766ca5899d..743fef2898 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -22,6 +22,7 @@
 #include "qemu/error-report.h"
 #include "sysemu/qtest.h"
 #include "hw/pci/pci.h"
+#include "hw/mem/nvdimm.h"
=20
 GlobalProperty hw_compat_3_1[] =3D {
     { "pcie-root-port", "x-speed", "2_5" },
@@ -481,6 +482,47 @@ static void machine_set_memory_encryption(Object *ob=
j, const char *value,
     ms->memory_encryption =3D g_strdup(value);
 }
=20
+static bool machine_get_nvdimm(Object *obj, Error **errp)
+{
+    MachineState *ms =3D MACHINE(obj);
+
+    return ms->nvdimms_state->is_enabled;
+}
+
+static void machine_set_nvdimm(Object *obj, bool value, Error **errp)
+{
+    MachineState *ms =3D MACHINE(obj);
+
+    ms->nvdimms_state->is_enabled =3D value;
+}
+
+static char *machine_get_nvdimm_persistence(Object *obj, Error **errp)
+{
+    MachineState *ms =3D MACHINE(obj);
+
+    return g_strdup(ms->nvdimms_state->persistence_string);
+}
+
+static void machine_set_nvdimm_persistence(Object *obj, const char *valu=
e,
+                                           Error **errp)
+{
+    MachineState *ms =3D MACHINE(obj);
+    NVDIMMState *nvdimms_state =3D ms->nvdimms_state;
+
+    if (strcmp(value, "cpu") =3D=3D 0) {
+        nvdimms_state->persistence =3D 3;
+    } else if (strcmp(value, "mem-ctrl") =3D=3D 0) {
+        nvdimms_state->persistence =3D 2;
+    } else {
+        error_setg(errp, "-machine nvdimm-persistence=3D%s: unsupported =
option",
+                   value);
+        return;
+    }
+
+    g_free(nvdimms_state->persistence_string);
+    nvdimms_state->persistence_string =3D g_strdup(value);
+}
+
 void machine_class_allow_dynamic_sysbus_dev(MachineClass *mc, const char=
 *type)
 {
     strList *item =3D g_new0(strList, 1);
@@ -791,6 +833,28 @@ static void machine_initfn(Object *obj)
     ms->mem_merge =3D true;
     ms->enable_graphics =3D true;
=20
+    if (mc->nvdimm_supported) {
+        Object *obj =3D OBJECT(ms);
+
+        ms->nvdimms_state =3D g_new0(NVDIMMState, 1);
+        object_property_add_bool(obj, "nvdimm",
+                                 machine_get_nvdimm, machine_set_nvdimm,
+                                 &error_abort);
+        object_property_set_description(obj, "nvdimm",
+                                        "Set on/off to enable/disable "
+                                        "NVDIMM instantiation", NULL);
+
+        object_property_add_str(obj, "nvdimm-persistence",
+                                machine_get_nvdimm_persistence,
+                                machine_set_nvdimm_persistence,
+                                &error_abort);
+        object_property_set_description(obj, "nvdimm-persistence",
+                                        "Set NVDIMM persistence"
+                                        "Valid values are cpu, mem-ctrl"=
,
+                                        NULL);
+    }
+
+
     /* Register notifier when init is done for sysbus sanity checks */
     ms->sysbus_notifier.notify =3D machine_init_notify;
     qemu_add_machine_init_done_notifier(&ms->sysbus_notifier);
@@ -809,6 +873,7 @@ static void machine_finalize(Object *obj)
     g_free(ms->dt_compatible);
     g_free(ms->firmware);
     g_free(ms->device_memory);
+    g_free(ms->nvdimms_state);
 }
=20
 bool machine_usb(MachineState *machine)
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9ecc96dcc7..416da318ae 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1867,7 +1867,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             aml_append(scope, method);
         }
=20
-        if (pcms->acpi_nvdimm_state.is_enabled) {
+        if (machine->nvdimms_state->is_enabled) {
             method =3D aml_method("_E04", 0, AML_NOTSERIALIZED);
             aml_append(method, aml_notify(aml_name("\\_SB.NVDR"),
                                           aml_int(0x80)));
@@ -2704,9 +2704,9 @@ void acpi_build(AcpiBuildTables *tables, MachineSta=
te *machine)
             build_dmar_q35(tables_blob, tables->linker);
         }
     }
-    if (pcms->acpi_nvdimm_state.is_enabled) {
+    if (machine->nvdimms_state->is_enabled) {
         nvdimm_build_acpi(table_offsets, tables_blob, tables->linker,
-                          &pcms->acpi_nvdimm_state, machine->ram_slots);
+                          machine->nvdimms_state, machine->ram_slots);
     }
=20
     /* Add tables supplied by user (if any) */
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 0338dbe9da..71385cfac9 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2069,6 +2069,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
 {
     const PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
     const PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
+    const MachineState *ms =3D MACHINE(hotplug_dev);
     const bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIM=
M);
     const uint64_t legacy_align =3D TARGET_PAGE_SIZE;
=20
@@ -2083,7 +2084,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
         return;
     }
=20
-    if (is_nvdimm && !pcms->acpi_nvdimm_state.is_enabled) {
+    if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
         error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M=
'");
         return;
     }
@@ -2097,6 +2098,7 @@ static void pc_memory_plug(HotplugHandler *hotplug_=
dev,
 {
     Error *local_err =3D NULL;
     PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
+    MachineState *ms =3D MACHINE(hotplug_dev);
     bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
=20
     pc_dimm_plug(PC_DIMM(dev), MACHINE(pcms), &local_err);
@@ -2105,7 +2107,7 @@ static void pc_memory_plug(HotplugHandler *hotplug_=
dev,
     }
=20
     if (is_nvdimm) {
-        nvdimm_plug(&pcms->acpi_nvdimm_state);
+        nvdimm_plug(ms->nvdimms_state);
     }
=20
     hotplug_handler_plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &error_ab=
ort);
@@ -2546,47 +2548,6 @@ static void pc_machine_set_smm(Object *obj, Visito=
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
-    NVDIMMState *nvdimm_state =3D &pcms->acpi_nvdimm_state;
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
@@ -2636,8 +2597,6 @@ static void pc_machine_initfn(Object *obj)
     pcms->max_ram_below_4g =3D 0; /* use default */
     pcms->smm =3D ON_OFF_AUTO_AUTO;
     pcms->vmport =3D ON_OFF_AUTO_AUTO;
-    /* nvdimm is disabled on default. */
-    pcms->acpi_nvdimm_state.is_enabled =3D false;
     /* acpi build is enabled by default if machine supports it */
     pcms->acpi_build_enabled =3D PC_MACHINE_GET_CLASS(pcms)->has_acpi_bu=
ild;
     pcms->smbus_enabled =3D true;
@@ -2774,6 +2733,7 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
     hc->unplug =3D pc_machine_device_unplug_cb;
     nc->nmi_monitor_handler =3D x86_nmi;
     mc->default_cpu_type =3D TARGET_DEFAULT_CPU_TYPE;
+    mc->nvdimm_supported =3D true;
=20
     object_class_property_add(oc, PC_MACHINE_DEVMEM_REGION_SIZE, "int",
         pc_machine_get_device_memory_region_size, NULL,
@@ -2798,13 +2758,6 @@ static void pc_machine_class_init(ObjectClass *oc,=
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
index 8770ecada9..8ad8e885c6 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -297,8 +297,8 @@ static void pc_init1(MachineState *machine,
                                  PC_MACHINE_ACPI_DEVICE_PROP, &error_abo=
rt);
     }
=20
-    if (pcms->acpi_nvdimm_state.is_enabled) {
-        nvdimm_init_acpi_state(&pcms->acpi_nvdimm_state, system_io,
+    if (machine->nvdimms_state->is_enabled) {
+        nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
                                pcms->fw_cfg, OBJECT(pcms));
     }
 }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index cfb9043e12..372c6b73be 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -329,8 +329,8 @@ static void pc_q35_init(MachineState *machine)
     pc_vga_init(isa_bus, host_bus);
     pc_nic_init(pcmc, isa_bus, host_bus);
=20
-    if (pcms->acpi_nvdimm_state.is_enabled) {
-        nvdimm_init_acpi_state(&pcms->acpi_nvdimm_state, system_io,
+    if (machine->nvdimms_state->is_enabled) {
+        nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
                                pcms->fw_cfg, OBJECT(pcms));
     }
 }
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 9690c71a6d..e231860666 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -210,6 +210,7 @@ struct MachineClass {
                                  int nb_nodes, ram_addr_t size);
     bool ignore_boot_device_suffixes;
     bool smbus_no_migration_support;
+    bool nvdimm_supported;
=20
     HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
@@ -272,6 +273,7 @@ struct MachineState {
     const char *cpu_type;
     AccelState *accelerator;
     CPUArchIdList *possible_cpus;
+    struct NVDIMMState *nvdimms_state;
 };
=20
 #define DEFINE_MACHINE(namestr, machine_initfn) \
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 94fb620d65..263a6343ff 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -45,8 +45,6 @@ struct PCMachineState {
     OnOffAuto vmport;
     OnOffAuto smm;
=20
-    NVDIMMState acpi_nvdimm_state;
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
--=20
2.20.1
