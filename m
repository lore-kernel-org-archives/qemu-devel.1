Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC7EC4321A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 15:03:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE0E2208E3
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 15:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uPkDFMNn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0E2208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhEsu-0004np-Tl
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 11:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37897)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hhEqj-00037C-0B
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 11:01:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hhEqh-0007G4-BO
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 11:01:08 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52719)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hhEqf-0007Bd-Ai
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 11:01:06 -0400
Received: by mail-wm1-x342.google.com with SMTP id s3so11744905wms.2
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2019 08:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gpp9Udz/jFQYQuXUbwF4OjuIMxDQuVUIk0bf5J+Kovs=;
 b=uPkDFMNnvQ0vTqQ1RZRMBzvZ5kKa1wW8Mn3zLS4odmbsJaRJ9mXweXTNQ1eK01dP8q
 s9atfzAe8hrA9odLutk8w5YcSrBeOzZQyXJFS0vaW3h+A5kqT5LMQGEWBo2HSHD6cUR9
 GrYDrW2SUBFM8tcZ2EldgWEw5gK717Wd1BYGXASNS7lQR1fTWzMvecxaXWDa173AKBcb
 dnX0D+SsEy4cFORSh8iRe7VvHrsw+snPbVe2ZzVSHbG7iKU05hqQpQlMKjIM7PwgTrIF
 oCDm2R0Uuv2E1f+C9uOJhP0QAOzsMBTteAJoP9FsC00C0RnkswTstD492WiOxME0UhWs
 +XKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=gpp9Udz/jFQYQuXUbwF4OjuIMxDQuVUIk0bf5J+Kovs=;
 b=cE9uEgXhOUUn2nnop7vB9fbQyyJEvcvRQKx2OMnjC/73JplyKCiohIurjV5/2FJdt6
 beqgl8b7TZ+74vVJESGhGvH92FRzP7lweTB9+EHIVGTEUCT+ePSVLYGXGTsUoKEbXU7c
 XDTY9ZUXJU07Z5oLSzcCuezJ8bvQ2ONVPBU70fGWW/LGRmtESK2BvR2QgDYLwwHo5ZYU
 OHQq9awpO9CFRn1dkm17L6VVPuiF4PrGbCAimDEMYOGcOxFzaCEhljMdw7IHL8AUykuE
 NQI6WMWHd+X/IRDz9Yqrdg2d4/GD5aLT1GQb4hfMo2/V+Ksk98XAFO6/dS25pVp4+hVo
 k0+Q==
X-Gm-Message-State: APjAAAWEdpL5WKuisD0GhM0xxXdkWuMZtsWGuzVSel005n1/OWgWvd4H
 Gptrb1WUIN4nOgINDnrO2WZWr5DU
X-Google-Smtp-Source: APXvYqypS6qIcngmcEQnpZSo5b0wbCVexxm1XyKXUQVqbAlGsZFXijy3GzVf+Jjcj3SUjVfg2c4lvw==
X-Received: by 2002:a1c:b6d4:: with SMTP id g203mr10892189wmf.19.1561820460058; 
 Sat, 29 Jun 2019 08:01:00 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id h19sm5146231wrb.81.2019.06.29.08.00.58
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 29 Jun 2019 08:00:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Sat, 29 Jun 2019 17:00:55 +0200
Message-Id: <20190629150056.9071-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190629150056.9071-1-f4bug@amsat.org>
References: <20190629150056.9071-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH 1/2] tests/acceptance: Add test of NeXTcube
 framebuffer using OCR
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a test of the NeXTcube framebuffer using the Tesseract OCR
engine on a screenshot of the framebuffer device.

The test is very quick:

  $ avocado --show=app,ocr run tests/acceptance/machine_m68k_nextcube.py
  JOB ID     : f7d3c27976047036dc568183baf64c04863d9985
  JOB LOG    : ~/avocado/job-results/job-2019-06-29T16.18-f7d3c27/job.log
  (1/1) tests/acceptance/machine_m68k_nextcube.py:NextCubeMachine.test_bootrom_framebuffer: |ocr:
  ue r pun Honl'ﬂx ; 5‘ 55‘
  avg ncaaaaa 25 MHZ, memary jag m
  Backplane slat «a
  Ethernet address a a r a r3 2
  Memgry sackets aea canflqured far 16MB Darlly page made stMs but have 16MB page made stMs )nstalled
  Memgry sackets a and 1 canflqured far 16MB Darlly page made stMs but have 16MB page made stMs )nstalled
  [...]
  Yestlnq the rpu, 5::
  system test raneg Errar egge 51
  Egg: cammand
  Default pggc devlce nut fauna
  NEXY>I
  PASS (3.59 s)
  RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
  JOB TIME   : 3.97 s

Documentation on how to install tesseract:
  https://github.com/tesseract-ocr/tesseract/wiki#installation

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/machine_m68k_nextcube.py | 50 +++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 tests/acceptance/machine_m68k_nextcube.py

diff --git a/tests/acceptance/machine_m68k_nextcube.py b/tests/acceptance/machine_m68k_nextcube.py
new file mode 100644
index 0000000000..cf061292a7
--- /dev/null
+++ b/tests/acceptance/machine_m68k_nextcube.py
@@ -0,0 +1,50 @@
+# Functional test that boots a VM and run OCR on the framebuffer
+#
+# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import logging
+import time
+import distutils.spawn
+
+from avocado import skipUnless
+from avocado_qemu import Test
+from avocado.utils import process
+
+
+class NextCubeMachine(Test):
+
+    timeout = 15
+
+    @skipUnless(distutils.spawn.find_executable('tesseract'),
+                'tesseract OCR tool not installed')
+    def test_bootrom_framebuffer(self):
+        """
+        :avocado: tags=arch:m68k
+        :avocado: tags=machine:next-cube
+        :avocado: tags=device:framebuffer
+        """
+        rom_url = ('http://www.nextcomputers.org/NeXTfiles/Software/ROM_Files/'
+                   '68040_Non-Turbo_Chipset/Rev_2.5_v66.BIN')
+        rom_hash = 'b3534796abae238a0111299fc406a9349f7fee24'
+        rom_path = self.fetch_asset(rom_url, asset_hash=rom_hash)
+
+        self.vm.set_machine('next-cube')
+        self.vm.add_args('-bios', rom_path)
+        self.vm.launch()
+
+        self.log.info('VM launched, waiting for display')
+        # FIXME how to catch the 'displaysurface_create 1120x832' trace-event?
+        time.sleep(2)
+
+        screenshot_path = self.workdir + "dump"
+        self.vm.command('human-monitor-command',
+                        command_line='screendump %s' % screenshot_path)
+
+        console_logger = logging.getLogger('ocr')
+        proc = process.run("tesseract %s stdout" % screenshot_path)
+        console_logger.debug(proc.stdout_text)
+        self.assertIn('Backplane', proc.stdout_text)
+        self.assertIn('Ethernet address', proc.stdout_text)
-- 
2.19.1


