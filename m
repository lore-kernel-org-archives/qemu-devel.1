Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B524C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:31:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEBE6207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jy6b2Sgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEBE6207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jot8J-0000dM-6w
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 14:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jot0C-0003hX-Su
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:23:04 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:42292)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jot0B-00056c-1o
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:23:04 -0400
Received: by mail-wr1-x42a.google.com with SMTP id o11so10368171wrv.9
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 11:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZwuOstmGcuTAVE1dTjCYiOJLUEzogyRARo4KTgzkFM4=;
 b=Jy6b2SgygRiD3sXuXzp2DdpHNu+1Le3Rj2MHmuOpCLeZwtMkj434/Q4fINXJ66wv8a
 dxJZg2/g6L8tNBMR2ztnk5iJwJKx2gPNc+8Frnwh4YY+8G7o85798yAZRcHoRz93nKXB
 W2GmxoaIiKKvioqPc5Sh720GJQW8BnIryCvrsY4NNKgzhoP3WYY+XNDTLmq38u4bGwS+
 Lm9v+2BY0XqM3rAK1cdbl3cg7f49RQEHS7uSPUaT4KIT+8mMk6om5H/D1ffYcKrE1X7x
 pZaKKChIHAbR5aQ5yhShAWTP2ecR+wFkig+pxFD9LjggqSXzxFtumWAwaMRXQFzQ7VqH
 bgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZwuOstmGcuTAVE1dTjCYiOJLUEzogyRARo4KTgzkFM4=;
 b=t2QsV17YsgLfAUnKVyihAg0J1hyLzIr7vZOb3XilHhfQJosGm6KSPYVM70SkeSCF2D
 Mi9LDeFAICboL8HaqUYN4FLBqW7e5mZn0EhAu3V3ch5NuCE098RDeczmQi6tNKdGTspP
 B/h2J/Zbtx81dTgWf0zhGfACojNcvJMwBWo6wY5qmPJeVT6X6jf1iEguHnpxwLANUJO5
 /pagC0a+xQxpUf+ZBPJyTtMgrFlIa86aVvKZ7nKYGBwBm/IGlS+4BSTYolNTtMmxmVfG
 E9DM0j5XSudMkvgkvoPuZV9QyMtM5VPOMgz4ZNrzalkxUr5mcV0Wn6jtQwHWng6DR6nO
 Mwow==
X-Gm-Message-State: AOAM531PXliLp8wo9UNzQq1K7UeIlOfMLHX5E9UrkUoMA4wEFvTgA8t8
 jNztUERPCyHck5cgE8KMU35/sw==
X-Google-Smtp-Source: ABdhPJwmJBwGXwBgFz0x12x5cZJG8iujq0pLmQee9Dil7UOtt/Xih4TCDQRJ1vKE3h5mybAOtVj0cg==
X-Received: by 2002:adf:f2c5:: with SMTP id d5mr5195462wrp.96.1593195781484;
 Fri, 26 Jun 2020 11:23:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v4sm23691721wro.26.2020.06.26.11.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 11:22:57 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AA06E1FFAA;
 Fri, 26 Jun 2020 19:14:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 23/30] tests/docker: add packages needed for
 check-acceptance
Date: Fri, 26 Jun 2020 19:13:50 +0100
Message-Id: <20200626181357.26211-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626181357.26211-1-alex.bennee@linaro.org>
References: <20200626181357.26211-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need additional python packages to run check-acceptance. Add them
to the docker images we will be using later.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/fedora.docker     |  7 +++++++
 tests/docker/dockerfiles/ubuntu2004.docker | 10 +++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 798ddd2c3e0..70b6186bd3e 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -80,7 +80,12 @@ ENV PACKAGES \
     pixman-devel \
     python3 \
     python3-PyYAML \
+    python3-numpy \
+    python3-opencv \
+    python3-pillow \
+    python3-pip \
     python3-sphinx \
+    python3-virtualenv \
     rdma-core-devel \
     SDL2-devel \
     snappy-devel \
@@ -89,6 +94,8 @@ ENV PACKAGES \
     systemd-devel \
     systemtap-sdt-devel \
     tar \
+    tesseract \
+    tesseract-langpack-eng \
     texinfo \
     usbredir-devel \
     virglrenderer-devel \
diff --git a/tests/docker/dockerfiles/ubuntu2004.docker b/tests/docker/dockerfiles/ubuntu2004.docker
index 6050ce7e8a8..f7aac840bf8 100644
--- a/tests/docker/dockerfiles/ubuntu2004.docker
+++ b/tests/docker/dockerfiles/ubuntu2004.docker
@@ -46,9 +46,17 @@ ENV PACKAGES flex bison \
     libxen-dev \
     libzstd-dev \
     make \
-    python3-yaml \
+    python3-numpy \
+    python3-opencv \
+    python3-pil \
+    python3-pip \
     python3-sphinx \
+    python3-venv \
+    python3-yaml \
+    rpm2cpio \
     sparse \
+    tesseract-ocr \
+    tesseract-ocr-eng \
     texinfo \
     xfslibs-dev\
     vim
-- 
2.20.1


