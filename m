Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B7EC2D0ED
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB434208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c6SQkvBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB434208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHtZR-00022y-10
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 14:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jHtUC-00023c-FN
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jHtUA-0000xX-Aq
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:40 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:44260)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jHtU9-0000w9-OW
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:38 -0400
Received: by mail-wr1-x42c.google.com with SMTP id m17so12500827wrw.11
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 11:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JPoDm/Y8ADNX7hlRvL6Q3jMgQOp/FBsw/kHWKcLczW8=;
 b=c6SQkvBty3OZUOlG8Cidcv5qNarFOL34e2lAY3NjE2BgJZlGaWw+XMPsMw2u05Dx2p
 xqUEQdy7B6x6PXO2nMbl0qhpb6o7UHrZmJzKSHmCPlsXMZu/zYZ2cybIQAZYn79PekHo
 0Na3S0sRmbh3ZNSPoZjd1cglqyq03MnZ6nPKbeMFBDg2acYEwG30dp9zoM04npaVjAXk
 jo6VQWqBG+LtjjTRovWzcDzhnUSRKyXvfoqjq4meg+zxMBBLmi09zUfEIwfP7H0H6F17
 kaX+Vrm7NA0A8cXCYx8wJQ/07hQazOYtFpqbe2YWUw3hK3vDBVdE/e+fDny8NVn/94XQ
 hYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JPoDm/Y8ADNX7hlRvL6Q3jMgQOp/FBsw/kHWKcLczW8=;
 b=pthDkZnsVk1dt3bCP2HzId62IFJb3pLDIHB/B+8lHcn4tUHjmT+rBbgM8ErO5P9RS+
 lMoVqPAKoQXrbQKgiFMnlExb7MF7kZcYBN58a6mjo3FuKEAWuTf8aQpCaXOUbm8Rmop6
 76seaoD8ZCPoh+GSXVtCCTibhsJ34YaXwAZ0VWezoei7BrGEOiFvsjjVbY22s9rhj3c2
 rcyJJwB6sQDW0tJBlfFzuVEPvaSmCssOQ1x7KDZKQ2HBryNM53S0BhbIPyC1eRZR2u2d
 9S3w4qxCO8awDG7tG91ph/UWOacf8pruIJximVB0GWxk3HCx9ES7+I0oMvRkys5ctG5n
 FC5w==
X-Gm-Message-State: ANhLgQ01iHyaIsphs/LoE2VyTdTixMW6dakjd2vOa2aypnRGux3LSCOu
 cRoORIQTsfBc/XzHlPKof2qYqw==
X-Google-Smtp-Source: ADFU+vvLn7OinPE/JT2tCW/ImkX9KvJm7vFFHNVLsJ4wZPW/ZqK9burQi5ii2bJOogh2TkRN8wjECw==
X-Received: by 2002:adf:f8cd:: with SMTP id f13mr648054wrq.119.1585332816732; 
 Fri, 27 Mar 2020 11:13:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t21sm8864495wmt.43.2020.03.27.11.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 11:13:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2FCF01FF99;
 Fri, 27 Mar 2020 18:13:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 10/12] tests/docker: Use Python3 PyYAML in the Fedora image
Date: Fri, 27 Mar 2020 18:13:18 +0000
Message-Id: <20200327181320.23329-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327181320.23329-1-alex.bennee@linaro.org>
References: <20200327181320.23329-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The Python2 PyYAML is now pointless, switch to the Python3 version.

Fixes: bcbf27947 (docker: move tests from python2 to python3)
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200322120104.21267-4-philmd@redhat.com>
Message-Id: <20200323161514.23952-10-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 019eb12dcb1..174979c7af4 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -79,8 +79,8 @@ ENV PACKAGES \
     perl-Test-Harness \
     pixman-devel \
     python3 \
+    python3-PyYAML \
     python3-sphinx \
-    PyYAML \
     rdma-core-devel \
     SDL2-devel \
     snappy-devel \
-- 
2.20.1


