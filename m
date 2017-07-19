Received: from eggs.gnu.org ([2001:4830:134:3::10]:39587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXgrv-0004kV-CL
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXgru-0006eT-KS
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:45:51 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXgru-0006eF-ES
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:45:50 -0400
Received: by mail-pf0-x243.google.com with SMTP id a11so5068098pfj.3
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 21:45:50 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 18:45:22 -1000
Message-Id: <20170719044522.21114-9-rth@twiddle.net>
In-Reply-To: <20170719044522.21114-1-rth@twiddle.net>
References: <20170719044522.21114-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 8/8] target/alpha: Log temp leaks
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

Tested-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/alpha/translate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index aaaf28f..90e6d52 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -3013,6 +3013,8 @@ void gen_intermediate_code(CPUAlphaState *env, struct TranslationBlock *tb)
     }
 
     gen_tb_start(tb);
+    tcg_clear_temp_count();
+
     do {
         tcg_gen_insn_start(ctx.pc);
         num_insns++;
@@ -3035,6 +3037,10 @@ void gen_intermediate_code(CPUAlphaState *env, struct TranslationBlock *tb)
         ret = translate_one(ctxp, insn);
         free_context_temps(ctxp);
 
+        if (tcg_check_temp_count()) {
+            qemu_log("TCG temporary leak before "TARGET_FMT_lx"\n", ctx.pc);
+        }
+
         /* If we reach a page boundary, are single stepping,
            or exhaust instruction count, stop generation.  */
         if (ret == NO_EXIT
-- 
2.9.4
