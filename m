Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3371EC4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 13:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B3CC208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 13:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B3CC208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEvAD-0001XQ-6t
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 09:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jEv5o-0002t1-Tl
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jEv5i-0001sW-O2
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:20:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11554
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jEv5i-0001dM-J2
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:20:06 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02JD3MA6161372
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 09:19:56 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yu7adbu4e-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 09:19:55 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 19 Mar 2020 13:19:54 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 19 Mar 2020 13:19:50 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 02JDIm5h48103820
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Mar 2020 13:18:49 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E034EA4060;
 Thu, 19 Mar 2020 13:19:49 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C88CA4054;
 Thu, 19 Mar 2020 13:19:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.146.136])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 19 Mar 2020 13:19:48 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 13/16] s390x: protvirt: Move IO control structures over
 SIDA
Date: Thu, 19 Mar 2020 09:19:18 -0400
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200319131921.2367-1-frankja@linux.ibm.com>
References: <20200319131921.2367-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031913-0012-0000-0000-00000393DADB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031913-0013-0000-0000-000021D0C09B
Message-Id: <20200319131921.2367-14-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-19_04:2020-03-19,
 2020-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=1 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=800 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003190057
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
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/ioinst.c | 61 +++++++++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index 8828482eec306a2b..7a14c52c123b842b 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -138,7 +138,9 @@ void ioinst_handle_msch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
     }
-    if (s390_cpu_virt_mem_read(cpu, addr, ar, &schib, sizeof(schib))) {
+    if (s390_is_pv()) {
+        s390_cpu_pv_mem_read(cpu, addr, &schib, sizeof(schib));
+    } else if (s390_cpu_virt_mem_read(cpu, addr, ar, &schib, sizeof(schib))) {
         s390_cpu_virt_mem_handle_exc(cpu, ra);
         return;
     }
@@ -195,7 +197,9 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
     }
-    if (s390_cpu_virt_mem_read(cpu, addr, ar, &orig_orb, sizeof(orb))) {
+    if (s390_is_pv()) {
+        s390_cpu_pv_mem_read(cpu, addr, &orig_orb, sizeof(orb));
+    } else if (s390_cpu_virt_mem_read(cpu, addr, ar, &orig_orb, sizeof(orb))) {
         s390_cpu_virt_mem_handle_exc(cpu, ra);
         return;
     }
@@ -231,14 +235,19 @@ void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
     cc = css_do_stcrw(&crw);
     /* 0 - crw stored, 1 - zeroes stored */
 
-    if (s390_cpu_virt_mem_write(cpu, addr, ar, &crw, sizeof(crw)) == 0) {
+    if (s390_is_pv()) {
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
 
@@ -260,6 +269,13 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb,
     }
 
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
+        /*
+         * The Ultravisor checks schid bit 16 to be one and bits 0-12
+         * to be 0 and injects a operand exception itself.
+         *
+         * Hence we should never end up here.
+         */
+        g_assert(!s390_is_pv());
         /*
          * As operand exceptions have a lower priority than access exceptions,
          * we check whether the memory area is writeable (injecting the
@@ -292,14 +308,17 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb,
         }
     }
     if (cc != 3) {
-        if (s390_cpu_virt_mem_write(cpu, addr, ar, &schib,
-                                    sizeof(schib)) != 0) {
+        if (s390_is_pv()) {
+            s390_cpu_pv_mem_write(cpu, addr, &schib, sizeof(schib));
+        } else if (s390_cpu_virt_mem_write(cpu, addr, ar, &schib,
+                                           sizeof(schib)) != 0) {
             s390_cpu_virt_mem_handle_exc(cpu, ra);
             return;
         }
     } else {
         /* Access exceptions have a higher priority than cc3 */
-        if (s390_cpu_virt_mem_check_write(cpu, addr, ar, sizeof(schib)) != 0) {
+        if (!s390_is_pv() &&
+            s390_cpu_virt_mem_check_write(cpu, addr, ar, sizeof(schib)) != 0) {
             s390_cpu_virt_mem_handle_exc(cpu, ra);
             return;
         }
@@ -336,7 +355,9 @@ int ioinst_handle_tsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
     }
     /* 0 - status pending, 1 - not status pending, 3 - not operational */
     if (cc != 3) {
-        if (s390_cpu_virt_mem_write(cpu, addr, ar, &irb, irb_len) != 0) {
+        if (s390_is_pv()) {
+            s390_cpu_pv_mem_write(cpu, addr, &irb, irb_len);
+        } else if (s390_cpu_virt_mem_write(cpu, addr, ar, &irb, irb_len) != 0) {
             s390_cpu_virt_mem_handle_exc(cpu, ra);
             return -EFAULT;
         }
@@ -344,7 +365,8 @@ int ioinst_handle_tsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
     } else {
         irb_len = sizeof(irb) - sizeof(irb.emw);
         /* Access exceptions have a higher priority than cc3 */
-        if (s390_cpu_virt_mem_check_write(cpu, addr, ar, irb_len) != 0) {
+        if (!s390_is_pv() &&
+            s390_cpu_virt_mem_check_write(cpu, addr, ar, irb_len) != 0) {
             s390_cpu_virt_mem_handle_exc(cpu, ra);
             return -EFAULT;
         }
@@ -642,7 +664,9 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
      * present CHSC sub-handlers ... if we ever need more, we should take
      * care of req->len here first.
      */
-    if (s390_cpu_virt_mem_read(cpu, addr, reg, buf, sizeof(ChscReq))) {
+    if (s390_is_pv()) {
+        s390_cpu_pv_mem_read(cpu, addr, buf, sizeof(ChscReq));
+    } else if (s390_cpu_virt_mem_read(cpu, addr, reg, buf, sizeof(ChscReq))) {
         s390_cpu_virt_mem_handle_exc(cpu, ra);
         return;
     }
@@ -675,11 +699,16 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
         break;
     }
 
-    if (!s390_cpu_virt_mem_write(cpu, addr + len, reg, res,
-                                 be16_to_cpu(res->len))) {
+    if (s390_is_pv()) {
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
2.25.1


