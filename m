Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA96C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:47:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7633A206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dEWS0JYT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7633A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOJXN-00007c-LU
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 07:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJNJ-0006vr-FJ
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:37:22 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:50715)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJND-0007cU-Bl
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:37:21 -0400
Received: by mail-wm1-x32e.google.com with SMTP id 13so1340571wmf.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 04:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tRNZoVlCJ2ZAw3qHytXOnl+zX212N4XcvNhpj7RoDvU=;
 b=dEWS0JYTNmz1WSY/fE29LV2xBloH+YfQxSKpWHw9lnSeylu8NtQmaeaPGjj2Ur9UA+
 F5JArGdvhQb4QjhZOvL59iHNmquCCj7VTNeXiRPVU+ggj1fm7RYA3MW/nAXznPgTFcQP
 YM1U+Ig6x25vgJQi6tdfOF95sEQgpnm7bSfSp8n1x4RnafE9ulRvmLsKpY8RGScI8o0F
 YF5ODnwCLjTCU9jNGcEYlfnQlzf4jiL5/RlaD94VMhlYH/+g0nqUsQXuIH90d/Y+WQ0p
 0uA0GhTjIfkdusqBYm2a5EXWeXr1fiD+d1Qnr1jMfHkiakQby16LtR1AAZsNPse9vUWW
 9aeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tRNZoVlCJ2ZAw3qHytXOnl+zX212N4XcvNhpj7RoDvU=;
 b=Zu2vQMm9aK4H/wBTXiWNxL2CPYDGRUAFqWS2Q+/ZmFhoCrPTl6gFA6tOqO1kWIPJhw
 t9HywOFQnkER3cZfX8/eSj3h3zBGKjhAKx9iH29Tw20JneiXVRVxYcWlhk5W+qsJ/iZK
 WwBaH6fODXttxPGTz0tgPqrHuo8XaSqfsYEJ2bJc93IGvtjFWwmXtsuZyyq72KJXB33r
 zT6uZep43eeT+Y0B2ViHIpb/vEdrcI3TWMGprCqPXmA1WfspSztUlypBsWXH0dZdpPJZ
 WN54Vf/ileEgSDWO1bfMpNnAoS6+Cma9EkMs51wWO1YMqn1rgNrMhLlr7ZvvNX8blfiD
 fEIw==
X-Gm-Message-State: AOAM530G3iYdzMJeRTuOKih73C9ksFDVGrpTw+u8UKE2NJpFQuR8wwa8
 +MQ9keFLPn+J+cyxpTmSyiNsOg==
X-Google-Smtp-Source: ABdhPJwWu/OinZjXY0P200PupH+NBhXeGWvz7C/xI/n56N5LwuIEyiB7JewDyR2rMoXWXhoLT2kNpg==
X-Received: by 2002:a1c:f407:: with SMTP id z7mr2426712wma.110.1601638618400; 
 Fri, 02 Oct 2020 04:36:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z203sm1558094wmg.17.2020.10.02.04.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 04:36:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 92D6C1FF93;
 Fri,  2 Oct 2020 12:36:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 07/14] gitlab-ci: Remove the Debian9-based containers and
 containers-layer3
Date: Fri,  2 Oct 2020 12:36:38 +0100
Message-Id: <20201002113645.17693-8-alex.bennee@linaro.org>
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

According to our support policy, Debian 9 is not supported by the
QEMU project anymore. Since we now switched the MinGW cross-compiler
builds to Fedora, we do not need these Debian9-based containers
in the gitlab-CI anymore, and can now also get rid of the "layer3"
container build stage this way.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200921174320.46062-3-thuth@redhat.com>
Message-Id: <20200925154027.12672-11-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index 15e7b564f9..6769eef0ff 100644
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
index a18e18b57e..c265e7f8ab 100644
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


