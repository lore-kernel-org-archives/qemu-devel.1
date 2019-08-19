Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8792C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:48:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B41A22087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YZ0YyngK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B41A22087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzpVn-0004v9-UI
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 17:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpLx-0001SK-Gi
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpLw-00065V-G1
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:13 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44256)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpLw-00064r-AQ
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:12 -0400
Received: by mail-pl1-x644.google.com with SMTP id t14so1574161plr.11
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=z6bTZIJUuD2Rb2udZZO8tN325lpohcam+cQYkXY7q0k=;
 b=YZ0YyngK2P7R9z4uAceUFNeutCFwqq8i7vHldiAteQsa2asCHVcg48IqB0ep869q68
 WLkmJMH3d9AIM/6t3LdqVsLoNan6DkrZ5bP5w0oWMU9dNJPzn0NceZRiJkn4fA0W7t9O
 VqGnq6tJFsJS8yAZTutn/9id0o2UvV7gLg5w24eEoXo/Jaw2B3RUlETz/b3mgkiUIkxg
 Pv5V2nc0CJZfig4FPjVa19zF7nxIaNayil+c2ucKqFf2SsqmklGyNSqj/u31Vw2DtjFt
 /YBMIXkSMJbhGIqqXP9cCMh7cdqcTG+K4swU2m2hb3JeyKUGvsFG18f0v96DbKCu8d0d
 DOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=z6bTZIJUuD2Rb2udZZO8tN325lpohcam+cQYkXY7q0k=;
 b=pAdooXmFRoVzrJPCPA4k2IPzRX/os6veXer/mlCrVKRe1o0trvFtAZ5Ko3+rq5G1De
 hpdpfCdGsi7A+7T0oGg3A9LqNcInL8yC87sNIvSgubxgbCz9DaEqprUyKvbZMfzyOAwe
 rN2hD2uV596eeGCOhZ5EYJRy97sM65BdLGyV7Hl383WeXnRt8UzW2SXQHbkR/pcP4RLO
 6EUWxWB3fnMw4NNqhlEa3UHETf3ZWzx9MZaj7Hjtc/HRtIgGrPes9KWB/t7ZVZiIkSYW
 CgIHY7cgyLwDAvDQ2/6UIR3A3a1p09a/tbWfj8G19uIjI8mO9RGx6DA7gkrxzUiv1IGS
 ckzA==
X-Gm-Message-State: APjAAAVGxeiyUXgQyOcdiqRRQHxh57ivTWK/BRBzNCx7NgbyVh2Q4XzU
 B6Vj3dttotHbezY4P6W7bp0qAd2Zw/A=
X-Google-Smtp-Source: APXvYqyTYPGYlGAlcPRyoPxB0CQOmFFZxh4s4C8Ae2V3wGwXug6GCI5bSU+JZSCR1Ghwu10OTGhz0w==
X-Received: by 2002:a17:902:3003:: with SMTP id
 u3mr10413251plb.161.1566250691131; 
 Mon, 19 Aug 2019 14:38:11 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:38:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:36:58 -0700
Message-Id: <20190819213755.26175-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v2 11/68] target/arm: Simplify op_smlawx for
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 8557ef831f..9a2fb7d3aa 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8213,7 +8213,6 @@ DO_SMLAX(SMLALTT, 2, 1, 1)
 static bool op_smlawx(DisasContext *s, arg_rrrr *a, bool add, bool mt)
 {
     TCGv_i32 t0, t1;
-    TCGv_i64 t64;
 
     if (!ENABLE_ARCH_5TE) {
         return false;
@@ -8221,16 +8220,17 @@ static bool op_smlawx(DisasContext *s, arg_rrrr *a, bool add, bool mt)
 
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


