Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D104C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07F1D207F9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZGqwHud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F1D207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiblz-0001iR-6l
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 06:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jibeI-0007sI-U1
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:38:30 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:39982)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jibeI-0004Q6-1b
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:38:30 -0400
Received: by mail-wm1-x336.google.com with SMTP id r15so2557975wmh.5
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 03:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TdE0NVqFjv8C+w+EbnPrnutxQ+h9lo6aIv6K+mMS940=;
 b=UZGqwHudciZm8hdnxZHYyLcY7jdL/PpjeSY8+MR7bC2ksVk6MedxdkK48qFxBEXgKe
 vkK4J2eEu5EASVz1B5qipZu06QtPoKGLPGOnNkIwP8T/LMDRitiS32TwtPnfwdS8+P7I
 48UkqXGFbeyc3Akxdw528JLxG+pB4rziCRkQU9fhUoNGbY/8XWN4xkltX0YZoZrJdhIF
 KmQX4AcZu/WOaBhkS8WQ0tWVN03iqeKONYDCCwoHnnUFHW+ur+xVcGQaVzNsr6XDJ/I4
 GvpVwAIq79ZPDs6ZDRnrmZmSDkhjnBDZDZXETtIH6+5HN4oMWHEvW+2XgV/mH6lXGpqX
 IXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TdE0NVqFjv8C+w+EbnPrnutxQ+h9lo6aIv6K+mMS940=;
 b=i1G7GHyYFLZXVHz4xN4X9wuzDz6xrYsozi8FBEHZ1PbSSzkqPcT0Y14kztyTK4QXZK
 edNIIpFxTAZBgWH6Ziqr5JQR5S17T+eXqN/Zuv9zl6ZfhYO+2yw92TE29DECaT8w6h/u
 xPUzSFEXKZ377AFI8fVg6+WRgSsiAfi5lP1DOqUGyuj846nqZHuP1Z1h+eYRsGskE8uB
 hdnGg+r9328aRzBBCC88S6njbQecT/EiPrfmxk2RGTEFnOHbkzFCwuTT0HSneVHf5LZT
 7c+4Qu0cTwGLv9rKN5pBxbQAKIPLQBrZj6GaJDa11GMaTTmFVTwToknAbZUxwcVTCfCc
 A+aQ==
X-Gm-Message-State: AOAM533c9TOjHeL3lVzEdd8PZDYtUNY3gMu4DPApISvm0CIrH7vHbcCw
 2oe9VxXF3wC3T19KqI7zvuX0Mw==
X-Google-Smtp-Source: ABdhPJy5R5RPIffgGt7rbouGzV6mmylcK+77Iea4uB9dv38/DbQPnCgxlFthVn54Y90yhTxg5SKNXQ==
X-Received: by 2002:a1c:66d5:: with SMTP id a204mr3278139wmc.134.1591699108754; 
 Tue, 09 Jun 2020 03:38:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y37sm3238863wrd.55.2020.06.09.03.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 03:38:19 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 106881FF93;
 Tue,  9 Jun 2020 11:38:11 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 07/17] tests/docker: fix pre-requisite for debian-tricore-cross
Date: Tue,  9 Jun 2020 11:37:59 +0100
Message-Id: <20200609103809.23443-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200609103809.23443-1-alex.bennee@linaro.org>
References: <20200609103809.23443-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reported-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200605154929.26910-9-alex.bennee@linaro.org>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index ed46bd98eb5..981b7fcf2a5 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -130,7 +130,7 @@ docker-image-debian-sparc64-cross: docker-image-debian10
 docker-image-travis: NOUSER=1
 
 # Specialist build images, sometimes very limited tools
-docker-image-tricore-cross: docker-image-debian9
+docker-image-debian-tricore-cross: docker-image-debian9
 docker-image-debian-arm64-test-cross: docker-image-debian11
 
 # These images may be good enough for building tests but not for test builds
-- 
2.20.1


