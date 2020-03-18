Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64664C5ACD6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:36:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210A720773
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210A720773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEZo5-0001AY-6u
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 10:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jEZjD-0002mD-72
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:31:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jEZjA-0001cc-Dk
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:31:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57399
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jEZjA-0001ay-3z
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:31:24 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02IE78c8136080
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 10:31:23 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yukx5kjgy-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 10:31:23 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 18 Mar 2020 14:31:21 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 18 Mar 2020 14:31:19 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02IEVJ5944433620
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Mar 2020 14:31:19 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E87F142045;
 Wed, 18 Mar 2020 14:31:18 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC8B242049;
 Wed, 18 Mar 2020 14:31:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.78.199])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 18 Mar 2020 14:31:17 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 09/16] s390x: protvirt: SCLP interpretation
Date: Wed, 18 Mar 2020 10:30:40 -0400
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200318143047.2335-1-frankja@linux.ibm.com>
References: <20200318143047.2335-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031814-4275-0000-0000-000003AE7993
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031814-4276-0000-0000-000038C3A582
Message-Id: <20200318143047.2335-10-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-18_06:2020-03-18,
 2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=1 mlxlogscore=999 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003180067
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

SCLP for a protected guest is done over the SIDAD, so we need to use
the s390_cpu_pv_mem_* functions to access the SIDAD instead of guest
memory when reading/writing SCBs.

To not confuse the sclp emulation, we set 0x4000 as the SCCB address,
since the function that injects the sclp external interrupt would
reject a zero sccb address.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 hw/s390x/sclp.c         | 65 ++++++++++++++++++++++++++++++++++-------
 include/hw/s390x/sclp.h |  2 ++
 target/s390x/kvm.c      | 25 ++++++++++++----
 3 files changed, 76 insertions(+), 16 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index af0bfbc2eca74767..6486890fecea4b3c 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -33,6 +33,22 @@ static inline SCLPDevice *get_sclp_device(void)
     return sclp;
 }
 
+static inline bool sclp_command_code_valid(uint32_t code)
+{
+    switch (code & SCLP_CMD_CODE_MASK) {
+    case SCLP_CMDW_READ_SCP_INFO:
+    case SCLP_CMDW_READ_SCP_INFO_FORCED:
+    case SCLP_CMDW_READ_CPU_INFO:
+    case SCLP_CMDW_CONFIGURE_IOA:
+    case SCLP_CMDW_DECONFIGURE_IOA:
+    case SCLP_CMD_READ_EVENT_DATA:
+    case SCLP_CMD_WRITE_EVENT_DATA:
+    case SCLP_CMD_WRITE_EVENT_MASK:
+        return true;
+    }
+    return false;
+}
+
 static void prepare_cpu_entries(SCLPDevice *sclp, CPUEntry *entry, int *count)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
@@ -193,6 +209,43 @@ static void sclp_execute(SCLPDevice *sclp, SCCB *sccb, uint32_t code)
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
+     * Only a very limited number of calls is permitted by the
+     * Ultravisor and we support all of them, so we don't check for
+     * them. All other specification exceptions are also interpreted
+     * by the Ultravisor and hence never cause an exit we need to
+     * handle.
+     *
+     * Setting the CC is also done by the Ultravisor.
+     */
+    s390_cpu_pv_mem_read(env_archcpu(env), 0, &work_sccb, sccb_len);
+
+    if (!sclp_command_code_valid(code)) {
+        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
+        goto out_write;
+    }
+
+    sclp_c->execute(sclp, &work_sccb, code);
+out_write:
+    s390_cpu_pv_mem_write(env_archcpu(env), 0, &work_sccb,
+                          be16_to_cpu(work_sccb.h.length));
+    sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
+    return 0;
+}
+
 int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
 {
     SCLPDevice *sclp = get_sclp_device();
@@ -225,17 +278,7 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
         return -PGM_SPECIFICATION;
     }
 
-    switch (code & SCLP_CMD_CODE_MASK) {
-    case SCLP_CMDW_READ_SCP_INFO:
-    case SCLP_CMDW_READ_SCP_INFO_FORCED:
-    case SCLP_CMDW_READ_CPU_INFO:
-    case SCLP_CMDW_CONFIGURE_IOA:
-    case SCLP_CMDW_DECONFIGURE_IOA:
-    case SCLP_CMD_READ_EVENT_DATA:
-    case SCLP_CMD_WRITE_EVENT_DATA:
-    case SCLP_CMD_WRITE_EVENT_MASK:
-        break;
-    default:
+    if (!sclp_command_code_valid(code)) {
         work_sccb.h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
         goto out_write;
     }
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index cd7b24359f28deb4..822eff4396ff5dde 100644
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
index 462a1d70ee78104c..6b7819d2c51a111c 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1233,12 +1233,27 @@ static void kvm_sclp_service_call(S390CPU *cpu, struct kvm_run *run,
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
+        /* Setting the CC is done by the Ultravisor. */
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
2.25.1


