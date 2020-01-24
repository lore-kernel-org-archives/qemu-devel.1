Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23275C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:43:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D41272077C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eBzlVqNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41272077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv5nd-0004uQ-0D
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 15:43:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iv5l2-0008Ey-44
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iv5ky-0006BG-DQ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:48 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44071)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iv5ky-00069t-5I
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:44 -0500
Received: by mail-wr1-x443.google.com with SMTP id q10so3579836wrm.11
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 12:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eXk6xJn5mo+4Umh39vGunW6agp342q8a4C1/5ECe89A=;
 b=eBzlVqNIfhPIWiPsPDH/tyDW8+w/fUKlX2SHSIBO4sRc12FoiqfzG59U9aP8BMYWlp
 ETxSgxtHtXaNI/DqwSRlw0bknCMwD8JslHCGOGaFmeaFUI/6Q1+J2pl5WbkQWxRMsLrL
 TvMfOQKRIgpVGeD8uNGaYEpxEaEcuFnNnDrBDaa0Q3QOICa66/eJKQ2Ek9TTPkidsi5I
 OCMbtUBFB3oJegqP5PsA3+Hei4EswlsuUUvEUAlZi1gveckDJTuV+iQQenNmGw0cA83l
 svkMNKX5G4pcYze1zDcorn+5Bw4Nfd5k8SUpYej9FBr30Tb7yxbprV3I0HP+nR9pJEWR
 245A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eXk6xJn5mo+4Umh39vGunW6agp342q8a4C1/5ECe89A=;
 b=CPI4YZQ4LijmIJLmI8BINyn/NPv0FrH591IKUjkTIX8cgZmA028hLXZ8Q5UZQtpV+I
 3b+W6y/kKaLZAffh+5lu38ikRyXMK08nXJhWGo3b3OO8ae5B5mbI3HZzCfsrAlb7SGP/
 NZCZlBBFRxBiqGivql0fFaLLZqzd6fjwGPmxKAF9nb1YKfmS1xKhVEJw95RvMpcVcnLK
 OTIUZ6qgsick5rF+OF0kB+XxpJuerywR9JnVG5wkQvachon4Y0H5p0E1exfxy9U23u9E
 KxC1fhNV6Q2BpbG37saI/+KGHpQwg28Iv+2utRofHFYzQYUgsVOVMKfRu9J7otXtgRV6
 3WHg==
X-Gm-Message-State: APjAAAV3phLqzlKoDCbidM65YbNIy/Ml9/xAy+LGaiQ8jvfYrwrX/ooo
 2NW08eZgXJnhtmc+VFdLJgok1w==
X-Google-Smtp-Source: APXvYqy2r1o603g2jhX6QXiD5fo/nWmlogLL+OKSHK5k4U9ydUGxslnsmMPH5/+GSQYtFOu2BePtgQ==
X-Received: by 2002:a5d:6441:: with SMTP id d1mr6061800wrw.93.1579898443012;
 Fri, 24 Jan 2020 12:40:43 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n14sm7887239wmi.26.2020.01.24.12.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 12:40:34 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6038E1FF9B;
 Fri, 24 Jan 2020 20:40:27 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 11/13] tests/docker: rename the cross builds
Date: Fri, 24 Jan 2020 20:40:24 +0000
Message-Id: <20200124204026.2107-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124204026.2107-1-alex.bennee@linaro.org>
References: <20200124204026.2107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The fact they are cross builds is known by virtue of where they are in
the system. Simplify the naming to a new scheme:

  $(BASEOS)-$(ARCH)-build-(qemu|tests)

Ultimately we will be able to build again $ARCH with something like:

  make docker-test-build@debian10-arm64-build-qemu

On whatever host architecture we are running on.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .../debian10-alpha-test-build.docker          |  1 +
 ...cker => debian10-alpha-build-tests.docker} |  0
 ...ocker => debian10-amd64-build-qemu.docker} |  0
 ...ocker => debian10-arm64-build-qemu.docker} |  0
 ...ocker => debian10-armel-build-qemu.docker} |  0
 ...ocker => debian10-armhf-build-qemu.docker} |  0
 ...ocker => debian10-hppa-build-tests.docker} |  0
 ...ocker => debian10-m68k-build-tests.docker} |  0
 ...docker => debian10-mips-build-qemu.docker} |  0
 ...ker => debian10-mips64-build-tests.docker} |  0
 ...er => debian10-mips64el-build-qemu.docker} |  0
 ...cker => debian10-mipsel-build-qemu.docker} |  0
 ...er => debian10-powerpc-build-tests.docker} |  0
 ...cker => debian10-ppc64-build-tests.docker} |  0
 ...ker => debian10-ppc64el-build-qemu.docker} |  0
 ...er => debian10-riscv64-build-tests.docker} |  0
 ...ocker => debian10-s390x-build-qemu.docker} |  0
 ...docker => debian10-sh4-build-tests.docker} |  0
 ...er => debian10-sparc64-build-tests.docker} |  0
 ...er => debian9-mxe-win32-build-qemu.docker} |  0
 ...er => debian9-mxe-win64-build-qemu.docker} |  0
 ...ker => debian9-tricore-build-tests.docker} |  0
 ...cker => debian9-xtensa-build-tests.docker} |  0
 ....docker => fedora-cris-build-tests.docker} |  0
 ...s.docker => fedora-i386-build-qemu.docker} |  0
 tests/tcg/configure.sh                        | 38 +++++++++----------
 26 files changed, 20 insertions(+), 19 deletions(-)
 create mode 120000 tests/docker/dockerfiles.aarch64/debian10-alpha-test-build.docker
 rename tests/docker/dockerfiles.cross/{debian-alpha-cross.docker => debian10-alpha-build-tests.docker} (100%)
 rename tests/docker/dockerfiles.cross/{debian-amd64-cross.docker => debian10-amd64-build-qemu.docker} (100%)
 rename tests/docker/dockerfiles.cross/{debian-arm64-cross.docker => debian10-arm64-build-qemu.docker} (100%)
 rename tests/docker/dockerfiles.cross/{debian-armel-cross.docker => debian10-armel-build-qemu.docker} (100%)
 rename tests/docker/dockerfiles.cross/{debian-armhf-cross.docker => debian10-armhf-build-qemu.docker} (100%)
 rename tests/docker/dockerfiles.cross/{debian-hppa-cross.docker => debian10-hppa-build-tests.docker} (100%)
 rename tests/docker/dockerfiles.cross/{debian-m68k-cross.docker => debian10-m68k-build-tests.docker} (100%)
 rename tests/docker/dockerfiles.cross/{debian-mips-cross.docker => debian10-mips-build-qemu.docker} (100%)
 rename tests/docker/dockerfiles.cross/{debian-mips64-cross.docker => debian10-mips64-build-tests.docker} (100%)
 rename tests/docker/dockerfiles.cross/{debian-mips64el-cross.docker => debian10-mips64el-build-qemu.docker} (100%)
 rename tests/docker/dockerfiles.cross/{debian-mipsel-cross.docker => debian10-mipsel-build-qemu.docker} (100%)
 rename tests/docker/dockerfiles.cross/{debian-powerpc-cross.docker => debian10-powerpc-build-tests.docker} (100%)
 rename tests/docker/dockerfiles.cross/{debian-ppc64-cross.docker => debian10-ppc64-build-tests.docker} (100%)
 rename tests/docker/dockerfiles.cross/{debian-ppc64el-cross.docker => debian10-ppc64el-build-qemu.docker} (100%)
 rename tests/docker/dockerfiles.cross/{debian-riscv64-cross.docker => debian10-riscv64-build-tests.docker} (100%)
 rename tests/docker/dockerfiles.cross/{debian-s390x-cross.docker => debian10-s390x-build-qemu.docker} (100%)
 rename tests/docker/dockerfiles.cross/{debian-sh4-cross.docker => debian10-sh4-build-tests.docker} (100%)
 rename tests/docker/dockerfiles.cross/{debian-sparc64-cross.docker => debian10-sparc64-build-tests.docker} (100%)
 rename tests/docker/dockerfiles.cross/{debian-win32-cross.docker => debian9-mxe-win32-build-qemu.docker} (100%)
 rename tests/docker/dockerfiles.cross/{debian-win64-cross.docker => debian9-mxe-win64-build-qemu.docker} (100%)
 rename tests/docker/dockerfiles.cross/{debian-tricore-cross.docker => debian9-tricore-build-tests.docker} (100%)
 rename tests/docker/dockerfiles.cross/{debian-xtensa-cross.docker => debian9-xtensa-build-tests.docker} (100%)
 rename tests/docker/dockerfiles.cross/{fedora-cris-cross.docker => fedora-cris-build-tests.docker} (100%)
 rename tests/docker/dockerfiles.cross/{fedora-i386-cross.docker => fedora-i386-build-qemu.docker} (100%)

diff --git a/tests/docker/dockerfiles.aarch64/debian10-alpha-test-build.docker b/tests/docker/dockerfiles.aarch64/debian10-alpha-test-build.docker
new file mode 120000
index 0000000000..a3f037c624
--- /dev/null
+++ b/tests/docker/dockerfiles.aarch64/debian10-alpha-test-build.docker
@@ -0,0 +1 @@
+../dockerfiles.cross/debian-alpha-cross.docker
\ No newline at end of file
diff --git a/tests/docker/dockerfiles.cross/debian-alpha-cross.docker b/tests/docker/dockerfiles.cross/debian10-alpha-build-tests.docker
similarity index 100%
rename from tests/docker/dockerfiles.cross/debian-alpha-cross.docker
rename to tests/docker/dockerfiles.cross/debian10-alpha-build-tests.docker
diff --git a/tests/docker/dockerfiles.cross/debian-amd64-cross.docker b/tests/docker/dockerfiles.cross/debian10-amd64-build-qemu.docker
similarity index 100%
rename from tests/docker/dockerfiles.cross/debian-amd64-cross.docker
rename to tests/docker/dockerfiles.cross/debian10-amd64-build-qemu.docker
diff --git a/tests/docker/dockerfiles.cross/debian-arm64-cross.docker b/tests/docker/dockerfiles.cross/debian10-arm64-build-qemu.docker
similarity index 100%
rename from tests/docker/dockerfiles.cross/debian-arm64-cross.docker
rename to tests/docker/dockerfiles.cross/debian10-arm64-build-qemu.docker
diff --git a/tests/docker/dockerfiles.cross/debian-armel-cross.docker b/tests/docker/dockerfiles.cross/debian10-armel-build-qemu.docker
similarity index 100%
rename from tests/docker/dockerfiles.cross/debian-armel-cross.docker
rename to tests/docker/dockerfiles.cross/debian10-armel-build-qemu.docker
diff --git a/tests/docker/dockerfiles.cross/debian-armhf-cross.docker b/tests/docker/dockerfiles.cross/debian10-armhf-build-qemu.docker
similarity index 100%
rename from tests/docker/dockerfiles.cross/debian-armhf-cross.docker
rename to tests/docker/dockerfiles.cross/debian10-armhf-build-qemu.docker
diff --git a/tests/docker/dockerfiles.cross/debian-hppa-cross.docker b/tests/docker/dockerfiles.cross/debian10-hppa-build-tests.docker
similarity index 100%
rename from tests/docker/dockerfiles.cross/debian-hppa-cross.docker
rename to tests/docker/dockerfiles.cross/debian10-hppa-build-tests.docker
diff --git a/tests/docker/dockerfiles.cross/debian-m68k-cross.docker b/tests/docker/dockerfiles.cross/debian10-m68k-build-tests.docker
similarity index 100%
rename from tests/docker/dockerfiles.cross/debian-m68k-cross.docker
rename to tests/docker/dockerfiles.cross/debian10-m68k-build-tests.docker
diff --git a/tests/docker/dockerfiles.cross/debian-mips-cross.docker b/tests/docker/dockerfiles.cross/debian10-mips-build-qemu.docker
similarity index 100%
rename from tests/docker/dockerfiles.cross/debian-mips-cross.docker
rename to tests/docker/dockerfiles.cross/debian10-mips-build-qemu.docker
diff --git a/tests/docker/dockerfiles.cross/debian-mips64-cross.docker b/tests/docker/dockerfiles.cross/debian10-mips64-build-tests.docker
similarity index 100%
rename from tests/docker/dockerfiles.cross/debian-mips64-cross.docker
rename to tests/docker/dockerfiles.cross/debian10-mips64-build-tests.docker
diff --git a/tests/docker/dockerfiles.cross/debian-mips64el-cross.docker b/tests/docker/dockerfiles.cross/debian10-mips64el-build-qemu.docker
similarity index 100%
rename from tests/docker/dockerfiles.cross/debian-mips64el-cross.docker
rename to tests/docker/dockerfiles.cross/debian10-mips64el-build-qemu.docker
diff --git a/tests/docker/dockerfiles.cross/debian-mipsel-cross.docker b/tests/docker/dockerfiles.cross/debian10-mipsel-build-qemu.docker
similarity index 100%
rename from tests/docker/dockerfiles.cross/debian-mipsel-cross.docker
rename to tests/docker/dockerfiles.cross/debian10-mipsel-build-qemu.docker
diff --git a/tests/docker/dockerfiles.cross/debian-powerpc-cross.docker b/tests/docker/dockerfiles.cross/debian10-powerpc-build-tests.docker
similarity index 100%
rename from tests/docker/dockerfiles.cross/debian-powerpc-cross.docker
rename to tests/docker/dockerfiles.cross/debian10-powerpc-build-tests.docker
diff --git a/tests/docker/dockerfiles.cross/debian-ppc64-cross.docker b/tests/docker/dockerfiles.cross/debian10-ppc64-build-tests.docker
similarity index 100%
rename from tests/docker/dockerfiles.cross/debian-ppc64-cross.docker
rename to tests/docker/dockerfiles.cross/debian10-ppc64-build-tests.docker
diff --git a/tests/docker/dockerfiles.cross/debian-ppc64el-cross.docker b/tests/docker/dockerfiles.cross/debian10-ppc64el-build-qemu.docker
similarity index 100%
rename from tests/docker/dockerfiles.cross/debian-ppc64el-cross.docker
rename to tests/docker/dockerfiles.cross/debian10-ppc64el-build-qemu.docker
diff --git a/tests/docker/dockerfiles.cross/debian-riscv64-cross.docker b/tests/docker/dockerfiles.cross/debian10-riscv64-build-tests.docker
similarity index 100%
rename from tests/docker/dockerfiles.cross/debian-riscv64-cross.docker
rename to tests/docker/dockerfiles.cross/debian10-riscv64-build-tests.docker
diff --git a/tests/docker/dockerfiles.cross/debian-s390x-cross.docker b/tests/docker/dockerfiles.cross/debian10-s390x-build-qemu.docker
similarity index 100%
rename from tests/docker/dockerfiles.cross/debian-s390x-cross.docker
rename to tests/docker/dockerfiles.cross/debian10-s390x-build-qemu.docker
diff --git a/tests/docker/dockerfiles.cross/debian-sh4-cross.docker b/tests/docker/dockerfiles.cross/debian10-sh4-build-tests.docker
similarity index 100%
rename from tests/docker/dockerfiles.cross/debian-sh4-cross.docker
rename to tests/docker/dockerfiles.cross/debian10-sh4-build-tests.docker
diff --git a/tests/docker/dockerfiles.cross/debian-sparc64-cross.docker b/tests/docker/dockerfiles.cross/debian10-sparc64-build-tests.docker
similarity index 100%
rename from tests/docker/dockerfiles.cross/debian-sparc64-cross.docker
rename to tests/docker/dockerfiles.cross/debian10-sparc64-build-tests.docker
diff --git a/tests/docker/dockerfiles.cross/debian-win32-cross.docker b/tests/docker/dockerfiles.cross/debian9-mxe-win32-build-qemu.docker
similarity index 100%
rename from tests/docker/dockerfiles.cross/debian-win32-cross.docker
rename to tests/docker/dockerfiles.cross/debian9-mxe-win32-build-qemu.docker
diff --git a/tests/docker/dockerfiles.cross/debian-win64-cross.docker b/tests/docker/dockerfiles.cross/debian9-mxe-win64-build-qemu.docker
similarity index 100%
rename from tests/docker/dockerfiles.cross/debian-win64-cross.docker
rename to tests/docker/dockerfiles.cross/debian9-mxe-win64-build-qemu.docker
diff --git a/tests/docker/dockerfiles.cross/debian-tricore-cross.docker b/tests/docker/dockerfiles.cross/debian9-tricore-build-tests.docker
similarity index 100%
rename from tests/docker/dockerfiles.cross/debian-tricore-cross.docker
rename to tests/docker/dockerfiles.cross/debian9-tricore-build-tests.docker
diff --git a/tests/docker/dockerfiles.cross/debian-xtensa-cross.docker b/tests/docker/dockerfiles.cross/debian9-xtensa-build-tests.docker
similarity index 100%
rename from tests/docker/dockerfiles.cross/debian-xtensa-cross.docker
rename to tests/docker/dockerfiles.cross/debian9-xtensa-build-tests.docker
diff --git a/tests/docker/dockerfiles.cross/fedora-cris-cross.docker b/tests/docker/dockerfiles.cross/fedora-cris-build-tests.docker
similarity index 100%
rename from tests/docker/dockerfiles.cross/fedora-cris-cross.docker
rename to tests/docker/dockerfiles.cross/fedora-cris-build-tests.docker
diff --git a/tests/docker/dockerfiles.cross/fedora-i386-cross.docker b/tests/docker/dockerfiles.cross/fedora-i386-build-qemu.docker
similarity index 100%
rename from tests/docker/dockerfiles.cross/fedora-i386-cross.docker
rename to tests/docker/dockerfiles.cross/fedora-i386-build-qemu.docker
diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index 210e68396f..0b2b62cfa0 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -97,80 +97,80 @@ for target in $target_list; do
   case $target in
     aarch64-*)
       # We don't have any bigendian build tools so we only use this for AArch64
-      container_image=debian-arm64-cross
+      container_image=debian-arm64-build-qemu
       container_cross_cc=aarch64-linux-gnu-gcc
       ;;
     alpha-*)
-      container_image=debian-alpha-cross
+      container_image=debian10-alpha-build-tests
       container_cross_cc=alpha-linux-gnu-gcc
       ;;
     arm-*)
       # We don't have any bigendian build tools so we only use this for ARM
-      container_image=debian-armhf-cross
+      container_image=debian10-armhf-build-qemu
       container_cross_cc=arm-linux-gnueabihf-gcc
       ;;
     cris-*)
-      container_image=fedora-cris-cross
+      container_image=fedora-cris-build-tests
       container_cross_cc=cris-linux-gnu-gcc
       ;;
     hppa-*)
-      container_image=debian-hppa-cross
+      container_image=debian10-hppa-build-tests
       container_cross_cc=hppa-linux-gnu-gcc
       ;;
     i386-*)
-      container_image=fedora-i386-cross
+      container_image=fedora-i386-build-qemu
       container_cross_cc=gcc
       ;;
     m68k-*)
-      container_image=debian-m68k-cross
+      container_image=debian10-m68k-build-tests
       container_cross_cc=m68k-linux-gnu-gcc
       ;;
     mips64el-*)
-      container_image=debian-mips64el-cross
+      container_image=debian10-mips64el-build-qemu
       container_cross_cc=mips64el-linux-gnuabi64-gcc
       ;;
     mips64-*)
-      container_image=debian-mips64-cross
+      container_image=debian10-mips64-build-tests
       container_cross_cc=mips64-linux-gnuabi64-gcc
       ;;
     mipsel-*)
-      container_image=debian-mipsel-cross
+      container_image=debian10-mipsel-build-qemu
       container_cross_cc=mipsel-linux-gnu-gcc
       ;;
     mips-*)
-      container_image=debian-mips-cross
+      container_image=debian10-mips-build-qemu
       container_cross_cc=mips-linux-gnu-gcc
       ;;
     ppc-*|ppc64abi32-*)
-      container_image=debian-powerpc-cross
+      container_image=debian10-powerpc-build-tests
       container_cross_cc=powerpc-linux-gnu-gcc
       ;;
     ppc64-*)
-      container_image=debian-ppc64-cross
+      container_image=debian10-ppc64-build-tests
       container_cross_cc=powerpc64-linux-gnu-gcc
       ;;
     ppc64le-*)
-      container_image=debian-ppc64el-cross
+      container_image=debian10-ppc64el-build-qemu
       container_cross_cc=powerpc64le-linux-gnu-gcc
       ;;
     riscv64-*)
-      container_image=debian-riscv64-cross
+      container_image=debian10-riscv64-build-tests
       container_cross_cc=riscv64-linux-gnu-gcc
       ;;
     s390x-*)
-      container_image=debian-s390x-cross
+      container_image=debian10-s390x-build-qemu
       container_cross_cc=s390x-linux-gnu-gcc
       ;;
     sh4-*)
-      container_image=debian-sh4-cross
+      container_image=debian10-sh4-build-tests
       container_cross_cc=sh4-linux-gnu-gcc
       ;;
     sparc64-*)
-      container_image=debian-sparc64-cross
+      container_image=debian10-sparc64-build-tests
       container_cross_cc=sparc64-linux-gnu-gcc
       ;;
     xtensa*-softmmu)
-      container_image=debian-xtensa-cross
+      container_image=debian9-xtensa-build-tests
 
       # default to the dc232b cpu
       container_cross_cc=/opt/2018.02/xtensa-dc232b-elf/bin/xtensa-dc232b-elf-gcc
-- 
2.20.1


