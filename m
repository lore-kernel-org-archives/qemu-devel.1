Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E141C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 16:49:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EA8B20B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 16:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qs2+rZTW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA8B20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVHIW-0001iq-6d
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 12:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVH1p-0006TZ-Q4
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 12:31:57 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:35883)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVH1j-0005Zg-Kj
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 12:31:56 -0400
Received: by mail-wr1-x432.google.com with SMTP id x7so3866117wrl.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 09:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lv4v4zlzR8QidECUdhB6cFe3aFKAbs5ejTx2hQvhsq4=;
 b=qs2+rZTWpAmK5XzFxv4CkPF3kktEOrMHTxgI3ERon13JT7/uf8Go/01qqwoWtIfBh5
 O8KIX2mM3tBvcSgHteyk2NKhMTV1k6j7eWhmV9ircdXcnBylPbz3cWoeRMHgqbnqApAt
 xs4ZIKqbaJv92CMWbOevXRucCTLhps7i1jYtZJaPBizdJ5txRHJKHbZUsxMDVVBYU2od
 PtgL2FN+osqAFURP0Q19cWkeDJ6xgHW6ffztPcjdeXHKDI4av0JtaUknWxlfYZOpuJAl
 Chl9bXJ904uVSEhxYi+KgHh/DCqmcZZy9cgJwRMw5s1rPsok0uZHSkwP31pLAvBCPND7
 2aHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lv4v4zlzR8QidECUdhB6cFe3aFKAbs5ejTx2hQvhsq4=;
 b=p59iN26KQK2uqce9uKM5mDDPJJIoR0iWqnwG7iWMUNWz31Y/4orcEO9PBgdbTtc6ZY
 2cbkz+a39xOkpCQ8Bf3qkrhAYI2pa1AqzaN3fPYBfgkFK8HzI1yGMMs8hKsyOymQnTS8
 CBiprcDooRGiPEWin3uAIkO4hEGqQ6hTuzYFY1dXM9irPoVrb0mP4g6AmrthKfQgAjA1
 peQQMCEDuE0R8/5XnzE2WgbP+84nNlnD+qsJvGBYi0pXk8/TSNl+0tuMAiU/gjxsO71o
 +5QktQM/J5PlqFJKQIfOfi29hfHYntdvycB4gk5qZnYJdh1/MkXknKot8xrx+7As+ose
 VQcw==
X-Gm-Message-State: AOAM5323wK6FbgRqpckMx/w6xEQnkEoRGUsAtJByWHucBsC5O4nJHHmn
 ommjXQjcgXCyq5dmvlWHetyr3A==
X-Google-Smtp-Source: ABdhPJzOZ3vY8J/bK1jM2nPuiuOa9z4CD1g33pk46WHXaYZ8qrbWPzmbWw1Yh38KalgJwIlED7u9fQ==
X-Received: by 2002:a5d:5086:: with SMTP id a6mr5674540wrt.283.1603297905883; 
 Wed, 21 Oct 2020 09:31:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p9sm4132354wmm.4.2020.10.21.09.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 09:31:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1F8561FF8F;
 Wed, 21 Oct 2020 17:31:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 3/6] tests/docker/dockerfiles/centos: Use SDL2 instead of
 SDL1
Date: Wed, 21 Oct 2020 17:31:33 +0100
Message-Id: <20201021163136.27324-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201021163136.27324-1-alex.bennee@linaro.org>
References: <20201021163136.27324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

We do not support SDL1 in QEMU anymore. Use SDL2 instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20201021072308.9224-1-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/centos7.docker | 2 +-
 tests/docker/dockerfiles/centos8.docker | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerfiles/centos7.docker
index 8b273725ee..6f11af1989 100644
--- a/tests/docker/dockerfiles/centos7.docker
+++ b/tests/docker/dockerfiles/centos7.docker
@@ -31,7 +31,7 @@ ENV PACKAGES \
     perl-Test-Harness \
     pixman-devel \
     python3 \
-    SDL-devel \
+    SDL2-devel \
     spice-glib-devel \
     spice-server-devel \
     tar \
diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/dockerfiles/centos8.docker
index 585dfad9be..f86931f955 100644
--- a/tests/docker/dockerfiles/centos8.docker
+++ b/tests/docker/dockerfiles/centos8.docker
@@ -2,7 +2,7 @@ FROM centos:8.1.1911
 
 RUN dnf -y update
 ENV PACKAGES \
-    SDL-devel \
+    SDL2-devel \
     bzip2 \
     bzip2-devel \
     dbus-daemon \
-- 
2.20.1


