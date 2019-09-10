Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C497C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:13:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B9C1206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZaFJJWY/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9C1206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cD0-00024u-1F
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bqt-0000kw-Rq
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bqs-0000bP-Pr
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:19 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:35701)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bqs-0000aq-Jx
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:18 -0400
Received: by mail-wr1-x435.google.com with SMTP id g7so18462519wrx.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N30EqGlP8UF0mNtNtom+iOG11VwbWKM+BfCDz04Jnc0=;
 b=ZaFJJWY/8Z5l4H453jANPvdy136Vgy993CMDtm5rPp4sUbpAXEwcjvLwbeyDlJmYaT
 QsOFsovl16qbflTl/Vxomd1B9KLm98W99Ic/OfOwn5R3E17KXVn6OxNbIAjwO103YQ68
 nMjv8VDox26YY1MaYO5hrl84MY5SlG+9pwB7piW6MmsRAjb3SdQl7FHGEyvho/DE5uVj
 ljgJfJFwERYLvrSJiW7OtVJmjkfOMnEJiriuiCY+v0My+xGBvTzP3ozTwnVeqctpzbBK
 g9AFD2dGDVV8vztyZgvC8kH4ftatmFb5e2XhT/GNbLwzbQ/Z8HRqCZc+vKnJNxK9aB9o
 D78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N30EqGlP8UF0mNtNtom+iOG11VwbWKM+BfCDz04Jnc0=;
 b=JHrZcWCikqss0dYnAr0Lwi0Isylk24Cp1iXUJTbXAVx0ZwxoP9TjOwpWVhUoBgPpGS
 QVzfL/nQ1cz3kgMYLV/XyHUxLb8qR0UxgjOlvEOdOwDSZx5qgvQGtUCSvKSDWHMDYX/e
 5ZL3BpY2GkCLxPJffemhsgo/i7sERP4MAJFzwOAEKJTNSCIqA6zALjd5O2Ae9ZAq98uf
 kbEhQ2NYSg09774hDBl48235+xS6KHlmj8YwRqG45NQWlL62iG2vqxnptGw9ULdO0SLh
 97QKup/3KRAtWhvZsDTkLMegH5Dp2vyy/fFMbTbvyRdJCvzOyL+1o5lKQdLdoI2sWlcu
 X8iA==
X-Gm-Message-State: APjAAAW6gVnEvEwG46eNh2uiECFTg1oFWRhfpOHhIb4vDFXLWLU0AlEA
 omP9TcQLDWBn70aNjtKrCFIBsA==
X-Google-Smtp-Source: APXvYqwKI8Qe7aMxo7fNtg2TODEZG0rvEB5U1WZE6vcUg1yTO5ykWTCQfv8LZ+dk2szFeBDgn4Y4aQ==
X-Received: by 2002:a05:6000:128e:: with SMTP id
 f14mr5682763wrx.28.1568105417629; 
 Tue, 10 Sep 2019 01:50:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t203sm3237145wmf.42.2019.09.10.01.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:50:14 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 003EA1FFAF;
 Tue, 10 Sep 2019 09:43:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:30 +0100
Message-Id: <20190910084349.28817-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
Subject: [Qemu-devel] [PULL 26/45] tests/docker: add debian-xtensa-cross to
 DEBIAN_PARTIAL_IMAGES
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This should have been marked when the docker recipe was added to
prevent it being used for cross compiling QEMU. Sort the
DEBIAN_PARTIAL_IMAGE list while we are at it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index b06716ff71c..c57b74903e6 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -116,10 +116,15 @@ docker-image-travis: NOUSER=1
 docker-image-tricore-cross: docker-image-debian9
 
 # These images may be good enough for building tests but not for test builds
-DOCKER_PARTIAL_IMAGES += debian-alpha-cross debian-hppa-cross debian-m68k-cross debian-sh4-cross
-DOCKER_PARTIAL_IMAGES += debian-sparc64-cross debian-mips64-cross debian-riscv64-cross
-DOCKER_PARTIAL_IMAGES += debian-tricore-cross debian-powerpc-cross debian-ppc64-cross fedora-i386-cross
-DOCKER_PARTIAL_IMAGES += fedora-cris-cross
+DOCKER_PARTIAL_IMAGES += debian-alpha-cross
+DOCKER_PARTIAL_IMAGES += debian-hppa-cross
+DOCKER_PARTIAL_IMAGES += debian-m68k-cross debian-mips64-cross
+DOCKER_PARTIAL_IMAGES += debian-powerpc-cross debian-ppc64-cross
+DOCKER_PARTIAL_IMAGES += debian-riscv64-cross
+DOCKER_PARTIAL_IMAGES += debian-sh4-cross debian-sparc64-cross
+DOCKER_PARTIAL_IMAGES += debian-tricore-cross
+DOCKER_PARTIAL_IMAGES += debian-xtensa-cross
+DOCKER_PARTIAL_IMAGES += fedora-i386-cross fedora-cris-cross
 
 # Rules for building linux-user powered images
 #
-- 
2.20.1


