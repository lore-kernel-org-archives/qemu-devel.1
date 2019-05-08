Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4963EC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F544214AF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F544214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60138 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOFxl-0006Sw-AQ
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 02:21:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hOFvr-0004zM-6W
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hOFvp-0008SK-TL
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:19:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:57351)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hOFvp-0008RD-J4
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:19:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	07 May 2019 23:19:56 -0700
X-ExtLoop1: 1
Received: from tao-optiplex-7060.sh.intel.com ([10.239.13.92])
	by fmsmga005.fm.intel.com with ESMTP; 07 May 2019 23:19:54 -0700
From: Tao Xu <tao3.xu@intel.com>
To: imammedo@redhat.com, mst@redhat.com, eblake@redhat.com,
	ehabkost@redhat.com, xiaoguangrong.eric@gmail.com
Date: Wed,  8 May 2019 14:17:17 +0800
Message-Id: <20190508061726.27631-3-tao3.xu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508061726.27631-1-tao3.xu@intel.com>
References: <20190508061726.27631-1-tao3.xu@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.43
Subject: [Qemu-devel] [PATCH v4 02/11] numa: move numa global variable
 have_numa_distance into MachineState
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

The aim of this patch is to move existing numa global have_numa_distance
into NumaState.

Reviewed-by: Liu Jingqi <jingqi.liu@intel.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

Changes in v4 -> v3:
    - send the patch together with HMAT patches
---
 hw/arm/virt-acpi-build.c | 2 +-
 hw/arm/virt.c            | 2 +-
 hw/i386/acpi-build.c     | 2 +-
 include/hw/boards.h      | 2 ++
 include/sysemu/numa.h    | 2 --
 numa.c                   | 5 ++---
 6 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 6805b4de51..65f070843c 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -815,7 +815,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     if (nb_numa_nodes > 0) {
         acpi_add_table(table_offsets, tables_blob);
         build_srat(tables_blob, tables->linker, vms);
-        if (have_numa_distance) {
+        if (ms->numa_state->have_numa_distance) {
             acpi_add_table(table_offsets, tables_blob);
             build_slit(tables_blob, tables->linker, ms);
         }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 70954b658d..f0818ef597 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -228,7 +228,7 @@ static void create_fdt(VirtMachineState *vms)
                                 "clk24mhz");
     qemu_fdt_setprop_cell(fdt, "/apb-pclk", "phandle", vms->clock_phandle);
 
-    if (have_numa_distance) {
+    if (nb_numa_nodes > 0 && ms->numa_state->have_numa_distance) {
         int size = nb_numa_nodes * nb_numa_nodes * 3 * sizeof(uint32_t);
         uint32_t *matrix = g_malloc0(size);
         int idx, i, j;
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 7d9bc88ac9..43a807c483 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2685,7 +2685,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     if (pcms->numa_nodes) {
         acpi_add_table(table_offsets, tables_blob);
         build_srat(tables_blob, tables->linker, machine);
-        if (have_numa_distance) {
+        if (machine->numa_state->have_numa_distance) {
             acpi_add_table(table_offsets, tables_blob);
             build_slit(tables_blob, tables->linker, machine);
         }
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 5f102e3075..c3c678b7ff 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -237,6 +237,8 @@ typedef struct NumaState {
     /* Number of NUMA nodes */
     int num_nodes;
 
+    /* Allow setting NUMA distance for different NUMA nodes */
+    bool have_numa_distance;
 } NumaState;
 
 /**
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index a55e2be563..1a29408db9 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -6,8 +6,6 @@
 #include "sysemu/hostmem.h"
 #include "hw/boards.h"
 
-extern bool have_numa_distance;
-
 struct NodeInfo {
     uint64_t node_mem;
     struct HostMemoryBackend *node_memdev;
diff --git a/numa.c b/numa.c
index 343fcaf13f..d4f5ff5193 100644
--- a/numa.c
+++ b/numa.c
@@ -52,7 +52,6 @@ static int have_memdevs = -1;
 static int max_numa_nodeid; /* Highest specified NUMA node ID, plus one.
                              * For all nodes, nodeid < max_numa_nodeid
                              */
-bool have_numa_distance;
 NodeInfo numa_info[MAX_NODES];
 
 
@@ -171,7 +170,7 @@ void parse_numa_distance(MachineState *ms, NumaDistOptions *dist, Error **errp)
     }
 
     numa_info[src].distance[dst] = val;
-    have_numa_distance = true;
+    ms->numa_state->have_numa_distance = true;
 }
 
 static
@@ -442,7 +441,7 @@ void numa_complete_configuration(MachineState *ms)
          * asymmetric. In this case, the distances for both directions
          * of all node pairs are required.
          */
-        if (have_numa_distance) {
+        if (ms->numa_state->have_numa_distance) {
             /* Validate enough NUMA distance information was provided. */
             validate_numa_distance(ms);
 
-- 
2.17.1


