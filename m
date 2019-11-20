Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D766C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:03:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEA1C20715
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zTC4yWUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA1C20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXNm5-0003ob-LX
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 06:03:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iXNgU-0006x7-1b
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:58:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iXNgS-0006oL-Tg
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:58:05 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:40727)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iXNgS-0006lO-Lx
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:58:04 -0500
Received: by mail-wm1-x32e.google.com with SMTP id y5so1112570wmi.5
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 02:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LEjZwaiT7NBJ0U3NNZiqFvcTWTL2UsFeD0o79C2EwzQ=;
 b=zTC4yWUxqeWCnJqA0H3IRgfLvT5O6yOXqylifZo9LGaCgYndaPjJMpD89L7r6XvTF0
 I0NohXoJr9Xp38EiBObtq0TeQq6G87MajE3BbqTt0gSMA31nvGUBPpaNJaTtiYUjRR6B
 KtNGWLNXCIW1KGbJMPTAU5/3tKFcOAs+BKzjJcbjfZw8pNzgxDIB5tP5f5HJNGICio4w
 ndapbhq+Reh7/X2de5vX7yonNgmDHJDbOWYOLwm64rXQBSLZliE2uzKaHPecvfN5yzFF
 5j4A7ZJa7ekJRIwY3CTl+KV/m7+TtcDjgi43I2ajeycMFjnAUBRoJytr7fTpJTCaSVhg
 A++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LEjZwaiT7NBJ0U3NNZiqFvcTWTL2UsFeD0o79C2EwzQ=;
 b=HMBFSElsPGfIM7+T4ZG8upaCNN3XyDyvCpHMbUeqUvFaXU0OG0TuLfzO609lT23ASi
 jUSZFD3Ni0+Zi94RieY6DkAZ7oqXBK6TVC65o3ggAY20R2zt1/zAP7Alme7mu0bvXceJ
 LFLNTQLFzU1PuLZSQqi3Ta4OJR4Gd55odW0kmeS1WV6fuRVLKmWy7QVQ8rThaqx9ngKk
 Yo1B1LPglH/y5Xyt+AUVx1KNEfjd3m9E01V5JTXoGi2Anjd16sId+UFwm0z9D6WUZLcD
 ytzQwVjVtHf1bsApUemYHd1h6jKM8H8U5H0MEdo1zgU78ArGVJZGDmrPX6rjubKllZy9
 h5Bw==
X-Gm-Message-State: APjAAAWmbvpOkCdoTp13DuUW96XaGx+9yih4DSs1ywnIv6VlPIoeuS/N
 OtublmS0wxfafM4WNJR5J+7JmA==
X-Google-Smtp-Source: APXvYqyP+CFTveu0lm4GmCYX4yxoJ8MQY/mySiWc8A0w2ddlTvjP77ZoCJBXTtNNJ77+800auE2Q3g==
X-Received: by 2002:a1c:6486:: with SMTP id y128mr2285036wmb.148.1574247483165; 
 Wed, 20 Nov 2019 02:58:03 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z4sm6258708wmf.36.2019.11.20.02.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 02:58:02 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6F9711FF8F;
 Wed, 20 Nov 2019 10:58:01 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 2/5] docs/devel: rename plugins.rst to tcg-plugins.rst
Date: Wed, 20 Nov 2019 10:57:58 +0000
Message-Id: <20191120105801.2735-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191120105801.2735-1-alex.bennee@linaro.org>
References: <20191120105801.2735-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This makes it a bit clearer what this is about.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index 2ff058bae38..c86a3cdff2f 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -22,4 +22,4 @@ Contents:
    decodetree
    secure-coding-practices
    tcg
-   plugins
+   tcg-plugins
diff --git a/docs/devel/plugins.rst b/docs/devel/tcg-plugins.rst
similarity index 100%
rename from docs/devel/plugins.rst
rename to docs/devel/tcg-plugins.rst
diff --git a/MAINTAINERS b/MAINTAINERS
index dfb7932608d..5e5e3e52d61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2371,6 +2371,7 @@ F: tcg/
 TCG Plugins
 M: Alex Bennée <alex.bennee@linaro.org>
 S: Maintained
+F: docs/devel/tcg-plugins.rst
 F: plugins/
 F: tests/plugin
 
-- 
2.20.1


