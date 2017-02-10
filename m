Received: from eggs.gnu.org ([2001:4830:134:3::10]:33688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cc7qR-0000Mh-Q7
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 04:50:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cc7qQ-0005P2-N3
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 04:50:23 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cc7qQ-0005Oj-Dn
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 04:50:22 -0500
Received: by mail-wm0-x243.google.com with SMTP id r18so6571166wmd.3
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 01:50:22 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 10 Feb 2017 10:50:12 +0100
Message-Id: <20170210095012.16039-8-pbonzini@redhat.com>
In-Reply-To: <20170210095012.16039-1-pbonzini@redhat.com>
References: <20170210095012.16039-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 7/7] KVM: use KVM_CAP_IMMEDIATE_EXIT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org

The purpose of the KVM_SET_SIGNAL_MASK API is to let userspace "kick"
a VCPU out of KVM_RUN through a POSIX signal.  A signal is attached
to a dummy signal handler; by blocking the signal outside KVM_RUN and
unblocking it inside, this possible race is closed:

          VCPU thread                     service thread
   --------------------------------------------------------------
        check flag
                                          set flag
                                          raise signal
        (signal handler does nothing)
        KVM_RUN

However, one issue with KVM_SET_SIGNAL_MASK is that it has to take
tsk->sighand->siglock on every KVM_RUN.  This lock is often on a
remote NUMA node, because it is on the node of a thread's creator.
Taking this lock can be very expensive if there are many userspace
exits (as is the case for SMP Windows VMs without Hyper-V reference
time counter).

KVM_CAP_IMMEDIATE_EXIT provides an alternative, where the flag is
placed directly in kvm_run so that KVM can see it:

          VCPU thread                     service thread
   --------------------------------------------------------------
                                          raise signal
        signal handler
          set run->immediate_exit
        KVM_RUN
          check run->immediate_exit

The previous patches changed QEMU so that the only blocked signal is
SIG_IPI, so we can now stop using KVM_SET_SIGNAL_MASK and sigtimedwait
if KVM_CAP_IMMEDIATE_EXIT is available.

On a 14-VCPU guest, an "inl" operation goes down from 30k to 6k on
an unlocked (no BQL) MemoryRegion, or from 30k to 15k if the BQL
is involved.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 kvm-all.c                 | 36 ++++++++++++++++++++++++++++++++----
 linux-headers/linux/kvm.h |  4 +++-
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/kvm-all.c b/kvm-all.c
index eaff0dc..083143f 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -120,6 +120,7 @@ bool kvm_vm_attributes_allowed;
 bool kvm_direct_msi_allowed;
 bool kvm_ioeventfd_any_length_allowed;
 bool kvm_msi_use_devid;
+static bool kvm_immediate_exit;
 
 static const KVMCapabilityInfo kvm_required_capabilites[] = {
     KVM_CAP_INFO(USER_MEMORY),
@@ -1619,6 +1620,7 @@ static int kvm_init(MachineState *ms)
         goto err;
     }
 
+    kvm_immediate_exit = kvm_check_extension(s, KVM_CAP_IMMEDIATE_EXIT);
     s->nr_slots = kvm_check_extension(s, KVM_CAP_NR_MEMSLOTS);
 
     /* If unspecified, use the default value */
@@ -1897,6 +1899,20 @@ static __thread void *pending_sigbus_addr;
 static __thread int pending_sigbus_code;
 static __thread bool have_sigbus_pending;
 
+static void kvm_cpu_kick(CPUState *cpu)
+{
+    atomic_set(&cpu->kvm_run->immediate_exit, 1);
+}
+
+static void kvm_cpu_kick_self(void)
+{
+    if (kvm_immediate_exit) {
+        kvm_cpu_kick(current_cpu);
+    } else {
+        qemu_cpu_kick_self();
+    }
+}
+
 static void kvm_eat_signals(CPUState *cpu)
 {
     struct timespec ts = { 0, 0 };
@@ -1905,6 +1921,10 @@ static void kvm_eat_signals(CPUState *cpu)
     sigset_t chkset;
     int r;
 
+    if (kvm_immediate_exit) {
+        return;
+    }
+
     sigemptyset(&waitset);
     sigaddset(&waitset, SIG_IPI);
 
@@ -1953,7 +1973,7 @@ int kvm_cpu_exec(CPUState *cpu)
              * instruction emulation. This self-signal will ensure that we
              * leave ASAP again.
              */
-            qemu_cpu_kick_self();
+            kvm_cpu_kick_self();
         }
 
         run_ret = kvm_vcpu_ioctl(cpu, KVM_RUN, 0);
@@ -2426,8 +2446,12 @@ static int kvm_set_signal_mask(CPUState *cpu, const sigset_t *sigset)
     return r;
 }
 
-static void dummy_signal(int sig)
+static void kvm_ipi_signal(int sig)
 {
+    if (current_cpu) {
+        assert(kvm_immediate_exit);
+        kvm_cpu_kick(current_cpu);
+    }
 }
 
 void kvm_init_cpu_signals(CPUState *cpu)
@@ -2437,7 +2461,7 @@ void kvm_init_cpu_signals(CPUState *cpu)
     struct sigaction sigact;
 
     memset(&sigact, 0, sizeof(sigact));
-    sigact.sa_handler = dummy_signal;
+    sigact.sa_handler = kvm_ipi_signal;
     sigaction(SIG_IPI, &sigact, NULL);
 
     pthread_sigmask(SIG_BLOCK, NULL, &set);
@@ -2446,7 +2470,11 @@ void kvm_init_cpu_signals(CPUState *cpu)
     pthread_sigmask(SIG_SETMASK, &set, NULL);
 #endif
     sigdelset(&set, SIG_IPI);
-    r = kvm_set_signal_mask(cpu, &set);
+    if (kvm_immediate_exit) {
+        r = pthread_sigmask(SIG_SETMASK, &set, NULL);
+    } else {
+        r = kvm_set_signal_mask(cpu, &set);
+    }
     if (r) {
         fprintf(stderr, "kvm_set_signal_mask: %s\n", strerror(-r));
         exit(1);
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index bb0ed71..b7d53ee 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -218,7 +218,8 @@ struct kvm_hyperv_exit {
 struct kvm_run {
 	/* in */
 	__u8 request_interrupt_window;
-	__u8 padding1[7];
+	__u8 immediate_exit;
+	__u8 padding1[6];
 
 	/* out */
 	__u32 exit_reason;
@@ -870,6 +871,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_S390_USER_INSTR0 130
 #define KVM_CAP_MSI_DEVID 131
 #define KVM_CAP_PPC_HTM 132
+#define KVM_CAP_IMMEDIATE_EXIT 136
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
1.8.3.1
