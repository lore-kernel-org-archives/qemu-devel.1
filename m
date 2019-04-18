Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295C0C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:39:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E24E220835
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24E220835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43144 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH98E-0002uT-6M
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 11:39:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hH941-0007d8-Py
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:35:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hH8yW-00033g-NZ
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:29:22 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:36772 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1hH8yW-00032H-C2
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:29:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id CBC701A246A;
	Thu, 18 Apr 2019 17:29:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw310-lin.domain.local (rtrkw310-lin.domain.local
	[10.10.13.97])
	by mail.rt-rk.com (Postfix) with ESMTPSA id A0FC11A2462;
	Thu, 18 Apr 2019 17:29:17 +0200 (CEST)
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Apr 2019 17:29:05 +0200
Message-Id: <1555601350-4176-2-git-send-email-mateja.marjanovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555601350-4176-1-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1555601350-4176-1-git-send-email-mateja.marjanovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v9 1/6] target/mips: Optimize ILVOD.<B|H|W|D>
 MSA instructions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: arikalo@wavecomp.com, richard.henderson@linaro.org, philmd@redhat.com,
	amarkovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418152905.yKIePpmXOmqw9lgmBKo_LYOeKzyfjr1Hx7UEhYS6xng@z>

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

Optimize set of MSA instructions ILVOD.<B|H|W|D>, using
directly tcg registers and performing logic on them instead
of using helpers.

In the following table, the first column is the performance
before this patch. The second represents the performance
after converting from helpers to tcg, but without using
tcg_gen_deposit function. The third one is with the deposit
function and with using a uint64_t constant bit mask, and
the fourth is with the deposit function and with a mask
which is a tcg constant. The fourth is implemented in this
patch.

Performance measurement is done by executing the
instructions 10 million times on a computer
with Intel Core i7-3770 CPU @ 3.40GHz=C3=978.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
|| instruction ||      1     ||     2    ||     3    ||     4    ||
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
||   ilvod.b   || 107.585 ms || 2.717 ms || 2.572 ms || 2.373 ms ||
||   ilvod.h   ||  82.871 ms || 2.420 ms || 2.414 ms || 2.320 ms ||
||   ilvod.w   || 109.722 ms || 2.702 ms || 2.348 ms || 2.303 ms ||
||   ilvod.d   ||  30.813 ms || 2.083 ms || 2.036 ms || 2.036 ms ||
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1 - before
2 - no-deposit-no-mask-as-tcg-constant
3 - with-deposit-no-mask-as-tcg-constant
4 - with-deposit-with-mask-as-tcg-constant (final)

The deposit function is used only in ILVOD.W.

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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
---
 target/mips/helper.h     |  1 -
 target/mips/msa_helper.c |  7 ----
 target/mips/translate.c  | 91 ++++++++++++++++++++++++++++++++++++++++++=
+++++-
 3 files changed, 90 insertions(+), 9 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index a6d687e..d162836 100644
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
index c74e3cd..9e52a31 100644
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
index 364bd6d..99bd441 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -28001,6 +28001,80 @@ static void gen_msa_bit(CPUMIPSState *env, Disas=
Context *ctx)
     tcg_temp_free_i32(tws);
 }
=20
+/*
+ * [MSA] ILVOD.<B|H> wd, ws, wt
+ *
+ *   Vector Interleave Odd (<byte|halfword> data elements)
+ *
+ */
+static inline void gen_ilvod_bh(CPUMIPSState *env, uint32_t wd,
+                                uint32_t ws, uint32_t wt,
+                                uint64_t mask, uint32_t shift)
+{
+    TCGv_i64 t1 =3D tcg_temp_new_i64();
+    TCGv_i64 t2 =3D tcg_temp_new_i64();
+    TCGv_i64 mask_tcg =3D tcg_const_i64(mask);
+
+    tcg_gen_and_i64(t1, msa_wr_d[wt * 2], mask_tcg);
+    tcg_gen_shri_i64(t1, t1, shift);
+    tcg_gen_and_i64(t2, msa_wr_d[ws * 2], mask_tcg);
+    tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
+
+    tcg_gen_and_i64(t1, msa_wr_d[wt * 2 + 1], mask_tcg);
+    tcg_gen_shri_i64(t1, t1, shift);
+    tcg_gen_and_i64(t2, msa_wr_d[ws * 2 + 1], mask_tcg);
+    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
+
+    tcg_temp_free_i64(mask_tcg);
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
+}
+
+static inline void gen_ilvod_b(CPUMIPSState *env, uint32_t wd,
+                               uint32_t ws, uint32_t wt)
+{
+    gen_ilvod_bh(env, wd, ws, wt, 0xff00ff00ff00ff00ULL, 8);
+}
+
+static inline void gen_ilvod_h(CPUMIPSState *env, uint32_t wd,
+                               uint32_t ws, uint32_t wt)
+{
+    gen_ilvod_bh(env, wd, ws, wt, 0xffff0000ffff0000ULL, 16);
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
@@ -28172,7 +28246,22 @@ static void gen_msa_3r(CPUMIPSState *env, DisasC=
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


