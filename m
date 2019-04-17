Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7EEC282DC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 15:35:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE1620835
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 15:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE1620835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55458 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGmbK-0001cf-Sb
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 11:35:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hGmZB-0000LA-Rp
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hGmZ9-0004lu-FP
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:33:41 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:34567 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1hGmZ7-0004jU-FF
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:33:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 884021A4130;
	Wed, 17 Apr 2019 17:33:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw310-lin.domain.local (rtrkw310-lin.domain.local
	[10.10.13.97])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 5811E1A2476;
	Wed, 17 Apr 2019 17:33:34 +0200 (CEST)
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Apr 2019 17:33:23 +0200
Message-Id: <1555515206-9352-4-git-send-email-mateja.marjanovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555515206-9352-1-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1555515206-9352-1-git-send-email-mateja.marjanovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v7 3/6] target/mips: Optimize ILVL.<B|H|W|D>
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
Message-ID: <20190417153323.mGHOTDhDidqNXPCVJZJ_Q7cZw475srJLLzghqmknG3g@z>

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

Optimize ILVL.<B|H|W|D> instructions, using a hybrid
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
||  ilvl.b   || 59.91 ms || 74.41 ms || 60.50 ms (helper) ||
||  ilvl.h   || 41.33 ms || 33.08 ms || 33.34 ms (tcg)    ||
||  ilvl.w   || 30.99 ms || 22.87 ms || 23.19 ms (tcg)    ||
||  ilvl.d   || 26.40 ms || 19.64 ms || 20.49 ms (tcg)    ||
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Suggested-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
---
 target/mips/helper.h     |   3 +-
 target/mips/msa_helper.c |  33 +++++++++++----
 target/mips/translate.c  | 106 +++++++++++++++++++++++++++++++++++++++++=
+++++-
 3 files changed, 132 insertions(+), 10 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 82f6a40..f737a0e 100644
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
@@ -934,6 +933,8 @@ DEF_HELPER_4(msa_pcnt_df, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_nloc_df, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_nlzc_df, void, env, i32, i32, i32)
=20
+DEF_HELPER_4(msa_ilvl_b, void, env, i32, i32, i32)
+
 DEF_HELPER_4(msa_copy_s_b, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_copy_s_h, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_copy_s_w, void, env, i32, i32, i32)
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index d5c3842..20ce447 100644
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
@@ -1214,6 +1206,31 @@ MSA_FN_DF(vshf_df)
 #undef MSA_LOOP_COND
 #undef MSA_FN_DF
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
 void helper_msa_sldi_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
                         uint32_t ws, uint32_t n)
 {
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 95bcc65..ee60f29 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -28885,6 +28885,95 @@ static void gen_msa_bit(CPUMIPSState *env, Disas=
Context *ctx)
 }
=20
 /*
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
@@ -29148,7 +29237,22 @@ static void gen_msa_3r(CPUMIPSState *env, DisasC=
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


