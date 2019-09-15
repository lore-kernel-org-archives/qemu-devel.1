Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5977FC4CEC7
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 21:22:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A8292067D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 21:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqVlhsak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8292067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9byl-0005Wl-UY
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 17:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9bvz-0003F2-LG
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 17:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9bvy-0000jt-7d
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 17:19:51 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:38911)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9bvv-0000hm-B4; Sun, 15 Sep 2019 17:19:47 -0400
Received: by mail-wm1-x331.google.com with SMTP id o184so7969210wme.3;
 Sun, 15 Sep 2019 14:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DGAkei/pdxmAWxadGqaNiywfyQsm6bUbjLXzI6Q0mkQ=;
 b=gqVlhsakY4WwthiZ/4rpLQoe0cQ/w5s2gp2S9VHc2rxxIHPaBlk/2/fJmdnOkxaXV3
 HjxN5npoE1vse3v5Di7kU8DC/zf0FZtlwV8aTEmNG9g7a9b9j/N69VxzR6VRfw89ndTz
 6b8lhaGJaoxdePXgauZTxJgssBEcihJf5LMVSR/1y/JjImaCySAv9H4wHNJvcWAqZB+/
 vfowLZsEK5hC4Vk4WmRTwl0HsslBW8PM9OJmGk2iGUI+MxA7RhAQ9ykQEg5dPdmuYTto
 2B/BwXuIfQimiemEz8Goe99aREALVfrXO0Z/g1lDDhH6iiHN5zQfQNVsWLmUWGqhOQC4
 iIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=DGAkei/pdxmAWxadGqaNiywfyQsm6bUbjLXzI6Q0mkQ=;
 b=KBkoBGBze9v/P0me5AGjfNvmOsfSUmDEIGiXdKnRHmHrX7FhjUBYRNDknH4BP50fzl
 OMZ7VlatJ9IJXx9F7+Gmbh2jXDzzpuIQHUVlflFZbZex9jnZuauDE4Erppcx47NU3sUv
 wejKrkPTUVWghDqRaobRAqALEXCaDl0vlJmX31RaYfoBhhVSTJZtltFcPbPRt0DDoPPe
 iYIiHaxk/2/+NBWi5ch2VG3TjSf6imtqegzQs4UcnUO6Z1LALbnNzLz9vE9sbgzZIqVg
 wrIsjezK/geLCsJi8bc1flV8Csh9FTTJwqVxlkFj3FCmiw9GK9ZKiV/sE72v4+Rhn/ky
 wtVQ==
X-Gm-Message-State: APjAAAXnMcFdzWzZcmrWtmsIkj/Mp0t6mWZBzyP5zqDcHTaMX3J/wrZ7
 hh0eKtrGmmw2iIXRGnOHqMUZlOCt
X-Google-Smtp-Source: APXvYqxT1oHvcHehO4HnabRoI5CY2Fl1X53OM8eA6FeF9Z0umxT6QwcM87BtOvjn7DHuizNwGAEosQ==
X-Received: by 2002:a1c:bcd6:: with SMTP id
 m205mr11009795wmf.129.1568582385975; 
 Sun, 15 Sep 2019 14:19:45 -0700 (PDT)
Received: from localhost.localdomain (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id s1sm50271021wrg.80.2019.09.15.14.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 14:19:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Date: Sun, 15 Sep 2019 23:19:35 +0200
Message-Id: <20190915211940.30427-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190915211940.30427-1-f4bug@amsat.org>
References: <20190915211940.30427-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
Subject: [Qemu-devel] [PATCH v2 1/6] tests/acceptance: Add test that runs
 NetBSD 4.0 installer on PRep/40p
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As of this commit, NetBSD 4.0 is very old. However it is enough to
test the PRep/40p machine.

User case from:
http://mail-index.netbsd.org/port-prep/2017/04/11/msg000112.html

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Installers after 4.0 doesn't work anymore, not sure if this is a
problem from the QEMU model or from NetBSD.
---
 MAINTAINERS                      |  1 +
 tests/acceptance/ppc_prep_40p.py | 63 ++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 tests/acceptance/ppc_prep_40p.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 50eaf005f4..ce809c7dee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1068,6 +1068,7 @@ F: hw/timer/m48t59-isa.c
 F: include/hw/isa/pc87312.h
 F: include/hw/timer/m48t59.h
 F: pc-bios/ppc_rom.bin
+F: tests/acceptance/machine_ppc_prep_40p.py
 
 sPAPR
 M: David Gibson <david@gibson.dropbear.id.au>
diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep_40p.py
new file mode 100644
index 0000000000..53f2d2ecf0
--- /dev/null
+++ b/tests/acceptance/ppc_prep_40p.py
@@ -0,0 +1,63 @@
+# Functional test that boots a PReP/40p machine and checks its serial console.
+#
+# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later. See the COPYING file in the top-level directory.
+
+import os
+import logging
+
+from avocado import skipIf
+from avocado_qemu import Test
+
+
+class IbmPrep40pMachine(Test):
+
+    timeout = 60
+
+    # TODO refactor to MachineTest
+    def wait_for_console_pattern(self, success_message, failure_message=None):
+        """
+        Waits for messages to appear on the console, while logging the content
+
+        :param success_message: if this message appears, test succeeds
+        :param failure_message: if this message appears, test fails
+        """
+        console = self.vm.console_socket.makefile()
+        console_logger = logging.getLogger('console')
+        while True:
+            msg = console.readline().strip()
+            if not msg:
+                continue
+            console_logger.debug(msg)
+            if success_message in msg:
+                break
+            if failure_message and failure_message in msg:
+                fail = 'Failure message found in console: %s' % failure_message
+                self.fail(fail)
+
+    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
+    def test_factory_firmware_and_netbsd(self):
+        """
+        :avocado: tags=arch:ppc
+        :avocado: tags=machine:40p
+        :avocado: tags=slowness:high
+        """
+        bios_url = ('ftp://ftp.boulder.ibm.com/rs6000/firmware/'
+                    '7020-40p/P12H0456.IMG')
+        bios_hash = '1775face4e6dc27f3a6ed955ef6eb331bf817f03'
+        bios_path = self.fetch_asset(bios_url, asset_hash=bios_hash)
+        drive_url = ('https://ftp.netbsd.org/pub/NetBSD/NetBSD-archive/'
+                     'NetBSD-4.0/prep/installation/floppy/generic_com0.fs')
+        drive_hash = 'dbcfc09912e71bd5f0d82c7c1ee43082fb596ceb'
+        drive_path = self.fetch_asset(drive_url, asset_hash=drive_hash)
+
+        self.vm.set_machine('40p')
+        self.vm.set_console()
+        self.vm.add_args('-bios', bios_path,
+                         '-fda', drive_path)
+        self.vm.launch()
+        os_banner = 'NetBSD 4.0 (GENERIC) #0: Sun Dec 16 00:49:40 PST 2007'
+        self.wait_for_console_pattern(os_banner)
+        self.wait_for_console_pattern('Model: IBM PPS Model 6015')
-- 
2.20.1


