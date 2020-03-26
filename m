Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E26C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:43:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAF2D20714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V6m31ra/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF2D20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYPw-0000TL-Rq
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYK6-0006Jx-5C
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYK5-0001SB-3I
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:50 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:36775)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYK4-0001Ry-V0
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:49 -0400
Received: by mail-qt1-x844.google.com with SMTP id m33so6545086qtb.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wrWqzZuurKLoDMN6QCL6bZgCudK/zrEU5r5KFbp+gtw=;
 b=V6m31ra/vKo4TCES2Z1DbKUzapR/nVGPwZjNsvgkgOc3jp0Id5Yt4xNrvJIqjBXEke
 CIQoe14Tj1EpPl+prQMEqUtYlTddpPdGCMStJ4P65AA5W3ed0/4z6n1xfNXrSk2GsLCW
 Y+BoLTlETZy1NNKD4uhZlcAlZ1GfrwDbKt76KVRjOvbbwFAq3pKICFXMwelhV+t9b8Q4
 oU6moHikWlFwULb43qCV4qj0zypkroyEGzocLxkRRmJDNn8TAuo2/apnx26j6ZG0pwJG
 2iODJg1Si6F0RLTXind+iwFilEjl7uFId2zLg+EldCJJTYGAwbyzB7sylTdARqiBNtUv
 yulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wrWqzZuurKLoDMN6QCL6bZgCudK/zrEU5r5KFbp+gtw=;
 b=tOmSiBoIE2KBKJdQcgnSktNol1Os5Fggww4p14NRZAdPQ5rfPe1EI6o61EqcQwPO6t
 NCXTLdsmxaanCk0LR1zyqmhoSfF9csFEsx+wHYY0BAMYpVJ9pN5HdIRRYPWImKzI1YA0
 blgSoeoQxSUMcPtZIxNj7nWvQXk4ra1CUN1ON6ZduFgWfPb1RaJZGY5SeCKUfq6HJeA/
 6ZP1ktsFA4dd3cMCGWe/RAnjgODkWFoGXSLxGuN6LE3Wam4VqLrQ+4AmVJuMQ9Yw6LTu
 BQ6Y66VGVczZN37DZoel3Ykbve8Ox6SZJRNYx3vmUGTAs71/RNTp2FOfzS7lvFuUNId9
 k+IQ==
X-Gm-Message-State: ANhLgQ1suPaCMvzPSFhYtju4hTWDKPxhSC+oBjUW86NtvlqbkH1dZL+K
 CqbFqxtGJ6eJLfRkD/x5tiJeFBs+sDjNrQ==
X-Google-Smtp-Source: ADFU+vt58yfVOHgKewLGMCJN6kJ1QUQpfismxMHIyDnj81OQFR2PHQS1yo4sdoSPU9PbEzOZ45cNAw==
X-Received: by 2002:ac8:4e44:: with SMTP id e4mr10068176qtw.313.1585251467241; 
 Thu, 26 Mar 2020 12:37:47 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:37:46 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 11/74] hppa: convert to helper_cpu_halted_set
Date: Thu, 26 Mar 2020 15:30:53 -0400
Message-Id: <20200326193156.4322-12-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
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
Cc: richard.henderson@linaro.org, "Emilio G. Cota" <cota@braap.org>,
 alex.bennee@linaro.org, robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/hppa/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 52d7bea1ea..9c4d5b28b0 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2725,8 +2725,7 @@ static bool trans_or(DisasContext *ctx, arg_rrr_cf *a)
 
             /* Tell the qemu main loop to halt until this cpu has work.  */
             tmp = tcg_const_i32(1);
-            tcg_gen_st_i32(tmp, cpu_env, -offsetof(HPPACPU, env) +
-                                         offsetof(CPUState, halted));
+            gen_helper_cpu_halted_set(cpu_env, tmp);
             tcg_temp_free_i32(tmp);
             gen_excp_1(EXCP_HALTED);
             ctx->base.is_jmp = DISAS_NORETURN;
-- 
2.17.1


