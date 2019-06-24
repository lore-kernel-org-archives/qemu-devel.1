Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F5BC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 13:55:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA40820820
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 13:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q3YH62h/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA40820820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51364 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfPRO-0007ol-9T
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 09:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41562)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPGI-0006iy-DS
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPGG-0007gJ-Qa
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:58 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:34481)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hfPGG-0007Ph-Fu
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:56 -0400
Received: by mail-wm1-x32e.google.com with SMTP id w9so6397wmd.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 06:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BBiBWMHXigNW/eAwUhEz7VujTp1CJQa4AIKszYpazcU=;
 b=q3YH62h/w752HZ54J+NrTZ9fRDFtw3iQAin8CdHAUxsdOgzE69NHyLlP+zCR7gdcda
 +qgaWN+F+7GTcfF5poyCrDegHuBA5rCG1PXpR42WFZs6OCalj2opQ7w74RwYYYi2l/gO
 LugnhhdYhtcTP+3MN7pC3S2OIN1EhfcKplGgo6GPgaFszyzsPSs0gJhwIXlXIjStPa0p
 9/0KRKiH76+0NwqaIh3TwNp9y+OjbGpfwa9Hmr/FgYhd6O1lD4yx37o0AdqHJ/k/C6Me
 zuYQrpuZAISOrxsLUxW5qC/Yic53Jz3b8OwD1h5lGpl8PZkvQxcCkOLuxfreG9Lr/A0h
 yqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BBiBWMHXigNW/eAwUhEz7VujTp1CJQa4AIKszYpazcU=;
 b=i7+naUuYnlWYWVREtgemlgFHLJX472mekRnCoxCuZowVuIRTRbPjFh6WlAF132FS3C
 didUQtdHN5PRcphVnLzE4XmgHeOq10Ypbg9p8JPOQqYgRI0kjvpJhgZoc+chkOH1+TYH
 5PP5uvT5aMyF61LmvKkfxdM19n5qY9g6+aCH+nqoRE7JFzhCYfg/XdXfFRk1Caw/epXa
 DlDoXiLPhf4HtPPf2EQ+MBf87mR5PdpI4OOmiSfwn7CRYju5TzE8D8iM08Sp74QgYH7C
 baL6ts/Zxe2yXB9KEKLx7R4mvfK1fFDbGT1gTVzoJiipvBzKuPQzXAh8XJpvG0KBzaXI
 +bEg==
X-Gm-Message-State: APjAAAXn/BksNfNFZZ42HYWBj4PB37OXh/bfruKzdaP29ZJBuKekn66J
 BWbruXKxIqQmc95Bqnui/TxsHEHof44=
X-Google-Smtp-Source: APXvYqw3jnUlfsghzs2t4x6YXTroZsL0RvSO0Z4luQ65XHQs5n31X0jp4p998GRNeyoPs4Lb0Um4sQ==
X-Received: by 2002:a1c:4b1a:: with SMTP id y26mr16112566wma.105.1561383824395; 
 Mon, 24 Jun 2019 06:43:44 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id w67sm11468568wma.24.2019.06.24.06.43.39
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 06:43:41 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 328A21FF98;
 Mon, 24 Jun 2019 14:43:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon, 24 Jun 2019 14:43:26 +0100
Message-Id: <20190624134337.10532-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624134337.10532-1-alex.bennee@linaro.org>
References: <20190624134337.10532-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
Subject: [Qemu-devel] [PULL 08/19] tests/vm: proper guest shutdown
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

When not running in snapshot mode ask the guest to poweroff and wait for
this to finish instead of simply quitting qemu, so the guest can flush
pending updates to disk.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190617043858.8290-5-kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 395eefaec9..f27178f3c7 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -51,6 +51,8 @@ class BaseVM(object):
     name = "#base"
     # The guest architecture, to be overridden by subclasses
     arch = "#arch"
+    # command to halt the guest, can be overridden by subclasses
+    poweroff = "poweroff"
     def __init__(self, debug=False, vcpus=None):
         self._guest = None
         self._tmpdir = os.path.realpath(tempfile.mkdtemp(prefix="vm-test-",
@@ -202,6 +204,10 @@ class BaseVM(object):
     def wait(self):
         self._guest.wait()
 
+    def graceful_shutdown(self):
+        self.ssh_root(self.poweroff)
+        self._guest.wait()
+
     def qmp(self, *args, **kwargs):
         return self._guest.qmp(*args, **kwargs)
 
@@ -278,11 +284,13 @@ def main(vmcls):
         traceback.print_exc()
         return 2
 
-    if args.interactive:
-        if vm.ssh(*cmd) == 0:
-            return 0
+    exitcode = 0
+    if vm.ssh(*cmd) != 0:
+        exitcode = 3
+    if exitcode != 0 and args.interactive:
         vm.ssh()
-        return 3
-    else:
-        if vm.ssh(*cmd) != 0:
-            return 3
+
+    if not args.snapshot:
+        vm.graceful_shutdown()
+
+    return exitcode
-- 
2.20.1


