Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C12CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:52:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A99D20738
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jvGgoa5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A99D20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboQY-0003a8-8e
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIJ-0002Y9-Ku
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:43 -0400
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e]:33325)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboII-0006Xi-MG
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:43 -0400
Received: by mail-qv1-xf2e.google.com with SMTP id er16so3384918qvb.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B03XAH5wL6d9wQMcetAjOEJJOmedJjFZih4s04YDqvs=;
 b=jvGgoa5JZt5CVicHbc16hTgS5Fn5N/TMorjKWHm/EtJ0QfGc1Qd1Dg4L2xIVoTXL4M
 sv47rnUIQPB8R1OnFOpYz06yhZMr89bfS0cNGrNBq18RChGMckFReojim/2Cz1ftBvVv
 DnopBTJx1HbEJiTmabP2gOyYgBkMsVfrDrLW/iazS2hsMNzVaNtwttYQbqbzrwM3a13W
 C3UOfrAoiVszrbk4NgfhstQ/y0hnUilj3M5W8h5BmMVArhh9KPcmBYJSe6z0gi6GkJGb
 MIsQeNvpoqaGMp5GVagE4J9S8t5g1WdyqjVvLAbGtLzoOcwWdtXeFnbJpPmuaZYUhM60
 uD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B03XAH5wL6d9wQMcetAjOEJJOmedJjFZih4s04YDqvs=;
 b=Br14/sRPpV2JvDPEeWfCUHZlvAoQF28dKBnwBTqiH9bta3Ng0ITH8C0F8ziM4Thhrp
 cdFR4e7JH402iEJxPlYJhmQATJ+Pd6dVCKky+WCYax4Rp//ZHSHKxqmB3d8wdTvlLJ/7
 QnrORZdXYt0akax7HqMJ5xn68aZXB6hqNWoiIruQFMyAOK4O4oTi6EaR0edm3s7RhZ8D
 mNKu7FP90KBazRBs3fNT7t3tpHh7vEkH4TUNdenpAEQED7AukJ0dOchLmTlusQ6U0UKM
 NmvFL0L32h4n8/mLFUJyqRmkwGTl8R/R5LJpf22R5XyDlkg74xsv0UaqqM7gxkJJNoIv
 XGdw==
X-Gm-Message-State: AOAM533gJ6XMXWsC2/nNHHjY8+mVEEDbH2Ypqn7L+2gUxiuzjlFwdAc5
 XXB1ox7UDJD1atlDP2VYz3BiBYypESZoKQ==
X-Google-Smtp-Source: ABdhPJwauUADvarZIupVpII3EkKwJC6Hl/hp6lE3oS72bnfRn432rctRTAmqR0J6vsXwYWLg269Frg==
X-Received: by 2002:ad4:5290:: with SMTP id v16mr11065935qvr.240.1590079421433; 
 Thu, 21 May 2020 09:43:41 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:43:40 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 20/74] sh4: convert to cpu_halted
Date: Thu, 21 May 2020 12:39:17 -0400
Message-Id: <20200521164011.638-21-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=robert.foley@linaro.org; helo=mail-qv1-xf2e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org, cota@braap.org,
 peter.puhov@linaro.org, alex.bennee@linaro.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/sh4/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 14c3db0f48..d338bbe871 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -90,7 +90,7 @@ void helper_sleep(CPUSH4State *env)
 {
     CPUState *cs = env_cpu(env);
 
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     env->in_sleep = 1;
     raise_exception(env, EXCP_HLT, 0);
 }
-- 
2.17.1


