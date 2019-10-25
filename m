Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130EDCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 19:47:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A1D21D7B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 19:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PPLcVwPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A1D21D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO5Yx-0001iO-Dp
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 15:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5Oe-00083O-0k
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5Oc-00035e-Sj
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:15 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:37645)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iO5Oc-00035C-Mk
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:14 -0400
Received: by mail-wm1-x332.google.com with SMTP id q130so3169419wme.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 12:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yblh+Oppt2iwvTtsCKOox3v37OMPEfvHfRdTq2vJFiQ=;
 b=PPLcVwPNg9F9gusYKbcEsitWIwrpltC1yc8VJ0a0pmlFwwLfNb9qVTfCUuXUThHkQY
 cFuvAEtoqdX5Mg/rLEBrHOq80t+HrGQ41y8VbBimnP4vw4cGjN3YwauoD/kY1DZetZgi
 JRGcdz289t2FYlHmj5ZngV9Wjw3rvwAfXA2ydN+671R1azzd/Ntg0jhmwKj9qCe/mfNd
 FtkEjhoUE2Pkg2oiL3gv735Ir5Kgk54j3qPepFsFaxOEI/26ztNRZ4ABBfLW2py4kObp
 oLxfw995nHFlD5KNWnYhL1SazGuF+LJMUm9Hxv5CJEYMDFx8irBHK6gW2fOLVPYFd4Dc
 j8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yblh+Oppt2iwvTtsCKOox3v37OMPEfvHfRdTq2vJFiQ=;
 b=BqruqjG0bxmgKoMFQmdhYOZxpoGh6p0FMmWqHIFrieFlmJQP/7hHWNsFRAlbC78gvM
 Dn8Jp6s0TmQ61OY22zr0/CY5Y+/MYefD4OjO0awF9zgrv+N0yv1dIvtzOKP6J9rDGYjn
 4jq5fHN+z4KaDLdgD6zJHJlyTv3JF5eejV3X2aS9GxKMGw6bRGmh3vt45BVJzxENqv7Q
 lJKz2kpeal2w9OMVZjo3u5lG68wUu9vHxoX+2f0xcV9Hz0bi31rR/1xjOC85JL/W2m42
 J+2C6S6DcmKf8aiIHWSwCCuhqwZzgqdzRTAFn/K3dlkzIkyKQzOCoKkgHuZ/0v+Up0MI
 yZtA==
X-Gm-Message-State: APjAAAVuK/48I9QvobSkxc0Ol7lRVAFxsa62nOSh1rnTD3Hb88ytyfs8
 GZcm9y2Fn6cT9WAWperxWoksCA==
X-Google-Smtp-Source: APXvYqy3gQ0hhYA3ilQQYLhMS2DX7jHzO+BfG+Z081llMzU8ZTma3PD4Z8mMlIY2+35wgcz0M7uaVQ==
X-Received: by 2002:a1c:7e10:: with SMTP id z16mr4740271wmc.11.1572032233542; 
 Fri, 25 Oct 2019 12:37:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k3sm3033702wro.77.2019.10.25.12.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 12:37:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CEEEF1FF91;
 Fri, 25 Oct 2019 20:37:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v3 04/15] travis.yml: Use newer version of libgnutls and libpng
Date: Fri, 25 Oct 2019 20:36:58 +0100
Message-Id: <20191025193709.28783-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025193709.28783-1-alex.bennee@linaro.org>
References: <20191025193709.28783-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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

libgnutls-dev and libpng12-dev are not available in newer versions
of Ubuntu anymore, so installing these packages fails e.g. in the
new arm64 containers on Travis. Let's use newer versions of these
packages by default instead. (The old versions still get tested in
the "gcc-9" build).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191009170701.14756-4-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index b446e04e8ae..e65e53f3d7e 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -29,7 +29,7 @@ addons:
       - libcap-dev
       - libcap-ng-dev
       - libgcc-4.8-dev
-      - libgnutls-dev
+      - libgnutls28-dev
       - libgtk-3-dev
       - libiscsi-dev
       - liblttng-ust-dev
@@ -37,7 +37,7 @@ addons:
       - libnfs-dev
       - libnss3-dev
       - libpixman-1-dev
-      - libpng12-dev
+      - libpng-dev
       - librados-dev
       - libsdl2-dev
       - libsdl2-image-dev
-- 
2.20.1


