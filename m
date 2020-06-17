Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0E4C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68CA620897
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bJZ9AnyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68CA620897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfoY-0006hu-LB
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEi-0004Ka-6p
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:45 -0400
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41]:36007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEd-0000Mp-Ek
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:43 -0400
Received: by mail-qv1-xf41.google.com with SMTP id x16so1776244qvr.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1b+dD7RxLqaUPVVNgXTFGKKstOqQ+qP/ZFHAKJHyCiE=;
 b=bJZ9AnyH38/u9FenAZJOw32x7nXAE3c11H3UA9e01D6LcFVkzh4ioqYu144nKCXVdF
 BxD+8cKCbFSDCU4yOxEWObt9rju8aW6aEX6X0gjikj3LhAjdtXr2iX9GFZKrQrJSZs1k
 r5oAMM8Q5RamzzyyeALQEzu5uzrcXmrgF/iPgE/jB8lixwmZOBIe8XnHlMnyj3XwSq5i
 PfaztLFruop8N0rCUpUgINYCWyGgxhXGkSO4zjaEuv3K+PXc276ZN4EFE9Qv7sOikx1V
 vx/6tOfp9M1+OnZGsjIwGBQRMeICZKZEcQ5o15sw8ncbFmRBuFk1FutnQoe2zAa/HhmF
 7AUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1b+dD7RxLqaUPVVNgXTFGKKstOqQ+qP/ZFHAKJHyCiE=;
 b=KaGzK9nqja7xYdxpSYkDIZ8hfc0oMHXfq+IvRZR6mj+b2stHDdgEmpUlHiOXsTs4Ov
 1vZw8Kf6JQL6vxqd4KvYKEzL0mFgAnHYNyJio+WLG5emGRe3Z4p9mVVl1WmeADW7CLTh
 yk0v1ogUBTyZ4HCBttFSkbRD6nVPsKHoJwIL2GCIpaR12oywd5wnoao1kLw2fqdcVBYx
 8OYHF7hdmAvQhmIQIVoWlA3qusrnd50PLM3FnrptTLC+Wk0z/toG6VlaUuX/mWQ2UdBR
 zdMzAHYfXbY6UCGY9qyzjVIBkev+VrOdD/T9rY0GQQDbe912UcgFr4cNmIOk/xQk1xYM
 fi+w==
X-Gm-Message-State: AOAM530NoBAi/atJ0vej/w2u0KFGGxOnOvSjR36o0sD+b2XRtXZMAHyA
 aQUDx5NlmetEpAMVq/h/3smUlseiAwfCPg==
X-Google-Smtp-Source: ABdhPJxNRVYp3AP7tFXV4bYbpzCc6IIWl4aKAMxqCHDz7BBBmEMED+n9+XyakEaFp6QPMpbpOI1oyg==
X-Received: by 2002:a05:6214:6b2:: with SMTP id
 s18mr523072qvz.135.1592427877097; 
 Wed, 17 Jun 2020 14:04:37 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:36 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 56/73] openrisc: convert to cpu_interrupt_request
Date: Wed, 17 Jun 2020 17:02:14 -0400
Message-Id: <20200617210231.4393-57-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f41;
 envelope-from=robert.foley@linaro.org; helo=mail-qv1-xf41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.puhov@linaro.org, Stafford Horne <shorne@gmail.com>, cota@braap.org,
 alex.bennee@linaro.org, robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Stafford Horne <shorne@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 hw/openrisc/cputimer.c | 2 +-
 target/openrisc/cpu.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/openrisc/cputimer.c b/hw/openrisc/cputimer.c
index 93268815d8..9475b77d0a 100644
--- a/hw/openrisc/cputimer.c
+++ b/hw/openrisc/cputimer.c
@@ -102,7 +102,7 @@ static void openrisc_timer_cb(void *opaque)
         CPUState *cs = CPU(cpu);
 
         cpu->env.ttmr |= TTMR_IP;
-        cs->interrupt_request |= CPU_INTERRUPT_TIMER;
+        cpu_interrupt_request_or(cs, CPU_INTERRUPT_TIMER);
     }
 
     switch (cpu->env.ttmr & TTMR_M) {
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 5528c0918f..fd2da39124 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -32,8 +32,8 @@ static void openrisc_cpu_set_pc(CPUState *cs, vaddr value)
 
 static bool openrisc_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & (CPU_INTERRUPT_HARD |
-                                    CPU_INTERRUPT_TIMER);
+    return cpu_interrupt_request(cs) & (CPU_INTERRUPT_HARD |
+                                        CPU_INTERRUPT_TIMER);
 }
 
 static void openrisc_disas_set_info(CPUState *cpu, disassemble_info *info)
-- 
2.17.1


