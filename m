Received: from eggs.gnu.org ([2001:4830:134:3::10]:42078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en99X-0000Pb-4w
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:32:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en99W-0000se-7p
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:32:11 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:33220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en99W-0000sT-1K
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:32:10 -0500
Received: by mail-pl0-x244.google.com with SMTP id t4so3544824plo.0
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 12:32:09 -0800 (PST)
Received: from cloudburst.twiddle.net ([50.0.192.64])
	by smtp.gmail.com with ESMTPSA id
	y7sm48203797pfe.26.2018.02.17.12.32.07 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 17 Feb 2018 12:32:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 12:31:32 -0800
Message-Id: <20180217203132.31780-20-richard.henderson@linaro.org>
In-Reply-To: <20180217203132.31780-1-richard.henderson@linaro.org>
References: <20180217203132.31780-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 19/19] target/hppa: Merge translate_one into
 hppa_tr_translate_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Now that the implementation is entirely within the generated
decode function, eliminate the wrapper.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 305a81778b..877e4dc2b7 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3992,13 +3992,6 @@ static void trans_fmpyfadd_d(DisasContext *ctx, arg_fmpyfadd_d *a,
     nullify_end(ctx);
 }
 
-static void translate_one(DisasContext *ctx, uint32_t insn)
-{
-    if (!decode(ctx, insn)) {
-        gen_illegal(ctx);
-    }
-}
-
 static int hppa_tr_init_disas_context(DisasContextBase *dcbase,
                                       CPUState *cs, int max_insns)
 {
@@ -4107,7 +4100,9 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
             ret = DISAS_NEXT;
         } else {
             ctx->insn = insn;
-            translate_one(ctx, insn);
+            if (!decode(ctx, insn)) {
+                gen_illegal(ctx);
+            }
             ret = ctx->base.is_jmp;
             assert(ctx->null_lab == NULL);
         }
-- 
2.14.3
