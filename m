Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C206C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 06:57:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3488420863
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 06:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3488420863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47759 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSyiB-0005fi-D4
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 02:57:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hSyHt-0006QE-SL
	for qemu-devel@nongnu.org; Tue, 21 May 2019 02:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hSyHr-0008JO-RV
	for qemu-devel@nongnu.org; Tue, 21 May 2019 02:30:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:50783)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hSyHk-0008AJ-A8; Tue, 21 May 2019 02:30:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	20 May 2019 23:30:03 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga001.jf.intel.com with ESMTP; 20 May 2019 23:30:00 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Date: Tue, 21 May 2019 14:28:36 +0800
Message-Id: <20190521062836.6541-3-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190521062836.6541-1-richardw.yang@linux.intel.com>
References: <20190521062836.6541-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.24
Subject: [Qemu-devel] [PATCH v6 2/2] acpi: pci: use build_append_foo() API
 to construct MCFG
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, thuth@redhat.com,
	mst@redhat.com, shannon.zhaosl@gmail.com,
	Wei Yang <richardw.yang@linux.intel.com>, imammedo@redhat.com,
	philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

build_append_foo() API doesn't need explicit endianness conversions
which eliminates a source of errors and it makes build_mcfg() look like
declarative definition of MCFG table in ACPI spec, which makes it easy
to review.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

v3:
   * add some comment on the Configuration Space base address allocation
     structure
v2:
   * miss the reserved[8] of MCFG in last version, add it back
   * drop SOBs and make sure bios-tables-test all OK
---
 hw/acpi/pci.c               | 39 +++++++++++++++++++++++++------------
 include/hw/acpi/acpi-defs.h | 18 -----------------
 2 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
index fa0fa30bb9..9510597a19 100644
--- a/hw/acpi/pci.c
+++ b/hw/acpi/pci.c
@@ -30,17 +30,32 @@
 
 void build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
 {
-    AcpiTableMcfg *mcfg;
-    int len = sizeof(*mcfg) + sizeof(mcfg->allocation[0]);
-
-    mcfg = acpi_data_push(table_data, len);
-    mcfg->allocation[0].address = cpu_to_le64(info->base);
-
-    /* Only a single allocation so no need to play with segments */
-    mcfg->allocation[0].pci_segment = cpu_to_le16(0);
-    mcfg->allocation[0].start_bus_number = 0;
-    mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->size - 1);
-
-    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
+    int mcfg_start = table_data->len;
+
+    /*
+     * PCI Firmware Specification, Revision 3.0
+     * 4.1.2 MCFG Table Description.
+     */
+    acpi_data_push(table_data, sizeof(AcpiTableHeader));
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 8);
+
+    /*
+     * Memory Mapped Enhanced Configuration Space Base Address Allocation
+     * Structure
+     */
+    /* Base address, processor-relative */
+    build_append_int_noprefix(table_data, info->base, 8);
+    /* PCI segment group number */
+    build_append_int_noprefix(table_data, 0, 2);
+    /* Starting PCI Bus number */
+    build_append_int_noprefix(table_data, 0, 1);
+    /* Final PCI Bus number */
+    build_append_int_noprefix(table_data, PCIE_MMCFG_BUS(info->size - 1), 1);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 4);
+
+    build_header(linker, table_data, (void *)(table_data->data + mcfg_start),
+                 "MCFG", table_data->len - mcfg_start, 1, NULL, NULL);
 }
 
diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index f9aa4bd398..57a3f58b0c 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -449,24 +449,6 @@ struct AcpiSratProcessorGiccAffinity {
 
 typedef struct AcpiSratProcessorGiccAffinity AcpiSratProcessorGiccAffinity;
 
-/* PCI fw r3.0 MCFG table. */
-/* Subtable */
-struct AcpiMcfgAllocation {
-    uint64_t address;                /* Base address, processor-relative */
-    uint16_t pci_segment;            /* PCI segment group number */
-    uint8_t start_bus_number;       /* Starting PCI Bus number */
-    uint8_t end_bus_number;         /* Final PCI Bus number */
-    uint32_t reserved;
-} QEMU_PACKED;
-typedef struct AcpiMcfgAllocation AcpiMcfgAllocation;
-
-struct AcpiTableMcfg {
-    ACPI_TABLE_HEADER_DEF;
-    uint8_t reserved[8];
-    AcpiMcfgAllocation allocation[0];
-} QEMU_PACKED;
-typedef struct AcpiTableMcfg AcpiTableMcfg;
-
 /*
  * TCPA Description Table
  *
-- 
2.19.1


