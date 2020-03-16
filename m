Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3239BC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF7A120409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RLfnecc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF7A120409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDu1a-0001bU-4b
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRI-0000XH-Mo
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRF-0007uA-Op
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:08 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:55825)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jDtRF-0007lt-83
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:05 -0400
Received: by mail-wm1-x332.google.com with SMTP id 6so18580789wmi.5
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=opP09aUpVqbLeEIEW2//0Q0JIWRT0FGPjndrXn93n2Y=;
 b=RLfnecc9q9W9f/t6YLGjgLi8IE2c+N90x3XNg2h3ASHSWWmq3CA4ldNH//P3LhMywr
 tjvlZwdS8ZRRwDe40QWpm+2/OcqevIm6Nyq8r0BLCBDISHh1QXeYJIKFOdQirWiEipfp
 J16SJ4e5bhrv7fbmOOkGpExN/ufO8J9Llit07o9QzRE2tslkhTLg7jlXzdK3SuHsphYs
 EZ4gGhHo7RmVER0EhJO+uD2kiAplbQWHji/S0KAtBWsYyq0gQtaqt2iDboGCuNS3npvI
 4rmpsp0UWmp/EQtJmJI/vM7YEDyxHxugFPqiKn1QnOQroICuvVkymZ4vmIYOyDXhHAXl
 B+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=opP09aUpVqbLeEIEW2//0Q0JIWRT0FGPjndrXn93n2Y=;
 b=nrZiD8WvC3i0ans8LnOirjE2b91OzQWdxTb1nDTKHQtUrEoOO5OzJjH4vmTousktLc
 8OI3uPaNtlNMH+NspX6jxPRqUaKQvOXmkNLwW/EhWkbggApZeytODzpZyNO03pkQHXqQ
 wv5IaTQ+nT+qNBle0xkRDh6U8fUe+1yiBxffhC12ar/lXGXQVTS2zOgRerqLVoOD1Hm5
 dY5zLuhJPhjm7/MKEnpvrigNY7gUMbovBuAfAEeSah6jGGStZacts8QWJXy4CWv0rYdP
 A81HfQFWt57Hh+XIbwmr3cvaOeCQqL1RWq7er+BjJbLFydBK+Oovytxj/Ks7jOi3slxa
 o/Xg==
X-Gm-Message-State: ANhLgQ1pqpGL9KZsPWIAIFjs/ioR64J5UTekF7tY/EomV6kl8IjchcKj
 PGRaMomifEQZt6w8SN5n6qMlyw==
X-Google-Smtp-Source: ADFU+vuDjDWa+Pbc84MzS/Zdv4r7Q+WA0L6WS1s5qmn7AVlx+9TKlwh7h7ll81SlydcAj9O02Pzurw==
X-Received: by 2002:a1c:7d88:: with SMTP id y130mr163415wmc.5.1584379321751;
 Mon, 16 Mar 2020 10:22:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h10sm799676wrb.24.2020.03.16.10.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 10:21:57 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3CBFE1FF87;
 Mon, 16 Mar 2020 17:21:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 01/28] tests/docker: Install tools to cross-debug and build
 Linux kernels
Date: Mon, 16 Mar 2020 17:21:28 +0000
Message-Id: <20200316172155.971-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316172155.971-1-alex.bennee@linaro.org>
References: <20200316172155.971-1-alex.bennee@linaro.org>
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
 qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

We often run Linux kernels to test QEMU. We sometimes need
to build them manually to use non-default features. We only
miss the tiny 'bc' tool.

The ncurses library is helpful to run 'make menuconfig'.

Finally, gdb-multiarch allow us to debug a TCG guest when its
architecture is different than the host.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200212202738.12986-1-philmd@redhat.com>
---
 tests/docker/dockerfiles/debian10.docker | 3 +++
 tests/docker/dockerfiles/debian9.docker  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/dockerfiles/debian10.docker
index 5de79ae5527..2fcdc406e83 100644
--- a/tests/docker/dockerfiles/debian10.docker
+++ b/tests/docker/dockerfiles/debian10.docker
@@ -17,14 +17,17 @@ RUN apt update && \
     DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
     apt install -y --no-install-recommends \
+        bc \
         bison \
         build-essential \
         ca-certificates \
         clang \
         dbus \
         flex \
+        gdb-multiarch \
         gettext \
         git \
+        libncurses5-dev \
         pkg-config \
         psmisc \
         python3 \
diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/dockerfiles/debian9.docker
index 8cbd742bb5f..92edbbf0f48 100644
--- a/tests/docker/dockerfiles/debian9.docker
+++ b/tests/docker/dockerfiles/debian9.docker
@@ -17,13 +17,16 @@ RUN apt update && \
     DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
     apt install -y --no-install-recommends \
+        bc \
         bison \
         build-essential \
         ca-certificates \
         clang \
         flex \
+        gdb-multiarch \
         gettext \
         git \
+        libncurses5-dev \
         pkg-config \
         psmisc \
         python3 \
-- 
2.20.1


