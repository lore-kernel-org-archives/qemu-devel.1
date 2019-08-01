Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B13C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 07:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98B5D206A2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 07:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B5D206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ht5u5-0005DX-TZ
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 03:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45745)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tao3.xu@intel.com>) id 1ht5tg-0004he-Vh
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 03:53:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1ht5tf-00061f-Og
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 03:53:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:58176)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>)
 id 1ht5td-0005qM-3V; Thu, 01 Aug 2019 03:53:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Aug 2019 00:53:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,333,1559545200"; d="scan'208";a="172830896"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.37])
 by fmsmga008.fm.intel.com with ESMTP; 01 Aug 2019 00:53:03 -0700
From: Tao Xu <tao3.xu@intel.com>
To: ehabkost@redhat.com, imammedo@redhat.com, marcel.apfelbaum@gmail.com,
 david@gibson.dropbear.id.au
Date: Thu,  1 Aug 2019 15:52:58 +0800
Message-Id: <20190801075258.19070-1-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
Subject: [Qemu-devel] [RFC PATCH] numa: add auto_enable_numa to fix broken
 check in spapr
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
Cc: Tao Xu <tao3.xu@intel.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce MachineClass::auto_enable_numa for one implicit NUMA node,
and enable it to fix broken check in spapr_validate_node_memory(), when
spapr_populate_memory() creates a implicit node and info then use
nb_numa_nodes which is 0.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

This patch has a dependency on
https://patchwork.kernel.org/cover/11063235/
---
 hw/core/numa.c      | 9 +++++++--
 hw/ppc/spapr.c      | 9 +--------
 include/hw/boards.h | 1 +
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index 75db35ac19..756d243d3f 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -580,9 +580,14 @@ void numa_complete_configuration(MachineState *ms)
      *   guest tries to use it with that drivers.
      *
      * Enable NUMA implicitly by adding a new NUMA node automatically.
+     *
+     * Or if MachineClass::auto_enable_numa is true and no NUMA nodes,
+     * assume there is just one node with whole RAM.
      */
-    if (ms->ram_slots > 0 && ms->numa_state->num_nodes == 0 &&
-        mc->auto_enable_numa_with_memhp) {
+    if (ms->numa_state->num_nodes == 0 &&
+        ((ms->ram_slots > 0 &&
+        mc->auto_enable_numa_with_memhp) ||
+        mc->auto_enable_numa)) {
             NumaNodeOptions node = { };
             parse_numa_node(ms, &node, &error_abort);
     }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f607ca567b..e50343f326 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -400,14 +400,6 @@ static int spapr_populate_memory(SpaprMachineState *spapr, void *fdt)
     hwaddr mem_start, node_size;
     int i, nb_nodes = machine->numa_state->num_nodes;
     NodeInfo *nodes = machine->numa_state->nodes;
-    NodeInfo ramnode;
-
-    /* No NUMA nodes, assume there is just one node with whole RAM */
-    if (!nb_nodes) {
-        nb_nodes = 1;
-        ramnode.node_mem = machine->ram_size;
-        nodes = &ramnode;
-    }
 
     for (i = 0, mem_start = 0; i < nb_nodes; ++i) {
         if (!nodes[i].node_mem) {
@@ -4369,6 +4361,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
      */
     mc->numa_mem_align_shift = 28;
     mc->numa_mem_supported = true;
+    mc->auto_enable_numa = true;
 
     smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
     smc->default_caps.caps[SPAPR_CAP_VSX] = SPAPR_CAP_ON;
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 2eb9a0b4e0..4a350b87d2 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -220,6 +220,7 @@ struct MachineClass {
     bool smbus_no_migration_support;
     bool nvdimm_supported;
     bool numa_mem_supported;
+    bool auto_enable_numa;
 
     HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
-- 
2.20.1


