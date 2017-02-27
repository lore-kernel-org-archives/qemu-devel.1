Received: from eggs.gnu.org ([2001:4830:134:3::10]:36069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciKgq-0004k4-Qu
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:46:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciKgo-0000cK-MH
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:46:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ciKgo-0000b9-6a
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:46:06 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A1CA3B712
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 12:46:06 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-118.ams2.redhat.com
	[10.36.117.118])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1RCjpe6028718
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 07:46:05 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 27 Feb 2017 13:45:45 +0100
Message-Id: <20170227124551.8673-12-pbonzini@redhat.com>
In-Reply-To: <20170227124551.8673-1-pbonzini@redhat.com>
References: <20170227124551.8673-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 11/17] KVM: move SIG_IPI handling to kvm-all.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This lets us remove a bunch of CONFIG_LINUX defines.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c               | 62 +---------------------------------------------------
 include/sysemu/kvm.h |  5 ++---
 kvm-all.c            | 60 +++++++++++++++++++++++++++++++++++++++++++++-----
 kvm-stub.c           | 12 +++++-----
 4 files changed, 63 insertions(+), 76 deletions(-)

diff --git a/cpus.c b/cpus.c
index 56b1338..c857ad2 100644
--- a/cpus.c
+++ b/cpus.c
@@ -950,69 +950,10 @@ static void qemu_init_sigbus(void)
 
     prctl(PR_MCE_KILL, PR_MCE_KILL_SET, PR_MCE_KILL_EARLY, 0, 0);
 }
-
-static void dummy_signal(int sig)
-{
-}
-
-static void qemu_kvm_init_cpu_signals(CPUState *cpu)
-{
-    int r;
-    sigset_t set;
-    struct sigaction sigact;
-
-    memset(&sigact, 0, sizeof(sigact));
-    sigact.sa_handler = dummy_signal;
-    sigaction(SIG_IPI, &sigact, NULL);
-
-    pthread_sigmask(SIG_BLOCK, NULL, &set);
-    sigdelset(&set, SIGBUS);
-    pthread_sigmask(SIG_SETMASK, &set, NULL);
-    sigdelset(&set, SIG_IPI);
-    r = kvm_set_signal_mask(cpu, &set);
-    if (r) {
-        fprintf(stderr, "kvm_set_signal_mask: %s\n", strerror(-r));
-        exit(1);
-    }
-}
-
-static void qemu_kvm_eat_signals(CPUState *cpu)
-{
-    struct timespec ts = { 0, 0 };
-    siginfo_t siginfo;
-    sigset_t waitset;
-    sigset_t chkset;
-    int r;
-
-    sigemptyset(&waitset);
-    sigaddset(&waitset, SIG_IPI);
-
-    do {
-        r = sigtimedwait(&waitset, &siginfo, &ts);
-        if (r == -1 && !(errno == EAGAIN || errno == EINTR)) {
-            perror("sigtimedwait");
-            exit(1);
-        }
-
-        r = sigpending(&chkset);
-        if (r == -1) {
-            perror("sigpending");
-            exit(1);
-        }
-    } while (sigismember(&chkset, SIG_IPI));
-}
 #else /* !CONFIG_LINUX */
 static void qemu_init_sigbus(void)
 {
 }
-
-static void qemu_kvm_eat_signals(CPUState *cpu)
-{
-}
-
-static void qemu_kvm_init_cpu_signals(CPUState *cpu)
-{
-}
 #endif /* !CONFIG_LINUX */
 
 static QemuMutex qemu_global_mutex;
@@ -1089,7 +1030,6 @@ static void qemu_kvm_wait_io_event(CPUState *cpu)
         qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
     }
 
-    qemu_kvm_eat_signals(cpu);
     qemu_wait_io_event_common(cpu);
 }
 
@@ -1112,7 +1052,7 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
         exit(1);
     }
 
-    qemu_kvm_init_cpu_signals(cpu);
+    kvm_init_cpu_signals(cpu);
 
     /* signal CPU creation */
     cpu->created = true;
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index a1b019d..24281fc 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -238,9 +238,6 @@ int kvm_remove_breakpoint(CPUState *cpu, target_ulong addr,
                           target_ulong len, int type);
 void kvm_remove_all_breakpoints(CPUState *cpu);
 int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap);
-#ifndef _WIN32
-int kvm_set_signal_mask(CPUState *cpu, const sigset_t *sigset);
-#endif
 
 int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
 int kvm_on_sigbus(int code, void *addr);
@@ -463,6 +460,8 @@ void kvm_cpu_synchronize_state(CPUState *cpu);
 void kvm_cpu_synchronize_post_reset(CPUState *cpu);
 void kvm_cpu_synchronize_post_init(CPUState *cpu);
 
+void kvm_init_cpu_signals(CPUState *cpu);
+
 /**
  * kvm_irqchip_add_msi_route - Add MSI route for specific vector
  * @s:      KVM state
diff --git a/kvm-all.c b/kvm-all.c
index a84040f..5bbdc44 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -1897,6 +1897,32 @@ static __thread void *pending_sigbus_addr;
 static __thread int pending_sigbus_code;
 static __thread bool have_sigbus_pending;
 
+static void kvm_eat_signals(CPUState *cpu)
+{
+    struct timespec ts = { 0, 0 };
+    siginfo_t siginfo;
+    sigset_t waitset;
+    sigset_t chkset;
+    int r;
+
+    sigemptyset(&waitset);
+    sigaddset(&waitset, SIG_IPI);
+
+    do {
+        r = sigtimedwait(&waitset, &siginfo, &ts);
+        if (r == -1 && !(errno == EAGAIN || errno == EINTR)) {
+            perror("sigtimedwait");
+            exit(1);
+        }
+
+        r = sigpending(&chkset);
+        if (r == -1) {
+            perror("sigpending");
+            exit(1);
+        }
+    } while (sigismember(&chkset, SIG_IPI));
+}
+
 int kvm_cpu_exec(CPUState *cpu)
 {
     struct kvm_run *run = cpu->kvm_run;
@@ -1949,6 +1975,7 @@ int kvm_cpu_exec(CPUState *cpu)
         if (run_ret < 0) {
             if (run_ret == -EINTR || run_ret == -EAGAIN) {
                 DPRINTF("io window exit\n");
+                kvm_eat_signals(cpu);
                 ret = EXCP_INTERRUPT;
                 break;
             }
@@ -2388,16 +2415,12 @@ void kvm_remove_all_breakpoints(CPUState *cpu)
 }
 #endif /* !KVM_CAP_SET_GUEST_DEBUG */
 
-int kvm_set_signal_mask(CPUState *cpu, const sigset_t *sigset)
+static int kvm_set_signal_mask(CPUState *cpu, const sigset_t *sigset)
 {
     KVMState *s = kvm_state;
     struct kvm_signal_mask *sigmask;
     int r;
 
-    if (!sigset) {
-        return kvm_vcpu_ioctl(cpu, KVM_SET_SIGNAL_MASK, NULL);
-    }
-
     sigmask = g_malloc(sizeof(*sigmask) + sizeof(*sigset));
 
     sigmask->len = s->sigmask_len;
@@ -2408,6 +2431,33 @@ int kvm_set_signal_mask(CPUState *cpu, const sigset_t *sigset)
     return r;
 }
 
+static void dummy_signal(int sig)
+{
+}
+
+void kvm_init_cpu_signals(CPUState *cpu)
+{
+    int r;
+    sigset_t set;
+    struct sigaction sigact;
+
+    memset(&sigact, 0, sizeof(sigact));
+    sigact.sa_handler = dummy_signal;
+    sigaction(SIG_IPI, &sigact, NULL);
+
+    pthread_sigmask(SIG_BLOCK, NULL, &set);
+#if defined KVM_HAVE_MCE_INJECTION
+    sigdelset(&set, SIGBUS);
+    pthread_sigmask(SIG_SETMASK, &set, NULL);
+#endif
+    sigdelset(&set, SIG_IPI);
+    r = kvm_set_signal_mask(cpu, &set);
+    if (r) {
+        fprintf(stderr, "kvm_set_signal_mask: %s\n", strerror(-r));
+        exit(1);
+    }
+}
+
 /* Called asynchronously in VCPU thread.  */
 int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr)
 {
diff --git a/kvm-stub.c b/kvm-stub.c
index b1b6b96..ef0c734 100644
--- a/kvm-stub.c
+++ b/kvm-stub.c
@@ -95,13 +95,6 @@ void kvm_remove_all_breakpoints(CPUState *cpu)
 {
 }
 
-#ifndef _WIN32
-int kvm_set_signal_mask(CPUState *cpu, const sigset_t *sigset)
-{
-    abort();
-}
-#endif
-
 int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr)
 {
     return 1;
@@ -157,4 +150,9 @@ bool kvm_has_free_slot(MachineState *ms)
 {
     return false;
 }
+
+void kvm_init_cpu_signals(CPUState *cpu)
+{
+    abort();
+}
 #endif
-- 
2.9.3
