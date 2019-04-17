Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A77C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 15:36:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A8EF20674
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 15:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8EF20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55462 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGmc3-0002AY-KB
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 11:36:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hGmZB-0000L7-8Z
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hGmZ8-0004l0-9X
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:33:40 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:34571 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1hGmZ7-0004jV-E4
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:33:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 89C791A4132;
	Wed, 17 Apr 2019 17:33:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw310-lin.domain.local (rtrkw310-lin.domain.local
	[10.10.13.97])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 652BD1A39C9;
	Wed, 17 Apr 2019 17:33:34 +0200 (CEST)
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Apr 2019 17:33:24 +0200
Message-Id: <1555515206-9352-5-git-send-email-mateja.marjanovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555515206-9352-1-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1555515206-9352-1-git-send-email-mateja.marjanovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v7 4/6] target/mips: Optimize ILVR.<B|H|W|D>
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
Message-ID: <20190417153324.fP172QGMov0-KHdqRLKs3YzSo-1av3HwM7MpgpXKiM0@z>

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

Optimize ILVR.<B|H|W|D> instructions, using a hybrid
approach. For byte data elements, use a helper with an
unrolled loop (having much better performance than
direct tcg translation), for halfword, word and
doubleword data elements use directly tcg registers
and logic performed on them.

Performance measurement is done by executing the
instructions 10 million times on a computer
with Intel Core i7-3770 CPU @ 3.40GHz=C3=978.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
||instruction||  helper  ||   tcg    ||      hybrid       ||
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
||  ilvr.b   || 62.87 ms || 74.76 ms || 61.49 ms (helper) ||
||  ilvr.h   || 44.11 ms || 33.00 ms || 33.69 ms (tcg)    ||
||  ilvr.w   || 34.97 ms || 23.06 ms || 23.01 ms (tcg)    ||
||  ilvr.d   || 27.33 ms || 19.87 ms || 19.65 ms (tcg)    ||
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Suggested-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
---
 target/mips/helper.h     |   2 +-
 target/mips/msa_helper.c |  33 +++++++++++----
 target/mips/translate.c  | 107 +++++++++++++++++++++++++++++++++++++++++=
+++++-
 3 files changed, 132 insertions(+), 10 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index f737a0e..4aee81c 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -862,7 +862,6 @@ DEF_HELPER_5(msa_sld_df, void, env, i32, i32, i32, i3=
2)
 DEF_HELPER_5(msa_splat_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_pckev_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_pckod_df, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(msa_ilvr_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_vshf_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_srar_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_srlr_df, void, env, i32, i32, i32, i32)
@@ -933,6 +932,7 @@ DEF_HELPER_4(msa_pcnt_df, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_nloc_df, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_nlzc_df, void, env, i32, i32, i32)
=20
+DEF_HELPER_4(msa_ilvr_b, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_ilvl_b, void, env, i32, i32, i32)
=20
 DEF_HELPER_4(msa_copy_s_b, void, env, i32, i32, i32)
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 20ce447..fedd9b5 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -1181,14 +1181,6 @@ MSA_FN_DF(pckev_df)
     } while (0)
 MSA_FN_DF(pckod_df)
 #undef MSA_DO
-
-#define MSA_DO(DF)                      \
-    do {                                \
-        pwx->DF[2*i]   =3D R##DF(pwt, i); \
-        pwx->DF[2*i+1] =3D R##DF(pws, i); \
-    } while (0)
-MSA_FN_DF(ilvr_df)
-#undef MSA_DO
 #undef MSA_LOOP_COND
=20
 #define MSA_LOOP_COND(DF) \
@@ -1206,6 +1198,31 @@ MSA_FN_DF(vshf_df)
 #undef MSA_LOOP_COND
 #undef MSA_FN_DF
=20
+void helper_msa_ilvr_b(CPUMIPSState *env, uint32_t wd,
+                       uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws =3D &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt =3D &(env->active_fpu.fpr[wt].wr);
+
+    pwd->b[15] =3D pws->b[7];
+    pwd->b[14] =3D pwt->b[7];
+    pwd->b[13] =3D pws->b[6];
+    pwd->b[12] =3D pwt->b[6];
+    pwd->b[11] =3D pws->b[5];
+    pwd->b[10] =3D pwt->b[5];
+    pwd->b[9]  =3D pws->b[4];
+    pwd->b[8]  =3D pwt->b[4];
+    pwd->b[7]  =3D pws->b[3];
+    pwd->b[6]  =3D pwt->b[3];
+    pwd->b[5]  =3D pws->b[2];
+    pwd->b[4]  =3D pwt->b[2];
+    pwd->b[3]  =3D pws->b[1];
+    pwd->b[2]  =3D pwt->b[1];
+    pwd->b[1]  =3D pws->b[0];
+    pwd->b[0]  =3D pwt->b[0];
+}
+
 void helper_msa_ilvl_b(CPUMIPSState *env, uint32_t wd,
                        uint32_t ws, uint32_t wt)
 {
diff --git a/target/mips/translate.c b/target/mips/translate.c
index ee60f29..4c7b076 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -28885,6 +28885,96 @@ static void gen_msa_bit(CPUMIPSState *env, Disas=
Context *ctx)
 }
=20
 /*
+ * [MSA] ILVR.H wd, ws, wt
+ *
+ *   Vector Interleave Right (halfword data elements)
+ *
+ */
+static inline void gen_ilvr_h(CPUMIPSState *env, uint32_t wd,
+                              uint32_t ws, uint32_t wt)
+{
+    TCGv_i64 t1 =3D tcg_temp_new_i64();
+    TCGv_i64 t2 =3D tcg_temp_new_i64();
+    uint64_t mask =3D 0x000000000000ffffULL;
+
+    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
+    tcg_gen_mov_i64(t2, t1);
+    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2], mask);
+    tcg_gen_shli_i64(t1, t1, 16);
+    tcg_gen_or_i64(t2, t2, t1);
+
+    mask =3D 0x00000000ffff0000ULL;
+    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
+    tcg_gen_shli_i64(t1, t1, 16);
+    tcg_gen_or_i64(t2, t2, t1);
+    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2], mask);
+    tcg_gen_shli_i64(t1, t1, 32);
+    tcg_gen_or_i64(msa_wr_d[wd * 2], t2, t1);
+
+    mask =3D 0x0000ffff00000000ULL;
+    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
+    tcg_gen_shri_i64(t1, t1, 32);
+    tcg_gen_mov_i64(t2, t1);
+    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2], mask);
+    tcg_gen_shri_i64(t1, t1, 16);
+    tcg_gen_or_i64(t2, t2, t1);
+
+    mask =3D 0xffff000000000000ULL;
+    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
+    tcg_gen_shri_i64(t1, t1, 16);
+    tcg_gen_or_i64(t2, t2, t1);
+    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2], mask);
+    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t2, t1);
+
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
+}
+
+/*
+ * [MSA] ILVR.W wd, ws, wt
+ *
+ *   Vector Interleave Right (word data elements)
+ *
+ */
+static inline void gen_ilvr_w(CPUMIPSState *env, uint32_t wd,
+                              uint32_t ws, uint32_t wt)
+{
+    TCGv_i64 t1 =3D tcg_temp_new_i64();
+    TCGv_i64 t2 =3D tcg_temp_new_i64();
+    uint64_t mask =3D 0x00000000ffffffffULL;
+
+    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
+    tcg_gen_mov_i64(t2, t1);
+    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2], mask);
+    tcg_gen_shli_i64(t1, t1, 32);
+    tcg_gen_or_i64(msa_wr_d[wd * 2], t2, t1);
+
+    mask =3D 0xffffffff00000000ULL;
+    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
+    tcg_gen_shri_i64(t1, t1, 32);
+    tcg_gen_mov_i64(t2, t1);
+    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2], mask);
+    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t2, t1);
+
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
+}
+
+/*
+ * [MSA] ILVR.D wd, ws, wt
+ *
+ *   Vector Interleave Right (doubleword data elements)
+ *
+ */
+static inline void gen_ilvr_d(CPUMIPSState *env, uint32_t wd,
+                              uint32_t ws, uint32_t wt)
+{
+    tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2]);
+    tcg_gen_mov_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2]);
+}
+
+
+/*
  * [MSA] ILVL.H wd, ws, wt
  *
  *   Vector Interleave Left (halfword data elements)
@@ -29273,7 +29363,22 @@ static void gen_msa_3r(CPUMIPSState *env, DisasC=
ontext *ctx)
         gen_helper_msa_div_u_df(cpu_env, tdf, twd, tws, twt);
         break;
     case OPC_ILVR_df:
-        gen_helper_msa_ilvr_df(cpu_env, tdf, twd, tws, twt);
+        switch (df) {
+        case DF_BYTE:
+            gen_helper_msa_ilvr_b(cpu_env, twd, tws, twt);
+            break;
+        case DF_HALF:
+            gen_ilvr_h(env, wd, ws, wt);
+            break;
+        case DF_WORD:
+            gen_ilvr_w(env, wd, ws, wt);
+            break;
+        case DF_DOUBLE:
+            gen_ilvr_d(env, wd, ws, wt);
+            break;
+        default:
+            assert(0);
+        }
         break;
     case OPC_BINSL_df:
         gen_helper_msa_binsl_df(cpu_env, tdf, twd, tws, twt);
--=20
2.7.4


