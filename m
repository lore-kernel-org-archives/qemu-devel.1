Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C956FC38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 05:07:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F00420753
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 05:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="AHsZ0+EH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F00420753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWYku-0005J1-NL
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 01:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWYhy-0007hO-Rr; Thu, 07 May 2020 01:04:30 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:41053)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWYhw-0007gC-SQ; Thu, 07 May 2020 01:04:30 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49HhFp4mghz9sTJ; Thu,  7 May 2020 15:04:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1588827854;
 bh=gvaiURSsSB2zDC9qKjqVsfG3wv1W9zvbaUwk6sqo0Pg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AHsZ0+EHmPVHgwlJCda+DVhk99zu/BmbtrjcruWE7uoM77MWtMtrPD7bm4nba5EYG
 ReMlEZPJCJWe1t1ZCrTFV1aUYmHmc2DyAgnNqXM4GTrgdx76rdO6l+DGCOdHbX5xSK
 tPQ98wNwjzYkYdlfpIDNM3tY10K/qoTE4FqtqfDY=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 12/18] target/ppc: Introduce ppc_radix64_xlate() for Radix tree
 translation
Date: Thu,  7 May 2020 15:02:22 +1000
Message-Id: <20200507050228.802395-13-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200507050228.802395-1-david@gibson.dropbear.id.au>
References: <20200507050228.802395-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, npiggin@gmail.com, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cédric Le Goater <clg@kaod.org>

This is moving code under a new ppc_radix64_xlate() routine shared by
the MMU Radix page fault handler and the 'get_phys_page_debug' PPC
callback. The difference being that 'get_phys_page_debug' does not
generate exceptions.

The specific part of process-scoped Radix translation is moved under
ppc_radix64_process_scoped_xlate() in preparation of the future support
for partition-scoped Radix translation. Routines raising the exceptions
now take a 'cause_excp' bool to cover the 'get_phys_page_debug' case.

It should be functionally equivalent.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <20200403140056.59465-2-clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu-radix64.c | 219 ++++++++++++++++++++++-----------------
 1 file changed, 123 insertions(+), 96 deletions(-)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index d2422d1c54..4b0d0ff50a 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -219,17 +219,127 @@ static bool validate_pate(PowerPCCPU *cpu, uint64_t lpid, ppc_v3_pate_t *pate)
     return true;
 }
 
+static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
+                                            vaddr eaddr, uint64_t pid,
+                                            ppc_v3_pate_t pate, hwaddr *g_raddr,
+                                            int *g_prot, int *g_page_size,
+                                            bool cause_excp)
+{
+    CPUState *cs = CPU(cpu);
+    uint64_t offset, size, prtbe_addr, prtbe0, pte;
+    int fault_cause = 0;
+    hwaddr pte_addr;
+
+    /* Index Process Table by PID to Find Corresponding Process Table Entry */
+    offset = pid * sizeof(struct prtb_entry);
+    size = 1ULL << ((pate.dw1 & PATE1_R_PRTS) + 12);
+    if (offset >= size) {
+        /* offset exceeds size of the process table */
+        if (cause_excp) {
+            ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
+        }
+        return 1;
+    }
+    prtbe_addr = (pate.dw1 & PATE1_R_PRTB) + offset;
+    prtbe0 = ldq_phys(cs->as, prtbe_addr);
+
+    /* Walk Radix Tree from Process Table Entry to Convert EA to RA */
+    *g_page_size = PRTBE_R_GET_RTS(prtbe0);
+    pte = ppc_radix64_walk_tree(cpu, eaddr & R_EADDR_MASK,
+                                prtbe0 & PRTBE_R_RPDB, prtbe0 & PRTBE_R_RPDS,
+                                g_raddr, g_page_size, &fault_cause, &pte_addr);
+
+    if (!(pte & R_PTE_VALID) ||
+        ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, g_prot)) {
+        /* No valid pte or access denied due to protection */
+        if (cause_excp) {
+            ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
+        }
+        return 1;
+    }
+
+    ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, g_prot);
+
+    return 0;
+}
+
+static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
+                             bool relocation,
+                             hwaddr *raddr, int *psizep, int *protp,
+                             bool cause_excp)
+{
+    uint64_t lpid = 0, pid = 0;
+    ppc_v3_pate_t pate;
+    int psize, prot;
+    hwaddr g_raddr;
+
+    /* Virtual Mode Access - get the fully qualified address */
+    if (!ppc_radix64_get_fully_qualified_addr(&cpu->env, eaddr, &lpid, &pid)) {
+        if (cause_excp) {
+            ppc_radix64_raise_segi(cpu, rwx, eaddr);
+        }
+        return 1;
+    }
+
+    /* Get Process Table */
+    if (cpu->vhyp) {
+        PPCVirtualHypervisorClass *vhc;
+        vhc = PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+        vhc->get_pate(cpu->vhyp, &pate);
+    } else {
+        if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
+            if (cause_excp) {
+                ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
+            }
+            return 1;
+        }
+        if (!validate_pate(cpu, lpid, &pate)) {
+            if (cause_excp) {
+                ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_R_BADCONFIG);
+            }
+            return 1;
+        }
+        /* We don't support guest mode yet */
+        if (lpid != 0) {
+            error_report("PowerNV guest support Unimplemented");
+            exit(1);
+        }
+    }
+
+    *psizep = INT_MAX;
+    *protp = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+
+    /*
+     * Perform process-scoped translation if relocation enabled.
+     *
+     * - Translates an effective address to a host real address in
+     *   quadrants 0 and 3 when HV=1.
+     */
+    if (relocation) {
+        int ret = ppc_radix64_process_scoped_xlate(cpu, rwx, eaddr, pid,
+                                                   pate, &g_raddr, &prot,
+                                                   &psize, cause_excp);
+        if (ret) {
+            return ret;
+        }
+        *psizep = MIN(*psizep, psize);
+        *protp &= prot;
+    } else {
+        g_raddr = eaddr & R_EADDR_MASK;
+    }
+
+    *raddr = g_raddr;
+    return 0;
+}
+
 int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
                                  int mmu_idx)
 {
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
-    PPCVirtualHypervisorClass *vhc;
-    hwaddr raddr, pte_addr;
-    uint64_t lpid = 0, pid = 0, offset, size, prtbe0, pte;
-    int page_size, prot, fault_cause = 0;
-    ppc_v3_pate_t pate;
+    int page_size, prot;
     bool relocation;
+    hwaddr raddr;
 
     assert(!(msr_hv && cpu->vhyp));
     assert((rwx == 0) || (rwx == 1) || (rwx == 2));
@@ -262,55 +372,12 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
                       TARGET_FMT_lx "\n", env->spr[SPR_LPCR]);
     }
 
-    /* Virtual Mode Access - get the fully qualified address */
-    if (!ppc_radix64_get_fully_qualified_addr(env, eaddr, &lpid, &pid)) {
-        ppc_radix64_raise_segi(cpu, rwx, eaddr);
+    /* Translate eaddr to raddr (where raddr is addr qemu needs for access) */
+    if (ppc_radix64_xlate(cpu, eaddr, rwx, relocation, &raddr,
+                          &page_size, &prot, true)) {
         return 1;
     }
 
-    /* Get Process Table */
-    if (cpu->vhyp) {
-        vhc = PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-        vhc->get_pate(cpu->vhyp, &pate);
-    } else {
-        if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
-            ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
-            return 1;
-        }
-        if (!validate_pate(cpu, lpid, &pate)) {
-            ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_R_BADCONFIG);
-        }
-        /* We don't support guest mode yet */
-        if (lpid != 0) {
-            error_report("PowerNV guest support Unimplemented");
-            exit(1);
-       }
-    }
-
-    /* Index Process Table by PID to Find Corresponding Process Table Entry */
-    offset = pid * sizeof(struct prtb_entry);
-    size = 1ULL << ((pate.dw1 & PATE1_R_PRTS) + 12);
-    if (offset >= size) {
-        /* offset exceeds size of the process table */
-        ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
-        return 1;
-    }
-    prtbe0 = ldq_phys(cs->as, (pate.dw1 & PATE1_R_PRTB) + offset);
-
-    /* Walk Radix Tree from Process Table Entry to Convert EA to RA */
-    page_size = PRTBE_R_GET_RTS(prtbe0);
-    pte = ppc_radix64_walk_tree(cpu, eaddr & R_EADDR_MASK,
-                                prtbe0 & PRTBE_R_RPDB, prtbe0 & PRTBE_R_RPDS,
-                                &raddr, &page_size, &fault_cause, &pte_addr);
-    if (!pte || ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, &prot)) {
-        /* Couldn't get pte or access denied due to protection */
-        ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
-        return 1;
-    }
-
-    /* Update Reference and Change Bits */
-    ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, &prot);
-
     tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_MASK,
                  prot, mmu_idx, 1UL << page_size);
     return 0;
@@ -318,58 +385,18 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
 
 hwaddr ppc_radix64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong eaddr)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
-    PPCVirtualHypervisorClass *vhc;
-    hwaddr raddr, pte_addr;
-    uint64_t lpid = 0, pid = 0, offset, size, prtbe0, pte;
-    int page_size, fault_cause = 0;
-    ppc_v3_pate_t pate;
+    int psize, prot;
+    hwaddr raddr;
 
     /* Handle Real Mode */
-    if (msr_dr == 0) {
+    if ((msr_dr == 0) && (msr_hv || cpu->vhyp)) {
         /* In real mode top 4 effective addr bits (mostly) ignored */
         return eaddr & 0x0FFFFFFFFFFFFFFFULL;
     }
 
-    /* Virtual Mode Access - get the fully qualified address */
-    if (!ppc_radix64_get_fully_qualified_addr(env, eaddr, &lpid, &pid)) {
-        return -1;
-    }
-
-    /* Get Process Table */
-    if (cpu->vhyp) {
-        vhc = PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-        vhc->get_pate(cpu->vhyp, &pate);
-    } else {
-        if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
-            return -1;
-        }
-        if (!validate_pate(cpu, lpid, &pate)) {
-            return -1;
-        }
-        /* We don't support guest mode yet */
-        if (lpid != 0) {
-            error_report("PowerNV guest support Unimplemented");
-            exit(1);
-       }
-    }
-
-    /* Index Process Table by PID to Find Corresponding Process Table Entry */
-    offset = pid * sizeof(struct prtb_entry);
-    size = 1ULL << ((pate.dw1 & PATE1_R_PRTS) + 12);
-    if (offset >= size) {
-        /* offset exceeds size of the process table */
-        return -1;
-    }
-    prtbe0 = ldq_phys(cs->as, (pate.dw1 & PATE1_R_PRTB) + offset);
-
-    /* Walk Radix Tree from Process Table Entry to Convert EA to RA */
-    page_size = PRTBE_R_GET_RTS(prtbe0);
-    pte = ppc_radix64_walk_tree(cpu, eaddr & R_EADDR_MASK,
-                                prtbe0 & PRTBE_R_RPDB, prtbe0 & PRTBE_R_RPDS,
-                                &raddr, &page_size, &fault_cause, &pte_addr);
-    if (!pte) {
+    if (ppc_radix64_xlate(cpu, eaddr, 0, msr_dr, &raddr, &psize,
+                          &prot, false)) {
         return -1;
     }
 
-- 
2.26.2


