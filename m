Received: from eggs.gnu.org ([209.51.188.92]:51291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hC2Dr-0004xC-LY
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 09:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hC2Dq-0004fD-3n
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 09:16:03 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:40243 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1hC2Dp-0003Gf-Ka
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 09:16:02 -0400
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Thu,  4 Apr 2019 15:14:47 +0200
Message-Id: <1554383690-28338-2-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1554383690-28338-1-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1554383690-28338-1-git-send-email-mateja.marjanovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 1/4] target/mips: Optimize ILVOD.<B|H|W|D>
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

Optimize set of MSA instructions ILVOD.<B|H|W|D>, using
directly tcg registers and performing logic on them instead
of using helpers.

In the following table, the first column is the performance
before this patch. The second represents the performance,
after converting from helpers to tcg, but without using
tcg_gen_deposit function. The third one is the solution
which is implemented in this patch.

Performance measurement is done by executing the
instructions a large number of times on a computer
with Intel Core i7-3770 CPU @ 3.40GHz=C3=978.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
|| instr    ||   before    || no-deposit || with-deposit  ||
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
|| ilvod.b  ||  117.50 ms  ||  24.13 ms  ||   23.71 ms    ||
|| ilvod.h  ||   93.16 ms  ||  24.21 ms  ||   23.45 ms    ||
|| ilvod.w  ||  119.90 ms  ||  24.15 ms  ||   22.91 ms    ||
|| ilvod.d  ||   43.01 ms  ||  21.17 ms  ||   20.53 ms    ||
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

No-deposit column and with-deposit column have the
same statistical values in every row, except ILVOD.W,
which is the only function which uses the deposit
function.

No-deposit version of the ILVOD.W implementation:

static inline void gen_ilvod_w(CPUMIPSState *env, uint32_t wd,
                               uint32_t ws, uint32_t wt)
{
    TCGv_i64 t1 =3D tcg_temp_new_i64();
    TCGv_i64 t2 =3D tcg_temp_new_i64();
    TCGv_i64 mask =3D tcg_const_i64(0xffffffff00000000ULL);

    tcg_gen_and_i64(t1, msa_wr_d[wt * 2], mask);
    tcg_gen_shri_i64(t1, t1, 32);
    tcg_gen_and_i64(t2, msa_wr_d[ws * 2], mask);
    tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);

    tcg_gen_and_i64(t1, msa_wr_d[wt * 2 + 1], mask);
    tcg_gen_shri_i64(t1, t1, 32);
    tcg_gen_and_i64(t2, msa_wr_d[ws * 2 + 1], mask);
    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);

    tcg_temp_free_i64(mask);
    tcg_temp_free_i64(t1);
    tcg_temp_free_i64(t2);
}

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
---
 target/mips/helper.h     |   1 -
 target/mips/msa_helper.c |   7 ----
 target/mips/translate.c  | 106 +++++++++++++++++++++++++++++++++++++++++=
+++++-
 3 files changed, 105 insertions(+), 9 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 2863f60..02e16c7 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -865,7 +865,6 @@ DEF_HELPER_5(msa_pckod_df, void, env, i32, i32, i32, =
i32)
 DEF_HELPER_5(msa_ilvl_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_ilvr_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_ilvev_df, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(msa_ilvod_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_vshf_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_srar_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_srlr_df, void, env, i32, i32, i32, i32)
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 6c57281..a7ea6aa 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -1206,13 +1206,6 @@ MSA_FN_DF(ilvr_df)
 MSA_FN_DF(ilvev_df)
 #undef MSA_DO
=20
-#define MSA_DO(DF)                          \
-    do {                                    \
-        pwx->DF[2*i]   =3D pwt->DF[2*i+1];    \
-        pwx->DF[2*i+1] =3D pws->DF[2*i+1];    \
-    } while (0)
-MSA_FN_DF(ilvod_df)
-#undef MSA_DO
 #undef MSA_LOOP_COND
=20
 #define MSA_LOOP_COND(DF) \
diff --git a/target/mips/translate.c b/target/mips/translate.c
index bba8b6c..df685e4 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -28884,6 +28884,95 @@ static void gen_msa_bit(CPUMIPSState *env, Disas=
Context *ctx)
     tcg_temp_free_i32(tws);
 }
=20
+/*
+ * [MSA] ILVOD.B wd, ws, wt
+ *
+ *   Vector Interleave Odd (byte data elements)
+ *
+ */
+static inline void gen_ilvod_b(CPUMIPSState *env, uint32_t wd,
+                               uint32_t ws, uint32_t wt)
+{
+    TCGv_i64 t1 =3D tcg_temp_new_i64();
+    TCGv_i64 t2 =3D tcg_temp_new_i64();
+    TCGv_i64 mask =3D tcg_const_i64(0xff00ff00ff00ff00ULL);
+
+    tcg_gen_and_i64(t1, msa_wr_d[wt * 2], mask);
+    tcg_gen_shri_i64(t1, t1, 8);
+    tcg_gen_and_i64(t2, msa_wr_d[ws * 2], mask);
+    tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
+
+    tcg_gen_and_i64(t1, msa_wr_d[wt * 2 + 1], mask);
+    tcg_gen_shri_i64(t1, t1, 8);
+    tcg_gen_and_i64(t2, msa_wr_d[ws * 2 + 1], mask);
+    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
+
+    tcg_temp_free_i64(mask);
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
+}
+
+/*
+ * [MSA] ILVOD.H wd, ws, wt
+ *
+ *   Vector Interleave Odd (halfword data elements)
+ *
+ */
+static inline void gen_ilvod_h(CPUMIPSState *env, uint32_t wd,
+                               uint32_t ws, uint32_t wt)
+{
+    TCGv_i64 t1 =3D tcg_temp_new_i64();
+    TCGv_i64 t2 =3D tcg_temp_new_i64();
+    TCGv_i64 mask =3D tcg_const_i64(0xffff0000ffff0000ULL);
+
+    tcg_gen_and_i64(t1, msa_wr_d[wt * 2], mask);
+    tcg_gen_shri_i64(t1, t1, 16);
+    tcg_gen_and_i64(t2, msa_wr_d[ws * 2], mask);
+    tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
+
+    tcg_gen_and_i64(t1, msa_wr_d[wt * 2 + 1], mask);
+    tcg_gen_shri_i64(t1, t1, 16);
+    tcg_gen_and_i64(t2, msa_wr_d[ws * 2 + 1], mask);
+    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
+
+    tcg_temp_free_i64(mask);
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
+}
+
+/*
+ * [MSA] ILVOD.W wd, ws, wt
+ *
+ *   Vector Interleave Odd (word data elements)
+ *
+ */
+static inline void gen_ilvod_w(CPUMIPSState *env, uint32_t wd,
+                               uint32_t ws, uint32_t wt)
+{
+    TCGv_i64 t1 =3D tcg_temp_new_i64();
+
+    tcg_gen_shri_i64(t1, msa_wr_d[wt * 2], 32);
+    tcg_gen_deposit_i64(msa_wr_d[wd * 2], msa_wr_d[ws * 2], t1, 0, 32);
+
+    tcg_gen_shri_i64(t1, msa_wr_d[wt * 2 + 1], 32);
+    tcg_gen_deposit_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2 + 1], t1, =
0, 32);
+
+    tcg_temp_free_i64(t1);
+}
+
+/*
+ * [MSA] ILVOD.D wd, ws, wt
+ *
+ *   Vector Interleave Odd (doubleword data elements)
+ *
+ */
+static inline void gen_ilvod_d(CPUMIPSState *env, uint32_t wd,
+                               uint32_t ws, uint32_t wt)
+{
+    tcg_gen_mov_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2 + 1]);
+    tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2 + 1]);
+}
+
 static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
 {
 #define MASK_MSA_3R(op)    (MASK_MSA_MINOR(op) | (op & (0x7 << 23)))
@@ -29055,7 +29144,22 @@ static void gen_msa_3r(CPUMIPSState *env, DisasC=
ontext *ctx)
         gen_helper_msa_mod_u_df(cpu_env, tdf, twd, tws, twt);
         break;
     case OPC_ILVOD_df:
-        gen_helper_msa_ilvod_df(cpu_env, tdf, twd, tws, twt);
+        switch (df) {
+        case DF_BYTE:
+            gen_ilvod_b(env, wd, ws, wt);
+            break;
+        case DF_HALF:
+            gen_ilvod_h(env, wd, ws, wt);
+            break;
+        case DF_WORD:
+            gen_ilvod_w(env, wd, ws, wt);
+            break;
+        case DF_DOUBLE:
+            gen_ilvod_d(env, wd, ws, wt);
+            break;
+        default:
+            assert(0);
+        }
         break;
=20
     case OPC_DOTP_S_df:
--=20
2.7.4
