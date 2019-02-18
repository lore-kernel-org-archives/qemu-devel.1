Received: from eggs.gnu.org ([209.51.188.92]:39410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxw-0006ch-Hk
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxt-0003Bg-Gu
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:16 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:37 +1100
Message-Id: <20190218143049.17142-32-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 31/43] target/ppc: convert VSX logical
 operations to vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20190215100058.20015-6-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate/vsx-impl.inc.c | 43 ++++++++++++-----------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
index ed4fdceacf..2576d81ac5 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -10,6 +10,11 @@ static inline void set_vsr(int n, TCGv_i64 src)
     tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState, vsr[n].u64[1]));
 }
=20
+static inline int vsr_full_offset(int n)
+{
+    return offsetof(CPUPPCState, vsr[n].u64[0]);
+}
+
 static inline void get_cpu_vsrh(TCGv_i64 dst, int n)
 {
     if (n < 32) {
@@ -1255,40 +1260,26 @@ static void gen_xxbrw(DisasContext *ctx)
     tcg_temp_free_i64(xbl);
 }
=20
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
-        t0 =3D tcg_temp_new_i64();                                     \
-        t1 =3D tcg_temp_new_i64();                                     \
-        t2 =3D tcg_temp_new_i64();                                     \
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
=20
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
=20
 #define VSX_XXMRG(name, high)                               \
 static void glue(gen_, name)(DisasContext * ctx)            \
--=20
2.20.1
