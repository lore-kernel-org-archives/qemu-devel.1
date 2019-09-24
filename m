Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEEEC432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:48:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3897D20872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LG2sXDoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3897D20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCtbW-0004Lm-Jf
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 18:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCs5L-0003V9-3D
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCs58-0007ac-Am
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:10:58 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:34972)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCs58-0007ZY-4i
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:10:46 -0400
Received: by mail-wm1-x332.google.com with SMTP id y21so1779094wmi.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 14:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EQMFVvQQ12r4Rl1Q/VQlrZ01jldIoi/+yP3w6mK03UM=;
 b=LG2sXDoq7B0YuRp2Zfx+WGnew5uPsIjZxJ4okFOmncKTVtvUXMDftKbrylnLjVHom6
 ssHeHMFDexuFOz10ndKnHC7NmpGfMFxslhHyBbuZXu17epVfYwH6YPKspNAUsaf0mfUH
 AS7FcJKpM46xsqBNF92pCzjrtPGAWvasvybSzAo3Ldtb6mK0k0GpD9eeUWnizJhqmszf
 i8mlKA8xLz1rbNpAPCIq6o2DxBE9EMfqZ43GE0R7UJ5BilyRrJSO70EIOXqX98yHWRza
 d8isrRTv5TYZXoMAbRrMgrYp/TCXx4gEuL1cRq+49Hgvl8QfWyjog02QikBSgywRQhbP
 aVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EQMFVvQQ12r4Rl1Q/VQlrZ01jldIoi/+yP3w6mK03UM=;
 b=ilbIeuTVeWOQ7toVoxwU/Ft+uL2CZFPyQBWR0weBgkV1EWdOkj2no94R1VTjW2k1E4
 N6poM88RajeLKxvLgLsWoa9ZcWaiM6RPyC1JE0Zo+BEnXvlMIft+lle4CfqSKAANM/Ha
 w1LvlTsY9RGeJAQo/0qi7YxYzMxdnw07ulbfN8iPtJGxrC97NntJGNQQalr3fJfH0aO+
 PFgwjn093qsvMN5QA8PykvZkbauplW0SfNQJQaxyuRSivOWpXeJBtUgw5MmdbkOYAEY7
 nNGGM5jkpQ6FLYbUi+nCQDEMZTGq6PK7/RlA8KQiysJgSAClTay4SrVDI91mPaqnYdt6
 uYIQ==
X-Gm-Message-State: APjAAAVc9HpSsX5lo+oMo5yltsbTV1i4OTEu61uRUyO6IKjuS0GTe3o5
 43RHvgaEN5TpNpUb3Sz0W+J9NA==
X-Google-Smtp-Source: APXvYqxx3QGTXWAKLiAbA/FWQNo+ghnd3yWrYHMQDBIiJKJ8fJf7gVfSiMTjElWtJV7ajnyAwThYzQ==
X-Received: by 2002:a7b:c44e:: with SMTP id l14mr2524349wmi.54.1569359441555; 
 Tue, 24 Sep 2019 14:10:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y5sm1450072wma.14.2019.09.24.14.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 14:10:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3212D1FFAE;
 Tue, 24 Sep 2019 22:01:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 25/33] tests/docker: Add fedora-win10sdk-cross image
Date: Tue, 24 Sep 2019 22:00:58 +0100
Message-Id: <20190924210106.27117-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924210106.27117-1-alex.bennee@linaro.org>
References: <20190924210106.27117-1-alex.bennee@linaro.org>
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, f4bug@amsat.org,
 Justin Terry <juterry@microsoft.com>, jsnow@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

To build WHPX (Windows Hypervisor) binaries, we need the WHPX
headers provided by the Windows SDK.

Add a script that fetches the required MSI/CAB files from the
latest SDK (currently 10.0.18362.1).

Headers are accessible under /opt/win10sdk/include.

Set the QEMU_CONFIGURE_OPTS environment variable accordingly,
enabling HAX and WHPX. Due to CPP warnings related to Microsoft
specific #pragmas, we also need to use the '--disable-werror'
configure flag.

Cc: Justin Terry <juterry@microsoft.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20190920113329.16787-3-philmd@redhat.com>
---
 tests/docker/Makefile.include                 |  2 ++
 .../dockerfiles/fedora-win10sdk-cross.docker  | 23 ++++++++++++++++
 tests/docker/dockerfiles/win10sdk-dl.sh       | 27 +++++++++++++++++++
 3 files changed, 52 insertions(+)
 create mode 100644 tests/docker/dockerfiles/fedora-win10sdk-cross.docker
 create mode 100755 tests/docker/dockerfiles/win10sdk-dl.sh

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 3fc7a863e51..e85e73025ba 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -125,6 +125,8 @@ docker-image-debian-ppc64-cross: docker-image-debian10
 docker-image-debian-riscv64-cross: docker-image-debian10
 docker-image-debian-sh4-cross: docker-image-debian10
 docker-image-debian-sparc64-cross: docker-image-debian10
+docker-image-fedora-win10sdk-cross: docker-image-fedora
+docker-image-fedora-win10sdk-cross: EXTRA_FILES:=$(DOCKER_FILES_DIR)/win10sdk-dl.sh
 
 docker-image-travis: NOUSER=1
 
diff --git a/tests/docker/dockerfiles/fedora-win10sdk-cross.docker b/tests/docker/dockerfiles/fedora-win10sdk-cross.docker
new file mode 100644
index 00000000000..55ca933d40d
--- /dev/null
+++ b/tests/docker/dockerfiles/fedora-win10sdk-cross.docker
@@ -0,0 +1,23 @@
+#
+# Docker MinGW64 cross-compiler target with WHPX header installed
+#
+# This docker target builds on the Fedora 30 base image.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+FROM qemu:fedora
+
+RUN dnf install -y \
+        cabextract \
+        msitools \
+        wget
+
+# Install WHPX headers from Windows Software Development Kit:
+# https://developer.microsoft.com/en-us/windows/downloads/windows-10-sdk
+ADD win10sdk-dl.sh /usr/local/bin/win10sdk-dl.sh
+RUN /usr/local/bin/win10sdk-dl.sh
+
+ENV QEMU_CONFIGURE_OPTS ${QEMU_CONFIGURE_OPTS} \
+    --cross-prefix=x86_64-w64-mingw32- \
+    --extra-cflags=-I/opt/win10sdk/include --disable-werror \
+    --enable-hax --enable-whpx
diff --git a/tests/docker/dockerfiles/win10sdk-dl.sh b/tests/docker/dockerfiles/win10sdk-dl.sh
new file mode 100755
index 00000000000..1c35c2a2524
--- /dev/null
+++ b/tests/docker/dockerfiles/win10sdk-dl.sh
@@ -0,0 +1,27 @@
+#!/bin/bash
+#
+# Install WHPX headers from Windows Software Development Kit
+# https://developer.microsoft.com/en-us/windows/downloads/windows-10-sdk
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+WINDIR=/opt/win10sdk
+mkdir -p ${WINDIR}
+pushd ${WINDIR}
+# Get the bundle base for Windows SDK v10.0.18362.1
+BASE_URL=$(curl --silent --include 'http://go.microsoft.com/fwlink/?prd=11966&pver=1.0&plcid=0x409&clcid=0x409&ar=Windows10&sar=SDK&o1=10.0.18362.1' | sed -nE 's_Location: (.*)/\r_\1_p')/Installers
+# Fetch the MSI containing the headers
+wget --no-verbose ${BASE_URL}/'Windows SDK Desktop Headers x86-x86_en-us.msi'
+while true; do
+    # Fetch all cabinets required by this MSI
+    CAB_NAME=$(msiextract Windows\ SDK\ Desktop\ Headers\ x86-x86_en-us.msi 3>&1 2>&3 3>&-| sed -nE "s_.*Error opening file $PWD/(.*): No such file or directory_\1_p")
+    test -z "${CAB_NAME}" && break
+    wget --no-verbose ${BASE_URL}/${CAB_NAME}
+done
+rm *.{cab,msi}
+mkdir /opt/win10sdk/include
+# Only keep the WHPX headers
+for inc in "${WINDIR}/Program Files/Windows Kits/10/Include/10.0.18362.0/um"/WinHv*; do
+    ln -s "${inc}" /opt/win10sdk/include
+done
+popd > /dev/null
-- 
2.20.1


