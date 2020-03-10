Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF06C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:45:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1943D24649
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1943D24649
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBfCC-00075s-Ob
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 09:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jBf9T-0002XZ-Rk
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jBf9R-0007qR-UI
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:42:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60746)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jBf9P-0007km-Vu
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:42:28 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02ADgLA8026044
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 09:42:25 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ym8n8mgv4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 09:42:23 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Tue, 10 Mar 2020 13:42:18 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 10 Mar 2020 13:42:16 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02ADgFAw52297906
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 13:42:15 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0431711C050;
 Tue, 10 Mar 2020 13:42:15 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA39311C04A;
 Tue, 10 Mar 2020 13:42:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.23.214])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2020 13:42:13 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 11/15] s390x: protvirt: Disable address checks for PV guest
 IO emulation
Date: Tue, 10 Mar 2020 09:40:04 -0400
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200310134008.130038-1-frankja@linux.ibm.com>
References: <20200310134008.130038-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031013-0028-0000-0000-000003E2B9AA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031013-0029-0000-0000-000024A7FAB0
Message-Id: <20200310134008.130038-12-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-10_07:2020-03-10,
 2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 mlxlogscore=752 mlxscore=0 suspectscore=1 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100090
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
 target/s390x/ioinst.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index c437a1d8c6..34afd2ee64 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -17,6 +17,22 @@
 #include "trace.h"
 #include "hw/s390x/s390-pci-bus.h"
 
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
+
 int ioinst_disassemble_sch_ident(uint32_t value, int *m, int *cssid, int *ssid,
                                  int *schid)
 {
@@ -114,7 +130,7 @@ void ioinst_handle_msch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
     CPUS390XState *env = &cpu->env;
     uint8_t ar;
 
-    addr = decode_basedisp_s(env, ipb, &ar);
+    addr = get_address_from_regs(env, ipb, &ar);
     if (addr & 3) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
@@ -171,7 +187,7 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
     CPUS390XState *env = &cpu->env;
     uint8_t ar;
 
-    addr = decode_basedisp_s(env, ipb, &ar);
+    addr = get_address_from_regs(env, ipb, &ar);
     if (addr & 3) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
@@ -203,7 +219,7 @@ void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
     CPUS390XState *env = &cpu->env;
     uint8_t ar;
 
-    addr = decode_basedisp_s(env, ipb, &ar);
+    addr = get_address_from_regs(env, ipb, &ar);
     if (addr & 3) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
@@ -234,7 +250,7 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb,
     CPUS390XState *env = &cpu->env;
     uint8_t ar;
 
-    addr = decode_basedisp_s(env, ipb, &ar);
+    addr = get_address_from_regs(env, ipb, &ar);
     if (addr & 3) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
@@ -303,7 +319,7 @@ int ioinst_handle_tsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
         return -EIO;
     }
     trace_ioinst_sch_id("tsch", cssid, ssid, schid);
-    addr = decode_basedisp_s(env, ipb, &ar);
+    addr = get_address_from_regs(env, ipb, &ar);
     if (addr & 3) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return -EIO;
@@ -601,7 +617,7 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
 {
     ChscReq *req;
     ChscResp *res;
-    uint64_t addr;
+    uint64_t addr = 0;
     int reg;
     uint16_t len;
     uint16_t command;
@@ -610,7 +626,9 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
 
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
2.20.1


