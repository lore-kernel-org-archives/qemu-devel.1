Received: from eggs.gnu.org ([2001:4830:134:3::10]:57293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6GR-0002ml-Cl
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6GQ-0005a2-CY
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:54:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dn6GQ-0005Z4-3q
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:54:50 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Aug 2017 18:52:32 +0200
Message-Id: <20170830165252.13421-25-cohuck@redhat.com>
In-Reply-To: <20170830165252.13421-1-cohuck@redhat.com>
References: <20170830165252.13421-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 24/44] s390x/kvm: drop KVMState parameter from
 kvm_s390_set_mem_limit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Not needed at that point. Also drop it from kvm_s390_query_mem_limit()
we call in kvm_s390_set_mem_limit().

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170818114353.13455-3-david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.h |  7 +++----
 target/s390x/kvm.c | 12 ++++++------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 44b1a7ab71..798e299db1 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -1169,7 +1169,7 @@ int kvm_s390_cmma_active(void);
 void kvm_s390_cmma_reset(void);
 int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state);
 void kvm_s390_reset_vcpu(S390CPU *cpu);
-int kvm_s390_set_mem_limit(KVMState *s, uint64_t new_limit, uint64_t *hw_limit);
+int kvm_s390_set_mem_limit(uint64_t new_limit, uint64_t *hw_limit);
 void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu);
 int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu);
 int kvm_s390_get_ri(void);
@@ -1215,8 +1215,7 @@ static inline int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state)
 static inline void kvm_s390_reset_vcpu(S390CPU *cpu)
 {
 }
-static inline int kvm_s390_set_mem_limit(KVMState *s, uint64_t new_limit,
-                                         uint64_t *hw_limit)
+static inline int kvm_s390_set_mem_limit(uint64_t new_limit, uint64_t *hw_limit)
 {
     return 0;
 }
@@ -1243,7 +1242,7 @@ static inline void kvm_s390_crypto_reset(void)
 static inline int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit)
 {
     if (kvm_enabled()) {
-        return kvm_s390_set_mem_limit(kvm_state, new_limit, hw_limit);
+        return kvm_s390_set_mem_limit(new_limit, hw_limit);
     }
     return 0;
 }
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index d961fcf18b..23109a7c76 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -145,7 +145,7 @@ static int active_cmma;
 
 static void *legacy_s390_alloc(size_t size, uint64_t *align);
 
-static int kvm_s390_query_mem_limit(KVMState *s, uint64_t *memory_limit)
+static int kvm_s390_query_mem_limit(uint64_t *memory_limit)
 {
     struct kvm_device_attr attr = {
         .group = KVM_S390_VM_MEM_CTRL,
@@ -153,10 +153,10 @@ static int kvm_s390_query_mem_limit(KVMState *s, uint64_t *memory_limit)
         .addr = (uint64_t) memory_limit,
     };
 
-    return kvm_vm_ioctl(s, KVM_GET_DEVICE_ATTR, &attr);
+    return kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
 }
 
-int kvm_s390_set_mem_limit(KVMState *s, uint64_t new_limit, uint64_t *hw_limit)
+int kvm_s390_set_mem_limit(uint64_t new_limit, uint64_t *hw_limit)
 {
     int rc;
 
@@ -166,18 +166,18 @@ int kvm_s390_set_mem_limit(KVMState *s, uint64_t new_limit, uint64_t *hw_limit)
         .addr = (uint64_t) &new_limit,
     };
 
-    if (!kvm_vm_check_mem_attr(s, KVM_S390_VM_MEM_LIMIT_SIZE)) {
+    if (!kvm_vm_check_mem_attr(kvm_state, KVM_S390_VM_MEM_LIMIT_SIZE)) {
         return 0;
     }
 
-    rc = kvm_s390_query_mem_limit(s, hw_limit);
+    rc = kvm_s390_query_mem_limit(hw_limit);
     if (rc) {
         return rc;
     } else if (*hw_limit < new_limit) {
         return -E2BIG;
     }
 
-    return kvm_vm_ioctl(s, KVM_SET_DEVICE_ATTR, &attr);
+    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
 }
 
 int kvm_s390_cmma_active(void)
-- 
2.13.5
