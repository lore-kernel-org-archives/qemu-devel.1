Received: from eggs.gnu.org ([2001:4830:134:3::10]:59669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH3E-0005ZE-1H
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH37-0007AC-35
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:43 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55807 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fpH36-00077X-C5
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:36 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 13 Aug 2018 19:53:20 +0200
Message-Id: <1534182832-554-56-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v8 55/87] target/mips: Adjust
 set_hflags_for_handler() for nanoMIPS
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

From: James Hogan <james.hogan@mips.com>

We shouldn't clear M16 mode when entering an interrupt on nanoMIPS,
otherwise we'll start interpreting the code as normal MIPS code.

Signed-off-by: James Hogan <james.hogan@mips.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/mips/helper.c b/target/mips/helper.c
index b429671..0c15e65 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -671,6 +671,9 @@ target_ulong exception_resume_pc (CPUMIPSState *env)
 #if !defined(CONFIG_USER_ONLY)
 static void set_hflags_for_handler (CPUMIPSState *env)
 {
+    if (env->insn_flags & ISA_NANOMIPS32) {
+        return;
+    }
     /* Exception handlers are entered in 32-bit mode.  */
     env->hflags &= ~(MIPS_HFLAG_M16);
     /* ...except that microMIPS lets you choose.  */
-- 
2.7.4
