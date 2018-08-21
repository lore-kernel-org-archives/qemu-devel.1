Received: from eggs.gnu.org ([2001:4830:134:3::10]:41687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs5tQ-00029u-Jc
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs5tK-0007SL-HH
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:36:16 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:34931 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fs5tJ-0007Ny-HP
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:36:10 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 21 Aug 2018 14:35:47 +0200
Message-Id: <1534854951-6321-43-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534854951-6321-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534854951-6321-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 42/46] elf: Don't check FCR31_NAN2008 bit for
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
Cc: peter.maydell@linaro.org

From: Aleksandar Markovic <amarkovic@wavecomp.com>

nanoMIPS is always NaN2008 compliant, and rules for checking
FCR31's NAN2008 bit are obsoleted.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 linux-user/mips/cpu_loop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 1d3dc9e..c9c20cf 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -747,6 +747,9 @@ void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
     if (regs->cp0_epc & 1) {
         env->hflags |= MIPS_HFLAG_M16;
     }
+    if (env->insn_flags & ISA_NANOMIPS32) {
+        return;
+    }
     if (((info->elf_flags & EF_MIPS_NAN2008) != 0) !=
         ((env->active_fpu.fcr31 & (1 << FCR31_NAN2008)) != 0)) {
         if ((env->active_fpu.fcr31_rw_bitmask &
-- 
2.7.4
