Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15A7C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:30:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B228720663
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B228720663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWkLz-0004fO-Tz
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1jWkJM-0000LX-HJ; Thu, 07 May 2020 13:27:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6050
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1jWkJL-0007Qp-PS; Thu, 07 May 2020 13:27:52 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 047H1Jvx160249; Thu, 7 May 2020 13:27:39 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 30s2g5j4cv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 May 2020 13:27:39 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 047HPYCb025012;
 Thu, 7 May 2020 17:27:37 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma05fra.de.ibm.com with ESMTP id 30s0g5ms7t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 May 2020 17:27:36 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 047HRYLL60489796
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 7 May 2020 17:27:34 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 558A9AE093;
 Thu,  7 May 2020 17:27:34 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C91F8AE05D;
 Thu,  7 May 2020 17:27:15 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.160.63])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  7 May 2020 17:27:15 +0000 (GMT)
Subject: [PATCH 6/6] target/ppc: Don't update radix PTE R/C bits with gdbstub
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 07 May 2020 19:27:15 +0200
Message-ID: <158887243487.1564424.7276382177976503972.stgit@bahia.lan>
In-Reply-To: <158887239173.1564424.16721638327458334129.stgit@bahia.lan>
References: <158887239173.1564424.16721638327458334129.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-07_10:2020-05-07,
 2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=912 clxscore=1034
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070135
Received-SPF: softfail client-ip=148.163.158.5; envelope-from=groug@kaod.org;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 12:11:34
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
translation. While here drop a not very useful comment.

This was found while reading the code. I could verify that this affects
both powernv and pseries, but I failed to observe any actual bug.

Fixes: d04ea940c597 "target/ppc: Add support for Radix partition-scoped translation"
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/mmu-radix64.c |   36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index ceeb3dfe2d49..bc51cd89a079 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -270,7 +270,8 @@ static int ppc_radix64_partition_scoped_xlate(PowerPCCPU *cpu, int rwx,
                                               ppc_v3_pate_t pate,
                                               hwaddr *h_raddr, int *h_prot,
                                               int *h_page_size, bool pde_addr,
-                                              bool cause_excp)
+                                              bool cause_excp,
+                                              bool cause_rc_update)
 {
     int fault_cause = 0;
     hwaddr pte_addr;
@@ -291,8 +292,9 @@ static int ppc_radix64_partition_scoped_xlate(PowerPCCPU *cpu, int rwx,
         return 1;
     }
 
-    /* Update Reference and Change Bits */
-    ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, h_prot);
+    if (cause_rc_update) {
+        ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, h_prot);
+    }
 
     return 0;
 }
@@ -301,7 +303,8 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
                                             vaddr eaddr, uint64_t pid,
                                             ppc_v3_pate_t pate, hwaddr *g_raddr,
                                             int *g_prot, int *g_page_size,
-                                            bool cause_excp)
+                                            bool cause_excp,
+                                            bool cause_rc_update)
 {
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
@@ -336,7 +339,8 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
         ret = ppc_radix64_partition_scoped_xlate(cpu, 0, eaddr, prtbe_addr,
                                                  pate, &h_raddr, &h_prot,
                                                  &h_page_size, true,
-                                                 cause_excp);
+                                                 cause_excp,
+                                                 cause_rc_update);
         if (ret) {
             return ret;
         }
@@ -376,7 +380,8 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
             ret = ppc_radix64_partition_scoped_xlate(cpu, 0, eaddr, pte_addr,
                                                      pate, &h_raddr, &h_prot,
                                                      &h_page_size, true,
-                                                     cause_excp);
+                                                     cause_excp,
+                                                     cause_rc_update);
             if (ret) {
                 return ret;
             }
@@ -408,7 +413,9 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
         return 1;
     }
 
-    ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, g_prot);
+    if (cause_rc_update) {
+        ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, g_prot);
+    }
 
     return 0;
 }
@@ -433,7 +440,8 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
 static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
                              bool relocation,
                              hwaddr *raddr, int *psizep, int *protp,
-                             bool cause_excp)
+                             bool cause_excp,
+                             bool cause_rc_update)
 {
     CPUPPCState *env = &cpu->env;
     uint64_t lpid, pid;
@@ -483,7 +491,9 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
     if (relocation) {
         int ret = ppc_radix64_process_scoped_xlate(cpu, rwx, eaddr, pid,
                                                    pate, &g_raddr, &prot,
-                                                   &psize, cause_excp);
+                                                   &psize,
+                                                   cause_excp,
+                                                   cause_rc_update);
         if (ret) {
             return ret;
         }
@@ -506,7 +516,9 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
 
             ret = ppc_radix64_partition_scoped_xlate(cpu, rwx, eaddr, g_raddr,
                                                      pate, raddr, &prot, &psize,
-                                                     0, cause_excp);
+                                                     0,
+                                                     cause_excp,
+                                                     cause_rc_update);
             if (ret) {
                 return ret;
             }
@@ -562,7 +574,7 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
 
     /* Translate eaddr to raddr (where raddr is addr qemu needs for access) */
     if (ppc_radix64_xlate(cpu, eaddr, rwx, relocation, &raddr,
-                          &page_size, &prot, true)) {
+                          &page_size, &prot, true, true)) {
         return 1;
     }
 
@@ -584,7 +596,7 @@ hwaddr ppc_radix64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong eaddr)
     }
 
     if (ppc_radix64_xlate(cpu, eaddr, 0, msr_dr, &raddr, &psize,
-                          &prot, false)) {
+                          &prot, false, false)) {
         return -1;
     }
 


