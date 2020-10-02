Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2929C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:47:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70FC5206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qMReLWrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FC5206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOJX8-00084O-Ix
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 07:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJNH-0006v6-Kf
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:37:20 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:37939)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJND-0007dO-99
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:37:19 -0400
Received: by mail-wm1-x32e.google.com with SMTP id v12so1398915wmh.3
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 04:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0dqMc2dIL5hZ97S02MWKJh/RSeEx2MHYq6DShfOMcGc=;
 b=qMReLWrEafp5/pKSFXXL2FADdWjdCZo1W/lmxP4OSVwU5D/oZM/I0xUMETe3VnhF/O
 pitbb5dGH05UQnsdrzZzcvTqBthZeHfwNgqC+0faG3RhMLeK/cIq2WpFzL1kTZ/JDVEe
 tjGhYM3Z9fH6m+Ufb2RwVpzQ9EcBG7gc1xoMPnzeIrBq1LbQezWUJTUwAEuyXzgJZ9JU
 UKoTdBC+FZMFtehsZOIU7mZeVGkI23WHYQnj7qN6nTv41vIdzvSlp7GlsxKF+ZCab7eY
 4rROyiBXvkfkbuZAY42rPZBAKPBUFvGE/lhY9nwDFlf5Yv2+bLJ18NnU/4L27LWk7KpN
 4lVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0dqMc2dIL5hZ97S02MWKJh/RSeEx2MHYq6DShfOMcGc=;
 b=rp1/1US9a+8BdvQYPsg6atL9HpzebwlukPJub99dfnIE5RJ8XjQ9DW3Ycs5oRECP9k
 XHWugMVNKw37sfcQFnKDfR1ypS6+Nj7UdQaxxN3q7WG6hViFLNiM3aq8dxdaGZd+K8Ja
 chp2B6pQSAVn84wkF9UdT+zWDvFGrT83sCqQ7y9U23usGgHN77U5AiynozZiu5q1Rn08
 1IBgZQdPky1eS+1fKzoqV9P8GryHTXptx0KgCMre7whopcDJaZecfrMos1spfTMuOpKj
 tDiG3ZWtRTgsWEGnexK3n7O3EgHXyfakLBfNv4zowj3DeJc0GXs0oTeTqPdZVgDaeAuA
 oE0Q==
X-Gm-Message-State: AOAM532loGtrWcGjtPizDTfwh6Re7g3eOsj3jQy6yRGQrAq/9R33C57v
 z2SxmFIE9Y1fnSVqAHUJ9wVMh1lRqNKxmg==
X-Google-Smtp-Source: ABdhPJw5RqlEt9cVVmLnLuJOA0u8qVwUvQWO2h0Xa5wDymriizczOAYUDZkieFEpjd4locTIDQ141g==
X-Received: by 2002:a7b:c92b:: with SMTP id h11mr2393049wml.6.1601638628061;
 Fri, 02 Oct 2020 04:37:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w7sm1438088wmc.43.2020.10.02.04.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 04:37:01 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EED641FF9A;
 Fri,  2 Oct 2020 12:36:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 11/14] gitlab-ci: Increase the timeout for the cross-compiler
 builds
Date: Fri,  2 Oct 2020 12:36:42 +0100
Message-Id: <20201002113645.17693-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201002113645.17693-1-alex.bennee@linaro.org>
References: <20201002113645.17693-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Some of the cross-compiler builds (the mips build and the win64 build
for example) are quite slow and sometimes hit the 1h time limit.
Increase the limit a little bit to make sure that we do not get failures
in the CI runs just because of some few minutes.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200921174320.46062-7-thuth@redhat.com>
Message-Id: <20200925154027.12672-15-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 510cfec03b..03ebfabb3f 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -2,6 +2,7 @@
 .cross_system_build_job_template: &cross_system_build_job_definition
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
+  timeout: 80m
   script:
     - mkdir build
     - cd build
-- 
2.20.1


