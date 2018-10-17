Received: from eggs.gnu.org ([2001:4830:134:3::10]:44758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCl2w-0001z5-1i
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCl2u-0006wF-2Y
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:29 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:39638 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gCl2t-0006gX-NF
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:27 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 17 Oct 2018 14:33:51 +0200
Message-Id: <1539779635-15445-24-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539779635-15445-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539779635-15445-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 23/27] target/mips: Add reset state for PWSize
 and PWField registers
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

From: Yongbok Kim <yongbok.kim@mips.com>

Add reset state for PWSize and PWField registers. The reset state
is different for pre-R6 and R6 (and post-R6) ISAa.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index d4d3369..aceda11 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -26443,6 +26443,24 @@ void cpu_state_reset(CPUMIPSState *env)
         env->CP0_Status |= (1 << CP0St_FR);
     }
 
+    if (env->insn_flags & ISA_MIPS32R6) {
+        /* PTW  =  1 */
+        env->CP0_PWSize = 0x40;
+        /* GDI  = 12 */
+        /* UDI  = 12 */
+        /* MDI  = 12 */
+        /* PRI  = 12 */
+        /* PTEI =  2 */
+        env->CP0_PWField = 0x0C30C302;
+    } else {
+        /* GDI  =  0 */
+        /* UDI  =  0 */
+        /* MDI  =  0 */
+        /* PRI  =  0 */
+        /* PTEI =  2 */
+        env->CP0_PWField = 0x02;
+    }
+
     if (env->CP0_Config3 & (1 << CP0C3_ISA) & (1 << (CP0C3_ISA + 1))) {
         /*  microMIPS on reset when Config3.ISA is 3 */
         env->hflags |= MIPS_HFLAG_M16;
-- 
2.7.4
