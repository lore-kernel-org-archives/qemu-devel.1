Received: from eggs.gnu.org ([2001:4830:134:3::10]:56869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqJmS-0008AP-R2
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqJmO-000230-0j
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:01:44 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46076 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fqJmA-00015h-1a
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:01:31 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 16 Aug 2018 16:58:07 +0200
Message-Id: <1534431497-1385-75-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v9 74/84] linux-user: Add signal.c for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Dimitrije Nikolic <dnikolic@wavecomp.com>

Add signal.c as a redirection to regular mips' signal.c, but at the
same time amend regular mips' signal.c with bits and pieces specific
for nanoMIPS. This was done this way to avoid duplication of large
pieces of code.

Signed-off-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 linux-user/mips/signal.c     | 25 ++++++++++++++++++++-----
 linux-user/nanomips/signal.c |  1 +
 2 files changed, 21 insertions(+), 5 deletions(-)
 create mode 100644 linux-user/nanomips/signal.c

diff --git a/linux-user/mips/signal.c b/linux-user/mips/signal.c
index 6aa303e..ab66429 100644
--- a/linux-user/mips/signal.c
+++ b/linux-user/mips/signal.c
@@ -21,7 +21,15 @@
 #include "signal-common.h"
 #include "linux-user/trace.h"
 
-# if defined(TARGET_ABI_MIPSO32)
+#if defined(TARGET_ABI_MIPSP32)
+struct target_sigcontext {
+    uint64_t sc_regs[32];
+    uint64_t sc_pc;
+    uint32_t sc_used_math;
+    uint32_t sc_reserved;
+};
+#define TARGET_ALMASK  (~15)
+#elif defined(TARGET_ABI_MIPSO32)
 struct target_sigcontext {
     uint32_t   sc_regmask;     /* Unused */
     uint32_t   sc_status;
@@ -43,6 +51,7 @@ struct target_sigcontext {
     target_ulong   sc_hi3;
     target_ulong   sc_lo3;
 };
+#define TARGET_ALMASK  (~7)
 # else /* N32 || N64 */
 struct target_sigcontext {
     uint64_t sc_regs[32];
@@ -61,6 +70,7 @@ struct target_sigcontext {
     uint32_t sc_dsp;
     uint32_t sc_reserved;
 };
+#define TARGET_ALMASK  (~15)
 # endif /* O32 */
 
 struct sigframe {
@@ -100,6 +110,7 @@ static inline int install_sigtramp(unsigned int *tramp,   unsigned int syscall)
 
     __put_user(0x24020000 + syscall, tramp + 0);
     __put_user(0x0000000c          , tramp + 1);
+
     return err;
 }
 
@@ -116,6 +127,7 @@ static inline void setup_sigcontext(CPUMIPSState *regs,
         __put_user(regs->active_tc.gpr[i], &sc->sc_regs[i]);
     }
 
+#if !defined(TARGET_ABI_MIPSP32)
     __put_user(regs->active_tc.HI[0], &sc->sc_mdhi);
     __put_user(regs->active_tc.LO[0], &sc->sc_mdlo);
 
@@ -137,6 +149,7 @@ static inline void setup_sigcontext(CPUMIPSState *regs,
     for (i = 0; i < 32; ++i) {
         __put_user(regs->active_fpu.fpr[i].d, &sc->sc_fpregs[i]);
     }
+#endif
 }
 
 static inline void
@@ -146,13 +159,14 @@ restore_sigcontext(CPUMIPSState *regs, struct target_sigcontext *sc)
 
     __get_user(regs->CP0_EPC, &sc->sc_pc);
 
-    __get_user(regs->active_tc.HI[0], &sc->sc_mdhi);
-    __get_user(regs->active_tc.LO[0], &sc->sc_mdlo);
-
     for (i = 1; i < 32; ++i) {
         __get_user(regs->active_tc.gpr[i], &sc->sc_regs[i]);
     }
 
+#if !defined(TARGET_ABI_MIPSP32)
+    __get_user(regs->active_tc.HI[0], &sc->sc_mdhi);
+    __get_user(regs->active_tc.LO[0], &sc->sc_mdlo);
+
     __get_user(regs->active_tc.HI[1], &sc->sc_hi1);
     __get_user(regs->active_tc.HI[2], &sc->sc_hi2);
     __get_user(regs->active_tc.HI[3], &sc->sc_hi3);
@@ -168,6 +182,7 @@ restore_sigcontext(CPUMIPSState *regs, struct target_sigcontext *sc)
     for (i = 0; i < 32; ++i) {
         __get_user(regs->active_fpu.fpr[i].d, &sc->sc_fpregs[i]);
     }
+#endif
 }
 
 /*
@@ -185,7 +200,7 @@ get_sigframe(struct target_sigaction *ka, CPUMIPSState *regs, size_t frame_size)
      */
     sp = target_sigsp(get_sp_from_cpustate(regs) - 32, ka);
 
-    return (sp - frame_size) & ~7;
+    return (sp - frame_size) & TARGET_ALMASK;
 }
 
 static void mips_set_hflags_isa_mode_from_pc(CPUMIPSState *env)
diff --git a/linux-user/nanomips/signal.c b/linux-user/nanomips/signal.c
new file mode 100644
index 0000000..86efc21
--- /dev/null
+++ b/linux-user/nanomips/signal.c
@@ -0,0 +1 @@
+#include "../mips/signal.c"
-- 
2.7.4
