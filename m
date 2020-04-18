Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FD5C54F70
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 15:58:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF148221F7
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 15:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LHcXxhgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF148221F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPpr8-0008MX-QC
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 11:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jPppz-0006wk-IZ
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 11:57:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jPppy-0002kN-AZ
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 11:56:59 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41575)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jPppy-0002iy-57
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 11:56:58 -0400
Received: by mail-pl1-x642.google.com with SMTP id d24so2191432pll.8
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2020 08:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7uX8ThqikoEq018tD9k93q1ZZz6mGC+ypRxdEu5/0Vw=;
 b=LHcXxhgYH8NUJ32OqE1+8L5xl0iipBPoiI1xa0YRy0pH1jm6NAkOc7oaVccIVeOy3g
 T/F7+wIYib6zNYSm5gebCftgMbwR0CO+WqT5y6Ihe94VFe4KW7T2TSxyvvvRpSBMBJvi
 1Bi031xX1jFptSs2i/zmLZzqEWe1pftpO1AgrHDdtbIg4A8b2go7f8JA/utmrKFpKOV0
 BPSL4kLzLxG2JYuwLxpt5Wdoxa6Fp6/38c898k58rVcE1QOy55+v5l9WFVFUnEm5fuD8
 cBfwjdV9xId0Zq2olmCJwVyb/Cq8CcJEiPr9Uecr+3UApJQMR2L0WrWhEIrYs75MdjNH
 zxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7uX8ThqikoEq018tD9k93q1ZZz6mGC+ypRxdEu5/0Vw=;
 b=qXf92rVBILiMmldNmEy/gzISoFbfXF+5tX32cRjmqqtbndVCubfx5gQrC5s0oPMap3
 gqYv1Z4upDLBtV7+6TVj0H9jCKZQ5W+23UkhqWf7ye4LMY7ET9MEvGI3o9IsfZ5ois3p
 is38ouSA/EKqiuMPNnwcagYczn5yE90o3SHYitllo6osRPUhNsAamqJp5H20cyx1v2gd
 F//Z9A1YoYtWmpOmquWjFwsO7aIf1PgXunvK8Jks11cvo/LclluKHaf9/MRBPGi+AHLp
 nU0RLmrJWXKuAIT59bOrV7Fxr0SxqOdX9ecAw0iSaScJ7AfiMpwn0yyEq/f2MpqYCvBG
 D86g==
X-Gm-Message-State: AGi0PuYan1BHP1+AvPupjqVsNk2aCuH69pKPSrsIB65zPklzlUs+9CdN
 OlYueQu+O0saGC4UOjnBRAIOwsLnmdw=
X-Google-Smtp-Source: APiQypInsW1j8bdviOTcpHgkM9TbZW04QcFv9JYn8hnkpQGzfK5Qecb4gC5kqT6eMOzlPVUatZRLpQ==
X-Received: by 2002:a17:90a:fb4e:: with SMTP id
 iq14mr11022943pjb.146.1587225416810; 
 Sat, 18 Apr 2020 08:56:56 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m189sm13928532pfm.60.2020.04.18.08.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2020 08:56:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] target/arm: Use tcg_gen_gvec_mov for clear_vec_high
Date: Sat, 18 Apr 2020 08:56:50 -0700
Message-Id: <20200418155651.3901-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418155651.3901-1-richard.henderson@linaro.org>
References: <20200418155651.3901-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 8-byte store for the end a !is_q operation can be
merged with the other stores.  Use a no-op vector move
to trigger the expand_clr portion of tcg_gen_gvec_mov.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 095638e09a..d57aa54d6a 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -513,14 +513,8 @@ static void clear_vec_high(DisasContext *s, bool is_q, int rd)
     unsigned ofs = fp_reg_offset(s, rd, MO_64);
     unsigned vsz = vec_full_reg_size(s);
 
-    if (!is_q) {
-        TCGv_i64 tcg_zero = tcg_const_i64(0);
-        tcg_gen_st_i64(tcg_zero, cpu_env, ofs + 8);
-        tcg_temp_free_i64(tcg_zero);
-    }
-    if (vsz > 16) {
-        tcg_gen_gvec_dup_imm(MO_64, ofs + 16, vsz - 16, vsz - 16, 0);
-    }
+    /* Nop move, with side effect of clearing the tail. */
+    tcg_gen_gvec_mov(MO_64, ofs, ofs, is_q ? 16 : 8, vsz);
 }
 
 void write_fp_dreg(DisasContext *s, int reg, TCGv_i64 v)
-- 
2.20.1


