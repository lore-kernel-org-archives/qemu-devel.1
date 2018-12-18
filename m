Received: from eggs.gnu.org ([2001:4830:134:3::10]:53253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ934-0001sB-IX
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92u-0002x3-PI
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:10 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZ92u-0002Wx-FA
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:00 -0500
Received: by mail-pg1-x543.google.com with SMTP id d72so7338497pga.9
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 22:39:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 17 Dec 2018 22:39:00 -0800
Message-Id: <20181218063911.2112-24-richard.henderson@linaro.org>
In-Reply-To: <20181218063911.2112-1-richard.henderson@linaro.org>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 23/34] target/ppc: convert xxspltib to vector
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate/vsx-impl.inc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 8ab1290026..d88d6bbd74 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1356,9 +1356,10 @@ static void gen_xxspltw(DisasContext *ctx)
 
 static void gen_xxspltib(DisasContext *ctx)
 {
-    unsigned char uim8 = IMM8(ctx->opcode);
-    TCGv_i64 vsr = tcg_temp_new_i64();
-    if (xS(ctx->opcode) < 32) {
+    uint8_t uim8 = IMM8(ctx->opcode);
+    int rt = xT(ctx->opcode);
+
+    if (rt < 32) {
         if (unlikely(!ctx->altivec_enabled)) {
             gen_exception(ctx, POWERPC_EXCP_VPU);
             return;
@@ -1369,10 +1370,7 @@ static void gen_xxspltib(DisasContext *ctx)
             return;
         }
     }
-    tcg_gen_movi_i64(vsr, pattern(uim8));
-    set_cpu_vsrh(xT(ctx->opcode), vsr);
-    set_cpu_vsrl(xT(ctx->opcode), vsr);
-    tcg_temp_free_i64(vsr);
+    tcg_gen_gvec_dup8i(vsr_full_offset(rt), 16, 16, uim8);
 }
 
 static void gen_xxsldwi(DisasContext *ctx)
-- 
2.17.2
