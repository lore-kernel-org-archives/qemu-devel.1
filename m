Received: from eggs.gnu.org ([2001:4830:134:3::10]:36137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbyg-0007Jm-DT
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:12:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbyd-0006ni-7E
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:12:46 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:43704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Yongbok.Kim@mips.com>)
	id 1fVbyc-0006fu-UV
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:12:43 -0400
From: Yongbok Kim <yongbok.kim@mips.com>
Date: Wed, 20 Jun 2018 13:06:08 +0100
Message-ID: <20180620120620.12806-24-yongbok.kim@mips.com>
In-Reply-To: <20180620120620.12806-1-yongbok.kim@mips.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 23/35] target/mips: Update BadInstr{P} regs on
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
Cc: aurelien@aurel32.net, Aleksandar.Markovic@mips.com, James.Hogan@mips.com, Paul.Burton@mips.com, Matthew.Fortune@mips.com, Stefan.Markovic@mips.com

From: Yongbok Kim <yongbok.kim@imgtec.com>

Update BadInstr{P} registers on nanoMIPS

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
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
1.9.1
