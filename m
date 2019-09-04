Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C06C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:41:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB1D1208E4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tlkXgdWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1D1208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5b9M-0005Eh-Vf
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 15:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5azs-0004Gm-VH
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5azr-0002Cr-CJ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:16 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44632)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5azr-0002CE-0D
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:15 -0400
Received: by mail-pl1-x642.google.com with SMTP id k1so2684442pls.11
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=l0Gtdyo5nMKKRI4uQ/+uyb9G9cj8p6HrKAyS4O+r2fs=;
 b=tlkXgdWIQHefx+VpksUhUtq3Z52JJCeLbdGikVTjX5c61VCUvgzBJG01Dg8rDhMBXi
 dIAKwe8xmTGmmoXp3Z+wSs5zQMr+jTcVzIxZVoJDWbk+Y/bcZkNPCoSuXdZuLpIhpoMG
 77QfhTcWKchL2GzhPnVj8q7CyZ18Waks9aJm5wX5/WO72+FtXZfmvZGnP9R7XLT9A959
 CB4F66lNs1q+vR9IysQ2qluoTNzh7Qe14Sp2xrrXiULHgY9ZY+IlZB2EHa6by/UeUJve
 ApvKwWPCDzIFII9FZrYWk5wGIv6Ppcay2hItvsUKbu55Y1MF5ilUV5SHjlAr7nkSXWAq
 4wPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=l0Gtdyo5nMKKRI4uQ/+uyb9G9cj8p6HrKAyS4O+r2fs=;
 b=Ib1cReoN1OZf5MlwLV7b8NFtcze6gF7spQD2vdoI4A7gBro0p0j8Ooa/WrJqzzpukj
 1qE0nKVYBkABMHgQNmYv2ZxrtnFTRa2/UrORRJG8gH7JcbEHP/F8OEKJtVjyRSoo2D0R
 2LKg2cjOUQtOo11Zt13Z+U0R6V/fOAhykUF3ha6e2q/DXlV+hW1JLNLKsrHzAbnJwCc6
 D7XbvgGsMo3hz2DzeQ0bcvAip905hwztMLPAllw6/ejXBUOjtkyF4hBUefgu7kXE+rwX
 QA8fZDpb1WQAvWGN4riUuqAena/x84PsZP+h4iHoU9cmZhPfeMrAYD7FLhRTI8EpY65f
 yddQ==
X-Gm-Message-State: APjAAAUx9XNvNU7HnElp0n9XmeraEDUth6ocuixOZbRv4y8BReMlcAua
 zIbXGvPosuVi9EpACsNUADvIiCtGnDo=
X-Google-Smtp-Source: APXvYqxyP0Trnwe+z9o/h9RBWTB1KnuiaZyQkws/igSTHRoHy3G+8g9HD0VYY7I07SnKMQbKwz304Q==
X-Received: by 2002:a17:902:4581:: with SMTP id
 n1mr43263035pld.310.1567625473716; 
 Wed, 04 Sep 2019 12:31:13 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:00 -0700
Message-Id: <20190904193059.26202-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v4 10/69] target/arm: Simplify op_smlaxxx for
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 5306e93470..37aa873e25 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8177,8 +8177,7 @@ DO_QADDSUB(QDSUB, false, true)
 static bool op_smlaxxx(DisasContext *s, arg_rrrr *a,
                        int add_long, bool nt, bool mt)
 {
-    TCGv_i32 t0, t1;
-    TCGv_i64 t64;
+    TCGv_i32 t0, t1, tl, th;
 
     if (s->thumb
         ? !arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)
@@ -8202,12 +8201,14 @@ static bool op_smlaxxx(DisasContext *s, arg_rrrr *a,
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


