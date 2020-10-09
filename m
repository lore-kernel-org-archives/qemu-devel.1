Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2588C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:56:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3A122251
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UMTRXZni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3A122251
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvgm-0000F4-9r
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvJI-0000BZ-5t
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:32:00 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:34626)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvJG-00059o-9q
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:31:59 -0400
Received: by mail-wm1-x330.google.com with SMTP id l15so9325270wmh.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Vw8FtkbtTEObTeK+pxZFlR23uufEuCQrBlYw/T1QDlM=;
 b=UMTRXZniPLeneNkF7dNw5klBsvulV3SHhucio00iioii544P+GUdEdBhsTuLm7ZjEr
 mdfFdeaniFj3PVkc04dPvGJWtidcB3+RZN/MPuO8QeUitDgiLW9Pdzm5O0mgIc0h4H/t
 OEyOYdai2Ey4RZRU9g9bNLtlGehDeS1B5YSDV3A6hl8LJU/g6UElByHIGLnquo2cu9YA
 2aoQ7XCP9gy8S5WxH9Xy435xGScPu2/ICk/2ibyUKStDvSFVd3KQj3XApz+9WiS7DP+z
 AmcwssJvWJ9pOhupvyiubbkZG1hvwFipw0FWGkqtBLYaEBxC0fYyx1tRQkEp5imxlxjx
 OzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Vw8FtkbtTEObTeK+pxZFlR23uufEuCQrBlYw/T1QDlM=;
 b=QRC/igVySKRzH/N/ofuNzqvv1aqmugMYqQtjjqN9BlHLaR/ZSGvyEsrHEnPCizhBVv
 pU8o3OWpP6Ay6goDrM04PbroK1RhBD1lf/McWPiUgPk31OJTsL+atyJDyR0HpN0wX3A/
 kxykEaJsB+XUdh0BgrDCw8OmQ+wg6ULPswgFUVOh927CDFhGnZiyqcUY/GzwbItJsWrK
 F8jSmnSm5Zg468eB4mThdok5UgjEM8inL2/iSkXZEdy8GD2c2hVRN276xaD230/zW0YI
 HmeL9eJ04avK4yBdAlBGbeqoOguZTK1oYjUq5lIVksos9oZZGMjHYK+lqFiLjmQJpDRt
 C7Nw==
X-Gm-Message-State: AOAM533IApE/fZPbJO43t4mROCGhm6EHxrmJgbJ8C6M4DwMok5CDL089
 gtn1PWJnU9+fiGZF4rindWuRMA==
X-Google-Smtp-Source: ABdhPJyGBr4Pdh7FWYdj0QaPSh+lgCCgTlFwEH/WpQY0Fmfd9lWi1Q/cpBhYl7WiGttbi2V80mruZg==
X-Received: by 2002:a7b:c453:: with SMTP id l19mr14880452wmi.50.1602261116873; 
 Fri, 09 Oct 2020 09:31:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x3sm3214910wmi.45.2020.10.09.09.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 09:31:52 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9FA5B1FF92;
 Fri,  9 Oct 2020 17:31:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 06/22] tests/docker: Add genisoimage to the docker file
Date: Fri,  9 Oct 2020 17:31:31 +0100
Message-Id: <20201009163147.28512-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201009163147.28512-1-alex.bennee@linaro.org>
References: <20201009163147.28512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

genisoimage is needed for running the tests/qtest/cdrom-test qtest.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20201006174347.152040-1-thuth@redhat.com>
Message-Id: <20201007160038.26953-7-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/dockerfiles/centos8.docker
index f435616d6a..0fc2697491 100644
--- a/tests/docker/dockerfiles/centos8.docker
+++ b/tests/docker/dockerfiles/centos8.docker
@@ -8,6 +8,7 @@ ENV PACKAGES \
     dbus-daemon \
     gcc \
     gcc-c++ \
+    genisoimage \
     gettext \
     git \
     glib2-devel \
diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
index d2500dcff1..314c6bae83 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -14,6 +14,7 @@ RUN apt update && \
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
     apt install -y --no-install-recommends \
+        genisoimage \
         libbz2-dev \
         liblzo2-dev \
         libgcrypt20-dev \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index ec783418c8..85c975543d 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -15,6 +15,7 @@ ENV PACKAGES \
     findutils \
     gcc \
     gcc-c++ \
+    genisoimage \
     gettext \
     git \
     glib2-devel \
diff --git a/tests/docker/dockerfiles/ubuntu2004.docker b/tests/docker/dockerfiles/ubuntu2004.docker
index cafe8443fb..f4b9556b9e 100644
--- a/tests/docker/dockerfiles/ubuntu2004.docker
+++ b/tests/docker/dockerfiles/ubuntu2004.docker
@@ -3,6 +3,7 @@ ENV PACKAGES flex bison \
     ccache \
     clang-10\
     gcc \
+    genisoimage \
     gettext \
     git \
     glusterfs-common \
-- 
2.20.1


