Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943F7C3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 10:06:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA7D20870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 10:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EneEo4fG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA7D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9QvZ-0006fy-Ja
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 05:06:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j9Qqv-000722-FI
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:02:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j9Qqt-0000nh-K7
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:02:09 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:41739)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j9Qqt-0000ky-D1
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:02:07 -0500
Received: by mail-wr1-x42d.google.com with SMTP id v4so1590811wrs.8
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 02:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8IoRhGZ2eqfxiUMqD1IQ15ijzzrrTQ6InFUO0k6F5mQ=;
 b=EneEo4fGMDkOTBs22ZPqJkV3yB3aP3Dar/OaTM1KeR4fv+dhkcOnLzAC4MhDP8D0YO
 z2uZm/t3tQplRy9LrQvUbS2XXbGZPG0E69XLbnYfeuyBswjKiZEjoioHJIyQq/xygfv1
 G2VXdKKKQP1o5Hi7ia9dRhN0ItdyAXSPTP7M+JbKyJHPCRKVVh6AzNwBX6Dn8Xo3sTlO
 JwaHnnIn1/Y5mTg0kr8uYLUPlzroJnaHqZu9u1CfyRLCma8TjFVDjX7siiMg4SLDZw1b
 Bp79kyPESbaQx+HMNl5PvAhaGs+KdFGVE0WU6ruv4LmQM0sJdrkuaX0izy1N2p/vmbW3
 E3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8IoRhGZ2eqfxiUMqD1IQ15ijzzrrTQ6InFUO0k6F5mQ=;
 b=PARHUXyva95PvEy9uwCMT2PA/Hq6dUAmqJUwaL9PsI4OyE3fGF1V9lNRg2w67qNXPt
 NUliGwjVnpZRyy07bTYSFnDW/3atcs2iCJ1CcQM2qAriG57SWma7civK1b2B+mOcVHWh
 qkIgzhK4mHqZR5zMMrfopvKtEkC4UnI94qT+8pQjZRqlAP6PNBRS+qLllDeqbpO3CvpC
 kg2DsWz5vrpGkBpHgOMtkEJS8hgCZuQ+DDADComZJbAw7QLOQuRx58TLSoFu17lm9UHW
 EcpbpZaHN3bJ2lMamuc4Pih0auklP7uC1MWLyl7AZcKSppdF/BRKVTtG+wbtNjI1w2bH
 iQ9g==
X-Gm-Message-State: ANhLgQ3w0TQDm8DRPCKDha5dpBlWmty57qsltIxqR2jeKrJ6DhVuBgBZ
 8iL3+fVVIYXZS5DEM/5/vwkhzQ==
X-Google-Smtp-Source: ADFU+vvflvPEU8+Ozi63zSAtlB9jgPVcuQl5JRjq8igDUu7n3kMbOhAfgNekFdXzoVETW+r0VaogLQ==
X-Received: by 2002:a5d:4d48:: with SMTP id a8mr3255313wru.35.1583316126338;
 Wed, 04 Mar 2020 02:02:06 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m3sm18662148wrx.9.2020.03.04.02.01.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 02:02:00 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 829231FF96;
 Wed,  4 Mar 2020 10:01:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 7/9] configure: detect and report genisoimage
Date: Wed,  4 Mar 2020 10:01:52 +0000
Message-Id: <20200304100154.14822-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304100154.14822-1-alex.bennee@linaro.org>
References: <20200304100154.14822-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is used for some of the vm-build tests so lets detect it and
behave sanely when it is not installed.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200303150622.20133-8-alex.bennee@linaro.org>

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


