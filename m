Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B992CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08EC320679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fFTSKMhk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08EC320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNaiE-0000cc-KW
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaOx-0000dt-BN
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaOw-0007nn-74
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:31:31 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46743)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNaOv-0007nQ-UD
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:31:30 -0400
Received: by mail-wr1-x444.google.com with SMTP id n15so14668879wrw.13
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 03:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U3W8sIO/2ZBTMPLoFcozYjR2QmMLtyhRSYqqV0DovIY=;
 b=fFTSKMhkI56d1fwFDm9DK7QpOriiwWI025mJidCgT28Mw2dxEqfMFsIYC1lTMP3sNv
 EafbVILZIHmDZVHjhe+b4E1HSwvIUIjA+yScohUIXiXTllDgXgiPFMejGZdfPjmIMGVj
 hnSMCGS4Ls0i3qwV816/p5R0z9X0tFF6LCEWGSLvLxhTFmJi8sivAimceUYg/W+oe1wC
 8FekQ8VISl2wJGAkjaLQ1ff7NTmrTKK8tvrAIG1OT+TTns3BMW1oRKgN6Y+Xmj5Mz3Mf
 tG9TkBqENdoMhhExlxr3ep6om7aUxYw8jK+8+d8O9D2EWMKf+citpCDnHLVbe7WZlmAE
 H2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U3W8sIO/2ZBTMPLoFcozYjR2QmMLtyhRSYqqV0DovIY=;
 b=BxhoPDsRXhWzKvyNbXw5Zmx8KJDINFSdwZsp7rWLnwJuo7rwBpopMe7B0NScpNMef2
 tyhOb+4ryhZsPBoi6IcNLL6ykFQC927YJIUcYEK9m+lCqmr3i6nhaESPXh6eNzO0kEvB
 yuNYp7lKxfWFMq99OPD2u8UjmaKroeY2OIq5AdFLo+ByX4h0cesM82ioa/AblTVLRUhz
 gkxL7Cu8SZlSMbiNCn5j8cGH94i2Xd/TFRlYO6rpH/r0RJBFmi0wYBUTgxffVEu58RvQ
 TK1MEC65MB5DwoSajPVsvGv38UvgPhQjgRjqV9e0jGpwLfcAIx6l9LisP6srNbdZguKO
 LywA==
X-Gm-Message-State: APjAAAXL0uVbnkBE0z96vY8D2xI3tCZD0d9s9k/HkmSGVlRH3UZNl2KV
 nBy4f+O7uPhDdNo8K7ATbUS7Vg==
X-Google-Smtp-Source: APXvYqyV+EjgB2DFHunNqA4wVGmkEgfzxHqiRd4RnMsIttKqy8RGEh+rNxks3t6u1HjWYR68V5LvVg==
X-Received: by 2002:adf:cf11:: with SMTP id o17mr3151322wrj.284.1571913088707; 
 Thu, 24 Oct 2019 03:31:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g5sm2246857wma.43.2019.10.24.03.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 03:31:27 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D98C71FFA5;
 Thu, 24 Oct 2019 11:22:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 17/17] tests/docker: update Travis image to a more current
 version
Date: Thu, 24 Oct 2019 11:22:40 +0100
Message-Id: <20191024102240.2778-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024102240.2778-1-alex.bennee@linaro.org>
References: <20191024102240.2778-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

This isn't the latest one available on hub.docker.com but it does
match the ID reported by the Xenial builds running on Travis:

  instance: ... travis-ci-sardonyx-xenial-1553530528-f909ac5

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/travis.docker | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/dockerfiles/travis.docker
index ea14da29d97..e8eb48dccfd 100644
--- a/tests/docker/dockerfiles/travis.docker
+++ b/tests/docker/dockerfiles/travis.docker
@@ -1,4 +1,8 @@
-FROM travisci/ci-sardonyx:packer-1546978056-2c98a19
+#
+# Travis Image - this is broadly the same image that we run our CI
+# tests on.
+#
+FROM travisci/ci-sardonyx:packer-1552557266-f909ac5
 ENV DEBIAN_FRONTEND noninteractive
 ENV LANG en_US.UTF-8
 ENV LC_ALL en_US.UTF-8
-- 
2.20.1


