Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61EDC28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F688207E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q/+e+lio"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F688207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47122 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZAqf-0005qR-Qe
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 05:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39280)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAox-000460-9e
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAow-00048s-22
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:05:59 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38580)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZAov-00043s-Ql
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:05:57 -0400
Received: by mail-wr1-x441.google.com with SMTP id d18so1354939wrs.5
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Iq7Nm46aUE7quvi6VDpmkC4n6wLldVq8o82duiGCIro=;
 b=q/+e+lioLf77XuvFKi5Ka2COkU5xft+YJvhYyOK6UFRK2pVrQCjd0ehgnnwxsw0yq5
 R6to5Z4b7a0sdAd2lPB6nLMveQrZNK8nHopVKh7ZNuNzfMVZWvMZOlOuBwUrT7c3+8Ra
 jtX0jZuA6zmd1X/PDkrW453Pdn9mZ1QwBl2Xsokbp1YAl7AIKjBDtxCv2vBCZO3qTegf
 vIL/EKWG21cKusOTPeupgftxhjfDzC8GxSynuKm0MCG9ZgHP6lQsquwU8FCjb5dYwRYd
 nm80QoatvQHD2bBEvEGRxS3Z9dBKbbmD3Y5m/oKnm5+aFYTiuon0PbQulfGabxtzoaaP
 22Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Iq7Nm46aUE7quvi6VDpmkC4n6wLldVq8o82duiGCIro=;
 b=RQzszi+MaJBBsLCpI9WXXKwPyJJmyEvWrK+vRH/WSjUR0xMasq+zzw6Jlz3B8GcaQ7
 D7KT/jp67Bye6HEZOdwEefbCDfNK0Q0WED6EoJHCOVzcxxowtlqbIaD6mYe4hraJHtic
 qAYEN52LkfdetuiV3/bcCLd2UFq3bbgA7lq+KvEgcVrCmGy7O1U66XKFFIPmtz+MpCjl
 tPuI06MwcOPP0iNbX2B6XqpJ0RcobyyH6n/EdY1lhmoT6/6SAw9P/23MXL1zKGIlo1St
 SonqyHh3ka3g2EDrRXjRgUhEcimJ4RySy0oW4tjlEyBYliXDb6ySY4bfOT9yKBZjUzgS
 2e3Q==
X-Gm-Message-State: APjAAAXN6dx8p0VGEvZedA07X/U46LpTV501b93LuNQtgdtmlRJ3ITHH
 lhZjipHxsIiWXcHOl8RU/2SO5A==
X-Google-Smtp-Source: APXvYqxwoqeoB/TWUxEe2DwhxkUnMF32YqUrgibu7UvFHTD6h3S6XO0UT1qfBQ27MM/dhG8TyJuCGg==
X-Received: by 2002:adf:f2c8:: with SMTP id d8mr6262931wrp.221.1559898355776; 
 Fri, 07 Jun 2019 02:05:55 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id j7sm1819350wru.54.2019.06.07.02.05.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:05:53 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 584A01FF91;
 Fri,  7 Jun 2019 10:05:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:03 +0100
Message-Id: <20190607090552.12434-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PULL 04/52] tests/docker: Update the Fedora cross
 compile images to 30
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
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While at it remove the bogus :latest tag for cris cross compiler. It
tends to break caching and cause confusion.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/docker/dockerfiles/fedora-cris-cross.docker b/tests/docker/dockerfiles/fedora-cris-cross.docker
index b168ada615..09e7e449f9 100644
--- a/tests/docker/dockerfiles/fedora-cris-cross.docker
+++ b/tests/docker/dockerfiles/fedora-cris-cross.docker
@@ -2,7 +2,7 @@
 # Cross compiler for cris system tests
 #
 
-FROM fedora:latest
+FROM fedora:30
 ENV PACKAGES gcc-cris-linux-gnu
 RUN dnf install -y $PACKAGES
 RUN rpm -q $PACKAGES | sort > /packages.txt
diff --git a/tests/docker/dockerfiles/fedora-i386-cross.docker b/tests/docker/dockerfiles/fedora-i386-cross.docker
index eb8108d118..9106cf9ebe 100644
--- a/tests/docker/dockerfiles/fedora-i386-cross.docker
+++ b/tests/docker/dockerfiles/fedora-i386-cross.docker
@@ -1,4 +1,4 @@
-FROM fedora:29
+FROM fedora:30
 ENV PACKAGES \
     gcc \
     glib2-devel.i686 \
-- 
2.20.1


