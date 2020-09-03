Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CED7C2BB84
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:24:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A8C2078E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jqdjz3Oj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A8C2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDnLX-0006Ty-1k
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kDnIr-0002VR-PC
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:21:17 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:34865)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kDnIq-0007ZR-1B
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:21:17 -0400
Received: by mail-wm1-x32a.google.com with SMTP id o21so2518204wmc.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 04:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yx117BKiV22Q73t4X6K8k+bAWttmepupVY+4lQVfzhA=;
 b=jqdjz3OjPBvO/kBpkhyV+3iLnJOMUDlSYj0vVhB5PgwvLyxUH8dSXfiK2iXagh58Ei
 zls0/kTn77HispDdMmMes+JeU9ooaQZ3mlKKMnavTkqB84Grz5AAzOM19nE76+6I03Wr
 Le/sebSh90fnqWD5hYrsGp6KtBx8YKqJyQd9ECitMWd8S1IZ8wB51/NzFHgZXazVwwBn
 V2KgTF3g89ZMwTO1QX2Wk6tGjVk2qPkNldXCTFZcNK4YRiHRGyO9b7taEY+lXYlkaSDc
 ojOEv/yUzbeo8dBfiVHqzYg4llVoDNsQYqDwHV9cNR0HwH4OfDSx4Pc682aEPc9O94MS
 F2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yx117BKiV22Q73t4X6K8k+bAWttmepupVY+4lQVfzhA=;
 b=oC52rTFG42I+BqupNhrJrad90KOWuB1b8pOJGbq1aicA/Mcg3X2pBBIQz2ai52pe3i
 m5yKX2FoJ6hP9ZSpc2iM1SO74F2iYPIMtAX4LqHYkArFWkGJFmK6o+YxWrmjSeCYva4w
 E0mLU2FKs+cvUOvoJo0PBYGQe+MbGhDYka7tWxvsKDupEPSwSbdcMDqjV+lxZzxiTTqS
 JfMg1Qhi1UXUVppMDq3+PYTTvxhuSoxORZiL/vQXtkbqVXIjgQ/Eckp7DTEch2xy1FjN
 S9eRM14dhnGoltwkibwVneBnbyVxiWUzBd9bm4hQYpaldq9YtXfQoj6eluoEbwYRISyQ
 aUlQ==
X-Gm-Message-State: AOAM533jaCfNELIAubA/YNZ5vFj91SfnIqkSLmobelbTLzMXYMw7mCTU
 nHBTo1N6rAbDe7zyhafMMtw6Bg==
X-Google-Smtp-Source: ABdhPJwpEHegbSip4bRWIb8pa64x+8j2gJCxfZPxPqad8BrBOuQIw4bTGo8ONjIP4bbOZYl9BqZ3fA==
X-Received: by 2002:a1c:e256:: with SMTP id z83mr2097421wmg.137.1599132074579; 
 Thu, 03 Sep 2020 04:21:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n17sm638180wrw.0.2020.09.03.04.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 04:21:12 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 093F41FF8F;
 Thu,  3 Sep 2020 12:21:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 3/8] tests/docker: add python3-setuptools the docker images
Date: Thu,  3 Sep 2020 12:21:02 +0100
Message-Id: <20200903112107.27367-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200903112107.27367-1-alex.bennee@linaro.org>
References: <20200903112107.27367-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need these now for builds to work.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian10.docker | 1 +
 tests/docker/dockerfiles/debian9.docker  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/dockerfiles/debian10.docker
index bcdff04ddfe..e3c11a454ee 100644
--- a/tests/docker/dockerfiles/debian10.docker
+++ b/tests/docker/dockerfiles/debian10.docker
@@ -29,6 +29,7 @@ RUN apt update && \
         pkg-config \
         psmisc \
         python3 \
+        python3-setuptools \
         python3-sphinx \
         texinfo \
         $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/dockerfiles/debian9.docker
index 0f0ebe530af..3edb5147ef3 100644
--- a/tests/docker/dockerfiles/debian9.docker
+++ b/tests/docker/dockerfiles/debian9.docker
@@ -28,4 +28,5 @@ RUN apt update && \
         pkg-config \
         psmisc \
         python3 \
+        python3-setuptools \
         $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
-- 
2.20.1


