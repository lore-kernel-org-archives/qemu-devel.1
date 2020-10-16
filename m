Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB57C43457
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 18:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 715CD20725
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 18:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X3da8qp9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715CD20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTUjz-0003Ur-Ef
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 14:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTUgM-0000UF-55
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 14:42:27 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:43122)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTUgA-000251-Uk
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 14:42:24 -0400
Received: by mail-pf1-x443.google.com with SMTP id a200so1976452pfa.10
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 11:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zVLgn+OX/nTD/oUAFauTpXTtA86xiUG6+rSs26rONZM=;
 b=X3da8qp97zHh18bfs//PjWRI7eoJKP8qXb0hu58E3tvMElVxzcK3VZXcftBvUJWUZT
 Zai2wqepNHmk1CYOF5UTMOKYyz4PA4wSzIWCo730xtyFo0jlab8MxR+hEHylDunD8T+/
 8a9sE6vx+TRM2aE/piEXv8PGGaGtqFSOSajShCv9vLqHwga2QjVNwYLQl37WVDi/AlEs
 2E25smK9Gelcbp0eKbc/yebt6xzGMSAFXKFHDa6JkKaXelqKYxbtckbQDC9VObKscCkt
 3M8sa0V2vmrsbIpvz+FD8HbVeCxO3dT6aHFWZrcaCdUoPwMGwyVekz6qPevPYNGK/rbr
 sTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zVLgn+OX/nTD/oUAFauTpXTtA86xiUG6+rSs26rONZM=;
 b=UL9/zSo+S6WixMqUoQYZk3tqA5qkvWeiJjKt35i6xGoPibZdRfi7lYHv1eH0PH0RuT
 sZZ7GfqKsFD2E26a2933SXjDMluxT5g3nHOSsM4o2Gz2lpAvoVpsgCl8mQzwcAH910sw
 Nd7LyGRkBr9Mybo1ZDLyMwN3hkRr69Ra2n0ort7KH47D7NVlTVDo0r5wqUD/LxlXX57O
 10qxcZAYQOf5LYf4Miw6r4yAbUF0tJMkfNByQpYRUTz8x0HdJVTpF/4jMqcsNvmXKaJx
 s2RmzQGpeCtj5Urx1b4nffWS+/5K5PW3rCF9cSOx0hJKx5l1iKjx4dM4LryAMeg7XRFb
 UDcg==
X-Gm-Message-State: AOAM530jNO7XecnKghIKQvtDucAApuVpagneJrcr2SVEsUnXogxuqkFF
 BztLTMuTxK6abzu2ncsx+pJ95XfJRW7+5A==
X-Google-Smtp-Source: ABdhPJyNq7fQaW86kRVsgO2N4V68S3cs6eqwd5iqB4LY7We4DRd3XSUVc72nxVezT5wMoWiFIC74Og==
X-Received: by 2002:a62:5b81:0:b029:156:2dce:5aa with SMTP id
 p123-20020a625b810000b02901562dce05aamr4938299pfb.15.1602873732189; 
 Fri, 16 Oct 2020 11:42:12 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id c15sm3426011pgg.77.2020.10.16.11.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 11:42:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 01/12] linux-user/aarch64: Reset btype for signals
Date: Fri, 16 Oct 2020 11:41:56 -0700
Message-Id: <20201016184207.786698-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201016184207.786698-1-richard.henderson@linaro.org>
References: <20201016184207.786698-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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


