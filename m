Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A32C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 05:43:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1DBC20758
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 05:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="NeOIZ56h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1DBC20758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxOad-0008Ra-50
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 01:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jxOYY-0005hl-3b; Mon, 20 Jul 2020 01:41:42 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45213 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jxOYU-0005w6-5x; Mon, 20 Jul 2020 01:41:41 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B99Zf1jslz9sR4; Mon, 20 Jul 2020 15:41:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595223690;
 bh=SoFDtUKbMTTP5vpI4nUoVVrIWAOlECjWo0U19O0woHM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NeOIZ56hiUSRK6cDTuV5/YJjbP3cAzIhjTDub5V25+AexeqWK4yAZ0liwjyoO6bER
 ZdLUO/pOiTAymEImz14KmnJj6Gljc8nJIqphc5xfmR6yjkkeP1KBczPjZBXh9nh1cy
 cCnGt6YtwF/D+Q+6t8xQGng968Pp6ElbhmhlBobo=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 3/4] spapr: Add a new level of NUMA for GPUs
Date: Mon, 20 Jul 2020 15:41:25 +1000
Message-Id: <20200720054126.258032-4-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720054126.258032-1-david@gibson.dropbear.id.au>
References: <20200720054126.258032-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 01:41:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Reza Arbab <arbab@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Reza Arbab <arbab@linux.ibm.com>

NUMA nodes corresponding to GPU memory currently have the same
affinity/distance as normal memory nodes. Add a third NUMA associativity
reference point enabling us to give GPU nodes more distance.

This is guest visible information, which shouldn't change under a
running guest across migration between different qemu versions, so make
the change effective only in new (pseries > 5.0) machine types.

Before, `numactl -H` output in a guest with 4 GPUs (nodes 2-5):

node distances:
node   0   1   2   3   4   5
  0:  10  40  40  40  40  40
  1:  40  10  40  40  40  40
  2:  40  40  10  40  40  40
  3:  40  40  40  10  40  40
  4:  40  40  40  40  10  40
  5:  40  40  40  40  40  10

After:

node distances:
node   0   1   2   3   4   5
  0:  10  40  80  80  80  80
  1:  40  10  80  80  80  80
  2:  80  80  10  80  80  80
  3:  80  80  80  10  80  80
  4:  80  80  80  80  10  80
  5:  80  80  80  80  80  10

These are the same distances as on the host, mirroring the change made
to host firmware in skiboot commit f845a648b8cb ("numa/associativity:
Add a new level of NUMA for GPU's").

Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
Message-Id: <20200716225655.24289-1-arbab@linux.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c              | 21 +++++++++++++++++++--
 hw/ppc/spapr_pci.c          |  2 ++
 hw/ppc/spapr_pci_nvlink2.c  | 13 ++++++++++---
 include/hw/pci-host/spapr.h |  1 +
 include/hw/ppc/spapr.h      |  1 +
 5 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 299908cc73..0ae293ec94 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -890,10 +890,16 @@ static int spapr_dt_rng(void *fdt)
 static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
 {
     MachineState *ms = MACHINE(spapr);
+    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(ms);
     int rtas;
     GString *hypertas = g_string_sized_new(256);
     GString *qemu_hypertas = g_string_sized_new(256);
-    uint32_t refpoints[] = { cpu_to_be32(0x4), cpu_to_be32(0x4) };
+    uint32_t refpoints[] = {
+        cpu_to_be32(0x4),
+        cpu_to_be32(0x4),
+        cpu_to_be32(0x2),
+    };
+    uint32_t nr_refpoints = ARRAY_SIZE(refpoints);
     uint64_t max_device_addr = MACHINE(spapr)->device_memory->base +
         memory_region_size(&MACHINE(spapr)->device_memory->mr);
     uint32_t lrdr_capacity[] = {
@@ -945,8 +951,12 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
                      qemu_hypertas->str, qemu_hypertas->len));
     g_string_free(qemu_hypertas, TRUE);
 
+    if (smc->pre_5_1_assoc_refpoints) {
+        nr_refpoints = 2;
+    }
+
     _FDT(fdt_setprop(fdt, rtas, "ibm,associativity-reference-points",
-                     refpoints, sizeof(refpoints)));
+                     refpoints, nr_refpoints * sizeof(refpoints[0])));
 
     _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
                      maxdomains, sizeof(maxdomains)));
@@ -4584,9 +4594,16 @@ DEFINE_SPAPR_MACHINE(5_1, "5.1", true);
  */
 static void spapr_machine_5_0_class_options(MachineClass *mc)
 {
+    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
+    static GlobalProperty compat[] = {
+        { TYPE_SPAPR_PCI_HOST_BRIDGE, "pre-5.1-associativity", "on" },
+    };
+
     spapr_machine_5_1_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_len);
+    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
     mc->numa_mem_supported = true;
+    smc->pre_5_1_assoc_refpoints = true;
 }
 
 DEFINE_SPAPR_MACHINE(5_0, "5.0", false);
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 21681215d4..363cdb3f7b 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2089,6 +2089,8 @@ static Property spapr_phb_properties[] = {
                      pcie_ecs, true),
     DEFINE_PROP_UINT64("gpa", SpaprPhbState, nv2_gpa_win_addr, 0),
     DEFINE_PROP_UINT64("atsd", SpaprPhbState, nv2_atsd_win_addr, 0),
+    DEFINE_PROP_BOOL("pre-5.1-associativity", SpaprPhbState,
+                     pre_5_1_assoc, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
index dd8cd6db96..76ae77ebc8 100644
--- a/hw/ppc/spapr_pci_nvlink2.c
+++ b/hw/ppc/spapr_pci_nvlink2.c
@@ -362,9 +362,9 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *sphb, void *fdt)
                                                     &error_abort);
         uint32_t associativity[] = {
             cpu_to_be32(0x4),
-            SPAPR_GPU_NUMA_ID,
-            SPAPR_GPU_NUMA_ID,
-            SPAPR_GPU_NUMA_ID,
+            cpu_to_be32(nvslot->numa_id),
+            cpu_to_be32(nvslot->numa_id),
+            cpu_to_be32(nvslot->numa_id),
             cpu_to_be32(nvslot->numa_id)
         };
         uint64_t size = object_property_get_uint(nv_mrobj, "size", NULL);
@@ -375,6 +375,13 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *sphb, void *fdt)
         _FDT(off);
         _FDT((fdt_setprop_string(fdt, off, "device_type", "memory")));
         _FDT((fdt_setprop(fdt, off, "reg", mem_reg, sizeof(mem_reg))));
+
+        if (sphb->pre_5_1_assoc) {
+            associativity[1] = SPAPR_GPU_NUMA_ID;
+            associativity[2] = SPAPR_GPU_NUMA_ID;
+            associativity[3] = SPAPR_GPU_NUMA_ID;
+        }
+
         _FDT((fdt_setprop(fdt, off, "ibm,associativity", associativity,
                           sizeof(associativity))));
 
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 8877ff51fb..600eb55c34 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -94,6 +94,7 @@ struct SpaprPhbState {
     hwaddr nv2_gpa_win_addr;
     hwaddr nv2_atsd_win_addr;
     SpaprPhbPciNvGpuConfig *nvgpus;
+    bool pre_5_1_assoc;
 };
 
 #define SPAPR_PCI_MEM_WIN_BUS_OFFSET 0x80000000ULL
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index c421410e3f..3134d339e8 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -129,6 +129,7 @@ struct SpaprMachineClass {
     bool linux_pci_probe;
     bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
     hwaddr rma_limit;          /* clamp the RMA to this size */
+    bool pre_5_1_assoc_refpoints;
 
     void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
                           uint64_t *buid, hwaddr *pio, 
-- 
2.26.2


