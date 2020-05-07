Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CC3C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 05:10:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1CA820753
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 05:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dJ8UJ0UO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CA820753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWYo9-00042Q-SU
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 01:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWYi1-0007nO-5z; Thu, 07 May 2020 01:04:33 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40939 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWYi0-0007ug-0W; Thu, 07 May 2020 01:04:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49HhFq0gz2z9sTL; Thu,  7 May 2020 15:04:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1588827855;
 bh=tZ3Kasifk++2rxl06Eg2Balz4fv0k7E9uAoNZry82So=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dJ8UJ0UOx+FNyk+RbO0TRt1G/2b387BEGnGmc+EwlSj47FyNojxol0+fJfwA7MNj4
 hO97rxfO0lHewY3I0BjEGoEaGiqncHONUxkXOQ4NmuwBVVYGg3GH2cp3w3gKgoxGl2
 dLe8/ZgvkCtkVoaqKfcCK5E1fUl2iWocFjlN6PvU=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 14/18] target/ppc: Rework ppc_radix64_walk_tree() for
 partition-scoped translation
Date: Thu,  7 May 2020 15:02:24 +1000
Message-Id: <20200507050228.802395-15-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200507050228.802395-1-david@gibson.dropbear.id.au>
References: <20200507050228.802395-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 01:04:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

The ppc_radix64_walk_tree() routine walks through the nested radix
tables to look for a PTE.

Split it in two and introduce a new routine ppc_radix64_next_level()
which we will use for partition-scoped Radix translation when
translating the process tree addresses. The prototypes are slightly
change to use a 'AddressSpace *' parameter, instead of a 'PowerPCCPU *'
which is not required, and to return an error code instead of a PTE
value. It clarifies error handling in the callers.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <20200403140056.59465-4-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu-radix64.c | 79 ++++++++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 27 deletions(-)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 11b3c6d48c..2400da41e0 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -163,44 +163,67 @@ static void ppc_radix64_set_rc(PowerPCCPU *cpu, int rwx, uint64_t pte,
     }
 }
 
-static uint64_t ppc_radix64_walk_tree(PowerPCCPU *cpu, vaddr eaddr,
-                                      uint64_t base_addr, uint64_t nls,
-                                      hwaddr *raddr, int *psize,
-                                      int *fault_cause, hwaddr *pte_addr)
+static int ppc_radix64_next_level(AddressSpace *as, vaddr eaddr,
+                                  uint64_t *pte_addr, uint64_t *nls,
+                                  int *psize, uint64_t *pte, int *fault_cause)
 {
-    CPUState *cs = CPU(cpu);
     uint64_t index, pde;
 
-    if (nls < 5) { /* Directory maps less than 2**5 entries */
+    if (*nls < 5) { /* Directory maps less than 2**5 entries */
         *fault_cause |= DSISR_R_BADCONFIG;
-        return 0;
+        return 1;
     }
 
     /* Read page <directory/table> entry from guest address space */
-    index = eaddr >> (*psize - nls); /* Shift */
-    index &= ((1UL << nls) - 1); /* Mask */
-    pde = ldq_phys(cs->as, base_addr + (index * sizeof(pde)));
-    if (!(pde & R_PTE_VALID)) { /* Invalid Entry */
+    pde = ldq_phys(as, *pte_addr);
+    if (!(pde & R_PTE_VALID)) {         /* Invalid Entry */
         *fault_cause |= DSISR_NOPTE;
-        return 0;
+        return 1;
     }
 
-    *psize -= nls;
+    *pte = pde;
+    *psize -= *nls;
+    if (!(pde & R_PTE_LEAF)) { /* Prepare for next iteration */
+        *nls = pde & R_PDE_NLS;
+        index = eaddr >> (*psize - *nls);       /* Shift */
+        index &= ((1UL << *nls) - 1);           /* Mask */
+        *pte_addr = (pde & R_PDE_NLB) + (index * sizeof(pde));
+    }
+    return 0;
+}
 
-    /* Check if Leaf Entry -> Page Table Entry -> Stop the Search */
-    if (pde & R_PTE_LEAF) {
-        uint64_t rpn = pde & R_PTE_RPN;
-        uint64_t mask = (1UL << *psize) - 1;
+static int ppc_radix64_walk_tree(AddressSpace *as, vaddr eaddr,
+                                 uint64_t base_addr, uint64_t nls,
+                                 hwaddr *raddr, int *psize, uint64_t *pte,
+                                 int *fault_cause, hwaddr *pte_addr)
+{
+    uint64_t index, pde, rpn , mask;
 
-        /* Or high bits of rpn and low bits to ea to form whole real addr */
-        *raddr = (rpn & ~mask) | (eaddr & mask);
-        *pte_addr = base_addr + (index * sizeof(pde));
-        return pde;
+    if (nls < 5) { /* Directory maps less than 2**5 entries */
+        *fault_cause |= DSISR_R_BADCONFIG;
+        return 1;
     }
 
-    /* Next Level of Radix Tree */
-    return ppc_radix64_walk_tree(cpu, eaddr, pde & R_PDE_NLB, pde & R_PDE_NLS,
-                                 raddr, psize, fault_cause, pte_addr);
+    index = eaddr >> (*psize - nls);    /* Shift */
+    index &= ((1UL << nls) - 1);       /* Mask */
+    *pte_addr = base_addr + (index * sizeof(pde));
+    do {
+        int ret;
+
+        ret = ppc_radix64_next_level(as, eaddr, pte_addr, &nls, psize, &pde,
+                                     fault_cause);
+        if (ret) {
+            return ret;
+        }
+    } while (!(pde & R_PTE_LEAF));
+
+    *pte = pde;
+    rpn = pde & R_PTE_RPN;
+    mask = (1UL << *psize) - 1;
+
+    /* Or high bits of rpn and low bits to ea to form whole real addr */
+    *raddr = (rpn & ~mask) | (eaddr & mask);
+    return 0;
 }
 
 static bool validate_pate(PowerPCCPU *cpu, uint64_t lpid, ppc_v3_pate_t *pate)
@@ -230,6 +253,7 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
     uint64_t offset, size, prtbe_addr, prtbe0, pte;
     int fault_cause = 0;
     hwaddr pte_addr;
+    int ret;
 
     /* Index Process Table by PID to Find Corresponding Process Table Entry */
     offset = pid * sizeof(struct prtb_entry);
@@ -246,11 +270,12 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
 
     /* Walk Radix Tree from Process Table Entry to Convert EA to RA */
     *g_page_size = PRTBE_R_GET_RTS(prtbe0);
-    pte = ppc_radix64_walk_tree(cpu, eaddr & R_EADDR_MASK,
+    ret = ppc_radix64_walk_tree(cs->as, eaddr & R_EADDR_MASK,
                                 prtbe0 & PRTBE_R_RPDB, prtbe0 & PRTBE_R_RPDS,
-                                g_raddr, g_page_size, &fault_cause, &pte_addr);
+                                g_raddr, g_page_size, &pte, &fault_cause,
+                                &pte_addr);
 
-    if (!(pte & R_PTE_VALID) ||
+    if (ret ||
         ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, g_prot, false)) {
         /* No valid pte or access denied due to protection */
         if (cause_excp) {
-- 
2.26.2


