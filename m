Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02341C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:46:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D01E120637
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01E120637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBfDE-0000Ks-Vl
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 09:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jBfBs-0006xt-ON
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:45:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jBfBr-0005GU-It
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:45:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6954)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jBfBr-0005D6-Bs
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:44:59 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02ADiqdH023047
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 09:44:58 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ynraxps7a-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 09:44:54 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Tue, 10 Mar 2020 13:42:16 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 10 Mar 2020 13:42:14 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 02ADfD0g49021288
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 13:41:14 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5873E11C052;
 Tue, 10 Mar 2020 13:42:13 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2FB0311C050;
 Tue, 10 Mar 2020 13:42:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.23.214])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2020 13:42:11 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 10/15] s390x: protvirt: Move diag 308 data over SIDA
Date: Tue, 10 Mar 2020 09:40:03 -0400
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200310134008.130038-1-frankja@linux.ibm.com>
References: <20200310134008.130038-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031013-0020-0000-0000-000003B25549
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031013-0021-0000-0000-0000220AA145
Message-Id: <20200310134008.130038-11-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-10_07:2020-03-10,
 2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0
 malwarescore=0 mlxlogscore=896 lowpriorityscore=0 bulkscore=0 mlxscore=0
 phishscore=0 impostorscore=0 suspectscore=1 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100092
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

For protected guests the IPIB is written/read to/from the SIDA, so we
need those accesses to go through s390_cpu_pv_mem_read/write().

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 target/s390x/diag.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 02918b37b8..417c4b53ab 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -87,6 +87,7 @@ static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
 void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
     CPUState *cs = env_cpu(env);
+    S390CPU *cpu = S390_CPU(cs);
     uint64_t addr =  env->regs[r1];
     uint64_t subcode = env->regs[r3];
     IplParameterBlock *iplb;
@@ -123,13 +124,22 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
             return;
         }
         iplb = g_new0(IplParameterBlock, 1);
-        cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
+        if (!s390_is_pv()) {
+            cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
+        } else {
+            s390_cpu_pv_mem_read(cpu, 0, iplb, sizeof(iplb->len));
+        }
+
         if (!iplb_valid_len(iplb)) {
             env->regs[r1 + 1] = DIAG_308_RC_INVALID;
             goto out;
         }
 
-        cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
+        if (!s390_is_pv()) {
+            cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
+        } else {
+            s390_cpu_pv_mem_read(cpu, 0, iplb, be32_to_cpu(iplb->len));
+        }
 
         if (!iplb_valid(iplb)) {
             env->regs[r1 + 1] = DIAG_308_RC_INVALID;
@@ -151,12 +161,17 @@ out:
         } else {
             iplb = s390_ipl_get_iplb();
         }
-        if (iplb) {
-            cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->len));
-            env->regs[r1 + 1] = DIAG_308_RC_OK;
-        } else {
+        if (!iplb) {
             env->regs[r1 + 1] = DIAG_308_RC_NO_CONF;
+            return;
         }
+
+        if (!s390_is_pv()) {
+            cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->len));
+        } else {
+            s390_cpu_pv_mem_write(cpu, 0, iplb, be32_to_cpu(iplb->len));
+        }
+        env->regs[r1 + 1] = DIAG_308_RC_OK;
         return;
     case DIAG308_PV_START:
         iplb = s390_ipl_get_iplb_pv();
-- 
2.20.1


