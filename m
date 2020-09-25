Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E69DC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:04:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A3E22B2D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C8Ilginx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A3E22B2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqCt-0008Ji-2A
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLpqB-0002yH-Gh
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:40:55 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:41000)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLpq5-0007eb-8u
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:40:55 -0400
Received: by mail-wr1-x42d.google.com with SMTP id w5so4063727wrp.8
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 08:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9nPyMT1X5QmnyF+DhIV8Y2gJFsLW/DPqQWHOVMTnoaA=;
 b=C8IlginxXjUunqjy6NE2/BOeWdP8hOrx0pxC4WrMWeQTiKp5ZcIZRzfhguwPLR+Czm
 EmaLlR30VokM+edUTHM3MbHwGY8OdyluheB2PiXFZ4Q/7bKroEkMEnQpIzXuenZSM0eE
 VfpaCjdfRSXa3w08Z0WYouWWIV3960cyqPRNnMI1sTM0RP4454ZH8CFXY1DTm0M6YcN3
 45qGVscMRYEL8aS+SiWAKiEevCsc9jL0JTRKgrTCYNw96LhV8Vf1YsO0WHrS6iehKkMs
 2/PFeiwAW2uphKMBckddTtyK0iNwdPw6f4cZJkf/GNlfXsPRGWIV6oCCSLdQQKe4nIqL
 GrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9nPyMT1X5QmnyF+DhIV8Y2gJFsLW/DPqQWHOVMTnoaA=;
 b=BTv8VTnAmEkg7+8eNOV2ejdrg9Zp2bFniXe9n36rRvplsjLjbRmoh9IyCmUA8E8F+6
 bWyqQYDgpQ/w5qtvnY1BtgSr1fd3qPaGNoQulzukNLbsjJ4FjXSr105BiLJBtIWYN/Ro
 b+kQ5ja8ClTP2nJ/Pns3kefruGfV+ioaxlh02/WPAXLJzzpQpE7jgv+7k5mJteijasRr
 acXnDkTa/neBZpgprpurDkip1LnQE0jLMo42dWkc9XWSpDKfsT1o7Z6C6GdELyjthzZD
 91p9DSUsBVpJj15XF6c+7BmGgbG7vIQgGkstfASswHBaeTQTqVTAwTL2MohiepkdEniK
 eq6g==
X-Gm-Message-State: AOAM531Yf9xXXx3lnfSQRwxCDXCfS+bFrmmWqJHlSc2ilzZtIDrTRAFP
 AboV6A2Up0xMNxdAl/xCjNlnMQ==
X-Google-Smtp-Source: ABdhPJzFkFhSI9n+Mskmz3dUbGSUs2z0+z2WCh1jXRnXNb2f5wfiJfk6dIrRCwg4XoWvHPWTt5QVQA==
X-Received: by 2002:adf:ab54:: with SMTP id r20mr1672274wrc.293.1601048447687; 
 Fri, 25 Sep 2020 08:40:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s17sm3524196wrr.40.2020.09.25.08.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 08:40:37 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 076601FF9A;
 Fri, 25 Sep 2020 16:40:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 11/15] tests/docker: Update the tricore container to debian
 10
Date: Fri, 25 Sep 2020 16:40:23 +0100
Message-Id: <20200925154027.12672-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925154027.12672-1-alex.bennee@linaro.org>
References: <20200925154027.12672-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

We do not support Debian 9 anymore, thus update the Tricore container
to Debian 10 now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200921174320.46062-4-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .gitlab-ci.d/containers.yml                          | 2 +-
 tests/docker/Makefile.include                        | 2 +-
 tests/docker/dockerfiles/debian-tricore-cross.docker | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index 6769eef0ff0d..089cea7c14c1 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -210,7 +210,7 @@ sparc64-debian-cross-container:
 tricore-debian-cross-container:
   <<: *container_job_definition
   stage: containers-layer2
-  needs: ['amd64-debian9-container']
+  needs: ['amd64-debian10-container']
   variables:
     NAME: debian-tricore-cross
 
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 75704268ff0a..02ec92830b83 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -137,7 +137,7 @@ docker-image-debian-sparc64-cross: docker-image-debian10
 docker-image-travis: NOUSER=1
 
 # Specialist build images, sometimes very limited tools
-docker-image-debian-tricore-cross: docker-image-debian9
+docker-image-debian-tricore-cross: docker-image-debian10
 docker-image-debian-all-test-cross: docker-image-debian10
 docker-image-debian-arm64-test-cross: docker-image-debian11
 
diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
index 769d95c77bb2..985925134c67 100644
--- a/tests/docker/dockerfiles/debian-tricore-cross.docker
+++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
@@ -7,7 +7,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
-FROM qemu/debian9
+FROM qemu/debian10
 
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
-- 
2.20.1


