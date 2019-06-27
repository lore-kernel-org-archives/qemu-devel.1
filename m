Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5841CC48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:55:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 260692086D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvjC/PjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 260692086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgSzt-0000EU-R2
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 07:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38708)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hgSyB-0007CJ-Ah
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:53:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hgSy9-000145-Ln
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:53:39 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50559)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hgSy9-000130-F4
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:53:37 -0400
Received: by mail-wm1-x344.google.com with SMTP id c66so5441977wmf.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 04:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7Kaojq+JVYsXMPIVtQoIpSEKIUgt3q0HMeJqgC9HTsI=;
 b=gvjC/PjXran5Lc6W1YhS2STDcvjGC9M6M7vdGtzdzeT7I7/rAXXnwW8xx54gor/dRs
 KQlh0P4rBK1iLb2iQoahmA2le6rwlsucyqNBESfIuZGJlvrw+8FsRb4Q5io6Pw70RGsN
 DgqfNDVIzm4WyURTyRowf0b+7wp/cZ4Qk1WkIf2625e82Ai+jhEMndkuNhatuHNt5hBz
 IC1cUEbF9o+ZwsUdNWGVRXuwd6V+bjx20zJ1KSHnsLCmUK6ycUv5Iw/xwgY2ZU/EXUW0
 KXleepvh1nwdMhNxPHvUbmePHTFDprOi9qQbsXS6yZ2tN/fdfW96Stai0InzCWja/7EQ
 i5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=7Kaojq+JVYsXMPIVtQoIpSEKIUgt3q0HMeJqgC9HTsI=;
 b=lEeV/5ZYxVgqJDiQuduiGgbQn7pdZenjnZyzp1h+wy8yB00v6rOmVpriXy5i7Aen9p
 zkpE2EyAjpyyj1iu+TM7cco3LCV6k8r68fQ0hnd22mQUsBrkT4KMFKs0OzTdvmSgAnju
 tukqZEiEx7XCbzr1sW4vC0SfGu6Jg1BSnCpiVpkSu/UyfLOeP84Yip2aTfxxiZ4clmJ8
 XDDMCA6oeL41UpQcUxCDrIWQ44wSzJcEuP4RKtROfVy0PX4kV7PB5EEWpjTIfEjSpd4a
 wSVQc6RBiFHC8rZiPAi+cuFxYY4qq1FRaOdmAeLajuufnQ0m4NxvR4Tb7oB5mV5lLNh/
 roMg==
X-Gm-Message-State: APjAAAVkJytJ+epQc/lEHHTz99rXDlg0jaIo68B18uGhL3G5qK/56mXi
 qnUk8wk/mGAE7TmBWZ4qJDAe2BuN
X-Google-Smtp-Source: APXvYqyF3GA5C5LZakVVi5cf7TS5DBmzSWiSNjQL5lHwDl8fjibYqM5GcnyM0q/qp4GSAftalacaOQ==
X-Received: by 2002:a1c:6585:: with SMTP id z127mr3184776wmb.25.1561636416139; 
 Thu, 27 Jun 2019 04:53:36 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id o126sm6196408wmo.1.2019.06.27.04.53.34
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 27 Jun 2019 04:53:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 13:53:30 +0200
Message-Id: <20190627115331.2373-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190627115331.2373-1-f4bug@amsat.org>
References: <20190627115331.2373-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH 2/3] tests/acceptance: Add test that boots
 Linux up to BusyBox on Leon3
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

Gaisler provides convenient images:
https://www.gaisler.com/index.php/downloads/linux

HOWTO build:
https://www.gaisler.com/index.php/products/operating-systems/linux

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/machine_sparc_leon3.py | 31 +++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tests/acceptance/machine_sparc_leon3.py b/tests/acceptance/machine_sparc_leon3.py
index 0bbae44f85..b3039b5d30 100644
--- a/tests/acceptance/machine_sparc_leon3.py
+++ b/tests/acceptance/machine_sparc_leon3.py
@@ -37,6 +37,11 @@ class Leon3Machine(Test):
                 fail = 'Failure message found in console: %s' % failure_message
                 self.fail(fail)
 
+    def exec_command_and_wait_for_pattern(self, command, success_message):
+        command += '\n'
+        self.vm.console_socket.sendall(command.encode())
+        self.wait_for_console_pattern(success_message)
+
     def test_leon3_helenos_uimage(self):
         """
         :avocado: tags=arch:sparc
@@ -56,3 +61,29 @@ class Leon3Machine(Test):
 
         self.wait_for_console_pattern('Copyright (c) 2001-2014 HelenOS project')
         self.wait_for_console_pattern('Booting the kernel ...')
+
+    def test_leon3_linux_kernel_4_9_busybox(self):
+        """
+        :avocado: tags=arch:sparc
+        :avocado: tags=machine:leon3
+        """
+        kernel_url = ('https://www.gaisler.com/anonftp/linux/linux-4/images/'
+                     'leon-linux-4.9/leon-linux-4.9-1.0/up/image.ram')
+        kernel_hash = '289bd1bcca10cda76d0ef2264a8657adc251f5f5'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        self.vm.set_machine('leon3_generic')
+        self.vm.set_console()
+        self.vm.add_args('-kernel', kernel_path)
+
+        self.vm.launch()
+
+        self.wait_for_console_pattern('TYPE: Leon3 System-on-a-Chip')
+
+        self.wait_for_console_pattern('Welcome to Buildroot')
+
+        self.wait_for_console_pattern('buildroot login:')
+        self.exec_command_and_wait_for_pattern('root', '#')
+        uname = 'Linux buildroot 4.9.54-00018-g62dab2c #2 ' \
+                'Wed Oct 18 09:45:51 CEST 2017 sparc GNU/Linux'
+        self.exec_command_and_wait_for_pattern('uname -a', uname)
-- 
2.19.1


