Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E64C1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:32:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCB362067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB362067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCQki-0005vB-0H
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60474)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jCQhy-0008Oj-6d
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jCQhv-0005I0-KD
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:29:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54820)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jCQhv-0005Gv-Ce
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:29:15 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02CGKbPR141578
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:29:14 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yqrgv8dk8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:28:08 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 12 Mar 2020 16:25:16 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 12 Mar 2020 16:25:13 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02CGPCCI66584752
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 16:25:12 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C5C1DA405E;
 Thu, 12 Mar 2020 16:25:12 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F3734A4051;
 Thu, 12 Mar 2020 16:25:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.152.224.122])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 12 Mar 2020 16:25:11 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9] s390x: protvirt: Fence huge pages
Date: Thu, 12 Mar 2020 12:25:10 -0400
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311132151.172389-1-frankja@linux.ibm.com>
References: <20200311132151.172389-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031216-0016-0000-0000-000002F00678
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031216-0017-0000-0000-0000335375AE
Message-Id: <20200312162510.5472-1-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-12_09:2020-03-11,
 2020-03-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 suspectscore=1 spamscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003120083
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

Let's bail out of the protected transition if we detect that huge
pages might be in use.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---

I'd like to squash this into the unpack patch to give a proper error
message if we try to transition into the protected mode while being
backed by huge pages. 

---
 hw/s390x/ipl.h             | 16 ++++++++++++++++
 hw/s390x/s390-virtio-ccw.c |  1 -
 target/s390x/diag.c        | 23 ++++++++---------------
 target/s390x/kvm-stub.c    |  5 +++++
 target/s390x/kvm.c         |  5 +++++
 target/s390x/kvm_s390x.h   |  1 +
 6 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index af5bb130a6334821..95e3183c9cccf8b6 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -185,6 +185,22 @@ struct S390IPLState {
 typedef struct S390IPLState S390IPLState;
 QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
 
+#define DIAG_308_RC_OK              0x0001
+#define DIAG_308_RC_NO_CONF         0x0102
+#define DIAG_308_RC_INVALID         0x0402
+#define DIAG_308_RC_NO_PV_CONF      0x0902
+#define DIAG_308_RC_INVAL_FOR_PV    0x0a02
+
+#define DIAG308_RESET_MOD_CLR       0
+#define DIAG308_RESET_LOAD_NORM     1
+#define DIAG308_LOAD_CLEAR          3
+#define DIAG308_LOAD_NORMAL_DUMP    4
+#define DIAG308_SET                 5
+#define DIAG308_STORE               6
+#define DIAG308_PV_SET              8
+#define DIAG308_PV_STORE            9
+#define DIAG308_PV_START            10
+
 #define S390_IPL_TYPE_FCP 0x00
 #define S390_IPL_TYPE_CCW 0x02
 #define S390_IPL_TYPE_PV 0x05
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index ebdaaa3a001f6e8c..d32f35c7f47b9c1d 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -361,7 +361,6 @@ out_err:
     return rc;
 }
 
-#define DIAG_308_RC_INVAL_FOR_PV    0x0a02
 static void s390_machine_inject_pv_error(CPUState *cs)
 {
     int r1 = (cs->kvm_run->s390_sieic.ipa & 0x00f0) >> 4;
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index b245e557037ded06..b1ca81633b83bbdc 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -21,6 +21,7 @@
 #include "hw/s390x/ipl.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/pv.h"
+#include "kvm_s390x.h"
 
 int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
 {
@@ -50,21 +51,6 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
     return diag288_class->handle_timer(diag288, func, timeout);
 }
 
-#define DIAG_308_RC_OK              0x0001
-#define DIAG_308_RC_NO_CONF         0x0102
-#define DIAG_308_RC_INVALID         0x0402
-#define DIAG_308_RC_NO_PV_CONF      0x0902
-
-#define DIAG308_RESET_MOD_CLR       0
-#define DIAG308_RESET_LOAD_NORM     1
-#define DIAG308_LOAD_CLEAR          3
-#define DIAG308_LOAD_NORMAL_DUMP    4
-#define DIAG308_SET                 5
-#define DIAG308_STORE               6
-#define DIAG308_PV_SET              8
-#define DIAG308_PV_STORE            9
-#define DIAG308_PV_START            10
-
 static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
                               uintptr_t ra, bool write)
 {
@@ -166,6 +152,13 @@ out:
             return;
         }
 
+        if (kvm_s390_get_hpage_1m()) {
+            error_report("Protected VMs can currently not be backed with "
+                         "huge pages");
+            env->regs[r1 + 1] = DIAG_308_RC_INVAL_FOR_PV;
+            return;
+        }
+
         s390_ipl_reset_request(cs, S390_RESET_PV);
         break;
     default:
diff --git a/target/s390x/kvm-stub.c b/target/s390x/kvm-stub.c
index c4cd497f850eb9c7..aa185017a2a886ca 100644
--- a/target/s390x/kvm-stub.c
+++ b/target/s390x/kvm-stub.c
@@ -39,6 +39,11 @@ int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu)
     return 0;
 }
 
+int kvm_s390_get_hpage_1m(void)
+{
+    return 0;
+}
+
 int kvm_s390_get_ri(void)
 {
     return 0;
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 1d6fd6a27b48e35f..c695941076b7aead 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -321,6 +321,11 @@ void kvm_s390_set_max_pagesize(uint64_t pagesize, Error **errp)
     cap_hpage_1m = 1;
 }
 
+int kvm_s390_get_hpage_1m(void)
+{
+    return cap_hpage_1m;
+}
+
 static void ccw_machine_class_foreach(ObjectClass *oc, void *opaque)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
index 0b21789796d7c462..dea813f450153c34 100644
--- a/target/s390x/kvm_s390x.h
+++ b/target/s390x/kvm_s390x.h
@@ -23,6 +23,7 @@ void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code);
 int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state);
 void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu);
 int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu);
+int kvm_s390_get_hpage_1m(void);
 int kvm_s390_get_ri(void);
 int kvm_s390_get_gs(void);
 int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_clock);
-- 
2.25.1


