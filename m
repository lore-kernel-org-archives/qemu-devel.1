Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AEBC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 08:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A92902158A
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 08:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92902158A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaFKP-0000KF-Qg
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 03:39:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iaFJ3-0007sX-6C
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 03:37:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iaFJ0-000208-Dd
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 03:37:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41762)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iaFJ0-0001yf-7L
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 03:37:42 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAS8bDD6064326
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 03:37:41 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wjar888ed-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 03:37:41 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 28 Nov 2019 08:37:38 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 28 Nov 2019 08:37:35 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xAS8bYqe37618150
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Nov 2019 08:37:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A3E111C04A;
 Thu, 28 Nov 2019 08:37:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 35CC611C052;
 Thu, 28 Nov 2019 08:37:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.152.224.146])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 28 Nov 2019 08:37:33 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5] s390x: Move initial reset
Date: Thu, 28 Nov 2019 03:37:23 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127175046.4911-4-frankja@linux.ibm.com>
References: <20191127175046.4911-4-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112808-0016-0000-0000-000002CD4C4F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112808-0017-0000-0000-0000332F2FBF
Message-Id: <20191128083723.11937-1-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_01:2019-11-28,2019-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 phishscore=0 impostorscore=0 clxscore=1015 suspectscore=1 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911280073
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

Let's move the intial reset into the reset handler and cleanup
afterwards.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---

Fixed the kvm vcpu reset.

---
 target/s390x/cpu-qom.h |  2 +-
 target/s390x/cpu.c     | 46 +++++++++++++++++-------------------------
 target/s390x/cpu.h     |  2 +-
 target/s390x/sigp.c    |  2 +-
 4 files changed, 21 insertions(+), 31 deletions(-)

diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
index f3b71bac67..6f0a12042e 100644
--- a/target/s390x/cpu-qom.h
+++ b/target/s390x/cpu-qom.h
@@ -36,6 +36,7 @@ typedef struct S390CPUDef S390CPUDef;
 
 typedef enum cpu_reset_type {
     S390_CPU_RESET_NORMAL,
+    S390_CPU_RESET_INITIAL,
 } cpu_reset_type;
 
 /**
@@ -62,7 +63,6 @@ typedef struct S390CPUClass {
     void (*parent_reset)(CPUState *cpu);
     void (*load_normal)(CPUState *cpu);
     void (*reset)(CPUState *cpu, cpu_reset_type type);
-    void (*initial_cpu_reset)(CPUState *cpu);
 } S390CPUClass;
 
 typedef struct S390CPU S390CPU;
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 67d6fbfa44..ca62fe7685 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -94,6 +94,23 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
     s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
 
     switch (type) {
+    case S390_CPU_RESET_INITIAL:
+        /* initial reset does not clear everything! */
+        memset(&env->start_initial_reset_fields, 0,
+               offsetof(CPUS390XState, end_reset_fields) -
+               offsetof(CPUS390XState, start_initial_reset_fields));
+
+        /* architectured initial value for Breaking-Event-Address register */
+        env->gbea = 1;
+
+        /* architectured initial values for CR 0 and 14 */
+        env->cregs[0] = CR0_RESET;
+        env->cregs[14] = CR14_RESET;
+
+        /* tininess for underflow is detected before rounding */
+        set_float_detect_tininess(float_tininess_before_rounding,
+                                  &env->fpu_status);
+       /* fall through */
     case S390_CPU_RESET_NORMAL:
         env->pfault_token = -1UL;
         env->bpbc = false;
@@ -101,35 +118,9 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
     default:
         g_assert_not_reached();
     }
-}
-
-/* S390CPUClass::initial_reset() */
-static void s390_cpu_initial_reset(CPUState *s)
-{
-    S390CPU *cpu = S390_CPU(s);
-    CPUS390XState *env = &cpu->env;
-
-    s390_cpu_reset(s, S390_CPU_RESET_NORMAL);
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
 
     /* Reset state inside the kernel that we cannot access yet from QEMU. */
-    if (kvm_enabled()) {
+    if (kvm_enabled() && type != S390_CPU_RESET_NORMAL) {
         kvm_s390_reset_vcpu(cpu);
     }
 }
@@ -481,7 +472,6 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     scc->load_normal = s390_cpu_load_normal;
 #endif
     scc->reset = s390_cpu_reset;
-    scc->initial_cpu_reset = s390_cpu_initial_reset;
     cc->reset = s390_cpu_full_reset;
     cc->class_by_name = s390_cpu_class_by_name,
     cc->has_work = s390_cpu_has_work;
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 18123dfd5b..d2af13b345 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -748,7 +748,7 @@ static inline void s390_do_cpu_initial_reset(CPUState *cs, run_on_cpu_data arg)
 {
     S390CPUClass *scc = S390_CPU_GET_CLASS(cs);
 
-    scc->initial_cpu_reset(cs);
+    scc->reset(cs, S390_CPU_RESET_INITIAL);
 }
 
 static inline void s390_do_cpu_load_normal(CPUState *cs, run_on_cpu_data arg)
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index 850139b9cd..727875bb4a 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -254,7 +254,7 @@ static void sigp_initial_cpu_reset(CPUState *cs, run_on_cpu_data arg)
     SigpInfo *si = arg.host_ptr;
 
     cpu_synchronize_state(cs);
-    scc->initial_cpu_reset(cs);
+    scc->reset(cs, S390_CPU_RESET_INITIAL);
     cpu_synchronize_post_reset(cs);
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
 }
-- 
2.20.1


