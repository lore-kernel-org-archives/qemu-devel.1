Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43485C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:04:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18849223D1
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18849223D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXOiU-0000ir-6p
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 07:04:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iXOPD-0003dv-PP
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:44:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iXOPC-0003uo-Ag
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:44:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iXOPC-0003Yr-2n
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:44:18 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAKBg7H4093132
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 06:44:07 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2waygnf5xs-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 06:44:06 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 20 Nov 2019 11:44:04 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 20 Nov 2019 11:44:01 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAKBi0Ka57147468
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Nov 2019 11:44:00 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A0864C040;
 Wed, 20 Nov 2019 11:44:00 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B1FE4C04E;
 Wed, 20 Nov 2019 11:43:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.152.224.205])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 20 Nov 2019 11:43:59 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/15] s390x: protvirt: Add new VCPU reset functions
Date: Wed, 20 Nov 2019 06:43:29 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191120114334.2287-1-frankja@linux.ibm.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112011-0028-0000-0000-000003BD0734
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112011-0029-0000-0000-000024802A42
Message-Id: <20191120114334.2287-11-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_03:2019-11-15,2019-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 suspectscore=1
 bulkscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911200107
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

CPU resets for protected guests need to be done via Ultravisor
calls. Hence we need a way to issue these calls for each reset.

As we formerly had only one reset function and it was called for
initial, as well as for the clear reset, we now need a new interface.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 target/s390x/cpu.c       | 15 ++++++++++++---
 target/s390x/kvm-stub.c  | 10 +++++++++-
 target/s390x/kvm.c       | 38 ++++++++++++++++++++++++++++++++------
 target/s390x/kvm_s390x.h |  4 +++-
 4 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 10d5b915d8..ac04fdbba9 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -125,9 +125,18 @@ static void s390_cpu_reset(CPUState *s, uint8_t type)
     }
 
     /* Reset state inside the kernel that we cannot access yet from QEMU. */
-    if (kvm_enabled() && (type == S390_CPU_RESET_CLEAR ||
-                          type == S390_CPU_RESET_INITIAL)) {
-            kvm_s390_reset_vcpu(cpu);
+    if (kvm_enabled()) {
+        switch (type) {
+        case S390_CPU_RESET_CLEAR:
+            kvm_s390_reset_vcpu_clear(cpu);
+            break;
+        case S390_CPU_RESET_INITIAL:
+            kvm_s390_reset_vcpu_initial(cpu);
+            break;
+        case S390_CPU_RESET_NORMAL:
+            kvm_s390_reset_vcpu_normal(cpu);
+            break;
+        }
     }
 
 #if defined(CONFIG_USER_ONLY)
diff --git a/target/s390x/kvm-stub.c b/target/s390x/kvm-stub.c
index 5152e2bdf1..c4cd497f85 100644
--- a/target/s390x/kvm-stub.c
+++ b/target/s390x/kvm-stub.c
@@ -83,7 +83,15 @@ void kvm_s390_cmma_reset(void)
 {
 }
 
-void kvm_s390_reset_vcpu(S390CPU *cpu)
+void kvm_s390_reset_vcpu_initial(S390CPU *cpu)
+{
+}
+
+void kvm_s390_reset_vcpu_clear(S390CPU *cpu)
+{
+}
+
+void kvm_s390_reset_vcpu_normal(S390CPU *cpu)
 {
 }
 
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 0f2458b553..190400df55 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -154,6 +154,7 @@ static int cap_ri;
 static int cap_gs;
 static int cap_hpage_1m;
 static int cap_protvirt;
+static int cap_vcpu_resets;
 
 static int active_cmma;
 
@@ -340,6 +341,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_mem_op = kvm_check_extension(s, KVM_CAP_S390_MEM_OP);
     cap_s390_irq = kvm_check_extension(s, KVM_CAP_S390_INJECT_IRQ);
     cap_protvirt = kvm_check_extension(s, KVM_CAP_S390_PROTECTED);
+    cap_vcpu_resets = kvm_check_extension(s, KVM_CAP_S390_VCPU_RESETS);
 
     if (!kvm_check_extension(s, KVM_CAP_S390_GMAP)
         || !kvm_check_extension(s, KVM_CAP_S390_COW)) {
@@ -401,20 +403,44 @@ int kvm_arch_destroy_vcpu(CPUState *cs)
     return 0;
 }
 
-void kvm_s390_reset_vcpu(S390CPU *cpu)
+static void kvm_s390_reset_vcpu(S390CPU *cpu, unsigned long type)
 {
     CPUState *cs = CPU(cpu);
 
-    /* The initial reset call is needed here to reset in-kernel
-     * vcpu data that we can't access directly from QEMU
-     * (i.e. with older kernels which don't support sync_regs/ONE_REG).
-     * Before this ioctl cpu_synchronize_state() is called in common kvm
-     * code (kvm-all) */
+    /*
+     * The reset call is needed here to reset in-kernel vcpu data that
+     * we can't access directly from QEMU (i.e. with older kernels
+     * which don't support sync_regs/ONE_REG).  Before this ioctl
+     * cpu_synchronize_state() is called in common kvm code
+     * (kvm-all).
+     */
+    if (cap_vcpu_resets) {
+        if (kvm_vcpu_ioctl(cs, KVM_S390_VCPU_RESET, type)) {
+            error_report("CPU reset type %ld failed on CPU %i",
+                         type, cs->cpu_index);
+        }
+        return;
+    }
     if (kvm_vcpu_ioctl(cs, KVM_S390_INITIAL_RESET, NULL)) {
         error_report("Initial CPU reset failed on CPU %i", cs->cpu_index);
     }
 }
 
+void kvm_s390_reset_vcpu_initial(S390CPU *cpu)
+{
+    kvm_s390_reset_vcpu(cpu, KVM_S390_VCPU_RESET_INITIAL);
+}
+
+void kvm_s390_reset_vcpu_clear(S390CPU *cpu)
+{
+    kvm_s390_reset_vcpu(cpu, KVM_S390_VCPU_RESET_CLEAR);
+}
+
+void kvm_s390_reset_vcpu_normal(S390CPU *cpu)
+{
+    kvm_s390_reset_vcpu(cpu, KVM_S390_VCPU_RESET_NORMAL);
+}
+
 static int can_sync_regs(CPUState *cs, int regs)
 {
     return cap_sync_regs && (cs->kvm_run->kvm_valid_regs & regs) == regs;
diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
index caf985955b..0b21789796 100644
--- a/target/s390x/kvm_s390x.h
+++ b/target/s390x/kvm_s390x.h
@@ -34,7 +34,9 @@ int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
                                     int vq, bool assign);
 int kvm_s390_cmma_active(void);
 void kvm_s390_cmma_reset(void);
-void kvm_s390_reset_vcpu(S390CPU *cpu);
+void kvm_s390_reset_vcpu_clear(S390CPU *cpu);
+void kvm_s390_reset_vcpu_normal(S390CPU *cpu);
+void kvm_s390_reset_vcpu_initial(S390CPU *cpu);
 int kvm_s390_set_mem_limit(uint64_t new_limit, uint64_t *hw_limit);
 void kvm_s390_set_max_pagesize(uint64_t pagesize, Error **errp);
 void kvm_s390_crypto_reset(void);
-- 
2.20.1


