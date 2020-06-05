Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B21C433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:22:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0539B207D3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O4UYiAV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0539B207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh3sL-0006R7-5p
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 00:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3nm-0004jI-8u
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:54 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:40215)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3nl-0000m5-AP
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:53 -0400
Received: by mail-pj1-x1041.google.com with SMTP id s88so2179789pjb.5
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 21:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VnwDYHyJTXcVKd4YU4u1JIC2YJpF3XkI8XH4jG+QmBM=;
 b=O4UYiAV9Ibj4ddqY35TKWtkunv4B9sYlB+YwK+UeIUdNLEv92cT3NaN8GmWM9alH7Y
 4lKUNk/gFpu5W8/DGaIewYGKBSQdeMv+RlHFcViD22IRUt3bZ24V3yy/DETld18qojHQ
 HdFY3TuTBfnXfRVzT0g8ZubDfIbhJk0U20eaRBcF/YPTWlqy/Bz3Pl/rdmI6DI6inLUT
 zcdNeDYWvOGdnr8+dlRr/QOgtdkpkqfl4fQxPuuKat3Kb0M9qBvdtkE1LSsYD12uJXYX
 EDQUMdGW/euqhY0eNbtefdgx+VUHHk83bJcsLS2A6MhNFKA4uFXw2t3Q7GDeA1HcyLvj
 xPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VnwDYHyJTXcVKd4YU4u1JIC2YJpF3XkI8XH4jG+QmBM=;
 b=ROhheJUAVy1Ad3TcQXMqtq+jETMWlDuL9FkaVH5ee1/SdSG2AJwee6RJcDZMYdixhI
 41LPuUEyqYFUlW71q5lkVAU1s5WnF00Gq2UJq52H/nu8b7giEz/n4qR01eZV+qDXWjbb
 Owff1EVqF+MHV2DqoqEANEZywvetlsZRMLfdUCUQo5U1zcTUX/nOdooh7qCf5ECA8fuo
 RmARxiPMbOJX1YJ942Df0G8/tAnbC7XcflIOTjxmX+7JlCLtLjGoX9Ow+AkwHv4quKsx
 cydZ3UNcqRShOmX1+vFORa5f2oOL6uOOmlfZzZjljC8tu1T9nkySR/5gvSD9AQp1To6f
 PJXg==
X-Gm-Message-State: AOAM531bhW7Irg3HZMQsnR8wEkcLT4uDFDOsJpcNI4ALClr9dC3Su05c
 MvlVbVpsfM85IrIKfc/DVyJVx5PVtqs=
X-Google-Smtp-Source: ABdhPJygvBGvbkJQaomvWIqZAV2+yzzElU7Hys64+HsqsLKL/tkfbbE5f7yyMeCSHdObXbSKGvyoPQ==
X-Received: by 2002:a17:90a:c258:: with SMTP id
 d24mr761390pjx.137.1591330671158; 
 Thu, 04 Jun 2020 21:17:51 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h15sm5440902pgl.12.2020.06.04.21.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 21:17:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/17] linux-user/aarch64: Signal SEGV_MTESERR for sync tag
 check fault
Date: Thu,  4 Jun 2020 21:17:29 -0700
Message-Id: <20200605041733.415188-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200605041733.415188-1-richard.henderson@linaro.org>
References: <20200605041733.415188-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_signal.h | 2 ++
 linux-user/aarch64/cpu_loop.c      | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/linux-user/aarch64/target_signal.h b/linux-user/aarch64/target_signal.h
index ddd73169f0..777fb667fe 100644
--- a/linux-user/aarch64/target_signal.h
+++ b/linux-user/aarch64/target_signal.h
@@ -21,5 +21,7 @@ typedef struct target_sigaltstack {
 
 #include "../generic/signal.h"
 
+#define TARGET_SEGV_MTESERR  9  /* Synchronous ARM MTE exception */
+
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* AARCH64_TARGET_SIGNAL_H */
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index ce56e15be2..41a68a57bc 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -132,6 +132,9 @@ void cpu_loop(CPUARMState *env)
             case 0x0d ... 0x0f: /* Permission fault, level {1-3} */
                 info.si_code = TARGET_SEGV_ACCERR;
                 break;
+            case 0x11: /* Synchronous Tag Check Fault */
+                info.si_code = TARGET_SEGV_MTESERR;
+                break;
             default:
                 g_assert_not_reached();
             }
-- 
2.25.1


