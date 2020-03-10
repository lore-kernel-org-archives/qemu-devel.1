Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A9DC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:49:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CD3C20637
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD3C20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBfGY-0006rG-QG
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 09:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jBf9d-0002mR-FW
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jBf9c-0008GI-3f
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:42:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24032)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jBf9b-0008Dz-R2
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:42:40 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02ADga8P019076
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 09:42:39 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ynraspkr4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 09:42:38 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Tue, 10 Mar 2020 13:42:13 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 10 Mar 2020 13:42:11 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02ADgA5i59965618
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 13:42:10 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5500911C04A;
 Tue, 10 Mar 2020 13:42:10 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1731811C04C;
 Tue, 10 Mar 2020 13:42:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.23.214])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2020 13:42:08 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 08/15] s390x: protvirt: SCLP interpretation
Date: Tue, 10 Mar 2020 09:40:01 -0400
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200310134008.130038-1-frankja@linux.ibm.com>
References: <20200310134008.130038-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031013-0016-0000-0000-000002EF054E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031013-0017-0000-0000-00003352696E
Message-Id: <20200310134008.130038-9-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-10_07:2020-03-10,
 2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 mlxlogscore=842 bulkscore=0
 suspectscore=1 clxscore=1015 malwarescore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100091
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

SCLP for a protected guest is done over the SIDAD, so we need to use
the s390_cpu_pv_mem_* functions to access the SIDAD instead of guest
memory when reading/writing SCBs.

To not confuse the sclp emulation, we set 0x4000 as the SCCB address,
since the function that injects the sclp external interrupt would
reject a zero sccb address.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/sclp.c         | 30 ++++++++++++++++++++++++++++++
 include/hw/s390x/sclp.h |  2 ++
 target/s390x/kvm.c      | 24 +++++++++++++++++++-----
 3 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index af0bfbc2ec..5f3aa30d62 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -193,6 +193,36 @@ static void sclp_execute(SCLPDevice *sclp, SCCB *sccb, uint32_t code)
     }
 }
 
+/*
+ * We only need the address to have something valid for the
+ * service_interrupt call.
+ */
+#define SCLP_PV_DUMMY_ADDR 0x4000
+int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
+                                uint32_t code)
+{
+    SCLPDevice *sclp = get_sclp_device();
+    SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
+    SCCB work_sccb;
+    hwaddr sccb_len = sizeof(SCCB);
+
+    /*
+     * Only a very limited amount of calls is permitted by the
+     * Ultravisor and we support all of them, so we don't check for
+     * them. All other specification exceptions are also interpreted
+     * by the Ultravisor and hence never cause an exit we need to
+     * handle.
+     *
+     * Setting the CC is also done by the Ultravisor.
+     */
+    s390_cpu_pv_mem_read(env_archcpu(env), 0, &work_sccb, sccb_len);
+    sclp_c->execute(sclp, &work_sccb, code);
+    s390_cpu_pv_mem_write(env_archcpu(env), 0, &work_sccb,
+                          be16_to_cpu(work_sccb.h.length));
+    sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
+    return 0;
+}
+
 int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
 {
     SCLPDevice *sclp = get_sclp_device();
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index c54413b78c..c0a3faa37d 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -217,5 +217,7 @@ void s390_sclp_init(void);
 void sclp_service_interrupt(uint32_t sccb);
 void raise_irq_cpu_hotplug(void);
 int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
+int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
+                                uint32_t code);
 
 #endif
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index e85ede3770..e92e0d5943 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1226,12 +1226,26 @@ static void kvm_sclp_service_call(S390CPU *cpu, struct kvm_run *run,
     sccb = env->regs[ipbh0 & 0xf];
     code = env->regs[(ipbh0 & 0xf0) >> 4];
 
-    r = sclp_service_call(env, sccb, code);
-    if (r < 0) {
-        kvm_s390_program_interrupt(cpu, -r);
-        return;
+    switch (run->s390_sieic.icptcode) {
+    case ICPT_PV_INSTR_NOTIFICATION:
+        g_assert(s390_is_pv());
+        /* The notification intercepts are currently handled by KVM */
+        error_report("unexpected SCLP PV notification");
+        exit(1);
+        break;
+    case ICPT_PV_INSTR:
+        g_assert(s390_is_pv());
+        sclp_service_call_protected(env, sccb, code);
+        break;
+    case ICPT_INSTRUCTION:
+        g_assert(!s390_is_pv());
+        r = sclp_service_call(env, sccb, code);
+        if (r < 0) {
+            kvm_s390_program_interrupt(cpu, -r);
+            return;
+        }
+        setcc(cpu, r);
     }
-    setcc(cpu, r);
 }
 
 static int handle_b2(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
-- 
2.20.1


