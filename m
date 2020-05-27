Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D026CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:43:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D57220787
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TSli55tG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D57220787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdoqs-0003aC-JB
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 01:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jdoln-0001DJ-1a; Wed, 27 May 2020 01:38:27 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:53057)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jdoll-0001ei-Kg; Wed, 27 May 2020 01:38:26 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49X03r2l37z9sTK; Wed, 27 May 2020 15:38:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1590557896;
 bh=V7+62qseqtwt71VNf/uBxCQnQbUz3nRZHhrS5KZw8hs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TSli55tGR/umJJgzWcCvDZrv90E3w5sdMLTwEp8v/4ZBzZJYHiLcqLPvp7EbEOPCR
 jxetkQplRM04Cac0nE6uEP3KysyaPS/WDSMWMIqB7AoowDtG5NLSl7oCx05oMFGoZQ
 t2hktRmQbahe11dBBBF7B1adjmewmZ0Ql9Mbv2F0=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 11/15] target/ppc: Don't update radix PTE R/C bits with gdbstub
Date: Wed, 27 May 2020 15:38:05 +1000
Message-Id: <20200527053809.356168-12-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527053809.356168-1-david@gibson.dropbear.id.au>
References: <20200527053809.356168-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

gdbstub shouldn't silently change guest visible state when doing address
translation. Since the R/C bits can only be updated when handling a MMU
fault, let's reuse the cause_excp flag and rename it to guest_visible.
While here drop a not very useful comment.

This was found while reading the code. I could verify that this affects
both powernv and pseries, but I failed to observe any actual bug.

Fixes: d04ea940c597 "target/ppc: Add support for Radix partition-scoped translation"
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <158941063899.240484.2778628492106387793.stgit@bahia.lan>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu-radix64.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 7ce37cb778..0d3922537c 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -274,7 +274,7 @@ static int ppc_radix64_partition_scoped_xlate(PowerPCCPU *cpu, int rwx,
                                               ppc_v3_pate_t pate,
                                               hwaddr *h_raddr, int *h_prot,
                                               int *h_page_size, bool pde_addr,
-                                              bool cause_excp)
+                                              bool guest_visible)
 {
     int fault_cause = 0;
     hwaddr pte_addr;
@@ -289,14 +289,15 @@ static int ppc_radix64_partition_scoped_xlate(PowerPCCPU *cpu, int rwx,
         if (pde_addr) { /* address being translated was that of a guest pde */
             fault_cause |= DSISR_PRTABLE_FAULT;
         }
-        if (cause_excp) {
+        if (guest_visible) {
             ppc_radix64_raise_hsi(cpu, rwx, eaddr, g_raddr, fault_cause);
         }
         return 1;
     }
 
-    /* Update Reference and Change Bits */
-    ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, h_prot);
+    if (guest_visible) {
+        ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, h_prot);
+    }
 
     return 0;
 }
@@ -305,7 +306,7 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
                                             vaddr eaddr, uint64_t pid,
                                             ppc_v3_pate_t pate, hwaddr *g_raddr,
                                             int *g_prot, int *g_page_size,
-                                            bool cause_excp)
+                                            bool guest_visible)
 {
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
@@ -319,7 +320,7 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
     size = 1ULL << ((pate.dw1 & PATE1_R_PRTS) + 12);
     if (offset >= size) {
         /* offset exceeds size of the process table */
-        if (cause_excp) {
+        if (guest_visible) {
             ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
         }
         return 1;
@@ -340,7 +341,7 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
         ret = ppc_radix64_partition_scoped_xlate(cpu, 0, eaddr, prtbe_addr,
                                                  pate, &h_raddr, &h_prot,
                                                  &h_page_size, true,
-                                                 cause_excp);
+                                                 guest_visible);
         if (ret) {
             return ret;
         }
@@ -360,7 +361,7 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
                                     &fault_cause, &pte_addr);
         if (ret) {
             /* No valid PTE */
-            if (cause_excp) {
+            if (guest_visible) {
                 ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
             }
             return ret;
@@ -380,7 +381,7 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
             ret = ppc_radix64_partition_scoped_xlate(cpu, 0, eaddr, pte_addr,
                                                      pate, &h_raddr, &h_prot,
                                                      &h_page_size, true,
-                                                     cause_excp);
+                                                     guest_visible);
             if (ret) {
                 return ret;
             }
@@ -389,7 +390,7 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
                                          &nls, g_page_size, &pte, &fault_cause);
             if (ret) {
                 /* No valid pte */
-                if (cause_excp) {
+                if (guest_visible) {
                     ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
                 }
                 return ret;
@@ -406,13 +407,15 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
 
     if (ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, g_prot, false)) {
         /* Access denied due to protection */
-        if (cause_excp) {
+        if (guest_visible) {
             ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
         }
         return 1;
     }
 
-    ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, g_prot);
+    if (guest_visible) {
+        ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, g_prot);
+    }
 
     return 0;
 }
@@ -437,7 +440,7 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
 static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
                              bool relocation,
                              hwaddr *raddr, int *psizep, int *protp,
-                             bool cause_excp)
+                             bool guest_visible)
 {
     CPUPPCState *env = &cpu->env;
     uint64_t lpid, pid;
@@ -447,7 +450,7 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
 
     /* Virtual Mode Access - get the fully qualified address */
     if (!ppc_radix64_get_fully_qualified_addr(&cpu->env, eaddr, &lpid, &pid)) {
-        if (cause_excp) {
+        if (guest_visible) {
             ppc_radix64_raise_segi(cpu, rwx, eaddr);
         }
         return 1;
@@ -460,13 +463,13 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
         vhc->get_pate(cpu->vhyp, &pate);
     } else {
         if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
-            if (cause_excp) {
+            if (guest_visible) {
                 ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
             }
             return 1;
         }
         if (!validate_pate(cpu, lpid, &pate)) {
-            if (cause_excp) {
+            if (guest_visible) {
                 ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_R_BADCONFIG);
             }
             return 1;
@@ -487,7 +490,7 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
     if (relocation) {
         int ret = ppc_radix64_process_scoped_xlate(cpu, rwx, eaddr, pid,
                                                    pate, &g_raddr, &prot,
-                                                   &psize, cause_excp);
+                                                   &psize, guest_visible);
         if (ret) {
             return ret;
         }
@@ -510,7 +513,7 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
 
             ret = ppc_radix64_partition_scoped_xlate(cpu, rwx, eaddr, g_raddr,
                                                      pate, raddr, &prot, &psize,
-                                                     0, cause_excp);
+                                                     0, guest_visible);
             if (ret) {
                 return ret;
             }
-- 
2.26.2


