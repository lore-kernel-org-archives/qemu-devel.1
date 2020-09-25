Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C833C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:08:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 026FC235FD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lBxErtcq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 026FC235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqGN-0004jl-UH
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLpq3-0002vo-NQ
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:40:49 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:40008)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLpq1-0007dy-Q0
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:40:47 -0400
Received: by mail-wm1-x32c.google.com with SMTP id k18so3774653wmj.5
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 08:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WKSNg6dxCEDR+YSvlaoe9ShT7s8QEV1fUXWqUzLTCNA=;
 b=lBxErtcqO/0cldm5pArSsDPO3PLK+xEuwGy2CsJhJwhI6bL+C/TyjEEKGwhksatvfV
 h045P1GjK3dCLq9fkUaes3yyDR/YtDH9mjKcfAPShNZwvFMVjtOnioiTfDNputoTmNnA
 repW+uKEssIC7a5F2RM5s1COGPERYPU9lSB3x3HjXhJiOy4YHq4NmPJfLZCP0b7P/FZF
 fXa7M91cg/OdHNwlZMJHovWiXQc8Y6pfsd8GIi4VqdZ5c7MwU/qs1h8Dea4pUqNbnjO8
 lr6qfr3xXqpyeCLlHGTz+KTvTMiObhLzYDVRaheWUsx6nXBLXHd5QAJB5abkcWc5nit/
 F+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WKSNg6dxCEDR+YSvlaoe9ShT7s8QEV1fUXWqUzLTCNA=;
 b=faYjQ7LdTMxTvAxn6VLKXnCkro4AnmSd/vVNByJf3xz3nebaF8iT/VAcywMPoMbCbP
 kg2KtR/mJdt57XYMmc4Crd7aZnn13oLiT2QANRJpkWw/x1IY/1QV8FjVDWpojP3Y41Pm
 y86yArsH59treq2BJodvyha8lqHA5XnZnIp5Ao3Zdz1LveLNLPXS1So3X3E2j00x0T8A
 j8OsUI/g4s19KYSqNsO1Wrtt/Q+rrbyntWvUzEz43ounczAZnw/X3YpvHJ8+QxUml3HI
 wjSQLB1moqbVYqbl+/ASoQ8cg75Dr4ewFdjxY+yYlbVR2zv2l49SFuvwT0D4L1zoPusa
 NaTg==
X-Gm-Message-State: AOAM530rGEE/gT8na4ucleKOTLM8H1wcGWw4Hc0vcKR4sbCPkXT8e/Bp
 5gP77mArlPQVRgMOHNDKqBXL0X8eZElSzg==
X-Google-Smtp-Source: ABdhPJyOVqNBkJUB+3lboBjNFPMsagYHP59K7YCDBfNq4COAHpoQLyBpz2GM5s0T7hKhkhFDf35Ogw==
X-Received: by 2002:a1c:7c13:: with SMTP id x19mr3899144wmc.45.1601048444423; 
 Fri, 25 Sep 2020 08:40:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p1sm3161957wma.0.2020.09.25.08.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 08:40:37 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CD5A21FF99;
 Fri, 25 Sep 2020 16:40:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 10/15] gitlab-ci: Remove the Debian9-based containers and
 containers-layer3
Date: Fri, 25 Sep 2020 16:40:22 +0100
Message-Id: <20200925154027.12672-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925154027.12672-1-alex.bennee@linaro.org>
References: <20200925154027.12672-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

According to our support policy, Debian 9 is not supported by the
QEMU project anymore. Since we now switched the MinGW cross-compiler
builds to Fedora, we do not need these Debian9-based containers
in the gitlab-CI anymore, and can now also get rid of the "layer3"
container build stage this way.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200921174320.46062-3-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/containers.yml | 14 --------------
 .gitlab-ci.yml              |  1 -
 2 files changed, 15 deletions(-)

diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index 15e7b564f91f..6769eef0ff0d 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -214,20 +214,6 @@ tricore-debian-cross-container:
   variables:
     NAME: debian-tricore-cross
 
-win32-debian-cross-container:
-  <<: *container_job_definition
-  stage: containers-layer3
-  needs: ['amd64-debian9-mxe-container']
-  variables:
-    NAME: debian-win32-cross
-
-win64-debian-cross-container:
-  <<: *container_job_definition
-  stage: containers-layer3
-  needs: ['amd64-debian9-mxe-container']
-  variables:
-    NAME: debian-win64-cross
-
 xtensa-debian-cross-container:
   <<: *container_job_definition
   variables:
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index a18e18b57e54..c265e7f8ab0a 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -4,7 +4,6 @@
 stages:
   - containers
   - containers-layer2
-  - containers-layer3
   - build
   - test
 
-- 
2.20.1


