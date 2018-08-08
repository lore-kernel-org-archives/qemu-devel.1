Received: from eggs.gnu.org ([2001:4830:134:3::10]:51460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fnQBx-0005pK-Tt
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 11:16:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fnQBv-0002h3-2v
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 11:16:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50250 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fnQBu-0002gm-S9
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 11:16:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7932187916
	for <qemu-devel@nongnu.org>; Wed,  8 Aug 2018 15:16:02 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed,  8 Aug 2018 17:15:48 +0200
Message-Id: <1533741349-199141-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1533741349-199141-1-git-send-email-imammedo@redhat.com>
References: <1533741349-199141-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 3/4] pc: acpi: add _CST support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>

Reuse CPU hotplug IO registers for passing a CST entry
containing package for shalowest C1 using mwait and
read it out in guest with new CCST AML method.

The CState support is optional and could be turned on
with '-global PIIX4_PM.cstate=on' CLI option.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
for demo purposes it's wired only to piix4
TODO: q35 wiring

'tested' with rhel7 and XPsp3 - WS2016
 (i.e. it boots and all windows versions happy about AML qemu produces)
---
 include/hw/acpi/cpu.h           |   9 +++
 docs/specs/acpi_cpu_hotplug.txt |  10 ++-
 hw/acpi/cpu.c                   | 131 ++++++++++++++++++++++++++++++++++++++++
 hw/acpi/piix4.c                 |   2 +
 hw/i386/acpi-build.c            |   5 +-
 tests/bios-tables-test.c        |   1 +
 6 files changed, 156 insertions(+), 2 deletions(-)

diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index 89ce172..eb79cbf 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -17,6 +17,12 @@
 #include "hw/acpi/aml-build.h"
 #include "hw/hotplug.h"
 
+typedef struct AcpiCState {
+    uint32_t current_cst_field;
+    uint32_t latency;
+    uint32_t power;
+} AcpiCState;
+
 typedef struct AcpiCpuStatus {
     struct CPUState *cpu;
     uint64_t arch_id;
@@ -24,6 +30,7 @@ typedef struct AcpiCpuStatus {
     bool is_removing;
     uint32_t ost_event;
     uint32_t ost_status;
+    AcpiCState cst;
 } AcpiCpuStatus;
 
 typedef struct CPUHotplugState {
@@ -32,6 +39,7 @@ typedef struct CPUHotplugState {
     uint8_t command;
     uint32_t dev_count;
     AcpiCpuStatus *devs;
+    bool enable_cstate;
 } CPUHotplugState;
 
 void acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
@@ -50,6 +58,7 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
 typedef struct CPUHotplugFeatures {
     bool apci_1_compatible;
     bool has_legacy_cphp;
+    bool cstate_enabled;
 } CPUHotplugFeatures;
 
 void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.txt
index ee219c8..adfb026 100644
--- a/docs/specs/acpi_cpu_hotplug.txt
+++ b/docs/specs/acpi_cpu_hotplug.txt
@@ -47,6 +47,12 @@ read access:
           in case of error or unsupported command reads is 0xFFFFFFFF
           current 'Command field' value:
               0: returns PXM value corresponding to device
+              3: sequential reads return a sequence of DWORDs
+                   {
+                     AddressSpaceKeyword, RegisterBitWidth, RegisterBitOffset,
+                     RegisterAddress Lo, RegisterAddress Hi, AccessSize,
+                     C State type, Latency, Power,
+                   }
 
 write access:
     offset:
@@ -75,7 +81,9 @@ write access:
             1: following writes to 'Command data' register set OST event
                register in QEMU
             2: following writes to 'Command data' register set OST status
-               register in QEMU
+            3: following reads from 'Command data' register return Cx
+               state (command execution resets unread field counter to the 1st
+               field).
             other values: reserved
     [0x6-0x7] reserved
     [0x8] Command data: (DWORD access)
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 5ae595e..7ef04f9 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -16,6 +16,7 @@ enum {
     CPHP_GET_NEXT_CPU_WITH_EVENT_CMD = 0,
     CPHP_OST_EVENT_CMD = 1,
     CPHP_OST_STATUS_CMD = 2,
+    CPHP_READ_CST_CMD = 3,
     CPHP_CMD_MAX
 };
 
@@ -73,6 +74,41 @@ static uint64_t cpu_hotplug_rd(void *opaque, hwaddr addr, unsigned size)
         case CPHP_GET_NEXT_CPU_WITH_EVENT_CMD:
            val = cpu_st->selector;
            break;
+        case CPHP_READ_CST_CMD:
+            switch (cdev->cst.current_cst_field) {
+            case 0:
+                val = cpu_to_le32(AML_AS_FFH); /* AddressSpaceKeyword */
+                break;
+            case 1:  /* RegisterBitWidth */
+                val = cpu_to_le32(1); /* Vendor: Intel */
+                break;
+            case 2:  /* RegisterBitOffset */
+                val = cpu_to_le32(2); /* Class: Native C State Instruction */
+                break;
+            case 3:  /* RegisterAddress Lo */
+                val = cpu_to_le64(0); /* Arg0: mwait EAX hint */
+                break;
+            case 4:  /* RegisterAddress Hi */
+                val = cpu_to_le32(0); /* Reserved */
+                break;
+            case 5:  /* AccessSize */
+                val = cpu_to_le32(0); /* Arg1 */
+                break;
+            case 6:
+                val = cpu_to_le32(1); /* The C State type C1*/
+                break;
+            case 7:
+                val = cpu_to_le32(cdev->cst.latency);
+                break;
+            case 8:
+                val = cpu_to_le32(cdev->cst.power);
+                break;
+            default:
+                val = 0xFFFFFFFF;
+               break;
+            }
+            cdev->cst.current_cst_field++;
+            break;
         default:
            break;
         }
@@ -145,6 +181,9 @@ static void cpu_hotplug_wr(void *opaque, hwaddr addr, uint64_t data,
                     }
                     iter = iter + 1 < cpu_st->dev_count ? iter + 1 : 0;
                 } while (iter != cpu_st->selector);
+            } else if (cpu_st->command == CPHP_READ_CST_CMD) {
+                cdev = &cpu_st->devs[cpu_st->selector];
+                cdev->cst.current_cst_field = 0;
             }
         }
         break;
@@ -265,6 +304,36 @@ void acpi_cpu_unplug_cb(CPUHotplugState *cpu_st,
     cdev->cpu = NULL;
 }
 
+static const VMStateDescription vmstate_cstate_sts = {
+    .name = "CState",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields      = (VMStateField[]) {
+        VMSTATE_UINT32(cst.current_cst_field, AcpiCpuStatus),
+        VMSTATE_UINT32(cst.latency, AcpiCpuStatus),
+        VMSTATE_UINT32(cst.power, AcpiCpuStatus),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool vmstate_test_use_cst(void *opaque)
+{
+    CPUHotplugState *s = opaque;
+    return s->enable_cstate;
+}
+
+static const VMStateDescription vmstate_cstates = {
+    .name = "CPU hotplug state/CStates",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = vmstate_test_use_cst,
+    .fields      = (VMStateField[]) {
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(devs, CPUHotplugState, dev_count,
+                                             vmstate_cstate_sts, AcpiCpuStatus),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_cpuhp_sts = {
     .name = "CPU hotplug device state",
     .version_id = 1,
@@ -290,6 +359,10 @@ const VMStateDescription vmstate_cpu_hotplug = {
         VMSTATE_STRUCT_VARRAY_POINTER_UINT32(devs, CPUHotplugState, dev_count,
                                              vmstate_cpuhp_sts, AcpiCpuStatus),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+       &vmstate_cstates,
+       NULL
     }
 };
 
@@ -301,6 +374,7 @@ const VMStateDescription vmstate_cpu_hotplug = {
 #define CPU_NOTIFY_METHOD "CTFY"
 #define CPU_EJECT_METHOD  "CEJ0"
 #define CPU_OST_METHOD    "COST"
+#define CPU_CST_METHOD    "CCST"
 
 #define CPU_ENABLED       "CPEN"
 #define CPU_SELECTOR      "CSEL"
@@ -501,6 +575,57 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
         }
         aml_append(cpus_dev, method);
 
+        if (opts.cstate_enabled) {
+            Aml *crs;
+            Aml *pkg = aml_local(0);
+            Aml *cst = aml_local(1);
+            Aml *cst_cmd = aml_int(CPHP_READ_CST_CMD);
+            Aml *uid = aml_arg(0);
+            Aml *nm = aml_name("CCRS");
+
+            method = aml_method(CPU_CST_METHOD, 1, AML_SERIALIZED);
+            /* Package to hold 1 CST entry */
+            aml_append(method, aml_store(aml_package(2), pkg));
+            aml_append(method, aml_store(aml_package(4), cst)); /* CST entry */
+
+            aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
+            aml_append(method, aml_store(uid, cpu_selector));
+            aml_append(method, aml_store(cst_cmd, cpu_cmd));
+
+            /* create register template to fill in */
+            crs = aml_resource_template();
+            aml_append(crs, aml_register(AML_AS_FFH, 0, 0, 0, 0));
+            aml_append(method, aml_name_decl("CCRS", crs));
+
+            /* fill in actual register values */
+            aml_append(method, aml_create_byte_field(nm, aml_int(3), "_ASI"));
+            aml_append(method, aml_store(cpu_data, aml_name("_ASI")));
+            aml_append(method, aml_create_byte_field(nm, aml_int(4), "_RBW"));
+            aml_append(method, aml_store(cpu_data, aml_name("_RBW")));
+            aml_append(method, aml_create_byte_field(nm, aml_int(5), "_RBO"));
+            aml_append(method, aml_store(cpu_data, aml_name("_RBO")));
+            aml_append(method, aml_create_dword_field(nm, aml_int(7), "LADR"));
+            aml_append(method, aml_store(cpu_data, aml_name("LADR")));
+            aml_append(method, aml_create_dword_field(nm, aml_int(11), "HADR"));
+            aml_append(method, aml_store(cpu_data, aml_name("HADR")));
+            aml_append(method, aml_create_byte_field(nm, aml_int(6), "_ASZ"));
+            aml_append(method, aml_store(cpu_data, aml_name("_ASZ")));
+
+            /* pack CST entry */
+            aml_append(method, aml_store(crs, aml_index(cst, zero)));
+            aml_append(method, aml_store(cpu_data, aml_index(cst, one)));
+            aml_append(method, aml_store(cpu_data, aml_index(cst, aml_int(2))));
+            aml_append(method, aml_store(cpu_data, aml_index(cst, aml_int(3))));
+            aml_append(method, aml_release(ctrl_lock));
+
+            /* prepare _CST descriptor with 1 CST entry */
+            aml_append(method, aml_store(one, aml_index(pkg, zero)));
+            aml_append(method, aml_store(cst, aml_index(pkg, one)));
+
+            aml_append(method, aml_return(pkg));
+            aml_append(cpus_dev, method);
+        }
+
         /* build Processor object for each processor */
         for (i = 0; i < arch_ids->len; i++) {
             Aml *dev;
@@ -520,6 +645,12 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
             aml_append(method, aml_return(aml_call1(CPU_STS_METHOD, uid)));
             aml_append(dev, method);
 
+            if (opts.cstate_enabled) {
+                method = aml_method("_CST", 0, AML_SERIALIZED);
+                aml_append(method, aml_return(aml_call1(CPU_CST_METHOD, uid)));
+                aml_append(dev, method);
+            }
+
             /* build _MAT object */
             assert(adevc && adevc->madt_cpu);
             adevc->madt_cpu(adev, i, arch_ids, madt_buf);
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 6404af5..6d3df17 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -677,6 +677,8 @@ static Property piix4_pm_properties[] = {
                      use_acpi_pci_hotplug, true),
     DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
                      acpi_memory_hotplug.is_enabled, true),
+    DEFINE_PROP_BOOL("cstate", PIIX4PMState,
+                     cpuhp_state.enable_cstate, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index e1ee8ae..dd695bd 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -100,6 +100,7 @@ typedef struct AcpiPmInfo {
     uint16_t cpu_hp_io_base;
     uint16_t pcihp_io_base;
     uint16_t pcihp_io_len;
+    bool cstate_enabled;
 } AcpiPmInfo;
 
 typedef struct AcpiMiscInfo {
@@ -218,6 +219,7 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
     pm->pcihp_bridge_en =
         object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-support",
                                  NULL);
+    pm->cstate_enabled = object_property_get_bool(obj, "cstate", NULL);
 }
 
 static void acpi_get_misc_info(AcpiMiscInfo *info)
@@ -1840,7 +1842,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
     } else {
         CPUHotplugFeatures opts = {
-            .apci_1_compatible = true, .has_legacy_cphp = true
+            .apci_1_compatible = true, .has_legacy_cphp = true,
+            .cstate_enabled = pm->cstate_enabled
         };
         build_cpus_aml(dsdt, machine, opts, pm->cpu_hp_io_base,
                        "\\_SB.PCI0", "\\_GPE._E02");
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 4e24930..3c1687e 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -716,6 +716,7 @@ static void test_acpi_piix4_tcg_cphp(void)
     data.machine = MACHINE_PC;
     data.variant = ".cphp";
     test_acpi_one("-smp 2,cores=3,sockets=2,maxcpus=6"
+                  " -global PIIX4_PM.cstate=on"
                   " -numa node -numa node"
                   " -numa dist,src=0,dst=1,val=21",
                   &data);
-- 
2.7.4
