Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627ACC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 17:53:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39B5C206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 17:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B5C206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia1Uy-00019o-5T
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 12:53:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1ia1T9-00089G-5o
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:51:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1ia1T5-0003Nb-Jq
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:51:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34526)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1ia1Sz-0003J8-Cn
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:51:07 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xARHkWEg081129
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 12:51:03 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2whhyfvbws-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 12:51:03 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 27 Nov 2019 17:51:00 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 27 Nov 2019 17:50:58 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xARHovjG42926288
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Nov 2019 17:50:57 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A401A404D;
 Wed, 27 Nov 2019 17:50:57 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B68BA4055;
 Wed, 27 Nov 2019 17:50:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.82.185])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 27 Nov 2019 17:50:55 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/6] s390x: Move reset normal to shared reset handler
Date: Wed, 27 Nov 2019 12:50:42 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127175046.4911-1-frankja@linux.ibm.com>
References: <20191127175046.4911-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112717-0008-0000-0000-000003390CA1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112717-0009-0000-0000-00004A581612
Message-Id: <20191127175046.4911-3-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_04:2019-11-27,2019-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=1
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911270145
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

Let's start moving the cpu reset functions into a single function with
a switch/case, so we can use fallthroughs and share more code between
resets.

This patch introduces the reset function by renaming cpu_reset() and
cleaning up leftovers.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu-qom.h |  6 +++++-
 target/s390x/cpu.c     | 19 +++++++++++++------
 target/s390x/cpu.h     |  2 +-
 target/s390x/sigp.c    |  2 +-
 4 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
index b809ec8418..f3b71bac67 100644
--- a/target/s390x/cpu-qom.h
+++ b/target/s390x/cpu-qom.h
@@ -34,6 +34,10 @@
 typedef struct S390CPUModel S390CPUModel;
 typedef struct S390CPUDef S390CPUDef;
 
+typedef enum cpu_reset_type {
+    S390_CPU_RESET_NORMAL,
+} cpu_reset_type;
+
 /**
  * S390CPUClass:
  * @parent_realize: The parent class' realize handler.
@@ -57,7 +61,7 @@ typedef struct S390CPUClass {
     DeviceRealize parent_realize;
     void (*parent_reset)(CPUState *cpu);
     void (*load_normal)(CPUState *cpu);
-    void (*cpu_reset)(CPUState *cpu);
+    void (*reset)(CPUState *cpu, cpu_reset_type type);
     void (*initial_cpu_reset)(CPUState *cpu);
 } S390CPUClass;
 
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 3abe7e80fd..67d6fbfa44 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -82,18 +82,25 @@ static void s390_cpu_load_normal(CPUState *s)
 }
 #endif
 
-/* S390CPUClass::cpu_reset() */
-static void s390_cpu_reset(CPUState *s)
+/* S390CPUClass::reset() */
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
+
+    switch (type) {
+    case S390_CPU_RESET_NORMAL:
+        env->pfault_token = -1UL;
+        env->bpbc = false;
+        break;
+    default:
+        g_assert_not_reached();
+    }
 }
 
 /* S390CPUClass::initial_reset() */
@@ -102,7 +109,7 @@ static void s390_cpu_initial_reset(CPUState *s)
     S390CPU *cpu = S390_CPU(s);
     CPUS390XState *env = &cpu->env;
 
-    s390_cpu_reset(s);
+    s390_cpu_reset(s, S390_CPU_RESET_NORMAL);
     /* initial reset does not clear everything! */
     memset(&env->start_initial_reset_fields, 0,
         offsetof(CPUS390XState, end_reset_fields) -
@@ -473,7 +480,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
 #if !defined(CONFIG_USER_ONLY)
     scc->load_normal = s390_cpu_load_normal;
 #endif
-    scc->cpu_reset = s390_cpu_reset;
+    scc->reset = s390_cpu_reset;
     scc->initial_cpu_reset = s390_cpu_initial_reset;
     cc->reset = s390_cpu_full_reset;
     cc->class_by_name = s390_cpu_class_by_name,
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 17460ed7b3..18123dfd5b 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -741,7 +741,7 @@ static inline void s390_do_cpu_reset(CPUState *cs, run_on_cpu_data arg)
 {
     S390CPUClass *scc = S390_CPU_GET_CLASS(cs);
 
-    scc->cpu_reset(cs);
+    scc->reset(cs, S390_CPU_RESET_NORMAL);
 }
 
 static inline void s390_do_cpu_initial_reset(CPUState *cs, run_on_cpu_data arg)
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index 2ce22d4dc1..850139b9cd 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -266,7 +266,7 @@ static void sigp_cpu_reset(CPUState *cs, run_on_cpu_data arg)
     SigpInfo *si = arg.host_ptr;
 
     cpu_synchronize_state(cs);
-    scc->cpu_reset(cs);
+    scc->reset(cs, S390_CPU_RESET_NORMAL);
     cpu_synchronize_post_reset(cs);
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
 }
-- 
2.20.1


