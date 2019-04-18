Received: from eggs.gnu.org ([209.51.188.92]:43722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hH940-0007d7-QT
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hH8yW-00033Z-LC
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:29:22 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:36797 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1hH8yW-00032V-8x
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:29:20 -0400
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Thu, 18 Apr 2019 17:29:07 +0200
Message-Id: <1555601350-4176-4-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1555601350-4176-1-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1555601350-4176-1-git-send-email-mateja.marjanovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 3/6] target/mips: Optimize ILVL.<B|H|W|D>
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

Optimize ILVL.<B|H|W|D> instructions, using
directly tcg registers and logic performed on
them, and instead of shifting the bit mask or
assigning a new tcg constant to the bit mask,
assign a new (shifted) uint64_t value to the
bit mask.

Performance measurement is done by executing the
instructions 10 million times on a computer
with Intel Core i7-3770 CPU @ 3.40GHz=C3=978.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
|| instruction ||   BEFORE    || LOOP UNROLL ||    TCG   ||
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
||   ilvl.b    || 107.069 ms  ||  55.619 ms  || 7.735 ms ||
||   ilvl.h    ||  83.340 ms  ||  31.320 ms  || 3.797 ms ||
||   ilvl.w    || 109.448 ms  ||  31.714 ms  || 2.381 ms ||
||   ilvl.d    ||  31.557 ms  ||  28.716 ms  || 2.029 ms ||
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

Suggested-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
---
 target/mips/helper.h     |   1 -
 target/mips/msa_helper.c |   8 ---
 target/mips/translate.c  | 184 +++++++++++++++++++++++++++++++++++++++++=
+++++-
 3 files changed, 183 insertions(+), 10 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 2f23b0d..85c8b17 100644
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
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index a500c59..f9b85fc 100644
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
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 930ef3a..d9aef77 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -28002,6 +28002,173 @@ static void gen_msa_bit(CPUMIPSState *env, Disa=
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
+    mask =3D 0x000000000000ff00ULL;
+    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
+    tcg_gen_shli_i64(t1, t1, 8);
+    tcg_gen_or_i64(t2, t2, t1);
+    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
+    tcg_gen_shli_i64(t1, t1, 16);
+    tcg_gen_or_i64(t2, t2, t1);
+
+    mask =3D 0x0000000000ff0000ULL;
+    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
+    tcg_gen_shli_i64(t1, t1, 16);
+    tcg_gen_or_i64(t2, t2, t1);
+    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
+    tcg_gen_shli_i64(t1, t1, 24);
+    tcg_gen_or_i64(t2, t2, t1);
+
+    mask =3D 0x00000000ff000000ULL;
+    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
+    tcg_gen_shli_i64(t1, t1, 24);
+    tcg_gen_or_i64(t2, t2, t1);
+    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
+    tcg_gen_shli_i64(t1, t1, 32);
+    tcg_gen_or_i64(msa_wr_d[wd * 2], t2, t1);
+
+    mask =3D 0x000000ff00000000ULL;
+    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
+    tcg_gen_shri_i64(t1, t1, 32);
+    tcg_gen_mov_i64(t2, t1);
+    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
+    tcg_gen_shri_i64(t1, t1, 24);
+    tcg_gen_or_i64(t2, t2, t1);
+
+    mask =3D 0x0000ff0000000000ULL;
+    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
+    tcg_gen_shri_i64(t1, t1, 24);
+    tcg_gen_or_i64(t2, t2, t1);
+    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
+    tcg_gen_shri_i64(t1, t1, 16);
+    tcg_gen_or_i64(t2, t2, t1);
+
+    mask =3D 0x00ff000000000000ULL;
+    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
+    tcg_gen_shri_i64(t1, t1, 16);
+    tcg_gen_or_i64(t2, t2, t1);
+    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
+    tcg_gen_shri_i64(t1, t1, 8);
+    tcg_gen_or_i64(t2, t2, t1);
+
+    mask =3D 0xff00000000000000ULL;
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
+    mask =3D 0x00000000ffff0000ULL;
+    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
+    tcg_gen_shli_i64(t1, t1, 16);
+    tcg_gen_or_i64(t2, t2, t1);
+    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
+    tcg_gen_shli_i64(t1, t1, 32);
+    tcg_gen_or_i64(msa_wr_d[wd * 2], t2, t1);
+
+    mask =3D 0x0000ffff00000000ULL;
+    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
+    tcg_gen_shri_i64(t1, t1, 32);
+    tcg_gen_mov_i64(t2, t1);
+    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
+    tcg_gen_shri_i64(t1, t1, 16);
+    tcg_gen_or_i64(t2, t2, t1);
+
+    mask =3D 0xffff000000000000ULL;
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
+    mask =3D 0xffffffff00000000ULL;
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
+    tcg_gen_mov_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2 + 1]);
+    tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2 + 1]);
+}
+
+/*
  * [MSA] ILVOD.<B|H> wd, ws, wt
  *
  *   Vector Interleave Odd (<byte|halfword> data elements)
@@ -28265,7 +28432,22 @@ static void gen_msa_3r(CPUMIPSState *env, DisasC=
ontext *ctx)
         gen_helper_msa_div_s_df(cpu_env, tdf, twd, tws, twt);
         break;
     case OPC_ILVL_df:
-        gen_helper_msa_ilvl_df(cpu_env, tdf, twd, tws, twt);
+        switch (df) {
+        case DF_BYTE:
+            gen_ilvl_b(env, wd, ws, wt);
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
