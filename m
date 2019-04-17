Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859F9C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 15:38:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4769020674
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 15:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4769020674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55482 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGme3-0003jZ-F5
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 11:38:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hGmZB-0000L8-8n
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hGmZ9-0004lo-F1
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:33:41 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:34560 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1hGmZ7-0004jT-Em
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:33:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 6E48B1A2451;
	Wed, 17 Apr 2019 17:33:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw310-lin.domain.local (rtrkw310-lin.domain.local
	[10.10.13.97])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 4B4251A2473;
	Wed, 17 Apr 2019 17:33:34 +0200 (CEST)
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Apr 2019 17:33:22 +0200
Message-Id: <1555515206-9352-3-git-send-email-mateja.marjanovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555515206-9352-1-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1555515206-9352-1-git-send-email-mateja.marjanovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v7 2/6] target/mips: Optimize ILVEV.<B|H|W|D>
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
Message-ID: <20190417153322.CY3azQafCF-6nbkh_OpJSYVRaj4UXbCHSjU-XvbY0IU@z>

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

Optimize set of MSA instructions ILVEV.<B|H|W|D>, using
directly tcg registers and performing logic on them
instead of using helpers.

In the following table, the first column is the performance
before this patch. The second represents the performance
after converting from helpers to tcg, but without using
tcg_gen_deposit function. The third one is with using the
tcg_gen_deposit function and with using a uint64_t constant
bit mask, and the fourth is with using the tcg_gen_deposit
function and with a mask which is a tcg constant. The fourth
is implemented in this patch.

Performance measurement is done by executing the
instructions 10 million times on a computer
with Intel Core i7-3770 CPU @ 3.40GHz=C3=978.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
|| instruction ||     1     ||     2    ||     3    ||     4    ||
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
||   ilvev.b   || 126.92 ms || 24.52 ms || 25.19 ms || 23.89 ms ||
||   ilvev.h   ||  93.67 ms || 23.92 ms || 24.76 ms || 24.31 ms ||
||   ilvev.w   || 117.86 ms || 23.83 ms || 21.84 ms || 21.99 ms ||
||   ilvev.d   ||  45.49 ms || 19.74 ms || 20.21 ms || 20.07 ms ||
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1 - before
2 - no-deposit-no-mask-as-tcg-constant
3 - with-deposit-no-mask-as-tcg-constant
4 - with-deposit-with-mask-as-tcg-constant (final)

The deposit function is used only in ILVEV.W.

No-deposit version of the ILVEV.W implementation:

static inline void gen_ilvev_w(CPUMIPSState *env, uint32_t wd,
                               uint32_t ws, uint32_t wt)
{
    TCGv_i64 t1 =3D tcg_temp_new_i64();
    TCGv_i64 t2 =3D tcg_temp_new_i64();
    uint64_t mask =3D 0x00000000ffffffffULL;

    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
    tcg_gen_andi_i64(t2, msa_wr_d[ws * 2], mask);
    tcg_gen_shli_i64(t2, t2, 32);
    tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);

    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
    tcg_gen_andi_i64(t2, msa_wr_d[ws * 2 + 1], mask);
    tcg_gen_shli_i64(t2, t2, 32);
    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);

    tcg_temp_free_i64(t1);
    tcg_temp_free_i64(t2);
}

Suggested-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
---
 target/mips/helper.h     |  1 -
 target/mips/msa_helper.c |  9 -----
 target/mips/translate.c  | 87 ++++++++++++++++++++++++++++++++++++++++++=
+++++-
 3 files changed, 86 insertions(+), 11 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 02e16c7..82f6a40 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -864,7 +864,6 @@ DEF_HELPER_5(msa_pckev_df, void, env, i32, i32, i32, =
i32)
 DEF_HELPER_5(msa_pckod_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_ilvl_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_ilvr_df, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(msa_ilvev_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_vshf_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_srar_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_srlr_df, void, env, i32, i32, i32, i32)
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index a7ea6aa..d5c3842 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -1197,15 +1197,6 @@ MSA_FN_DF(ilvl_df)
     } while (0)
 MSA_FN_DF(ilvr_df)
 #undef MSA_DO
-
-#define MSA_DO(DF)                      \
-    do {                                \
-        pwx->DF[2*i]   =3D pwt->DF[2*i];  \
-        pwx->DF[2*i+1] =3D pws->DF[2*i];  \
-    } while (0)
-MSA_FN_DF(ilvev_df)
-#undef MSA_DO
-
 #undef MSA_LOOP_COND
=20
 #define MSA_LOOP_COND(DF) \
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 4c8fef0..95bcc65 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -28958,6 +28958,76 @@ static inline void gen_ilvod_d(CPUMIPSState *env=
, uint32_t wd,
     tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2 + 1]);
 }
=20
+
+/*
+ * [MSA] ILVEV.<B|H> wd, ws, wt
+ *
+ *   Vector Interleave Even (<byte|halfword> data elements)
+ *
+ */
+static inline void gen_ilvev_bh(CPUMIPSState *env, uint32_t wd,
+                                uint32_t ws, uint32_t wt,
+                                uint64_t mask, uint32_t shift)
+{
+    TCGv_i64 t1 =3D tcg_temp_new_i64();
+    TCGv_i64 t2 =3D tcg_temp_new_i64();
+    TCGv_i64 mask_tcg =3D tcg_const_i64(mask);
+
+    tcg_gen_and_i64(t1, msa_wr_d[wt * 2], mask_tcg);
+    tcg_gen_and_i64(t2, msa_wr_d[ws * 2], mask_tcg);
+    tcg_gen_shli_i64(t2, t2, shift);
+    tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
+
+    tcg_gen_and_i64(t1, msa_wr_d[wt * 2 + 1], mask_tcg);
+    tcg_gen_and_i64(t2, msa_wr_d[ws * 2 + 1], mask_tcg);
+    tcg_gen_shli_i64(t2, t2, shift);
+    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
+
+    tcg_temp_free_i64(mask_tcg);
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
+}
+
+static inline void gen_ilvev_b(CPUMIPSState *env, uint32_t wd,
+                               uint32_t ws, uint32_t wt)
+{
+    gen_ilvev_bh(env, wd, ws, wt, 0x00ff00ff00ff00ffULL, 8);
+}
+
+static inline void gen_ilvev_h(CPUMIPSState *env, uint32_t wd,
+                               uint32_t ws, uint32_t wt)
+{
+    gen_ilvev_bh(env, wd, ws, wt, 0x0000ffff0000ffffULL, 16);
+}
+
+/*
+ * [MSA] ILVEV.W wd, ws, wt
+ *
+ *   Vector Interleave Even (word data elements)
+ *
+ */
+static inline void gen_ilvev_w(CPUMIPSState *env, uint32_t wd,
+                               uint32_t ws, uint32_t wt)
+{
+    tcg_gen_deposit_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2],
+                        msa_wr_d[ws * 2], 32, 32);
+    tcg_gen_deposit_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[wt * 2 + 1],
+                        msa_wr_d[ws * 2 + 1], 32, 32);
+}
+
+/*
+ * [MSA] ILVEV.D wd, ws, wt
+ *
+ *   Vector Interleave Even (Doubleword data elements)
+ *
+ */
+static inline void gen_ilvev_d(CPUMIPSState *env, uint32_t wd,
+                               uint32_t ws, uint32_t wt)
+{
+    tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2]);
+    tcg_gen_mov_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2]);
+}
+
 static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
 {
 #define MASK_MSA_3R(op)    (MASK_MSA_MINOR(op) | (op & (0x7 << 23)))
@@ -29114,7 +29184,22 @@ static void gen_msa_3r(CPUMIPSState *env, DisasC=
ontext *ctx)
         gen_helper_msa_mod_s_df(cpu_env, tdf, twd, tws, twt);
         break;
     case OPC_ILVEV_df:
-        gen_helper_msa_ilvev_df(cpu_env, tdf, twd, tws, twt);
+        switch (df) {
+        case DF_BYTE:
+            gen_ilvev_b(env, wd, ws, wt);
+            break;
+        case DF_HALF:
+            gen_ilvev_h(env, wd, ws, wt);
+            break;
+        case DF_WORD:
+            gen_ilvev_w(env, wd, ws, wt);
+            break;
+        case DF_DOUBLE:
+            gen_ilvev_d(env, wd, ws, wt);
+            break;
+        default:
+            assert(0);
+        }
         break;
     case OPC_BINSR_df:
         gen_helper_msa_binsr_df(cpu_env, tdf, twd, tws, twt);
--=20
2.7.4


