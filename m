Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B98C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 04:09:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3C822076A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 04:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="I0zI0sHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C822076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCbdP-0008R7-Tx
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 00:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jCba8-0003Po-JT
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 00:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jCba6-00076g-5a
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 00:05:56 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49169 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jCba5-0006rN-Ah; Fri, 13 Mar 2020 00:05:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48dsYj1YFSz9sRN; Fri, 13 Mar 2020 15:05:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584072345;
 bh=1xtkFiwCdluo8myE4MDdXsPGwwZAwQarkL2wO8T60L8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=I0zI0sHeZW8FZ0eCvPB2VTrCJ5P2N1Ugjm1QkOGRbuDv08M1Q8VpwNNpchjmyavF3
 3dAwps6uTKe8JHKVNldmsGUChQcnnGiXJ3o8Q6O+DMNeUaJb96HooG5aOgpC+QQ097
 tGEsKG5snqXCqiRg2GKLYFutEx5kDIo8YClLdXIg=
From: David Gibson <david@gibson.dropbear.id.au>
To: groug@kaod.org,
	clg@kaod.org,
	philmd@redhat.com
Subject: [PATCH 1/4] spapr: Move creation of ibm,
 dynamic-reconfiguration-memory dt node
Date: Fri, 13 Mar 2020 15:05:36 +1100
Message-Id: <20200313040539.819138-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313040539.819138-1-david@gibson.dropbear.id.au>
References: <20200313040539.819138-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently this node with information about hotpluggable memory is created
from spapr_dt_cas_updates().  But that's just a hangover from when we
created it only as a diff to the device tree at CAS time.  Now that we
fully rebuild the DT as CAS time, it makes more sense to create this alon=
g
with the rest of the memory information in the device tree.

So, move it to spapr_populate_memory().  The patch is huge, but it's near=
ly
all just code motion.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 512 +++++++++++++++++++++++++------------------------
 1 file changed, 257 insertions(+), 255 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 64bc8b83e9..66289ffef5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -341,257 +341,6 @@ static int spapr_populate_memory_node(void *fdt, in=
t nodeid, hwaddr start,
     return off;
 }
=20
-static int spapr_populate_memory(SpaprMachineState *spapr, void *fdt)
-{
-    MachineState *machine =3D MACHINE(spapr);
-    hwaddr mem_start, node_size;
-    int i, nb_nodes =3D machine->numa_state->num_nodes;
-    NodeInfo *nodes =3D machine->numa_state->nodes;
-
-    for (i =3D 0, mem_start =3D 0; i < nb_nodes; ++i) {
-        if (!nodes[i].node_mem) {
-            continue;
-        }
-        if (mem_start >=3D machine->ram_size) {
-            node_size =3D 0;
-        } else {
-            node_size =3D nodes[i].node_mem;
-            if (node_size > machine->ram_size - mem_start) {
-                node_size =3D machine->ram_size - mem_start;
-            }
-        }
-        if (!mem_start) {
-            /* spapr_machine_init() checks for rma_size <=3D node0_size
-             * already */
-            spapr_populate_memory_node(fdt, i, 0, spapr->rma_size);
-            mem_start +=3D spapr->rma_size;
-            node_size -=3D spapr->rma_size;
-        }
-        for ( ; node_size; ) {
-            hwaddr sizetmp =3D pow2floor(node_size);
-
-            /* mem_start !=3D 0 here */
-            if (ctzl(mem_start) < ctzl(sizetmp)) {
-                sizetmp =3D 1ULL << ctzl(mem_start);
-            }
-
-            spapr_populate_memory_node(fdt, i, mem_start, sizetmp);
-            node_size -=3D sizetmp;
-            mem_start +=3D sizetmp;
-        }
-    }
-
-    return 0;
-}
-
-static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
-                                  SpaprMachineState *spapr)
-{
-    MachineState *ms =3D MACHINE(spapr);
-    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-    CPUPPCState *env =3D &cpu->env;
-    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cs);
-    int index =3D spapr_get_vcpu_id(cpu);
-    uint32_t segs[] =3D {cpu_to_be32(28), cpu_to_be32(40),
-                       0xffffffff, 0xffffffff};
-    uint32_t tbfreq =3D kvm_enabled() ? kvmppc_get_tbfreq()
-        : SPAPR_TIMEBASE_FREQ;
-    uint32_t cpufreq =3D kvm_enabled() ? kvmppc_get_clockfreq() : 100000=
0000;
-    uint32_t page_sizes_prop[64];
-    size_t page_sizes_prop_size;
-    unsigned int smp_threads =3D ms->smp.threads;
-    uint32_t vcpus_per_socket =3D smp_threads * ms->smp.cores;
-    uint32_t pft_size_prop[] =3D {0, cpu_to_be32(spapr->htab_shift)};
-    int compat_smt =3D MIN(smp_threads, ppc_compat_max_vthreads(cpu));
-    SpaprDrc *drc;
-    int drc_index;
-    uint32_t radix_AP_encodings[PPC_PAGE_SIZES_MAX_SZ];
-    int i;
-
-    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index);
-    if (drc) {
-        drc_index =3D spapr_drc_index(drc);
-        _FDT((fdt_setprop_cell(fdt, offset, "ibm,my-drc-index", drc_inde=
x)));
-    }
-
-    _FDT((fdt_setprop_cell(fdt, offset, "reg", index)));
-    _FDT((fdt_setprop_string(fdt, offset, "device_type", "cpu")));
-
-    _FDT((fdt_setprop_cell(fdt, offset, "cpu-version", env->spr[SPR_PVR]=
)));
-    _FDT((fdt_setprop_cell(fdt, offset, "d-cache-block-size",
-                           env->dcache_line_size)));
-    _FDT((fdt_setprop_cell(fdt, offset, "d-cache-line-size",
-                           env->dcache_line_size)));
-    _FDT((fdt_setprop_cell(fdt, offset, "i-cache-block-size",
-                           env->icache_line_size)));
-    _FDT((fdt_setprop_cell(fdt, offset, "i-cache-line-size",
-                           env->icache_line_size)));
-
-    if (pcc->l1_dcache_size) {
-        _FDT((fdt_setprop_cell(fdt, offset, "d-cache-size",
-                               pcc->l1_dcache_size)));
-    } else {
-        warn_report("Unknown L1 dcache size for cpu");
-    }
-    if (pcc->l1_icache_size) {
-        _FDT((fdt_setprop_cell(fdt, offset, "i-cache-size",
-                               pcc->l1_icache_size)));
-    } else {
-        warn_report("Unknown L1 icache size for cpu");
-    }
-
-    _FDT((fdt_setprop_cell(fdt, offset, "timebase-frequency", tbfreq)));
-    _FDT((fdt_setprop_cell(fdt, offset, "clock-frequency", cpufreq)));
-    _FDT((fdt_setprop_cell(fdt, offset, "slb-size", cpu->hash64_opts->sl=
b_size)));
-    _FDT((fdt_setprop_cell(fdt, offset, "ibm,slb-size", cpu->hash64_opts=
->slb_size)));
-    _FDT((fdt_setprop_string(fdt, offset, "status", "okay")));
-    _FDT((fdt_setprop(fdt, offset, "64-bit", NULL, 0)));
-
-    if (env->spr_cb[SPR_PURR].oea_read) {
-        _FDT((fdt_setprop_cell(fdt, offset, "ibm,purr", 1)));
-    }
-    if (env->spr_cb[SPR_SPURR].oea_read) {
-        _FDT((fdt_setprop_cell(fdt, offset, "ibm,spurr", 1)));
-    }
-
-    if (ppc_hash64_has(cpu, PPC_HASH64_1TSEG)) {
-        _FDT((fdt_setprop(fdt, offset, "ibm,processor-segment-sizes",
-                          segs, sizeof(segs))));
-    }
-
-    /* Advertise VSX (vector extensions) if available
-     *   1               =3D=3D VMX / Altivec available
-     *   2               =3D=3D VSX available
-     *
-     * Only CPUs for which we create core types in spapr_cpu_core.c
-     * are possible, and all of those have VMX */
-    if (spapr_get_cap(spapr, SPAPR_CAP_VSX) !=3D 0) {
-        _FDT((fdt_setprop_cell(fdt, offset, "ibm,vmx", 2)));
-    } else {
-        _FDT((fdt_setprop_cell(fdt, offset, "ibm,vmx", 1)));
-    }
-
-    /* Advertise DFP (Decimal Floating Point) if available
-     *   0 / no property =3D=3D no DFP
-     *   1               =3D=3D DFP available */
-    if (spapr_get_cap(spapr, SPAPR_CAP_DFP) !=3D 0) {
-        _FDT((fdt_setprop_cell(fdt, offset, "ibm,dfp", 1)));
-    }
-
-    page_sizes_prop_size =3D ppc_create_page_sizes_prop(cpu, page_sizes_=
prop,
-                                                      sizeof(page_sizes_=
prop));
-    if (page_sizes_prop_size) {
-        _FDT((fdt_setprop(fdt, offset, "ibm,segment-page-sizes",
-                          page_sizes_prop, page_sizes_prop_size)));
-    }
-
-    spapr_populate_pa_features(spapr, cpu, fdt, offset);
-
-    _FDT((fdt_setprop_cell(fdt, offset, "ibm,chip-id",
-                           cs->cpu_index / vcpus_per_socket)));
-
-    _FDT((fdt_setprop(fdt, offset, "ibm,pft-size",
-                      pft_size_prop, sizeof(pft_size_prop))));
-
-    if (ms->numa_state->num_nodes > 1) {
-        _FDT(spapr_fixup_cpu_numa_dt(fdt, offset, cpu));
-    }
-
-    _FDT(spapr_fixup_cpu_smt_dt(fdt, offset, cpu, compat_smt));
-
-    if (pcc->radix_page_info) {
-        for (i =3D 0; i < pcc->radix_page_info->count; i++) {
-            radix_AP_encodings[i] =3D
-                cpu_to_be32(pcc->radix_page_info->entries[i]);
-        }
-        _FDT((fdt_setprop(fdt, offset, "ibm,processor-radix-AP-encodings=
",
-                          radix_AP_encodings,
-                          pcc->radix_page_info->count *
-                          sizeof(radix_AP_encodings[0]))));
-    }
-
-    /*
-     * We set this property to let the guest know that it can use the la=
rge
-     * decrementer and its width in bits.
-     */
-    if (spapr_get_cap(spapr, SPAPR_CAP_LARGE_DECREMENTER) !=3D SPAPR_CAP=
_OFF)
-        _FDT((fdt_setprop_u32(fdt, offset, "ibm,dec-bits",
-                              pcc->lrg_decr_bits)));
-}
-
-static void spapr_populate_cpus_dt_node(void *fdt, SpaprMachineState *sp=
apr)
-{
-    CPUState **rev;
-    CPUState *cs;
-    int n_cpus;
-    int cpus_offset;
-    char *nodename;
-    int i;
-
-    cpus_offset =3D fdt_add_subnode(fdt, 0, "cpus");
-    _FDT(cpus_offset);
-    _FDT((fdt_setprop_cell(fdt, cpus_offset, "#address-cells", 0x1)));
-    _FDT((fdt_setprop_cell(fdt, cpus_offset, "#size-cells", 0x0)));
-
-    /*
-     * We walk the CPUs in reverse order to ensure that CPU DT nodes
-     * created by fdt_add_subnode() end up in the right order in FDT
-     * for the guest kernel the enumerate the CPUs correctly.
-     *
-     * The CPU list cannot be traversed in reverse order, so we need
-     * to do extra work.
-     */
-    n_cpus =3D 0;
-    rev =3D NULL;
-    CPU_FOREACH(cs) {
-        rev =3D g_renew(CPUState *, rev, n_cpus + 1);
-        rev[n_cpus++] =3D cs;
-    }
-
-    for (i =3D n_cpus - 1; i >=3D 0; i--) {
-        CPUState *cs =3D rev[i];
-        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-        int index =3D spapr_get_vcpu_id(cpu);
-        DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
-        int offset;
-
-        if (!spapr_is_thread0_in_vcore(spapr, cpu)) {
-            continue;
-        }
-
-        nodename =3D g_strdup_printf("%s@%x", dc->fw_name, index);
-        offset =3D fdt_add_subnode(fdt, cpus_offset, nodename);
-        g_free(nodename);
-        _FDT(offset);
-        spapr_populate_cpu_dt(cs, fdt, offset, spapr);
-    }
-
-    g_free(rev);
-}
-
-static int spapr_rng_populate_dt(void *fdt)
-{
-    int node;
-    int ret;
-
-    node =3D qemu_fdt_add_subnode(fdt, "/ibm,platform-facilities");
-    if (node <=3D 0) {
-        return -1;
-    }
-    ret =3D fdt_setprop_string(fdt, node, "device_type",
-                             "ibm,platform-facilities");
-    ret |=3D fdt_setprop_cell(fdt, node, "#address-cells", 0x1);
-    ret |=3D fdt_setprop_cell(fdt, node, "#size-cells", 0x0);
-
-    node =3D fdt_add_subnode(fdt, node, "ibm,random-v1");
-    if (node <=3D 0) {
-        return -1;
-    }
-    ret |=3D fdt_setprop_string(fdt, node, "compatible", "ibm,random");
-
-    return ret ? -1 : 0;
-}
-
 static uint32_t spapr_pc_dimm_node(MemoryDeviceInfoList *list, ram_addr_=
t addr)
 {
     MemoryDeviceInfoList *info;
@@ -877,14 +626,51 @@ static int spapr_populate_drconf_memory(SpaprMachin=
eState *spapr, void *fdt)
     return ret;
 }
=20
-static int spapr_dt_cas_updates(SpaprMachineState *spapr, void *fdt,
-                                SpaprOptionVector *ov5_updates)
+static int spapr_populate_memory(SpaprMachineState *spapr, void *fdt)
 {
+    MachineState *machine =3D MACHINE(spapr);
     SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
-    int ret =3D 0, offset;
+    hwaddr mem_start, node_size;
+    int i, nb_nodes =3D machine->numa_state->num_nodes;
+    NodeInfo *nodes =3D machine->numa_state->nodes;
+
+    for (i =3D 0, mem_start =3D 0; i < nb_nodes; ++i) {
+        if (!nodes[i].node_mem) {
+            continue;
+        }
+        if (mem_start >=3D machine->ram_size) {
+            node_size =3D 0;
+        } else {
+            node_size =3D nodes[i].node_mem;
+            if (node_size > machine->ram_size - mem_start) {
+                node_size =3D machine->ram_size - mem_start;
+            }
+        }
+        if (!mem_start) {
+            /* spapr_machine_init() checks for rma_size <=3D node0_size
+             * already */
+            spapr_populate_memory_node(fdt, i, 0, spapr->rma_size);
+            mem_start +=3D spapr->rma_size;
+            node_size -=3D spapr->rma_size;
+        }
+        for ( ; node_size; ) {
+            hwaddr sizetmp =3D pow2floor(node_size);
+
+            /* mem_start !=3D 0 here */
+            if (ctzl(mem_start) < ctzl(sizetmp)) {
+                sizetmp =3D 1ULL << ctzl(mem_start);
+            }
+
+            spapr_populate_memory_node(fdt, i, mem_start, sizetmp);
+            node_size -=3D sizetmp;
+            mem_start +=3D sizetmp;
+        }
+    }
=20
     /* Generate ibm,dynamic-reconfiguration-memory node if required */
-    if (spapr_ovec_test(ov5_updates, OV5_DRCONF_MEMORY)) {
+    if (spapr_ovec_test(spapr->ov5_cas, OV5_DRCONF_MEMORY)) {
+        int ret;
+
         g_assert(smc->dr_lmb_enabled);
         ret =3D spapr_populate_drconf_memory(spapr, fdt);
         if (ret) {
@@ -892,6 +678,222 @@ static int spapr_dt_cas_updates(SpaprMachineState *=
spapr, void *fdt,
         }
     }
=20
+    return 0;
+}
+
+static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
+                                  SpaprMachineState *spapr)
+{
+    MachineState *ms =3D MACHINE(spapr);
+    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+    CPUPPCState *env =3D &cpu->env;
+    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cs);
+    int index =3D spapr_get_vcpu_id(cpu);
+    uint32_t segs[] =3D {cpu_to_be32(28), cpu_to_be32(40),
+                       0xffffffff, 0xffffffff};
+    uint32_t tbfreq =3D kvm_enabled() ? kvmppc_get_tbfreq()
+        : SPAPR_TIMEBASE_FREQ;
+    uint32_t cpufreq =3D kvm_enabled() ? kvmppc_get_clockfreq() : 100000=
0000;
+    uint32_t page_sizes_prop[64];
+    size_t page_sizes_prop_size;
+    unsigned int smp_threads =3D ms->smp.threads;
+    uint32_t vcpus_per_socket =3D smp_threads * ms->smp.cores;
+    uint32_t pft_size_prop[] =3D {0, cpu_to_be32(spapr->htab_shift)};
+    int compat_smt =3D MIN(smp_threads, ppc_compat_max_vthreads(cpu));
+    SpaprDrc *drc;
+    int drc_index;
+    uint32_t radix_AP_encodings[PPC_PAGE_SIZES_MAX_SZ];
+    int i;
+
+    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index);
+    if (drc) {
+        drc_index =3D spapr_drc_index(drc);
+        _FDT((fdt_setprop_cell(fdt, offset, "ibm,my-drc-index", drc_inde=
x)));
+    }
+
+    _FDT((fdt_setprop_cell(fdt, offset, "reg", index)));
+    _FDT((fdt_setprop_string(fdt, offset, "device_type", "cpu")));
+
+    _FDT((fdt_setprop_cell(fdt, offset, "cpu-version", env->spr[SPR_PVR]=
)));
+    _FDT((fdt_setprop_cell(fdt, offset, "d-cache-block-size",
+                           env->dcache_line_size)));
+    _FDT((fdt_setprop_cell(fdt, offset, "d-cache-line-size",
+                           env->dcache_line_size)));
+    _FDT((fdt_setprop_cell(fdt, offset, "i-cache-block-size",
+                           env->icache_line_size)));
+    _FDT((fdt_setprop_cell(fdt, offset, "i-cache-line-size",
+                           env->icache_line_size)));
+
+    if (pcc->l1_dcache_size) {
+        _FDT((fdt_setprop_cell(fdt, offset, "d-cache-size",
+                               pcc->l1_dcache_size)));
+    } else {
+        warn_report("Unknown L1 dcache size for cpu");
+    }
+    if (pcc->l1_icache_size) {
+        _FDT((fdt_setprop_cell(fdt, offset, "i-cache-size",
+                               pcc->l1_icache_size)));
+    } else {
+        warn_report("Unknown L1 icache size for cpu");
+    }
+
+    _FDT((fdt_setprop_cell(fdt, offset, "timebase-frequency", tbfreq)));
+    _FDT((fdt_setprop_cell(fdt, offset, "clock-frequency", cpufreq)));
+    _FDT((fdt_setprop_cell(fdt, offset, "slb-size", cpu->hash64_opts->sl=
b_size)));
+    _FDT((fdt_setprop_cell(fdt, offset, "ibm,slb-size", cpu->hash64_opts=
->slb_size)));
+    _FDT((fdt_setprop_string(fdt, offset, "status", "okay")));
+    _FDT((fdt_setprop(fdt, offset, "64-bit", NULL, 0)));
+
+    if (env->spr_cb[SPR_PURR].oea_read) {
+        _FDT((fdt_setprop_cell(fdt, offset, "ibm,purr", 1)));
+    }
+    if (env->spr_cb[SPR_SPURR].oea_read) {
+        _FDT((fdt_setprop_cell(fdt, offset, "ibm,spurr", 1)));
+    }
+
+    if (ppc_hash64_has(cpu, PPC_HASH64_1TSEG)) {
+        _FDT((fdt_setprop(fdt, offset, "ibm,processor-segment-sizes",
+                          segs, sizeof(segs))));
+    }
+
+    /* Advertise VSX (vector extensions) if available
+     *   1               =3D=3D VMX / Altivec available
+     *   2               =3D=3D VSX available
+     *
+     * Only CPUs for which we create core types in spapr_cpu_core.c
+     * are possible, and all of those have VMX */
+    if (spapr_get_cap(spapr, SPAPR_CAP_VSX) !=3D 0) {
+        _FDT((fdt_setprop_cell(fdt, offset, "ibm,vmx", 2)));
+    } else {
+        _FDT((fdt_setprop_cell(fdt, offset, "ibm,vmx", 1)));
+    }
+
+    /* Advertise DFP (Decimal Floating Point) if available
+     *   0 / no property =3D=3D no DFP
+     *   1               =3D=3D DFP available */
+    if (spapr_get_cap(spapr, SPAPR_CAP_DFP) !=3D 0) {
+        _FDT((fdt_setprop_cell(fdt, offset, "ibm,dfp", 1)));
+    }
+
+    page_sizes_prop_size =3D ppc_create_page_sizes_prop(cpu, page_sizes_=
prop,
+                                                      sizeof(page_sizes_=
prop));
+    if (page_sizes_prop_size) {
+        _FDT((fdt_setprop(fdt, offset, "ibm,segment-page-sizes",
+                          page_sizes_prop, page_sizes_prop_size)));
+    }
+
+    spapr_populate_pa_features(spapr, cpu, fdt, offset);
+
+    _FDT((fdt_setprop_cell(fdt, offset, "ibm,chip-id",
+                           cs->cpu_index / vcpus_per_socket)));
+
+    _FDT((fdt_setprop(fdt, offset, "ibm,pft-size",
+                      pft_size_prop, sizeof(pft_size_prop))));
+
+    if (ms->numa_state->num_nodes > 1) {
+        _FDT(spapr_fixup_cpu_numa_dt(fdt, offset, cpu));
+    }
+
+    _FDT(spapr_fixup_cpu_smt_dt(fdt, offset, cpu, compat_smt));
+
+    if (pcc->radix_page_info) {
+        for (i =3D 0; i < pcc->radix_page_info->count; i++) {
+            radix_AP_encodings[i] =3D
+                cpu_to_be32(pcc->radix_page_info->entries[i]);
+        }
+        _FDT((fdt_setprop(fdt, offset, "ibm,processor-radix-AP-encodings=
",
+                          radix_AP_encodings,
+                          pcc->radix_page_info->count *
+                          sizeof(radix_AP_encodings[0]))));
+    }
+
+    /*
+     * We set this property to let the guest know that it can use the la=
rge
+     * decrementer and its width in bits.
+     */
+    if (spapr_get_cap(spapr, SPAPR_CAP_LARGE_DECREMENTER) !=3D SPAPR_CAP=
_OFF)
+        _FDT((fdt_setprop_u32(fdt, offset, "ibm,dec-bits",
+                              pcc->lrg_decr_bits)));
+}
+
+static void spapr_populate_cpus_dt_node(void *fdt, SpaprMachineState *sp=
apr)
+{
+    CPUState **rev;
+    CPUState *cs;
+    int n_cpus;
+    int cpus_offset;
+    char *nodename;
+    int i;
+
+    cpus_offset =3D fdt_add_subnode(fdt, 0, "cpus");
+    _FDT(cpus_offset);
+    _FDT((fdt_setprop_cell(fdt, cpus_offset, "#address-cells", 0x1)));
+    _FDT((fdt_setprop_cell(fdt, cpus_offset, "#size-cells", 0x0)));
+
+    /*
+     * We walk the CPUs in reverse order to ensure that CPU DT nodes
+     * created by fdt_add_subnode() end up in the right order in FDT
+     * for the guest kernel the enumerate the CPUs correctly.
+     *
+     * The CPU list cannot be traversed in reverse order, so we need
+     * to do extra work.
+     */
+    n_cpus =3D 0;
+    rev =3D NULL;
+    CPU_FOREACH(cs) {
+        rev =3D g_renew(CPUState *, rev, n_cpus + 1);
+        rev[n_cpus++] =3D cs;
+    }
+
+    for (i =3D n_cpus - 1; i >=3D 0; i--) {
+        CPUState *cs =3D rev[i];
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+        int index =3D spapr_get_vcpu_id(cpu);
+        DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
+        int offset;
+
+        if (!spapr_is_thread0_in_vcore(spapr, cpu)) {
+            continue;
+        }
+
+        nodename =3D g_strdup_printf("%s@%x", dc->fw_name, index);
+        offset =3D fdt_add_subnode(fdt, cpus_offset, nodename);
+        g_free(nodename);
+        _FDT(offset);
+        spapr_populate_cpu_dt(cs, fdt, offset, spapr);
+    }
+
+    g_free(rev);
+}
+
+static int spapr_rng_populate_dt(void *fdt)
+{
+    int node;
+    int ret;
+
+    node =3D qemu_fdt_add_subnode(fdt, "/ibm,platform-facilities");
+    if (node <=3D 0) {
+        return -1;
+    }
+    ret =3D fdt_setprop_string(fdt, node, "device_type",
+                             "ibm,platform-facilities");
+    ret |=3D fdt_setprop_cell(fdt, node, "#address-cells", 0x1);
+    ret |=3D fdt_setprop_cell(fdt, node, "#size-cells", 0x0);
+
+    node =3D fdt_add_subnode(fdt, node, "ibm,random-v1");
+    if (node <=3D 0) {
+        return -1;
+    }
+    ret |=3D fdt_setprop_string(fdt, node, "compatible", "ibm,random");
+
+    return ret ? -1 : 0;
+}
+
+static int spapr_dt_cas_updates(SpaprMachineState *spapr, void *fdt,
+                                SpaprOptionVector *ov5_updates)
+{
+    int offset;
+
     offset =3D fdt_path_offset(fdt, "/chosen");
     if (offset < 0) {
         offset =3D fdt_add_subnode(fdt, 0, "chosen");
--=20
2.24.1


