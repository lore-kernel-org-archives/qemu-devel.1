Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5883DC3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 11:53:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E9F520842
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 11:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9F520842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Saj-0006hd-BR
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 06:53:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j9SRa-0007j6-RJ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:44:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j9SRZ-000872-IC
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:44:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64344)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j9SRZ-000834-Aw
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:44:05 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 024BhrDJ101214
 for <qemu-devel@nongnu.org>; Wed, 4 Mar 2020 06:43:54 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yhw6nvvt6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 06:43:54 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 4 Mar 2020 11:43:25 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 4 Mar 2020 11:43:21 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 024BhLJf50069622
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2020 11:43:21 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F05CC42042;
 Wed,  4 Mar 2020 11:43:20 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 42D734203F;
 Wed,  4 Mar 2020 11:43:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.152.224.55])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  4 Mar 2020 11:43:20 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 13/18] s390x: protvirt: Disable address checks for PV guest
 IO emulation
Date: Wed,  4 Mar 2020 06:42:26 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304114231.23493-1-frankja@linux.ibm.com>
References: <20200304114231.23493-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030411-0008-0000-0000-000003593BBF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030411-0009-0000-0000-00004A7A6E71
Message-Id: <20200304114231.23493-14-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-04_03:2020-03-04,
 2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0
 suspectscore=1 adultscore=0 mlxscore=0 mlxlogscore=593 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040090
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
---
 target/s390x/ioinst.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index c437a1d8c6..e4102430aa 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -17,6 +17,16 @@
 #include "trace.h"
 #include "hw/s390x/s390-pci-bus.h"
 
+static uint64_t get_address_from_regs(CPUS390XState *env, uint32_t ipb,
+                                      uint8_t *ar)
+{
+    if (env->pv) {
+        *ar = 0;
+        return 0;
+    }
+    return decode_basedisp_s(env, ipb, ar);
+}
+
 int ioinst_disassemble_sch_ident(uint32_t value, int *m, int *cssid, int *ssid,
                                  int *schid)
 {
@@ -114,7 +124,7 @@ void ioinst_handle_msch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
     CPUS390XState *env = &cpu->env;
     uint8_t ar;
 
-    addr = decode_basedisp_s(env, ipb, &ar);
+    addr = get_address_from_regs(env, ipb, &ar);
     if (addr & 3) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
@@ -171,7 +181,7 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
     CPUS390XState *env = &cpu->env;
     uint8_t ar;
 
-    addr = decode_basedisp_s(env, ipb, &ar);
+    addr = get_address_from_regs(env, ipb, &ar);
     if (addr & 3) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
@@ -203,7 +213,7 @@ void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
     CPUS390XState *env = &cpu->env;
     uint8_t ar;
 
-    addr = decode_basedisp_s(env, ipb, &ar);
+    addr = get_address_from_regs(env, ipb, &ar);
     if (addr & 3) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
@@ -234,7 +244,7 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb,
     CPUS390XState *env = &cpu->env;
     uint8_t ar;
 
-    addr = decode_basedisp_s(env, ipb, &ar);
+    addr = get_address_from_regs(env, ipb, &ar);
     if (addr & 3) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
@@ -303,7 +313,7 @@ int ioinst_handle_tsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
         return -EIO;
     }
     trace_ioinst_sch_id("tsch", cssid, ssid, schid);
-    addr = decode_basedisp_s(env, ipb, &ar);
+    addr = get_address_from_regs(env, ipb, &ar);
     if (addr & 3) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return -EIO;
@@ -601,7 +611,7 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
 {
     ChscReq *req;
     ChscResp *res;
-    uint64_t addr;
+    uint64_t addr = 0;
     int reg;
     uint16_t len;
     uint16_t command;
@@ -610,7 +620,9 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
 
     trace_ioinst("chsc");
     reg = (ipb >> 20) & 0x00f;
-    addr = env->regs[reg];
+    if (!env->pv) {
+        addr = env->regs[reg];
+    }
     /* Page boundary? */
     if (addr & 0xfff) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
-- 
2.20.1


