Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF38C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 10:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3F3621741
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 10:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F3621741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaGrp-0000Gq-3b
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 05:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmorel@linux.ibm.com>) id 1iaGnc-0007Mb-Kz
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 05:13:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmorel@linux.ibm.com>) id 1iaGnZ-0007oE-4b
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 05:13:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52904)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
 id 1iaGnY-0007l1-RQ
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 05:13:21 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xASACGtT050119
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 05:13:19 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wjah6br9d-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 05:13:17 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
 Thu, 28 Nov 2019 10:13:10 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 28 Nov 2019 10:13:08 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xASAD6EF29819034
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Nov 2019 10:13:06 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 873764C04A;
 Thu, 28 Nov 2019 10:13:06 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CB4E4C040;
 Thu, 28 Nov 2019 10:13:06 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.145.185.119])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 28 Nov 2019 10:13:05 +0000 (GMT)
From: Pierre Morel <pmorel@linux.ibm.com>
To: qemu-s390x@nongnu.org
Subject: [PATCH v1 1/1] s390x: protvirt: SCLP interpretation
Date: Thu, 28 Nov 2019 11:13:04 +0100
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574935984-16910-1-git-send-email-pmorel@linux.ibm.com>
References: <1574935984-16910-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19112810-0008-0000-0000-000003395244
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112810-0009-0000-0000-00004A585DE0
Message-Id: <1574935984-16910-2-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_01:2019-11-28,2019-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0
 mlxscore=0 suspectscore=1 impostorscore=0 clxscore=1015 bulkscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=780 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911280088
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, david@redhat.com,
 cohuck@redhat.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com,
 mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The SCLP protection handle some of the exceptions due to
mis-constructions of the SCLP Control Block (SCCB) by the guest and
provides notifications to the host when something gets wrong.
We currently do not handle these exceptions, letting all the work to the
firmware therefor, we only need to inject an external interrupt to the
guest.

When the SCCB is correct, the S390x virtualisation protection copies
the SCLP Control Block (SCCB) from the guest inside the kernel to avoid
opening a direct access to the guest memory.
When accessing the kernel memory with standard s390_cpu_virt_mem_*
functions the host opens access to the SCCB shadow at address 0.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 hw/s390x/sclp.c         | 18 +++++++++++++
 include/hw/s390x/sclp.h |  2 ++
 target/s390x/kvm.c      | 56 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index f57ce7b739..02e4e0146f 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -193,6 +193,24 @@ static void sclp_execute(SCLPDevice *sclp, SCCB *sccb, uint32_t code)
     }
 }
 
+int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
+                                uint32_t code)
+{
+    SCLPDevice *sclp = get_sclp_device();
+    SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
+    SCCB work_sccb;
+    hwaddr sccb_len = sizeof(SCCB);
+
+    /* Protected guest SCCB is always seen at address 0 */
+    s390_cpu_virt_mem_read(env_archcpu(env), 0, 0, &work_sccb, sccb_len);
+    sclp_c->execute(sclp, &work_sccb, code);
+    s390_cpu_virt_mem_write(env_archcpu(env), 0, 0, &work_sccb,
+                            be16_to_cpu(work_sccb.h.length));
+
+    sclp_c->service_interrupt(sclp, (uint64_t)&work_sccb);
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
index 0c9d14b4b1..559f470f51 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1170,7 +1170,14 @@ static int kvm_sclp_service_call(S390CPU *cpu, struct kvm_run *run,
     sccb = env->regs[ipbh0 & 0xf];
     code = env->regs[(ipbh0 & 0xf0) >> 4];
 
-    r = sclp_service_call(env, sccb, code);
+    switch (run->s390_sieic.icptcode) {
+    case ICPT_PV_INSTR:
+        r = sclp_service_call_protected(env, sccb, code);
+        break;
+    default:
+        r = sclp_service_call(env, sccb, code);
+        break;
+    }
     if (r < 0) {
         kvm_s390_program_interrupt(cpu, -r);
     } else {
@@ -1575,6 +1582,47 @@ static int kvm_s390_handle_sigp(S390CPU *cpu, uint8_t ipa1, uint32_t ipb)
     return 0;
 }
 
+static int handle_secure_notification(S390CPU *cpu, struct kvm_run *run)
+{
+    unsigned int ipa0 = (run->s390_sieic.ipa & 0xff00);
+    uint8_t ipa1 = run->s390_sieic.ipa & 0x00ff;
+
+    switch (ipa0) {
+    case IPA0_SIGP: /* We get the notification that the guest stop */
+        kvm_s390_handle_sigp(cpu, ipa1, run->s390_sieic.ipb);
+        break;
+    case IPA0_B2: /* We accept but do nothing for B2 notifications */
+        break;
+    default: /* We do not expect other instruction's notification */
+        kvm_s390_program_interrupt(cpu, PGM_OPERATION);
+        break;
+    }
+    return 0;
+}
+
+static int handle_secure_instruction(S390CPU *cpu, struct kvm_run *run)
+{
+    unsigned int ipa0 = (run->s390_sieic.ipa & 0xff00);
+    uint8_t ipa1 = run->s390_sieic.ipa & 0x00ff;
+    int r = -1;
+
+    switch (ipa0) {
+    case IPA0_B2:
+        r = handle_b2(cpu, run, ipa1);
+        break;
+    case IPA0_DIAG:
+        r = handle_diag(cpu, run, run->s390_sieic.ipb);
+        break;
+    }
+
+    if (r < 0) {
+        r = 0;
+        kvm_s390_program_interrupt(cpu, PGM_OPERATION);
+    }
+
+    return r;
+}
+
 static int handle_instruction(S390CPU *cpu, struct kvm_run *run)
 {
     unsigned int ipa0 = (run->s390_sieic.ipa & 0xff00);
@@ -1665,6 +1713,12 @@ static int handle_intercept(S390CPU *cpu)
     DPRINTF("intercept: 0x%x (at 0x%lx)\n", icpt_code,
             (long)cs->kvm_run->psw_addr);
     switch (icpt_code) {
+         case ICPT_PV_INSTR_NOT:
+            r = handle_secure_notification(cpu, run);
+            break;
+        case ICPT_PV_INSTR:
+            r = handle_secure_instruction(cpu, run);
+            break;
         case ICPT_INSTRUCTION:
             r = handle_instruction(cpu, run);
             break;
-- 
2.17.0


