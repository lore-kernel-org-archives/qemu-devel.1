Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896ECC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:44:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4899C206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cc2pcTAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4899C206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYQN-0001W9-Ev
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYK8-0006QL-IB
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYK7-0001TZ-Ga
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:52 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:43198)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYK7-0001TI-4h
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:51 -0400
Received: by mail-qk1-x743.google.com with SMTP id o10so8125700qki.10
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8O2wd0xMJ+DcB/CefCYufYGHDOjb2p67mBVobEDCvB4=;
 b=Cc2pcTAQPE/Ki6EFtkI0GW/uf8axCXccKlplmECMVLRW7453alOX6ZZL1095Zdf4hu
 29LKubWAFylftnO1O6RQ180ZJ9Nc3d8k24AZ0nT+Fp4tPL7y724Q+5aEQT47A+QoCJli
 Z8NwYZHumhZNh89SC6C6VV7rMrRMn+q1F2A0LCwOHGMOe13jmhLuctwzzuiZNo01X3na
 qLSDYykHPoyb4m4rbdPC2qzREKZpin6/ZV931BfYIgCN24F181SRkC7rLyABjtyJGG8P
 Xa9k1FQJ4uz69WHofmskbZuP0uB/qL2g91aqRdJu5HKh+nATG7ej7Rl4ib+p7Q7aUysw
 gqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8O2wd0xMJ+DcB/CefCYufYGHDOjb2p67mBVobEDCvB4=;
 b=lPxLIW5UtZrRF5WdrW+C/e0cuNS17amAz6eNjWEOXpUHIMhxN+/mexvnRBUUoq6OUZ
 nVGgShYjB6nRJpPQqKZAP2M/d/alwHjR/bu22hdOQ5/wdWfkKzq9C6ygRTS9r/wDxG7a
 5vxMzw947WltFIiThQCJDXw24hgg3pyfiLvYvQ9lpHOsFCKMkIBW9LuKcjs1Mj/gFFCY
 sGd1AYzQAD4M0PrpS3UbEO2dqItZzJD61Cthjw1OXeNXqlvCpEjGTbED5I/qPFB1mMgT
 7rG7MHh5KjC/VA7U+ATzJbcOjoBGlDcNhwO5XGbbvTMnD/8K8+0MDY+hpwxl586MnWj0
 Z3Xw==
X-Gm-Message-State: ANhLgQ0WzaM4UX90W/NnXUqDTmOuw/9G3DSfXtbIDaWHedG40K8WEldn
 jTLp+psPhUweuZUIsX+0LWjYTR9pWx5DTQ==
X-Google-Smtp-Source: ADFU+vvAR7Th51GevUbkly5uISJvbTJ4F+LAYDVNsjU9QD7mGHOK+h7tYKwVV/asUH5FWUD6Pd4yiQ==
X-Received: by 2002:a37:a4d6:: with SMTP id
 n205mr10320937qke.352.1585251469831; 
 Thu, 26 Mar 2020 12:37:49 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:37:49 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 13/74] alpha: convert to helper_cpu_halted_set
Date: Thu, 26 Mar 2020 15:30:55 -0400
Message-Id: <20200326193156.4322-14-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
 target/alpha/translate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 8870284f57..b1cd55e6ca 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -1226,8 +1226,7 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
             /* WTINT */
             {
                 TCGv_i32 tmp = tcg_const_i32(1);
-                tcg_gen_st_i32(tmp, cpu_env, -offsetof(AlphaCPU, env) +
-                                             offsetof(CPUState, halted));
+                gen_helper_cpu_halted_set(cpu_env, tmp);
                 tcg_temp_free_i32(tmp);
             }
             tcg_gen_movi_i64(ctx->ir[IR_V0], 0);
@@ -1381,8 +1380,7 @@ static DisasJumpType gen_mtpr(DisasContext *ctx, TCGv vb, int regno)
         /* WAIT */
         {
             TCGv_i32 tmp = tcg_const_i32(1);
-            tcg_gen_st_i32(tmp, cpu_env, -offsetof(AlphaCPU, env) +
-                                         offsetof(CPUState, halted));
+            gen_helper_cpu_halted_set(cpu_env, tmp);
             tcg_temp_free_i32(tmp);
         }
         return gen_excp(ctx, EXCP_HALTED, 0);
-- 
2.17.1


