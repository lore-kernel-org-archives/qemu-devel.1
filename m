Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3EBC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 517FE2087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HPosPl9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517FE2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzpTA-0002QO-KI
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 17:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58563)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpLs-0001K2-IC
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpLr-00061h-C0
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:08 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42035)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpLr-00061E-6S
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:07 -0400
Received: by mail-pl1-x643.google.com with SMTP id y1so1577685plp.9
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YCIk/F5LxR+bAmsRyhfJi8qC+d9H6yIirq1I2qlCLZk=;
 b=HPosPl9eiczke+k7xDh+6kjHrl5v1F6hnfQ0nrkfjkzhdEOpEUZ4mHsd9wrxvDee47
 JrWRXIBNIhc9pJbttavZwxlvcXlP82JAfVCo7cZKEDYY6ld9rOwlJPOd+ASyYq/RZymh
 Ur+a64Kx1QVeAr3Ixl6IgfHxaqZ5/9U8IIEaNXHVf7Yr2AxHKMwU7URrbBtjHFLxEC5e
 QSmJ4PX7jeXRBxLXNX3mkyunxZDUMj2tYi824Qq+4OVvMa2ZVeV3DUMMyJUrcc8zaD3+
 TcPknfGtpJpxweiUofjme1LeXcBIW1izr8wBCY/yURt6RaoEgk04PZfauJvVkWhtvGi0
 nmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YCIk/F5LxR+bAmsRyhfJi8qC+d9H6yIirq1I2qlCLZk=;
 b=DBuSBYCu2mjPpchXJQ7u1q++p9MCG278GZxqYMsudV7orQkI6U8mYM5bp62geitYO6
 sNINBIKz4I+dDzeaRDhdYbmG2TxsfKikII8ivdgoH2gUTkJWzva8zF70N7fajtsBgq4d
 17ZA+p8UFnqAIkQJKh2HAq8oBLb52dO8Q+QmSJ2OzdsFnX6B3p4l/9ThfCEh3/Eu/kLs
 J8AhWpbpHAJJU4/8geTNji470kB5psIRm+yggHDEsZzhGpwRPDiHpECwlVcuIk0Lbet4
 9N4ZjFgmm5NyJ4gRt5gf/pFOU0NBGQG+YLFYTfLdLNoxg7FGr5+ZOqbfWXHfsPcDrunG
 kR7g==
X-Gm-Message-State: APjAAAXdbK1Elf62bUaGtqqSfvQa1rWvdB48l3NyfHbhbeJRPV8Su0sV
 s6h7Wm7TVQJVL2K5PjNsW1SvTXAoYr0=
X-Google-Smtp-Source: APXvYqw+AoDELrnbEdHvdOQnNpH61iX5df2z28Z5p9bhv68Po7LpmE3LDE9BofgYTs6TKjfdELTZXg==
X-Received: by 2002:a17:902:6b07:: with SMTP id
 o7mr24106899plk.180.1566250685895; 
 Mon, 19 Aug 2019 14:38:05 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:38:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:36:54 -0700
Message-Id: <20190819213755.26175-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v2 07/68] target/arm: Simplify UMAAL
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

Since all of the inputs and outputs are i32, dispense with
the intermediate promotion to i64 and use tcg_gen_mulu2_i32
and tcg_gen_add2_i32.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 94659086c0..82bd207799 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7324,21 +7324,6 @@ static void gen_storeq_reg(DisasContext *s, int rlow, int rhigh, TCGv_i64 val)
     store_reg(s, rhigh, tmp);
 }
 
-/* load a 32-bit value from a register and perform a 64-bit accumulate.  */
-static void gen_addq_lo(DisasContext *s, TCGv_i64 val, int rlow)
-{
-    TCGv_i64 tmp;
-    TCGv_i32 tmp2;
-
-    /* Load value and extend to 64 bits.  */
-    tmp = tcg_temp_new_i64();
-    tmp2 = load_reg(s, rlow);
-    tcg_gen_extu_i32_i64(tmp, tmp2);
-    tcg_temp_free_i32(tmp2);
-    tcg_gen_add_i64(val, val, tmp);
-    tcg_temp_free_i64(tmp);
-}
-
 /* load and add a 64-bit value from a register pair.  */
 static void gen_addq(DisasContext *s, TCGv_i64 val, int rlow, int rhigh)
 {
@@ -8090,8 +8075,7 @@ static bool trans_SMLAL(DisasContext *s, arg_SMLAL *a)
 
 static bool trans_UMAAL(DisasContext *s, arg_UMAAL *a)
 {
-    TCGv_i32 t0, t1;
-    TCGv_i64 t64;
+    TCGv_i32 t0, t1, t2, zero;
 
     if (s->thumb
         ? !arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)
@@ -8101,11 +8085,17 @@ static bool trans_UMAAL(DisasContext *s, arg_UMAAL *a)
 
     t0 = load_reg(s, a->rm);
     t1 = load_reg(s, a->rn);
-    t64 = gen_mulu_i64_i32(t0, t1);
-    gen_addq_lo(s, t64, a->ra);
-    gen_addq_lo(s, t64, a->rd);
-    gen_storeq_reg(s, a->ra, a->rd, t64);
-    tcg_temp_free_i64(t64);
+    tcg_gen_mulu2_i32(t0, t1, t0, t1);
+    zero = tcg_const_i32(0);
+    t2 = load_reg(s, a->ra);
+    tcg_gen_add2_i32(t0, t1, t0, t1, t2, zero);
+    tcg_temp_free_i32(t2);
+    t2 = load_reg(s, a->rd);
+    tcg_gen_add2_i32(t0, t1, t0, t1, t2, zero);
+    tcg_temp_free_i32(t2);
+    tcg_temp_free_i32(zero);
+    store_reg(s, a->ra, t0);
+    store_reg(s, a->rd, t1);
     return true;
 }
 
-- 
2.17.1


