Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E04C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:29:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B54C62083B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okvCFFyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54C62083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgSaY-0005ip-0i
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 07:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56435)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hgSB6-0007xQ-It
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:03:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hgSAg-0007F2-7I
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:02:53 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37982)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hgSAg-00076J-0d
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:02:30 -0400
Received: by mail-wr1-x444.google.com with SMTP id d18so2041890wrs.5
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 04:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jQnUw1BmzWMnlXfW7LCtb9pyPaLN7VGNxTThl1xshH4=;
 b=okvCFFyI/GD3UYTpUy2PezAIcSdUIVxUPzNHPeVjwCqwra3G0pOEYorV88rscei2ty
 5lrRwyJT3hLFzvZGeCD0376xzadqEATdlJufEUDKtZqzCcIT24d84Hsm+H+r4araXYvr
 yFzg+YWq+/5Z9EggXHFztXwolWuuIzQeTtDroH4VZ2ynao3Y6cW1v3eMcJ6UqA01Qz0L
 XaV1OdkgqgyHLTcedbS3lXmJwc6TXen9qcEaUUA9k/DQbY4Uo6pHVtaJ+DivPKgTaXoj
 LmBR7zsp2hpQ0Uh6rOAwEN0y0gtJp4gAGkN7q8yjXA4qT2CJtWyJK03xTL6J0ntSs+oc
 xu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jQnUw1BmzWMnlXfW7LCtb9pyPaLN7VGNxTThl1xshH4=;
 b=qv/qjt/Zl/B7Avnv3W4E4Bno7mqPC2lemDUIogP3eOUz9rG9sxz+VQZyC82HnKXMqp
 7rSgQACNvC9WAwRKg+Lh1y9KwZRFh8WMmu5TP4i+1TdzcE2Gese2FvzIHS04pHIljKT7
 f0Uk62FYer4OZbEIe1NwR/AWlhdQcvRlxd7jPORGP0mtPUZZ66cxmeqsXmAXScPhPfFV
 46qEx4AfBvToS0enM9GfIBx8pir4D9VSk0FPvvO9uNaU18jbMMVbfyAPAsXv+KVt0NAJ
 FTLe8WAC9RS6vi2fvWZmLokJ9XIrS2QFBBa0dJn3eCqsXkY5wnWULSPjrfLqhq2WWVCq
 /3HQ==
X-Gm-Message-State: APjAAAVJfOd/4hFVJ5zFt94KEwUpk3X7GCvfCpfYFv3RX/vsDD8+EZrD
 MyuBCFfK6AdPxGRRzrVCyilB8ucY
X-Google-Smtp-Source: APXvYqztIsSdVhuYPAGqQaOxxZQ5Cns3pvaVv8Wnbs2Qregw5hiu5BwkA0nID1yzDrulkjh4WUzEaQ==
X-Received: by 2002:adf:eb86:: with SMTP id t6mr2726356wrn.96.1561633340363;
 Thu, 27 Jun 2019 04:02:20 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id y18sm6368968wmi.23.2019.06.27.04.02.10
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 27 Jun 2019 04:02:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 13:01:57 +0200
Message-Id: <20190627110201.1999-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190627110201.1999-1-f4bug@amsat.org>
References: <20190627110201.1999-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 1/5] tests/acceptance: Add test that runs
 NetBSD installer on PRep/40p
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

User case from:
http://mail-index.netbsd.org/port-prep/2017/04/11/msg000112.html

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/ppc_prep_40p.py | 63 ++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 tests/acceptance/ppc_prep_40p.py

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
2.19.1


