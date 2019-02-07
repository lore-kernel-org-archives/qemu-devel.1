Received: from eggs.gnu.org ([209.51.188.92]:58341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1griGJ-0007Za-G4
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1griGI-0001YA-D4
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:35 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1griGI-0001VR-5d
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:34 -0500
Received: by mail-wm1-x343.google.com with SMTP id v26so1309525wmh.3
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 03:54:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Feb 2019 11:54:00 +0000
Message-Id: <20190207115400.647-20-richard.henderson@linaro.org>
In-Reply-To: <20190207115400.647-1-richard.henderson@linaro.org>
References: <20190207115400.647-1-richard.henderson@linaro.org>
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
Cc: deller@gmx.de, svens@stackframe.org

Now that the implementation is entirely within the generated
decode function, eliminate the wrapper.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index ecec5c42d1..6836fb6245 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3982,13 +3982,6 @@ static bool trans_fmpyfadd_d(DisasContext *ctx, arg_fmpyfadd_d *a)
     return nullify_end(ctx);
 }
 
-static void translate_one(DisasContext *ctx, uint32_t insn)
-{
-    if (!decode(ctx, insn)) {
-        gen_illegal(ctx);
-    }
-}
-
 static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
@@ -4094,7 +4087,9 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
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
2.17.2
