Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5D7C3A5A4
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 14:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3227D22CE9
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 14:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3227D22CE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4Qsi-0005P7-MR
	for qemu-devel@archiver.kernel.org; Sun, 01 Sep 2019 10:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1i4Qjb-0004eF-PU
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 10:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1i4QjZ-0004l3-64
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 10:21:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:16719)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1i4QjY-0004jJ-RZ
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 10:21:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Sep 2019 07:21:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,455,1559545200"; d="scan'208";a="211453104"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.36])
 by fmsmga002.fm.intel.com with ESMTP; 01 Sep 2019 07:21:34 -0700
From: Tao Xu <tao3.xu@intel.com>
To: imammedo@redhat.com,
	eblake@redhat.com,
	ehabkost@redhat.com
Date: Sun,  1 Sep 2019 22:21:14 +0800
Message-Id: <20190901142119.20482-7-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190901142119.20482-1-tao3.xu@intel.com>
References: <20190901142119.20482-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
Subject: [Qemu-devel] [PATCH v10 06/11] hmat acpi: Build Memory Proximity
 Domain Attributes Structure(s)
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: jingqi.liu@intel.com, tao3.xu@intel.com, fan.du@intel.com,
 qemu-devel@nongnu.org, daniel@linux.ibm.com,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liu Jingqi <jingqi.liu@intel.com>

HMAT is defined in ACPI 6.3: 5.2.27 Heterogeneous Memory Attribute Table
(HMAT). The specification references below link:
http://www.uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf

It describes the memory attributes, such as memory side cache
attributes and bandwidth and latency details, related to the
Memory Proximity Domain. The software is
expected to use this information as hint for optimization.

This structure describes Memory Proximity Domain Attributes by memory
subsystem and its associativity with processor proximity domain as well as
hint for memory usage.

In the linux kernel, the codes in drivers/acpi/hmat/hmat.c parse and report
the platform's HMAT tables.

Reviewed-by: Daniel Black <daniel@linux.ibm.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

No changes in v10
---
 hw/acpi/Kconfig       |   5 +++
 hw/acpi/Makefile.objs |   1 +
 hw/acpi/hmat.c        | 101 ++++++++++++++++++++++++++++++++++++++++++
 hw/acpi/hmat.h        |  45 +++++++++++++++++++
 hw/i386/acpi-build.c  |   3 ++
 5 files changed, 155 insertions(+)
 create mode 100644 hw/acpi/hmat.c
 create mode 100644 hw/acpi/hmat.h

diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
index 7c59cf900b..039bb99efa 100644
--- a/hw/acpi/Kconfig
+++ b/hw/acpi/Kconfig
@@ -7,6 +7,7 @@ config ACPI_X86
     select ACPI_NVDIMM
     select ACPI_CPU_HOTPLUG
     select ACPI_MEMORY_HOTPLUG
+    select ACPI_HMAT
 
 config ACPI_X86_ICH
     bool
@@ -31,3 +32,7 @@ config ACPI_VMGENID
     bool
     default y
     depends on PC
+
+config ACPI_HMAT
+    bool
+    depends on ACPI
diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index 9bb2101e3b..c05019b059 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -6,6 +6,7 @@ common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) += memory_hotplug.o
 common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu.o
 common-obj-$(CONFIG_ACPI_NVDIMM) += nvdimm.o
 common-obj-$(CONFIG_ACPI_VMGENID) += vmgenid.o
+common-obj-$(CONFIG_ACPI_HMAT) += hmat.o
 common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
 
 common-obj-y += acpi_interface.o
diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
new file mode 100644
index 0000000000..1368fce7ee
--- /dev/null
+++ b/hw/acpi/hmat.c
@@ -0,0 +1,101 @@
+/*
+ * HMAT ACPI Implementation
+ *
+ * Copyright(C) 2019 Intel Corporation.
+ *
+ * Author:
+ *  Liu jingqi <jingqi.liu@linux.intel.com>
+ *  Tao Xu <tao3.xu@intel.com>
+ *
+ * HMAT is defined in ACPI 6.3: 5.2.27 Heterogeneous Memory Attribute Table
+ * (HMAT)
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>
+ */
+
+#include "qemu/osdep.h"
+#include "sysemu/numa.h"
+#include "hw/acpi/hmat.h"
+
+/*
+ * ACPI 6.3:
+ * 5.2.27.3 Memory Proximity Domain Attributes Structure: Table 5-145
+ */
+static void build_hmat_mpda(GArray *table_data, uint16_t flags, int initiator,
+                           int mem_node)
+{
+
+    /* Memory Proximity Domain Attributes Structure */
+    /* Type */
+    build_append_int_noprefix(table_data, 0, 2);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 2);
+    /* Length */
+    build_append_int_noprefix(table_data, 40, 4);
+    /* Flags */
+    build_append_int_noprefix(table_data, flags, 2);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 2);
+    /* Proximity Domain for the Attached Initiator */
+    build_append_int_noprefix(table_data, initiator, 4);
+    /* Proximity Domain for the Memory */
+    build_append_int_noprefix(table_data, mem_node, 4);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 4);
+    /*
+     * Reserved:
+     * Previously defined as the Start Address of the System Physical
+     * Address Range. Deprecated since ACPI Spec 6.3.
+     */
+    build_append_int_noprefix(table_data, 0, 8);
+    /*
+     * Reserved:
+     * Previously defined as the Range Length of the region in bytes.
+     * Deprecated since ACPI Spec 6.3.
+     */
+    build_append_int_noprefix(table_data, 0, 8);
+}
+
+/* Build HMAT sub table structures */
+static void hmat_build_table_structs(GArray *table_data, NumaState *nstat)
+{
+    uint16_t flags;
+    int i;
+
+    for (i = 0; i < nstat->num_nodes; i++) {
+        flags = 0;
+
+        if (nstat->nodes[i].initiator_valid) {
+            flags |= HMAT_PROX_INIT_VALID;
+        }
+
+        build_hmat_mpda(table_data, flags, nstat->nodes[i].initiator, i);
+    }
+}
+
+void build_hmat(GArray *table_data, BIOSLinker *linker, NumaState *nstat)
+{
+    uint64_t hmat_start;
+
+    hmat_start = table_data->len;
+
+    /* reserve space for HMAT header  */
+    acpi_data_push(table_data, 40);
+
+    hmat_build_table_structs(table_data, nstat);
+
+    build_header(linker, table_data,
+                 (void *)(table_data->data + hmat_start),
+                 "HMAT", table_data->len - hmat_start, 2, NULL, NULL);
+}
diff --git a/hw/acpi/hmat.h b/hw/acpi/hmat.h
new file mode 100644
index 0000000000..0c1839cf6f
--- /dev/null
+++ b/hw/acpi/hmat.h
@@ -0,0 +1,45 @@
+/*
+ * HMAT ACPI Implementation Header
+ *
+ * Copyright(C) 2019 Intel Corporation.
+ *
+ * Author:
+ *  Liu jingqi <jingqi.liu@linux.intel.com>
+ *  Tao Xu <tao3.xu@intel.com>
+ *
+ * HMAT is defined in ACPI 6.3: 5.2.27 Heterogeneous Memory Attribute Table
+ * (HMAT)
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>
+ */
+
+#ifndef HMAT_H
+#define HMAT_H
+
+#include "hw/acpi/acpi-defs.h"
+#include "hw/acpi/acpi.h"
+#include "hw/acpi/bios-linker-loader.h"
+#include "hw/acpi/aml-build.h"
+
+/*
+ * ACPI 6.3: 5.2.27.3 Memory Proximity Domain Attributes Structure,
+ * Table 5-145, Field "flag", Bit [0]: set to 1 to indicate that data in
+ * the Proximity Domain for the Attached Initiator field is valid.
+ * Other bits reserved.
+ */
+#define HMAT_PROX_INIT_VALID 0x1
+
+void build_hmat(GArray *table_data, BIOSLinker *linker, NumaState *nstat);
+
+#endif
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index e54e571a75..ff9a5983eb 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -68,6 +68,7 @@
 #include "hw/i386/intel_iommu.h"
 
 #include "hw/acpi/ipmi.h"
+#include "hw/acpi/hmat.h"
 
 /* These are used to size the ACPI tables for -M pc-i440fx-1.7 and
  * -M pc-i440fx-2.0.  Even if the actual amount of AML generated grows
@@ -2698,6 +2699,8 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
             acpi_add_table(table_offsets, tables_blob);
             build_slit(tables_blob, tables->linker, machine);
         }
+        acpi_add_table(table_offsets, tables_blob);
+        build_hmat(tables_blob, tables->linker, machine->numa_state);
     }
     if (acpi_get_mcfg(&mcfg)) {
         acpi_add_table(table_offsets, tables_blob);
-- 
2.20.1


