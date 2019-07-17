Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D92C76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43BF1208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ArEW43px"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BF1208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnkEs-0001tV-6p
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 09:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55356)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkDf-00057V-W1
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkDd-0004VO-MO
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:43 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:37995)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hnkDd-0004Uk-G4
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:41 -0400
Received: by mail-wm1-x32c.google.com with SMTP id s15so856249wmj.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 06:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S6vlCzd8bs8oUu9Zqj4pZDk3kYEbnE2MFo03V6K4g9k=;
 b=ArEW43pxywcL9yjnRgBtIv5de7eQmLfLmd0j62mEqdnVjE2KBvY6e4i7r8caGaNICv
 gjnGCxmlKYRPj+PtHAFqRXFZIZsfLusiuwIgeGriKOzWViWwN7fnLteCLGKQes+aoko1
 7+HzFRMX9/RILbZJbWOzKRdk3TJK5inKJSLCiwl+OiguT+yydEwQrb9Tu415MfQSHS+P
 KM2qyN1Tl8rYU9krBN+eDJYFDegZsTB7B54xU8Mxx7sfXwogTKv4i8rsDIo24Q5zX6fu
 PZxU6PqhjqdAETkH8dJh6s52OyHuJ4Xhie1NjS4tcBrB4aKc8/6tYkQqAyC1guLj7CHN
 9tmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S6vlCzd8bs8oUu9Zqj4pZDk3kYEbnE2MFo03V6K4g9k=;
 b=KKrSwTtBTxmat7kJKF6cMlsWOj6iBEMxya0Dd6tXl2NWdWHoO34007P/vFbO2+IhpI
 QmUgJd9UM7w727lvkiPMNMaZxqSqEnMdRiXr/DIK/datyr8VojYst2kfgGFiekavugfd
 umCoPBGDz7QiK96vYHvi0RxTP1GSIlSnosEcGs5EdWNn/q7CrWpyywaggMgncvYWaV1+
 Fn7e/Ns6b/j6F6o9pDEhXK9wPbHAQMReR2u0Z1lk1Ttxnw4pstaUNdMVJaIdnZ/kwC8Q
 yP/7btUi/DJAePOXKiyFW2RJmqIPa0nr3lbAFbyPF13Mq5miFSochD7nGvAwKpRVIUGm
 PoQA==
X-Gm-Message-State: APjAAAUqilRE+u9f9gdBehtzwTfao2qFG1YK09HQ83iwTZEZNWjY475/
 1EPNstE0wn2rJEHq3CrxLwl1bQ8vCx4=
X-Google-Smtp-Source: APXvYqyINJgXlQwEoZoov7Gz/MbfaKKgxKbKq7b/mI645kKZGgUcKIvrpK948fthDNHYQSs4+KI5lw==
X-Received: by 2002:a1c:5602:: with SMTP id k2mr34525660wmb.173.1563371020251; 
 Wed, 17 Jul 2019 06:43:40 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id g19sm41640608wrb.52.2019.07.17.06.43.37
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 06:43:37 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4ED6B1FF92;
 Wed, 17 Jul 2019 14:43:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 14:43:17 +0100
Message-Id: <20190717134335.15351-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717134335.15351-1-alex.bennee@linaro.org>
References: <20190717134335.15351-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
Subject: [Qemu-devel] [PATCH v2 05/23] tests/docker: Install Ubuntu images
 noninteractively
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
 Richard Henderson <richard.henderson@linaro.org>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

We correctly use the DEBIAN_FRONTEND environment variable on
the Debian images, but forgot the Ubuntu ones are based on it.

Since building docker images is not interactive, we need to
inform the APT tools about it using the DEBIAN_FRONTEND
environment variable (we already use it on our Debian images).

This fixes:

  $ make docker-image-ubuntu V=1
  [...]
  Setting up tzdata (2019b-0ubuntu0.19.04) ...
  debconf: unable to initialize frontend: Dialog
  debconf: (TERM is not set, so the dialog frontend is not usable.)
  debconf: falling back to frontend: Readline
  Configuring tzdata
  ------------------

  Please select the geographic area in which you live. Subsequent configuration
  questions will narrow this down by presenting a list of cities, representing
  the time zones in which they are located.

    1. Africa      4. Australia  7. Atlantic  10. Pacific  13. Etc
    2. America     5. Arctic     8. Europe    11. SystemV
    3. Antarctica  6. Asia       9. Indian    12. US
  Geographic area: 12
  [HANG]

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190711124805.26476-1-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/ubuntu.docker     | 2 +-
 tests/docker/dockerfiles/ubuntu1804.docker | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
index 2500ec84b6f..a4f601395c8 100644
--- a/tests/docker/dockerfiles/ubuntu.docker
+++ b/tests/docker/dockerfiles/ubuntu.docker
@@ -66,6 +66,6 @@ ENV PACKAGES flex bison \
     texinfo \
     xfslibs-dev
 RUN apt-get update && \
-    apt-get -y install $PACKAGES
+    DEBIAN_FRONTEND=noninteractive apt-get -y install $PACKAGES
 RUN dpkg -l $PACKAGES | sort > /packages.txt
 ENV FEATURES clang pyyaml sdl2
diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/dockerfiles/ubuntu1804.docker
index 0bb8088658d..44bbf0f77ae 100644
--- a/tests/docker/dockerfiles/ubuntu1804.docker
+++ b/tests/docker/dockerfiles/ubuntu1804.docker
@@ -53,6 +53,6 @@ ENV PACKAGES flex bison \
     texinfo \
     xfslibs-dev
 RUN apt-get update && \
-    apt-get -y install $PACKAGES
+    DEBIAN_FRONTEND=noninteractive apt-get -y install $PACKAGES
 RUN dpkg -l $PACKAGES | sort > /packages.txt
 ENV FEATURES clang pyyaml sdl2
-- 
2.20.1


