Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D192C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:12:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E4F320872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZD1lshxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4F320872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCs6s-000446-1d
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 17:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrw3-0002a1-L2
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrw1-0004Vz-Bk
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:23 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:35808)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCrw1-0004UM-2i
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:21 -0400
Received: by mail-wr1-x42a.google.com with SMTP id v8so3623029wrt.2
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 14:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ehrUyxIk/TYD5FBHcYxV5NvPpPuPm/qI3SJa6YtXabo=;
 b=ZD1lshxyFozfKyYn9kFEUZcYXEK3XYNK2+he5rjFHKf7OypyPJwmi7gqAOMXKapsEy
 RaDB678kOZIqPVIgxOZpmjnoS9g/mJ3w0ImZcWJvgRwlr8ejSJ+cdCwHRF2g8zSHaotu
 nPCm37KRh6Or97rVPBh9LVKcyJg+X23RUDlB+08D92ulu4LfEmcZxBcEWaY8vxFy3/y4
 dGNEHGierd12rIBO6JWfNOwmBwGemVYj8HMXV5n9Y1wuSj6MbJJGd81WklqaBamHR7fW
 iBK5NpFVIrzHh5lHyTTLAqtzvKGv0fNhtKkl+5w1zREwaFATh32uLzgA2vyWiSLbn5xD
 rJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ehrUyxIk/TYD5FBHcYxV5NvPpPuPm/qI3SJa6YtXabo=;
 b=Ay/lxIGs/V2Bh/l/YPw9exkxwrXvM6MEEO3BiiY0jcBkT6n04WoXBcViOdoVVA+0RR
 CAzqb8nIuaZZMByD0bK5SSZls0wXZX46Kb+O6Ptn6SnYIvbd4l5FgrXwgOJ9OYF+3uHM
 DtTsZ+T+VrNL44FJkQtclSuwXS69nanYcPYRrixND6JX7n0rS1prCO/sJufHmc6F3PqH
 OCJcFf/qIL7U572WSVVilGwXPPMieaOPRaNHPEuK2SjU6i4dCLi2zIzRkTyR+yvKrKEW
 eBi3gPKoYJlqU084InxYyC6WUExWrbFpTCx8KyVEv6p2bcU3F1b8YpZGPCsvKXuhzkV+
 AP3Q==
X-Gm-Message-State: APjAAAWesNkG7GLe0oCIF2onLIkLF87dBp2Gpo4JINvl95AovPEFdJkc
 h/HWI7NzaAvP+qNiD3iZpGckXQ==
X-Google-Smtp-Source: APXvYqxym9SdfJr3PTGx+g191fi0fieLitQoNcLkOvRnoTBTMrk00PpqcZ9QdtIw3B/QGurIPat6AA==
X-Received: by 2002:a5d:5005:: with SMTP id e5mr4923632wrt.79.1569358879836;
 Tue, 24 Sep 2019 14:01:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v20sm1217020wml.26.2019.09.24.14.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 14:01:15 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F3CD81FF9D;
 Tue, 24 Sep 2019 22:01:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 13/33] tests/docker: fix DOCKER_PARTIAL_IMAGES
Date: Tue, 24 Sep 2019 22:00:46 +0100
Message-Id: <20190924210106.27117-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924210106.27117-1-alex.bennee@linaro.org>
References: <20190924210106.27117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
Cc: Fam Zheng <fam@euphon.net>, jsnow@redhat.com, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Finger trouble in a previous clean-up inadvertently set
DEBIAN_PARTIAL_IMAGES instead of DOCKER_PARTIAL_IMAGES. Also fix the
typo to debian-9-mxe.

Fixes: 44d5a8bf5d2
Signed-off-by: John Snow <jsnow@redhat.com>
[AJB: merged fix from Message-Id: <20190917185537.25417-1-jsnow@redhat.com>]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
---
 tests/docker/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 50a400b573a..3fc7a863e51 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -7,7 +7,7 @@ DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
 DOCKER_DEPRECATED_IMAGES := debian
 # we don't run tests on intermediate images (used as base by another image)
 DOCKER_PARTIAL_IMAGES := debian debian8 debian9 debian10 debian-sid
-DEBIAN_PARTIAL_IMAGES += debian8-mxe debian-9-mxe debian-ports debian-bootstrap
+DOCKER_PARTIAL_IMAGES += debian8-mxe debian9-mxe debian-ports debian-bootstrap
 DOCKER_IMAGES := $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
 DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
 # Use a global constant ccache directory to speed up repetitive builds
-- 
2.20.1


