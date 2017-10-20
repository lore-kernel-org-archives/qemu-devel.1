Received: from eggs.gnu.org ([2001:4830:134:3::10]:58683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5VtR-0002Zl-4J
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5VtP-0003Bo-PA
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:55:13 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:53:46 +0200
Message-Id: <20171020115418.2050-15-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 14/46] s390x/kvm: generalize SIGP stop and
 restart interrupt injection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Preparation for factoring it out into !kvm code.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170928203708.9376-13-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/internal.h  |  2 ++
 target/s390x/interrupt.c | 20 ++++++++++++++++++++
 target/s390x/kvm-stub.c  |  8 ++++++++
 target/s390x/kvm.c       | 33 +++++++++++++++++++++------------
 target/s390x/kvm_s390x.h |  2 ++
 5 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 6e500d6bb7..0ac026d30f 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -369,6 +369,8 @@ bool s390_cpu_has_io_int(S390CPU *cpu);
 bool s390_cpu_has_ext_int(S390CPU *cpu);
 bool s390_cpu_has_mcck_int(S390CPU *cpu);
 bool s390_cpu_has_int(S390CPU *cpu);
+void cpu_inject_restart(S390CPU *cpu);
+void cpu_inject_stop(S390CPU *cpu);
 
 
 /* ioinst.c */
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 83a0f194f8..462d45e95f 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -107,6 +107,26 @@ int cpu_inject_external_call(S390CPU *cpu, uint16_t src_cpu_addr)
     return 0;
 }
 
+void cpu_inject_restart(S390CPU *cpu)
+{
+    if (kvm_enabled()) {
+        kvm_s390_restart_interrupt(cpu);
+        return;
+    }
+    /* FIXME TCG */
+    g_assert_not_reached();
+}
+
+void cpu_inject_stop(S390CPU *cpu)
+{
+    if (kvm_enabled()) {
+        kvm_s390_stop_interrupt(cpu);
+        return;
+    }
+    /* FIXME TCG */
+    g_assert_not_reached();
+}
+
 static void cpu_inject_io(S390CPU *cpu, uint16_t subchannel_id,
                           uint16_t subchannel_number,
                           uint32_t io_int_parm, uint32_t io_int_word)
diff --git a/target/s390x/kvm-stub.c b/target/s390x/kvm-stub.c
index 43f02c2d69..b27ed2927a 100644
--- a/target/s390x/kvm-stub.c
+++ b/target/s390x/kvm-stub.c
@@ -119,3 +119,11 @@ int kvm_s390_set_mem_limit(uint64_t new_limit, uint64_t *hw_limit)
 void kvm_s390_crypto_reset(void)
 {
 }
+
+void kvm_s390_stop_interrupt(S390CPU *cpu)
+{
+}
+
+void kvm_s390_restart_interrupt(S390CPU *cpu)
+{
+}
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 2e75bda31a..98fa1c59a9 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1539,9 +1539,6 @@ static void sigp_stop(CPUState *cs, run_on_cpu_data arg)
 {
     S390CPU *cpu = S390_CPU(cs);
     SigpInfo *si = arg.host_ptr;
-    struct kvm_s390_irq irq = {
-        .type = KVM_S390_SIGP_STOP,
-    };
 
     if (s390_cpu_get_state(cpu) != CPU_STATE_OPERATING) {
         si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
@@ -1554,7 +1551,7 @@ static void sigp_stop(CPUState *cs, run_on_cpu_data arg)
     } else {
         /* execute the stop function */
         cpu->env.sigp_order = SIGP_STOP;
-        kvm_s390_vcpu_interrupt(cpu, &irq);
+        cpu_inject_stop(cpu);
     }
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
 }
@@ -1653,9 +1650,6 @@ static void sigp_stop_and_store_status(CPUState *cs, run_on_cpu_data arg)
 {
     S390CPU *cpu = S390_CPU(cs);
     SigpInfo *si = arg.host_ptr;
-    struct kvm_s390_irq irq = {
-        .type = KVM_S390_SIGP_STOP,
-    };
 
     /* disabled wait - sleeping in user space */
     if (s390_cpu_get_state(cpu) == CPU_STATE_OPERATING && cs->halted) {
@@ -1665,7 +1659,7 @@ static void sigp_stop_and_store_status(CPUState *cs, run_on_cpu_data arg)
     switch (s390_cpu_get_state(cpu)) {
     case CPU_STATE_OPERATING:
         cpu->env.sigp_order = SIGP_STOP_STORE_STATUS;
-        kvm_s390_vcpu_interrupt(cpu, &irq);
+        cpu_inject_stop(cpu);
         /* store will be performed when handling the stop intercept */
         break;
     case CPU_STATE_STOPPED:
@@ -1755,9 +1749,6 @@ static void sigp_restart(CPUState *cs, run_on_cpu_data arg)
 {
     S390CPU *cpu = S390_CPU(cs);
     SigpInfo *si = arg.host_ptr;
-    struct kvm_s390_irq irq = {
-        .type = KVM_S390_RESTART,
-    };
 
     switch (s390_cpu_get_state(cpu)) {
     case CPU_STATE_STOPPED:
@@ -1767,7 +1758,7 @@ static void sigp_restart(CPUState *cs, run_on_cpu_data arg)
         s390_cpu_set_state(CPU_STATE_OPERATING, cpu);
         break;
     case CPU_STATE_OPERATING:
-        kvm_s390_vcpu_interrupt(cpu, &irq);
+        cpu_inject_restart(cpu);
         break;
     }
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
@@ -2818,3 +2809,21 @@ void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
         kvm_s390_enable_cmma();
     }
 }
+
+void kvm_s390_restart_interrupt(S390CPU *cpu)
+{
+    struct kvm_s390_irq irq = {
+        .type = KVM_S390_RESTART,
+    };
+
+    kvm_s390_vcpu_interrupt(cpu, &irq);
+}
+
+void kvm_s390_stop_interrupt(S390CPU *cpu)
+{
+    struct kvm_s390_irq irq = {
+        .type = KVM_S390_SIGP_STOP,
+    };
+
+    kvm_s390_vcpu_interrupt(cpu, &irq);
+}
diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
index 501fc5aabd..46dbb742f0 100644
--- a/target/s390x/kvm_s390x.h
+++ b/target/s390x/kvm_s390x.h
@@ -42,6 +42,8 @@ void kvm_s390_cmma_reset(void);
 void kvm_s390_reset_vcpu(S390CPU *cpu);
 int kvm_s390_set_mem_limit(uint64_t new_limit, uint64_t *hw_limit);
 void kvm_s390_crypto_reset(void);
+void kvm_s390_restart_interrupt(S390CPU *cpu);
+void kvm_s390_stop_interrupt(S390CPU *cpu);
 
 /* implemented outside of target/s390x/ */
 int kvm_s390_inject_flic(struct kvm_s390_irq *irq);
-- 
2.13.6
