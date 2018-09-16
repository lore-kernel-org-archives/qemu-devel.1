Received: from eggs.gnu.org ([2001:4830:134:3::10]:54569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1g1WSB-0006CS-3p
	for qemu-devel@nongnu.org; Sun, 16 Sep 2018 08:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1g1WS7-0006Tz-VD
	for qemu-devel@nongnu.org; Sun, 16 Sep 2018 08:47:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1g1WS7-0006TJ-MA
	for qemu-devel@nongnu.org; Sun, 16 Sep 2018 08:47:03 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Sun, 16 Sep 2018 15:46:30 +0300
Message-Id: <20180916124631.39016-2-liran.alon@oracle.com>
In-Reply-To: <20180916124631.39016-1-liran.alon@oracle.com>
References: <20180916124631.39016-1-liran.alon@oracle.com>
Subject: [Qemu-devel] [QEMU PATCH v2 1/2] i386: Compile CPUX86State
 xsave_buf only when support KVM or HVF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, ehabkost@redhat.com, kvm@vger.kernel.org, jmattson@google.com, Liran Alon <liran.alon@oracle.com>

While at it, also rename var to indicate it is not used only in KVM.

Reviewed-by: Nikita Leshchenko <nikita.leshchenko@oracle.com>
Reviewed-by: Patrick Colp <patrick.colp@oracle.com>
Reviewed-by: Mihai Carabas <mihai.carabas@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 target/i386/cpu.h         | 4 +++-
 target/i386/hvf/README.md | 2 +-
 target/i386/hvf/hvf.c     | 2 +-
 target/i386/hvf/x86hvf.c  | 4 ++--
 target/i386/kvm.c         | 6 +++---
 5 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b572a8e4aa41..6e4c2b02f947 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1327,7 +1327,9 @@ typedef struct CPUX86State {
     bool tsc_valid;
     int64_t tsc_khz;
     int64_t user_tsc_khz; /* for sanity check only */
-    void *kvm_xsave_buf;
+#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
+    void *xsave_buf;
+#endif
 #if defined(CONFIG_HVF)
     HVFX86EmulatorState *hvf_emul;
 #endif
diff --git a/target/i386/hvf/README.md b/target/i386/hvf/README.md
index 0d27a0d52b58..2d33477aca50 100644
--- a/target/i386/hvf/README.md
+++ b/target/i386/hvf/README.md
@@ -2,6 +2,6 @@
 
 These sources (and ../hvf-all.c) are adapted from Veertu Inc's vdhh (Veertu Desktop Hosted Hypervisor) (last known location: https://github.com/veertuinc/vdhh) with some minor changes, the most significant of which were:
 
-1. Adapt to our current QEMU's `CPUState` structure and `address_space_rw` API; many struct members have been moved around (emulated x86 state, kvm_xsave_buf) due to historical differences + QEMU needing to handle more emulation targets.
+1. Adapt to our current QEMU's `CPUState` structure and `address_space_rw` API; many struct members have been moved around (emulated x86 state, xsave_buf) due to historical differences + QEMU needing to handle more emulation targets.
 2. Removal of `apic_page` and hyperv-related functionality.
 3. More relaxed use of `qemu_mutex_lock_iothread`.
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index df69e6d0a7af..5db167df98e6 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -587,7 +587,7 @@ int hvf_init_vcpu(CPUState *cpu)
     hvf_reset_vcpu(cpu);
 
     x86cpu = X86_CPU(cpu);
-    x86cpu->env.kvm_xsave_buf = qemu_memalign(4096, 4096);
+    x86cpu->env.xsave_buf = qemu_memalign(4096, 4096);
 
     hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_STAR, 1);
     hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_LSTAR, 1);
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 6c88939b968b..df8e946fbcde 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -75,7 +75,7 @@ void hvf_put_xsave(CPUState *cpu_state)
 
     struct X86XSaveArea *xsave;
 
-    xsave = X86_CPU(cpu_state)->env.kvm_xsave_buf;
+    xsave = X86_CPU(cpu_state)->env.xsave_buf;
 
     x86_cpu_xsave_all_areas(X86_CPU(cpu_state), xsave);
 
@@ -163,7 +163,7 @@ void hvf_get_xsave(CPUState *cpu_state)
 {
     struct X86XSaveArea *xsave;
 
-    xsave = X86_CPU(cpu_state)->env.kvm_xsave_buf;
+    xsave = X86_CPU(cpu_state)->env.xsave_buf;
 
     if (hv_vcpu_read_fpstate(cpu_state->hvf_fd, (void*)xsave, 4096)) {
         abort();
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 0b2a07d3a47b..c1cd8c461fe4 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1189,7 +1189,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
 
     if (has_xsave) {
-        env->kvm_xsave_buf = qemu_memalign(4096, sizeof(struct kvm_xsave));
+        env->xsave_buf = qemu_memalign(4096, sizeof(struct kvm_xsave));
     }
     cpu->kvm_msr_buf = g_malloc0(MSR_BUF_SIZE);
 
@@ -1639,7 +1639,7 @@ ASSERT_OFFSET(XSAVE_PKRU, pkru_state);
 static int kvm_put_xsave(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
-    X86XSaveArea *xsave = env->kvm_xsave_buf;
+    X86XSaveArea *xsave = env->xsave_buf;
 
     if (!has_xsave) {
         return kvm_put_fpu(cpu);
@@ -2081,7 +2081,7 @@ static int kvm_get_fpu(X86CPU *cpu)
 static int kvm_get_xsave(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
-    X86XSaveArea *xsave = env->kvm_xsave_buf;
+    X86XSaveArea *xsave = env->xsave_buf;
     int ret;
 
     if (!has_xsave) {
-- 
2.16.1
