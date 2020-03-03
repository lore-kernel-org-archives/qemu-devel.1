Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283C2C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E74882073D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FV0fEUwR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74882073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j99AW-0008H7-2n
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 10:09:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42633)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j997z-0003AP-FG
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j997y-0001l4-8p
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:35 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:51447)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j997y-0001ku-2X
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:34 -0500
Received: by mail-wm1-x330.google.com with SMTP id a132so3628532wme.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 07:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T+UmvkcuJ29VTcRDaXTcG4zdKU9zWXLmw7iHIS3VZmQ=;
 b=FV0fEUwROdajTV63RAMJFTV3YkHSn4tZjI5p5jhFFKGi3U+ymEyOxDVT9ez+iocjEO
 NBNiIWwtj/qIP8HenuK5Dmm4cK79Dj3Pi0M16MoKnzHpKMAKaxNqdIALK35AGMSphgZV
 7K1Rfru+BeD/HrSBgDHZgBVHlm5zw1+ZZMmAsf79nRKQ7do/VjaroBu5jWORoSmb3UbN
 RKrWFSCMY06sNmMjcW4Pv17K5O3JFM7CqEvMeurruIXLdnDNmGDGNl4r/dLHQZg0h36U
 ZvFtVq2sGKvaXX/NRbF02MGGza5Vh8WnXZbu4zdhi0tdU8UllvwrD6nAamBBMZ5J9diK
 wM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T+UmvkcuJ29VTcRDaXTcG4zdKU9zWXLmw7iHIS3VZmQ=;
 b=lkePZmu/UtQ8DB8wMSY0iIx+2ZiMUHt6tL3YJNVNobGD1CpAC5o+OJycTKwVbuLw44
 X9giTkb3p3vIhwqaFL/1Az6UC3SuPlgeVf+ogioA78w3GvKgRQSHmcjfr6Q1xO8vQX2o
 kwsmWCTXAVs2BUY7ngXMYy6YCW3z+VgyrEagytPk5OCdLfwpXzdUgyOduYmtbVfMNtyi
 f/OIqPyhBSyzkXmIPc0qEyZtjV6VYPx7Hs/AOugryd47j/KHTl+oxekbASEbjJlkk71Y
 AduxRpDvz391ePOwTNI2kYv35uO5UtwqC8c5Z+r/DRwKkceHxh64sxj9gelLd/VYyDru
 dYlg==
X-Gm-Message-State: ANhLgQ3Aqk21IxwjUACnYCkdZ4wGYTOY+t5Eo7GLoLHHhN7w48ZMt3xr
 HNs7I+ohDp7hiJ8k1v7kTBbi5A==
X-Google-Smtp-Source: ADFU+vucmtOB1DOyUA+ZfWws/AkC9jEPWl579nAtzPenSVnZOb+9OBkEF6lSBH5bc04C2dSzS5lMBw==
X-Received: by 2002:a1c:3d46:: with SMTP id k67mr4991314wma.177.1583247992974; 
 Tue, 03 Mar 2020 07:06:32 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k2sm2742354wrn.57.2020.03.03.07.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 07:06:29 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BDE731FF96;
 Tue,  3 Mar 2020 15:06:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 7/9] configure: detect and report genisoimage
Date: Tue,  3 Mar 2020 15:06:20 +0000
Message-Id: <20200303150622.20133-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303150622.20133-1-alex.bennee@linaro.org>
References: <20200303150622.20133-1-alex.bennee@linaro.org>
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is used for some of the vm-build tests so lets detect it and
behave sanely when it is not installed.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure                 | 13 +++++++++++++
 tests/vm/Makefile.include | 14 +++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 7b373bc0bb8..fab6281eb70 100755
--- a/configure
+++ b/configure
@@ -936,6 +936,17 @@ do
     fi
 done
 
+# Check for ancillary tools used in testing
+genisoimage=
+for binary in genisoimage
+do
+    if has $binary
+    then
+        genisoimage=$(command -v "$binary")
+        break
+    fi
+done
+
 : ${smbd=${SMBD-/usr/sbin/smbd}}
 
 # Default objcc to clang if available, otherwise use CC
@@ -6567,6 +6578,7 @@ echo "python            $python ($python_version)"
 if test "$docs" != "no"; then
     echo "sphinx-build      $sphinx_build"
 fi
+echo "genisoimage       $genisoimage"
 echo "slirp support     $slirp $(echo_version $slirp $slirp_version)"
 if test "$slirp" != "no" ; then
     echo "smbd              $smbd"
@@ -7616,6 +7628,7 @@ echo "INSTALL_PROG=$install -c -m 0755" >> $config_host_mak
 echo "INSTALL_LIB=$install -c -m 0644" >> $config_host_mak
 echo "PYTHON=$python" >> $config_host_mak
 echo "SPHINX_BUILD=$sphinx_build" >> $config_host_mak
+echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
 echo "CC=$cc" >> $config_host_mak
 if $iasl -h > /dev/null 2>&1; then
   echo "IASL=$iasl" >> $config_host_mak
diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 778e5067554..1bf9693d195 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -2,7 +2,11 @@
 
 .PHONY: vm-build-all vm-clean-all
 
-IMAGES := ubuntu.i386 freebsd netbsd openbsd centos fedora
+IMAGES := freebsd netbsd openbsd centos fedora
+ifneq ($(GENISOIMAGE),)
+IMAGES += ubuntu.i386 centos
+endif
+
 IMAGES_DIR := $(HOME)/.cache/qemu-vm/images
 IMAGE_FILES := $(patsubst %, $(IMAGES_DIR)/%.img, $(IMAGES))
 
@@ -12,12 +16,16 @@ IMAGE_FILES := $(patsubst %, $(IMAGES_DIR)/%.img, $(IMAGES))
 vm-help vm-test:
 	@echo "vm-help: Test QEMU in preconfigured virtual machines"
 	@echo
-	@echo "  vm-build-ubuntu.i386            - Build QEMU in ubuntu i386 VM"
 	@echo "  vm-build-freebsd                - Build QEMU in FreeBSD VM"
 	@echo "  vm-build-netbsd                 - Build QEMU in NetBSD VM"
 	@echo "  vm-build-openbsd                - Build QEMU in OpenBSD VM"
-	@echo "  vm-build-centos                 - Build QEMU in CentOS VM, with Docker"
 	@echo "  vm-build-fedora                 - Build QEMU in Fedora VM"
+ifneq ($(GENISOIMAGE),)
+	@echo "  vm-build-centos                 - Build QEMU in CentOS VM, with Docker"
+	@echo "  vm-build-ubuntu.i386            - Build QEMU in ubuntu i386 VM"
+else
+	@echo "  (install genisoimage to build centos/ubuntu images)"
+endif
 	@echo ""
 	@echo "  vm-build-all                    - Build QEMU in all VMs"
 	@echo "  vm-clean-all                    - Clean up VM images"
-- 
2.20.1


