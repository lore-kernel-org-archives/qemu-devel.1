Received: from eggs.gnu.org ([2001:4830:134:3::10]:55184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8Z0-0004MK-1x
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8Vx-0006gI-6X
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:01:46 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:57630 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1fg8Vw-0006fU-QE
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:58:37 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu, 19 Jul 2018 14:54:57 +0200
Message-Id: <1532004912-13899-26-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 25/40] target/mips: Add updating CP0
 BadInstrX register for nanoMIPs only
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

From: Stefan Markovic <smarkovic@wavecomp.com>

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/mips/helper.c b/target/mips/helper.c
index 5299f21..9535131 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -695,6 +695,12 @@ static inline void set_badinstr_registers(CPUMIPSState *env)
                 instr |= cpu_lduw_code(env, env->active_tc.PC + 2);
             }
             env->CP0_BadInstr = instr;
+
+            if ((env->insn_flags & ISA_NANOMIPS32) &&
+                ((instr & 0xFC000000) == 0x60000000)) {
+                instr = cpu_lduw_code(env, env->active_tc.PC + 4) << 16;
+                env->CP0_BadInstrX = instr;
+            }
         }
         if ((env->CP0_Config3 & (1 << CP0C3_BP)) &&
             (env->hflags & MIPS_HFLAG_BMASK)) {
-- 
2.7.4
