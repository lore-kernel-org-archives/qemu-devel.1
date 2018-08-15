Received: from eggs.gnu.org ([2001:4830:134:3::10]:58257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fpvoO-0006xc-L0
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:26:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fpvoG-0000TC-38
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:26:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46094 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fpvoF-0000Rv-4E
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:25:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8082777154
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 13:25:58 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 15 Aug 2018 15:25:52 +0200
Message-Id: <1534339552-155139-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <20180810015952-mutt-send-email-mst@kernel.org>
References: <20180810015952-mutt-send-email-mst@kernel.org>
Subject: [Qemu-devel] [PATCH 3/4] pc: acpi: add _CST support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com

Reuse CPU hotplug IO registers for passing a CST entry
containing package for shalowest C1 using mwait and
read it out in guest with new CCST AML method.

The CState support is optional and could be turned on
with '-global PIIX4_PM.cstate-count=X' CLI option.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
V2:
  - support for multiple CStates (Michael)
    full updated series is at https://github.com/imammedo/qemu/commits/mwait2

for demo purposes it's wired only to piix4
TODO: q35 wiring

'tested' with rhel7 and XPsp3 - WS2016
 (i.e. it boots and all windows versions happy about AML qemu produces)
---
 include/hw/acpi/cpu.h           |   5 ++
 docs/specs/acpi_cpu_hotplug.txt |  12 +++-
 hw/acpi/cpu.c                   | 141 ++++++++++++++++++++++++++++++++++++++++
 hw/acpi/piix4.c                 |   2 +
 hw/i386/acpi-build.c            |   5 +-
 tests/bios-tables-test.c        |   1 +
 6 files changed, 164 insertions(+), 2 deletions(-)

diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index 89ce172..379605c 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -24,6 +24,9 @@ typedef struct AcpiCpuStatus {
     bool is_removing;
     uint32_t ost_event;
     uint32_t ost_status;
+    uint32_t cst_idx;
+    uint32_t cst_count;
+    uint32_t *cst;
 } AcpiCpuStatus;
 
 typedef struct CPUHotplugState {
@@ -32,6 +35,7 @@ typedef struct CPUHotplugState {
     uint8_t command;
     uint32_t dev_count;
     AcpiCpuStatus *devs;
+    uint32_t cst_count;
 } CPUHotplugState;
 
 void acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
@@ -50,6 +54,7 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
 typedef struct CPUHotplugFeatures {
     bool apci_1_compatible;
     bool has_legacy_cphp;
+    uint32_t cst_count;
 } CPUHotplugFeatures;
 
 void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.txt
index ee219c8..c80cdcd 100644
--- a/docs/specs/acpi_cpu_hotplug.txt
+++ b/docs/specs/acpi_cpu_hotplug.txt
@@ -47,6 +47,14 @@ read access:
           in case of error or unsupported command reads is 0xFFFFFFFF
           current 'Command field' value:
               0: returns PXM value corresponding to device
+              3: 1st read, returns number of entries and following sequential
+                 reads return a sequence of tuples. each tuple consists of
+                 DWORDs in following order:
+                   {
+                     AddressSpaceKeyword, RegisterBitWidth, RegisterBitOffset,
+                     RegisterAddress Lo, RegisterAddress Hi, AccessSize,
+                     C State type, Latency, Power,
+                   }
 
 write access:
     offset:
@@ -75,7 +83,9 @@ write access:
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
index 5ae595e..364187b 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -16,6 +16,7 @@ enum {
     CPHP_GET_NEXT_CPU_WITH_EVENT_CMD = 0,
     CPHP_OST_EVENT_CMD = 1,
     CPHP_OST_STATUS_CMD = 2,
+    CPHP_READ_CST_CMD = 3,
     CPHP_CMD_MAX
 };
 
@@ -73,6 +74,16 @@ static uint64_t cpu_hotplug_rd(void *opaque, hwaddr addr, unsigned size)
         case CPHP_GET_NEXT_CPU_WITH_EVENT_CMD:
            val = cpu_st->selector;
            break;
+        case CPHP_READ_CST_CMD:
+            val = 0xFFFFFFFF;
+            if (cdev->cst_idx == 0) {
+                val = cpu_to_le32(cpu_st->cst_count);
+                cdev->cst_idx++;
+            } else if (cdev->cst_idx <= (cpu_st->cst_count * 9)) {
+                val = cpu_to_le32(cdev->cst[cdev->cst_idx - 1]);
+                cdev->cst_idx++;
+            }
+            break;
         default:
            break;
         }
@@ -145,6 +156,9 @@ static void cpu_hotplug_wr(void *opaque, hwaddr addr, uint64_t data,
                     }
                     iter = iter + 1 < cpu_st->dev_count ? iter + 1 : 0;
                 } while (iter != cpu_st->selector);
+            } else if (cpu_st->command == CPHP_READ_CST_CMD) {
+                cdev = &cpu_st->devs[cpu_st->selector];
+                cdev->cst_idx = 0;
             }
         }
         break;
@@ -197,6 +211,33 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
     id_list = mc->possible_cpu_arch_ids(machine);
     state->dev_count = id_list->len;
     state->devs = g_new0(typeof(*state->devs), state->dev_count);
+    if (state->cst_count) {
+        for (i = 0; i < state->dev_count; i++) {
+            int j;
+            state->devs[i].cst_count = state->cst_count;
+            state->devs[i].cst = g_new0(typeof(*state->devs->cst),
+                                        state->cst_count * 9);
+
+            /* HACK: makeup fake CST values somehow */
+            for (j = 0; j < state->cst_count; j++) {
+                int z = 9 * j;
+                /* AddressSpaceKeyword */
+                state->devs[i].cst[z + 0] = AML_AS_FFH;
+                /* RegisterBitWidth: Vendor: Intel */
+                state->devs[i].cst[z + 1] = 1;
+                /* RegisterBitOffset: Class: Native C State Instruction  */
+                state->devs[i].cst[z + 2] = 2;
+                /* RegisterAddress Lo: Arg0: mwait EAX hint */
+                state->devs[i].cst[z + 3] = 0;
+                /* RegisterAddress Hi: Reserved */
+                state->devs[i].cst[z + 4] = 0;
+                state->devs[i].cst[z + 5] = 0; /* AccessSize: Arg1 */
+                state->devs[i].cst[z + 6] = j + 1; /* The C State type C(j+1) */
+                state->devs[i].cst[z + 7] = 10 * (j + 1); /* CST: latency */
+                state->devs[i].cst[z + 8] = 100 * (j + 1); /* CST: power */
+            }
+        }
+    }
     for (i = 0; i < id_list->len; i++) {
         state->devs[i].cpu =  CPU(id_list->cpus[i].cpu);
         state->devs[i].arch_id = id_list->cpus[i].arch_id;
@@ -265,6 +306,37 @@ void acpi_cpu_unplug_cb(CPUHotplugState *cpu_st,
     cdev->cpu = NULL;
 }
 
+static const VMStateDescription vmstate_cstate_sts = {
+    .name = "CState",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields      = (VMStateField[]) {
+        VMSTATE_UINT32(cst_count, AcpiCpuStatus),
+        VMSTATE_UINT32(cst_idx, AcpiCpuStatus),
+        VMSTATE_VARRAY_UINT32(cst, AcpiCpuStatus, cst_count, 0,
+                              vmstate_info_uint32, uint32_t),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool vmstate_test_use_cst(void *opaque)
+{
+    CPUHotplugState *s = opaque;
+    return s->cst_count;
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
@@ -290,6 +362,10 @@ const VMStateDescription vmstate_cpu_hotplug = {
         VMSTATE_STRUCT_VARRAY_POINTER_UINT32(devs, CPUHotplugState, dev_count,
                                              vmstate_cpuhp_sts, AcpiCpuStatus),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+       &vmstate_cstates,
+       NULL
     }
 };
 
@@ -301,6 +377,7 @@ const VMStateDescription vmstate_cpu_hotplug = {
 #define CPU_NOTIFY_METHOD "CTFY"
 #define CPU_EJECT_METHOD  "CEJ0"
 #define CPU_OST_METHOD    "COST"
+#define CPU_CST_METHOD    "CCST"
 
 #define CPU_ENABLED       "CPEN"
 #define CPU_SELECTOR      "CSEL"
@@ -501,6 +578,64 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
         }
         aml_append(cpus_dev, method);
 
+        if (opts.cst_count) {
+            Aml *crs, *loop;
+            Aml *pkg = aml_local(0);
+            Aml *cst = aml_local(1);
+            Aml *count = aml_local(2);
+            Aml *idx = aml_local(3);
+            Aml *cst_cmd = aml_int(CPHP_READ_CST_CMD);
+            Aml *uid = aml_arg(0);
+            Aml *nm = aml_name("CCRS");
+
+            method = aml_method(CPU_CST_METHOD, 1, AML_SERIALIZED);
+            /* Package to hold opts.cst_count CST entries */
+            aml_append(method, aml_store(aml_package(opts.cst_count + 1), pkg));
+            aml_append(method, aml_store(aml_package(4), cst)); /* CST entry */
+            aml_append(method, aml_store(aml_int(opts.cst_count),
+                                         aml_index(pkg, zero)));
+
+            /* create register template to fill in */
+            crs = aml_resource_template();
+            aml_append(crs, aml_register(AML_AS_FFH, 0, 0, 0, 0));
+            aml_append(method, aml_name_decl("CCRS", crs));
+            aml_append(method, aml_create_byte_field(nm, aml_int(3), "_ASI"));
+            aml_append(method, aml_create_byte_field(nm, aml_int(4), "_RBW"));
+            aml_append(method, aml_create_byte_field(nm, aml_int(5), "_RBO"));
+            aml_append(method, aml_create_dword_field(nm, aml_int(7), "LADR"));
+            aml_append(method, aml_create_dword_field(nm, aml_int(11), "HADR"));
+            aml_append(method, aml_create_byte_field(nm, aml_int(6), "_ASZ"));
+
+            aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
+            aml_append(method, aml_store(uid, cpu_selector));
+            aml_append(method, aml_store(cst_cmd, cpu_cmd));
+
+            aml_append(method, aml_store(one, idx));
+            aml_append(method, aml_store(cpu_data, count));
+
+            loop = aml_while(aml_lgreater_equal(count, idx));
+            /* fill in actual register values */
+            aml_append(loop, aml_store(cpu_data, aml_name("_ASI")));
+            aml_append(loop, aml_store(cpu_data, aml_name("_RBW")));
+            aml_append(loop, aml_store(cpu_data, aml_name("_RBO")));
+            aml_append(loop, aml_store(cpu_data, aml_name("LADR")));
+            aml_append(loop, aml_store(cpu_data, aml_name("HADR")));
+            aml_append(loop, aml_store(cpu_data, aml_name("_ASZ")));
+            /* pack CST entry */
+            aml_append(loop, aml_store(crs, aml_index(cst, zero)));
+            aml_append(loop, aml_store(cpu_data, aml_index(cst, one)));
+            aml_append(loop, aml_store(cpu_data, aml_index(cst, aml_int(2))));
+            aml_append(loop, aml_store(cpu_data, aml_index(cst, aml_int(3))));
+            /* store entry into _CST descriptors package */
+            aml_append(loop, aml_store(cst, aml_index(pkg, idx)));
+            aml_append(loop, aml_add(idx, one, idx));
+            aml_append(method, loop);
+            aml_append(method, aml_release(ctrl_lock));
+
+            aml_append(method, aml_return(pkg));
+            aml_append(cpus_dev, method);
+        }
+
         /* build Processor object for each processor */
         for (i = 0; i < arch_ids->len; i++) {
             Aml *dev;
@@ -520,6 +655,12 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
             aml_append(method, aml_return(aml_call1(CPU_STS_METHOD, uid)));
             aml_append(dev, method);
 
+            if (opts.cst_count) {
+                method = aml_method("_CST", 0, AML_SERIALIZED);
+                aml_append(method, aml_return(aml_call1(CPU_CST_METHOD, uid)));
+                aml_append(dev, method);
+            }
+
             /* build _MAT object */
             assert(adevc && adevc->madt_cpu);
             adevc->madt_cpu(adev, i, arch_ids, madt_buf);
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 6404af5..8858afc 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -677,6 +677,8 @@ static Property piix4_pm_properties[] = {
                      use_acpi_pci_hotplug, true),
     DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
                      acpi_memory_hotplug.is_enabled, true),
+    DEFINE_PROP_UINT32("cstate-count", PIIX4PMState,
+                      cpuhp_state.cst_count, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index e1ee8ae..490429f 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -100,6 +100,7 @@ typedef struct AcpiPmInfo {
     uint16_t cpu_hp_io_base;
     uint16_t pcihp_io_base;
     uint16_t pcihp_io_len;
+    uint32_t cst_count;
 } AcpiPmInfo;
 
 typedef struct AcpiMiscInfo {
@@ -218,6 +219,7 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
     pm->pcihp_bridge_en =
         object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-support",
                                  NULL);
+    pm->cst_count = object_property_get_uint(obj, "cstate-count", NULL);
 }
 
 static void acpi_get_misc_info(AcpiMiscInfo *info)
@@ -1840,7 +1842,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
     } else {
         CPUHotplugFeatures opts = {
-            .apci_1_compatible = true, .has_legacy_cphp = true
+            .apci_1_compatible = true, .has_legacy_cphp = true,
+            .cst_count = pm->cst_count
         };
         build_cpus_aml(dsdt, machine, opts, pm->cpu_hp_io_base,
                        "\\_SB.PCI0", "\\_GPE._E02");
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 4e24930..d3a62e5 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -716,6 +716,7 @@ static void test_acpi_piix4_tcg_cphp(void)
     data.machine = MACHINE_PC;
     data.variant = ".cphp";
     test_acpi_one("-smp 2,cores=3,sockets=2,maxcpus=6"
+                  " -global PIIX4_PM.cstate-count=2"
                   " -numa node -numa node"
                   " -numa dist,src=0,dst=1,val=21",
                   &data);
-- 
2.7.4
