Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54999C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:44:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 208A7208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="POiI6Lg0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208A7208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnkED-0006zZ-P1
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 09:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55340)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkDf-00054i-Bl
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkDd-0004V2-65
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:43 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:34490)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hnkDc-0004UJ-VU
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:41 -0400
Received: by mail-wm1-x336.google.com with SMTP id w9so19215547wmd.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 06:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eRmhgYLbm6ZQVE/5wpa9qXZLrenpDvE0swt2uYBp4H4=;
 b=POiI6Lg08KhR63jgO8j8bxe7rhL56Iwz9Gop07AaFbdgsyUYtma2axQoeP6P53YFsZ
 kSXhDWgzRCt579Qu7q9+0iFghvjWTUQ6er9RRsoV65YNWMmGgNEX/5Mdkp9PfudPMk2w
 91XcOY2OM9fZGwCEWRzjxBO2oLvZ+qMwcIPfrV4SdG/45oGlNY3UA+7qhvuqeKknqTtt
 LUwsHcBBu2QWNYj7ltUmv1AWzxSbiM4JKhKRL9fdV5J7WjqYhDQib7BQ/7oLpsyrtmRg
 q+Kk/7TVFLYXIcvB9ej8xKaK3ybVPSAQRBoogXeXWv6Q0tzlxjHs3a0JYbmHqgYI3dnl
 hJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eRmhgYLbm6ZQVE/5wpa9qXZLrenpDvE0swt2uYBp4H4=;
 b=VUBFShz3P1+1YJPZJNajT+UOX/MAaCnNQY7epl0y3BsnzNqJoPPnURXCsEFyDlATLz
 GVmyTJ4alt43Q54mbVVJ9W8UVDGDbMuTkMjwuIOwam51OHAumY83o6prrv9R1C9nlRFi
 RTl9vCxBJ8G4n9sWQcf6JkeLDwS0/x6Gl9SuzA0C4y4mrGpi9DVzPPswNMzQJMKRWkYM
 G4+27Qhfs4+mBDDDmeKbO796R5PyX+YWkADRNR7sjv+e7Af4tpPVd1zTOJWJ+mDom7nz
 7JfEpEjL2WjqtzNs2QDoTysCp7ILmGPZVUc5DcweymkfV7QY7JFrdKNGtkKlRbHES/xn
 DbmA==
X-Gm-Message-State: APjAAAUoHS3VMyGxgCah9nqmCHJykrYRD/2XjSNpBE8VzzkKYpuCnKuL
 tqQ6PFkipkT2j65JnOQc2e0W5A==
X-Google-Smtp-Source: APXvYqzdHAh7KvMHF3UsYhkcA+4fACDLFPYVxfsYcI2FgDTK7LG7JPKHgj5jc3LecengsIH8tnxeYA==
X-Received: by 2002:a7b:c313:: with SMTP id k19mr35434413wmj.2.1563371019739; 
 Wed, 17 Jul 2019 06:43:39 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id s10sm18954123wrt.49.2019.07.17.06.43.36
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 06:43:37 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 38EA11FF91;
 Wed, 17 Jul 2019 14:43:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 14:43:16 +0100
Message-Id: <20190717134335.15351-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717134335.15351-1-alex.bennee@linaro.org>
References: <20190717134335.15351-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
Subject: [Qemu-devel] [PATCH v2 04/23] tests/docker: Install Sphinx in the
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
[AJB: also add /usr/libexec/python3-sphinx/ to PATH]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/fedora.docker | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 619d1b5656d..2350d494d9a 100644
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
@@ -95,4 +96,5 @@ ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3
 
 RUN dnf install -y $PACKAGES
 RUN rpm -q $PACKAGES | sort > /packages.txt
+ENV PATH $PATH:/usr/libexec/python3-sphinx/
 ENV FEATURES mingw clang pyyaml asan
-- 
2.20.1


