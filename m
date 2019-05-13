Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C84C04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 06:25:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0CB520989
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 06:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0CB520989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51809 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ4P1-0007UK-Rh
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 02:25:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hQ4Jy-00037V-Fj
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hQ4Jx-0004eq-3I
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:20:22 -0400
Received: from mga07.intel.com ([134.134.136.100]:24552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hQ4Jw-0004ds-Qi
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:20:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	12 May 2019 23:20:19 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga003.jf.intel.com with ESMTP; 12 May 2019 23:20:17 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 14:19:05 +0800
Message-Id: <20190513061913.9284-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190513061913.9284-1-richardw.yang@linux.intel.com>
References: <20190513061913.9284-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.100
Subject: [Qemu-devel] [RFC PATCH 1/9] hw/acpi: expand pc_madt_cpu_entry in
 place
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

This is a preparation for MADT refactor.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 hw/acpi/cpu.c                        | 33 +++++++++++--
 hw/acpi/piix4.c                      |  1 -
 hw/i386/acpi-build.c                 | 71 ++++++++++++----------------
 hw/isa/lpc_ich9.c                    |  1 -
 include/hw/acpi/acpi_dev_interface.h |  6 ---
 5 files changed, 59 insertions(+), 53 deletions(-)

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 7a90c8f82d..d786df1a2c 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -329,7 +329,7 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
     char *cphp_res_path = g_strdup_printf("%s." CPUHP_RES_DEVICE, res_root);
     Object *obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF, NULL);
     AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(obj);
-    AcpiDeviceIf *adev = ACPI_DEVICE_IF(obj);
+    uint32_t apic_id;
 
     cpu_ctrl_dev = aml_device("%s", cphp_res_path);
     {
@@ -522,8 +522,35 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
             aml_append(dev, method);
 
             /* build _MAT object */
-            assert(adevc && adevc->madt_cpu);
-            adevc->madt_cpu(adev, i, arch_ids, madt_buf);
+            assert(adevc);
+            apic_id = arch_ids->cpus[i].arch_id;
+            if (apic_id < 255) {
+                AcpiMadtProcessorApic *apic = acpi_data_push(madt_buf,
+                                                             sizeof *apic);
+
+                apic->type = ACPI_APIC_PROCESSOR;
+                apic->length = sizeof(*apic);
+                apic->processor_id = i;
+                apic->local_apic_id = apic_id;
+                if (arch_ids->cpus[i].cpu != NULL) {
+                    apic->flags = cpu_to_le32(1);
+                } else {
+                    apic->flags = cpu_to_le32(0);
+                }
+            } else {
+                AcpiMadtProcessorX2Apic *apic = acpi_data_push(madt_buf,
+                                                               sizeof *apic);
+
+                apic->type = ACPI_APIC_LOCAL_X2APIC;
+                apic->length = sizeof(*apic);
+                apic->uid = cpu_to_le32(i);
+                apic->x2apic_id = cpu_to_le32(apic_id);
+                if (arch_ids->cpus[i].cpu != NULL) {
+                    apic->flags = cpu_to_le32(1);
+                } else {
+                    apic->flags = cpu_to_le32(0);
+                }
+            }
             switch (madt_buf->data[0]) {
             case ACPI_APIC_PROCESSOR: {
                 AcpiMadtProcessorApic *apic = (void *)madt_buf->data;
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 9c079d6834..76fde125a3 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -722,7 +722,6 @@ static void piix4_pm_class_init(ObjectClass *klass, void *data)
     hc->unplug = piix4_device_unplug_cb;
     adevc->ospm_status = piix4_ospm_status;
     adevc->send_event = piix4_send_gpe;
-    adevc->madt_cpu = pc_madt_cpu_entry;
 }
 
 static const TypeInfo piix4_pm_info = {
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 29980bb3f4..54b70e62ac 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -301,52 +301,12 @@ build_facs(GArray *table_data)
     facs->length = cpu_to_le32(sizeof(*facs));
 }
 
-void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
-                       const CPUArchIdList *apic_ids, GArray *entry)
-{
-    uint32_t apic_id = apic_ids->cpus[uid].arch_id;
-
-    /* ACPI spec says that LAPIC entry for non present
-     * CPU may be omitted from MADT or it must be marked
-     * as disabled. However omitting non present CPU from
-     * MADT breaks hotplug on linux. So possible CPUs
-     * should be put in MADT but kept disabled.
-     */
-    if (apic_id < 255) {
-        AcpiMadtProcessorApic *apic = acpi_data_push(entry, sizeof *apic);
-
-        apic->type = ACPI_APIC_PROCESSOR;
-        apic->length = sizeof(*apic);
-        apic->processor_id = uid;
-        apic->local_apic_id = apic_id;
-        if (apic_ids->cpus[uid].cpu != NULL) {
-            apic->flags = cpu_to_le32(1);
-        } else {
-            apic->flags = cpu_to_le32(0);
-        }
-    } else {
-        AcpiMadtProcessorX2Apic *apic = acpi_data_push(entry, sizeof *apic);
-
-        apic->type = ACPI_APIC_LOCAL_X2APIC;
-        apic->length = sizeof(*apic);
-        apic->uid = cpu_to_le32(uid);
-        apic->x2apic_id = cpu_to_le32(apic_id);
-        if (apic_ids->cpus[uid].cpu != NULL) {
-            apic->flags = cpu_to_le32(1);
-        } else {
-            apic->flags = cpu_to_le32(0);
-        }
-    }
-}
-
 static void
 build_madt(GArray *table_data, BIOSLinker *linker, PCMachineState *pcms)
 {
     MachineClass *mc = MACHINE_GET_CLASS(pcms);
     const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(pcms));
     int madt_start = table_data->len;
-    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(pcms->acpi_dev);
-    AcpiDeviceIf *adev = ACPI_DEVICE_IF(pcms->acpi_dev);
     bool x2apic_mode = false;
 
     AcpiMultipleApicTable *madt;
@@ -359,8 +319,35 @@ build_madt(GArray *table_data, BIOSLinker *linker, PCMachineState *pcms)
     madt->flags = cpu_to_le32(1);
 
     for (i = 0; i < apic_ids->len; i++) {
-        adevc->madt_cpu(adev, i, apic_ids, table_data);
-        if (apic_ids->cpus[i].arch_id > 254) {
+        uint32_t apic_id = apic_ids->cpus[i].arch_id;
+        if (apic_id < 255) {
+            AcpiMadtProcessorApic *apic = acpi_data_push(table_data,
+                                                         sizeof *apic);
+
+            apic->type = ACPI_APIC_PROCESSOR;
+            apic->length = sizeof(*apic);
+            apic->processor_id = i;
+            apic->local_apic_id = apic_id;
+            if (apic_ids->cpus[i].cpu != NULL) {
+                apic->flags = cpu_to_le32(1);
+            } else {
+                apic->flags = cpu_to_le32(0);
+            }
+        } else {
+            AcpiMadtProcessorX2Apic *apic = acpi_data_push(table_data,
+                                                           sizeof *apic);
+
+            apic->type = ACPI_APIC_LOCAL_X2APIC;
+            apic->length = sizeof(*apic);
+            apic->uid = cpu_to_le32(i);
+            apic->x2apic_id = cpu_to_le32(apic_id);
+            if (apic_ids->cpus[i].cpu != NULL) {
+                apic->flags = cpu_to_le32(1);
+            } else {
+                apic->flags = cpu_to_le32(0);
+            }
+        }
+        if (apic_id > 254) {
             x2apic_mode = true;
         }
     }
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index ac44aa53be..8e00504cd9 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -811,7 +811,6 @@ static void ich9_lpc_class_init(ObjectClass *klass, void *data)
     hc->unplug = ich9_pm_device_unplug_cb;
     adevc->ospm_status = ich9_pm_ospm_status;
     adevc->send_event = ich9_send_gpe;
-    adevc->madt_cpu = pc_madt_cpu_entry;
 }
 
 static const TypeInfo ich9_lpc_info = {
diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
index 43ff119179..160b785045 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -35,10 +35,6 @@ void acpi_send_event(DeviceState *dev, AcpiEventStatusBits event);
  * ospm_status: returns status of ACPI device objects, reported
  *              via _OST method if device supports it.
  * send_event: inject a specified event into guest
- * madt_cpu: fills @entry with Interrupt Controller Structure
- *           for CPU indexed by @uid in @apic_ids array,
- *           returned structure types are:
- *           0 - Local APIC, 9 - Local x2APIC, 0xB - GICC
  *
  * Interface is designed for providing unified interface
  * to generic ACPI functionality that could be used without
@@ -52,7 +48,5 @@ typedef struct AcpiDeviceIfClass {
     /* <public> */
     void (*ospm_status)(AcpiDeviceIf *adev, ACPIOSTInfoList ***list);
     void (*send_event)(AcpiDeviceIf *adev, AcpiEventStatusBits ev);
-    void (*madt_cpu)(AcpiDeviceIf *adev, int uid,
-                     const CPUArchIdList *apic_ids, GArray *entry);
 } AcpiDeviceIfClass;
 #endif
-- 
2.19.1


