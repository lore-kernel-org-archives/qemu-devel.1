Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0283C2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:12:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6409F2064A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l5x/H0Fz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6409F2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jORv5-0007m5-ID
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 16:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jORpT-0005zL-QN
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jORpS-0005w7-8Z
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:43 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:50380)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jORpS-0005vX-23
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:42 -0400
Received: by mail-wm1-x330.google.com with SMTP id x25so14524468wmc.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 13:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MKNqRiBPCPZs1Nb8xQ+iMkO9ECJezVjcKyg7f8B8t6U=;
 b=l5x/H0FzNGEL47GRnzCGTQS6UHX8GrWNGh8RgaP/OSqthAsQt7FUL+Hfr1dMv6rWEO
 EZ6+Zc/5uKFNU6G9VKyq7C8cFPZ8SWm8jkjAqU8wLI+/JR02HjKCjLqFN1avOR/W+dAa
 S3gh/De7w+cjua5rPeZloCg0DrNKMKjTnuUStGSaQJTqOuM+e8W4hx7NvHJ9wAnyCXBu
 Bm2aZgY16Kz1RcCv2QTbsDTYt8jvz6szJmH1DjfdlxWLDvOfvcPVtmr+nJunHvDZz+Iq
 ydEEZFe2DjuSsRq2K8cnzdx0EK5gAa0MwggbZRSTT59Jor6eUbK/A6tYu8h7Ph1dF9Zm
 0sNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MKNqRiBPCPZs1Nb8xQ+iMkO9ECJezVjcKyg7f8B8t6U=;
 b=TAQumhpec74LCIGG2g4AWKX9B+dFBzcW8du7CDjRUToJubtPVxB60bhP4h6wvVG2JJ
 A4H1BU58GhBP56STc+CDdAB3p9W2Q+GI6avZxTUq5ibj/BtnsrzQ6MWOvHZK/KQuTmBo
 nOAL+sRkaG10cRxRMVPWf8+VNyi8dPd+CFMrrLApcRK+rH+URnGK+JB7ZoXGPr07xGkC
 FSW8oh5LgYDprQP4h+rQNPGgOrZLjY1aJdrBD/F677LOkdCj9hJwTuZsosfU4rkTeVor
 5+bFdudDlp9APEiP23K14VywEPX5sr2tvWo517I0kmZdKqsna8/ocB2jF/2Jct5KVmyi
 fFQg==
X-Gm-Message-State: AGi0PubNMiYbuohRkz5AYUShKXE3MjJ36g3j4QiqKaXugr7TQNf0Tq2K
 8pJW69oaG7v9iy+TTfDHf0pUYlVHlGg=
X-Google-Smtp-Source: APiQypI6PdXiEd++tF4vra0RNIsWkoKeZbDQmijSGTs4/drkAYyBvMSZWxt6YijeW3YXlN6/s3GuXg==
X-Received: by 2002:a1c:e242:: with SMTP id z63mr1586134wmg.72.1586894800990; 
 Tue, 14 Apr 2020 13:06:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q8sm19482844wmg.22.2020.04.14.13.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 13:06:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 85FC81FF92;
 Tue, 14 Apr 2020 21:06:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/17] tests/docker: add docs FEATURE flag and use for
 test-misc
Date: Tue, 14 Apr 2020 21:06:20 +0100
Message-Id: <20200414200631.12799-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414200631.12799-1-alex.bennee@linaro.org>
References: <20200414200631.12799-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The test-misc docker test fails on a number of images which don't have
the prerequisites to build the docs. Use the FEATURES flag so we can
skip those tests.

As the sphinx test fails to detect whatever feature we need to get
hxtool to work we drop them from debian9 so the windows build doesn't
attempt to build the docs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/docker/dockerfiles/debian10.docker   | 2 ++
 tests/docker/dockerfiles/debian9.docker    | 2 --
 tests/docker/dockerfiles/fedora.docker     | 2 +-
 tests/docker/dockerfiles/travis.docker     | 2 +-
 tests/docker/dockerfiles/ubuntu.docker     | 2 +-
 tests/docker/dockerfiles/ubuntu1804.docker | 2 +-
 tests/docker/test-misc                     | 2 ++
 7 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/dockerfiles/debian10.docker
index 2fcdc406e83..0769700a416 100644
--- a/tests/docker/dockerfiles/debian10.docker
+++ b/tests/docker/dockerfiles/debian10.docker
@@ -34,3 +34,5 @@ RUN apt update && \
         python3-sphinx \
         texinfo \
         $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
+
+ENV FEATURES docs
diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/dockerfiles/debian9.docker
index 92edbbf0f48..08cc970feb1 100644
--- a/tests/docker/dockerfiles/debian9.docker
+++ b/tests/docker/dockerfiles/debian9.docker
@@ -30,6 +30,4 @@ RUN apt update && \
         pkg-config \
         psmisc \
         python3 \
-        python3-sphinx \
-        texinfo \
         $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 4bd2c953af8..179575ecaaa 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -103,4 +103,4 @@ ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3
 RUN dnf install -y $PACKAGES
 RUN rpm -q $PACKAGES | sort > /packages.txt
 ENV PATH $PATH:/usr/libexec/python3-sphinx/
-ENV FEATURES mingw clang pyyaml asan
+ENV FEATURES mingw clang pyyaml asan docs
diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/dockerfiles/travis.docker
index e8eb48dccfd..591282561bc 100644
--- a/tests/docker/dockerfiles/travis.docker
+++ b/tests/docker/dockerfiles/travis.docker
@@ -13,5 +13,5 @@ RUN apt-get -y install device-tree-compiler python3 python3-yaml dh-autoreconf g
 # Travis tools require PhantomJS / Neo4j / Maven accessible
 # in their PATH (QEMU build won't access them).
 ENV PATH /usr/local/phantomjs/bin:/usr/local/phantomjs:/usr/local/neo4j-3.2.7/bin:/usr/local/maven-3.5.2/bin:/usr/local/cmake-3.9.2/bin:/usr/local/clang-5.0.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
-ENV FEATURES clang pyyaml
+ENV FEATURES clang pyyaml docs
 USER travis
diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
index b6c7b41dddd..eeb3b22bf20 100644
--- a/tests/docker/dockerfiles/ubuntu.docker
+++ b/tests/docker/dockerfiles/ubuntu.docker
@@ -68,4 +68,4 @@ ENV PACKAGES flex bison \
 RUN apt-get update && \
     DEBIAN_FRONTEND=noninteractive apt-get -y install $PACKAGES
 RUN dpkg -l $PACKAGES | sort > /packages.txt
-ENV FEATURES clang pyyaml sdl2
+ENV FEATURES clang pyyaml sdl2 docs
diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/dockerfiles/ubuntu1804.docker
index 1efedeef995..f66b06f4cff 100644
--- a/tests/docker/dockerfiles/ubuntu1804.docker
+++ b/tests/docker/dockerfiles/ubuntu1804.docker
@@ -54,7 +54,7 @@ ENV PACKAGES flex bison \
 RUN apt-get update && \
     DEBIAN_FRONTEND=noninteractive apt-get -y install $PACKAGES
 RUN dpkg -l $PACKAGES | sort > /packages.txt
-ENV FEATURES clang pyyaml sdl2
+ENV FEATURES clang pyyaml sdl2 docs
 
 # https://bugs.launchpad.net/qemu/+bug/1838763
 ENV QEMU_CONFIGURE_OPTS --disable-libssh
diff --git a/tests/docker/test-misc b/tests/docker/test-misc
index d480afedca7..cc94a738dd0 100755
--- a/tests/docker/test-misc
+++ b/tests/docker/test-misc
@@ -14,6 +14,8 @@
 
 . common.rc
 
+requires docs
+
 cd "$BUILD_DIR"
 
 # build everything else but QEMU
-- 
2.20.1


