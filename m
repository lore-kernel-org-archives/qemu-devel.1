Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64FFC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:40:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEF62217AB
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF62217AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iadgz-0005Fu-EE
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 05:40:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iactp-0003IZ-7h
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:49:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iacto-0005TQ-2T
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:49:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42230)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iactm-0005Pg-3I
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:49:15 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAT9n04K164781
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 04:49:12 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wjar9f7k9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 04:49:06 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 29 Nov 2019 09:48:48 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 29 Nov 2019 09:48:45 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAT9mhE555509240
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Nov 2019 09:48:43 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ABD97A4040;
 Fri, 29 Nov 2019 09:48:43 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E3D0A404D;
 Fri, 29 Nov 2019 09:48:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.188.128])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 29 Nov 2019 09:48:41 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/13] s390x: protvirt: Move diag 308 data over SIDAD
Date: Fri, 29 Nov 2019 04:48:07 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191129094809.26684-1-frankja@linux.ibm.com>
References: <20191129094809.26684-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112909-4275-0000-0000-00000387EFCF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112909-4276-0000-0000-0000389B8457
Message-Id: <20191129094809.26684-12-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-29_02:2019-11-29,2019-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 phishscore=0 impostorscore=0 clxscore=1015 suspectscore=1 mlxlogscore=809
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911290086
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

For protected guests the IPIB is written/read to/from the satellite
block, so we need to make those accesses virtual to make them go
through KVM mem ops.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 target/s390x/diag.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 5489fc721a..6d78759151 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -88,6 +88,7 @@ static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
 void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
     CPUState *cs = env_cpu(env);
+    S390CPU *cpu = S390_CPU(cs);
     uint64_t addr =  env->regs[r1];
     uint64_t subcode = env->regs[r3];
     IplParameterBlock *iplb;
@@ -118,14 +119,27 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
         if (diag308_parm_check(env, r1, addr, ra, false)) {
             return;
         }
+
         iplb = g_new0(IplParameterBlock, 1);
-        cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
+        if (!env->pv) {
+            cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
+        } else {
+            s390_cpu_virt_mem_read(cpu, 0, 0, iplb, sizeof(iplb->len));
+            s390_cpu_virt_mem_handle_exc(cpu, ra);
+        }
+
         if (!iplb_valid_len(iplb)) {
             env->regs[r1 + 1] = DIAG_308_RC_INVALID;
             goto out;
         }
 
-        cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
+        if (!env->pv) {
+            cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
+        } else {
+            s390_cpu_virt_mem_read(cpu, 0, 0, iplb, be32_to_cpu(iplb->len));
+            s390_cpu_virt_mem_handle_exc(cpu, ra);
+        }
+
 
         if (!iplb_valid_ccw(iplb) && !iplb_valid_fcp(iplb) &&
             !(iplb_valid_se(iplb) && s390_ipl_pv_check_comp(iplb) >= 0)) {
@@ -149,7 +163,13 @@ out:
             iplb = s390_ipl_get_iplb();
         }
         if (iplb) {
-            cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->len));
+            if (!env->pv) {
+                cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->len));
+            } else {
+                s390_cpu_virt_mem_write(cpu, 0, 0, iplb,
+                                        be32_to_cpu(iplb->len));
+                s390_cpu_virt_mem_handle_exc(cpu, ra);
+            }
             env->regs[r1 + 1] = DIAG_308_RC_OK;
         } else {
             env->regs[r1 + 1] = DIAG_308_RC_NO_CONF;
-- 
2.20.1


