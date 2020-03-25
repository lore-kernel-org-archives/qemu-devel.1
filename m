Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79346C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C7012076A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tld5UFd6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7012076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7nu-0008NH-7Q
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jH7l2-0003XM-Jp
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jH7l1-0007z1-A9
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:15:52 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:43484)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jH7l1-0007yQ-3F
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:15:51 -0400
Received: by mail-wr1-x432.google.com with SMTP id b2so3548314wrj.10
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 08:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ztDbOw6DhMgOgSgsUfM4L+NS4o98VZx9Fe9KbZgV6vo=;
 b=tld5UFd6KSF4Sysx1MQ8dGFcKrGuhmtHnChqKVmTbpWphopy4WXXBkPnm5h3lHFqzx
 wc6Wr4vc93T31RKy/qs5oYz52ihfYcvIHuoiV2qujrBQzRIU0wmM5dVuuMtpR10zBRds
 9Kr7DgfpgyNktm/gA/8IdnPjk1eVksIjbLA/aWgrMQBRHegaEI7szpvifVupVtzuAcLD
 5IDihNZnVFTl4mF8aRvSfEP0SrZ58BmBJYEOvyQ70Q73yyTdppCr90+XsrvhaYez4Bag
 sWA1XKzM66nt87/8F3ykJRwUYCrdI5sxhe+GLknbYaoutakPimjWCm6qv8pf9r4eqBDk
 fKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ztDbOw6DhMgOgSgsUfM4L+NS4o98VZx9Fe9KbZgV6vo=;
 b=RfwTa78JHzHaUk1REX9IiHPsCv/esYyPx4G4FN8dO3jRXB8EGR3g0Y62xj2BQJ2KXo
 5lELYAEHMu16coYM7pk8fEMphntxPCJQdI2i7NkqmXJkM6Zf/PvDBs86HSqzC+jrpean
 oc7zlU3l49+jxHEbPhlmA9KSTYQ5L//wDdQ7jGxOWYPRIBPoIER73OjHzqsnGrv8/V9s
 tF0BYPuDsZ/PW+A74frP32ZNsSg5JoM2uaSJRJb0cN/z+rf5ZXhJMXhWp8SMnUV4pnCm
 3cJ4h7nSpx6KuzBPm/r+3V8fe0f0f9qK8wxIvVoMmxv7oZI+GnQmadqDasWhNnaAtQ85
 /vgw==
X-Gm-Message-State: ANhLgQ0JEAt3k01yRkJfsJkaFnrnJQAjjI3Z4p7b+ipp/pUFsEyEnl/A
 po2LrbBvFjLlf0fNqUtzHyi41g==
X-Google-Smtp-Source: ADFU+vtdT1uGEiO/MFMo8nZOPOdPDoChaihjjKYDg3NEG4sEd0+ls1NNvH+H0MMNMoJyh5ooCCT1WQ==
X-Received: by 2002:adf:c648:: with SMTP id u8mr4085356wrg.185.1585149350011; 
 Wed, 25 Mar 2020 08:15:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n9sm6286154wru.50.2020.03.25.08.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 08:15:44 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A01671FF90;
 Wed, 25 Mar 2020 15:15:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 04/11] tests/vm: update NetBSD to 9.0
Date: Wed, 25 Mar 2020 15:15:36 +0000
Message-Id: <20200325151543.32478-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325151543.32478-1-alex.bennee@linaro.org>
References: <20200325151543.32478-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

The installer supports GPT now, so the install workflow has changed a
bit.  Also: run without VGA device.  This works around a bug in the
seabios sercon code and makes the bootloader menu show up on the serial
line, so we can drop the quirk for that.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200310083218.26355-5-kraxel@redhat.com>
Message-Id: <20200323161514.23952-5-alex.bennee@linaro.org>

diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index f3257bc245a..b10c9d429de 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -22,8 +22,8 @@ class NetBSDVM(basevm.BaseVM):
     name = "netbsd"
     arch = "x86_64"
 
-    link = "https://cdn.netbsd.org/pub/NetBSD/NetBSD-8.1/images/NetBSD-8.1-amd64.iso"
-    csum = "718f275b7e0879599bdac95630c5e3f2184700032fdb6cdebf3bdd63687898c48ff3f08f57b89f4437a86cdd8ea07c01a39d432dbb37e1e4b008f4985f98da3f"
+    link = "https://cdn.netbsd.org/pub/NetBSD/NetBSD-9.0/images/NetBSD-9.0-amd64.iso"
+    csum = "34da4882ee61bdbf69f241195a8933dc800949d30b43fc6988da853d57fc2b8cac50cf97a0d2adaf93250b4e329d189c1a8b83c33bd515226f37745d50c33369"
     size = "20G"
     pkgs = [
         # tools
@@ -86,42 +86,31 @@ class NetBSDVM(basevm.BaseVM):
         self.boot(img_tmp, extra_args = [
             "-bios", "pc-bios/bios-256k.bin",
             "-machine", "graphics=off",
-            "-device", "VGA",
             "-cdrom", iso
         ])
         self.console_init()
-        self.console_wait("Primary Bootstrap")
-
-        # serial console boot menu output doesn't work for some
-        # reason, so we have to fly blind ...
-        for char in list("5consdev com0\n"):
-            time.sleep(0.2)
-            self.console_send(char)
-            self.console_consume()
+        self.console_wait_send("3. Drop to boot prompt", "3")
+        self.console_wait_send("> ", "consdev com0\n")
         self.console_wait_send("> ", "boot\n")
 
         self.console_wait_send("Terminal type",            "xterm\n")
         self.console_wait_send("a: Installation messages", "a\n")
-        self.console_wait_send("b: US-English",            "b\n")
         self.console_wait_send("a: Install NetBSD",        "a\n")
         self.console_wait("Shall we continue?")
         self.console_wait_send("b: Yes",                   "b\n")
 
         self.console_wait_send("a: ld0",                   "a\n")
+        self.console_wait_send("a: Guid Partition Table",  "a\n")
         self.console_wait_send("a: This is the correct",   "a\n")
-        self.console_wait_send("b: Use the entire disk",   "b\n")
-        self.console_wait("NetBSD bootcode")
-        self.console_wait_send("a: Yes",                   "a\n")
-        self.console_wait_send("b: Use existing part",     "b\n")
+        self.console_wait_send("b: Use default part",      "b\n")
         self.console_wait_send("x: Partition sizes ok",    "x\n")
-        self.console_wait_send("for your NetBSD disk",     "\n")
         self.console_wait("Shall we continue?")
         self.console_wait_send("b: Yes",                   "b\n")
 
         self.console_wait_send("b: Use serial port com0",  "b\n")
         self.console_wait_send("f: Set serial baud rate",  "f\n")
         self.console_wait_send("a: 9600",                  "a\n")
-        self.console_wait_send("x: Exit",                  "x\n")
+        self.console_wait_send("x: Continue",              "x\n")
 
         self.console_wait_send("a: Full installation",     "a\n")
         self.console_wait_send("a: CD-ROM",                "a\n")
-- 
2.20.1


