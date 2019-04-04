Received: from eggs.gnu.org ([209.51.188.92]:51295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hC2Dr-0004xm-WB
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 09:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hC2Dq-0004fS-5T
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 09:16:03 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:40256 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1hC2Dp-0003Gm-KZ
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 09:16:02 -0400
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Thu,  4 Apr 2019 15:14:49 +0200
Message-Id: <1554383690-28338-4-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1554383690-28338-1-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1554383690-28338-1-git-send-email-mateja.marjanovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 3/4] target/mips: Optimize ILVL.<B|H|W|D>
 MSA instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, philmd@redhat.com, richard.henderson@linaro.org, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

Optimized ILVL.<B|H|W|D> instructions, using a hybrid
approach. For byte data elements, use a helper with an
unrolled loop (much better performance), for halfword,
word and doubleword data elements use directly tcg
registers and logic performed on them.

Performance measurement is done by executing the
instructions a large number of times on a computer
with Intel Core i7-3770 CPU @ 3.40GHz=C3=978.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
||  instr  ||  helper  ||   tcg    ||  hybrid   ||
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
|| ilvl.b: || 59.91 ms || 74.41 ms ||  59.24 ms || <-- helper
|| ilvl.h: || 41.33 ms || 33.08 ms ||  32.96 ms || <-- tcg
|| ilvl.w: || 30.99 ms || 22.87 ms ||  22.81 ms || <-- tcg
|| ilvl.d: || 26.40 ms || 19.64 ms ||  19.45 ms || <-- tcg
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
---
 target/mips/helper.h     |   3 +-
 target/mips/msa_helper.c |  33 ++++++---
 target/mips/translate.c  | 184 +++++++++++++++++++++++++++++++++++++++++=
+++++-
 3 files changed, 210 insertions(+), 10 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 82f6a40..cd73723 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -862,7 +862,6 @@ DEF_HELPER_5(msa_sld_df, void, env, i32, i32, i32, i3=
2)
 DEF_HELPER_5(msa_splat_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_pckev_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_pckod_df, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(msa_ilvl_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_ilvr_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_vshf_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_srar_df, void, env, i32, i32, i32, i32)
@@ -946,6 +945,8 @@ DEF_HELPER_4(msa_insert_h, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_insert_w, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_insert_d, void, env, i32, i32, i32)
=20
+DEF_HELPER_4(msa_ilvl_b, void, env, i32, i32, i32)
+
 DEF_HELPER_4(msa_fclass_df, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_ftrunc_s_df, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_ftrunc_u_df, void, env, i32, i32, i32)
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index d5c3842..84bbe6f 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -1184,14 +1184,6 @@ MSA_FN_DF(pckod_df)
=20
 #define MSA_DO(DF)                      \
     do {                                \
-        pwx->DF[2*i]   =3D L##DF(pwt, i); \
-        pwx->DF[2*i+1] =3D L##DF(pws, i); \
-    } while (0)
-MSA_FN_DF(ilvl_df)
-#undef MSA_DO
-
-#define MSA_DO(DF)                      \
-    do {                                \
         pwx->DF[2*i]   =3D R##DF(pwt, i); \
         pwx->DF[2*i+1] =3D R##DF(pws, i); \
     } while (0)
@@ -1232,6 +1224,31 @@ void helper_msa_splati_df(CPUMIPSState *env, uint3=
2_t df, uint32_t wd,
     msa_splat_df(df, pwd, pws, n);
 }
=20
+void helper_msa_ilvl_b(CPUMIPSState *env, uint32_t wd,
+                       uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws =3D &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt =3D &(env->active_fpu.fpr[wt].wr);
+
+    pwd->b[0]  =3D pwt->b[8];
+    pwd->b[1]  =3D pws->b[8];
+    pwd->b[2]  =3D pwt->b[9];
+    pwd->b[3]  =3D pws->b[9];
+    pwd->b[4]  =3D pwt->b[10];
+    pwd->b[5]  =3D pws->b[10];
+    pwd->b[6]  =3D pwt->b[11];
+    pwd->b[7]  =3D pws->b[11];
+    pwd->b[8]  =3D pwt->b[12];
+    pwd->b[9]  =3D pws->b[12];
+    pwd->b[10] =3D pwt->b[13];
+    pwd->b[11] =3D pws->b[13];
+    pwd->b[12] =3D pwt->b[14];
+    pwd->b[13] =3D pws->b[14];
+    pwd->b[14] =3D pwt->b[15];
+    pwd->b[15] =3D pws->b[15];
+}
+
 void helper_msa_copy_s_b(CPUMIPSState *env, uint32_t rd,
                          uint32_t ws, uint32_t n)
 {
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 3057669..6c6811e 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -28885,6 +28885,173 @@ static void gen_msa_bit(CPUMIPSState *env, Disa=
sContext *ctx)
 }
=20
 /*
+ * [MSA] ILVL.B wd, ws, wt
+ *
+ *   Vector Interleave Left (byte data elements)
+ *
+ */
+static inline void gen_ilvl_b(CPUMIPSState *env, uint32_t wd,
+                              uint32_t ws, uint32_t wt)
+{
+    TCGv_i64 t1 =3D tcg_temp_new_i64();
+    TCGv_i64 t2 =3D tcg_temp_new_i64();
+    uint64_t mask =3D 0x00000000000000ffULL;
+
+    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
+    tcg_gen_mov_i64(t2, t1);
+    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
+    tcg_gen_shli_i64(t1, t1, 8);
+    tcg_gen_or_i64(t2, t2, t1);
+
+    mask <<=3D 8;
+    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
+    tcg_gen_shli_i64(t1, t1, 8);
+    tcg_gen_or_i64(t2, t2, t1);
+    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
+    tcg_gen_shli_i64(t1, t1, 16);
+    tcg_gen_or_i64(t2, t2, t1);
+
+    mask <<=3D 8;
+    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
+    tcg_gen_shli_i64(t1, t1, 16);
+    tcg_gen_or_i64(t2, t2, t1);
+    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
+    tcg_gen_shli_i64(t1, t1, 24);
+    tcg_gen_or_i64(t2, t2, t1);
+
+    mask <<=3D 8;
+    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
+    tcg_gen_shli_i64(t1, t1, 24);
+    tcg_gen_or_i64(t2, t2, t1);
+    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
+    tcg_gen_shli_i64(t1, t1, 32);
+    tcg_gen_or_i64(msa_wr_d[wd * 2], t2, t1);
+
+    mask <<=3D 8;
+    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
+    tcg_gen_shri_i64(t1, t1, 32);
+    tcg_gen_mov_i64(t2, t1);
+    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
+    tcg_gen_shri_i64(t1, t1, 24);
+    tcg_gen_or_i64(t2, t2, t1);
+
+    mask <<=3D 8;
+    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
+    tcg_gen_shri_i64(t1, t1, 24);
+    tcg_gen_or_i64(t2, t2, t1);
+    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
+    tcg_gen_shri_i64(t1, t1, 16);
+    tcg_gen_or_i64(t2, t2, t1);
+
+    mask <<=3D 8;
+    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
+    tcg_gen_shri_i64(t1, t1, 16);
+    tcg_gen_or_i64(t2, t2, t1);
+    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
+    tcg_gen_shri_i64(t1, t1, 8);
+    tcg_gen_or_i64(t2, t2, t1);
+
+    mask <<=3D 8;
+    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
+    tcg_gen_shri_i64(t1, t1, 8);
+    tcg_gen_or_i64(t2, t2, t1);
+    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
+    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t2, t1);
+
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
+}
+
+/*
+ * [MSA] ILVL.H wd, ws, wt
+ *
+ *   Vector Interleave Left (halfword data elements)
+ *
+ */
+static inline void gen_ilvl_h(CPUMIPSState *env, uint32_t wd,
+                              uint32_t ws, uint32_t wt)
+{
+    TCGv_i64 t1 =3D tcg_temp_new_i64();
+    TCGv_i64 t2 =3D tcg_temp_new_i64();
+    uint64_t mask =3D 0x000000000000ffffULL;
+
+    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
+    tcg_gen_mov_i64(t2, t1);
+    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
+    tcg_gen_shli_i64(t1, t1, 16);
+    tcg_gen_or_i64(t2, t2, t1);
+
+    mask <<=3D 16;
+    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
+    tcg_gen_shli_i64(t1, t1, 16);
+    tcg_gen_or_i64(t2, t2, t1);
+    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
+    tcg_gen_shli_i64(t1, t1, 32);
+    tcg_gen_or_i64(msa_wr_d[wd * 2], t2, t1);
+
+    mask <<=3D 16;
+    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
+    tcg_gen_shri_i64(t1, t1, 32);
+    tcg_gen_mov_i64(t2, t1);
+    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
+    tcg_gen_shri_i64(t1, t1, 16);
+    tcg_gen_or_i64(t2, t2, t1);
+
+    mask <<=3D 16;
+    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
+    tcg_gen_shri_i64(t1, t1, 16);
+    tcg_gen_or_i64(t2, t2, t1);
+    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
+    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t2, t1);
+
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
+}
+
+/*
+ * [MSA] ILVL.W wd, ws, wt
+ *
+ *   Vector Interleave Left (word data elements)
+ *
+ */
+static inline void gen_ilvl_w(CPUMIPSState *env, uint32_t wd,
+                              uint32_t ws, uint32_t wt)
+{
+    TCGv_i64 t1 =3D tcg_temp_new_i64();
+    TCGv_i64 t2 =3D tcg_temp_new_i64();
+    uint64_t mask =3D 0x00000000ffffffffULL;
+
+    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
+    tcg_gen_mov_i64(t2, t1);
+    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
+    tcg_gen_shli_i64(t1, t1, 32);
+    tcg_gen_or_i64(msa_wr_d[wd * 2], t2, t1);
+
+    mask <<=3D 32;
+    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
+    tcg_gen_shri_i64(t1, t1, 32);
+    tcg_gen_mov_i64(t2, t1);
+    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
+    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t2, t1);
+
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
+}
+
+/*
+ * [MSA] ILVL.D wd, ws, wt
+ *
+ *   Vector Interleave Left (doubleword data elements)
+ *
+ */
+static inline void gen_ilvl_d(CPUMIPSState *env, uint32_t wd,
+                              uint32_t ws, uint32_t wt)
+{
+    tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2 + 1]);
+    tcg_gen_mov_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2 + 1]);
+}
+
+/*
  * [MSA] ILVOD.B wd, ws, wt
  *
  *   Vector Interleave Odd (byte data elements)
@@ -29177,7 +29344,22 @@ static void gen_msa_3r(CPUMIPSState *env, DisasC=
ontext *ctx)
         gen_helper_msa_div_s_df(cpu_env, tdf, twd, tws, twt);
         break;
     case OPC_ILVL_df:
-        gen_helper_msa_ilvl_df(cpu_env, tdf, twd, tws, twt);
+        switch (df) {
+        case DF_BYTE:
+            gen_helper_msa_ilvl_b(cpu_env, twd, tws, twt);
+            break;
+        case DF_HALF:
+            gen_ilvl_h(env, wd, ws, wt);
+            break;
+        case DF_WORD:
+            gen_ilvl_w(env, wd, ws, wt);
+            break;
+        case DF_DOUBLE:
+            gen_ilvl_d(env, wd, ws, wt);
+            break;
+        default:
+            assert(0);
+        }
         break;
     case OPC_BNEG_df:
         gen_helper_msa_bneg_df(cpu_env, tdf, twd, tws, twt);
--=20
2.7.4
