Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060D6C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B60C221EC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mJcq0Y3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B60C221EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqfF-0002AU-6k
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVk-0006r2-Ov
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:53 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:45578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVd-0006r1-Kc
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:52 -0400
Received: by mail-wr1-x42f.google.com with SMTP id x14so4188972wrl.12
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 09:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b27CB/FmLq2oeiHU/6zkG//hh/Oo3LelbsnNKWwTVM0=;
 b=mJcq0Y3gXrYSpPTPJph+oe7Hk6EcpnrqiXnRYlcQDAqYpWTdWUqyf8eaYjiDfiS1tr
 iYFY+ooUbp9LftEXgBLdM6AU1XTGcPL3AbtC0kvbCZVUxVNDxU9YOhw4xzg+2MLIRdXg
 FjKpscamNXutxB8n1I8MSJb2lClwiPs2t4OM6JNNlZm/Ltjk7rNNr5a9Ko7wBpqtI3da
 yD9lEC18vw5HEx4BRQvimXWHXTxU9ETu1abjtQGbZrqrdxwGjYQuV+R+laBVcDJ95Xcy
 ocv+4VEEV6wgNifJaSvnRQdlWCQTerpMwQn0ZTXkTck5+PF57I8Hx8GVL2aq3cRjZglN
 XZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b27CB/FmLq2oeiHU/6zkG//hh/Oo3LelbsnNKWwTVM0=;
 b=Mw8GVR+Z2DUp8iBroEIAiHe2Fm2GvvdiTXSTWpMj2mUlL7aBhxqm4eWDAiEjBbrM0J
 xPULwn1k//y/FX722JHI4H2757CbQupCiErGrl7vPQHHXt7bvgw1eGPqXCAvt2OzmqVa
 KsdK4EOOjksDMDo1bIgufTOxRQSDDiXJbLBT2qAASgPyB2EWEU3lx0UPvzSFuiWOAf9O
 won1GvcbRhHyWItlZSiplY77Na9ugLka3juWolbQ95MLUiFliPq/4KHB+5N6AiCRJCGi
 k+BXeNNSjZkJejbudZ8x8EwA0QaL5kXLOEddVYyfKT6FJuWfgXRs2sJslQ/x4lsZ8N+c
 sdAw==
X-Gm-Message-State: AOAM533uzCE3HBfy73tapjVtNP9f0HzY6ehL8wU9Gf2l96fbV79uhJhI
 a76mlz5RnRuQ8h7Epo+t4SQreC67JfzD4ume
X-Google-Smtp-Source: ABdhPJzJ8GJ+YKnhZSKrRwC0abwgx3fEXOmgpHP1yt0fqAcywFqiwIJJf56hYB3MWSZzrNk26aeXkg==
X-Received: by 2002:a5d:4744:: with SMTP id o4mr5299974wrs.130.1601051023800; 
 Fri, 25 Sep 2020 09:23:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d6sm3565824wrq.67.2020.09.25.09.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 09:23:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 21/21] Remove texinfo dependency from docker and CI configs
Date: Fri, 25 Sep 2020 17:23:16 +0100
Message-Id: <20200925162316.21205-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925162316.21205-1-peter.maydell@linaro.org>
References: <20200925162316.21205-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need texinfo to build the docs any more, so we can
drop that dependency from our docker and other CI configs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 .travis.yml                                | 1 -
 scripts/coverity-scan/coverity-scan.docker | 1 -
 tests/docker/dockerfiles/debian10.docker   | 1 -
 tests/docker/dockerfiles/fedora.docker     | 1 -
 tests/docker/dockerfiles/ubuntu.docker     | 1 -
 tests/docker/dockerfiles/ubuntu1804.docker | 1 -
 tests/docker/dockerfiles/ubuntu2004.docker | 1 -
 7 files changed, 7 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index c75221dca3e..bd9a6fc06cc 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -192,7 +192,6 @@ jobs:
         apt:
           packages:
             - python3-sphinx
-            - texinfo
             - perl
 
 
diff --git a/scripts/coverity-scan/coverity-scan.docker b/scripts/coverity-scan/coverity-scan.docker
index 018c03de6d5..501ac672332 100644
--- a/scripts/coverity-scan/coverity-scan.docker
+++ b/scripts/coverity-scan/coverity-scan.docker
@@ -110,7 +110,6 @@ ENV PACKAGES \
     systemd-devel \
     systemtap-sdt-devel \
     tar \
-    texinfo \
     usbredir-devel \
     virglrenderer-devel \
     vte291-devel \
diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/dockerfiles/debian10.docker
index e3c11a454ee..1e4188ba225 100644
--- a/tests/docker/dockerfiles/debian10.docker
+++ b/tests/docker/dockerfiles/debian10.docker
@@ -31,7 +31,6 @@ RUN apt update && \
         python3 \
         python3-setuptools \
         python3-sphinx \
-        texinfo \
         $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
 
 ENV FEATURES docs
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 70b6186bd3e..71e4b569770 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -96,7 +96,6 @@ ENV PACKAGES \
     tar \
     tesseract \
     tesseract-langpack-eng \
-    texinfo \
     usbredir-devel \
     virglrenderer-devel \
     vte291-devel \
diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
index 161806e6b8c..b556ed17d29 100644
--- a/tests/docker/dockerfiles/ubuntu.docker
+++ b/tests/docker/dockerfiles/ubuntu.docker
@@ -63,7 +63,6 @@ ENV PACKAGES \
     python3-yaml \
     python3-sphinx \
     sparse \
-    texinfo \
     xfslibs-dev
 RUN apt-get update && \
     DEBIAN_FRONTEND=noninteractive apt-get -y install $PACKAGES
diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/dockerfiles/ubuntu1804.docker
index a10ea2850b6..a6a7617da67 100644
--- a/tests/docker/dockerfiles/ubuntu1804.docker
+++ b/tests/docker/dockerfiles/ubuntu1804.docker
@@ -49,7 +49,6 @@ ENV PACKAGES \
     python3-yaml \
     python3-sphinx \
     sparse \
-    texinfo \
     xfslibs-dev
 RUN apt-get update && \
     DEBIAN_FRONTEND=noninteractive apt-get -y install $PACKAGES
diff --git a/tests/docker/dockerfiles/ubuntu2004.docker b/tests/docker/dockerfiles/ubuntu2004.docker
index 8d10934a2a7..cafe8443fbf 100644
--- a/tests/docker/dockerfiles/ubuntu2004.docker
+++ b/tests/docker/dockerfiles/ubuntu2004.docker
@@ -57,7 +57,6 @@ ENV PACKAGES flex bison \
     sparse \
     tesseract-ocr \
     tesseract-ocr-eng \
-    texinfo \
     xfslibs-dev\
     vim
 RUN apt-get update && \
-- 
2.20.1


