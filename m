Received: from eggs.gnu.org ([2001:4830:134:3::10]:59666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH3D-0005Z3-WF
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH36-00079I-I6
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:43 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55805 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fpH36-00076t-41
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:36 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 13 Aug 2018 19:53:18 +0200
Message-Id: <1534182832-554-54-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v8 53/87] target/mips: Add updating BadInstr,
 BadInstrP, BadInstrX for nanoMIPS
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

From: Stefan Markovic <smarkovic@wavecomp.com>

Update BadInstr, BadInstrP,and BadInstrX registers for nanoMIPS.
The same support for pre-nanoMIPS remains unimplemented.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/helper.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/target/mips/helper.c b/target/mips/helper.c
index e215af9..b25e000 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -682,6 +682,31 @@ static void set_hflags_for_handler (CPUMIPSState *env)
 
 static inline void set_badinstr_registers(CPUMIPSState *env)
 {
+    if (env->insn_flags & ISA_NANOMIPS32) {
+        if (env->CP0_Config3 & (1 << CP0C3_BI)) {
+            uint32_t instr = (cpu_lduw_code(env, env->active_tc.PC)) << 16;
+            if ((instr & 0x10000000) == 0) {
+                instr |= cpu_lduw_code(env, env->active_tc.PC + 2);
+            }
+            env->CP0_BadInstr = instr;
+
+            if ((instr & 0xFC000000) == 0x60000000) {
+                instr = cpu_lduw_code(env, env->active_tc.PC + 4) << 16;
+                env->CP0_BadInstrX = instr;
+            }
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
+        return;
+    }
+
     if (env->hflags & MIPS_HFLAG_M16) {
         /* TODO: add BadInstr support for microMIPS */
         return;
-- 
2.7.4
