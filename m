Received: from eggs.gnu.org ([2001:4830:134:3::10]:53437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfZ5-0003wk-2I
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfZ1-0003BY-3L
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxfZ0-0003BB-Qp
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:43 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 22:36:50 +0200
Message-Id: <20170928203708.9376-13-david@redhat.com>
In-Reply-To: <20170928203708.9376-1-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 12/30] s390x/kvm: generalize SIGP stop and
 restart interrupt injection
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Preparation for factoring it out into !kvm code.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
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
index c1eaaea98b..64b3f519ef 100644
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
index 261e1cdc44..18b53b2ad6 100644
--- a/target/s390x/kvm-stub.c
+++ b/target/s390x/kvm-stub.c
@@ -109,3 +109,11 @@ int kvm_s390_set_mem_limit(uint64_t new_limit, uint64_t *hw_limit)
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
index 43f8f7331a..7f2623f679 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1502,9 +1502,6 @@ static void sigp_stop(CPUState *cs, run_on_cpu_data arg)
 {
     S390CPU *cpu = S390_CPU(cs);
     SigpInfo *si = arg.host_ptr;
-    struct kvm_s390_irq irq = {
-        .type = KVM_S390_SIGP_STOP,
-    };
 
     if (s390_cpu_get_state(cpu) != CPU_STATE_OPERATING) {
         si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
@@ -1517,7 +1514,7 @@ static void sigp_stop(CPUState *cs, run_on_cpu_data arg)
     } else {
         /* execute the stop function */
         cpu->env.sigp_order = SIGP_STOP;
-        kvm_s390_vcpu_interrupt(cpu, &irq);
+        cpu_inject_stop(cpu);
     }
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
 }
@@ -1616,9 +1613,6 @@ static void sigp_stop_and_store_status(CPUState *cs, run_on_cpu_data arg)
 {
     S390CPU *cpu = S390_CPU(cs);
     SigpInfo *si = arg.host_ptr;
-    struct kvm_s390_irq irq = {
-        .type = KVM_S390_SIGP_STOP,
-    };
 
     /* disabled wait - sleeping in user space */
     if (s390_cpu_get_state(cpu) == CPU_STATE_OPERATING && cs->halted) {
@@ -1628,7 +1622,7 @@ static void sigp_stop_and_store_status(CPUState *cs, run_on_cpu_data arg)
     switch (s390_cpu_get_state(cpu)) {
     case CPU_STATE_OPERATING:
         cpu->env.sigp_order = SIGP_STOP_STORE_STATUS;
-        kvm_s390_vcpu_interrupt(cpu, &irq);
+        cpu_inject_stop(cpu);
         /* store will be performed when handling the stop intercept */
         break;
     case CPU_STATE_STOPPED:
@@ -1718,9 +1712,6 @@ static void sigp_restart(CPUState *cs, run_on_cpu_data arg)
 {
     S390CPU *cpu = S390_CPU(cs);
     SigpInfo *si = arg.host_ptr;
-    struct kvm_s390_irq irq = {
-        .type = KVM_S390_RESTART,
-    };
 
     switch (s390_cpu_get_state(cpu)) {
     case CPU_STATE_STOPPED:
@@ -1730,7 +1721,7 @@ static void sigp_restart(CPUState *cs, run_on_cpu_data arg)
         s390_cpu_set_state(CPU_STATE_OPERATING, cpu);
         break;
     case CPU_STATE_OPERATING:
-        kvm_s390_vcpu_interrupt(cpu, &irq);
+        cpu_inject_restart(cpu);
         break;
     }
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
@@ -2781,3 +2772,21 @@ void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
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
index 2d594bd4ee..fd03cd662a 100644
--- a/target/s390x/kvm_s390x.h
+++ b/target/s390x/kvm_s390x.h
@@ -40,6 +40,8 @@ void kvm_s390_cmma_reset(void);
 void kvm_s390_reset_vcpu(S390CPU *cpu);
 int kvm_s390_set_mem_limit(uint64_t new_limit, uint64_t *hw_limit);
 void kvm_s390_crypto_reset(void);
+void kvm_s390_restart_interrupt(S390CPU *cpu);
+void kvm_s390_stop_interrupt(S390CPU *cpu);
 
 /* implemented outside of target/s390x/ */
 int kvm_s390_inject_flic(struct kvm_s390_irq *irq);
-- 
2.13.5
