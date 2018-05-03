Received: from eggs.gnu.org ([2001:4830:134:3::10]:54809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fELwo-0004jD-9a
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fELwk-00055i-8Q
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:39:30 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:46273)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fELwj-00052j-Rf
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:39:26 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  3 May 2018 23:39:01 +0200
Message-Id: <20180503213903.30335-5-laurent@vivier.eu>
In-Reply-To: <20180503213903.30335-1-laurent@vivier.eu>
References: <20180503213903.30335-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 4/6] linux-user: ARM-FDPIC: Add support for
 signals for FDPIC targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Christophe Lyon <christophe.lyon@st.com>

From: Christophe Lyon <christophe.lyon@st.com>

The FDPIC restorer needs to deal with a function descriptor, hence we
have to extend 'retcode' such that it can hold the instructions needed
to perform this.

The restorer sequence uses the same thumbness as the exception
handler (mainly to support Thumb-only architectures).

Co-Authored-By: Mickaël Guêné <mickael.guene@st.com>
Signed-off-by: Christophe Lyon <christophe.lyon@st.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180430080404.7323-5-christophe.lyon@st.com>
[lv: moved the change to linux-user/arm/signal.c]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/arm/signal.c | 105 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 89 insertions(+), 16 deletions(-)

diff --git a/linux-user/arm/signal.c b/linux-user/arm/signal.c
index 0c1ec53025..eb72be5dd0 100644
--- a/linux-user/arm/signal.c
+++ b/linux-user/arm/signal.c
@@ -102,13 +102,13 @@ struct sigframe_v1
 {
     struct target_sigcontext sc;
     abi_ulong extramask[TARGET_NSIG_WORDS-1];
-    abi_ulong retcode;
+    abi_ulong retcode[4];
 };
 
 struct sigframe_v2
 {
     struct target_ucontext_v2 uc;
-    abi_ulong retcode;
+    abi_ulong retcode[4];
 };
 
 struct rt_sigframe_v1
@@ -117,14 +117,14 @@ struct rt_sigframe_v1
     abi_ulong puc;
     struct target_siginfo info;
     struct target_ucontext_v1 uc;
-    abi_ulong retcode;
+    abi_ulong retcode[4];
 };
 
 struct rt_sigframe_v2
 {
     struct target_siginfo info;
     struct target_ucontext_v2 uc;
-    abi_ulong retcode;
+    abi_ulong retcode[4];
 };
 
 #define TARGET_CONFIG_CPU_32 1
@@ -147,6 +147,21 @@ static const abi_ulong retcodes[4] = {
         SWI_SYS_RT_SIGRETURN,   SWI_THUMB_RT_SIGRETURN
 };
 
+/*
+ * Stub needed to make sure the FD register (r9) contains the right
+ * value.
+ */
+static const unsigned long sigreturn_fdpic_codes[3] = {
+    0xe59fc004, /* ldr r12, [pc, #4] to read function descriptor */
+    0xe59c9004, /* ldr r9, [r12, #4] to setup GOT */
+    0xe59cf000  /* ldr pc, [r12] to jump into restorer */
+};
+
+static const unsigned long sigreturn_fdpic_thumb_codes[3] = {
+    0xc008f8df, /* ldr r12, [pc, #8] to read function descriptor */
+    0x9004f8dc, /* ldr r9, [r12, #4] to setup GOT */
+    0xf000f8dc  /* ldr pc, [r12] to jump into restorer */
+};
 
 static inline int valid_user_regs(CPUARMState *regs)
 {
@@ -200,13 +215,33 @@ get_sigframe(struct target_sigaction *ka, CPUARMState *regs, int framesize)
     return (sp - framesize) & ~7;
 }
 
-static void
+static int
 setup_return(CPUARMState *env, struct target_sigaction *ka,
              abi_ulong *rc, abi_ulong frame_addr, int usig, abi_ulong rc_addr)
 {
-    abi_ulong handler = ka->_sa_handler;
+    abi_ulong handler = 0;
+    abi_ulong handler_fdpic_GOT = 0;
     abi_ulong retcode;
-    int thumb = handler & 1;
+
+    int thumb;
+    int is_fdpic = info_is_fdpic(((TaskState *)thread_cpu->opaque)->info);
+
+    if (is_fdpic) {
+        /* In FDPIC mode, ka->_sa_handler points to a function
+         * descriptor (FD). The first word contains the address of the
+         * handler. The second word contains the value of the PIC
+         * register (r9).  */
+        abi_ulong funcdesc_ptr = ka->_sa_handler;
+        if (get_user_ual(handler, funcdesc_ptr)
+            || get_user_ual(handler_fdpic_GOT, funcdesc_ptr + 4)) {
+            return 1;
+        }
+    } else {
+        handler = ka->_sa_handler;
+    }
+
+    thumb = handler & 1;
+
     uint32_t cpsr = cpsr_read(env);
 
     cpsr &= ~CPSR_IT;
@@ -217,7 +252,28 @@ setup_return(CPUARMState *env, struct target_sigaction *ka,
     }
 
     if (ka->sa_flags & TARGET_SA_RESTORER) {
-        retcode = ka->sa_restorer;
+        if (is_fdpic) {
+            /* For FDPIC we ensure that the restorer is called with a
+             * correct r9 value.  For that we need to write code on
+             * the stack that sets r9 and jumps back to restorer
+             * value.
+             */
+            if (thumb) {
+                __put_user(sigreturn_fdpic_thumb_codes[0], rc);
+                __put_user(sigreturn_fdpic_thumb_codes[1], rc + 1);
+                __put_user(sigreturn_fdpic_thumb_codes[2], rc + 2);
+                __put_user((abi_ulong)ka->sa_restorer, rc + 3);
+            } else {
+                __put_user(sigreturn_fdpic_codes[0], rc);
+                __put_user(sigreturn_fdpic_codes[1], rc + 1);
+                __put_user(sigreturn_fdpic_codes[2], rc + 2);
+                __put_user((abi_ulong)ka->sa_restorer, rc + 3);
+            }
+
+            retcode = rc_addr + thumb;
+        } else {
+            retcode = ka->sa_restorer;
+        }
     } else {
         unsigned int idx = thumb;
 
@@ -231,10 +287,15 @@ setup_return(CPUARMState *env, struct target_sigaction *ka,
     }
 
     env->regs[0] = usig;
+    if (is_fdpic) {
+        env->regs[9] = handler_fdpic_GOT;
+    }
     env->regs[13] = frame_addr;
     env->regs[14] = retcode;
     env->regs[15] = handler & (thumb ? ~1 : ~3);
     cpsr_write(env, cpsr, CPSR_IT | CPSR_T, CPSRWriteByInstr);
+
+    return 0;
 }
 
 static abi_ulong *setup_sigframe_v2_vfp(abi_ulong *regspace, CPUARMState *env)
@@ -327,12 +388,15 @@ static void setup_frame_v1(int usig, struct target_sigaction *ka,
         __put_user(set->sig[i], &frame->extramask[i - 1]);
     }
 
-    setup_return(regs, ka, &frame->retcode, frame_addr, usig,
-                 frame_addr + offsetof(struct sigframe_v1, retcode));
+    if (setup_return(regs, ka, frame->retcode, frame_addr, usig,
+                     frame_addr + offsetof(struct sigframe_v1, retcode))) {
+        goto sigsegv;
+    }
 
     unlock_user_struct(frame, frame_addr, 1);
     return;
 sigsegv:
+    unlock_user_struct(frame, frame_addr, 1);
     force_sigsegv(usig);
 }
 
@@ -349,12 +413,15 @@ static void setup_frame_v2(int usig, struct target_sigaction *ka,
 
     setup_sigframe_v2(&frame->uc, set, regs);
 
-    setup_return(regs, ka, &frame->retcode, frame_addr, usig,
-                 frame_addr + offsetof(struct sigframe_v2, retcode));
+    if (setup_return(regs, ka, frame->retcode, frame_addr, usig,
+                     frame_addr + offsetof(struct sigframe_v2, retcode))) {
+        goto sigsegv;
+    }
 
     unlock_user_struct(frame, frame_addr, 1);
     return;
 sigsegv:
+    unlock_user_struct(frame, frame_addr, 1);
     force_sigsegv(usig);
 }
 
@@ -404,8 +471,10 @@ static void setup_rt_frame_v1(int usig, struct target_sigaction *ka,
         __put_user(set->sig[i], &frame->uc.tuc_sigmask.sig[i]);
     }
 
-    setup_return(env, ka, &frame->retcode, frame_addr, usig,
-                 frame_addr + offsetof(struct rt_sigframe_v1, retcode));
+    if (setup_return(env, ka, frame->retcode, frame_addr, usig,
+                     frame_addr + offsetof(struct rt_sigframe_v1, retcode))) {
+        goto sigsegv;
+    }
 
     env->regs[1] = info_addr;
     env->regs[2] = uc_addr;
@@ -413,6 +482,7 @@ static void setup_rt_frame_v1(int usig, struct target_sigaction *ka,
     unlock_user_struct(frame, frame_addr, 1);
     return;
 sigsegv:
+    unlock_user_struct(frame, frame_addr, 1);
     force_sigsegv(usig);
 }
 
@@ -435,8 +505,10 @@ static void setup_rt_frame_v2(int usig, struct target_sigaction *ka,
 
     setup_sigframe_v2(&frame->uc, set, env);
 
-    setup_return(env, ka, &frame->retcode, frame_addr, usig,
-                 frame_addr + offsetof(struct rt_sigframe_v2, retcode));
+    if (setup_return(env, ka, frame->retcode, frame_addr, usig,
+                     frame_addr + offsetof(struct rt_sigframe_v2, retcode))) {
+        goto sigsegv;
+    }
 
     env->regs[1] = info_addr;
     env->regs[2] = uc_addr;
@@ -444,6 +516,7 @@ static void setup_rt_frame_v2(int usig, struct target_sigaction *ka,
     unlock_user_struct(frame, frame_addr, 1);
     return;
 sigsegv:
+    unlock_user_struct(frame, frame_addr, 1);
     force_sigsegv(usig);
 }
 
-- 
2.14.3
