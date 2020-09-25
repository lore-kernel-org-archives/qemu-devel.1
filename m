Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28367C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:51:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A087A21741
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CmsIsTbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A087A21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLq0o-0004bI-Jr
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLpps-0002jB-9u
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:40:36 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:40454)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLppq-0007ax-B2
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:40:36 -0400
Received: by mail-wr1-x432.google.com with SMTP id j2so4071527wrx.7
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 08:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=z2OtAFTh3+9q2/zKqbcEllbBFvpVmRkFnnE3OIbznwA=;
 b=CmsIsTbzgqI2HXh1gv/izniCtpOZwttxLBTjiax52Ri6U8MMtTfaarBf0QmUiazJlO
 s9Ar1o2FNDwRUBd9j9QQJZhAsTmDRbp4kJS/x2kDjd/q1gywrjiRYG8FxZbowAGsMwSW
 Xah9w+VBFZV1z0CQ4f+Gm+bUqlWBWK/QVJD7tuJNuR8eu7leYrgFRYf2OzvNe0nwcc2/
 QFdeQFCVOcQ8NDnYcXYczsW4WAHzY/pvoAq3tO421mkQzhUFW2/nRaKuNUUcNvOSpjWT
 AylSeYypYAsltCnWIyaDwitvJBiMfVJq9MGvqt51t02ayB8LcUdv9QOWuzrGtjFTC5RX
 P2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z2OtAFTh3+9q2/zKqbcEllbBFvpVmRkFnnE3OIbznwA=;
 b=KTQ0xcvqCA6WUriiLPhXRk15RvkErY15e4H7scnw9txqb7yXQjsLHatm4ZOvlX3Xpy
 F4Sdnw5bh6JoeV60xLEWd0qGTAACuiQOWha9r/ZI5H1IZKwIbKN7k9PRE/TBIgNRa8yN
 RwneVsf2dZXSfjIqo+nFzWPuW8dmvPLznaTAkA3ylRj9XhqLfqSi/m6iw9s22mDIFu8E
 5RikblanLeOzZIJwB+e+N2doGH94AmzjhdWQEKq+yq3SagUAVjf3FNVsgC+xEitisE0k
 HuzwdNTN5CpjAHmG5Mtk7cdqX7sGxQMTfgmMIKshUjMhna4hJXd/DwL/WSWbDpmNjIdp
 jkDA==
X-Gm-Message-State: AOAM533iAhegk6GmmytEjj4KP5+W9e9LnnwwSd9tRyaQY21UYlaehM2D
 N3JUy4/oSh44H/e+6eSgka1H+Q==
X-Google-Smtp-Source: ABdhPJzaGlRwdGG88vPM8KeLNwNTrmjmNTykbBkHaDRQZiJGTacq7BRde0ct1GoVTHXYxFNftlgRXA==
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr5535670wrm.371.1601048432899; 
 Fri, 25 Sep 2020 08:40:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o4sm3155038wru.55.2020.09.25.08.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 08:40:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C29881FF90;
 Fri, 25 Sep 2020 16:40:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 04/15] migration: Silence compiler warning in
 global_state_store_running()
Date: Fri, 25 Sep 2020 16:40:16 +0100
Message-Id: <20200925154027.12672-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925154027.12672-1-alex.bennee@linaro.org>
References: <20200925154027.12672-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

GCC 9.3.0 on Ubuntu complains:

In file included from /usr/include/string.h:495,
                 from /home/travis/build/huth/qemu/include/qemu/osdep.h:87,
                 from ../migration/global_state.c:13:
In function ‘strncpy’,
    inlined from ‘global_state_store_running’ at ../migration/global_state.c:47:5:
/usr/include/x86_64-linux-gnu/bits/string_fortified.h:106:10: error:
 ‘__builtin_strncpy’ specified bound 100 equals destination size [-Werror=stringop-truncation]
  106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

... but we apparently really want to do a strncpy here - the size is already
checked with the assert() statement right in front of it. To silence the
warning, simply replace it with our strpadcpy() function.

Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com> (two years ago)
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200918103430.297167-4-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 migration/global_state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/global_state.c b/migration/global_state.c
index 25311479a4bd..a33947ca32b5 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -44,8 +44,8 @@ void global_state_store_running(void)
 {
     const char *state = RunState_str(RUN_STATE_RUNNING);
     assert(strlen(state) < sizeof(global_state.runstate));
-    strncpy((char *)global_state.runstate,
-           state, sizeof(global_state.runstate));
+    strpadcpy((char *)global_state.runstate, sizeof(global_state.runstate),
+              state, '\0');
 }
 
 bool global_state_received(void)
-- 
2.20.1


