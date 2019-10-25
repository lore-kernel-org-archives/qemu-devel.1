Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BD4CA9EBD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7354E2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tARXIZaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7354E2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNy1V-0006M3-Id
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 07:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNxwV-0006qW-UM
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNxwQ-0006gc-Pw
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:41 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:39897)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNxwP-0006fB-1v
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:37 -0400
Received: by mail-qk1-x742.google.com with SMTP id 15so1401379qkh.6
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 04:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gyTalvpUNKSJ73L+c2LcfOwC3yCRl3XSXEKw11FCS20=;
 b=tARXIZaf6JD0O9SZZCu7GP4auGvVhv7DjA+9hKeRokTMaCXYJDGn31BbcZXum3Y+cO
 diDAadMmFfFRj2KDve28ON0J+vUV4+qm51pB1rYwTMYLJI8mIcUtA/icikTKVzd2rd0P
 j0S9QZ6v5PC2En32z4VLUhrNkaONv89wWwXsAyQXyX5aXL5t0ricm3bfU5SYF3cq1M1x
 qErQJGO0312iSn8lfYidXV/OKJkkTVJFijsRoeewtqNbC9F6OQ1MuP2bujEaN97oaGla
 ZXiR/R9bG5DHRODjU+SB2UflrnuJwTyERG6RQ4tSW3XFjHrAk6FwzhLAQYsbG6GSNbgD
 YHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=gyTalvpUNKSJ73L+c2LcfOwC3yCRl3XSXEKw11FCS20=;
 b=bhSNrpy+MSYOUBYJyUa1yE1ocs45vjNe7ltvZEmRh2gGhqb8o286m0cTQpvAmTkjHv
 BSQYaOnMlM4BnVfY6yRhEiikJjOnDwAClZSspIvpBM6fii7YFX6m45+uPlOJWcdYdNbW
 HdtqsPGyGG7melgbJwcgL9tvIcha0raJgojNv+JJ6QFJFHbZiQO80BvFNkOAMr1BSBd3
 gCMeckd8TG1xHB8EIFN2HZkMqXZMwmghbYydt7RKTRw1KgCDneRoHxyiTxdgCVE2yPDO
 7MCEIVBs/8xjVTUX+1rOnCfQWs7FVKEqBIiJvkO8B5Nws6SFxgUCplMctv2OWvKskkum
 6U4Q==
X-Gm-Message-State: APjAAAU54oEDSiEBFvTh4xK1SKugZ97stJ6NLJg9gG3SQKxOCtOcjgMx
 8xRGUShmrbhafhSpU211xyOD8H2x8Qo=
X-Google-Smtp-Source: APXvYqwNfSIPuSrnweJE5Z6p+WWVkVtcnvb9CUDeJST5WzUMThmvHZvWKiafLfQkGyXt4LD8aWBJBg==
X-Received: by 2002:a37:507:: with SMTP id 7mr2378216qkf.107.1572003576108;
 Fri, 25 Oct 2019 04:39:36 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id x38sm1473335qtc.64.2019.10.25.04.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 04:39:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/12] linux-user/alpha: Set r20 secondary return value
Date: Fri, 25 Oct 2019 07:39:21 -0400
Message-Id: <20191025113921.9412-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025113921.9412-1-richard.henderson@linaro.org>
References: <20191025113921.9412-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Cc: alex.bennee@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This value is not, as far as I know, used by any linux software,
but it is set by the kernel and is part of the ABI.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Do not set the parent secondary return if SETTLS.
---
 linux-user/alpha/target_cpu.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/linux-user/alpha/target_cpu.h b/linux-user/alpha/target_cpu.h
index dd25e18f47..ad408ab5cc 100644
--- a/linux-user/alpha/target_cpu.h
+++ b/linux-user/alpha/target_cpu.h
@@ -27,10 +27,19 @@ static inline void cpu_clone_regs_child(CPUAlphaState *env, target_ulong newsp,
     }
     env->ir[IR_V0] = 0;
     env->ir[IR_A3] = 0;
+    env->ir[IR_A4] = 1;  /* OSF/1 secondary return: child */
 }
 
 static inline void cpu_clone_regs_parent(CPUAlphaState *env, unsigned flags)
 {
+    /*
+     * OSF/1 secondary return: parent
+     * Note that the kernel does not do this if SETTLS, because the
+     * settls argument register is still live after copy_thread.
+     */
+    if (!(flags & CLONE_SETTLS)) {
+        env->ir[IR_A4] = 0;
+    }
 }
 
 static inline void cpu_set_tls(CPUAlphaState *env, target_ulong newtls)
-- 
2.17.1


