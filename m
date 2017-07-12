Received: from eggs.gnu.org ([2001:4830:134:3::10]:44844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVHDL-0006Vm-2R
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVHDG-0000zh-8F
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:57:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVHDF-0000ys-VB
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:57:54 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6CCs5vO063414
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 08:57:51 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bncjassut-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 08:57:51 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 12 Jul 2017 13:57:49 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 12 Jul 2017 14:57:35 +0200
In-Reply-To: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
References: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1499864265-144136-2-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 01/11] s390x/kvm: Rework cmma management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Janosch Frank <frankja@linux.vnet.ibm.com>

Let's keep track of cmma enablement and move the mem_path check into
the actual enablement. This now also warns users that do not use
cpu-models about disabled cmma when using huge pages.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 target/s390x/cpu.h |  1 +
 target/s390x/kvm.c | 26 +++++++++++++++++---------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index bdb9bdb..8ab75c0 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -1158,6 +1158,7 @@ int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
                                     int vq, bool assign);
 int kvm_s390_cpu_restart(S390CPU *cpu);
 int kvm_s390_get_memslot_count(KVMState *s);
+int kvm_s390_cmma_active(void);
 void kvm_s390_cmma_reset(void);
 int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state);
 void kvm_s390_reset_vcpu(S390CPU *cpu);
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index a3d0019..7a2a7c0 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -140,6 +140,8 @@ static int cap_mem_op;
 static int cap_s390_irq;
 static int cap_ri;
 
+static int active_cmma;
+
 static void *legacy_s390_alloc(size_t size, uint64_t *align);
 
 static int kvm_s390_query_mem_limit(KVMState *s, uint64_t *memory_limit)
@@ -177,6 +179,11 @@ int kvm_s390_set_mem_limit(KVMState *s, uint64_t new_limit, uint64_t *hw_limit)
     return kvm_vm_ioctl(s, KVM_SET_DEVICE_ATTR, &attr);
 }
 
+int kvm_s390_cmma_active(void)
+{
+    return active_cmma;
+}
+
 static bool kvm_s390_cmma_available(void)
 {
     static bool initialized, value;
@@ -197,7 +204,7 @@ void kvm_s390_cmma_reset(void)
         .attr = KVM_S390_VM_MEM_CLR_CMMA,
     };
 
-    if (mem_path || !kvm_s390_cmma_available()) {
+    if (!kvm_s390_cmma_active()) {
         return;
     }
 
@@ -213,7 +220,13 @@ static void kvm_s390_enable_cmma(void)
         .attr = KVM_S390_VM_MEM_ENABLE_CMMA,
     };
 
+    if (mem_path) {
+        error_report("Warning: CMM will not be enabled because it is not "
+                     "compatible to hugetlbfs.");
+        return;
+    }
     rc = kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
+    active_cmma = !rc;
     trace_kvm_enable_cmma(rc);
 }
 
@@ -2641,7 +2654,7 @@ void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
 
     if (!model) {
         /* compatibility handling if cpu models are disabled */
-        if (kvm_s390_cmma_available() && !mem_path) {
+        if (kvm_s390_cmma_available()) {
             kvm_s390_enable_cmma();
         }
         return;
@@ -2672,13 +2685,8 @@ void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
         error_setg(errp, "KVM: Error configuring CPU subfunctions: %d", rc);
         return;
     }
-    /* enable CMM via CMMA - disable on hugetlbfs */
+    /* enable CMM via CMMA */
     if (test_bit(S390_FEAT_CMM, model->features)) {
-        if (mem_path) {
-            error_report("Warning: CMM will not be enabled because it is not "
-                         "compatible to hugetlbfs.");
-        } else {
-            kvm_s390_enable_cmma();
-        }
+        kvm_s390_enable_cmma();
     }
 }
-- 
2.7.4
