Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8F6C352AB
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB18C222C3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XRYtg5RW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB18C222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDYsT-0008Pa-8V
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 14:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYm3-0002Hz-56
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:45:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYlz-0004vX-E2
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:45:54 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:41794)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDYlz-0004uW-6e
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:45:51 -0400
Received: by mail-wr1-x433.google.com with SMTP id h7so3627872wrw.8
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 11:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+z/2TFSiIsPQhsLoIn7FTSMT/krf74rbncYhReyhJi0=;
 b=XRYtg5RW/vIUpcGzGpyZUJn7S+8soIU7DbuFFuZB9eaNibP0JCqsNQLXZ6FYuFKfeb
 +gcg86lisEgkoTigWyuJkFRcl6lYvu/ALjhgkKAJYMGSDgKyc7ouuIZCZaFKCIRZc/tH
 fqbrVsVZzewIj7br69D9wTEo3sPem4iJDJcwxGpb0jg8+tSYzCOHmI3+RzcTz9zHFejH
 LqxVPp4yRo8RFEOphCsLa4t2J5Wola85VaKDzW6aSXCuFHljyj00JCe55OeeSyykK3sR
 GR37onz34/cdAaBCj1bVnccUJgUrn2QaZj+C1cjsN+ValinuoXT9dC2xPwjXvinQV1HM
 b6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+z/2TFSiIsPQhsLoIn7FTSMT/krf74rbncYhReyhJi0=;
 b=ZDna1Flpa/AXV5rA4QkRcWSLCxDokr6ayzvtcyQtD7rXsXAIuCPP4awkelI5fHO30V
 b3X/35I3SHJhSPl1Rf/Bk6I/5DL4d5Ql+x95+x6032mxWhOosYu+my0gXX0rcMDjLHiZ
 fWzYaOxIPhj5JyTxnk74+kbTa6mej25hFoBSgMtvYtBQLeCa+xTZIu8P24lBYmGw1Dxe
 SuuIgBgRWxx7p3P9Bha4keZwWhmlSFyYlMe0fvtvLBiPXzxTQ6pIxzr1SMa3K7OvpxEA
 iQtwdydgE+/K2Y9ibhRQi+2zuYybZ1R/aHEuD0b/Q4Prk5q1bjhZTHa+/+T5kjWAdX4v
 QfuA==
X-Gm-Message-State: APjAAAWR9lPaDjYx7aSIRTV3w868Jfo/+FGgOV65t+DwAOwZEg0uvyjQ
 /A0Q0nUyAtb/XQ4yvY41e3ESPA==
X-Google-Smtp-Source: APXvYqyi6nCfWPyVFJjH9GQd0q+ckbY2acvHD6mgQAAoCW+JD4g/434CfYufpLSxP/LwW3dFP2wyDA==
X-Received: by 2002:a5d:6ac8:: with SMTP id u8mr4146378wrw.104.1569523549437; 
 Thu, 26 Sep 2019 11:45:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y186sm8522528wmb.41.2019.09.26.11.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 11:45:48 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 999931FFAF;
 Thu, 26 Sep 2019 19:35:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 26/28] docker: remove unused debian-sid
Date: Thu, 26 Sep 2019 19:35:51 +0100
Message-Id: <20190926183553.13895-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926183553.13895-1-alex.bennee@linaro.org>
References: <20190926183553.13895-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

debian-sid is listed as a partial image, so we cannot run tests against it.
Since it isn't used by any other testable image, remove it for now as it
is prone to bitrot.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20190923181140.7235-6-jsnow@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index df73def340..02cd5eeabc 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -5,7 +5,7 @@
 DOCKER_SUFFIX := .docker
 DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
 # we don't run tests on intermediate images (used as base by another image)
-DOCKER_PARTIAL_IMAGES := debian9 debian10 debian-sid
+DOCKER_PARTIAL_IMAGES := debian9 debian10
 DOCKER_PARTIAL_IMAGES += debian9-mxe debian-bootstrap
 DOCKER_IMAGES := $(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker))))
 DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/dockerfiles/debian-sid.docker
deleted file mode 100644
index 2a1bcc33b2..0000000000
--- a/tests/docker/dockerfiles/debian-sid.docker
+++ /dev/null
@@ -1,35 +0,0 @@
-#
-# Debian Sid Base
-#
-# Currently we can build all our guests with cross-compilers in the
-# latest Debian release (Buster). However new compilers will first
-# arrive in Sid. However Sid is a rolling distro which may be broken
-# at any particular time. To try and mitigate this we use Debian's
-# snapshot archive which provides a "stable" view of what state Sid
-# was in.
-#
-
-# This must be earlier than the snapshot date we are aiming for
-FROM debian:sid-20190812-slim
-
- # Use a snapshot known to work (see http://snapshot.debian.org/#Usage)
-ENV DEBIAN_SNAPSHOT_DATE "20190820"
-RUN sed -i "s%^deb \(https\?://\)deb.debian.org/debian/\? \(.*\)%deb [check-valid-until=no] \1snapshot.debian.org/archive/debian/${DEBIAN_SNAPSHOT_DATE} \2%" /etc/apt/sources.list
-
-# Duplicate deb line as deb-src
-RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
-
-# Install common build utilities
-RUN apt update && \
-    DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
-    DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt install -y --no-install-recommends \
-        bison \
-        build-essential \
-        ca-certificates \
-        flex \
-        git \
-        pkg-config \
-        psmisc \
-        python \
-        texinfo || { echo "Failed to build - see debian-sid.docker notes"; exit 1; }
-- 
2.20.1


