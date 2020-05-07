Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6AAC38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 05:12:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 480D520753
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 05:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BBi+rCHw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 480D520753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWYpu-0007VN-Ee
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 01:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWYi2-0007ry-Pz; Thu, 07 May 2020 01:04:34 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:60183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWYi0-0007wV-PX; Thu, 07 May 2020 01:04:34 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49HhFq3jkgz9sTY; Thu,  7 May 2020 15:04:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1588827855;
 bh=55CWZyvBjrn87AQNAWFTCfs6zi0QsgtTgI2UAZ43IKs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BBi+rCHwm0Jtl9Oc/43EinQXtCaYEBufabIO7tTYCGv8PbPC8lbxIUoX3W9auGxeW
 VwVn/jYbY+eT9+E5gYv5EWs9Z2eD027xlIWIc+MK0LS6G/szSBKsH9bI14Stm+of/R
 A1BBOlDgJbmb63Xsg67EDROV3UK9KV/5XIrOvT74=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 15/18] target/ppc: Add support for Radix partition-scoped
 translation
Date: Thu,  7 May 2020 15:02:25 +1000
Message-Id: <20200507050228.802395-16-david@gibson.dropbear.id.au>
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

The Radix tree translation model currently supports process-scoped
translation for the PowerNV machine (Hypervisor mode) and for the
pSeries machine (Guest mode). Guests running under an emulated
Hypervisor (PowerNV machine) require a new type of Radix translation,
called partition-scoped, which is missing today.

The Radix tree translation is a 2 steps process. The first step,
process-scoped translation, converts an effective Address to a guest
real address, and the second step, partition-scoped translation,
converts a guest real address to a host real address.

There are difference cases to covers :

* Hypervisor real mode access: no Radix translation.

* Hypervisor or host application access (quadrant 0 and 3) with
  relocation on: process-scoped translation.

* Guest OS real mode access: only partition-scoped translation.

* Guest OS real or guest application access (quadrant 0 and 3) with
  relocation on: both process-scoped translation and partition-scoped
  translations.

* Hypervisor access in quadrant 1 and 2 with relocation on: both
  process-scoped translation and partition-scoped translations.

The radix tree partition-scoped translation is performed using tables
pointed to by the first double-word of the Partition Table Entries and
process-scoped translation uses tables pointed to by the Process Table
Entries (second double-word of the Partition Table Entries).

Both partition-scoped and process-scoped translations process are
identical and thus the radix tree traversing code is largely reused.
However, errors in partition-scoped translations generate hypervisor
exceptions.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <20200403140056.59465-5-clg@kaod.org>
[dwg: Fixup from Greg Kurz folded in]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h         |   3 +
 target/ppc/excp_helper.c |   3 +-
 target/ppc/mmu-radix64.c | 194 +++++++++++++++++++++++++++++++++++----
 3 files changed, 181 insertions(+), 19 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index f4a5304d43..6b6dd7e483 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -463,6 +463,9 @@ typedef struct ppc_v3_pate_t {
 #define DSISR_AMR                0x00200000
 /* Unsupported Radix Tree Configuration */
 #define DSISR_R_BADCONFIG        0x00080000
+#define DSISR_ATOMIC_RC          0x00040000
+/* Unable to translate address of (guest) pde or process/page table entry */
+#define DSISR_PRTABLE_FAULT      0x00020000
 
 /* SRR1 error code fields */
 
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 1acc3786de..f052979664 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -506,9 +506,10 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
     case POWERPC_EXCP_ISEG:      /* Instruction segment exception            */
     case POWERPC_EXCP_TRACE:     /* Trace exception                          */
         break;
+    case POWERPC_EXCP_HISI:      /* Hypervisor instruction storage exception */
+        msr |= env->error_code;
     case POWERPC_EXCP_HDECR:     /* Hypervisor decrementer exception         */
     case POWERPC_EXCP_HDSI:      /* Hypervisor data storage exception        */
-    case POWERPC_EXCP_HISI:      /* Hypervisor instruction storage exception */
     case POWERPC_EXCP_HDSEG:     /* Hypervisor data segment exception        */
     case POWERPC_EXCP_HISEG:     /* Hypervisor instruction segment exception */
     case POWERPC_EXCP_SDOOR_HV:  /* Hypervisor Doorbell interrupt            */
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 2400da41e0..1404e53dec 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -103,6 +103,27 @@ static void ppc_radix64_raise_si(PowerPCCPU *cpu, int rwx, vaddr eaddr,
     }
 }
 
+static void ppc_radix64_raise_hsi(PowerPCCPU *cpu, int rwx, vaddr eaddr,
+                                  hwaddr g_raddr, uint32_t cause)
+{
+    CPUState *cs = CPU(cpu);
+    CPUPPCState *env = &cpu->env;
+
+    if (rwx == 2) { /* H Instruction Storage Interrupt */
+        cs->exception_index = POWERPC_EXCP_HISI;
+        env->spr[SPR_ASDR] = g_raddr;
+        env->error_code = cause;
+    } else { /* H Data Storage Interrupt */
+        cs->exception_index = POWERPC_EXCP_HDSI;
+        if (rwx == 1) { /* Write -> Store */
+            cause |= DSISR_ISSTORE;
+        }
+        env->spr[SPR_HDSISR] = cause;
+        env->spr[SPR_HDAR] = eaddr;
+        env->spr[SPR_ASDR] = g_raddr;
+        env->error_code = 0;
+    }
+}
 
 static bool ppc_radix64_check_prot(PowerPCCPU *cpu, int rwx, uint64_t pte,
                                    int *fault_cause, int *prot,
@@ -243,6 +264,37 @@ static bool validate_pate(PowerPCCPU *cpu, uint64_t lpid, ppc_v3_pate_t *pate)
     return true;
 }
 
+static int ppc_radix64_partition_scoped_xlate(PowerPCCPU *cpu, int rwx,
+                                              vaddr eaddr, hwaddr g_raddr,
+                                              ppc_v3_pate_t pate,
+                                              hwaddr *h_raddr, int *h_prot,
+                                              int *h_page_size, bool pde_addr,
+                                              bool cause_excp)
+{
+    int fault_cause = 0;
+    hwaddr pte_addr;
+    uint64_t pte;
+
+    *h_page_size = PRTBE_R_GET_RTS(pate.dw0);
+    /* No valid pte or access denied due to protection */
+    if (ppc_radix64_walk_tree(CPU(cpu)->as, g_raddr, pate.dw0 & PRTBE_R_RPDB,
+                              pate.dw0 & PRTBE_R_RPDS, h_raddr, h_page_size,
+                              &pte, &fault_cause, &pte_addr) ||
+        ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, h_prot, true)) {
+        if (pde_addr) /* address being translated was that of a guest pde */
+            fault_cause |= DSISR_PRTABLE_FAULT;
+        if (cause_excp) {
+            ppc_radix64_raise_hsi(cpu, rwx, eaddr, g_raddr, fault_cause);
+        }
+        return 1;
+    }
+
+    /* Update Reference and Change Bits */
+    ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, h_prot);
+
+    return 0;
+}
+
 static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
                                             vaddr eaddr, uint64_t pid,
                                             ppc_v3_pate_t pate, hwaddr *g_raddr,
@@ -250,9 +302,10 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
                                             bool cause_excp)
 {
     CPUState *cs = CPU(cpu);
-    uint64_t offset, size, prtbe_addr, prtbe0, pte;
-    int fault_cause = 0;
-    hwaddr pte_addr;
+    CPUPPCState *env = &cpu->env;
+    uint64_t offset, size, prtbe_addr, prtbe0, base_addr, nls, index, pte;
+    int fault_cause = 0, h_page_size, h_prot;
+    hwaddr h_raddr, pte_addr;
     int ret;
 
     /* Index Process Table by PID to Find Corresponding Process Table Entry */
@@ -266,18 +319,85 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
         return 1;
     }
     prtbe_addr = (pate.dw1 & PATE1_R_PRTB) + offset;
-    prtbe0 = ldq_phys(cs->as, prtbe_addr);
+
+    if (cpu->vhyp) {
+        prtbe0 = ldq_phys(cs->as, prtbe_addr);
+    } else {
+        /*
+         * Process table addresses are subject to partition-scoped
+         * translation
+         *
+         * On a Radix host, the partition-scoped page table for LPID=0
+         * is only used to translate the effective addresses of the
+         * process table entries.
+         */
+        ret = ppc_radix64_partition_scoped_xlate(cpu, 0, eaddr, prtbe_addr,
+                                                 pate, &h_raddr, &h_prot,
+                                                 &h_page_size, 1, 1);
+        if (ret) {
+            return ret;
+        }
+        prtbe0 = ldq_phys(cs->as, h_raddr);
+    }
 
     /* Walk Radix Tree from Process Table Entry to Convert EA to RA */
     *g_page_size = PRTBE_R_GET_RTS(prtbe0);
-    ret = ppc_radix64_walk_tree(cs->as, eaddr & R_EADDR_MASK,
-                                prtbe0 & PRTBE_R_RPDB, prtbe0 & PRTBE_R_RPDS,
-                                g_raddr, g_page_size, &pte, &fault_cause,
-                                &pte_addr);
-
-    if (ret ||
-        ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, g_prot, false)) {
-        /* No valid pte or access denied due to protection */
+    base_addr = prtbe0 & PRTBE_R_RPDB;
+    nls = prtbe0 & PRTBE_R_RPDS;
+    if (msr_hv || cpu->vhyp) {
+        /*
+         * Can treat process table addresses as real addresses
+         */
+        ret = ppc_radix64_walk_tree(cs->as, eaddr & R_EADDR_MASK, base_addr,
+                                    nls, g_raddr, g_page_size, &pte,
+                                    &fault_cause, &pte_addr);
+        if (ret) {
+            /* No valid PTE */
+            if (cause_excp) {
+                ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
+            }
+            return ret;
+        }
+    } else {
+        uint64_t rpn, mask;
+
+        index = (eaddr & R_EADDR_MASK) >> (*g_page_size - nls); /* Shift */
+        index &= ((1UL << nls) - 1);                            /* Mask */
+        pte_addr = base_addr + (index * sizeof(pte));
+
+        /*
+         * Each process table address is subject to a partition-scoped
+         * translation
+         */
+        do {
+            ret = ppc_radix64_partition_scoped_xlate(cpu, 0, eaddr, pte_addr,
+                                                     pate, &h_raddr, &h_prot,
+                                                     &h_page_size, 1, 1);
+            if (ret) {
+                return ret;
+            }
+
+            ret = ppc_radix64_next_level(cs->as, eaddr & R_EADDR_MASK, &h_raddr,
+                                         &nls, g_page_size, &pte, &fault_cause);
+            if (ret) {
+                /* No valid pte */
+                if (cause_excp) {
+                    ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
+                }
+                return ret;
+            }
+            pte_addr = h_raddr;
+        } while (!(pte & R_PTE_LEAF));
+
+        rpn = pte & R_PTE_RPN;
+        mask = (1UL << *g_page_size) - 1;
+
+        /* Or high bits of rpn and low bits to ea to form whole real addr */
+        *g_raddr = (rpn & ~mask) | (eaddr & mask);
+    }
+
+    if (ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, g_prot, false)) {
+        /* Access denied due to protection */
         if (cause_excp) {
             ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
         }
@@ -289,11 +409,29 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
     return 0;
 }
 
+/*
+ * Radix tree translation is a 2 steps translation process:
+ *
+ * 1. Process-scoped translation:   Guest Eff Addr  -> Guest Real Addr
+ * 2. Partition-scoped translation: Guest Real Addr -> Host Real Addr
+ *
+ *                                  MSR[HV]
+ *              +-------------+----------------+---------------+
+ *              |             |     HV = 0     |     HV = 1    |
+ *              +-------------+----------------+---------------+
+ *              | Relocation  |    Partition   |      No       |
+ *              | = Off       |     Scoped     |  Translation  |
+ *  Relocation  +-------------+----------------+---------------+
+ *              | Relocation  |   Partition &  |    Process    |
+ *              | = On        | Process Scoped |    Scoped     |
+ *              +-------------+----------------+---------------+
+ */
 static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
                              bool relocation,
                              hwaddr *raddr, int *psizep, int *protp,
                              bool cause_excp)
 {
+    CPUPPCState *env = &cpu->env;
     uint64_t lpid = 0, pid = 0;
     ppc_v3_pate_t pate;
     int psize, prot;
@@ -325,11 +463,6 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
             }
             return 1;
         }
-        /* We don't support guest mode yet */
-        if (lpid != 0) {
-            error_report("PowerNV guest support Unimplemented");
-            exit(1);
-        }
     }
 
     *psizep = INT_MAX;
@@ -340,6 +473,8 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
      *
      * - Translates an effective address to a host real address in
      *   quadrants 0 and 3 when HV=1.
+     *
+     * - Translates an effective address to a guest real address.
      */
     if (relocation) {
         int ret = ppc_radix64_process_scoped_xlate(cpu, rwx, eaddr, pid,
@@ -354,7 +489,30 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
         g_raddr = eaddr & R_EADDR_MASK;
     }
 
-    *raddr = g_raddr;
+    if (cpu->vhyp) {
+        *raddr = g_raddr;
+    } else {
+        /*
+         * Perform partition-scoped translation if !HV or HV access to
+         * quadrants 1 or 2. Translates a guest real address to a host
+         * real address.
+         */
+        if (lpid || !msr_hv) {
+            int ret;
+
+            ret = ppc_radix64_partition_scoped_xlate(cpu, rwx, eaddr, g_raddr,
+                                                     pate, raddr, &prot, &psize,
+                                                     0, cause_excp);
+            if (ret) {
+                return ret;
+            }
+            *psizep = MIN(*psizep, psize);
+            *protp &= prot;
+        } else {
+            *raddr = g_raddr;
+        }
+    }
+
     return 0;
 }
 
-- 
2.26.2


