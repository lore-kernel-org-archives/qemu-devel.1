Received: from eggs.gnu.org ([2001:4830:134:3::10]:53057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92y-0001iH-59
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92s-0002tH-G7
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:04 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:34060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZ92r-0002Ta-Rg
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:39:58 -0500
Received: by mail-pg1-x52b.google.com with SMTP id j10so6136811pga.1
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 22:39:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 17 Dec 2018 22:38:59 -0800
Message-Id: <20181218063911.2112-23-richard.henderson@linaro.org>
In-Reply-To: <20181218063911.2112-1-richard.henderson@linaro.org>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 22/34] target/ppc: convert VSX logical
 operations to vector operations
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
 target/ppc/translate/vsx-impl.inc.c | 43 ++++++++++++-----------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 1608ad48b1..8ab1290026 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -10,6 +10,11 @@ static inline void set_vsr(int n, TCGv_i64 src)
     tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState, vsr[n].u64[1]));
 }
 
+static inline int vsr_full_offset(int n)
+{
+    return offsetof(CPUPPCState, vsr[n].u64[0]);
+}
+
 static inline void get_cpu_vsrh(TCGv_i64 dst, int n)
 {
     if (n < 32) {
@@ -1214,40 +1219,26 @@ static void gen_xxbrw(DisasContext *ctx)
     tcg_temp_free_i64(xbl);
 }
 
-#define VSX_LOGICAL(name, tcg_op)                                    \
+#define VSX_LOGICAL(name, vece, tcg_op)                              \
 static void glue(gen_, name)(DisasContext * ctx)                     \
     {                                                                \
-        TCGv_i64 t0;                                                 \
-        TCGv_i64 t1;                                                 \
-        TCGv_i64 t2;                                                 \
         if (unlikely(!ctx->vsx_enabled)) {                           \
             gen_exception(ctx, POWERPC_EXCP_VSXU);                   \
             return;                                                  \
         }                                                            \
-        t0 = tcg_temp_new_i64();                                     \
-        t1 = tcg_temp_new_i64();                                     \
-        t2 = tcg_temp_new_i64();                                     \
-        get_cpu_vsrh(t0, xA(ctx->opcode));                           \
-        get_cpu_vsrh(t1, xB(ctx->opcode));                           \
-        tcg_op(t2, t0, t1);                                          \
-        set_cpu_vsrh(xT(ctx->opcode), t2);                           \
-        get_cpu_vsrl(t0, xA(ctx->opcode));                           \
-        get_cpu_vsrl(t1, xB(ctx->opcode));                           \
-        tcg_op(t2, t0, t1);                                          \
-        set_cpu_vsrl(xT(ctx->opcode), t2);                           \
-        tcg_temp_free_i64(t0);                                       \
-        tcg_temp_free_i64(t1);                                       \
-        tcg_temp_free_i64(t2);                                       \
+        tcg_op(vece, vsr_full_offset(xT(ctx->opcode)),               \
+               vsr_full_offset(xA(ctx->opcode)),                     \
+               vsr_full_offset(xB(ctx->opcode)), 16, 16);            \
     }
 
-VSX_LOGICAL(xxland, tcg_gen_and_i64)
-VSX_LOGICAL(xxlandc, tcg_gen_andc_i64)
-VSX_LOGICAL(xxlor, tcg_gen_or_i64)
-VSX_LOGICAL(xxlxor, tcg_gen_xor_i64)
-VSX_LOGICAL(xxlnor, tcg_gen_nor_i64)
-VSX_LOGICAL(xxleqv, tcg_gen_eqv_i64)
-VSX_LOGICAL(xxlnand, tcg_gen_nand_i64)
-VSX_LOGICAL(xxlorc, tcg_gen_orc_i64)
+VSX_LOGICAL(xxland, MO_64, tcg_gen_gvec_and)
+VSX_LOGICAL(xxlandc, MO_64, tcg_gen_gvec_andc)
+VSX_LOGICAL(xxlor, MO_64, tcg_gen_gvec_or)
+VSX_LOGICAL(xxlxor, MO_64, tcg_gen_gvec_xor)
+VSX_LOGICAL(xxlnor, MO_64, tcg_gen_gvec_nor)
+VSX_LOGICAL(xxleqv, MO_64, tcg_gen_gvec_eqv)
+VSX_LOGICAL(xxlnand, MO_64, tcg_gen_gvec_nand)
+VSX_LOGICAL(xxlorc, MO_64, tcg_gen_gvec_orc)
 
 #define VSX_XXMRG(name, high)                               \
 static void glue(gen_, name)(DisasContext * ctx)            \
-- 
2.17.2
