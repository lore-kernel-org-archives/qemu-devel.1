Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08243C04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 06:40:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEA7120879
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 06:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA7120879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51972 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ4dA-0005Q8-3W
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 02:40:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hQ4Zs-0002mj-UF
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hQ4KK-000509-F8
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:20:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:24552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hQ4KJ-0004ds-BF
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:20:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	12 May 2019 23:20:43 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga003.jf.intel.com with ESMTP; 12 May 2019 23:20:41 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 14:19:13 +0800
Message-Id: <20190513061913.9284-10-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190513061913.9284-1-richardw.yang@linux.intel.com>
References: <20190513061913.9284-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.100
Subject: [Qemu-devel] [RFC PATCH 9/9] hw/acpi: implement madt_main to
 manipulate main madt table
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

Different arch would handle the main madt table differently. Add a
helper function to achieve this goal.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 hw/acpi/piix4.c                      |  1 +
 hw/i386/acpi-build.c                 | 13 +++++++++++--
 hw/isa/lpc_ich9.c                    |  1 +
 include/hw/acpi/acpi_dev_interface.h |  1 +
 include/hw/i386/pc.h                 |  1 +
 5 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index f4336b9238..d7d097daee 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -723,6 +723,7 @@ static void piix4_pm_class_init(ObjectClass *klass, void *data)
     adevc->ospm_status = piix4_ospm_status;
     adevc->send_event = piix4_send_gpe;
     adevc->madt_sub = i386_madt_sub;
+    adevc->madt_main = i386_madt_main;
 }
 
 static const TypeInfo piix4_pm_info = {
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 74a34e297e..e73e9fddee 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -454,6 +454,14 @@ madt_operations i386_madt_sub = {
     [ACPI_APIC_LOCAL_NMI] = pc_madt_nmi_entry,
 };
 
+void i386_madt_main(GArray *entry, void *opaque)
+{
+    AcpiMultipleApicTable *madt = opaque;
+
+    madt->local_apic_address = cpu_to_le32(APIC_DEFAULT_ADDRESS);
+    madt->flags = cpu_to_le32(1);
+}
+
 static void
 build_madt(GArray *table_data, BIOSLinker *linker, PCMachineState *pcms,
            struct madt_input *input)
@@ -466,8 +474,9 @@ build_madt(GArray *table_data, BIOSLinker *linker, PCMachineState *pcms,
     void *opaque;
 
     madt = acpi_data_push(table_data, sizeof *madt);
-    madt->local_apic_address = cpu_to_le32(APIC_DEFAULT_ADDRESS);
-    madt->flags = cpu_to_le32(1);
+    if (adevc->madt_main) {
+        adevc->madt_main(table_data, madt);
+    }
 
     for (i = 0; ; i++) {
         sub_id = input[i].sub_id;
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index efb0fd8e94..21afd1a12d 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -812,6 +812,7 @@ static void ich9_lpc_class_init(ObjectClass *klass, void *data)
     adevc->ospm_status = ich9_pm_ospm_status;
     adevc->send_event = ich9_send_gpe;
     adevc->madt_sub = i386_madt_sub;
+    adevc->madt_main = i386_madt_main;
 }
 
 static const TypeInfo ich9_lpc_info = {
diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
index 3a3a12d543..d3b216544d 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -52,6 +52,7 @@ typedef struct AcpiDeviceIfClass {
     /* <public> */
     void (*ospm_status)(AcpiDeviceIf *adev, ACPIOSTInfoList ***list);
     void (*send_event)(AcpiDeviceIf *adev, AcpiEventStatusBits ev);
+    madt_operation madt_main;
     madt_operation *madt_sub;
 } AcpiDeviceIfClass;
 #endif
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index db4ec693d3..6b7dd060ac 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -282,6 +282,7 @@ void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
 void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
                        const CPUArchIdList *apic_ids, GArray *entry);
 extern madt_operations i386_madt_sub;
+void i386_madt_main(GArray *entry, void *opaque);
 
 /* e820 types */
 #define E820_RAM        1
-- 
2.19.1


