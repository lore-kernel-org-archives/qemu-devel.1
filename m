Received: from eggs.gnu.org ([2001:4830:134:3::10]:35915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciKgn-0004hU-AJ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:46:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciKgk-0000YR-Vk
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:46:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ciKgk-0000XZ-Lv
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:46:02 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C4C3B3B717
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 12:46:02 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-118.ams2.redhat.com
	[10.36.117.118])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1RCjpe3028718
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 07:46:02 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 27 Feb 2017 13:45:42 +0100
Message-Id: <20170227124551.8673-9-pbonzini@redhat.com>
In-Reply-To: <20170227124551.8673-1-pbonzini@redhat.com>
References: <20170227124551.8673-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 08/17] cpus: reorganize signal handling code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Move the KVM "eat signals" code under CONFIG_LINUX, in preparation
for moving it to kvm-all.c; reraise non-MCE SIGBUS immediately,
without passing it to KVM.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c               | 63 ++++++++++++++++++++++++++--------------------------
 include/qemu/osdep.h |  9 ++++++++
 target/i386/kvm.c    | 15 ++-----------
 3 files changed, 43 insertions(+), 44 deletions(-)

diff --git a/cpus.c b/cpus.c
index a628cde..399e271 100644
--- a/cpus.c
+++ b/cpus.c
@@ -922,6 +922,10 @@ static void sigbus_reraise(void)
 
 static void sigbus_handler(int n, siginfo_t *siginfo, void *ctx)
 {
+    if (siginfo->si_code != BUS_MCEERR_AO && siginfo->si_code != BUS_MCEERR_AR) {
+        sigbus_reraise();
+    }
+
     if (kvm_on_sigbus(siginfo->si_code, siginfo->si_addr)) {
         sigbus_reraise();
     }
@@ -939,6 +943,30 @@ static void qemu_init_sigbus(void)
     prctl(PR_MCE_KILL, PR_MCE_KILL_SET, PR_MCE_KILL_EARLY, 0, 0);
 }
 
+static void dummy_signal(int sig)
+{
+}
+
+static void qemu_kvm_init_cpu_signals(CPUState *cpu)
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
+    sigdelset(&set, SIG_IPI);
+    sigdelset(&set, SIGBUS);
+    r = kvm_set_signal_mask(cpu, &set);
+    if (r) {
+        fprintf(stderr, "kvm_set_signal_mask: %s\n", strerror(-r));
+        exit(1);
+    }
+}
+
 static void qemu_kvm_eat_signals(CPUState *cpu)
 {
     struct timespec ts = { 0, 0 };
@@ -960,6 +988,9 @@ static void qemu_kvm_eat_signals(CPUState *cpu)
 
         switch (r) {
         case SIGBUS:
+            if (siginfo.si_code != BUS_MCEERR_AO && siginfo.si_code != BUS_MCEERR_AR) {
+                sigbus_reraise();
+            }
             if (kvm_on_sigbus_vcpu(cpu, siginfo.si_code, siginfo.si_addr)) {
                 sigbus_reraise();
             }
@@ -975,9 +1006,7 @@ static void qemu_kvm_eat_signals(CPUState *cpu)
         }
     } while (sigismember(&chkset, SIG_IPI) || sigismember(&chkset, SIGBUS));
 }
-
 #else /* !CONFIG_LINUX */
-
 static void qemu_init_sigbus(void)
 {
 }
@@ -985,39 +1014,11 @@ static void qemu_init_sigbus(void)
 static void qemu_kvm_eat_signals(CPUState *cpu)
 {
 }
-#endif /* !CONFIG_LINUX */
-
-#ifndef _WIN32
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
-    sigdelset(&set, SIG_IPI);
-    sigdelset(&set, SIGBUS);
-    r = kvm_set_signal_mask(cpu, &set);
-    if (r) {
-        fprintf(stderr, "kvm_set_signal_mask: %s\n", strerror(-r));
-        exit(1);
-    }
-}
 
-#else /* _WIN32 */
 static void qemu_kvm_init_cpu_signals(CPUState *cpu)
 {
-    abort();
 }
-#endif /* _WIN32 */
+#endif /* !CONFIG_LINUX */
 
 static QemuMutex qemu_global_mutex;
 
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 3c394b2..8778cce 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -284,6 +284,15 @@ void qemu_anon_ram_free(void *ptr, size_t size);
 
 #endif
 
+#if defined(CONFIG_LINUX)
+#ifndef BUS_MCEERR_AR
+#define BUS_MCEERR_AR 4
+#endif
+#ifndef BUS_MCEERR_AO
+#define BUS_MCEERR_AO 5
+#endif
+#endif
+
 #if defined(__linux__) && \
     (defined(__x86_64__) || defined(__arm__) || defined(__aarch64__))
    /* Use 2 MiB alignment so transparent hugepages can be used by KVM.
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 0c48dfd..f49a786 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -64,13 +64,6 @@
  * 255 kvm_msr_entry structs */
 #define MSR_BUF_SIZE 4096
 
-#ifndef BUS_MCEERR_AR
-#define BUS_MCEERR_AR 4
-#endif
-#ifndef BUS_MCEERR_AO
-#define BUS_MCEERR_AO 5
-#endif
-
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(SET_TSS_ADDR),
     KVM_CAP_INFO(EXT_CPUID),
@@ -469,9 +462,7 @@ int kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
     ram_addr_t ram_addr;
     hwaddr paddr;
 
-    if (code != BUS_MCEERR_AR && code != BUS_MCEERR_AO) {
-        return 1;
-    }
+    assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
 
     /* Because the MCE happened while running the VCPU, KVM could have
      * injected action required MCEs too.  Action optional MCEs should
@@ -504,9 +495,7 @@ int kvm_arch_on_sigbus(int code, void *addr)
 {
     X86CPU *cpu = X86_CPU(first_cpu);
 
-    if (code != BUS_MCEERR_AR && code != BUS_MCEERR_AO) {
-        return 1;
-    }
+    assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
 
     if (code == BUS_MCEERR_AR) {
         hardware_memory_error();
-- 
2.9.3
