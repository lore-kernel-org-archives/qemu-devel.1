Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFFEC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AAD324691
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aeG0pYb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AAD324691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7j8T-0000HW-Iy
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 12:09:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifV-0008DU-Lw
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifU-00025Y-8u
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:17 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:55450)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7ifU-000256-2D
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:16 -0500
Received: by mail-wm1-x334.google.com with SMTP id q9so3813450wmj.5
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=hTbY0nJfRg44cC4x/jkt29PNMvHIJImu3BmtAxBXRUA=;
 b=aeG0pYb/ggqslbXgJm/hF6BjCA4tRiDrvAm8kOn4xhxTdW1suW+X2lH1a0PaqaHj+d
 1edvoZTMikv1vWDxLLgIchq6KuDR8FRp7SmJw/1B8yV+eCjTiskTX6ZinMqAtw6GNZD3
 /oyGAqTKDhGBLgjFm4Qel2zIHkxdHkQ8BChUAYCZNJClB0tPdtP4PD55zlKsIr3RukoA
 Ir8St7AVjk5DH5AqAQnSKJnhsvXPdz5nl6zhyrETGRfSapUyDsy/wx1+sPagwX9PURzs
 B50ts03pxKt5ZACVJUcT2IDMYQM7KCD7p+REHsQ6zIpHFrW0mnBTdON60VHALvcexw+R
 e2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hTbY0nJfRg44cC4x/jkt29PNMvHIJImu3BmtAxBXRUA=;
 b=fA0KA2X27xejjFaIagtxcZpdAY7Ra08T1TollTKDqFYDFH6WsVp4PYDwGiP8zkZ4lq
 gOkDeWh99eQKmMQwS51pPKWXrLTKMxPYqwYAjjll7KgoNOzimy3jgRTVawgvRSe0QbE7
 CJZxfjEJDpJnPXh7OgnDtU8UmeXlhz1/SRB1LlhpS9jgurLLSLF79BFwvQV4mh265EwD
 RKI+HB+iwSXQJE17dWQX7oQUyf2hXzenX7WUO9hfww/GY7n32Owp2diP5m6ddDfVpyfm
 vJLDVEPL/Q7eirnBBm2Xif1gsYkXsrFzFai3uxmTlKhE54wP38gEbJ3ovyel1O5SNKlt
 epNw==
X-Gm-Message-State: APjAAAUrtkNec2kL4hR67LN6qKXz6P7v+dG97faPcajrmPmDNNDqyeJ+
 9ewa6+AsIYgMJNHnbA9cuQsMFy1CVfnQtQ==
X-Google-Smtp-Source: APXvYqwzkbW/MZ5n/ULQ9POm2Xt/rCkrJAFh4nPR4gciBW6mTqdU92Bn4tCNNLSYLXViozlcIQvJXQ==
X-Received: by 2002:a05:600c:290:: with SMTP id
 16mr3131736wmk.64.1582907954723; 
 Fri, 28 Feb 2020 08:39:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.39.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:39:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/33] tests/acceptance/integratorcp: Verify Tux is displayed
 on framebuffer
Date: Fri, 28 Feb 2020 16:38:35 +0000
Message-Id: <20200228163840.23585-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Add a test that verifies the Tux logo is displayed on the framebuffer.

We simply follow the OpenCV "Template Matching with Multiple Objects"
tutorial, replacing Lionel Messi by Tux:
https://docs.opencv.org/4.2.0/d4/dc6/tutorial_py_template_matching.html

When OpenCV and NumPy are installed, this test can be run using:

  $ AVOCADO_ALLOW_UNTRUSTED_CODE=hmmm \
    avocado --show=app,framebuffer run -t device:framebuffer \
      tests/acceptance/machine_arm_integratorcp.py
  JOB ID     : 8c46b0f8269242e87d738247883ea2a470df949e
  JOB LOG    : avocado/job-results/job-2020-01-31T21.38-8c46b0f/job.log
   (1/1) tests/acceptance/machine_arm_integratorcp.py:IntegratorMachine.test_framebuffer_tux_logo:
  framebuffer: found Tux at position [x, y] = (0, 0)
  PASS (3.96 s)
  RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
  JOB TIME   : 4.23 s

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-id: 20200225172501.29609-5-philmd@redhat.com
Message-Id: <20200131211102.29612-3-f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/acceptance/machine_arm_integratorcp.py | 52 ++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tests/acceptance/machine_arm_integratorcp.py b/tests/acceptance/machine_arm_integratorcp.py
index 22afd3b82a8..49c8ebff78b 100644
--- a/tests/acceptance/machine_arm_integratorcp.py
+++ b/tests/acceptance/machine_arm_integratorcp.py
@@ -9,11 +9,26 @@
 # later.  See the COPYING file in the top-level directory.
 
 import os
+import logging
 
 from avocado import skipUnless
 from avocado_qemu import Test
 from avocado_qemu import wait_for_console_pattern
 
+
+NUMPY_AVAILABLE = True
+try:
+    import numpy as np
+except ImportError:
+    NUMPY_AVAILABLE = False
+
+CV2_AVAILABLE = True
+try:
+    import cv2
+except ImportError:
+    CV2_AVAILABLE = False
+
+
 class IntegratorMachine(Test):
 
     timeout = 90
@@ -45,3 +60,40 @@ class IntegratorMachine(Test):
         """
         self.boot_integratorcp()
         wait_for_console_pattern(self, 'Log in as root')
+
+    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
+    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
+    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    def test_framebuffer_tux_logo(self):
+        """
+        Boot Linux and verify the Tux logo is displayed on the framebuffer.
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:integratorcp
+        :avocado: tags=device:pl110
+        :avocado: tags=device:framebuffer
+        """
+        screendump_path = os.path.join(self.workdir, "screendump.pbm")
+        tuxlogo_url = ('https://github.com/torvalds/linux/raw/v2.6.12/'
+                       'drivers/video/logo/logo_linux_vga16.ppm')
+        tuxlogo_hash = '3991c2ddbd1ddaecda7601f8aafbcf5b02dc86af'
+        tuxlogo_path = self.fetch_asset(tuxlogo_url, asset_hash=tuxlogo_hash)
+
+        self.boot_integratorcp()
+        framebuffer_ready = 'Console: switching to colour frame buffer device'
+        wait_for_console_pattern(self, framebuffer_ready)
+        self.vm.command('human-monitor-command', command_line='stop')
+        self.vm.command('human-monitor-command',
+                        command_line='screendump %s' % screendump_path)
+        logger = logging.getLogger('framebuffer')
+
+        cpu_count = 1
+        match_threshold = 0.92
+        screendump_bgr = cv2.imread(screendump_path)
+        screendump_gray = cv2.cvtColor(screendump_bgr, cv2.COLOR_BGR2GRAY)
+        result = cv2.matchTemplate(screendump_gray, cv2.imread(tuxlogo_path, 0),
+                                   cv2.TM_CCOEFF_NORMED)
+        loc = np.where(result >= match_threshold)
+        tux_count = 0
+        for tux_count, pt in enumerate(zip(*loc[::-1]), start=1):
+            logger.debug('found Tux at position [x, y] = %s', pt)
+        self.assertGreaterEqual(tux_count, cpu_count)
-- 
2.20.1


