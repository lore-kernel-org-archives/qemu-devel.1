Received: from eggs.gnu.org ([2001:4830:134:3::10]:58166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fXXl2-0002ff-N6
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 16:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fXXl1-0002OX-66
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 16:06:40 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:40249 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fXXl0-0002MS-Ty
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 16:06:39 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 25 Jun 2018 22:06:01 +0200
Message-Id: <1529957164-4744-7-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1529957164-4744-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1529957164-4744-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 6/9] target/mips: Fix microMIPS on reset
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

Fix to activate microMIPS (and nanoMIPS) on reset when Config3.ISA == {1, 3}

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Reviewed-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
---
 target/mips/translate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index e57d71e..2eb211a 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20713,6 +20713,11 @@ void cpu_state_reset(CPUMIPSState *env)
         env->CP0_Status |= (1 << CP0St_FR);
     }
 
+    if (env->CP0_Config3 & (1 << CP0C3_ISA)) {
+        /*  microMIPS on reset when Config3.ISA == {1, 3} */
+        env->hflags |= MIPS_HFLAG_M16;
+    }
+
     /* MSA */
     if (env->CP0_Config3 & (1 << CP0C3_MSAP)) {
         msa_reset(env);
-- 
2.7.4
