Received: from eggs.gnu.org ([2001:4830:134:3::10]:43247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVoJl-0003Jr-5X
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVoJk-0000B4-Cl
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:18:49 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dVoJk-0000Am-9r
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:18:48 -0400
Received: by mail-qk0-x242.google.com with SMTP id q66so10270870qki.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 17:18:48 -0700 (PDT)
Received: from bigtime.twiddle.net.com (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	v47sm5647206qtb.11.2017.07.13.17.18.46 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 13 Jul 2017 17:18:47 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu, 13 Jul 2017 14:18:19 -1000
Message-Id: <20170714001819.1660-9-rth@twiddle.net>
In-Reply-To: <20170714001819.1660-1-rth@twiddle.net>
References: <20170714001819.1660-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 8/8] target/alpha: Log temp leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
