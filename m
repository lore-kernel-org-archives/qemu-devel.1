Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AD8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 23:02:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25F9020675
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 23:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F9020675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ0O5-0005fb-0l
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 19:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1jZ0Jk-0004uC-7m; Wed, 13 May 2020 18:57:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40700
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1jZ0Jj-0007Dp-Cy; Wed, 13 May 2020 18:57:35 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04DMk6cD152212; Wed, 13 May 2020 18:57:24 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 310syt070b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 May 2020 18:57:24 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04DMtZkA013539;
 Wed, 13 May 2020 22:57:22 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma05fra.de.ibm.com with ESMTP id 3100ub0ypc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 May 2020 22:57:22 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 04DMu9u851184110
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 May 2020 22:56:09 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 26C1211C04A;
 Wed, 13 May 2020 22:57:20 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E053311C052;
 Wed, 13 May 2020 22:57:19 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.63.64])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 13 May 2020 22:57:19 +0000 (GMT)
Subject: [PATCH v2 6/6] target/ppc: Don't update radix PTE R/C bits with
 gdbstub
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 14 May 2020 00:57:19 +0200
Message-ID: <158941063899.240484.2778628492106387793.stgit@bahia.lan>
In-Reply-To: <158941060199.240484.5620994992064687533.stgit@bahia.lan>
References: <158941060199.240484.5620994992064687533.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-13_09:2020-05-13,
 2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 adultscore=0 cotscore=-2147483648 suspectscore=0 clxscore=1034
 malwarescore=0 phishscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005130193
Received-SPF: softfail client-ip=148.163.158.5; envelope-from=groug@kaod.org;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 18:57:00
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_SOFTFAIL=0.665,
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
Cc: qemu-ppc@nongnu.org, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

gdbstub shouldn't silently change guest visible state when doing address
translation. Since the R/C bits can only be updated when handling a MMU
fault, let's reuse the cause_excp flag and rename it to guest_visible.
While here drop a not very useful comment.

This was found while reading the code. I could verify that this affects
both powernv and pseries, but I failed to observe any actual bug.

Fixes: d04ea940c597 "target/ppc: Add support for Radix partition-scoped translation"
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/mmu-radix64.c |   39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 7ce37cb778db..0d3922537c4c 100644
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


