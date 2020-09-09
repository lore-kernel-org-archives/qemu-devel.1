Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5A4C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:30:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E4842074B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IfrZbKBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4842074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFyJN-0005AR-JV
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 07:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFyGW-0008T3-IV
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:27:52 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:34772)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFyGU-0006Wr-J4
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:27:52 -0400
Received: by mail-wr1-x436.google.com with SMTP id t10so2565455wrv.1
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 04:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xYzK93R335zRMjvSDIkJPyE3RplpCsCBHGGRS+l5Oy8=;
 b=IfrZbKBztv82ehGSAD2BkY50l42f4zqfMvtGe3l6xDQvxvcnr5ZPWU5WOQAvC/hcQl
 cxM2kwP3uCHlc6qLCc72IQYkCMgZHTNE1wdRhnaCLHVRHBhGxS2dXzSAbfkNdtyG8Vah
 KaUUWWcr2kTmYs4kRY30md3x/eHh2td7+JUoFlQtWhIThHjIqiqSIWJEtjnX2sDqoak7
 vkrR5zjf9XYRo5GmqKehUS82Fh0uqxZe11JqATRIuYZFMoj8sYpyE8Q6joO1z/pPRjV+
 cviVXD/Bk5Ul/0kY/YX1nIJl242jcSG3aajqYZ/1EMNZ2bmKI+ronfeEAH3SvHSfFqc3
 IzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xYzK93R335zRMjvSDIkJPyE3RplpCsCBHGGRS+l5Oy8=;
 b=h9yawzNw2N8f3PeLdQn7CxHRpJbV0Z8XFsHghSEBcq+9o6a5bucaNfVLjXVRneDP0F
 6FnIUYi4N7JmFz0WBBuEuhnW31vTvGP91VRbfFT0WamqcggUWeGKzWQaaMTaI9ck6ADk
 o+q+n+MjWYRgaRx4/X9RbBE0AlI2ChcObFcgTQVBWeM31D2aQm0oSUVFYkAolTSOnGyL
 RyP2MkqSOJ+QM4qCWK8dwHNDm0YT+pO6ZnAJWTEVsZIPVuvikaOqEw742Lrw0oZhBKVb
 FXhSxfnN+aFE27t3hBjucfxZqD2uJmLpeAr7ts74on7bmg/POo/NpC/dJrZeRMdfQtQe
 iYZw==
X-Gm-Message-State: AOAM532Vq3UC9CfnrZTU2uSSrmFzSh1kAE5jZCss3CbxO4Y3dqaW/D9G
 BijnGhIvgys8T78X/E4tsynikg==
X-Google-Smtp-Source: ABdhPJyrbGdqC+tD898R79MIWa51+u7QbmCDnGpCjV0kc2rtgo9VbWtNKOAgJZpVcvj/oPDp35L4hw==
X-Received: by 2002:a5d:5106:: with SMTP id s6mr3787392wrt.166.1599650869147; 
 Wed, 09 Sep 2020 04:27:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t4sm3632061wrr.26.2020.09.09.04.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 04:27:45 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 53DDC1FF8F;
 Wed,  9 Sep 2020 12:27:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 03/10] tests/meson.build: fp tests don't need CONFIG_TCG
Date: Wed,  9 Sep 2020 12:27:34 +0100
Message-Id: <20200909112742.25730-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200909112742.25730-1-alex.bennee@linaro.org>
References: <20200909112742.25730-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As the tests build only softfloat.c no actual TCG machinary is neede
to test them (as is evidenced by GCC check-softfloat). Might as well
fix the wording on Travis while at it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200903112107.27367-7-alex.bennee@linaro.org>
---
 .travis.yml       | 2 +-
 tests/meson.build | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 1d0ade0a133..65341634d02 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -138,7 +138,7 @@ jobs:
 
 
     # Just build tools and run minimal unit and softfloat checks
-    - name: "GCC check-softfloat (user)"
+    - name: "GCC check-unit and check-softfloat"
       env:
         - BASE_CONFIG="--enable-tools"
         - CONFIG="--disable-user --disable-system"
diff --git a/tests/meson.build b/tests/meson.build
index 998e4c48f90..dae8a77df14 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -259,8 +259,9 @@ test('decodetree', sh,
      workdir: meson.current_source_dir() / 'decode',
      suite: 'decodetree')
 
+subdir('fp')
+
 if 'CONFIG_TCG' in config_host
-  subdir('fp')
   if 'CONFIG_PLUGIN' in config_host
     subdir('plugin')
   endif
-- 
2.20.1


