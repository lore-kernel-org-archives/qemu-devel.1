Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48E7C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:08:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 720F92080A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jrY2w58p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720F92080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56278 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haee6-0003sz-PF
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 07:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39331)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haeQ3-0007Mt-Pv
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haePy-0007Xl-2d
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:23 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:56298)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haePx-0007WS-P2
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:17 -0400
Received: by mail-wm1-x343.google.com with SMTP id a15so2410654wmj.5
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 03:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cK7JkilQieDkUn82Nw1HdIxAvdbLi1r9HYhhZBb3zbw=;
 b=jrY2w58p5/FPOklE7DpeP1DdQbEpg86SDopTlM+5PKQQSjAkAqkoP95xHOOoj1GF7n
 YrcS2uK/iucVz8Assl8ExlgojXF5TcnuDBTZLMZazJmPD0orPU9eueQaMMdqdUMlQt80
 NFTHTXFPotdS7fREjOnsqV9E2Xj7+mC2Qb2NMi4ustzSffBUt7dSJ9JwaXFxjffplin3
 Bj0mSydensa5U0D9viZJYS1lUM8MhbQxB8VJ0jR+EyeoTzDz4nzWZQhmPC0kQEx9KZUT
 /rALcNoBY+se0+It0cQ6raNB6oBshms6G9I8xJ50kMlPWIaT22vXhbkBWDZX5ewmgdky
 ppWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cK7JkilQieDkUn82Nw1HdIxAvdbLi1r9HYhhZBb3zbw=;
 b=bkxScvhnr/FJZX3mQqU+nXezg1m9OZvS8DYTTaLiKbPdTNb5Cb1nmhdhJqcGKPK6FD
 DMuFt5zI5yfkUwETEzkv8kRefKVVCpQuHwDHCCWERGRsbi6GHqNvDNuLKxb7kp/SGaKX
 fstMK06py7jWAMlQCMQvB3KkPiehmChnO1HhHtPGSAAjFoCKO85n5vv9lNpwSzq2YVFf
 KF9C5WnWP9JNWn/h7rlGvLdfcTPgVqwDDxxNi4Or88PuTKLfC+uyIvGE/3TXqv1m1uha
 UVt9zlRjGToVWM+QScVaGphhtCfiQROjJKPE4hKFl7jwx4Upjdu8chBySDh9NCHB0nPe
 WqbQ==
X-Gm-Message-State: APjAAAUvXihoRe2U+DIW2QIyXStHG/3JkRWeq2iuGrRXMXAdOdeFPbd1
 voXKaI7w6SODu1ahfGfHTixP5y503/xTHw==
X-Google-Smtp-Source: APXvYqyo+eMza8qCzreix8AbrnK1iGAYRXAzC/jdtEzAUWQkNAkUesJo3/izO5ZUW9vnQdi+i/mf4A==
X-Received: by 2002:a1c:3c8a:: with SMTP id
 j132mr17006597wma.172.1560250456796; 
 Tue, 11 Jun 2019 03:54:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e17sm10785945wrt.95.2019.06.11.03.54.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 03:54:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 11:53:30 +0100
Message-Id: <20190611105351.9871-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611105351.9871-1-peter.maydell@linaro.org>
References: <20190611105351.9871-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v2 21/42] target/arm: Convert VFP VNMLA to
 decodetree
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VFP VNMLA instruction to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 34 ++++++++++++++++++++++++++++++++++
 target/arm/translate.c         | 19 +------------------
 target/arm/vfp.decode          |  5 +++++
 3 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 1d7100debe4..8532bf4abcd 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1383,3 +1383,37 @@ static bool trans_VNMLS_dp(DisasContext *s, arg_VNMLS_sp *a)
 {
     return do_vfp_3op_dp(s, gen_VNMLS_dp, a->vd, a->vn, a->vm, true);
 }
+
+static void gen_VNMLA_sp(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm, TCGv_ptr fpst)
+{
+    /* VNMLA: -fd + -(fn * fm) */
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    gen_helper_vfp_muls(tmp, vn, vm, fpst);
+    gen_helper_vfp_negs(tmp, tmp);
+    gen_helper_vfp_negs(vd, vd);
+    gen_helper_vfp_adds(vd, vd, tmp, fpst);
+    tcg_temp_free_i32(tmp);
+}
+
+static bool trans_VNMLA_sp(DisasContext *s, arg_VNMLA_sp *a)
+{
+    return do_vfp_3op_sp(s, gen_VNMLA_sp, a->vd, a->vn, a->vm, true);
+}
+
+static void gen_VNMLA_dp(TCGv_i64 vd, TCGv_i64 vn, TCGv_i64 vm, TCGv_ptr fpst)
+{
+    /* VNMLA: -fd + (fn * fm) */
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    gen_helper_vfp_muld(tmp, vn, vm, fpst);
+    gen_helper_vfp_negd(tmp, tmp);
+    gen_helper_vfp_negd(vd, vd);
+    gen_helper_vfp_addd(vd, vd, tmp, fpst);
+    tcg_temp_free_i64(tmp);
+}
+
+static bool trans_VNMLA_dp(DisasContext *s, arg_VNMLA_sp *a)
+{
+    return do_vfp_3op_dp(s, gen_VNMLA_dp, a->vd, a->vn, a->vm, true);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index b3d0648bb50..1f83723b81a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1393,16 +1393,6 @@ VFP_OP2(div)
 
 #undef VFP_OP2
 
-static inline void gen_vfp_F1_neg(int dp)
-{
-    /* Like gen_vfp_neg() but put result in F1 */
-    if (dp) {
-        gen_helper_vfp_negd(cpu_F1d, cpu_F0d);
-    } else {
-        gen_helper_vfp_negs(cpu_F1s, cpu_F0s);
-    }
-}
-
 static inline void gen_vfp_abs(int dp)
 {
     if (dp)
@@ -3122,7 +3112,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             rn = VFP_SREG_N(insn);
 
             switch (op) {
-            case 0 ... 2:
+            case 0 ... 3:
                 /* Already handled by decodetree */
                 return 1;
             default:
@@ -3308,13 +3298,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             for (;;) {
                 /* Perform the calculation.  */
                 switch (op) {
-                case 3: /* VNMLA: -fd + -(fn * fm) */
-                    gen_vfp_mul(dp);
-                    gen_vfp_F1_neg(dp);
-                    gen_mov_F0_vreg(dp, rd);
-                    gen_vfp_neg(dp);
-                    gen_vfp_add(dp);
-                    break;
                 case 4: /* mul: fn * fm */
                     gen_vfp_mul(dp);
                     break;
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 08e4f427408..c50d2c3ebf3 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -112,3 +112,8 @@ VNMLS_sp     ---- 1110 0.01 .... .... 1010 .0.0 .... \
              vm=%vm_sp vn=%vn_sp vd=%vd_sp
 VNMLS_dp     ---- 1110 0.01 .... .... 1011 .0.0 .... \
              vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
+VNMLA_sp     ---- 1110 0.01 .... .... 1010 .1.0 .... \
+             vm=%vm_sp vn=%vn_sp vd=%vd_sp
+VNMLA_dp     ---- 1110 0.01 .... .... 1011 .1.0 .... \
+             vm=%vm_dp vn=%vn_dp vd=%vd_dp
-- 
2.20.1


