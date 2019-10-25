Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF1ACA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC1C12070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZKOCAS0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1C12070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNy1Z-0006Mw-Bx
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 07:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNxwN-0006XP-0C
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNxwK-0006dS-FR
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:33 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:45247)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNxwJ-0006cV-9j
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:31 -0400
Received: by mail-qk1-x741.google.com with SMTP id q70so1373453qke.12
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 04:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=DlXXOhTdrM3bVVr6VG88KwpML+EyXMPXZ3h5425yg7c=;
 b=ZKOCAS0zDwnYBsA1VAnnjCkenRE6kQmZiPNdzlupEPL4+IjEq4rlAJ5nEd3/TW7qsC
 tWtfA+9n9ojS9NGxZi0f/H0QlmLPKITQSMdm+aNaQKJi81RsprZrMzdhyUdzdSjDGFWW
 eJFvk8nnxgl6G9SZKN2DvSb5W9G3ne0p/Xzxm/gvi2TVwWvfGd/f1xdYeA63rG02pIWk
 vHYbenEs/VyTuInmprNfuq7F80XgQOh9bEi+J4cUVj7Ps6FUhUzW2/j5vgy5g+ymu/ZO
 /59mzCwx7Qd7Uwhwl98nR3+VXph94aiWNg4V5lPKShlKhqw+RbiIdYZphFUlPZfJf5+r
 ueOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=DlXXOhTdrM3bVVr6VG88KwpML+EyXMPXZ3h5425yg7c=;
 b=NfEhwBw+eK9cipl1gz9IxLuxU7dfkmJcN6auOOgzy7R5TjPpVolD9DBn2DHScOFcg6
 Y45OaOMkpwMtqKctBitQmkY48ThvtOy2PQpijtwT1zBEw0WGGkHsNjmQdpxI381mGw+j
 vXMUiJ4j9qZNO/ustBbtsobZrz/OaZSnRkoYLpFb0qYa++PKIhNpEVTCwB+vtM4WYl3C
 nD1m8qx7P4yP7BhHwnCwfX13CW4AyjeRfO1CdWmNCRxfQ99UYqP5zcuhYUDiZxqXuZkN
 YIWu/vzh/sOzQJaJPhZT922v3Hw4yxFgDocPvMBL3MQpAEc7ne8HiIDeHWclQ7UmqrwO
 RkAw==
X-Gm-Message-State: APjAAAUJeuoGECvO+EpjIZGdRvep2YiVwE6Q4T96wEu7usTTCR8FBQOe
 XUXuV0wSiC+VYlRuNJJJ49gRMyu4K+U=
X-Google-Smtp-Source: APXvYqwSXT6R/VMFAdSfkmeVTS9NB/EcMQ/xmEBPdmqqBTsNa+rzAq8mJ7f+nejRgl/Tvi7xdVkuqw==
X-Received: by 2002:a37:e407:: with SMTP id y7mr2242107qkf.77.1572003570488;
 Fri, 25 Oct 2019 04:39:30 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id x38sm1473335qtc.64.2019.10.25.04.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 04:39:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/12] linux-user/sparc: Fix WREG usage in setup_frame
Date: Fri, 25 Oct 2019 07:39:16 -0400
Message-Id: <20191025113921.9412-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025113921.9412-1-richard.henderson@linaro.org>
References: <20191025113921.9412-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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

Use WREG_I0 not WREG_O0 in order to properly save the "ins".
The "outs" were saved separately in setup___siginfo.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sparc/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index 0db4c5f84f..efb0df7e2b 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -192,7 +192,7 @@ void setup_frame(int sig, struct target_sigaction *ka,
         __put_user(env->regwptr[i + WREG_L0], &sf->ss.locals[i]);
     }
     for (i = 0; i < 8; i++) {
-        __put_user(env->regwptr[i + WREG_O0], &sf->ss.ins[i]);
+        __put_user(env->regwptr[i + WREG_I0], &sf->ss.ins[i]);
     }
     if (err)
         goto sigsegv;
-- 
2.17.1


