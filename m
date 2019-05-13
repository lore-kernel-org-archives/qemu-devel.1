Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3181BC04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 06:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA08120989
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 06:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA08120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51843 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ4Qc-0000nN-7E
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 02:27:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hQ4K0-00039N-9C
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hQ4Jz-0004fN-1X
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:20:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:24552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hQ4Jy-0004ds-Ps
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:20:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	12 May 2019 23:20:22 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga003.jf.intel.com with ESMTP; 12 May 2019 23:20:20 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 14:19:06 +0800
Message-Id: <20190513061913.9284-3-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190513061913.9284-1-richardw.yang@linux.intel.com>
References: <20190513061913.9284-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.100
Subject: [Qemu-devel] [RFC PATCH 2/9] hw/acpi: implement
 madt_sub[ACPI_APIC_PROCESSOR]
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
Cc: yang.zhong@intel.com, ehabkost@redhat.com, mst@redhat.com,
	Wei Yang <richardw.yang@linux.intel.com>, pbonzini@redhat.com,
	imammedo@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 hw/acpi/cpu.c                        | 15 +++--------
 hw/acpi/piix4.c                      |  1 +
 hw/i386/acpi-build.c                 | 39 +++++++++++++++++++---------
 hw/isa/lpc_ich9.c                    |  1 +
 include/hw/acpi/acpi_dev_interface.h |  5 ++++
 include/hw/i386/pc.h                 |  1 +
 6 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index d786df1a2c..35e57f9824 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -508,6 +508,7 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
             Aml *uid = aml_int(i);
             GArray *madt_buf = g_array_new(0, 1, 1);
             int arch_id = arch_ids->cpus[i].arch_id;
+            int processor_id = i;
 
             if (opts.acpi_1_compatible && arch_id < 255) {
                 dev = aml_processor(i, 0, 0, CPU_NAME_FMT, i);
@@ -525,18 +526,8 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
             assert(adevc);
             apic_id = arch_ids->cpus[i].arch_id;
             if (apic_id < 255) {
-                AcpiMadtProcessorApic *apic = acpi_data_push(madt_buf,
-                                                             sizeof *apic);
-
-                apic->type = ACPI_APIC_PROCESSOR;
-                apic->length = sizeof(*apic);
-                apic->processor_id = i;
-                apic->local_apic_id = apic_id;
-                if (arch_ids->cpus[i].cpu != NULL) {
-                    apic->flags = cpu_to_le32(1);
-                } else {
-                    apic->flags = cpu_to_le32(0);
-                }
+                assert(adevc->madt_sub[ACPI_APIC_PROCESSOR]);
+                adevc->madt_sub[ACPI_APIC_PROCESSOR](madt_buf, &processor_id);
             } else {
                 AcpiMadtProcessorX2Apic *apic = acpi_data_push(madt_buf,
                                                                sizeof *apic);
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 76fde125a3..f4336b9238 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -722,6 +722,7 @@ static void piix4_pm_class_init(ObjectClass *klass, void *data)
     hc->unplug = piix4_device_unplug_cb;
     adevc->ospm_status = piix4_ospm_status;
     adevc->send_event = piix4_send_gpe;
+    adevc->madt_sub = i386_madt_sub;
 }
 
 static const TypeInfo piix4_pm_info = {
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 54b70e62ac..dfcdcaeaf7 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -301,12 +301,37 @@ build_facs(GArray *table_data)
     facs->length = cpu_to_le32(sizeof(*facs));
 }
 
+static void pc_madt_apic_entry(GArray *entry, void *opaque)
+{
+    MachineState *machine = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(machine);
+    int *processor_id = opaque;
+    AcpiMadtProcessorApic *apic = acpi_data_push(entry, sizeof *apic);
+
+    apic->type = ACPI_APIC_PROCESSOR;
+    apic->length = sizeof(*apic);
+    apic->processor_id = *processor_id;
+    apic->local_apic_id = apic_ids->cpus[*processor_id].arch_id;
+    if (apic_ids->cpus[*processor_id].cpu != NULL) {
+        apic->flags = cpu_to_le32(1);
+    } else {
+        apic->flags = cpu_to_le32(0);
+    }
+}
+
+madt_operations i386_madt_sub = {
+    [ACPI_APIC_PROCESSOR] = pc_madt_apic_entry,
+};
+
 static void
 build_madt(GArray *table_data, BIOSLinker *linker, PCMachineState *pcms)
 {
     MachineClass *mc = MACHINE_GET_CLASS(pcms);
     const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(pcms));
     int madt_start = table_data->len;
+    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(pcms->acpi_dev);
+
     bool x2apic_mode = false;
 
     AcpiMultipleApicTable *madt;
@@ -320,19 +345,9 @@ build_madt(GArray *table_data, BIOSLinker *linker, PCMachineState *pcms)
 
     for (i = 0; i < apic_ids->len; i++) {
         uint32_t apic_id = apic_ids->cpus[i].arch_id;
+        int processor_id = i;
         if (apic_id < 255) {
-            AcpiMadtProcessorApic *apic = acpi_data_push(table_data,
-                                                         sizeof *apic);
-
-            apic->type = ACPI_APIC_PROCESSOR;
-            apic->length = sizeof(*apic);
-            apic->processor_id = i;
-            apic->local_apic_id = apic_id;
-            if (apic_ids->cpus[i].cpu != NULL) {
-                apic->flags = cpu_to_le32(1);
-            } else {
-                apic->flags = cpu_to_le32(0);
-            }
+            adevc->madt_sub[ACPI_APIC_PROCESSOR](table_data, &processor_id);
         } else {
             AcpiMadtProcessorX2Apic *apic = acpi_data_push(table_data,
                                                            sizeof *apic);
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 8e00504cd9..efb0fd8e94 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -811,6 +811,7 @@ static void ich9_lpc_class_init(ObjectClass *klass, void *data)
     hc->unplug = ich9_pm_device_unplug_cb;
     adevc->ospm_status = ich9_pm_ospm_status;
     adevc->send_event = ich9_send_gpe;
+    adevc->madt_sub = i386_madt_sub;
 }
 
 static const TypeInfo ich9_lpc_info = {
diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
index 160b785045..3a3a12d543 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -3,6 +3,7 @@
 
 #include "qom/object.h"
 #include "hw/boards.h"
+#include "hw/acpi/acpi-defs.h"
 
 /* These values are part of guest ABI, and can not be changed */
 typedef enum {
@@ -29,6 +30,9 @@ typedef struct AcpiDeviceIf AcpiDeviceIf;
 
 void acpi_send_event(DeviceState *dev, AcpiEventStatusBits event);
 
+typedef void (*madt_operation)(GArray *entry, void *opaque);
+typedef madt_operation madt_operations[ACPI_APIC_RESERVED];
+
 /**
  * AcpiDeviceIfClass:
  *
@@ -48,5 +52,6 @@ typedef struct AcpiDeviceIfClass {
     /* <public> */
     void (*ospm_status)(AcpiDeviceIf *adev, ACPIOSTInfoList ***list);
     void (*send_event)(AcpiDeviceIf *adev, AcpiEventStatusBits ev);
+    madt_operation *madt_sub;
 } AcpiDeviceIfClass;
 #endif
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ca65ef18af..db4ec693d3 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -281,6 +281,7 @@ void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
 /* acpi-build.c */
 void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
                        const CPUArchIdList *apic_ids, GArray *entry);
+extern madt_operations i386_madt_sub;
 
 /* e820 types */
 #define E820_RAM        1
-- 
2.19.1


