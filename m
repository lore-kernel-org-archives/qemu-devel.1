Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83935C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 508A320656
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTdbxFMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 508A320656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgSzi-00009D-Fc
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 07:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38684)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hgSy9-00073N-B1
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hgSy8-00012a-5X
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:53:37 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:32879)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hgSy7-00011t-VJ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:53:36 -0400
Received: by mail-wr1-x443.google.com with SMTP id n9so2250061wru.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 04:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JTxYLS9RV7PoqVMzocUyMJN2JBKOC+NjHRRmxKXvGt4=;
 b=bTdbxFMIHYdHFeYC+P0B2o/E+Lrv7W7wKTyL0F65k3nNntVy9J0wYSRzVivdGq5eZI
 R70pQSJhYMnl5Ui+cxICVwIcOKYjQ7RW5StPDA1H0Chvpngn8uE0USbAqOenNQgSxkQ6
 A/DzuoWRkoLiHd4vgvUctDwR0WQXfctjuzgNr+CVfM5RuKCn91SJH/6gzJItqOT4KwR9
 FPSBw25HIkdwI7f7JCB89r+9LMd8npwGJ4QFyw0ClTPiETXNtG0t7wSDtP6oYNrFRNbd
 0XCW0A4W3aOKgOnVrE9/Uv1c1nebjqeiJCQTYKvFgZ2HW+x/6QZ1nGGxOAHFeD55FYgK
 K5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=JTxYLS9RV7PoqVMzocUyMJN2JBKOC+NjHRRmxKXvGt4=;
 b=deSouvQ5eL1kU1v6n6If/ZCxnfXouEU7wr3iP64C5jOehYoGuhJQSPBwTQy/c2AgG3
 4Nv8U5Aw3CpWPTDu7JRJL8uLD+S35JMw2HfKWuduNDulUHhRH2lJ61W4jOlAATNPPWsi
 4RMydPb916Nff4D9JxfD86etX+ShmflUtIKnsZzsh9kQT93L2787Q5L1FtPi8trAvj0T
 FvD0k5uirXcYJkEsCc6xTreokE+jUj2uCKNME2uv2hGgbTU74YR6rp65G5Z8Bus37Tk9
 9PljGdcv+F/wXeIqoo/3C8Uj4TuoIOwtbwjZUocdf5wqbJ8LROENmcLOL4mGS4bTO0e8
 J4hQ==
X-Gm-Message-State: APjAAAX9MlaINpj+V8vCuHHL2xHtbSPP+YbaN3cvkDs3eF9C+0TpWg9H
 MgTtV+v1hE7fD9AZUwX+w5Gkfs77
X-Google-Smtp-Source: APXvYqyPN4eT5I1KGbwpYrK/FQVFn7Lr8W+QlfNfZjsAw2y4D6Pf4+Fmw+u7EojlZ8dLX/dpFmGqoQ==
X-Received: by 2002:adf:eb49:: with SMTP id u9mr2620899wrn.215.1561636414673; 
 Thu, 27 Jun 2019 04:53:34 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id o126sm6196408wmo.1.2019.06.27.04.53.33
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 27 Jun 2019 04:53:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 13:53:29 +0200
Message-Id: <20190627115331.2373-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190627115331.2373-1-f4bug@amsat.org>
References: <20190627115331.2373-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH 1/3] tests/acceptance: Add test that boots the
 HelenOS microkernel on Leon3
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Release notes:
http://www.helenos.org/wiki/Download#HelenOS0.6.0

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS                             |  1 +
 tests/acceptance/machine_sparc_leon3.py | 58 +++++++++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100644 tests/acceptance/machine_sparc_leon3.py

diff --git a/MAINTAINERS b/MAINTAINERS
index cad58b9487..8660e13ef2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1158,6 +1158,7 @@ S: Maintained
 F: hw/sparc/leon3.c
 F: hw/*/grlib*
 F: include/hw/*/grlib*
+F: tests/acceptance/machine_sparc_leon3.py
 
 S390 Machines
 -------------
diff --git a/tests/acceptance/machine_sparc_leon3.py b/tests/acceptance/machine_sparc_leon3.py
new file mode 100644
index 0000000000..0bbae44f85
--- /dev/null
+++ b/tests/acceptance/machine_sparc_leon3.py
@@ -0,0 +1,58 @@
+# Functional test that boots a Leon3 machine and checks its serial console.
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
+class Leon3Machine(Test):
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
+    def test_leon3_helenos_uimage(self):
+        """
+        :avocado: tags=arch:sparc
+        :avocado: tags=machine:leon3
+        :avocado: tags=binfmt:uimage
+        """
+        kernel_url = ('http://www.helenos.org/releases/'
+                      'HelenOS-0.6.0-sparc32-leon3.bin')
+        kernel_hash = 'a88c9cfdb8430c66650e5290a08765f9bf049a30'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        self.vm.set_machine('leon3_generic')
+        self.vm.set_console()
+        self.vm.add_args('-kernel', kernel_path)
+
+        self.vm.launch()
+
+        self.wait_for_console_pattern('Copyright (c) 2001-2014 HelenOS project')
+        self.wait_for_console_pattern('Booting the kernel ...')
-- 
2.19.1


