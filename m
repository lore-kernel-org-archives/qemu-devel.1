Received: from eggs.gnu.org ([2001:4830:134:3::10]:46741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cikPg-00037K-I0
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:14:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cikPd-0000sL-Fy
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:14:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cikPd-0000s1-5w
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:14:05 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6AA8061B96
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 16:14:05 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-252.ams2.redhat.com
	[10.36.117.252])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1SGE33P015424
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 11:14:04 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 28 Feb 2017 17:14:00 +0100
Message-Id: <20170228161402.25122-2-pbonzini@redhat.com>
In-Reply-To: <20170228161402.25122-1-pbonzini@redhat.com>
References: <20170228161402.25122-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 10/19] KVM: do not use sigtimedwait to catch
 SIGBUS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Call kvm_on_sigbus_vcpu asynchronously from the VCPU thread.
Information for the SIGBUS can be stored in thread-local variables
and processed later in kvm_cpu_exec.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c               | 31 +++++++++++++------------------
 include/sysemu/kvm.h |  5 ++++-
 kvm-all.c            | 35 ++++++++++++++++++++++++++++++++++-
 target/arm/kvm.c     |  5 -----
 target/i386/kvm.c    |  5 ++---
 target/mips/kvm.c    |  6 ------
 target/ppc/kvm.c     |  5 -----
 target/s390x/kvm.c   |  5 -----
 8 files changed, 53 insertions(+), 44 deletions(-)

diff --git a/cpus.c b/cpus.c
index 399e271..56b1338 100644
--- a/cpus.c
+++ b/cpus.c
@@ -926,8 +926,16 @@ static void sigbus_handler(int n, siginfo_t *siginfo, void *ctx)
         sigbus_reraise();
     }
 
-    if (kvm_on_sigbus(siginfo->si_code, siginfo->si_addr)) {
-        sigbus_reraise();
+    if (current_cpu) {
+        /* Called asynchronously in VCPU thread.  */
+        if (kvm_on_sigbus_vcpu(current_cpu, siginfo->si_code, siginfo->si_addr)) {
+            sigbus_reraise();
+        }
+    } else {
+        /* Called synchronously (via signalfd) in main thread.  */
+        if (kvm_on_sigbus(siginfo->si_code, siginfo->si_addr)) {
+            sigbus_reraise();
+        }
     }
 }
 
@@ -958,8 +966,9 @@ static void qemu_kvm_init_cpu_signals(CPUState *cpu)
     sigaction(SIG_IPI, &sigact, NULL);
 
     pthread_sigmask(SIG_BLOCK, NULL, &set);
-    sigdelset(&set, SIG_IPI);
     sigdelset(&set, SIGBUS);
+    pthread_sigmask(SIG_SETMASK, &set, NULL);
+    sigdelset(&set, SIG_IPI);
     r = kvm_set_signal_mask(cpu, &set);
     if (r) {
         fprintf(stderr, "kvm_set_signal_mask: %s\n", strerror(-r));
@@ -977,7 +986,6 @@ static void qemu_kvm_eat_signals(CPUState *cpu)
 
     sigemptyset(&waitset);
     sigaddset(&waitset, SIG_IPI);
-    sigaddset(&waitset, SIGBUS);
 
     do {
         r = sigtimedwait(&waitset, &siginfo, &ts);
@@ -986,25 +994,12 @@ static void qemu_kvm_eat_signals(CPUState *cpu)
             exit(1);
         }
 
-        switch (r) {
-        case SIGBUS:
-            if (siginfo.si_code != BUS_MCEERR_AO && siginfo.si_code != BUS_MCEERR_AR) {
-                sigbus_reraise();
-            }
-            if (kvm_on_sigbus_vcpu(cpu, siginfo.si_code, siginfo.si_addr)) {
-                sigbus_reraise();
-            }
-            break;
-        default:
-            break;
-        }
-
         r = sigpending(&chkset);
         if (r == -1) {
             perror("sigpending");
             exit(1);
         }
-    } while (sigismember(&chkset, SIG_IPI) || sigismember(&chkset, SIGBUS));
+    } while (sigismember(&chkset, SIG_IPI));
 }
 #else /* !CONFIG_LINUX */
 static void qemu_init_sigbus(void)
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 6ecb61c..a1b019d 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -357,7 +357,10 @@ bool kvm_vcpu_id_is_valid(int vcpu_id);
 /* Returns VCPU ID to be used on KVM_CREATE_VCPU ioctl() */
 unsigned long kvm_arch_vcpu_id(CPUState *cpu);
 
-int kvm_arch_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
+#ifdef TARGET_I386
+#define KVM_HAVE_MCE_INJECTION 1
+void kvm_arch_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
+#endif
 
 void kvm_arch_init_irq_routing(KVMState *s);
 
diff --git a/kvm-all.c b/kvm-all.c
index a433ad3..0baa193 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -1893,6 +1893,12 @@ void kvm_cpu_synchronize_post_init(CPUState *cpu)
     run_on_cpu(cpu, do_kvm_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
 }
 
+#ifdef KVM_HAVE_MCE_INJECTION
+static __thread void *pending_sigbus_addr;
+static __thread int pending_sigbus_code;
+static __thread bool have_sigbus_pending;
+#endif
+
 int kvm_cpu_exec(CPUState *cpu)
 {
     struct kvm_run *run = cpu->kvm_run;
@@ -1930,6 +1936,16 @@ int kvm_cpu_exec(CPUState *cpu)
 
         attrs = kvm_arch_post_run(cpu, run);
 
+#ifdef KVM_HAVE_MCE_INJECTION
+        if (unlikely(have_sigbus_pending)) {
+            qemu_mutex_lock_iothread();
+            kvm_arch_on_sigbus_vcpu(cpu, pending_sigbus_code,
+                                    pending_sigbus_addr);
+            have_sigbus_pending = false;
+            qemu_mutex_unlock_iothread();
+        }
+#endif
+
         if (run_ret < 0) {
             if (run_ret == -EINTR || run_ret == -EAGAIN) {
                 DPRINTF("io window exit\n");
@@ -2392,13 +2408,27 @@ int kvm_set_signal_mask(CPUState *cpu, const sigset_t *sigset)
     return r;
 }
 
+/* Called asynchronously in VCPU thread.  */
 int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr)
 {
-    return kvm_arch_on_sigbus_vcpu(cpu, code, addr);
+#ifdef KVM_HAVE_MCE_INJECTION
+    if (have_sigbus_pending) {
+        return 1;
+    }
+    have_sigbus_pending = true;
+    pending_sigbus_addr = addr;
+    pending_sigbus_code = code;
+    atomic_set(&cpu->exit_request, 1);
+    return 0;
+#else
+    return 1;
+#endif
 }
 
+/* Called synchronously (via signalfd) in main thread.  */
 int kvm_on_sigbus(int code, void *addr)
 {
+#ifdef KVM_HAVE_MCE_INJECTION
     /* Action required MCE kills the process if SIGBUS is blocked.  Because
      * that's what happens in the I/O thread, where we handle MCE via signalfd,
      * we can only get action optional here.
@@ -2406,6 +2436,9 @@ int kvm_on_sigbus(int code, void *addr)
     assert(code != BUS_MCEERR_AR);
     kvm_arch_on_sigbus_vcpu(first_cpu, code, addr);
     return 0;
+#else
+    return 1;
+#endif
 }
 
 int kvm_create_device(KVMState *s, uint64_t type, bool test)
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index e5218f6..4555468 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -560,11 +560,6 @@ int kvm_arch_process_async_events(CPUState *cs)
     return 0;
 }
 
-int kvm_arch_on_sigbus_vcpu(CPUState *cs, int code, void *addr)
-{
-    return 1;
-}
-
 /* The #ifdef protections are until 32bit headers are imported and can
  * be removed once both 32 and 64 bit reach feature parity.
  */
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 2adf992..7698421 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -455,7 +455,7 @@ static void hardware_memory_error(void)
     exit(1);
 }
 
-int kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
+void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
 {
     X86CPU *cpu = X86_CPU(c);
     CPUX86State *env = &cpu->env;
@@ -475,7 +475,7 @@ int kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
             kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
             kvm_hwpoison_page_add(ram_addr);
             kvm_mce_inject(cpu, paddr, code);
-            return 0;
+            return;
         }
 
         fprintf(stderr, "Hardware memory error for memory used by "
@@ -487,7 +487,6 @@ int kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
     }
 
     /* Hope we are lucky for AO MCE */
-    return 0;
 }
 
 static int kvm_inject_mce_oldstyle(X86CPU *cpu)
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index 3e686e7..0982e87 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -180,12 +180,6 @@ bool kvm_arch_stop_on_emulation_error(CPUState *cs)
     return true;
 }
 
-int kvm_arch_on_sigbus_vcpu(CPUState *cs, int code, void *addr)
-{
-    DPRINTF("%s\n", __func__);
-    return 1;
-}
-
 void kvm_arch_init_irq_routing(KVMState *s)
 {
 }
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index bc011c6..f22ecab 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2582,11 +2582,6 @@ bool kvm_arch_stop_on_emulation_error(CPUState *cpu)
     return true;
 }
 
-int kvm_arch_on_sigbus_vcpu(CPUState *cpu, int code, void *addr)
-{
-    return 1;
-}
-
 void kvm_arch_init_irq_routing(KVMState *s)
 {
 }
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index e7eea6d..ac47154 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2140,11 +2140,6 @@ bool kvm_arch_stop_on_emulation_error(CPUState *cpu)
     return true;
 }
 
-int kvm_arch_on_sigbus_vcpu(CPUState *cpu, int code, void *addr)
-{
-    return 1;
-}
-
 void kvm_s390_io_interrupt(uint16_t subchannel_id,
                            uint16_t subchannel_nr, uint32_t io_int_parm,
                            uint32_t io_int_word)
-- 
2.9.3
