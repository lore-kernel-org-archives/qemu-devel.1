Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C350BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:46:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E6662071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f+/0SpQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E6662071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47809 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv5qe-0001zp-Fa
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 15:46:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42810)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iv5l2-0008F1-63
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iv5ky-0006Bt-Um
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:48 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:38674)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iv5ky-0006Au-La
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:44 -0500
Received: by mail-wm1-x32c.google.com with SMTP id u2so738351wmc.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 12:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+XW5fSg6tGBZsjMniFCf1PL3dCw9r0nhEXAapE+hRz0=;
 b=f+/0SpQMny0KCoEJLLeNnX7gQK8Sr1RtUfZobvqA0yR83djZebx3n9GjcMHRYmov+v
 coQVAx3mhoFlkE48H2RUnXjkMDKT4GdSjBkMF7O4/9Ni15ES00QG8XnIckccwp/jadbk
 PFun02wPhMCTtmAu0PU96aNT1hq6dIyUL85VnRwXw92zcHByJMqOchqNNlPyYcbibeT3
 G5FyNZKna0m/+PdqYcZQKT0Fx65ukbVoQEC6jnIptr4Lx2hN35F6N95hDzv+CacIQp4l
 7XPdcdonNU37MtV618tQFkUOOfz4nMdxT6jYlAFJyN0Gyqy1Fib12SmNN/f6JInxr+jP
 vY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+XW5fSg6tGBZsjMniFCf1PL3dCw9r0nhEXAapE+hRz0=;
 b=PicOegVPNfkVn+1+L2KNmngHBc+Ier0DPhLbsw+CQcRuCLNyUuykXnwJs5x+FEAmts
 30ka66fdZ44/TX36Z0exLFLgsZ2zjJwpP65ArKyDRlAnsnxwgFw7QHGVt9fRvaZFNstd
 bJGb17/YsqxIxClvPajxPCCery3mQZ/TG/Cgi7RwtmJdEMwqWidzJLKDaKRD8rAHFOgW
 LVFVumusYHGBbqX4iL0cVCmK5sRs4hMAG2Zc83BH0K32hjFNjojwa+JlMhij/PRPV+Pi
 XRQ3eet4HcW0NBw3cJ9qYhFecRziVFTqnnrNVf+C3OHRt52SnH4D01rcAnl/9lnXVbMt
 C73g==
X-Gm-Message-State: APjAAAXCP7R+4zUU9cdONvv7jCf/P6cJBpq9tHzK02T5ns/M8sXzDrvq
 txkhDd7C/wyogSsM4AIJLUNe8A==
X-Google-Smtp-Source: APXvYqwIDclvgA3TNC4r0iU6RTANJ5LgmdVvLbg2Ot75wjWw8sW+u5dyYUmCxDaAhBLn/xPSGCOIcA==
X-Received: by 2002:a7b:c74c:: with SMTP id w12mr843314wmk.1.1579898442040;
 Fri, 24 Jan 2020 12:40:42 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a1sm8726012wrr.80.2020.01.24.12.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 12:40:34 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9A67C1FF9C;
 Fri, 24 Jan 2020 20:40:27 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 12/13] tests/docker: re-enable cross-compiling for x86_64
 hosts
Date: Fri, 24 Jan 2020 20:40:25 +0000
Message-Id: <20200124204026.2107-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124204026.2107-1-alex.bennee@linaro.org>
References: <20200124204026.2107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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

Now we have moved everything around we can re-enable the builds for
x86_64. Thanks to the descriptive names we are able to sort out QEMU
build and tests build dockerfiles and ensure the correct debian
dependencies.

Move the fedora, mxe and travis dockerfiles into the x86_64 directory
as they cannot be used on other architectures.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .../dockerfiles.x86_64/Makefile.include       | 26 +++++++++++++++++++
 .../debain10-x86_64-qemu-build.docker         |  1 +
 .../debian10-alpha-build-tests.docker         |  1 +
 .../debian10-amd64-build-qemu.docker          |  1 +
 .../debian10-arm64-build-qemu.docker          |  1 +
 .../debian10-armel-build-qemu.docker          |  1 +
 .../debian10-armhf-build-qemu.docker          |  1 +
 .../debian10-hppa-build-tests.docker          |  1 +
 .../debian10-m68k-build-tests.docker          |  1 +
 .../debian10-mips-build-qemu.docker           |  1 +
 .../debian10-mips64-build-tests.docker        |  1 +
 .../debian10-mips64el-build-qemu.docker       |  1 +
 .../debian10-mipsel-build-qemu.docker         |  1 +
 .../debian10-native-qemu-build.docker         |  1 +
 .../debian10-powerpc-build-tests.docker       |  1 +
 .../debian10-ppc64-build-tests.docker         |  1 +
 .../debian10-ppc64el-build-qemu.docker        |  1 +
 .../debian10-riscv64-build-tests.docker       |  1 +
 .../debian10-s390x-build-qemu.docker          |  1 +
 .../debian10-sh4-build-tests.docker           |  1 +
 .../debian10-sparc64-build-tests.docker       |  1 +
 .../debian9-mxe-win32-build-qemu.docker       |  0
 .../debian9-mxe-win64-build-qemu.docker       |  0
 .../debian9-mxe.docker                        |  0
 .../debian9-tricore-build-tests.docker        |  1 +
 .../debian9-xtensa-build-tests.docker         |  1 +
 .../fedora-cris-build-tests.docker            |  1 +
 .../fedora-i386-build-tests.docker            |  1 +
 .../travis.docker                             |  0
 29 files changed, 50 insertions(+)
 create mode 100644 tests/docker/dockerfiles.x86_64/Makefile.include
 create mode 120000 tests/docker/dockerfiles.x86_64/debain10-x86_64-qemu-build.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-alpha-build-tests.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-amd64-build-qemu.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-arm64-build-qemu.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-armel-build-qemu.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-armhf-build-qemu.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-hppa-build-tests.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-m68k-build-tests.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-mips-build-qemu.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-mips64-build-tests.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-mips64el-build-qemu.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-mipsel-build-qemu.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-native-qemu-build.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-powerpc-build-tests.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-ppc64-build-tests.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-ppc64el-build-qemu.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-riscv64-build-tests.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-s390x-build-qemu.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-sh4-build-tests.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-sparc64-build-tests.docker
 rename tests/docker/{dockerfiles.cross => dockerfiles.x86_64}/debian9-mxe-win32-build-qemu.docker (100%)
 rename tests/docker/{dockerfiles.cross => dockerfiles.x86_64}/debian9-mxe-win64-build-qemu.docker (100%)
 rename tests/docker/{dockerfiles => dockerfiles.x86_64}/debian9-mxe.docker (100%)
 create mode 120000 tests/docker/dockerfiles.x86_64/debian9-tricore-build-tests.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian9-xtensa-build-tests.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/fedora-cris-build-tests.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/fedora-i386-build-tests.docker
 rename tests/docker/{dockerfiles => dockerfiles.x86_64}/travis.docker (100%)

diff --git a/tests/docker/dockerfiles.x86_64/Makefile.include b/tests/docker/dockerfiles.x86_64/Makefile.include
new file mode 100644
index 0000000000..6237eb500e
--- /dev/null
+++ b/tests/docker/dockerfiles.x86_64/Makefile.include
@@ -0,0 +1,26 @@
+# -*- Mode: makefile -*-
+#
+# x86_64 Containers
+#
+# This architecture has by far the largest number of cross compilers
+# enabled for it.
+#
+
+X86_64_BASE = $(DOCKER_BASE)/dockerfiles.x86_64
+VPATH += $(X86_64_BASE)
+
+#
+# We have both QEMU build and TEST build containers we can access
+#
+QEMU_BUILD_CONTAINERS += $(call get-basenames,$(wildcard $(X86_64_BASE)/*-build-qemu.docker))
+TEST_BUILD_CONTAINERS += $(call get-basenames,$(wildcard $(X86_64_BASE)/*-build-tests.docker))
+
+# Generate build-deps based on names
+#
+# Most of this architecture are based on Debian images
+X86_64_CONTAINERS=$(call get-basenames,$(wildcard $(X86_64_BASE)/*.docker))
+$(filter-out,debian9,$(X86_64_CONTAINERS)): docker-image-debian9
+$(filter-out,debian10,$(X86_64_CONTAINERS)): docker-image-debian10
+
+# MXE windows cross compilers are all based on stretch
+debian9-mxe-%: docker-image-debian9-mxe
diff --git a/tests/docker/dockerfiles.x86_64/debain10-x86_64-qemu-build.docker b/tests/docker/dockerfiles.x86_64/debain10-x86_64-qemu-build.docker
new file mode 120000
index 0000000000..cd1caa0704
--- /dev/null
+++ b/tests/docker/dockerfiles.x86_64/debain10-x86_64-qemu-build.docker
@@ -0,0 +1 @@
+../dockerfiles/debian10-native-qemu-build.docker
\ No newline at end of file
diff --git a/tests/docker/dockerfiles.x86_64/debian10-alpha-build-tests.docker b/tests/docker/dockerfiles.x86_64/debian10-alpha-build-tests.docker
new file mode 120000
index 0000000000..614c8525ef
--- /dev/null
+++ b/tests/docker/dockerfiles.x86_64/debian10-alpha-build-tests.docker
@@ -0,0 +1 @@
+../dockerfiles.cross/debian10-alpha-build-tests.docker
\ No newline at end of file
diff --git a/tests/docker/dockerfiles.x86_64/debian10-amd64-build-qemu.docker b/tests/docker/dockerfiles.x86_64/debian10-amd64-build-qemu.docker
new file mode 120000
index 0000000000..81aa695b35
--- /dev/null
+++ b/tests/docker/dockerfiles.x86_64/debian10-amd64-build-qemu.docker
@@ -0,0 +1 @@
+../dockerfiles.cross/debian10-amd64-build-qemu.docker
\ No newline at end of file
diff --git a/tests/docker/dockerfiles.x86_64/debian10-arm64-build-qemu.docker b/tests/docker/dockerfiles.x86_64/debian10-arm64-build-qemu.docker
new file mode 120000
index 0000000000..911274674a
--- /dev/null
+++ b/tests/docker/dockerfiles.x86_64/debian10-arm64-build-qemu.docker
@@ -0,0 +1 @@
+../dockerfiles.cross/debian10-arm64-build-qemu.docker
\ No newline at end of file
diff --git a/tests/docker/dockerfiles.x86_64/debian10-armel-build-qemu.docker b/tests/docker/dockerfiles.x86_64/debian10-armel-build-qemu.docker
new file mode 120000
index 0000000000..ad6302f721
--- /dev/null
+++ b/tests/docker/dockerfiles.x86_64/debian10-armel-build-qemu.docker
@@ -0,0 +1 @@
+../dockerfiles.cross/debian10-armel-build-qemu.docker
\ No newline at end of file
diff --git a/tests/docker/dockerfiles.x86_64/debian10-armhf-build-qemu.docker b/tests/docker/dockerfiles.x86_64/debian10-armhf-build-qemu.docker
new file mode 120000
index 0000000000..a5111afb01
--- /dev/null
+++ b/tests/docker/dockerfiles.x86_64/debian10-armhf-build-qemu.docker
@@ -0,0 +1 @@
+../dockerfiles.cross/debian10-armhf-build-qemu.docker
\ No newline at end of file
diff --git a/tests/docker/dockerfiles.x86_64/debian10-hppa-build-tests.docker b/tests/docker/dockerfiles.x86_64/debian10-hppa-build-tests.docker
new file mode 120000
index 0000000000..4ce5da228d
--- /dev/null
+++ b/tests/docker/dockerfiles.x86_64/debian10-hppa-build-tests.docker
@@ -0,0 +1 @@
+../dockerfiles.cross/debian10-hppa-build-tests.docker
\ No newline at end of file
diff --git a/tests/docker/dockerfiles.x86_64/debian10-m68k-build-tests.docker b/tests/docker/dockerfiles.x86_64/debian10-m68k-build-tests.docker
new file mode 120000
index 0000000000..402972365f
--- /dev/null
+++ b/tests/docker/dockerfiles.x86_64/debian10-m68k-build-tests.docker
@@ -0,0 +1 @@
+../dockerfiles.cross/debian10-m68k-build-tests.docker
\ No newline at end of file
diff --git a/tests/docker/dockerfiles.x86_64/debian10-mips-build-qemu.docker b/tests/docker/dockerfiles.x86_64/debian10-mips-build-qemu.docker
new file mode 120000
index 0000000000..9b4fc155f3
--- /dev/null
+++ b/tests/docker/dockerfiles.x86_64/debian10-mips-build-qemu.docker
@@ -0,0 +1 @@
+../dockerfiles.cross/debian10-mips-build-qemu.docker
\ No newline at end of file
diff --git a/tests/docker/dockerfiles.x86_64/debian10-mips64-build-tests.docker b/tests/docker/dockerfiles.x86_64/debian10-mips64-build-tests.docker
new file mode 120000
index 0000000000..89fef7d8ac
--- /dev/null
+++ b/tests/docker/dockerfiles.x86_64/debian10-mips64-build-tests.docker
@@ -0,0 +1 @@
+../dockerfiles.cross/debian10-mips64-build-tests.docker
\ No newline at end of file
diff --git a/tests/docker/dockerfiles.x86_64/debian10-mips64el-build-qemu.docker b/tests/docker/dockerfiles.x86_64/debian10-mips64el-build-qemu.docker
new file mode 120000
index 0000000000..1ef8ccfec6
--- /dev/null
+++ b/tests/docker/dockerfiles.x86_64/debian10-mips64el-build-qemu.docker
@@ -0,0 +1 @@
+../dockerfiles.cross/debian10-mips64el-build-qemu.docker
\ No newline at end of file
diff --git a/tests/docker/dockerfiles.x86_64/debian10-mipsel-build-qemu.docker b/tests/docker/dockerfiles.x86_64/debian10-mipsel-build-qemu.docker
new file mode 120000
index 0000000000..9c1a090aba
--- /dev/null
+++ b/tests/docker/dockerfiles.x86_64/debian10-mipsel-build-qemu.docker
@@ -0,0 +1 @@
+../dockerfiles.cross/debian10-mipsel-build-qemu.docker
\ No newline at end of file
diff --git a/tests/docker/dockerfiles.x86_64/debian10-native-qemu-build.docker b/tests/docker/dockerfiles.x86_64/debian10-native-qemu-build.docker
new file mode 120000
index 0000000000..cd1caa0704
--- /dev/null
+++ b/tests/docker/dockerfiles.x86_64/debian10-native-qemu-build.docker
@@ -0,0 +1 @@
+../dockerfiles/debian10-native-qemu-build.docker
\ No newline at end of file
diff --git a/tests/docker/dockerfiles.x86_64/debian10-powerpc-build-tests.docker b/tests/docker/dockerfiles.x86_64/debian10-powerpc-build-tests.docker
new file mode 120000
index 0000000000..2480077366
--- /dev/null
+++ b/tests/docker/dockerfiles.x86_64/debian10-powerpc-build-tests.docker
@@ -0,0 +1 @@
+../dockerfiles.cross/debian10-powerpc-build-tests.docker
\ No newline at end of file
diff --git a/tests/docker/dockerfiles.x86_64/debian10-ppc64-build-tests.docker b/tests/docker/dockerfiles.x86_64/debian10-ppc64-build-tests.docker
new file mode 120000
index 0000000000..e9290dcf63
--- /dev/null
+++ b/tests/docker/dockerfiles.x86_64/debian10-ppc64-build-tests.docker
@@ -0,0 +1 @@
+../dockerfiles.cross/debian10-ppc64-build-tests.docker
\ No newline at end of file
diff --git a/tests/docker/dockerfiles.x86_64/debian10-ppc64el-build-qemu.docker b/tests/docker/dockerfiles.x86_64/debian10-ppc64el-build-qemu.docker
new file mode 120000
index 0000000000..6c1639cf6d
--- /dev/null
+++ b/tests/docker/dockerfiles.x86_64/debian10-ppc64el-build-qemu.docker
@@ -0,0 +1 @@
+../dockerfiles.cross/debian10-ppc64el-build-qemu.docker
\ No newline at end of file
diff --git a/tests/docker/dockerfiles.x86_64/debian10-riscv64-build-tests.docker b/tests/docker/dockerfiles.x86_64/debian10-riscv64-build-tests.docker
new file mode 120000
index 0000000000..06493c2663
--- /dev/null
+++ b/tests/docker/dockerfiles.x86_64/debian10-riscv64-build-tests.docker
@@ -0,0 +1 @@
+../dockerfiles.cross/debian10-riscv64-build-tests.docker
\ No newline at end of file
diff --git a/tests/docker/dockerfiles.x86_64/debian10-s390x-build-qemu.docker b/tests/docker/dockerfiles.x86_64/debian10-s390x-build-qemu.docker
new file mode 120000
index 0000000000..f08338748e
--- /dev/null
+++ b/tests/docker/dockerfiles.x86_64/debian10-s390x-build-qemu.docker
@@ -0,0 +1 @@
+../dockerfiles.cross/debian10-s390x-build-qemu.docker
\ No newline at end of file
diff --git a/tests/docker/dockerfiles.x86_64/debian10-sh4-build-tests.docker b/tests/docker/dockerfiles.x86_64/debian10-sh4-build-tests.docker
new file mode 120000
index 0000000000..771ac25b23
--- /dev/null
+++ b/tests/docker/dockerfiles.x86_64/debian10-sh4-build-tests.docker
@@ -0,0 +1 @@
+../dockerfiles.cross/debian10-sh4-build-tests.docker
\ No newline at end of file
diff --git a/tests/docker/dockerfiles.x86_64/debian10-sparc64-build-tests.docker b/tests/docker/dockerfiles.x86_64/debian10-sparc64-build-tests.docker
new file mode 120000
index 0000000000..0187622e06
--- /dev/null
+++ b/tests/docker/dockerfiles.x86_64/debian10-sparc64-build-tests.docker
@@ -0,0 +1 @@
+../dockerfiles.cross/debian10-sparc64-build-tests.docker
\ No newline at end of file
diff --git a/tests/docker/dockerfiles.cross/debian9-mxe-win32-build-qemu.docker b/tests/docker/dockerfiles.x86_64/debian9-mxe-win32-build-qemu.docker
similarity index 100%
rename from tests/docker/dockerfiles.cross/debian9-mxe-win32-build-qemu.docker
rename to tests/docker/dockerfiles.x86_64/debian9-mxe-win32-build-qemu.docker
diff --git a/tests/docker/dockerfiles.cross/debian9-mxe-win64-build-qemu.docker b/tests/docker/dockerfiles.x86_64/debian9-mxe-win64-build-qemu.docker
similarity index 100%
rename from tests/docker/dockerfiles.cross/debian9-mxe-win64-build-qemu.docker
rename to tests/docker/dockerfiles.x86_64/debian9-mxe-win64-build-qemu.docker
diff --git a/tests/docker/dockerfiles/debian9-mxe.docker b/tests/docker/dockerfiles.x86_64/debian9-mxe.docker
similarity index 100%
rename from tests/docker/dockerfiles/debian9-mxe.docker
rename to tests/docker/dockerfiles.x86_64/debian9-mxe.docker
diff --git a/tests/docker/dockerfiles.x86_64/debian9-tricore-build-tests.docker b/tests/docker/dockerfiles.x86_64/debian9-tricore-build-tests.docker
new file mode 120000
index 0000000000..75f342fc01
--- /dev/null
+++ b/tests/docker/dockerfiles.x86_64/debian9-tricore-build-tests.docker
@@ -0,0 +1 @@
+../dockerfiles.cross/debian9-tricore-build-tests.docker
\ No newline at end of file
diff --git a/tests/docker/dockerfiles.x86_64/debian9-xtensa-build-tests.docker b/tests/docker/dockerfiles.x86_64/debian9-xtensa-build-tests.docker
new file mode 120000
index 0000000000..b531d9332d
--- /dev/null
+++ b/tests/docker/dockerfiles.x86_64/debian9-xtensa-build-tests.docker
@@ -0,0 +1 @@
+../dockerfiles.cross/debian9-xtensa-build-tests.docker
\ No newline at end of file
diff --git a/tests/docker/dockerfiles.x86_64/fedora-cris-build-tests.docker b/tests/docker/dockerfiles.x86_64/fedora-cris-build-tests.docker
new file mode 120000
index 0000000000..4f260380a9
--- /dev/null
+++ b/tests/docker/dockerfiles.x86_64/fedora-cris-build-tests.docker
@@ -0,0 +1 @@
+../dockerfiles.cross/fedora-cris-build-tests.docker
\ No newline at end of file
diff --git a/tests/docker/dockerfiles.x86_64/fedora-i386-build-tests.docker b/tests/docker/dockerfiles.x86_64/fedora-i386-build-tests.docker
new file mode 120000
index 0000000000..373f15ee40
--- /dev/null
+++ b/tests/docker/dockerfiles.x86_64/fedora-i386-build-tests.docker
@@ -0,0 +1 @@
+../dockerfiles.cross/fedora-i386-build-qemu.docker
\ No newline at end of file
diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/dockerfiles.x86_64/travis.docker
similarity index 100%
rename from tests/docker/dockerfiles/travis.docker
rename to tests/docker/dockerfiles.x86_64/travis.docker
-- 
2.20.1


