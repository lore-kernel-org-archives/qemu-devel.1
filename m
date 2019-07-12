Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51381C742B2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:19:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EE4620863
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mzlskNgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE4620863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hltaG-0001lX-Rt
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 07:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47096)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hltZn-0000Gr-9y
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hltZm-0000Kh-8k
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:18:55 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:53044)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hltZm-0000Jb-1h
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:18:54 -0400
Received: by mail-wm1-x332.google.com with SMTP id s3so8573258wms.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 04:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8dg+G9am5UsGH5+qyraqKg9u6GQQDRS8YAQGlF3Cs2s=;
 b=mzlskNgsQ85YluFpgc2fjsm+ctk4dyb1eP9+SKAepMb9RcO5Zf8HVY7F/rNv0ueM2o
 ysxmsQ15ch9pxbQPZ+Ee0bFfRsC21Iiw1vfQH4IIH5oUTvD8xXCWKw3He/ywyf1o0Ud8
 R8o1Q+gIZlqpvSWX527sxNXnMVTTudsm+bNVPucRBNuB1YgB+ib/VZn5WIs5NnUYtawz
 3PUBHs0CuuXLg+Gr86MvoUM+nlKRQbOWxzNA2D5GsjP93iyNIlf3qnS2ycVZD6GAoMWB
 Sn9zlxTsQCNsFLQQlE8nrMwK33AfacqcG7zvMyVyLXUf8Af/+PC1TJn4SMn4BQ7Ks9Yu
 x0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8dg+G9am5UsGH5+qyraqKg9u6GQQDRS8YAQGlF3Cs2s=;
 b=sZjrVsicPxe/SsVWxTC5hAW2Al3VfxlCrzT+o+KbfbMZjvkKyOACdCWayJ+gJdBpKO
 LKCa/ypaQ1qwi8y2a2KHLys34cADa7WZxB7rphgIQgNdNIqDkAZgUwbVX7Dp0o0A2/kn
 WKSfaWlvvtqMRZ4ElU3dRPSZU1iUsRHTz5WrWn2VOHSXrzv0CR8yQeLKyWDQhtve4tXQ
 +2jBrCD/EqeTJ8mdeuCO3A3TJ5rZ4WwNx26l1RLFccRQQBvwgK/sBSBLnJFKkfxXpKs5
 EcsRo2xFkbvsdDa8MZonQPbdT567drPhNLHKyeNSck7aXtC2vo3Y6byyLIdpSQCTudKE
 ZsRg==
X-Gm-Message-State: APjAAAVcovRcMx5c5Uz//mMt7Pg+pl+4vuFBIxMefAQoCuK0e12JxSq3
 39wlaERd8bpV6Ml/00IOYjW8hg==
X-Google-Smtp-Source: APXvYqxesDAQdfZYL/5QhHnfezi8bEynlURqVRbmNv05n74bDKvAxeMCZ2OdrpeT0rEzL03YQzKPnw==
X-Received: by 2002:a7b:c3d7:: with SMTP id t23mr9222783wmj.94.1562930332818; 
 Fri, 12 Jul 2019 04:18:52 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id y16sm6801251wru.28.2019.07.12.04.18.50
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 12 Jul 2019 04:18:51 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4E02A1FF90;
 Fri, 12 Jul 2019 12:18:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 12 Jul 2019 12:18:45 +0100
Message-Id: <20190712111849.9006-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190712111849.9006-1-alex.bennee@linaro.org>
References: <20190712111849.9006-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
Subject: [Qemu-devel] [PATCH v1 3/7] tests/docker: Install Sphinx in the
 Fedora image
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
 Richard Henderson <richard.henderson@linaro.org>, Fam Zheng <fam@euphon.net>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Since commit 5f71eac06e the Sphinx tool is required
to build the rST documentation.

This fixes:

 $ ./configure --enable-docs

 ERROR: User requested feature docs
        configure was not able to find it.
        Install texinfo, Perl/perl-podlators and python-sphinx

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190711102710.2263-1-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/fedora.docker | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 619d1b5656d..e6d39e14cb1 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -76,6 +76,7 @@ ENV PACKAGES \
     perl-Test-Harness \
     pixman-devel \
     python3 \
+    python3-sphinx \
     PyYAML \
     rdma-core-devel \
     SDL2-devel \
-- 
2.20.1


