Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777E0C3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 11:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BDB02146E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 11:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BDB02146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9SWE-0007Om-CU
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 06:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j9SQz-0006EQ-77
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:43:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j9SQx-0007gb-UC
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:43:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19012
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j9SQx-0007gS-PO
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:43:27 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 024BdIW8028618
 for <qemu-devel@nongnu.org>; Wed, 4 Mar 2020 06:43:27 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yhs0u07rb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 06:43:27 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 4 Mar 2020 11:43:24 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 4 Mar 2020 11:43:23 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 024BhMG954984850
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2020 11:43:22 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0331242041;
 Wed,  4 Mar 2020 11:43:22 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F4F342042;
 Wed,  4 Mar 2020 11:43:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.152.224.55])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  4 Mar 2020 11:43:21 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 14/18] s390x: protvirt: Move IO control structures over SIDA
Date: Wed,  4 Mar 2020 06:42:27 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304114231.23493-1-frankja@linux.ibm.com>
References: <20200304114231.23493-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030411-0016-0000-0000-000002ED13AC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030411-0017-0000-0000-000033506089
Message-Id: <20200304114231.23493-15-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-04_01:2020-03-04,
 2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=1
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 mlxlogscore=760 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040090
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For protected guests, we need to put the IO emulation results into the
SIDA, so SIE will write them into the guest at the next entry.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 target/s390x/ioinst.c | 87 ++++++++++++++++++++++++++++++-------------
 1 file changed, 61 insertions(+), 26 deletions(-)

diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index e4102430aa..330b04d79a 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -129,9 +129,13 @@ void ioinst_handle_msch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
     }
-    if (s390_cpu_virt_mem_read(cpu, addr, ar, &schib, sizeof(schib))) {
-        s390_cpu_virt_mem_handle_exc(cpu, ra);
-        return;
+    if (env->pv) {
+        s390_cpu_pv_mem_read(cpu, addr, &schib, sizeof(schib));
+    } else {
+        if (s390_cpu_virt_mem_read(cpu, addr, ar, &schib, sizeof(schib))) {
+            s390_cpu_virt_mem_handle_exc(cpu, ra);
+            return;
+        }
     }
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid) ||
         !ioinst_schib_valid(&schib)) {
@@ -186,9 +190,13 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
     }
-    if (s390_cpu_virt_mem_read(cpu, addr, ar, &orig_orb, sizeof(orb))) {
-        s390_cpu_virt_mem_handle_exc(cpu, ra);
-        return;
+    if (env->pv) {
+        s390_cpu_pv_mem_read(cpu, addr, &orig_orb, sizeof(orb));
+    } else {
+        if (s390_cpu_virt_mem_read(cpu, addr, ar, &orig_orb, sizeof(orb))) {
+            s390_cpu_virt_mem_handle_exc(cpu, ra);
+            return;
+        }
     }
     copy_orb_from_guest(&orb, &orig_orb);
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid) ||
@@ -222,14 +230,19 @@ void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
     cc = css_do_stcrw(&crw);
     /* 0 - crw stored, 1 - zeroes stored */
 
-    if (s390_cpu_virt_mem_write(cpu, addr, ar, &crw, sizeof(crw)) == 0) {
+    if (env->pv) {
+        s390_cpu_pv_mem_write(cpu, addr, &crw, sizeof(crw));
         setcc(cpu, cc);
     } else {
-        if (cc == 0) {
-            /* Write failed: requeue CRW since STCRW is suppressing */
-            css_undo_stcrw(&crw);
+        if (s390_cpu_virt_mem_write(cpu, addr, ar, &crw, sizeof(crw)) == 0) {
+            setcc(cpu, cc);
+        } else {
+            if (cc == 0) {
+                /* Write failed: requeue CRW since STCRW is suppressing */
+                css_undo_stcrw(&crw);
+            }
+            s390_cpu_virt_mem_handle_exc(cpu, ra);
         }
-        s390_cpu_virt_mem_handle_exc(cpu, ra);
     }
 }
 
@@ -251,6 +264,9 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb,
     }
 
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
+        if (env->pv) {
+            return;
+        }
         /*
          * As operand exceptions have a lower priority than access exceptions,
          * we check whether the memory area is writeable (injecting the
@@ -283,14 +299,19 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb,
         }
     }
     if (cc != 3) {
-        if (s390_cpu_virt_mem_write(cpu, addr, ar, &schib,
-                                    sizeof(schib)) != 0) {
-            s390_cpu_virt_mem_handle_exc(cpu, ra);
-            return;
+        if (env->pv) {
+            s390_cpu_pv_mem_write(cpu, addr, &schib, sizeof(schib));
+        } else {
+            if (s390_cpu_virt_mem_write(cpu, addr, ar, &schib,
+                                        sizeof(schib)) != 0) {
+                s390_cpu_virt_mem_handle_exc(cpu, ra);
+                return;
+            }
         }
     } else {
         /* Access exceptions have a higher priority than cc3 */
-        if (s390_cpu_virt_mem_check_write(cpu, addr, ar, sizeof(schib)) != 0) {
+        if (!env->pv &&
+            s390_cpu_virt_mem_check_write(cpu, addr, ar, sizeof(schib)) != 0) {
             s390_cpu_virt_mem_handle_exc(cpu, ra);
             return;
         }
@@ -327,15 +348,20 @@ int ioinst_handle_tsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
     }
     /* 0 - status pending, 1 - not status pending, 3 - not operational */
     if (cc != 3) {
-        if (s390_cpu_virt_mem_write(cpu, addr, ar, &irb, irb_len) != 0) {
-            s390_cpu_virt_mem_handle_exc(cpu, ra);
-            return -EFAULT;
+        if (env->pv) {
+            s390_cpu_pv_mem_write(cpu, addr, &irb, irb_len);
+        } else {
+            if (s390_cpu_virt_mem_write(cpu, addr, ar, &irb, irb_len) != 0) {
+                s390_cpu_virt_mem_handle_exc(cpu, ra);
+                return -EFAULT;
+            }
         }
         css_do_tsch_update_subch(sch);
     } else {
         irb_len = sizeof(irb) - sizeof(irb.emw);
         /* Access exceptions have a higher priority than cc3 */
-        if (s390_cpu_virt_mem_check_write(cpu, addr, ar, irb_len) != 0) {
+        if (!env->pv &&
+            s390_cpu_virt_mem_check_write(cpu, addr, ar, irb_len) != 0) {
             s390_cpu_virt_mem_handle_exc(cpu, ra);
             return -EFAULT;
         }
@@ -633,9 +659,13 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
      * present CHSC sub-handlers ... if we ever need more, we should take
      * care of req->len here first.
      */
-    if (s390_cpu_virt_mem_read(cpu, addr, reg, buf, sizeof(ChscReq))) {
-        s390_cpu_virt_mem_handle_exc(cpu, ra);
-        return;
+    if (env->pv) {
+        s390_cpu_pv_mem_read(cpu, addr, buf, sizeof(ChscReq));
+    } else {
+        if (s390_cpu_virt_mem_read(cpu, addr, reg, buf, sizeof(ChscReq))) {
+            s390_cpu_virt_mem_handle_exc(cpu, ra);
+            return;
+        }
     }
     req = (ChscReq *)buf;
     len = be16_to_cpu(req->len);
@@ -666,11 +696,16 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
         break;
     }
 
-    if (!s390_cpu_virt_mem_write(cpu, addr + len, reg, res,
-                                 be16_to_cpu(res->len))) {
+    if (env->pv) {
+        s390_cpu_pv_mem_write(cpu, addr + len, res, be16_to_cpu(res->len));
         setcc(cpu, 0);    /* Command execution complete */
     } else {
-        s390_cpu_virt_mem_handle_exc(cpu, ra);
+        if (!s390_cpu_virt_mem_write(cpu, addr + len, reg, res,
+                                     be16_to_cpu(res->len))) {
+            setcc(cpu, 0);    /* Command execution complete */
+        } else {
+            s390_cpu_virt_mem_handle_exc(cpu, ra);
+        }
     }
 }
 
-- 
2.20.1


