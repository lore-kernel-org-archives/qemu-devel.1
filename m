Received: from eggs.gnu.org ([2001:4830:134:3::10]:55431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dNQ87-0008EZ-7Y
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 16:52:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dNQ84-0004H6-JB
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 16:52:07 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:57635)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dNQ84-0004GF-8C
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 16:52:04 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 20 Jun 2017 22:51:21 +0200
Message-Id: <20170620205121.26515-7-laurent@vivier.eu>
In-Reply-To: <20170620205121.26515-1-laurent@vivier.eu>
References: <20170620205121.26515-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v5 6/6] target-m68k,
 linux-user: manage FP registers in ucontext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/signal.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 3d18d1b..d3753e4 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -5673,6 +5673,24 @@ give_sigsegv:
     force_sigsegv(sig);
 }
 
+static inline void target_rt_save_fpu_state(struct target_ucontext *uc,
+                                           CPUM68KState *env)
+{
+    int i;
+    target_fpregset_t *fpregs = &uc->tuc_mcontext.fpregs;
+
+    __put_user(env->fpcr, &fpregs->f_fpcntl[0]);
+    __put_user(env->fpsr, &fpregs->f_fpcntl[1]);
+    /* fpiar is not emulated */
+
+    for (i = 0; i < 8; i++) {
+        uint32_t high = env->fregs[i].d.high << 16;
+        __put_user(high, &fpregs->f_fpregs[i * 3]);
+        __put_user(env->fregs[i].d.low,
+                   (uint64_t *)&fpregs->f_fpregs[i * 3 + 1]);
+    }
+}
+
 static inline int target_rt_setup_ucontext(struct target_ucontext *uc,
                                            CPUM68KState *env)
 {
@@ -5699,9 +5717,30 @@ static inline int target_rt_setup_ucontext(struct target_ucontext *uc,
     __put_user(env->pc, &gregs[16]);
     __put_user(sr, &gregs[17]);
 
+    target_rt_save_fpu_state(uc, env);
+
     return 0;
 }
 
+static inline void target_rt_restore_fpu_state(CPUM68KState *env,
+                                               struct target_ucontext *uc)
+{
+    int i;
+    target_fpregset_t *fpregs = &uc->tuc_mcontext.fpregs;
+
+    __get_user(env->fpcr, &fpregs->f_fpcntl[0]);
+    __get_user(env->fpsr, &fpregs->f_fpcntl[1]);
+    /* fpiar is not emulated */
+
+    for (i = 0; i < 8; i++) {
+        uint32_t high;
+        __get_user(high, &fpregs->f_fpregs[i * 3]);
+        env->fregs[i].d.high = high >> 16;
+        __get_user(env->fregs[i].d.low,
+                   (uint64_t *)&fpregs->f_fpregs[i * 3 + 1]);
+    }
+}
+
 static inline int target_rt_restore_ucontext(CPUM68KState *env,
                                              struct target_ucontext *uc)
 {
@@ -5733,6 +5772,8 @@ static inline int target_rt_restore_ucontext(CPUM68KState *env,
     __get_user(temp, &gregs[17]);
     cpu_m68k_set_ccr(env, temp);
 
+    target_rt_restore_fpu_state(env, uc);
+
     return 0;
 
 badframe:
-- 
2.9.4
