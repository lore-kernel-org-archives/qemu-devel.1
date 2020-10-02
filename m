Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D182C35257
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 22:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF58720719
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 22:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mZf3ei3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF58720719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOT8V-0004pf-IQ
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 18:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOT5v-0002Ud-Ik
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 18:00:03 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:43183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOT5s-0007Lv-Ks
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 18:00:03 -0400
Received: by mail-oo1-xc41.google.com with SMTP id w25so734987oos.10
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 15:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zVLgn+OX/nTD/oUAFauTpXTtA86xiUG6+rSs26rONZM=;
 b=mZf3ei3K0SiIqpW+c5uWCNbm2ueVTT5/vAmHbsu2rR/KjUJHZrOXhkwRax/5I7x3oP
 2Dl9Sq4f1iRROEp8QgfSJRu/U4uv8opg6mRo3zyQEmOhbwMDys6EQ8Ev28eQ/uxCBu0x
 mRjvNGcUgDhRh3e9Fs7J8NaS49+rPfrnWw5DKG19+vLajb+4aOX5SVOLjXLOhbJI++kJ
 V8G6AlBwsILhn3kLOe8ozGtt/3WYwcsjvtleVvnGiKiLNp3nRNcx4V9teyKyHPu/AHhO
 egLqObZdC0c1DJU+oQVQa59HqvYOisS2HkT2AvOb1zjZRHQvPliP57PLHkAF1gZTK0R8
 maZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zVLgn+OX/nTD/oUAFauTpXTtA86xiUG6+rSs26rONZM=;
 b=ORwW6NKJtkcvNRg75osZkFJLGKn244V6xVOH9BtTN8h9wCv/vcjTFiJVP4V4KRBFxE
 gd+BI6qcfyYA4rFQaI7IZ5PQxsafGq3BHNWdPRH/qufnCfk73iHAhM7aR2BORwvwhRYx
 TjAPaeZ8iJY4RGm/pKhrcg+jhS6OTJn7ggCZfz2QCuBKxBAVqg6vXTrq+eFNGBagDB/f
 12RUDau5SsVnWvA4uO/+adZyIe/2t1W15ZxwWKH+w4wREbl6/moRxPg+tuPGpyaMIZlx
 sPHpL5bDnRy4KvOBH9Lo5CwKzjYvdVWvZHasHkr7hydyU6ndDyRb/DOfoTazNcHYBlT3
 N5ow==
X-Gm-Message-State: AOAM5324g8F9zii25jXUW1A0Bozii/wi5PV9weSFe1M0st2cTF6s3tt1
 quBEPIoXqaWf7CvXz3uZOi7OSmx5xjy49cUk
X-Google-Smtp-Source: ABdhPJxJAFr0JUaS6cov/1LQ671Bk+7vDG2Ga/BMZ0JmrVqdOhTUGXlMYCYdV/jZkdtiFba6kZf34Q==
X-Received: by 2002:a4a:b40a:: with SMTP id y10mr3402836oon.71.1601675999237; 
 Fri, 02 Oct 2020 14:59:59 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id k10sm684268ots.60.2020.10.02.14.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 14:59:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 1/8] linux-user/aarch64: Reset btype for signals
Date: Fri,  2 Oct 2020 16:59:48 -0500
Message-Id: <20201002215955.254866-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201002215955.254866-1-richard.henderson@linaro.org>
References: <20201002215955.254866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The kernel sets btype for the signal handler as if for a call.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/signal.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index d50c1ae583..b591790c22 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -506,10 +506,16 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
             + offsetof(struct target_rt_frame_record, tramp);
     }
     env->xregs[0] = usig;
-    env->xregs[31] = frame_addr;
     env->xregs[29] = frame_addr + fr_ofs;
-    env->pc = ka->_sa_handler;
     env->xregs[30] = return_addr;
+    env->xregs[31] = frame_addr;
+    env->pc = ka->_sa_handler;
+
+    /* Invoke the signal handler as if by indirect call.  */
+    if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
+        env->btype = 2;
+    }
+
     if (info) {
         tswap_siginfo(&frame->info, info);
         env->xregs[1] = frame_addr + offsetof(struct target_rt_sigframe, info);
-- 
2.25.1


