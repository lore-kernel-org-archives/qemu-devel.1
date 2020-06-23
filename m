Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9968CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:11:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 647F521473
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M76zOh8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647F521473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnpGY-0003By-NI
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 16:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnok5-0005HH-UH
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:38:01 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37284)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnok1-0005vK-Af
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:38:01 -0400
Received: by mail-pg1-x544.google.com with SMTP id d4so24314pgk.4
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 12:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JXq//EY41qOxgUUn2iV4AqQzVXGmUlIHXAR8u9hZfo0=;
 b=M76zOh8g1nzD8ykE8027goebeYeai4bA649NaA4G1gHsa5r6jQnT/WM7LW61AJDkfn
 YekIAyfY5N0U9+9p5gN4MUSqLF1HcpL0afenT+VCJJJWRLV8xVEzgN2GMm95zIRd/jcf
 X+MwVMQxBUihJAO7k0G/twbFiyNzZlY1Qhs8l1Y/AyAD6zApEk9Yo8QFqPIagK3zvxkO
 +wAs9tcjkq7cLV+QoCYtX2+IRuesQ2NRRuN0DI5xlqdZXvu0HCZ5yxlILOgUjrNEj8+u
 yoXpCQTkFMXnO6HEZMxFvLTiqRW8SbT+C5jWWULW13sP7krMCBUwERtNO1RJFcn+Rn1V
 GLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JXq//EY41qOxgUUn2iV4AqQzVXGmUlIHXAR8u9hZfo0=;
 b=Rumr9ylKIlQqoNVmD3YzJpwC2KEY+D8V5juIdIaQryN/JUfJrKMQ2jzjvj/Wy8oGLi
 RddTMYRXt8kwyVBDeDVqJeJDcxkg2uwk37qVHcNjx8wNYEGR+CoC4Ags5xKEvL8vET1q
 T5mz9CUTTet0m8OA7BMlQsvHdrjUVQUS5DrN1c+tvpkz6i1iWvwLdjZ7jtr+U0SDaarK
 XQQcy5EvQwtjT1khHwAwMx6baXF6aAdVa6Y/ph1HmLjBIkNsIuIdXUhpCfTFwUwUO8zH
 W5jn5snCPREW1edqhrJjPKVOAbmK7GKmgWfcbhjl2NFsWM+Sf5WGftHfg4B/AacAQ/sg
 BcnA==
X-Gm-Message-State: AOAM531yiLVbYwiXngvY28EClJ/RfCWe+kBWE5HbyQVus0sCTLbyCUHv
 o+/3h5om1EwWilWDJdq8/D9/xSpeYJQ=
X-Google-Smtp-Source: ABdhPJzitqWLBJRr/BvaqbgErSRzlsWsskqdWcj1IBjxcIPQgp9oOBFllMsF0C1dHOAi0W+6VUIZ/A==
X-Received: by 2002:a63:b915:: with SMTP id z21mr19384826pge.145.1592941075565; 
 Tue, 23 Jun 2020 12:37:55 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p12sm17927642pfq.69.2020.06.23.12.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 12:37:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 40/45] target/arm: Set PSTATE.TCO on exception entry
Date: Tue, 23 Jun 2020 12:36:53 -0700
Message-Id: <20200623193658.623279-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623193658.623279-1-richard.henderson@linaro.org>
References: <20200623193658.623279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

D1.10 specifies that exception handlers begin with tag checks overridden.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Only set if MTE feature present.
---
 target/arm/helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 23cf44fcf4..d220612a20 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9704,6 +9704,9 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
             break;
         }
     }
+    if (cpu_isar_feature(aa64_mte, cpu)) {
+        new_mode |= PSTATE_TCO;
+    }
 
     pstate_write(env, PSTATE_DAIF | new_mode);
     env->aarch64 = 1;
-- 
2.25.1


