Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7047BC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 17:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41211207DD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 17:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41211207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia1Yw-0004Zj-SO
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 12:57:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1ia1TA-00089L-1I
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:51:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1ia1T5-0003OB-SK
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:51:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14058)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1ia1T5-0003Lt-N7
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:51:11 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xARHkOTZ088055
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 12:51:08 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2whrgmc0vq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 12:51:08 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 27 Nov 2019 17:51:06 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 27 Nov 2019 17:51:03 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xARHp1vr35062100
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Nov 2019 17:51:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 879E3A405B;
 Wed, 27 Nov 2019 17:51:01 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E206BA4053;
 Wed, 27 Nov 2019 17:50:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.82.185])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 27 Nov 2019 17:50:59 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/6] s390x: Move clear reset
Date: Wed, 27 Nov 2019 12:50:44 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127175046.4911-1-frankja@linux.ibm.com>
References: <20191127175046.4911-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112717-0028-0000-0000-000003C0C67B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112717-0029-0000-0000-00002483CE4B
Message-Id: <20191127175046.4911-5-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_04:2019-11-27,2019-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=1 adultscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911270145
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

Let's also move the clear reset function into the reset handler.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 target/s390x/cpu-qom.h |  1 +
 target/s390x/cpu.c     | 58 +++++++++++++-----------------------------
 2 files changed, 18 insertions(+), 41 deletions(-)

diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
index 6f0a12042e..dbe5346ec9 100644
--- a/target/s390x/cpu-qom.h
+++ b/target/s390x/cpu-qom.h
@@ -37,6 +37,7 @@ typedef struct S390CPUDef S390CPUDef;
 typedef enum cpu_reset_type {
     S390_CPU_RESET_NORMAL,
     S390_CPU_RESET_INITIAL,
+    S390_CPU_RESET_CLEAR,
 } cpu_reset_type;
 
 /**
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 55e2d1fe7b..3e745e8ecc 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -94,6 +94,9 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
     s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
 
     switch (type) {
+    case S390_CPU_RESET_CLEAR:
+        memset(env, 0, offsetof(CPUS390XState, start_initial_reset_fields));
+        /* fall through */
     case S390_CPU_RESET_INITIAL:
         /* initial reset does not clear everything! */
         memset(&env->start_initial_reset_fields, 0,
@@ -107,6 +110,14 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
         env->cregs[0] = CR0_RESET;
         env->cregs[14] = CR14_RESET;
 
+#if defined(CONFIG_USER_ONLY)
+        /* user mode should always be allowed to use the full FPU */
+        env->cregs[0] |= CR0_AFP;
+        if (s390_has_feat(S390_FEAT_VECTOR)) {
+            env->cregs[0] |= CR0_VECTOR;
+        }
+#endif
+
         /* tininess for underflow is detected before rounding */
         set_float_detect_tininess(float_tininess_before_rounding,
                                   &env->fpu_status);
@@ -125,46 +136,6 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
     }
 }
 
-/* CPUClass:reset() */
-static void s390_cpu_full_reset(CPUState *s)
-{
-    S390CPU *cpu = S390_CPU(s);
-    S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
-    CPUS390XState *env = &cpu->env;
-
-    scc->parent_reset(s);
-    cpu->env.sigp_order = 0;
-    s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
-
-    memset(env, 0, offsetof(CPUS390XState, end_reset_fields));
-
-    /* architectured initial values for CR 0 and 14 */
-    env->cregs[0] = CR0_RESET;
-    env->cregs[14] = CR14_RESET;
-
-#if defined(CONFIG_USER_ONLY)
-    /* user mode should always be allowed to use the full FPU */
-    env->cregs[0] |= CR0_AFP;
-    if (s390_has_feat(S390_FEAT_VECTOR)) {
-        env->cregs[0] |= CR0_VECTOR;
-    }
-#endif
-
-    /* architectured initial value for Breaking-Event-Address register */
-    env->gbea = 1;
-
-    env->pfault_token = -1UL;
-
-    /* tininess for underflow is detected before rounding */
-    set_float_detect_tininess(float_tininess_before_rounding,
-                              &env->fpu_status);
-
-    /* Reset state inside the kernel that we cannot access yet from QEMU. */
-    if (kvm_enabled()) {
-        kvm_s390_reset_vcpu(cpu);
-    }
-}
-
 #if !defined(CONFIG_USER_ONLY)
 static void s390_cpu_machine_reset_cb(void *opaque)
 {
@@ -456,6 +427,11 @@ static Property s390x_cpu_properties[] = {
     DEFINE_PROP_END_OF_LIST()
 };
 
+static void s390_cpu_reset_full(CPUState *s)
+{
+    return s390_cpu_reset(s, S390_CPU_RESET_CLEAR);
+}
+
 static void s390_cpu_class_init(ObjectClass *oc, void *data)
 {
     S390CPUClass *scc = S390_CPU_CLASS(oc);
@@ -472,7 +448,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     scc->load_normal = s390_cpu_load_normal;
 #endif
     scc->reset = s390_cpu_reset;
-    cc->reset = s390_cpu_full_reset;
+    cc->reset = s390_cpu_reset_full;
     cc->class_by_name = s390_cpu_class_by_name,
     cc->has_work = s390_cpu_has_work;
 #ifdef CONFIG_TCG
-- 
2.20.1


