Received: from eggs.gnu.org ([2001:4830:134:3::10]:55254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8Z7-0004Mx-0U
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8Vq-0006bW-Q6
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:01:53 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:57598 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1fg8Vq-0006ak-60
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:58:30 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu, 19 Jul 2018 14:54:56 +0200
Message-Id: <1532004912-13899-25-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 24/40] target/mips: Add updating BadInstr
 and BadInstrP registers for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Yongbok Kim <yongbok.kim@mips.com>

Updating BadInstr and BadInstrP registers was addded for nanoMIPS.
BadInstr and BadInstrP support for pre-nanoMIPS remains
unimplemented.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/helper.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/target/mips/helper.c b/target/mips/helper.c
index e215af9..5299f21 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -683,7 +683,28 @@ static void set_hflags_for_handler (CPUMIPSState *env)
 static inline void set_badinstr_registers(CPUMIPSState *env)
 {
     if (env->hflags & MIPS_HFLAG_M16) {
-        /* TODO: add BadInstr support for microMIPS */
+        uint32_t instr;
+        if (!(env->insn_flags & ISA_NANOMIPS32)) {
+            /* TODO: add BadInstr support for pre-nanoMIPS */
+             return;
+        }
+        if (env->CP0_Config3 & (1 << CP0C3_BI)) {
+            instr = (cpu_lduw_code(env, env->active_tc.PC)) << 16;
+            if ((env->insn_flags & ISA_NANOMIPS32) &&
+                ((instr & 0x10000000) == 0)) {
+                instr |= cpu_lduw_code(env, env->active_tc.PC + 2);
+            }
+            env->CP0_BadInstr = instr;
+        }
+        if ((env->CP0_Config3 & (1 << CP0C3_BP)) &&
+            (env->hflags & MIPS_HFLAG_BMASK)) {
+            if (!(env->hflags & MIPS_HFLAG_B16)) {
+                env->CP0_BadInstrP = cpu_ldl_code(env, env->active_tc.PC - 4);
+            } else {
+                env->CP0_BadInstrP =
+                    (cpu_lduw_code(env, env->active_tc.PC - 2)) << 16;
+            }
+        }
         return;
     }
     if (env->CP0_Config3 & (1 << CP0C3_BI)) {
-- 
2.7.4
