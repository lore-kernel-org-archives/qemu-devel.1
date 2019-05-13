Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49341C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 06:38:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CD4520879
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 06:38:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD4520879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51960 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ4ba-0004Du-9D
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 02:38:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hQ4Zy-0002z4-6u
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hQ4K9-0004sl-1r
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:20:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:24552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hQ4K8-0004ds-QZ
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:20:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	12 May 2019 23:20:32 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga003.jf.intel.com with ESMTP; 12 May 2019 23:20:29 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 14:19:09 +0800
Message-Id: <20190513061913.9284-6-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190513061913.9284-1-richardw.yang@linux.intel.com>
References: <20190513061913.9284-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.100
Subject: [Qemu-devel] [RFC PATCH 5/9] hw/acpi: implement
 madt_sub[ACPI_APIC_XRUPT_OVERRIDE]
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
 hw/i386/acpi-build.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index a661fff51d..f48cc5b292 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -351,10 +351,31 @@ static void pc_madt_io_entry(GArray *entry, void *opaque)
     io_apic->interrupt = cpu_to_le32(0);
 }
 
+static void pc_madt_xrupt_override_entry(GArray *entry, void *opaque)
+{
+    AcpiMadtIntsrcovr *intsrcovr;
+    int *idx = opaque;
+
+    intsrcovr = acpi_data_push(entry, sizeof *intsrcovr);
+    intsrcovr->type   = ACPI_APIC_XRUPT_OVERRIDE;
+    intsrcovr->length = sizeof(*intsrcovr);
+    intsrcovr->source = *idx;
+    if (*idx == 0) {
+        intsrcovr->gsi    = cpu_to_le32(2);
+        /* conforms to bus specifications */
+        intsrcovr->flags = cpu_to_le16(0);
+    } else {
+        intsrcovr->gsi    = cpu_to_le32(*idx);
+        /* active high, level triggered */
+        intsrcovr->flags = cpu_to_le16(0xd);
+    }
+}
+
 madt_operations i386_madt_sub = {
     [ACPI_APIC_PROCESSOR] = pc_madt_apic_entry,
     [ACPI_APIC_LOCAL_X2APIC] = pc_madt_x2apic_entry,
     [ACPI_APIC_IO] = pc_madt_io_entry,
+    [ACPI_APIC_XRUPT_OVERRIDE] = pc_madt_xrupt_override_entry,
 };
 
 static void
@@ -368,7 +389,6 @@ build_madt(GArray *table_data, BIOSLinker *linker, PCMachineState *pcms)
     bool x2apic_mode = false;
 
     AcpiMultipleApicTable *madt;
-    AcpiMadtIntsrcovr *intsrcovr;
     int i;
 
     madt = acpi_data_push(table_data, sizeof *madt);
@@ -391,12 +411,8 @@ build_madt(GArray *table_data, BIOSLinker *linker, PCMachineState *pcms)
     adevc->madt_sub[ACPI_APIC_IO](table_data, NULL);
 
     if (pcms->apic_xrupt_override) {
-        intsrcovr = acpi_data_push(table_data, sizeof *intsrcovr);
-        intsrcovr->type   = ACPI_APIC_XRUPT_OVERRIDE;
-        intsrcovr->length = sizeof(*intsrcovr);
-        intsrcovr->source = 0;
-        intsrcovr->gsi    = cpu_to_le32(2);
-        intsrcovr->flags  = cpu_to_le16(0); /* conforms to bus specifications */
+        i = 0;
+        adevc->madt_sub[ACPI_APIC_XRUPT_OVERRIDE](table_data, &i);
     }
     for (i = 1; i < 16; i++) {
 #define ACPI_BUILD_PCI_IRQS ((1<<5) | (1<<9) | (1<<10) | (1<<11))
@@ -404,12 +420,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, PCMachineState *pcms)
             /* No need for a INT source override structure. */
             continue;
         }
-        intsrcovr = acpi_data_push(table_data, sizeof *intsrcovr);
-        intsrcovr->type   = ACPI_APIC_XRUPT_OVERRIDE;
-        intsrcovr->length = sizeof(*intsrcovr);
-        intsrcovr->source = i;
-        intsrcovr->gsi    = cpu_to_le32(i);
-        intsrcovr->flags  = cpu_to_le16(0xd); /* active high, level triggered */
+        adevc->madt_sub[ACPI_APIC_XRUPT_OVERRIDE](table_data, &i);
     }
 
     if (x2apic_mode) {
-- 
2.19.1


