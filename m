Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA29BC3A59E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 04:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B09322173E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 04:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B09322173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i26hF-0001xB-SP
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 00:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1i26fi-00010U-B6
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 00:32:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1i26fg-0007rE-ON
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 00:32:02 -0400
Received: from ozlabs.ru ([107.173.13.209]:34210)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>)
 id 1i26fg-0007qw-H3; Mon, 26 Aug 2019 00:32:00 -0400
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id A25C0AE80011;
 Mon, 26 Aug 2019 00:31:07 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 14:31:26 +1000
Message-Id: <20190826043126.11589-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 107.173.13.209
Subject: [Qemu-devel] [PATCH qemu] spapr: Render full FDT on ibm,
 client-architecture-support
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ibm,client-architecture-support call is a way for the guest to
negotiate capabilities with a hypervisor. It is implemented as:
- the guest calls SLOF via client interface;
- SLOF calls QEMU (H_CAS hypercall) with an options vector from the guest;
- QEMU returns a device tree diff (which uses FDT format with
an additional header before it);
- SLOF walks through the partial diff tree and updates its internal tree
with the values from the diff.

This changes QEMU to simply re-render the entire tree and send it as
an update. SLOF can handle this already mostly, [1] is needed before this
can be applied.

The benefit is reduced code size as there is no need for another set of
DT rendering helpers such as spapr_fixup_cpu_dt().

The downside is that the updates are bigger now (as they include all
nodes and properties) but the difference on a '-smp 256,threads=1' system
before/after is 2.35s vs. 2.5s.

While at this, add a missing g_free(fdt) if the resulting tree is bigger
than the space allocated by SLOF. Also, store the resulting tree in
the spapr machine to have the latest valid FDT copy possible (this should
not matter much as H_UPDATE_DT happens right after that but nevertheless).

[1] https://patchwork.ozlabs.org/patch/1152915/

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/ppc/spapr.c | 90 ++++++--------------------------------------------
 1 file changed, 10 insertions(+), 80 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index baedadf20b8c..6dea5947afbc 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -295,65 +295,6 @@ static void spapr_populate_pa_features(SpaprMachineState *spapr,
     _FDT((fdt_setprop(fdt, offset, "ibm,pa-features", pa_features, pa_size)));
 }
 
-static int spapr_fixup_cpu_dt(void *fdt, SpaprMachineState *spapr)
-{
-    MachineState *ms = MACHINE(spapr);
-    int ret = 0, offset, cpus_offset;
-    CPUState *cs;
-    char cpu_model[32];
-    uint32_t pft_size_prop[] = {0, cpu_to_be32(spapr->htab_shift)};
-
-    CPU_FOREACH(cs) {
-        PowerPCCPU *cpu = POWERPC_CPU(cs);
-        DeviceClass *dc = DEVICE_GET_CLASS(cs);
-        int index = spapr_get_vcpu_id(cpu);
-        int compat_smt = MIN(ms->smp.threads, ppc_compat_max_vthreads(cpu));
-
-        if (!spapr_is_thread0_in_vcore(spapr, cpu)) {
-            continue;
-        }
-
-        snprintf(cpu_model, 32, "%s@%x", dc->fw_name, index);
-
-        cpus_offset = fdt_path_offset(fdt, "/cpus");
-        if (cpus_offset < 0) {
-            cpus_offset = fdt_add_subnode(fdt, 0, "cpus");
-            if (cpus_offset < 0) {
-                return cpus_offset;
-            }
-        }
-        offset = fdt_subnode_offset(fdt, cpus_offset, cpu_model);
-        if (offset < 0) {
-            offset = fdt_add_subnode(fdt, cpus_offset, cpu_model);
-            if (offset < 0) {
-                return offset;
-            }
-        }
-
-        ret = fdt_setprop(fdt, offset, "ibm,pft-size",
-                          pft_size_prop, sizeof(pft_size_prop));
-        if (ret < 0) {
-            return ret;
-        }
-
-        if (nb_numa_nodes > 1) {
-            ret = spapr_fixup_cpu_numa_dt(fdt, offset, cpu);
-            if (ret < 0) {
-                return ret;
-            }
-        }
-
-        ret = spapr_fixup_cpu_smt_dt(fdt, offset, cpu, compat_smt);
-        if (ret < 0) {
-            return ret;
-        }
-
-        spapr_populate_pa_features(spapr, cpu, fdt, offset,
-                                   spapr->cas_legacy_guest_workaround);
-    }
-    return ret;
-}
-
 static hwaddr spapr_node0_size(MachineState *machine)
 {
     if (nb_numa_nodes) {
@@ -983,11 +924,13 @@ static bool spapr_hotplugged_dev_before_cas(void)
     return false;
 }
 
+static void *spapr_build_fdt(SpaprMachineState *spapr);
+
 int spapr_h_cas_compose_response(SpaprMachineState *spapr,
                                  target_ulong addr, target_ulong size,
                                  SpaprOptionVector *ov5_updates)
 {
-    void *fdt, *fdt_skel;
+    void *fdt;
     SpaprDeviceTreeUpdateHeader hdr = { .version_id = 1 };
 
     if (spapr_hotplugged_dev_before_cas()) {
@@ -1003,28 +946,11 @@ int spapr_h_cas_compose_response(SpaprMachineState *spapr,
 
     size -= sizeof(hdr);
 
-    /* Create skeleton */
-    fdt_skel = g_malloc0(size);
-    _FDT((fdt_create(fdt_skel, size)));
-    _FDT((fdt_finish_reservemap(fdt_skel)));
-    _FDT((fdt_begin_node(fdt_skel, "")));
-    _FDT((fdt_end_node(fdt_skel)));
-    _FDT((fdt_finish(fdt_skel)));
-    fdt = g_malloc0(size);
-    _FDT((fdt_open_into(fdt_skel, fdt, size)));
-    g_free(fdt_skel);
-
-    /* Fixup cpu nodes */
-    _FDT((spapr_fixup_cpu_dt(fdt, spapr)));
-
-    if (spapr_dt_cas_updates(spapr, fdt, ov5_updates)) {
-        return -1;
-    }
-
-    /* Pack resulting tree */
+    fdt = spapr_build_fdt(spapr);
     _FDT((fdt_pack(fdt)));
 
     if (fdt_totalsize(fdt) + sizeof(hdr) > size) {
+        g_free(fdt);
         trace_spapr_cas_failed(size);
         return -1;
     }
@@ -1032,7 +958,11 @@ int spapr_h_cas_compose_response(SpaprMachineState *spapr,
     cpu_physical_memory_write(addr, &hdr, sizeof(hdr));
     cpu_physical_memory_write(addr + sizeof(hdr), fdt, fdt_totalsize(fdt));
     trace_spapr_cas_continue(fdt_totalsize(fdt) + sizeof(hdr));
-    g_free(fdt);
+
+    g_free(spapr->fdt_blob);
+    spapr->fdt_size = fdt_totalsize(fdt);
+    spapr->fdt_initial_size = spapr->fdt_size;
+    spapr->fdt_blob = fdt;
 
     return 0;
 }
-- 
2.17.1


