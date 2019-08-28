Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909EBC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D08B214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="feOtS/Zq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D08B214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i33TP-0007Tr-KS
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Ft-00039r-6R
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Fr-0008KI-CO
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:16 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39426)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33Fr-0008JT-1G
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:15 -0400
Received: by mail-pf1-x444.google.com with SMTP id y200so389279pfb.6
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XK0pfbS5nVG6fwyWU5L/Wqmb0aEonSQXz/8cuqg+DQA=;
 b=feOtS/ZqFlgBkJZ5pdTynYGbMfBpLK0CfrWpuWVF9HIw+VTK/yoKK9RpuibcvLQqx3
 q5OUGEyPoH0zjc4pJQa/otLTy951BOV5GVXbq/8iMZ/aS/ad7L6/U+yvTr0IzbXpKHJh
 vgP1DgHnYRmb+bMyY9763H/UCKW0jKTx4IHRmeYRIZg7i1fBnpC9lj2+fywG19R/MJP8
 g96AMqPv6oM6gTcXiLkIZjaDS6up0+EpDLWakz+XauTQ1nOSzRQPZ1XmuHGXhobFkgNp
 b7mzL3VgbLHQ0aMzkCH1aQorwt4fJ5pJTgLT3utQlC0JaKyzSQRenRhNsMAQqlySOGKB
 /gtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XK0pfbS5nVG6fwyWU5L/Wqmb0aEonSQXz/8cuqg+DQA=;
 b=cynBdTFrgoA18F/RbUSIfg6ZxYGhoPMyCy971FRpmu8vscwX1Y7zSphXIlVXFwMcd7
 ULID881FQSFCAQYZoO2+D+Xdl3hFIW7X7AhBYo3P8oG/LMys9elCPJD56TJ4UtPf+nMu
 SF6Fb8t35TtYcwfzJp2KQGnSGQusAfjLACUL1Fn/S/lTbgkN/yY2XfH47vQxXuWWT4Ch
 +z8H4EEXTBVfFN4Gpwy2ztAIKLy1jipy9+CRhJ4WRemOOFV+aHhwhpE11RpkspaCW3Kn
 3YsIkB7tkC9YQcxQBROGz5/CDVATFJoQNHDxDORBdPitStk+BGsKyhoYDT/ts2HUpR3M
 JL3w==
X-Gm-Message-State: APjAAAXNasw7Fcpg2WvfSqGuIiDTfHhfOXAc5kaUfzzDZxd26C6AlWQr
 55pV8BFMjpBzunwpaPIrxHiumMY6Nng=
X-Google-Smtp-Source: APXvYqw6sI8uYpfFUoGwZx1M6jOJNvEIE5BAY3VhloQC5D0dzVats6JLgjLFm0Zk1UXE0xn5QXUXjg==
X-Received: by 2002:a63:607:: with SMTP id 7mr4768185pgg.240.1567019113050;
 Wed, 28 Aug 2019 12:05:13 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:05:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:03:58 -0700
Message-Id: <20190828190456.30315-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v3 11/69] target/arm: Simplify op_smlawx for
 SMLAW*
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By shifting the 16-bit input left by 16, we can align the desired
portion of the 48-bit product and use tcg_gen_muls2_i32.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 8813d40a2c..fad07499d2 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8216,7 +8216,6 @@ DO_SMLAX(SMLALTT, 2, 1, 1)
 static bool op_smlawx(DisasContext *s, arg_rrrr *a, bool add, bool mt)
 {
     TCGv_i32 t0, t1;
-    TCGv_i64 t64;
 
     if (!ENABLE_ARCH_5TE) {
         return false;
@@ -8224,16 +8223,17 @@ static bool op_smlawx(DisasContext *s, arg_rrrr *a, bool add, bool mt)
 
     t0 = load_reg(s, a->rn);
     t1 = load_reg(s, a->rm);
+    /*
+     * Since the nominal result is product<47:16>, shift the 16-bit
+     * input up by 16 bits, so that the result is at product<63:32>.
+     */
     if (mt) {
-        tcg_gen_sari_i32(t1, t1, 16);
+        tcg_gen_andi_i32(t1, t1, 0xffff0000);
     } else {
-        gen_sxth(t1);
+        tcg_gen_shli_i32(t1, t1, 16);
     }
-    t64 = gen_muls_i64_i32(t0, t1);
-    tcg_gen_shri_i64(t64, t64, 16);
-    t1 = tcg_temp_new_i32();
-    tcg_gen_extrl_i64_i32(t1, t64);
-    tcg_temp_free_i64(t64);
+    tcg_gen_muls2_i32(t0, t1, t0, t1);
+    tcg_temp_free_i32(t0);
     if (add) {
         t0 = load_reg(s, a->ra);
         gen_helper_add_setq(t1, cpu_env, t1, t0);
-- 
2.17.1


