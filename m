Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023D0C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:36:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1464206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hS0vqQGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1464206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37377 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXg1-0000uF-J5
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iIXRp-0000Lx-3V
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:21:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iIXRn-0005hE-J8
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:21:36 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34378)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iIXRn-0005gk-Cv
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:21:35 -0400
Received: by mail-wr1-x441.google.com with SMTP id j11so7651837wrp.1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 05:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DPra1Z32r4f5QHXR9RCwjUNzYWTa9oyUkwq8uwkxPu8=;
 b=hS0vqQGh1dKUrriTg1MLHF94GKIfG8ZntcVdGDjHh7cYyR4XJLUYmewIU1o+QYhWvJ
 27mPIUXl59A5aFNTKl1iice6jStwBsRohPrmKVsIt2FtA/SgyySYsQg6qg5udmfRKKpr
 CzWPCKSFjac625RTIQ5sl3+oeiCbAdFMFyiGTAFZwwikttBSG1aBCBrydL1rLTKVAx1W
 qlspMNXrpz253oyjXMMWrJUhjU2MO6fIvcO79HbwdzlCirFsyzC9vALDepfksgkDnpBq
 DbHC+6xPS1jQqGDeXN5FAwqGyPg0ZefsuTHmkcYjZF9S6d7NzK0rEvnmAQ7Enbxqr8XX
 BGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=DPra1Z32r4f5QHXR9RCwjUNzYWTa9oyUkwq8uwkxPu8=;
 b=JezFM4ItoNEeQBU1BWuoO/7ZEUAJTRZVxVPz/JACMTildJMptj+lkytM3mhVyYaQEr
 hxvObn6oOHfJ/9rfvtsqR4vMym41RVRxUijln+EMIWF0BCnmQWoCsadIuUg6JZX2EaFq
 eFqhBF1iPV8xt9vxKsrLoI5qKYfSqTdPy2d8Dw/d8fX4mJ7yMDT/bRTFvh1kimQGRV3C
 tDvWlS8DcA+7XhHOkzME+lsSCaQUp0w4b7upEtgY/YjUM5M6ffRpbOgeMtOVCMa5JIJK
 A8G+2SQ5E3hevW/T0ONToD+bBbTdBFJ9+CHxniRuFyC5ShJDHA8CTlp+EAvX/wWt2VlR
 JT6g==
X-Gm-Message-State: APjAAAWv7gyLeAKjL2uHGXzC/I0JicikqZX7sxp7ZfVCU/zjarxMv+El
 AJoYpDzxjolNc4p9aimfGR65Wf6tEds=
X-Google-Smtp-Source: APXvYqyx2aezjzBDTcE9qXoM+xUEjVFYZRYvJ9WgKnZD1etSMo3rrHW2880haO+uFVtYW5q1AzPWmQ==
X-Received: by 2002:adf:fd04:: with SMTP id e4mr8582328wrr.371.1570710093936; 
 Thu, 10 Oct 2019 05:21:33 -0700 (PDT)
Received: from x1w.redhat.com (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id o4sm12413169wre.91.2019.10.10.05.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2019 05:21:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] tests/boot_console: Test booting HP-UX firmware upgrade
Date: Thu, 10 Oct 2019 14:21:28 +0200
Message-Id: <20191010122128.29000-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191010122128.29000-1-f4bug@amsat.org>
References: <20191010122128.29000-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>, Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a test which boots a HP-UX firmware upgrade CD-ROM.
It exercise the PCI LSI53C895A SCSI controller.

The ISO image comes from:
https://web.archive.org/web/20101204061612/http://ftp.parisc-linux.org/kernels/712/PF_C7120023

This test is very quick, less than 3s:

  $ avocado --show=app,console run -t arch:hppa tests/acceptance/boot_linux_console.py
  console: Firmware Version 6.1
  console: Duplex Console IO Dependent Code (IODC) revision 1
  console: Memory Test/Initialization Completed
  console: ------------------------------------------------------------------------------
  console: (c) Copyright 2017-2018 Helge Deller <deller@gmx.de> and SeaBIOS developers.
  console: ------------------------------------------------------------------------------
  console: Processor   Speed            State           Coprocessor State  Cache Size
  console: ---------  --------   ---------------------  -----------------  ----------
  console: 0      250 MHz    Active                 Functional            0 KB
  console: Available memory:     512 MB
  console: Good memory required: 16 MB
  console: Primary boot path:    FWSCSI.0.0
  console: Alternate boot path:  FWSCSI.2.0
  console: Console path:         SERIAL_1.9600.8.none
  console: Keyboard path:        PS2
  console: Available boot devices:
  console: 1. DVD/CD [lsi 00:00.0 2:0 Drive QEMU QEMU CD-ROM 2.5+]
  console: Booting from DVD/CD [lsi 00:00.0 2:0 Drive QEMU QEMU CD-ROM 2.5+]
  console: Booting...
  console: Boot IO Dependent Code (IODC) revision 153
  console: HARD Booted.
  console: ISL Revision A.00.25 November 18, 1992
  console: ISL booting  ODE UPDATE ; stable off ; RUN
  console: Loading...
  console: ***************************************************************************
  console: ******                                                               ******
  console: ******             Offline Diagnostic Environment                    ******
  console: ******                                                               ******
  console: ******      (C) Copyright Hewlett-Packard Co 1993                    ******
  console: ******                    All Rights Reserved                        ******
  console: ******                                                               ******
  console: ******  HP shall not be liable for any damages resulting from the    ******
  console: ******  use of this program.                                         ******
  console: ******                                                               ******
  console: ******                TC  Version A.00.15                            ******
  console: ******                SysLib Version A.00.44                         ******
  console: ******                                                               ******
  console: ***************************************************************************
  console: Type HELP for command information.
  console: ISL_CMD> UPDATE ; stable off ; RUN
  console: ***************************************************************************
  console: ******                                                               ******
  console: ******                           PDC UPDATER                         ******
  console: ******                                                               ******
  console: ******    Copyright (C) 1993, 1994, 1995 by Hewlett-Packard Company  ******
  console: ******                         Version A.00.19                       ******
  console: ******                                                               ******
  console: ***************************************************************************
  console: Type HELP for command information.
  console: Stable Storage will NOT be updated
  console: STARTING EXECUTION OF UPDATE
  console: Unrecognized MODEL TYPE = 502
  console: ERROR 0001
  console: UPDATE PAUSED> exit
  console: UPDATE>
  console: UPDATE> ls
  console: Modules on this boot media are:
  console: filename    type    size     created   description
  console: -----------------------------------------------------------------------------
  console: DAGGER      DATA    118      96/02/15  ?
  console: IMAGE1A     DATA    512      96/02/15  ?
  console: IMAGE1B     DATA    388      96/02/15  ?
  console: UPDATE> exit
  console: THIS UTILITY WILL NOW RESET THE SYSTEM.....
  PASS (2.39 s)
  JOB TIME   : 2.54 s

Suggested-by: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
I know this is not a 'Linux' test, but all our console functions
reside in this file and I don't want to duplicate again.
Maybe we could rename this file as 'boot_console_tests.py' or
extract the console related functions.
---
 tests/acceptance/boot_linux_console.py | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index f05452824e..8bfcd0625a 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -378,3 +378,28 @@ class BootLinuxConsole(Test):
         self.vm.launch()
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
+
+    def test_hppa_fwupdate(self):
+        """
+        :avocado: tags=arch:hppa
+        :avocado: tags=device:lsi53c895a
+        """
+        cdrom_url = ('https://github.com/philmd/qemu-testing-blob/raw/ec1b741/'
+                     'hppa/hp9000/712/C7120023.frm')
+        cdrom_hash = '17944dee46f768791953009bcda551be5ab9fac9'
+        cdrom_path = self.fetch_asset(cdrom_url, asset_hash=cdrom_hash)
+
+        self.vm.set_console()
+        self.vm.add_args('-cdrom', cdrom_path,
+                         '-boot', 'd',
+                         '-no-reboot')
+        self.vm.launch()
+        self.wait_for_console_pattern('Unrecognized MODEL TYPE = 502')
+
+        self.exec_command_and_wait_for_pattern('exit',
+                                               'UPDATE>')
+        self.exec_command_and_wait_for_pattern('ls',
+                                               'IMAGE1B')
+        self.exec_command_and_wait_for_pattern('exit',
+                                               'THIS UTILITY WILL NOW '
+                                               'RESET THE SYSTEM.....')
-- 
2.21.0


