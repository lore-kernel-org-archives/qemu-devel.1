Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65724C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 09:08:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38DD720718
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 09:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DD720718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZAMF-0005Xz-DF
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 04:08:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iZAI1-0008JX-JX
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 04:04:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iZAHw-0000Dw-E0
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 04:04:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50090)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iZAHw-0000Dc-5d
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 04:04:08 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAP8wsqE014447
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 04:04:07 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wfjqxtrs2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 04:04:07 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Mon, 25 Nov 2019 09:04:05 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 25 Nov 2019 09:04:01 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xAP93Kg350331968
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Nov 2019 09:03:21 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E04C42042;
 Mon, 25 Nov 2019 09:03:59 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50A404203F;
 Mon, 25 Nov 2019 09:03:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.152.224.205])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 25 Nov 2019 09:03:58 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/5] s390x: Move clear reset
Date: Mon, 25 Nov 2019 04:03:47 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191125090348.27010-1-frankja@linux.ibm.com>
References: <20191125090348.27010-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112509-0016-0000-0000-000002CBE7BC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112509-0017-0000-0000-0000332DBA01
Message-Id: <20191125090348.27010-5-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-25_02:2019-11-21,2019-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=1
 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 spamscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911250084
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
index 9f009b226c..4853cef204 100644
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
@@ -122,46 +133,6 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
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
@@ -453,6 +424,11 @@ static Property s390x_cpu_properties[] = {
     DEFINE_PROP_END_OF_LIST()
 };
 
+static void s390_cpu_reset_clear(CPUState *s)
+{
+    return s390_cpu_reset(s, S390_CPU_RESET_CLEAR);
+}
+
 static void s390_cpu_class_init(ObjectClass *oc, void *data)
 {
     S390CPUClass *scc = S390_CPU_CLASS(oc);
@@ -469,7 +445,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     scc->load_normal = s390_cpu_load_normal;
 #endif
     scc->reset = s390_cpu_reset;
-    cc->reset = s390_cpu_full_reset;
+    cc->reset = s390_cpu_reset_clear;
     cc->class_by_name = s390_cpu_class_by_name,
     cc->has_work = s390_cpu_has_work;
 #ifdef CONFIG_TCG
-- 
2.20.1


