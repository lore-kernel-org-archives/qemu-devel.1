Received: from eggs.gnu.org ([2001:4830:134:3::10]:46544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWk-0004aq-2U
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWi-0007dK-3O
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:10 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSeWh-0007bk-Ql
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:08 -0400
Received: by mail-wm0-x242.google.com with SMTP id y5so30407863wmh.3
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:15:07 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Jul 2017 09:14:17 +0200
Message-Id: <1499238885-26161-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 14/42] xsave_helper: pull xsave and xrstor out
 of kvm.c into helper function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>, Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>

From: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>

This patch pulls out of kvm.c and into the new files the implementation
for the xsave and xrstor instructions. This so they can be shared by
kvm and hvf.

Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
Message-Id: <20170626200832.11058-1-Sergio.G.DelReal@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
---
 target/i386/Makefile.objs  |   1 +
 target/i386/cpu.h          |   2 +
 target/i386/kvm.c          |  91 ++----------------------------------
 target/i386/xsave_helper.c | 114 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+), 88 deletions(-)
 create mode 100644 target/i386/xsave_helper.c

diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index 4fcb7f3..ca3bd21 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -1,6 +1,7 @@
 obj-y += translate.o helper.o cpu.o bpt_helper.o
 obj-y += excp_helper.o fpu_helper.o cc_helper.o int_helper.o svm_helper.o
 obj-y += smm_helper.o misc_helper.o mem_helper.o seg_helper.o mpx_helper.o
+obj-y += xsave_helper.o
 obj-y += gdbstub.o
 obj-$(CONFIG_SOFTMMU) += machine.o arch_memory_mapping.o arch_dump.o monitor.o
 obj-$(CONFIG_KVM) += kvm.o hyperv.o
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index de0551f..c5e143e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1697,4 +1697,6 @@ void x86_cpu_dump_local_apic_state(CPUState *cs, FILE *f,
 /* cpu.c */
 bool cpu_is_bsp(X86CPU *cpu);
 
+void x86_cpu_xrstor_all_areas(X86CPU *cpu, const X86XSaveArea *buf);
+void x86_cpu_xsave_all_areas(X86CPU *cpu, X86XSaveArea *buf);
 #endif /* I386_CPU_H */
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index ee36502..f84a49d 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1433,56 +1433,12 @@ static int kvm_put_xsave(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
     X86XSaveArea *xsave = env->kvm_xsave_buf;
-    uint16_t cwd, swd, twd;
-    int i;
 
     if (!has_xsave) {
         return kvm_put_fpu(cpu);
     }
+    x86_cpu_xsave_all_areas(cpu, xsave);
 
-    memset(xsave, 0, sizeof(struct kvm_xsave));
-    twd = 0;
-    swd = env->fpus & ~(7 << 11);
-    swd |= (env->fpstt & 7) << 11;
-    cwd = env->fpuc;
-    for (i = 0; i < 8; ++i) {
-        twd |= (!env->fptags[i]) << i;
-    }
-    xsave->legacy.fcw = cwd;
-    xsave->legacy.fsw = swd;
-    xsave->legacy.ftw = twd;
-    xsave->legacy.fpop = env->fpop;
-    xsave->legacy.fpip = env->fpip;
-    xsave->legacy.fpdp = env->fpdp;
-    memcpy(&xsave->legacy.fpregs, env->fpregs,
-            sizeof env->fpregs);
-    xsave->legacy.mxcsr = env->mxcsr;
-    xsave->header.xstate_bv = env->xstate_bv;
-    memcpy(&xsave->bndreg_state.bnd_regs, env->bnd_regs,
-            sizeof env->bnd_regs);
-    xsave->bndcsr_state.bndcsr = env->bndcs_regs;
-    memcpy(&xsave->opmask_state.opmask_regs, env->opmask_regs,
-            sizeof env->opmask_regs);
-
-    for (i = 0; i < CPU_NB_REGS; i++) {
-        uint8_t *xmm = xsave->legacy.xmm_regs[i];
-        uint8_t *ymmh = xsave->avx_state.ymmh[i];
-        uint8_t *zmmh = xsave->zmm_hi256_state.zmm_hi256[i];
-        stq_p(xmm,     env->xmm_regs[i].ZMM_Q(0));
-        stq_p(xmm+8,   env->xmm_regs[i].ZMM_Q(1));
-        stq_p(ymmh,    env->xmm_regs[i].ZMM_Q(2));
-        stq_p(ymmh+8,  env->xmm_regs[i].ZMM_Q(3));
-        stq_p(zmmh,    env->xmm_regs[i].ZMM_Q(4));
-        stq_p(zmmh+8,  env->xmm_regs[i].ZMM_Q(5));
-        stq_p(zmmh+16, env->xmm_regs[i].ZMM_Q(6));
-        stq_p(zmmh+24, env->xmm_regs[i].ZMM_Q(7));
-    }
-
-#ifdef TARGET_X86_64
-    memcpy(&xsave->hi16_zmm_state.hi16_zmm, &env->xmm_regs[16],
-            16 * sizeof env->xmm_regs[16]);
-    memcpy(&xsave->pkru_state, &env->pkru, sizeof env->pkru);
-#endif
     return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_XSAVE, xsave);
 }
 
@@ -1868,8 +1824,7 @@ static int kvm_get_xsave(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
     X86XSaveArea *xsave = env->kvm_xsave_buf;
-    int ret, i;
-    uint16_t cwd, swd, twd;
+    int ret;
 
     if (!has_xsave) {
         return kvm_get_fpu(cpu);
@@ -1879,48 +1834,8 @@ static int kvm_get_xsave(X86CPU *cpu)
     if (ret < 0) {
         return ret;
     }
+    x86_cpu_xrstor_all_areas(cpu, xsave);
 
-    cwd = xsave->legacy.fcw;
-    swd = xsave->legacy.fsw;
-    twd = xsave->legacy.ftw;
-    env->fpop = xsave->legacy.fpop;
-    env->fpstt = (swd >> 11) & 7;
-    env->fpus = swd;
-    env->fpuc = cwd;
-    for (i = 0; i < 8; ++i) {
-        env->fptags[i] = !((twd >> i) & 1);
-    }
-    env->fpip = xsave->legacy.fpip;
-    env->fpdp = xsave->legacy.fpdp;
-    env->mxcsr = xsave->legacy.mxcsr;
-    memcpy(env->fpregs, &xsave->legacy.fpregs,
-            sizeof env->fpregs);
-    env->xstate_bv = xsave->header.xstate_bv;
-    memcpy(env->bnd_regs, &xsave->bndreg_state.bnd_regs,
-            sizeof env->bnd_regs);
-    env->bndcs_regs = xsave->bndcsr_state.bndcsr;
-    memcpy(env->opmask_regs, &xsave->opmask_state.opmask_regs,
-            sizeof env->opmask_regs);
-
-    for (i = 0; i < CPU_NB_REGS; i++) {
-        uint8_t *xmm = xsave->legacy.xmm_regs[i];
-        uint8_t *ymmh = xsave->avx_state.ymmh[i];
-        uint8_t *zmmh = xsave->zmm_hi256_state.zmm_hi256[i];
-        env->xmm_regs[i].ZMM_Q(0) = ldq_p(xmm);
-        env->xmm_regs[i].ZMM_Q(1) = ldq_p(xmm+8);
-        env->xmm_regs[i].ZMM_Q(2) = ldq_p(ymmh);
-        env->xmm_regs[i].ZMM_Q(3) = ldq_p(ymmh+8);
-        env->xmm_regs[i].ZMM_Q(4) = ldq_p(zmmh);
-        env->xmm_regs[i].ZMM_Q(5) = ldq_p(zmmh+8);
-        env->xmm_regs[i].ZMM_Q(6) = ldq_p(zmmh+16);
-        env->xmm_regs[i].ZMM_Q(7) = ldq_p(zmmh+24);
-    }
-
-#ifdef TARGET_X86_64
-    memcpy(&env->xmm_regs[16], &xsave->hi16_zmm_state.hi16_zmm,
-           16 * sizeof env->xmm_regs[16]);
-    memcpy(&env->pkru, &xsave->pkru_state, sizeof env->pkru);
-#endif
     return 0;
 }
 
diff --git a/target/i386/xsave_helper.c b/target/i386/xsave_helper.c
new file mode 100644
index 0000000..ca735ee
--- /dev/null
+++ b/target/i386/xsave_helper.c
@@ -0,0 +1,114 @@
+/*
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+
+#include "qemu-common.h"
+#include "cpu.h"
+
+void x86_cpu_xsave_all_areas(X86CPU *cpu, X86XSaveArea *buf)
+{
+    CPUX86State *env = &cpu->env;
+    X86XSaveArea *xsave = buf;
+
+    uint16_t cwd, swd, twd;
+    int i;
+    memset(xsave, 0, sizeof(X86XSaveArea));
+    twd = 0;
+    swd = env->fpus & ~(7 << 11);
+    swd |= (env->fpstt & 7) << 11;
+    cwd = env->fpuc;
+    for (i = 0; i < 8; ++i) {
+        twd |= (!env->fptags[i]) << i;
+    }
+    xsave->legacy.fcw = cwd;
+    xsave->legacy.fsw = swd;
+    xsave->legacy.ftw = twd;
+    xsave->legacy.fpop = env->fpop;
+    xsave->legacy.fpip = env->fpip;
+    xsave->legacy.fpdp = env->fpdp;
+    memcpy(&xsave->legacy.fpregs, env->fpregs,
+            sizeof env->fpregs);
+    xsave->legacy.mxcsr = env->mxcsr;
+    xsave->header.xstate_bv = env->xstate_bv;
+    memcpy(&xsave->bndreg_state.bnd_regs, env->bnd_regs,
+            sizeof env->bnd_regs);
+    xsave->bndcsr_state.bndcsr = env->bndcs_regs;
+    memcpy(&xsave->opmask_state.opmask_regs, env->opmask_regs,
+            sizeof env->opmask_regs);
+
+    for (i = 0; i < CPU_NB_REGS; i++) {
+        uint8_t *xmm = xsave->legacy.xmm_regs[i];
+        uint8_t *ymmh = xsave->avx_state.ymmh[i];
+        uint8_t *zmmh = xsave->zmm_hi256_state.zmm_hi256[i];
+        stq_p(xmm,     env->xmm_regs[i].ZMM_Q(0));
+        stq_p(xmm+8,   env->xmm_regs[i].ZMM_Q(1));
+        stq_p(ymmh,    env->xmm_regs[i].ZMM_Q(2));
+        stq_p(ymmh+8,  env->xmm_regs[i].ZMM_Q(3));
+        stq_p(zmmh,    env->xmm_regs[i].ZMM_Q(4));
+        stq_p(zmmh+8,  env->xmm_regs[i].ZMM_Q(5));
+        stq_p(zmmh+16, env->xmm_regs[i].ZMM_Q(6));
+        stq_p(zmmh+24, env->xmm_regs[i].ZMM_Q(7));
+    }
+
+#ifdef TARGET_X86_64
+    memcpy(&xsave->hi16_zmm_state.hi16_zmm, &env->xmm_regs[16],
+            16 * sizeof env->xmm_regs[16]);
+    memcpy(&xsave->pkru_state, &env->pkru, sizeof env->pkru);
+#endif
+
+}
+
+void x86_cpu_xrstor_all_areas(X86CPU *cpu, const X86XSaveArea *buf)
+{
+
+    CPUX86State *env = &cpu->env;
+    const X86XSaveArea *xsave = buf;
+
+    int i;
+    uint16_t cwd, swd, twd;
+    cwd = xsave->legacy.fcw;
+    swd = xsave->legacy.fsw;
+    twd = xsave->legacy.ftw;
+    env->fpop = xsave->legacy.fpop;
+    env->fpstt = (swd >> 11) & 7;
+    env->fpus = swd;
+    env->fpuc = cwd;
+    for (i = 0; i < 8; ++i) {
+        env->fptags[i] = !((twd >> i) & 1);
+    }
+    env->fpip = xsave->legacy.fpip;
+    env->fpdp = xsave->legacy.fpdp;
+    env->mxcsr = xsave->legacy.mxcsr;
+    memcpy(env->fpregs, &xsave->legacy.fpregs,
+            sizeof env->fpregs);
+    env->xstate_bv = xsave->header.xstate_bv;
+    memcpy(env->bnd_regs, &xsave->bndreg_state.bnd_regs,
+            sizeof env->bnd_regs);
+    env->bndcs_regs = xsave->bndcsr_state.bndcsr;
+    memcpy(env->opmask_regs, &xsave->opmask_state.opmask_regs,
+            sizeof env->opmask_regs);
+
+    for (i = 0; i < CPU_NB_REGS; i++) {
+        const uint8_t *xmm = xsave->legacy.xmm_regs[i];
+        const uint8_t *ymmh = xsave->avx_state.ymmh[i];
+        const uint8_t *zmmh = xsave->zmm_hi256_state.zmm_hi256[i];
+        env->xmm_regs[i].ZMM_Q(0) = ldq_p(xmm);
+        env->xmm_regs[i].ZMM_Q(1) = ldq_p(xmm+8);
+        env->xmm_regs[i].ZMM_Q(2) = ldq_p(ymmh);
+        env->xmm_regs[i].ZMM_Q(3) = ldq_p(ymmh+8);
+        env->xmm_regs[i].ZMM_Q(4) = ldq_p(zmmh);
+        env->xmm_regs[i].ZMM_Q(5) = ldq_p(zmmh+8);
+        env->xmm_regs[i].ZMM_Q(6) = ldq_p(zmmh+16);
+        env->xmm_regs[i].ZMM_Q(7) = ldq_p(zmmh+24);
+    }
+
+#ifdef TARGET_X86_64
+    memcpy(&env->xmm_regs[16], &xsave->hi16_zmm_state.hi16_zmm,
+           16 * sizeof env->xmm_regs[16]);
+    memcpy(&env->pkru, &xsave->pkru_state, sizeof env->pkru);
+#endif
+
+}
-- 
1.8.3.1
