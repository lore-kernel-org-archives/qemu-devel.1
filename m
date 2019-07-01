Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB90C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:05:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A08AF20665
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aA6bVM03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A08AF20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhyY5-00087N-3J
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 11:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41185)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hhyKS-0000Qx-LC
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:34:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hhyKL-0003YL-LS
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:34:47 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40906)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hhyKJ-0003WG-Ot
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:34:43 -0400
Received: by mail-wr1-x443.google.com with SMTP id p11so14367338wre.7
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 08:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uK5bPKqQSOVaNTPYWlOvXm0O51fNBjeVOdDX+K+ANYs=;
 b=aA6bVM03lga4HuYVODqmDwmjWd+pkfPTFIcAN9i9wf7gEgNoX6s7cg1E58PJ5OavcN
 wpqaXnZzEAy+ErLa5CloUz6/Ikt3KIqkwyDjl4G4CfF6aI6Y4iyz3ise2zSeizNNvn8+
 3mvRwN4Qu2QIFDCuWe6EAsgGTpMK7z5WXSBIW664bTWUJJcvemwJMeN/R5jR9yERP6D6
 8tD1VWM+Qz/FgVkar67pVfxdUzZdZ0GAL4+QhEPa18CITOtiEC9SXO9KV9MfNJ3cQ7v4
 e4VIpqa26JcqGezenHE/wEbsHuh3xV6bOSlDHlw23JPv3IckzI8NRE2teDwYe5GvZs/U
 ZhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=uK5bPKqQSOVaNTPYWlOvXm0O51fNBjeVOdDX+K+ANYs=;
 b=Fo8oR7/d7drJieNz+AlORAnSvJOEWu/filR7p9LsV+KgJ6NydeMXD7XkGgfmJZfwPb
 kAM2a9boj7QwjTatcXv2uf8ooX9OVN+2DfZFYFfbVmuiZE71PKLyz9x5528zSPZPbDis
 pETQwSeHROAFZ6MAl755P93XwfTwzWqSBOFhgkicAmSm6KxnBjt+aQlOgbk/o/7s5v1S
 ctuyyuHDBgZgHsAM1fPJEDs4I5KqwEk1mRZjiqbmdDq+xXQYc9cgUxY12sC9vtaLDcod
 yuohrmp+lnGEJ5bnFLtqX3eR/DnC8wya9/xBCqEBW1nBYV50qBTNvs7886daVMh7USrA
 a03w==
X-Gm-Message-State: APjAAAURdmoTI/oMsjH6uELzDZ93FNTQOENxf37aVktI8jlOG4kKt1vs
 sEdcEI1kiaGEvsDSkC5L+Ec1UkGk
X-Google-Smtp-Source: APXvYqyA007tv98QFkZF3pkS+nMyLMzIgRF4/hjuQYsw8az7khP7FOxMU4iLbdkPl4cPsKArGArAmA==
X-Received: by 2002:a5d:6449:: with SMTP id d9mr1574721wrw.192.1561995280895; 
 Mon, 01 Jul 2019 08:34:40 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id w24sm8922341wmc.30.2019.07.01.08.34.39
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 08:34:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:34:35 +0200
Message-Id: <20190701153436.16579-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190701153436.16579-1-f4bug@amsat.org>
References: <20190701153436.16579-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v2 1/2] tests/acceptance: Add test of NeXTcube
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
v2:
- test fb sizes
- handle 2 versions of teseract
---
 tests/acceptance/machine_m68k_nextcube.py | 102 ++++++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 tests/acceptance/machine_m68k_nextcube.py

diff --git a/tests/acceptance/machine_m68k_nextcube.py b/tests/acceptance/machine_m68k_nextcube.py
new file mode 100644
index 0000000000..f8e514a058
--- /dev/null
+++ b/tests/acceptance/machine_m68k_nextcube.py
@@ -0,0 +1,102 @@
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
+try:
+    from PIL import Image
+    pil_available = True
+except ImportError:
+    pil_available = False
+
+
+def tesseract_available(expected_version):
+    if not distutils.spawn.find_executable('tesseract'):
+        return False
+    res = process.run('tesseract --version')
+    try:
+        version = res.stdout_text.split()[1]
+    except IndexError:
+        version = res.stderr_text.split()[1]
+    return int(version.split('.')[0]) == expected_version
+
+
+class NextCubeMachine(Test):
+
+    timeout = 15
+
+    def check_bootrom_framebuffer(self, screenshot_path):
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
+        self.vm.command('human-monitor-command',
+                        command_line='screendump %s' % screenshot_path)
+
+    @skipUnless(pil_available, 'Python PIL not installed')
+    def test_bootrom_framebuffer_size(self):
+        """
+        :avocado: tags=arch:m68k
+        :avocado: tags=machine:next-cube
+        :avocado: tags=device:framebuffer
+        """
+        screenshot_path = self.workdir + "dump"
+        self.check_bootrom_framebuffer(screenshot_path)
+
+        width, height = Image.open(screenshot_path).size
+        self.assertEqual(width, 1120)
+        self.assertEqual(height, 832)
+
+    @skipUnless(tesseract_available(3), 'tesseract v3 OCR tool not available')
+    def test_bootrom_framebuffer_ocr_with_tesseract_v3(self):
+        """
+        :avocado: tags=arch:m68k
+        :avocado: tags=machine:next-cube
+        :avocado: tags=device:framebuffer
+        """
+        screenshot_path = self.workdir + "dump"
+        self.check_bootrom_framebuffer(screenshot_path)
+
+        console_logger = logging.getLogger('ocr')
+        text = process.run("tesseract %s stdout" % screenshot_path).stdout_text
+        console_logger.debug(text)
+        self.assertIn('Backplane', text)
+        self.assertIn('Ethernet address', text)
+
+    @skipUnless(tesseract_available(4), 'tesseract v4 OCR tool not available')
+    def test_bootrom_framebuffer_ocr_with_tesseract_v4(self):
+        """
+        :avocado: tags=arch:m68k
+        :avocado: tags=machine:next-cube
+        :avocado: tags=device:framebuffer
+        """
+        screenshot_path = self.workdir + "dump"
+        self.check_bootrom_framebuffer(screenshot_path)
+
+        console_logger = logging.getLogger('ocr')
+        proc = process.run("tesseract --oem 1 %s stdout" % screenshot_path)
+        text = proc.stdout_text
+        console_logger.debug(text)
+        self.assertIn('Testing the FPU, SCC', text)
+        self.assertIn('System test failed. Error code 51', text)
+        self.assertIn('Boot command', text)
+        self.assertIn('Next>', text)
-- 
2.19.1


