Received: from eggs.gnu.org ([2001:4830:134:3::10]:45671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fspm9-00050H-Nh
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fspm5-0008VF-Jz
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:35:49 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:38401 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fspm5-0007vh-BT
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:35:45 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 23 Aug 2018 15:33:54 +0200
Message-Id: <1535031276-22911-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1535031276-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1535031276-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v4 04/46] target/mips: Prevent switching mode
 related to Config3 ISA bit for nanoMIPS
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

From: Stefan Markovic <smarkovic@wavecomp.com>

Only if Config3.ISA is 3 (microMIPS), the mode should be switched in
cpu_state_reset(). Config3.ISA is 1 for nanoMIPS processors, and no mode
change should happen.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 4f95b9a..7fb322b 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -21841,8 +21841,8 @@ void cpu_state_reset(CPUMIPSState *env)
         env->CP0_Status |= (1 << CP0St_FR);
     }
 
-    if (env->CP0_Config3 & (1 << CP0C3_ISA)) {
-        /*  microMIPS on reset when Config3.ISA == {1, 3} */
+    if (env->CP0_Config3 & (1 << CP0C3_ISA) & (1 << (CP0C3_ISA + 1))) {
+        /*  microMIPS on reset when Config3.ISA is 3 */
         env->hflags |= MIPS_HFLAG_M16;
     }
 
-- 
2.7.4
