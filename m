Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647C8C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:39:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C18CE206E3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eoTBC1h9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18CE206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOJPj-0000Xt-ND
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 07:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJNB-0006op-JM
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:37:15 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:37580)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJN5-0007cD-1B
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:37:11 -0400
Received: by mail-wr1-x42c.google.com with SMTP id z4so1450024wrr.4
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 04:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7YyNvtTVHS9g+3PWjEn5QUsNf/wgonsRE0HWf6d1wVM=;
 b=eoTBC1h9rt7Ad6l7r4VboTu9UOD9D0qSNnLkqlhfgV7+C8mTpjVrnIwN5IEjpMdb02
 KPOOGkrVBHLoFlvecIzeWD3rBVqR1IaUcOdyxZBtmbLiEsKNs75+XetxEzKM2pOp+Tjk
 xAtB6B6aMn2eE6iz3opDG4eC3eLtRIitUU147vOKUFCNnfEL1ag7uVc0NIZHcPLXNYVK
 aFiEvos3IRn0vXjP/X4mu3jzzMIzApgjrY8jA8q+hY/9gRv1HlPoW6Lkb6IhI8oka3Lb
 fuf7lHgVW20RTY3gY7xXmgu/N3dXfQQp1p9MU7+hA7yGvYe8UYC8wlqbwfuFNY3pMrIK
 pVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7YyNvtTVHS9g+3PWjEn5QUsNf/wgonsRE0HWf6d1wVM=;
 b=OnG3wQ3ts0GKLADn8SFee2ciEDILUiw9E8DwPaClXWPD0T79O4TuHxBzHOm3LfG6l0
 gko3+XhoW24kowbjvd/zPydOHrps94wwTzqmSI/xeo77JkIgrKVa4QEF99AaKkW4nSca
 UX5wJgcz9C5ln2Yn8OuAH8KzuTsmXln5D2QOBp8uo+v/m6XOETMZ4UOtJ8hfWqTGzqBR
 Ico/bmOxCY9eHuTaZ93ZgHdHmPjVrefSO2MJECn5ewlAAWl057ZV+IADqy81f9pCdJ08
 sU1jRXtNMLx+LiXPm2zZ6AKcn8RjUzXojsKYKnv1kkcWZi+dKNdpeD+d2J8TYRdhtOns
 au+g==
X-Gm-Message-State: AOAM531p1Goo2Qo+Jg/bvsA6/FjK3jBvCvCBiP01vDlC0w/pkAg+BPVl
 vpKWA0Ult0rLLp0HlxvXQT6Z6g==
X-Google-Smtp-Source: ABdhPJw8TKCy7skG3Easbg5SxxE+pT49SDx1qTozUikt21/9tbVtGaroIheituhGCPK25U+I4KGUHg==
X-Received: by 2002:a5d:554c:: with SMTP id g12mr2553697wrw.294.1601638616051; 
 Fri, 02 Oct 2020 04:36:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s12sm1398060wmd.20.2020.10.02.04.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 04:36:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7BBFA1FF92;
 Fri,  2 Oct 2020 12:36:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 06/14] tests/docker: Use Fedora containers for MinGW
 cross-builds in the gitlab-CI
Date: Fri,  2 Oct 2020 12:36:37 +0100
Message-Id: <20201002113645.17693-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201002113645.17693-1-alex.bennee@linaro.org>
References: <20201002113645.17693-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

According to our support policy, we do not support Debian 9 in QEMU
anymore, and we only support building the Windows binaries with a
very recent version of the MinGW toolchain. So we should not test
the MinGW cross-compilation with Debian 9 anymore, but switch to
something newer like Fedora. To do this, we need a separate Fedora
container for each build that provides the QEMU_CONFIGURE_OPTS
environment variable.
Unfortunately, the MinGW 64-bit compiler seems to be a little bit
slow, so we also have to disable some features like "capstone" in the
build here to make sure that the CI pipelines still finish within a
reasonable amount of time.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200921174320.46062-2-thuth@redhat.com>
Message-Id: <20200925154027.12672-10-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index 8c89efeb6d..15e7b564f9 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -248,6 +248,16 @@ i386-fedora-cross-container:
   variables:
     NAME: fedora-i386-cross
 
+win32-fedora-cross-container:
+  <<: *container_job_definition
+  variables:
+    NAME: fedora-win32-cross
+
+win64-fedora-cross-container:
+  <<: *container_job_definition
+  variables:
+    NAME: fedora-win64-cross
+
 amd64-ubuntu1804-container:
   <<: *container_job_definition
   variables:
diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 4ec7226b5c..510cfec03b 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -105,9 +105,9 @@ cross-s390x-user:
 cross-win32-system:
   <<: *cross_system_build_job_definition
   variables:
-    IMAGE: debian-win32-cross
+    IMAGE: fedora-win32-cross
 
 cross-win64-system:
   <<: *cross_system_build_job_definition
   variables:
-    IMAGE: debian-win64-cross
+    IMAGE: fedora-win64-cross
diff --git a/tests/docker/dockerfiles/fedora-win32-cross.docker b/tests/docker/dockerfiles/fedora-win32-cross.docker
new file mode 100644
index 0000000000..5903e1b0b4
--- /dev/null
+++ b/tests/docker/dockerfiles/fedora-win32-cross.docker
@@ -0,0 +1,42 @@
+FROM fedora:32
+
+# Please keep this list sorted alphabetically
+ENV PACKAGES \
+    bc \
+    bzip2 \
+    diffutils \
+    findutils \
+    gcc \
+    gettext \
+    git \
+    hostname \
+    make \
+    meson \
+    mingw32-bzip2 \
+    mingw32-curl \
+    mingw32-glib2 \
+    mingw32-gmp \
+    mingw32-gnutls \
+    mingw32-gtk3 \
+    mingw32-libjpeg-turbo \
+    mingw32-libpng \
+    mingw32-libtasn1 \
+    mingw32-nettle \
+    mingw32-nsis \
+    mingw32-pixman \
+    mingw32-pkg-config \
+    mingw32-SDL2 \
+    perl \
+    perl-Test-Harness \
+    python3 \
+    python3-PyYAML \
+    python3-setuptools \
+    tar \
+    which
+
+RUN dnf install -y $PACKAGES
+RUN rpm -q $PACKAGES | sort > /packages.txt
+ENV FEATURES mingw
+
+# Specify the cross prefix for this image (see tests/docker/common.rc)
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=i686-w64-mingw32-
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
new file mode 100644
index 0000000000..7f03cd8ffc
--- /dev/null
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -0,0 +1,38 @@
+FROM fedora:32
+
+# Please keep this list sorted alphabetically
+ENV PACKAGES \
+    bc \
+    bzip2 \
+    diffutils \
+    findutils \
+    gcc \
+    gettext \
+    git \
+    hostname \
+    make \
+    meson \
+    mingw64-bzip2 \
+    mingw64-curl \
+    mingw64-glib2 \
+    mingw64-gmp \
+    mingw64-gtk3 \
+    mingw64-libjpeg-turbo \
+    mingw64-libpng \
+    mingw64-libtasn1 \
+    mingw64-pixman \
+    mingw64-pkg-config \
+    perl \
+    perl-Test-Harness \
+    python3 \
+    python3-PyYAML \
+    python3-setuptools \
+    tar \
+    which
+
+RUN dnf install -y $PACKAGES
+RUN rpm -q $PACKAGES | sort > /packages.txt
+ENV FEATURES mingw
+
+# Specify the cross prefix for this image (see tests/docker/common.rc)
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=x86_64-w64-mingw32- --disable-capstone
-- 
2.20.1


