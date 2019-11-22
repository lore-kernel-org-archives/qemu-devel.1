Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57954C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 08:04:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C29920659
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 08:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C29920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY3v5-00060X-Cn
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 03:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iY3kR-0002Nq-AM
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 02:53:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iY3kP-0004Qb-P2
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 02:52:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25250
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iY3kP-0004QP-KK
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 02:52:57 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAM7l6Iv034926
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 02:52:57 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wdfxvvfpu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 02:52:57 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 22 Nov 2019 07:52:55 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Nov 2019 07:52:52 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xAM7qCfm44499318
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Nov 2019 07:52:12 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 997D111C05C;
 Fri, 22 Nov 2019 07:52:50 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 86E7411C04A;
 Fri, 22 Nov 2019 07:52:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.41.23])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 22 Nov 2019 07:52:48 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] s390x: Cleanup cpu resets
Date: Fri, 22 Nov 2019 02:52:16 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122075218.23935-1-frankja@linux.ibm.com>
References: <20191122075218.23935-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112207-0008-0000-0000-0000033605BC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112207-0009-0000-0000-00004A5531FF
Message-Id: <20191122075218.23935-3-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_07:2019-11-21,2019-11-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=1 mlxscore=0 phishscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911220068
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

Let's move the resets into one function and switch by type, so we can
use fallthroughs for shared reset actions.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 target/s390x/cpu.c | 110 ++++++++++++++++++++-------------------------
 1 file changed, 48 insertions(+), 62 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 3abe7e80fd..556afecbc1 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -82,67 +82,52 @@ static void s390_cpu_load_normal(CPUState *s)
 }
 #endif
 
-/* S390CPUClass::cpu_reset() */
-static void s390_cpu_reset(CPUState *s)
+typedef enum cpu_reset_type {
+    S390_CPU_RESET_NORMAL,
+    S390_CPU_RESET_INITIAL,
+    S390_CPU_RESET_CLEAR,
+} cpu_reset_type;
+
+static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
 {
     S390CPU *cpu = S390_CPU(s);
     S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
     CPUS390XState *env = &cpu->env;
 
-    env->pfault_token = -1UL;
-    env->bpbc = false;
     scc->parent_reset(s);
     cpu->env.sigp_order = 0;
     s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
-}
 
-/* S390CPUClass::initial_reset() */
-static void s390_cpu_initial_reset(CPUState *s)
-{
-    S390CPU *cpu = S390_CPU(s);
-    CPUS390XState *env = &cpu->env;
+    /* Set initial values after clearing */
+    switch (type) {
+    case S390_CPU_RESET_CLEAR:
+        memset(env, 0, offsetof(CPUS390XState, start_initial_reset_fields));
+        /* Fallthrough */
+    case S390_CPU_RESET_INITIAL:
+        memset(&env->start_initial_reset_fields, 0,
+               offsetof(CPUS390XState, end_reset_fields) -
+               offsetof(CPUS390XState, start_initial_reset_fields));
+        /* architectured initial values for CR 0 and 14 */
+        env->cregs[0] = CR0_RESET;
+        env->cregs[14] = CR14_RESET;
 
-    s390_cpu_reset(s);
-    /* initial reset does not clear everything! */
-    memset(&env->start_initial_reset_fields, 0,
-        offsetof(CPUS390XState, end_reset_fields) -
-        offsetof(CPUS390XState, start_initial_reset_fields));
-
-    /* architectured initial values for CR 0 and 14 */
-    env->cregs[0] = CR0_RESET;
-    env->cregs[14] = CR14_RESET;
-
-    /* architectured initial value for Breaking-Event-Address register */
-    env->gbea = 1;
-
-    env->pfault_token = -1UL;
-
-    /* tininess for underflow is detected before rounding */
-    set_float_detect_tininess(float_tininess_before_rounding,
-                              &env->fpu_status);
+        /* architectured initial value for Breaking-Event-Address register */
+        env->gbea = 1;
+        /* tininess for underflow is detected before rounding */
+        set_float_detect_tininess(float_tininess_before_rounding,
+                                  &env->fpu_status);
+        /* Fallthrough */
+    case S390_CPU_RESET_NORMAL:
+        env->pfault_token = -1UL;
+        env->bpbc = false;
+        break;
+    }
 
     /* Reset state inside the kernel that we cannot access yet from QEMU. */
-    if (kvm_enabled()) {
-        kvm_s390_reset_vcpu(cpu);
+    if (kvm_enabled() && (type == S390_CPU_RESET_CLEAR ||
+                          type == S390_CPU_RESET_INITIAL)) {
+            kvm_s390_reset_vcpu(cpu);
     }
-}
-
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
 
 #if defined(CONFIG_USER_ONLY)
     /* user mode should always be allowed to use the full FPU */
@@ -151,20 +136,21 @@ static void s390_cpu_full_reset(CPUState *s)
         env->cregs[0] |= CR0_VECTOR;
     }
 #endif
+}
 
-    /* architectured initial value for Breaking-Event-Address register */
-    env->gbea = 1;
+static void s390_cpu_reset_normal(CPUState *s)
+{
+    return s390_cpu_reset(s, S390_CPU_RESET_NORMAL);
+}
 
-    env->pfault_token = -1UL;
+static void s390_cpu_reset_initial(CPUState *s)
+{
+    return s390_cpu_reset(s, S390_CPU_RESET_INITIAL);
+}
 
-    /* tininess for underflow is detected before rounding */
-    set_float_detect_tininess(float_tininess_before_rounding,
-                              &env->fpu_status);
-
-    /* Reset state inside the kernel that we cannot access yet from QEMU. */
-    if (kvm_enabled()) {
-        kvm_s390_reset_vcpu(cpu);
-    }
+static void s390_cpu_reset_clear(CPUState *s)
+{
+    return s390_cpu_reset(s, S390_CPU_RESET_CLEAR);
 }
 
 #if !defined(CONFIG_USER_ONLY)
@@ -473,9 +459,9 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
 #if !defined(CONFIG_USER_ONLY)
     scc->load_normal = s390_cpu_load_normal;
 #endif
-    scc->cpu_reset = s390_cpu_reset;
-    scc->initial_cpu_reset = s390_cpu_initial_reset;
-    cc->reset = s390_cpu_full_reset;
+    scc->cpu_reset = s390_cpu_reset_normal;
+    scc->initial_cpu_reset = s390_cpu_reset_initial;
+    cc->reset = s390_cpu_reset_clear;
     cc->class_by_name = s390_cpu_class_by_name,
     cc->has_work = s390_cpu_has_work;
 #ifdef CONFIG_TCG
-- 
2.20.1


