Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663F2C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:32:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A07520873
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A07520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC1T6-0003k7-F2
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 09:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jC1PP-000684-Hn
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jC1PO-0003Uq-8n
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:28:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52648)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jC1PO-0003T4-1X
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:28:26 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02BDOGxe107185
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 09:28:25 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yq05utt9u-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 09:28:22 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 11 Mar 2020 13:22:28 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 11 Mar 2020 13:22:26 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02BDMPsk59244564
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Mar 2020 13:22:25 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 226E952050;
 Wed, 11 Mar 2020 13:22:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.36.208])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C85A352052;
 Wed, 11 Mar 2020 13:22:23 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 11/15] s390x: protvirt: Disable address checks for PV guest
 IO emulation
Date: Wed, 11 Mar 2020 09:21:47 -0400
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311132151.172389-1-frankja@linux.ibm.com>
References: <20200311132151.172389-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031113-0008-0000-0000-0000035B92BC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031113-0009-0000-0000-00004A7CD95D
Message-Id: <20200311132151.172389-12-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-11_05:2020-03-11,
 2020-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=757
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=1 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003110085
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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

IO instruction data is routed through SIDAD for protected guests, so
adresses do not need to be checked, as this is kernel memory.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/ioinst.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index c437a1d8c6afed80..481d789de9e09a04 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -16,6 +16,23 @@
 #include "hw/s390x/ioinst.h"
 #include "trace.h"
 #include "hw/s390x/s390-pci-bus.h"
+#include "hw/s390x/pv.h"
+
+static uint64_t get_address_from_regs(CPUS390XState *env, uint32_t ipb,
+                                      uint8_t *ar)
+{
+    /*
+     * Addresses for protected guests are all offsets into the
+     * satellite block which holds the IO control structures. Those
+     * control structures are always aligned and accessible, so we can
+     * return 0 here which will pass the following address checks.
+     */
+    if (s390_is_pv()) {
+        *ar = 0;
+        return 0;
+    }
+    return decode_basedisp_s(env, ipb, ar);
+}
 
 int ioinst_disassemble_sch_ident(uint32_t value, int *m, int *cssid, int *ssid,
                                  int *schid)
@@ -114,7 +131,7 @@ void ioinst_handle_msch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
     CPUS390XState *env = &cpu->env;
     uint8_t ar;
 
-    addr = decode_basedisp_s(env, ipb, &ar);
+    addr = get_address_from_regs(env, ipb, &ar);
     if (addr & 3) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
@@ -171,7 +188,7 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
     CPUS390XState *env = &cpu->env;
     uint8_t ar;
 
-    addr = decode_basedisp_s(env, ipb, &ar);
+    addr = get_address_from_regs(env, ipb, &ar);
     if (addr & 3) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
@@ -203,7 +220,7 @@ void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
     CPUS390XState *env = &cpu->env;
     uint8_t ar;
 
-    addr = decode_basedisp_s(env, ipb, &ar);
+    addr = get_address_from_regs(env, ipb, &ar);
     if (addr & 3) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
@@ -234,7 +251,7 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb,
     CPUS390XState *env = &cpu->env;
     uint8_t ar;
 
-    addr = decode_basedisp_s(env, ipb, &ar);
+    addr = get_address_from_regs(env, ipb, &ar);
     if (addr & 3) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
@@ -303,7 +320,7 @@ int ioinst_handle_tsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
         return -EIO;
     }
     trace_ioinst_sch_id("tsch", cssid, ssid, schid);
-    addr = decode_basedisp_s(env, ipb, &ar);
+    addr = get_address_from_regs(env, ipb, &ar);
     if (addr & 3) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return -EIO;
@@ -601,7 +618,7 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
 {
     ChscReq *req;
     ChscResp *res;
-    uint64_t addr;
+    uint64_t addr = 0;
     int reg;
     uint16_t len;
     uint16_t command;
@@ -610,7 +627,9 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
 
     trace_ioinst("chsc");
     reg = (ipb >> 20) & 0x00f;
-    addr = env->regs[reg];
+    if (!s390_is_pv()) {
+        addr = env->regs[reg];
+    }
     /* Page boundary? */
     if (addr & 0xfff) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
-- 
2.25.1


