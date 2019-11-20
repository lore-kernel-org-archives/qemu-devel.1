Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AC3C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:00:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C25622419
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C25622419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXOfB-0006TK-6Q
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 07:00:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iXOP7-0003S8-Gx
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:44:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iXOP6-0003iI-5b
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:44:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30426
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iXOP6-0003hI-0s
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:44:12 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAKBhRd6132053
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 06:44:11 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wcf4867jf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 06:44:11 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 20 Nov 2019 11:44:09 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 20 Nov 2019 11:44:07 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAKBi5xL41812022
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Nov 2019 11:44:05 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADE434C046;
 Wed, 20 Nov 2019 11:44:05 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 940BA4C040;
 Wed, 20 Nov 2019 11:44:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.152.224.205])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 20 Nov 2019 11:44:04 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/15] s390x: protvirt: Disable address checks for PV guest IO
 emulation
Date: Wed, 20 Nov 2019 06:43:33 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191120114334.2287-1-frankja@linux.ibm.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112011-0016-0000-0000-000002C9CC58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112011-0017-0000-0000-0000332B8B84
Message-Id: <20191120114334.2287-15-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_03:2019-11-15,2019-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=613
 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=1 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911200107
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

IO instruction data is routed through SIDAD for protected guests, so
adresses do not need to be checked, as this is kernel memory.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 target/s390x/ioinst.c | 46 +++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index c437a1d8c6..d3bd422ddd 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -110,11 +110,13 @@ void ioinst_handle_msch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
     int cssid, ssid, schid, m;
     SubchDev *sch;
     SCHIB schib;
-    uint64_t addr;
+    uint64_t addr = 0;
     CPUS390XState *env = &cpu->env;
-    uint8_t ar;
+    uint8_t ar = 0;
 
-    addr = decode_basedisp_s(env, ipb, &ar);
+    if (!env->pv) {
+        addr = decode_basedisp_s(env, ipb, &ar);
+    }
     if (addr & 3) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
@@ -167,11 +169,13 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
     int cssid, ssid, schid, m;
     SubchDev *sch;
     ORB orig_orb, orb;
-    uint64_t addr;
+    uint64_t addr = 0;
     CPUS390XState *env = &cpu->env;
-    uint8_t ar;
+    uint8_t ar = 0;
 
-    addr = decode_basedisp_s(env, ipb, &ar);
+    if (!env->pv) {
+        addr = decode_basedisp_s(env, ipb, &ar);
+    }
     if (addr & 3) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
@@ -198,12 +202,14 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
 void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
 {
     CRW crw;
-    uint64_t addr;
+    uint64_t addr = 0;
     int cc;
     CPUS390XState *env = &cpu->env;
-    uint8_t ar;
+    uint8_t ar = 0;
 
-    addr = decode_basedisp_s(env, ipb, &ar);
+    if (!env->pv) {
+        addr = decode_basedisp_s(env, ipb, &ar);
+    }
     if (addr & 3) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
@@ -228,13 +234,15 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb,
 {
     int cssid, ssid, schid, m;
     SubchDev *sch;
-    uint64_t addr;
+    uint64_t addr = 0;
     int cc;
     SCHIB schib;
     CPUS390XState *env = &cpu->env;
-    uint8_t ar;
+    uint8_t ar = 0;
 
-    addr = decode_basedisp_s(env, ipb, &ar);
+    if (!env->pv) {
+        addr = decode_basedisp_s(env, ipb, &ar);
+    }
     if (addr & 3) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
@@ -294,16 +302,18 @@ int ioinst_handle_tsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
     int cssid, ssid, schid, m;
     SubchDev *sch;
     IRB irb;
-    uint64_t addr;
+    uint64_t addr = 0;
     int cc, irb_len;
-    uint8_t ar;
+    uint8_t ar = 0;
 
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
         s390_program_interrupt(env, PGM_OPERAND, ra);
         return -EIO;
     }
     trace_ioinst_sch_id("tsch", cssid, ssid, schid);
-    addr = decode_basedisp_s(env, ipb, &ar);
+    if (!env->pv) {
+        addr = decode_basedisp_s(env, ipb, &ar);
+    }
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


