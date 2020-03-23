Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3111C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:19:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69B2C20409
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LY5EM5cE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B2C20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGPnD-0006EM-Cc
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 12:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jGPjW-0000ur-4w
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:15:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jGPjU-0002PM-SR
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:15:22 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:38872)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jGPjU-0002OW-MK
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:15:20 -0400
Received: by mail-wr1-x42b.google.com with SMTP id s1so17840572wrv.5
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 09:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QfCspCOrWTOEmoOgXMfkxkaEAryK0S2ORKOBU3lMEoo=;
 b=LY5EM5cEeLxNuktfDQgM8gb0i/09DHoJnlcC8otReBCmWQiB2F7iMMMCmc/TOKb4B1
 MGQ8K+3MXScuiFLvfWxsNRpGx/5zoKcKJDSFQ5FRhlLVh+CEXrcxDSmegHDcbh7mJypx
 XmPQZ10y6D8Xj+BE2vZ+66mMGBasGDvcWgjjRvWzF/SXX6hxAWTjGQG8i4k206LMk4mP
 micpRJ3FuRc0miZGd5SOVMqPeeMWluHbZ+/kxqRcYFori3oYEC7eOSX7WaJnczjo06Bl
 4z5qsCUvKzWfu4OZDgSuFZfmwhOZ6jusfvaCFCIr+2qvF2u4lA0EAofFw4tjyVrODj7O
 dxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QfCspCOrWTOEmoOgXMfkxkaEAryK0S2ORKOBU3lMEoo=;
 b=hnm2N1NqF85tVub3+u6fXog7ItOs/Z2Ujmqk2FfJJzyU1kcsB56138YNIYpJDKf358
 QBWMGMvyT/bdNHabyLfr2kv8ZeakbUWHmnciuBVGu4FY7JQf/niWXCdRSY9FRiaHKom0
 iylPQZ0o9QOJPP69yy1duAIBytx89Wh/O8NiePPhJbdvZC8HTzGeeO8Q9CPxePsoft5U
 LXjUtUU/qWj7VjHIHgzuigNpq3yydbWeN+EVXyktm/rBHDfPfybU0Af1i32dAJanNZBV
 S5slHYZaL0bTtAxBnxgylIaJUCXeNRSbRKGudER8YY5PHyB2FvRT9+9PnU9gKmoeyyBE
 w98w==
X-Gm-Message-State: ANhLgQ03Zfxal1393KWC82L7arnHiECIoEyeo0xRVHweT0/++V+P2k7X
 5yfPZt75h2UHdH5i5aWf89dTAg==
X-Google-Smtp-Source: ADFU+vvKix1UIwX+Fqk//q2lQep0afIQv8s2xCCNoeW4TFI3fpCzY50hyn/eUzlUX6W05z6AdcW4mw==
X-Received: by 2002:a5d:4984:: with SMTP id r4mr11092511wrq.121.1584980119532; 
 Mon, 23 Mar 2020 09:15:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g195sm40405wme.32.2020.03.23.09.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 09:15:17 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1CDB51FF8C;
 Mon, 23 Mar 2020 16:15:15 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 02/11] tests/vm: move vga setup
Date: Mon, 23 Mar 2020 16:15:05 +0000
Message-Id: <20200323161514.23952-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200323161514.23952-1-alex.bennee@linaro.org>
References: <20200323161514.23952-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Move '-device VGA' from basevm.py to the guests, so they have
the chance to opt out and run without display device.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200310083218.26355-3-kraxel@redhat.com>
---
 tests/vm/basevm.py   | 1 -
 tests/vm/fedora      | 1 +
 tests/vm/freebsd     | 1 +
 tests/vm/netbsd      | 1 +
 tests/vm/openbsd     | 1 +
 tests/vm/ubuntu.i386 | 5 ++++-
 6 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index c53fd354d95..cffe7c4600e 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -179,7 +179,6 @@ class BaseVM(object):
 
     def boot(self, img, extra_args=[]):
         args = self._args + [
-            "-device", "VGA",
             "-drive", "file=%s,if=none,id=drive0,cache=writeback" % img,
             "-device", "virtio-blk,drive=drive0,bootindex=0"]
         args += self._data_args + extra_args
diff --git a/tests/vm/fedora b/tests/vm/fedora
index 4843b4175e0..bd9c6cf295c 100755
--- a/tests/vm/fedora
+++ b/tests/vm/fedora
@@ -82,6 +82,7 @@ class FedoraVM(basevm.BaseVM):
         self.boot(img_tmp, extra_args = [
             "-bios", "pc-bios/bios-256k.bin",
             "-machine", "graphics=off",
+            "-device", "VGA",
             "-cdrom", iso
         ])
         self.console_init(300)
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 86770878b67..58166766d91 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -92,6 +92,7 @@ class FreeBSDVM(basevm.BaseVM):
         self.boot(img_tmp, extra_args = [
             "-bios", "pc-bios/bios-256k.bin",
             "-machine", "graphics=off",
+            "-device", "VGA",
             "-cdrom", iso
         ])
         self.console_init()
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 55590f46015..f3257bc245a 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -86,6 +86,7 @@ class NetBSDVM(basevm.BaseVM):
         self.boot(img_tmp, extra_args = [
             "-bios", "pc-bios/bios-256k.bin",
             "-machine", "graphics=off",
+            "-device", "VGA",
             "-cdrom", iso
         ])
         self.console_init()
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index ab6abbedab5..0b705f49452 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -82,6 +82,7 @@ class OpenBSDVM(basevm.BaseVM):
         self.boot(img_tmp, extra_args = [
             "-bios", "pc-bios/bios-256k.bin",
             "-machine", "graphics=off",
+            "-device", "VGA",
             "-cdrom", iso
         ])
         self.console_init()
diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index 3266038fbde..15707753353 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -36,7 +36,10 @@ class UbuntuX86VM(basevm.BaseVM):
         img_tmp = img + ".tmp"
         subprocess.check_call(["cp", "-f", cimg, img_tmp])
         self.exec_qemu_img("resize", img_tmp, "50G")
-        self.boot(img_tmp, extra_args = ["-cdrom", self.gen_cloud_init_iso()])
+        self.boot(img_tmp, extra_args = [
+            "-device", "VGA",
+            "-cdrom", self.gen_cloud_init_iso()
+        ])
         self.wait_ssh()
         self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
         self.ssh_root_check("apt-get update")
-- 
2.20.1


