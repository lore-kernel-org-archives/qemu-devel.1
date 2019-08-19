Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC96C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:43:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98AB02087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uE9+yCU0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98AB02087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzpQg-0007vO-Fl
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 17:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpLw-0001QC-5Q
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpLv-00064N-4t
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:12 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34695)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpLu-000641-W3
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:11 -0400
Received: by mail-pg1-x542.google.com with SMTP id n9so1937730pgc.1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UWYlG2k/Brng2tcRnik0JT0fnjwpLVOKsVAvc3Cf6uM=;
 b=uE9+yCU0T6Ao9JMkI8KrbQfhfd2p5ajqTi+mS0jkyNzaOKbM+TKA8AtOCL4pC6F/Yv
 /CbiLFEEQlrYbNj5U1s5YbgpvtZ/sTezNqAKO2PPBRgNUzBaZYD+lEybrcTMWGSRW/CF
 Nft3it02B853GxhnR4bWQ7LtIXYLQjEdkzRWYFWJWx8QK3sYo6TOMgbYyS6P5ROs7Fs1
 qnXtAy/D+c1AztrlLgdyBeFHDG08pyGCZ+hQE+TyiYXF7yta4U9WAU33L9p/hhzELN2a
 DRgFMwT+xQSG/dKxX1X540+PtLcdldj5NPQZ9vVs2l1J+8zEURAZhLxvjHOw0pRnILGo
 PXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=UWYlG2k/Brng2tcRnik0JT0fnjwpLVOKsVAvc3Cf6uM=;
 b=bgs35LoFgSqOR9tKKjL2wiLapLd+lDtSgUk92D+6VvRHjhSNuHEWz3OfzrU19CwXZP
 NqwBDaDmwM0h/YhmekiLK4q1tBf7nxd0GVFy2K+Du1Pf3pE/vaxKzf9Ve6hSVaQtsx/P
 xVZe6y4ziVu6nx0PRXjDM4nhC4B7hnM22wclN+/HAzZKOV2jX5+ef/N+1YsXuf54aGFY
 T+d9f1qCsyNdJQ5CApKlpXWUivbbNxxpxYkijTkasf0LT/LxVCWQRwYXvi1RiEnpxrDi
 cqsnWGqf5/TCAvmgq9kW4RLlr2/vVVlZVNLNrFPzBG3pdTYEna8qaDpP5kElodOnkXbB
 4ATg==
X-Gm-Message-State: APjAAAWtef8QGbH+u+DvCWEA+TmuBm43BEi5d0q3Z3DaVc0GlPEXQVkq
 DFbMlSUEwkATnkvL4PJ8NE+nSlswbH4=
X-Google-Smtp-Source: APXvYqyzON00wVk0yJxiZEVkc0bKErpX5uOCMiINKu7c6SBBYMNH5j8wPhYJo31NKuCs5KaqgrpPCQ==
X-Received: by 2002:a62:584:: with SMTP id 126mr26621954pff.73.1566250689777; 
 Mon, 19 Aug 2019 14:38:09 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:38:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:36:57 -0700
Message-Id: <20190819213755.26175-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v2 10/68] target/arm: Simplify op_smlaxxx for
 SMLAL*
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
the intermediate promotion to i64 and use tcg_gen_add2_i32.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 56ae83a7d0..8557ef831f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8148,8 +8148,7 @@ DO_QADDSUB(QDSUB, false, true)
 static bool op_smlaxxx(DisasContext *s, arg_rrrr *a,
                        int add_long, bool nt, bool mt)
 {
-    TCGv_i32 t0, t1;
-    TCGv_i64 t64;
+    TCGv_i32 t0, t1, tl, th;
 
     if (s->thumb
         ? !arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)
@@ -8173,12 +8172,14 @@ static bool op_smlaxxx(DisasContext *s, arg_rrrr *a,
         store_reg(s, a->rd, t0);
         break;
     case 2:
-        t64 = tcg_temp_new_i64();
-        tcg_gen_ext_i32_i64(t64, t0);
+        tl = load_reg(s, a->ra);
+        th = load_reg(s, a->rd);
+        t1 = tcg_const_i32(0);
+        tcg_gen_add2_i32(tl, th, tl, th, t0, t1);
         tcg_temp_free_i32(t0);
-        gen_addq(s, t64, a->ra, a->rd);
-        gen_storeq_reg(s, a->ra, a->rd, t64);
-        tcg_temp_free_i64(t64);
+        tcg_temp_free_i32(t1);
+        store_reg(s, a->ra, tl);
+        store_reg(s, a->rd, th);
         break;
     default:
         g_assert_not_reached();
-- 
2.17.1


