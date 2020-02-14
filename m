Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39293C3B19D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:18:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12CF52168B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12CF52168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2cjX-0000B0-4N
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 10:18:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j2ciP-0006kB-6E
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:17:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j2ciN-00064t-Mg
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:17:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9174
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j2ciN-00064X-IF
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:17:11 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01EFH6YZ001224
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:17:11 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y4j8d25cg-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:17:09 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 14 Feb 2020 15:16:58 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 14 Feb 2020 15:16:56 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01EFGttX52559940
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2020 15:16:55 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BBED4A4040;
 Fri, 14 Feb 2020 15:16:55 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4CBD4A4051;
 Fri, 14 Feb 2020 15:16:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.191.187])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 14 Feb 2020 15:16:54 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/17] s390x: Add missing vcpu reset functions
Date: Fri, 14 Feb 2020 10:16:21 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214151636.8764-1-frankja@linux.ibm.com>
References: <20200214151636.8764-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021415-0012-0000-0000-00000386D78C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021415-0013-0000-0000-000021C35EA1
Message-Id: <20200214151636.8764-3-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-14_04:2020-02-12,
 2020-02-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=1 phishscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002140121
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
Cc: mihajlov@linux.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Up to now we only had an ioctl to reset vcpu data QEMU couldn't reach
for the initial reset, which was also called for the clear reset. To
be architecture compliant, we also need to clear local interrupts on a
normal reset.

Because of this and the upcoming protvirt support we need to add
ioctls for the missing clear and normal resets.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.c       | 14 ++++++++++++--
 target/s390x/kvm-stub.c  | 10 +++++++++-
 target/s390x/kvm.c       | 42 ++++++++++++++++++++++++++++++++--------
 target/s390x/kvm_s390x.h |  4 +++-
 4 files changed, 58 insertions(+), 12 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index cf84d307c6..8da1905485 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -144,8 +144,18 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
     }
 
     /* Reset state inside the kernel that we cannot access yet from QEMU. */
-    if (kvm_enabled() && type != S390_CPU_RESET_NORMAL) {
-        kvm_s390_reset_vcpu(cpu);
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
 }
 
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
index 30112e529c..1d6fd6a27b 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -151,6 +151,7 @@ static int cap_s390_irq;
 static int cap_ri;
 static int cap_gs;
 static int cap_hpage_1m;
+static int cap_vcpu_resets;
 
 static int active_cmma;
 
@@ -342,6 +343,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_async_pf = kvm_check_extension(s, KVM_CAP_ASYNC_PF);
     cap_mem_op = kvm_check_extension(s, KVM_CAP_S390_MEM_OP);
     cap_s390_irq = kvm_check_extension(s, KVM_CAP_S390_INJECT_IRQ);
+    cap_vcpu_resets = kvm_check_extension(s, KVM_CAP_S390_VCPU_RESETS);
 
     if (!kvm_check_extension(s, KVM_CAP_S390_GMAP)
         || !kvm_check_extension(s, KVM_CAP_S390_COW)) {
@@ -406,17 +408,41 @@ int kvm_arch_destroy_vcpu(CPUState *cs)
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
-    if (kvm_vcpu_ioctl(cs, KVM_S390_INITIAL_RESET, NULL)) {
-        error_report("Initial CPU reset failed on CPU %i", cs->cpu_index);
+    /*
+     * The reset call is needed here to reset in-kernel vcpu data that
+     * we can't access directly from QEMU (i.e. with older kernels
+     * which don't support sync_regs/ONE_REG).  Before this ioctl
+     * cpu_synchronize_state() is called in common kvm code
+     * (kvm-all).
+     */
+    if (kvm_vcpu_ioctl(cs, type)) {
+        error_report("CPU reset failed on CPU %i type %lx",
+                     cs->cpu_index, type);
+    }
+}
+
+void kvm_s390_reset_vcpu_initial(S390CPU *cpu)
+{
+    kvm_s390_reset_vcpu(cpu, KVM_S390_INITIAL_RESET);
+}
+
+void kvm_s390_reset_vcpu_clear(S390CPU *cpu)
+{
+    if (cap_vcpu_resets) {
+        kvm_s390_reset_vcpu(cpu, KVM_S390_CLEAR_RESET);
+    } else {
+        kvm_s390_reset_vcpu(cpu, KVM_S390_INITIAL_RESET);
+    }
+}
+
+void kvm_s390_reset_vcpu_normal(S390CPU *cpu)
+{
+    if (cap_vcpu_resets) {
+        kvm_s390_reset_vcpu(cpu, KVM_S390_NORMAL_RESET);
     }
 }
 
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


