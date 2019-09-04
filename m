Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B208C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:05:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A3720674
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ttPaSj+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A3720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cSa-0000oT-RP
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5c3z-00012j-3U
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5c3x-0003YB-NK
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:34 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:32874)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5c3x-0003Xa-Gh
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id r17so3372465wme.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3YyKCQsfgzvXKSHDv5mJ/Ups/NVidIa51ccen10JgYE=;
 b=ttPaSj+pg0CsO+J+ADN+B9sIbM2YYgljcdeFQGiiPsYypwqS+dkCGm9wG0TEiGnv4R
 hnROhgSeJRT56ul6B1hpTeikKX7cC3PmvCoK3n0icuSKoQNw2vKcLaNFsv39lr5zhvNO
 LQdpAZswinUdUOdc5MQFnZFx2C/VN0mz7y2mbfWJ2uWuiYDcaUHhCu4YA+8g8tIlDoe2
 fHPbNt+rwybRzdBRGcyT8wlWaCmebAcDRDh99cBxAVvleejUOcAIJReDkaf+bU+Cn7uj
 6pe0LzymFdkXdGiOaT8ASNA4OwhVNugh618r25pZJKn7jsY/dwhbbJ0i8gBov129qfI+
 opdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3YyKCQsfgzvXKSHDv5mJ/Ups/NVidIa51ccen10JgYE=;
 b=FqH2kzE+xWVQqNMJUWvnsuyHLi+Rm8P6hGS3UWgfevULAFXn1atuu8nRjnqfBnLweg
 XE2BORq+aEze6TLHUgj5LOKtFnDQ9GjJwNQ0Ie3aFChjjPVLNvI58eRKXRjJxrNqA/MW
 F93x/v6TIS44Nks8v1V901gGoZDf4uD3N+ADQOAfdHp2fhNXMoQZLq7KU8lu03Ivtbg0
 e8xsaHszaEVIu/8qBqMfZj2rhYmD5ENkhRe0I7GEiw0TrcnLVC39F0tTn8iY23F17xEQ
 gzPQuqbEVi5cmpTvJZUP7J8232qCtkQ991uYKlG4NBDoOFx562hOINcTBypLd2JZylAf
 Kw6w==
X-Gm-Message-State: APjAAAUPQPr0+md1GtprxTtTQRo51s3/DVo0czag3SoE2rFAq2NV/CrO
 oucevjvGBl/rJIbCdmuQeoy6+g==
X-Google-Smtp-Source: APXvYqzjKjzJG1aCTK6brZfIaFla0XtWTIP6rpRTHuDLrakmnP7ZCsY1NsmKBInyuRYDSy/u9FLajg==
X-Received: by 2002:a1c:9e0b:: with SMTP id h11mr123107wme.144.1567629572522; 
 Wed, 04 Sep 2019 13:39:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t13sm26606401wra.70.2019.09.04.13.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:39:31 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A95F71FFBD;
 Wed,  4 Sep 2019 21:30:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:30:07 +0100
Message-Id: <20190904203013.9028-37-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
Subject: [Qemu-devel] [PATCH v1 36/42] .travis.yml: Document how the build
 matrix use caches
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

We will set the CACHE_NAME variable to improve the caching
of various jobs using the same characteristics. Document it
first.

See https://docs.travis-ci.com/user/caching/#caches-and-build-matrices

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .travis.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 2dd26486abc..ab3e4ebaadf 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -6,6 +6,12 @@ language: c
 compiler:
   - gcc
 cache:
+  # There is one cache per branch and compiler version.
+  # characteristics of each job are used to identify the cache:
+  # - OS name (currently, linux, osx, or windows)
+  # - OS distribution (for Linux, xenial, trusty, or precise)
+  # - macOS image name (e.g., xcode7.2)
+  # - Names and values of visible environment variables set in .travis.yml or Settings panel
   timeout: 1200
   ccache: true
   pip: true
-- 
2.20.1


