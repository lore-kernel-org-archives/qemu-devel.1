Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2FBC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:01:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8656F2087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="holC5qKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8656F2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cP6-0005jm-6h
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5c3x-0000xy-AN
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5c3v-0003Vo-6T
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:33 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:52318)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5c3u-0003UF-MK
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:30 -0400
Received: by mail-wm1-x334.google.com with SMTP id t17so221542wmi.2
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JTL/FheK7UxEeMxwOW9JyHS60K9JSq+RkXWJ74ocsQk=;
 b=holC5qKN5z20UzdvT6rEJ9Vj/2iK4ltydUxH6hoAFwNpriOfmGLxgwfKi9UkG6Gk1l
 blg4cFHHJ4P+NzbQZA4C4IK9qCf2fVsppKJL6C+KgMmypUbcR8Gqim5CbL/r5Gdt9Z7A
 Tx/1zVOe2KROncYtSGJEycUOFS49oO4AD7b81FI8hYFF56TyHvD21pbohBWNw9Z2tXLF
 RMNZV9PiaTk9Q9IkgFYtyFyIRIV4n8ZnED8C4ElgvVpFVzMS44JmW9SRXV9eRZ7UKlh/
 ChkIJMr5SDhUfLlC1JgI3I8OiDZu6HEsjNWWawhcum4rKKHaUXdejj3mRy0XeOFvIONK
 qEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JTL/FheK7UxEeMxwOW9JyHS60K9JSq+RkXWJ74ocsQk=;
 b=ZYEjixCgzSE4SnIHYRYnmjrXIk/Gajcq+lh9hUnU5nQfXSoY0FBeojzgXyStSzyEyt
 /4439nM4aRn2Dt6/WUB0+eDNY6CwnqwlQtRDF3U9qAKRfngVwhOXU+rSqm7X/orkAovv
 KBdnT1jtdjXQ8jsJW6M8U4llnzSfcnLTNy+ui8PzZaQPS/KIvHxpf6g5IDKmOGRKkzWB
 6tVx5etsutVeUTNdes5rdHr243fWehSNOMs36uFeB6DhuNGhp0H8HZ1xHZtJqoRWMbft
 ujV8TnW5Uc2OsLrizPFCB2+ufv7HlXu6uj2YXNBzlrA1IcxFDWkHf10s8KeOaTohpL/i
 YX2w==
X-Gm-Message-State: APjAAAVTnWN6fyZU88lkbsAUrzzqgjPM/kJSbkIxJb6exIgOgpTRGHTJ
 2E4JKtKqZDM1S28A5FwxfOD4vQ==
X-Google-Smtp-Source: APXvYqwBoDIbDpzzpzx6KevZ3pU2EbbwPWqLm03lNuxeq30cZg4F7feO72PGNokxLo537f2+/hlv5w==
X-Received: by 2002:a1c:9ecb:: with SMTP id h194mr111228wme.35.1567629569522; 
 Wed, 04 Sep 2019 13:39:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s26sm19428810wrs.63.2019.09.04.13.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:39:26 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0C7B51FFC0;
 Wed,  4 Sep 2019 21:30:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:30:11 +0100
Message-Id: <20190904203013.9028-41-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
Subject: [Qemu-devel] [PATCH v1 40/42] Fedora images: use URLs from stable
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
Cc: fam@euphon.net, Yash Mankad <ymankad@redhat.com>, berrange@redhat.com,
 stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 qemu-doc.texi                          |  6 +++---
 tests/acceptance/boot_linux_console.py | 25 +++++++++++++++----------
 tests/acceptance/linux_initrd.py       |  5 +++--
 tests/vm/fedora                        |  2 +-
 4 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 577d1e83764..37795f86fb6 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -440,15 +440,15 @@ of <protocol>.
 
 Example: boot from a remote Fedora 20 live ISO image
 @example
-qemu-system-x86_64 --drive media=cdrom,file=http://dl.fedoraproject.org/pub/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
+qemu-system-x86_64 --drive media=cdrom,file=https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
 
-qemu-system-x86_64 --drive media=cdrom,file.driver=http,file.url=http://dl.fedoraproject.org/pub/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
+qemu-system-x86_64 --drive media=cdrom,file.driver=http,file.url=http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
 @end example
 
 Example: boot from a remote Fedora 20 cloud image using a local overlay for
 writes, copy-on-read, and a readahead of 64k
 @example
-qemu-img create -f qcow2 -o backing_file='json:@{"file.driver":"http",, "file.url":"https://dl.fedoraproject.org/pub/fedora/linux/releases/20/Images/x86_64/Fedora-x86_64-20-20131211.1-sda.qcow2",, "file.readahead":"64k"@}' /tmp/Fedora-x86_64-20-20131211.1-sda.qcow2
+qemu-img create -f qcow2 -o backing_file='json:@{"file.driver":"http",, "file.url":"http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/20/Images/x86_64/Fedora-x86_64-20-20131211.1-sda.qcow2",, "file.readahead":"64k"@}' /tmp/Fedora-x86_64-20-20131211.1-sda.qcow2
 
 qemu-system-x86_64 -drive file=/tmp/Fedora-x86_64-20-20131211.1-sda.qcow2,copy-on-read=on
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


