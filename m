Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E60C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:29:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A6C421019
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6C421019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60239 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOG4x-0005k3-FU
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 02:29:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hOFvx-00053y-W4
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:20:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hOFvw-00007D-0e
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:20:05 -0400
Received: from mga05.intel.com ([192.55.52.43]:57351)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hOFvu-0008RD-35
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:20:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	07 May 2019 23:20:00 -0700
X-ExtLoop1: 1
Received: from tao-optiplex-7060.sh.intel.com ([10.239.13.92])
	by fmsmga005.fm.intel.com with ESMTP; 07 May 2019 23:19:58 -0700
From: Tao Xu <tao3.xu@intel.com>
To: imammedo@redhat.com, mst@redhat.com, eblake@redhat.com,
	ehabkost@redhat.com, xiaoguangrong.eric@gmail.com
Date: Wed,  8 May 2019 14:17:19 +0800
Message-Id: <20190508061726.27631-5-tao3.xu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508061726.27631-1-tao3.xu@intel.com>
References: <20190508061726.27631-1-tao3.xu@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.43
Subject: [Qemu-devel] [PATCH v4 04/11] acpi: introduce
 AcpiDeviceIfClass.build_mem_ranges hook
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pbonzini@redhat.com, tao3.xu@intel.com, jingqi.liu@intel.com,
	qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add build_mem_ranges callback to AcpiDeviceIfClass and use
it for generating SRAT and HMAT numa memory ranges.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Co-developed-by: Liu Jingqi <jingqi.liu@intel.com>
Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

Changes in v4 -> v3:
    - spilt the 1/8 of v3 patch into two patches, 4/13 introduces
    build_mem_ranges() and adding it to ACPI interface, 5/13 builds
    HMAT (Igor)
---
 hw/acpi/piix4.c                      |   1 +
 hw/i386/acpi-build.c                 | 116 ++++++++++++++++-----------
 hw/isa/lpc_ich9.c                    |   1 +
 include/hw/acpi/acpi_dev_interface.h |   3 +
 include/hw/boards.h                  |  12 +++
 include/hw/i386/pc.h                 |   1 +
 stubs/Makefile.objs                  |   1 +
 stubs/pc_build_mem_ranges.c          |   6 ++
 8 files changed, 96 insertions(+), 45 deletions(-)
 create mode 100644 stubs/pc_build_mem_ranges.c

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 9c079d6834..7c320a49b2 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -723,6 +723,7 @@ static void piix4_pm_class_init(ObjectClass *klass, void *data)
     adevc->ospm_status = piix4_ospm_status;
     adevc->send_event = piix4_send_gpe;
     adevc->madt_cpu = pc_madt_cpu_entry;
+    adevc->build_mem_ranges = pc_build_mem_ranges;
 }
 
 static const TypeInfo piix4_pm_info = {
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 43a807c483..5598e7f780 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2271,6 +2271,65 @@ build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
 #define HOLE_640K_START  (640 * KiB)
 #define HOLE_640K_END   (1 * MiB)
 
+void pc_build_mem_ranges(AcpiDeviceIf *adev, MachineState *ms)
+{
+    uint64_t mem_len, mem_base, next_base;
+    int i;
+    PCMachineState *pcms = PC_MACHINE(ms);
+    /*
+     * the memory map is a bit tricky, it contains at least one hole
+     * from 640k-1M and possibly another one from 3.5G-4G.
+     */
+    NumaMemRange *mem_ranges = ms->numa_state->mem_ranges;
+    ms->numa_state->mem_ranges_num = 0;
+    next_base = 0;
+
+    for (i = 0; i < pcms->numa_nodes; ++i) {
+        mem_base = next_base;
+        mem_len = pcms->node_mem[i];
+        next_base = mem_base + mem_len;
+
+        /* Cut out the 640K hole */
+        if (mem_base <= HOLE_640K_START &&
+            next_base > HOLE_640K_START) {
+            mem_len -= next_base - HOLE_640K_START;
+            if (mem_len > 0) {
+                mem_ranges[ms->numa_state->mem_ranges_num].base = mem_base;
+                mem_ranges[ms->numa_state->mem_ranges_num].length = mem_len;
+                mem_ranges[ms->numa_state->mem_ranges_num].node = i;
+                ms->numa_state->mem_ranges_num++;
+            }
+
+            /* Check for the rare case: 640K < RAM < 1M */
+            if (next_base <= HOLE_640K_END) {
+                next_base = HOLE_640K_END;
+                continue;
+            }
+            mem_base = HOLE_640K_END;
+            mem_len = next_base - HOLE_640K_END;
+        }
+
+        /* Cut out the ACPI_PCI hole */
+        if (mem_base <= pcms->below_4g_mem_size &&
+            next_base > pcms->below_4g_mem_size) {
+            mem_len -= next_base - pcms->below_4g_mem_size;
+            if (mem_len > 0) {
+                mem_ranges[ms->numa_state->mem_ranges_num].base = mem_base;
+                mem_ranges[ms->numa_state->mem_ranges_num].length = mem_len;
+                mem_ranges[ms->numa_state->mem_ranges_num].node = i;
+                ms->numa_state->mem_ranges_num++;
+            }
+            mem_base = 1ULL << 32;
+            mem_len = next_base - pcms->below_4g_mem_size;
+            next_base = mem_base + mem_len;
+        }
+        mem_ranges[ms->numa_state->mem_ranges_num].base = mem_base;
+        mem_ranges[ms->numa_state->mem_ranges_num].length = mem_len;
+        mem_ranges[ms->numa_state->mem_ranges_num].node = i;
+        ms->numa_state->mem_ranges_num++;
+    }
+}
+
 static void
 build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 {
@@ -2279,10 +2338,13 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 
     int i;
     int srat_start, numa_start, slots;
-    uint64_t mem_len, mem_base, next_base;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(machine);
     PCMachineState *pcms = PC_MACHINE(machine);
+    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(pcms->acpi_dev);
+    AcpiDeviceIf *adev = ACPI_DEVICE_IF(pcms->acpi_dev);
+    uint32_t mem_ranges_num = machine->numa_state->mem_ranges_num;
+    NumaMemRange *mem_ranges = machine->numa_state->mem_ranges;
     ram_addr_t hotplugabble_address_space_size =
         object_property_get_int(OBJECT(pcms), PC_MACHINE_DEVMEM_REGION_SIZE,
                                 NULL);
@@ -2319,57 +2381,21 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
         }
     }
 
+    if (pcms->numa_nodes && !mem_ranges_num) {
+        adevc->build_mem_ranges(adev, machine);
+    }
 
-    /* the memory map is a bit tricky, it contains at least one hole
-     * from 640k-1M and possibly another one from 3.5G-4G.
-     */
-    next_base = 0;
     numa_start = table_data->len;
 
-    for (i = 1; i < pcms->numa_nodes + 1; ++i) {
-        mem_base = next_base;
-        mem_len = pcms->node_mem[i - 1];
-        next_base = mem_base + mem_len;
-
-        /* Cut out the 640K hole */
-        if (mem_base <= HOLE_640K_START &&
-            next_base > HOLE_640K_START) {
-            mem_len -= next_base - HOLE_640K_START;
-            if (mem_len > 0) {
+    for (i = 0; i < mem_ranges_num; i++) {
+        if (mem_ranges[i].length > 0) {
                 numamem = acpi_data_push(table_data, sizeof *numamem);
-                build_srat_memory(numamem, mem_base, mem_len, i - 1,
+            build_srat_memory(numamem, mem_ranges[i].base,
+                              mem_ranges[i].length,
+                              mem_ranges[i].node,
                                   MEM_AFFINITY_ENABLED);
             }
-
-            /* Check for the rare case: 640K < RAM < 1M */
-            if (next_base <= HOLE_640K_END) {
-                next_base = HOLE_640K_END;
-                continue;
             }
-            mem_base = HOLE_640K_END;
-            mem_len = next_base - HOLE_640K_END;
-        }
-
-        /* Cut out the ACPI_PCI hole */
-        if (mem_base <= pcms->below_4g_mem_size &&
-            next_base > pcms->below_4g_mem_size) {
-            mem_len -= next_base - pcms->below_4g_mem_size;
-            if (mem_len > 0) {
-                numamem = acpi_data_push(table_data, sizeof *numamem);
-                build_srat_memory(numamem, mem_base, mem_len, i - 1,
-                                  MEM_AFFINITY_ENABLED);
-            }
-            mem_base = 1ULL << 32;
-            mem_len = next_base - pcms->below_4g_mem_size;
-            next_base = mem_base + mem_len;
-        }
-
-        if (mem_len > 0) {
-            numamem = acpi_data_push(table_data, sizeof *numamem);
-            build_srat_memory(numamem, mem_base, mem_len, i - 1,
-                              MEM_AFFINITY_ENABLED);
-        }
-    }
     slots = (table_data->len - numa_start) / sizeof *numamem;
     for (; slots < pcms->numa_nodes + 2; slots++) {
         numamem = acpi_data_push(table_data, sizeof *numamem);
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index ac44aa53be..4ae64846ba 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -812,6 +812,7 @@ static void ich9_lpc_class_init(ObjectClass *klass, void *data)
     adevc->ospm_status = ich9_pm_ospm_status;
     adevc->send_event = ich9_send_gpe;
     adevc->madt_cpu = pc_madt_cpu_entry;
+    adevc->build_mem_ranges = pc_build_mem_ranges;
 }
 
 static const TypeInfo ich9_lpc_info = {
diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
index 43ff119179..d8634ac1ed 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -39,6 +39,7 @@ void acpi_send_event(DeviceState *dev, AcpiEventStatusBits event);
  *           for CPU indexed by @uid in @apic_ids array,
  *           returned structure types are:
  *           0 - Local APIC, 9 - Local x2APIC, 0xB - GICC
+ * build_mem_ranges: build memory ranges of ACPI SRAT and HMAT
  *
  * Interface is designed for providing unified interface
  * to generic ACPI functionality that could be used without
@@ -54,5 +55,7 @@ typedef struct AcpiDeviceIfClass {
     void (*send_event)(AcpiDeviceIf *adev, AcpiEventStatusBits ev);
     void (*madt_cpu)(AcpiDeviceIf *adev, int uid,
                      const CPUArchIdList *apic_ids, GArray *entry);
+    void (*build_mem_ranges)(AcpiDeviceIf *adev, MachineState *ms);
+
 } AcpiDeviceIfClass;
 #endif
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 777eed4dd9..9fbf921ecf 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -240,6 +240,12 @@ struct NodeInfo {
     uint8_t distance[MAX_NODES];
 };
 
+typedef struct NumaMemRange {
+    uint64_t base;
+    uint64_t length;
+    uint32_t node;
+} NumaMemRange;
+
 typedef struct NumaState {
     /* Number of NUMA nodes */
     int num_nodes;
@@ -249,6 +255,12 @@ typedef struct NumaState {
 
     /* NUMA nodes information */
     NodeInfo nodes[MAX_NODES];
+
+    /* Number of NUMA memory ranges */
+    uint32_t mem_ranges_num;
+
+    /* NUMA memory ranges */
+    NumaMemRange mem_ranges[MAX_NODES + 2];
 } NumaState;
 
 /**
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 43df7230a2..1e4ee404ae 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -281,6 +281,7 @@ void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
 /* acpi-build.c */
 void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
                        const CPUArchIdList *apic_ids, GArray *entry);
+void pc_build_mem_ranges(AcpiDeviceIf *adev, MachineState *ms);
 
 /* e820 types */
 #define E820_RAM        1
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 269dfa5832..7e0a962815 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -33,6 +33,7 @@ stub-obj-y += qmp_memory_device.o
 stub-obj-y += target-monitor-defs.o
 stub-obj-y += target-get-monitor-def.o
 stub-obj-y += pc_madt_cpu_entry.o
+stub-obj-y += pc_build_mem_ranges.o
 stub-obj-y += vmgenid.o
 stub-obj-y += xen-common.o
 stub-obj-y += xen-hvm.o
diff --git a/stubs/pc_build_mem_ranges.c b/stubs/pc_build_mem_ranges.c
new file mode 100644
index 0000000000..0f104ba79d
--- /dev/null
+++ b/stubs/pc_build_mem_ranges.c
@@ -0,0 +1,6 @@
+#include "qemu/osdep.h"
+#include "hw/i386/pc.h"
+
+void pc_build_mem_ranges(AcpiDeviceIf *adev, MachineState *machine)
+{
+}
-- 
2.17.1


