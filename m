Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD91C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:19:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB4F420828
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eOKovI64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4F420828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cgE-0007ja-6t
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51509)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5c3r-0000pk-BY
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5c3q-0003Qz-5h
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:27 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:55350)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5c3p-0003QF-VX
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:26 -0400
Received: by mail-wm1-x336.google.com with SMTP id g207so204892wmg.5
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PIODOTVy4HDE3zFxAtxJ3smi6AAB4cF2pRQrP6evZ/U=;
 b=eOKovI64ggTWYbvl4vwuZOMrD3G3UNKZc50/ewN/tTWAk5Xl+IsVaZ9WTWhOf6LVBC
 KFFiEeR7m/E2Sx1Fi2xqWeU3W34X9Qs8y0bwzSBnHuyhwv8fyzqKViGFM+WkD5dyCr50
 4xg3VomLtYHoQGQX2W2OSJUBVxdMI++zYZdL/3ist2PF/AI6cbXdTbOvX2wB54aq6g6N
 k/ocvipcTBrLhkReSCHspq7aT6t+IDPoHEg278aI4T7wbZCD74EGD76i5zBP4+v/+Zps
 OOGFEhfkwX2yZ1zu1YGRlty1gGpm3ld446zoGWd0+qo3lY7VS63+8NyF7V20F0ivDutw
 eR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PIODOTVy4HDE3zFxAtxJ3smi6AAB4cF2pRQrP6evZ/U=;
 b=GSh/8Yp6xtu5DyTjkA2CMUf8BpuIc6WwT/GUz24VrfbhyBiuXk4b6ZghLLaiYbLFnp
 omg5BopcQmCoGP+zuXwI/UNDO6lttq8mn0PFJqSeHSl18bodgXC9xtOgTRqHVfB/RpzK
 pLLkxT1teTo10wYQeGDOOavh6bXMDezujvD2eKscQO3CouGoU/M6KkhnOe+aRW0x3qrA
 hCXUTkXqrXZgmHj7NAwhFD9h+1j1Y/K1uGz1qRT7IRlIQ3qsh7YxsCQRDJ7zBlHtlq8n
 BdyAkT04WN1j0qFYCI0kWZsuMPqfSOvF9XfrLSVA3m5vZyMZtdQVuMtTgAGTA3k5OmCD
 GlPw==
X-Gm-Message-State: APjAAAViywWOryHOQEgd+KOULqliDKzFeuOchcrkhWc6P6pb6xfA99HY
 xbw8yoKRvhm2JHfla2dlXSAUHg==
X-Google-Smtp-Source: APXvYqxijLN3khc6JjBLJETmWttdIC7iHrIDKJbXX+ITnNC16dhk02dRmSv3IUhIfVW2Kqyf0kH0iA==
X-Received: by 2002:a7b:ce8f:: with SMTP id q15mr128286wmj.106.1567629564909; 
 Wed, 04 Sep 2019 13:39:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a205sm183512wmd.44.2019.09.04.13.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:39:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 58D201FFB8;
 Wed,  4 Sep 2019 21:30:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:30:03 +0100
Message-Id: <20190904203013.9028-33-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
Subject: [Qemu-devel] [PATCH v1 32/42] .travis.yml: Cache Python PIP packages
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

We always install the same packages ever and ever, cache them.

See https://docs.travis-ci.com/user/caching/#pip-cache

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .travis.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.travis.yml b/.travis.yml
index 8c376d22239..d51125c9569 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -8,6 +8,7 @@ compiler:
 cache:
   timeout: 1200
   ccache: true
+  pip: true
 
 
 addons:
-- 
2.20.1


