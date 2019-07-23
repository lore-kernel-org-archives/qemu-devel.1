Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02F0C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:38:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9248821655
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RVy5HDBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9248821655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpsBg-00069k-Hw
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37801)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hps9c-0005nZ-Fk
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hps9b-0007O2-B7
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:20 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:37964)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hps9b-0007N7-4F
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:19 -0400
Received: by mail-wr1-x433.google.com with SMTP id g17so42618745wrr.5
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 03:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1aB6CS66id195EEgwuQ7Hg3FMvOUuzvHx6tDmNmk8yg=;
 b=RVy5HDBx8clvfTk+OSqIJLjBqNHGrHLwDUU/Z68nry9MeCD6iJvyb6iGDi12MKEHk3
 KgfUUIBzM5wlUKXailBbLSjU1cdJ03NsJSCfg1sWoRpagzihYFI4fm3OcBa5zAqRsMcV
 XxcvTrJaLLVZbOegToBSBnY7VYm0aii2Gxvamp8Tb1vhW6JhbhuR+82BfRrLaZ14JbN9
 rVXKAqPCWzcp5dqCFBR9V3EPjKBo2s8kue/1jCuDFsRcejl1KvyNa2sM8fMFE/w/BwDG
 UxrQotFQRMp9fp4JiLv8wMbKNaEP+FJnQmGWDSXvUlf/Rek7/E1O1lmgKgvPkEZ+Wkcs
 sVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1aB6CS66id195EEgwuQ7Hg3FMvOUuzvHx6tDmNmk8yg=;
 b=gZxFIWXNFgJbs1bjwib0u9DTAT81Rr89eQc0VD9yabxiMXkwcSByUstcTqfEbITHLr
 4eliNmN+0rqlcBnARZixXu391ImIIDTmwIMcKduFinhDzbPJdfs8N5YvfhFTWfl52pCw
 E0mIbLio5EH/UFsRva4wobaK72P6vCv4I1VmWthFjt0RcKxwkw7uFmrZsaSZL7YMakpq
 jPudt3il0Iwuk770CMJtNQep4S5oFmNCDKq88NiCk4ZDkLmMkf+kRhXZWPdVv/L8yl8O
 SIyCBJt+C6kwoDGkkq7T2guyTxxVBXW+0+ldgXIiyj3eTeXDeZ0UTHe63QdDcJUA6Bcz
 Z9dA==
X-Gm-Message-State: APjAAAV3Pazzey6+FJR3bAylAYvAmqyEvrDSo2zXzZL7Jz1p2ZyjyTHL
 7Eq1XtV2jCDvq0BsJ4K9rdnKIw==
X-Google-Smtp-Source: APXvYqyNWWVLGgOS6JnGCgT2MBDlwsmt0E5FcuueYkE2IGESKH1xOGxYCwJLWexxq1Mzhxzu+Cx/Yw==
X-Received: by 2002:a5d:56d0:: with SMTP id m16mr77613211wrw.276.1563878178022; 
 Tue, 23 Jul 2019 03:36:18 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id r12sm50472704wrt.95.2019.07.23.03.36.13
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 03:36:14 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C65861FF92;
 Tue, 23 Jul 2019 11:36:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 23 Jul 2019 11:35:54 +0100
Message-Id: <20190723103612.5600-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723103612.5600-1-alex.bennee@linaro.org>
References: <20190723103612.5600-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
Subject: [Qemu-devel] [PULL 05/23] tests/docker: Install Ubuntu images
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
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


