Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE0DC04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 06:38:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C596420879
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 06:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C596420879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51958 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ4bY-0004CK-Sb
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 02:38:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hQ4Zt-0002z4-RI
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hQ4KG-0004w1-Q1
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:20:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:24552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hQ4KG-0004ds-I4
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:20:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	12 May 2019 23:20:40 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga003.jf.intel.com with ESMTP; 12 May 2019 23:20:38 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 14:19:12 +0800
Message-Id: <20190513061913.9284-9-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190513061913.9284-1-richardw.yang@linux.intel.com>
References: <20190513061913.9284-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.100
Subject: [Qemu-devel] [RFC PATCH 8/9] hw/acpi: factor build_madt with
 madt_input
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

struct madt_input is introduced to represent one sub madt table.

With help of madt_sub[] for related sub madt table, build_madt could
be agnostic.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 hw/i386/acpi-build.c | 103 +++++++++++++++++++++++++++----------------
 1 file changed, 65 insertions(+), 38 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index a7aeb215fc..74a34e297e 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -284,6 +284,54 @@ static void acpi_get_pci_holes(Range *hole, Range *hole64)
                                                NULL));
 }
 
+struct madt_input {
+    int sub_id;
+    void *opaque;
+};
+
+int xrupt_override_idx[] = {0, 5, 9, 10, 11};
+static struct madt_input *
+acpi_get_madt_input(PCMachineState *pcms, int *processor_id)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(pcms);
+    const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(pcms));
+    int i, sub_heads = 0;
+    uint32_t apic_id;
+    struct madt_input *input = NULL;
+
+    sub_heads = apic_ids->len                      /* PROCESSOR/X2APIC */
+                + 1                                /* APIC_IO */
+                + ARRAY_SIZE(xrupt_override_idx)   /* XRUPT_OVERRIDE */
+                + 1                                /* NMI/X2APIC_NMI */
+                + 1;                               /* END MARK */
+    input = g_new0(struct madt_input, sub_heads);
+    for (i = 0, sub_heads = 0; i < apic_ids->len; i++, sub_heads++) {
+        apic_id = apic_ids->cpus[i].arch_id;
+        if (apic_id < 255) {
+            input[sub_heads].sub_id = ACPI_APIC_PROCESSOR;
+        } else {
+            input[sub_heads].sub_id = ACPI_APIC_LOCAL_X2APIC;
+        }
+        input[sub_heads].opaque = processor_id;
+    }
+    input[sub_heads++].sub_id = ACPI_APIC_IO;
+    for (i = 0; i < ARRAY_SIZE(xrupt_override_idx); i++, sub_heads++) {
+        if (i == 0 && !pcms->apic_xrupt_override) {
+            continue;
+        }
+        input[sub_heads].sub_id = ACPI_APIC_XRUPT_OVERRIDE;
+        input[sub_heads].opaque = &xrupt_override_idx[i];
+    }
+    if (apic_id > 254) {
+        input[sub_heads++].sub_id = ACPI_APIC_LOCAL_X2APIC_NMI;
+    } else {
+        input[sub_heads++].sub_id = ACPI_APIC_LOCAL_NMI;
+    }
+    input[sub_heads].sub_id = ACPI_APIC_RESERVED;
+
+    return input;
+}
+
 static void acpi_align_size(GArray *blob, unsigned align)
 {
     /* Align size to multiple of given size. This reduces the chance
@@ -318,6 +366,7 @@ static void pc_madt_apic_entry(GArray *entry, void *opaque)
     } else {
         apic->flags = cpu_to_le32(0);
     }
+    (*processor_id)++;
 }
 
 static void pc_madt_x2apic_entry(GArray *entry, void *opaque)
@@ -337,6 +386,7 @@ static void pc_madt_x2apic_entry(GArray *entry, void *opaque)
     } else {
         apic->flags = cpu_to_le32(0);
     }
+    (*processor_id)++;
 }
 
 static void pc_madt_io_entry(GArray *entry, void *opaque)
@@ -405,54 +455,27 @@ madt_operations i386_madt_sub = {
 };
 
 static void
-build_madt(GArray *table_data, BIOSLinker *linker, PCMachineState *pcms)
+build_madt(GArray *table_data, BIOSLinker *linker, PCMachineState *pcms,
+           struct madt_input *input)
 {
-    MachineClass *mc = MACHINE_GET_CLASS(pcms);
-    const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(pcms));
     int madt_start = table_data->len;
     AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(pcms->acpi_dev);
 
-    bool x2apic_mode = false;
-
     AcpiMultipleApicTable *madt;
-    int i;
+    int i, sub_id;
+    void *opaque;
 
     madt = acpi_data_push(table_data, sizeof *madt);
     madt->local_apic_address = cpu_to_le32(APIC_DEFAULT_ADDRESS);
     madt->flags = cpu_to_le32(1);
 
-    for (i = 0; i < apic_ids->len; i++) {
-        uint32_t apic_id = apic_ids->cpus[i].arch_id;
-        int processor_id = i;
-        if (apic_id < 255) {
-            adevc->madt_sub[ACPI_APIC_PROCESSOR](table_data, &processor_id);
-        } else {
-            adevc->madt_sub[ACPI_APIC_LOCAL_X2APIC](table_data, &processor_id);
+    for (i = 0; ; i++) {
+        sub_id = input[i].sub_id;
+        if (sub_id == ACPI_APIC_RESERVED) {
+            break;
         }
-        if (apic_id > 254) {
-            x2apic_mode = true;
-        }
-    }
-
-    adevc->madt_sub[ACPI_APIC_IO](table_data, NULL);
-
-    if (pcms->apic_xrupt_override) {
-        i = 0;
-        adevc->madt_sub[ACPI_APIC_XRUPT_OVERRIDE](table_data, &i);
-    }
-    for (i = 1; i < 16; i++) {
-#define ACPI_BUILD_PCI_IRQS ((1<<5) | (1<<9) | (1<<10) | (1<<11))
-        if (!(ACPI_BUILD_PCI_IRQS & (1 << i))) {
-            /* No need for a INT source override structure. */
-            continue;
-        }
-        adevc->madt_sub[ACPI_APIC_XRUPT_OVERRIDE](table_data, &i);
-    }
-
-    if (x2apic_mode) {
-        adevc->madt_sub[ACPI_APIC_LOCAL_X2APIC_NMI](table_data, NULL);
-    } else {
-        adevc->madt_sub[ACPI_APIC_LOCAL_NMI](table_data, NULL);
+        opaque = input[i].opaque;
+        adevc->madt_sub[sub_id](table_data, opaque);
     }
 
     build_header(linker, table_data,
@@ -2627,6 +2650,8 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     GArray *tables_blob = tables->table_data;
     AcpiSlicOem slic_oem = { .id = NULL, .table_id = NULL };
     Object *vmgenid_dev;
+    struct madt_input *input = NULL;
+    int processor_id = 0;
 
     acpi_get_pm_info(&pm);
     acpi_get_misc_info(&misc);
@@ -2671,7 +2696,9 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     aml_len += tables_blob->len - fadt;
 
     acpi_add_table(table_offsets, tables_blob);
-    build_madt(tables_blob, tables->linker, pcms);
+    input = acpi_get_madt_input(pcms, &processor_id);
+    build_madt(tables_blob, tables->linker, pcms, input);
+    g_free(input);
 
     vmgenid_dev = find_vmgenid_dev();
     if (vmgenid_dev) {
-- 
2.19.1


