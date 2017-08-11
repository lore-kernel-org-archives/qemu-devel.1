Received: from eggs.gnu.org ([2001:4830:134:3::10]:36297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dg4fE-0001qi-A5
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dg4fD-0003Gl-0s
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:47:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dg4fC-0003Gb-NS
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:47:22 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 11 Aug 2017 09:46:51 +0200
Message-Id: <20170811074652.31474-5-david@redhat.com>
In-Reply-To: <20170811074652.31474-1-david@redhat.com>
References: <20170811074652.31474-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 4/5] target/s390x: remove all CONFIG_KVM
 from cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com

Let's move everything into internal.h

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h      | 62 -------------------------------------------------
 target/s390x/internal.h | 52 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 62 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 87dea80..dc1eb77 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -406,22 +406,6 @@ int cpu_s390x_signal_handler(int host_signum, void *pinfo,
 
 void s390_enable_css_support(S390CPU *cpu);
 int s390_virtio_hypercall(CPUS390XState *env);
-
-#ifdef CONFIG_KVM
-int kvm_s390_inject_flic(struct kvm_s390_irq *irq);
-int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_clock);
-int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_clock);
-#else
-static inline int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_low)
-{
-    return -ENOSYS;
-}
-static inline int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_low)
-{
-    return -ENOSYS;
-}
-#endif
-
 int s390_get_clock(uint8_t *tod_high, uint64_t *tod_low);
 int s390_set_clock(uint8_t *tod_high, uint64_t *tod_low);
 
@@ -688,52 +672,6 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
 #define ILEN_AUTO                   0xff
 void program_interrupt(CPUS390XState *env, uint32_t code, int ilen);
 
-#ifdef CONFIG_KVM
-void kvm_s390_enable_css_support(S390CPU *cpu);
-int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
-                                    int vq, bool assign);
-int kvm_s390_cpu_restart(S390CPU *cpu);
-int kvm_s390_get_memslot_count(KVMState *s);
-int kvm_s390_cmma_active(void);
-void kvm_s390_cmma_reset(void);
-void kvm_s390_reset_vcpu(S390CPU *cpu);
-int kvm_s390_set_mem_limit(KVMState *s, uint64_t new_limit, uint64_t *hw_limit);
-void kvm_s390_crypto_reset(void);
-#else
-
-static inline void kvm_s390_enable_css_support(S390CPU *cpu)
-{
-}
-static inline int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier,
-                                                  uint32_t sch, int vq,
-                                                  bool assign)
-{
-    return -ENOSYS;
-}
-static inline int kvm_s390_cpu_restart(S390CPU *cpu)
-{
-    return -ENOSYS;
-}
-static inline void kvm_s390_cmma_reset(void)
-{
-}
-static inline int kvm_s390_get_memslot_count(KVMState *s)
-{
-  return MAX_AVAIL_SLOTS;
-}
-static inline void kvm_s390_reset_vcpu(S390CPU *cpu)
-{
-}
-static inline int kvm_s390_set_mem_limit(KVMState *s, uint64_t new_limit,
-                                         uint64_t *hw_limit)
-{
-    return 0;
-}
-static inline void kvm_s390_crypto_reset(void)
-{
-}
-#endif
-
 int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit);
 void s390_cmma_reset(void);
 int s390_cpu_restart(S390CPU *cpu);
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 9a55271..c3e98b4 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -491,6 +491,19 @@ void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu);
 int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu);
 int kvm_s390_get_ri(void);
 int kvm_s390_get_gs(void);
+int kvm_s390_inject_flic(struct kvm_s390_irq *irq);
+int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_clock);
+int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_clock);
+void kvm_s390_enable_css_support(S390CPU *cpu);
+int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
+                                    int vq, bool assign);
+int kvm_s390_cpu_restart(S390CPU *cpu);
+int kvm_s390_get_memslot_count(KVMState *s);
+int kvm_s390_cmma_active(void);
+void kvm_s390_cmma_reset(void);
+void kvm_s390_reset_vcpu(S390CPU *cpu);
+int kvm_s390_set_mem_limit(KVMState *s, uint64_t new_limit, uint64_t *hw_limit);
+void kvm_s390_crypto_reset(void);
 #else
 static inline void kvm_s390_service_interrupt(uint32_t parm)
 {
@@ -535,6 +548,45 @@ static inline int kvm_s390_get_gs(void)
 {
     return 0;
 }
+static inline int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_low)
+{
+    return -ENOSYS;
+}
+static inline int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_low)
+{
+    return -ENOSYS;
+}
+static inline void kvm_s390_enable_css_support(S390CPU *cpu)
+{
+}
+static inline int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier,
+                                                  uint32_t sch, int vq,
+                                                  bool assign)
+{
+    return -ENOSYS;
+}
+static inline int kvm_s390_cpu_restart(S390CPU *cpu)
+{
+    return -ENOSYS;
+}
+static inline void kvm_s390_cmma_reset(void)
+{
+}
+static inline int kvm_s390_get_memslot_count(KVMState *s)
+{
+  return MAX_AVAIL_SLOTS;
+}
+static inline void kvm_s390_reset_vcpu(S390CPU *cpu)
+{
+}
+static inline int kvm_s390_set_mem_limit(KVMState *s, uint64_t new_limit,
+                                         uint64_t *hw_limit)
+{
+    return 0;
+}
+static inline void kvm_s390_crypto_reset(void)
+{
+}
 #endif /* CONFIG_KVM */
 
 
-- 
2.9.4
