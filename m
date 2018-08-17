Received: from eggs.gnu.org ([2001:4830:134:3::10]:52957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqfMh-0004qi-1g
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqfMZ-0007d4-BL
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:33 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45374 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fqfMY-0007Yu-EB
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:26 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 17 Aug 2018 16:03:45 +0200
Message-Id: <1534514633-13725-58-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534514633-13725-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534514633-13725-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v10 57/65] linux-user: Add cpu_loop.c for
 nanoMIPS
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

Amend regular MIPS' cpu_loop.c to include nanoMIPS support.

Signed-off-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 linux-user/mips/cpu_loop.c     | 8 +++++++-
 linux-user/nanomips/cpu_loop.c | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)
 create mode 100644 linux-user/nanomips/cpu_loop.c

diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index c9c20cf..ada5a79 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -546,7 +546,7 @@ void cpu_loop(CPUMIPSState *env)
                                  arg5, arg6, arg7, arg8);
             }
 done_syscall:
-# else
+# else /* N32/N64 and P32 */
             ret = do_syscall(env, env->active_tc.gpr[2],
                              env->active_tc.gpr[4], env->active_tc.gpr[5],
                              env->active_tc.gpr[6], env->active_tc.gpr[7],
@@ -562,6 +562,7 @@ done_syscall:
                    Avoid clobbering register state.  */
                 break;
             }
+#if !defined(TARGET_ABI_MIPSP32)
             if ((abi_ulong)ret >= (abi_ulong)-1133) {
                 env->active_tc.gpr[7] = 1; /* error flag */
                 ret = -ret;
@@ -569,6 +570,9 @@ done_syscall:
                 env->active_tc.gpr[7] = 0; /* error flag */
             }
             env->active_tc.gpr[2] = ret;
+#else
+            env->active_tc.gpr[4] = ret;
+#endif
             break;
         case EXCP_TLBL:
         case EXCP_TLBS:
@@ -714,6 +718,8 @@ done_syscall:
                     } else {
                         code = ((trap_instr >> 6) & ((1 << 10) - 1));
                     }
+                } else if (env->insn_flags & ISA_NANOMIPS32) {
+                    code = ((trap_instr >> 11) & ((1 << 5) - 1));
                 }
 
                 if (do_break(env, &info, code) != 0) {
diff --git a/linux-user/nanomips/cpu_loop.c b/linux-user/nanomips/cpu_loop.c
new file mode 100644
index 0000000..da4949a
--- /dev/null
+++ b/linux-user/nanomips/cpu_loop.c
@@ -0,0 +1 @@
+#include "../mips/cpu_loop.c"
-- 
2.7.4
