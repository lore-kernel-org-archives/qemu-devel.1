Received: from eggs.gnu.org ([2001:4830:134:3::10]:33416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fsqSE-0005B5-0G
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:19:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fsqS7-0004j9-US
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:19:17 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:56891 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fsqS6-0004hP-5K
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:19:11 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 23 Aug 2018 16:18:19 +0200
Message-Id: <1535033941-861-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1535033941-861-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1535033941-861-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v5 04/46] target/mips: Prevent switching mode
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
