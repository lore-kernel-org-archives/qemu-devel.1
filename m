Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CF7C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:02:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30DCC206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iVfN9MxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30DCC206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7c2R-0005c4-5d
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bqs-0000j3-Dd
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bqq-0000a2-F4
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:18 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:36007)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bqq-0000ZQ-7z
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:16 -0400
Received: by mail-wm1-x334.google.com with SMTP id p13so574206wmh.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XZ6K4vUbyReKzpC03BdsNhH31lJ6dRz1tPBlaHFb3eo=;
 b=iVfN9MxXXcdHroPlOO0unpD6eNM04ozUZgWucrfY71JHufO9hy9d/qKoCzfXLc691M
 YmaNXbIypx919a/uRA+t9zXx0Aq30bwybV+t/J6S5UjjTY1KxK/bctKIkoT3OlON+60s
 p3cSVtdRllaqIAzkPZqM2A/SithIIbTseA2fsErgBCPXFemY0Jd2Jb5owKUlHii+5y+J
 mTMwPn93C4DghlEtTEobZo0T4cZB7squ5x2t4B1yNcp6F3ZP0FozOFfTJtJXHHgVLx/h
 OOorcQIu8M1TRORTrjEUzACDNNn41WId/QdJ8N203SNfTkpMdV26hlX20SpXty/brhVy
 nJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XZ6K4vUbyReKzpC03BdsNhH31lJ6dRz1tPBlaHFb3eo=;
 b=elHY+b4NytkUPwFWPZ/oaEWdP4WvXWQCWdvMgHaSndXT+k/CgDAXTLkx5zfujkeFQc
 KdNTZB+/oPeC694nTysy9Mcj9WQbLVs80jEY5wB3E8FWhIETeRapWh4WnYXwfDuwMTSQ
 Zp8d4cJZWa470a+kminYhSwh3Cu74TMjpmVcPLaNCiVn5OvMobCVYII4HOUnUYpF8cjt
 ADfqUYnKCL/6eGlhai6aUIn71nZyWpFTirvGhkP749rxtfgcYOF9VP+aGSc1zujMaVhd
 aEFDhHt9hE+w3CdAPu/6FXMv8fDX9VJkZWhEXAVUy6deecH9S0fkKyu+gk1xJSvUyOUI
 MjVQ==
X-Gm-Message-State: APjAAAUW+//sDivF0+q9VSLXR03xcGtZdr440PMtIhpC3vKh05hCihIc
 dCX7FOwuCKssN8IFFhu+bKKKbQ==
X-Google-Smtp-Source: APXvYqztYJhAztOSyO3WvSP9mzw4KuYn18mtTnGrX3rlvjAgMnCfGUrmfBWJA4elmLIAzOzO6sUuDg==
X-Received: by 2002:a7b:ca50:: with SMTP id m16mr267509wml.158.1568105414866; 
 Tue, 10 Sep 2019 01:50:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f186sm3582355wmg.21.2019.09.10.01.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:50:11 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 982801FF91;
 Tue, 10 Sep 2019 09:43:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:48 +0100
Message-Id: <20190910084349.28817-45-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
Subject: [Qemu-devel] [PULL 44/45] Fedora images: use URLs from stable
 "archives.fedoraproject.org"
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
Cc: Yash Mankad <ymankad@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cleber Rosa <crosa@redhat.com>

The LinuxInitrd.test_with_2gib_file_should_work_with_linux_v4_16 test,
from tests/acceptance/linux_initrd.py, is currently failing to fetch
the "vmlinuz" file.  The reason for the failure is that the Fedora
project retires older versions from the "dl.fedoraproject.org" URL,
and keeps them in "archives.fedoraproject.org".  As an added note,
that test uses a Fedora 28 image, because of the specific Linux kernel
version requirements of the test.

For the sake of stability, let's use URLs from the archived and
supposedely ever stable URLs.  The good news is that the currently
supported versions are also hosted on the later.  This change limits
itself to change the URLs, while keeping the fetched files the same
(as can be evidenced by the unchanged hashes).

Documentation and the "vm tests" fedora definition were also updated.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Yash Mankad <ymankad@redhat.com>
Message-Id: <20190904005218.12536-1-crosa@redhat.com>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 4d828a5135f..b47e89cfca6 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -451,15 +451,15 @@ of <protocol>.
 
 Example: boot from a remote Fedora 20 live ISO image
 @example
-@value{qemu_system_x86} --drive media=cdrom,file=http://dl.fedoraproject.org/pub/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
+@value{qemu_system_x86} --drive media=cdrom,file=https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
 
-@value{qemu_system_x86} --drive media=cdrom,file.driver=http,file.url=http://dl.fedoraproject.org/pub/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
+@value{qemu_system_x86} --drive media=cdrom,file.driver=http,file.url=http://archives.fedoraproject.org/pub/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
 @end example
 
 Example: boot from a remote Fedora 20 cloud image using a local overlay for
 writes, copy-on-read, and a readahead of 64k
 @example
-qemu-img create -f qcow2 -o backing_file='json:@{"file.driver":"http",, "file.url":"https://dl.fedoraproject.org/pub/fedora/linux/releases/20/Images/x86_64/Fedora-x86_64-20-20131211.1-sda.qcow2",, "file.readahead":"64k"@}' /tmp/Fedora-x86_64-20-20131211.1-sda.qcow2
+qemu-img create -f qcow2 -o backing_file='json:@{"file.driver":"http",, "file.url":"http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/20/Images/x86_64/Fedora-x86_64-20-20131211.1-sda.qcow2",, "file.readahead":"64k"@}' /tmp/Fedora-x86_64-20-20131211.1-sda.qcow2
 
 @value{qemu_system_x86} -drive file=/tmp/Fedora-x86_64-20-20131211.1-sda.qcow2,copy-on-read=on
 @end example
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 2504ef01507..8a9a314ab49 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -76,8 +76,9 @@ class BootLinuxConsole(Test):
         :avocado: tags=arch:x86_64
         :avocado: tags=machine:pc
         """
-        kernel_url = ('https://download.fedoraproject.org/pub/fedora/linux/'
-                      'releases/29/Everything/x86_64/os/images/pxeboot/vmlinuz')
+        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
+                      '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
+                      '/vmlinuz')
         kernel_hash = '23bebd2680757891cf7adedb033532163a792495'
         kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
 
@@ -250,8 +251,9 @@ class BootLinuxConsole(Test):
         :avocado: tags=arch:aarch64
         :avocado: tags=machine:virt
         """
-        kernel_url = ('https://download.fedoraproject.org/pub/fedora/linux/'
-                      'releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz')
+        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
+                      '/linux/releases/29/Everything/aarch64/os/images/pxeboot'
+                      '/vmlinuz')
         kernel_hash = '8c73e469fc6ea06a58dc83a628fc695b693b8493'
         kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
 
@@ -271,8 +273,9 @@ class BootLinuxConsole(Test):
         :avocado: tags=arch:arm
         :avocado: tags=machine:virt
         """
-        kernel_url = ('https://download.fedoraproject.org/pub/fedora/linux/'
-                      'releases/29/Everything/armhfp/os/images/pxeboot/vmlinuz')
+        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
+                      '/linux/releases/29/Everything/armhfp/os/images/pxeboot'
+                      '/vmlinuz')
         kernel_hash = 'e9826d741b4fb04cadba8d4824d1ed3b7fb8b4d4'
         kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
 
@@ -318,8 +321,9 @@ class BootLinuxConsole(Test):
         :avocado: tags=arch:s390x
         :avocado: tags=machine:s390_ccw_virtio
         """
-        kernel_url = ('https://download.fedoraproject.org/pub/fedora-secondary/'
-                      'releases/29/Everything/s390x/os/images/kernel.img')
+        kernel_url = ('https://archives.fedoraproject.org/pub/archive'
+                      '/fedora-secondary/releases/29/Everything/s390x/os/images'
+                      '/kernel.img')
         kernel_hash = 'e8e8439103ef8053418ef062644ffd46a7919313'
         kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
 
@@ -360,8 +364,9 @@ class BootLinuxConsole(Test):
         :avocado: tags=arch:ppc64
         :avocado: tags=machine:pseries
         """
-        kernel_url = ('https://download.fedoraproject.org/pub/fedora-secondary/'
-                      'releases/29/Everything/ppc64le/os/ppc/ppc64/vmlinuz')
+        kernel_url = ('https://archives.fedoraproject.org/pub/archive'
+                      '/fedora-secondary/releases/29/Everything/ppc64le/os'
+                      '/ppc/ppc64/vmlinuz')
         kernel_hash = '3fe04abfc852b66653b8c3c897a59a689270bc77'
         kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
 
diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux_initrd.py
index 23be5a63aa8..c61d9826a45 100644
--- a/tests/acceptance/linux_initrd.py
+++ b/tests/acceptance/linux_initrd.py
@@ -54,8 +54,9 @@ class LinuxInitrd(Test):
         QEMU has supported up to 4 GiB initrd for recent kernel
         Expect guest can reach 'Unpacking initramfs...'
         """
-        kernel_url = ('https://mirrors.kernel.org/fedora/releases/28/'
-                      'Everything/x86_64/os/images/pxeboot/vmlinuz')
+        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
+                      '/linux/releases/28/Everything/x86_64/os/images/pxeboot/'
+                      'vmlinuz')
         kernel_hash = '238e083e114c48200f80d889f7e32eeb2793e02a'
         kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
         max_size = 2 * (1024 ** 3) + 1
diff --git a/tests/vm/fedora b/tests/vm/fedora
index e8fa5bf0d21..7fec1479fb7 100755
--- a/tests/vm/fedora
+++ b/tests/vm/fedora
@@ -23,7 +23,7 @@ class FedoraVM(basevm.BaseVM):
     name = "fedora"
     arch = "x86_64"
 
-    base = "http://dl.fedoraproject.org/pub/fedora/linux/releases/30/"
+    base = "https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/30/"
     link = base + "Server/x86_64/iso/Fedora-Server-netinst-x86_64-30-1.2.iso"
     repo = base + "Server/x86_64/os/"
     full = base + "Everything/x86_64/os/"
-- 
2.20.1


