Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BTC_ID,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DA3CA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:37:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D812082C
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJ+3sZ1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D812082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLqmw-00075O-9a
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 11:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqkk-0005Dw-9u
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqki-0002tw-O9
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:34:50 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38281)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqki-0002tM-I1
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:34:48 -0400
Received: by mail-wr1-x444.google.com with SMTP id o15so8802102wru.5
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 08:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QBTrUBOd5GMcqdYIUb+wluk81oA9TycjHbQQeiTj8kE=;
 b=HJ+3sZ1oqiasnuOlFbQYJCm9vU7tr816YZcAElZMG8QWhN8KGivj3wTWxrMbCJqw4C
 fXMKcyFXKe5h/zWocjQISFxBD2TQ0GLSocZ2+tJpvpK0u+lcN2Ml/QSROuVCSc5lOXng
 VSvmTPibf6sk9l52Avjyw1kwIscSH3qeLXCfp58RjdjrUvI44z9ar62fQ2AlrDLgA1vK
 g4l2VRhaFUqMLkz8B/Y3aFivWNko4kPFtlJV2LWSG4ZPnfDV/aqlDTsryaHkqqqVwrCf
 IBK94o2Yf+sZfQ7+cdmLqtPNEXR1WN4+1yzPoJ6v7Ezkkhc+x2TR8iQVZQhN4Vgn6Zd4
 9k7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=QBTrUBOd5GMcqdYIUb+wluk81oA9TycjHbQQeiTj8kE=;
 b=GzpPfUJfoz5tEvJgy7CnB7jg70EaGhYsIB1JwrslZMKUh7CoWfcwQ9xz6glg1kpEte
 YhJUsz0a14IGD/4FDOIpW1s9gHAewuse1O2w5nkb5ZOw3aeKFvFDhZhqusmfX1nzdo25
 fJGKB1elCJ7zo6ENHunBPlntO2L1g8HfkiZCIzH+GG9hSULkhfIBg9rMhqcsAf2AHFKK
 JmH7AksWG1TLGbDcAivEpXANI0R3su04/1R2w7XAtW/jODeltvczCo2o47sQMwItRLOW
 +9jioAi7x9eUzKh4l3xA8hcFCfEFBxPc5Cv1DFVplp4qClozj9kGIVY6/BUpejf2N9aA
 TZcQ==
X-Gm-Message-State: APjAAAWZmGQQjaJcw9YiGrV+dzp2Dtmy44Z3SXuHswszW9ZvNsSucY2k
 leQfwFUKVdbNyOOTVRwk1NQMVeFw
X-Google-Smtp-Source: APXvYqzr+mfdeupUQVZggAj7YHBlI7jj3pw790Jy08IvYdI3zHfb4kojZ+hWNL9zUELiSdaiog+SoA==
X-Received: by 2002:adf:a54e:: with SMTP id j14mr9859289wrb.265.1571499287173; 
 Sat, 19 Oct 2019 08:34:47 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id j19sm15245605wre.0.2019.10.19.08.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 08:34:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/11] tests/boot_linux_console: Run BusyBox on 5KEc 64-bit
 cpu
Date: Sat, 19 Oct 2019 17:34:32 +0200
Message-Id: <20191019153437.9820-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019153437.9820-1-f4bug@amsat.org>
References: <20191019153437.9820-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This tests boots a Linux kernel on a Malta machine up to a
busybox shell on the serial console. Few commands are executed
before halting the machine (via reboot).

We use the Fedora 24 kernel extracted from the image at:
https://fedoraproject.org/wiki/Architectures/MIPS
and the initrd cpio image from the kerneltests project:
https://kerneltests.org/

If MIPS is a target being built, "make check-acceptance" will
automatically include this test by the use of the "arch:mips" tags.

Alternatively, this test can be run using:

  $ avocado --show=console run -t arch:mips64el tests/acceptance/boot_linux_console.py
  console: [    0.000000] Linux version 3.19.3.mtoman.20150408 (mtoman@debian-co3-1) (gcc version 5.0.0 20150316 (Red Hat 5.0.0-0.20) (GCC) ) #3 Wed Apr 8 14:32:50 UTC 2015
  console: [    0.000000] Early serial console at I/O port 0x3f8 (options '38400n8')
  console: [    0.000000] bootconsole [uart0] enabled
  console: [    0.000000] CPU0 revision is: 00018900 (MIPS 5KE)
  console: [    0.000000] Checking for the multiply/shift bug... no.
  console: [    0.000000] Checking for the daddiu bug... no.
  [...]
  console: Boot successful.
  console: cat /proc/cpuinfo
  console: / # cat /proc/cpuinfo
  console: system type            : MIPS Malta
  console: machine                        : Unknown
  console: processor              : 0
  console: cpu model              : MIPS 5KE V0.0
  console: : 1616.89
  console: wait instruction       : nouname -a
  console: microsecond timers     : yes
  console: tlb_entries            : 32
  console: extra interrupt vector : yes
  console: hardware watchpoint    : yes, count: 1, address/irw mask: [0x0ff8]
  console: isa                    : mips1 mips2 mips3 mips4 mips5 mips32r1 mips32r2 mips64r1 mips64r2
  console: ASEs implemented       :
  console: shadow register sets   : 1
  console: kscratch registers     : 0
  console: package                        : 0
  console: core                   : 0
  console: VCED exceptions                : not available
  console: VCEI exceptions                : not available
  console: / #
  console: / # uname -a
  console: Linux buildroot 3.19.3.mtoman.20150408 #3 Wed Apr 8 14:32:50 UTC 2015 mips64 GNU/Linux
  console: reboot
  console: / #
  console: / # reboot
  console: / #
  console: / # reboot: Restarting system
  PASS (7.04 s)
  JOB TIME   : 7.20 s

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 40 ++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 67d7e96d98..e505a41eed 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -166,6 +166,46 @@ class BootLinuxConsole(Test):
         exec_command_and_wait_for_pattern(self, 'reboot',
                                                 'reboot: Restarting system')
 
+    def test_mips64el_malta_5KEc_cpio(self):
+        """
+        :avocado: tags=arch:mips64el
+        :avocado: tags=machine:malta
+        :avocado: tags=endian:little
+        """
+        kernel_url = ('https://github.com/philmd/qemu-testing-blob/'
+                      'raw/9ad2df38/mips/malta/mips64el/'
+                      'vmlinux-3.19.3.mtoman.20150408')
+        kernel_hash = '00d1d268fb9f7d8beda1de6bebcc46e884d71754'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        initrd_url = ('https://github.com/groeck/linux-build-test/'
+                      'raw/8584a59e/rootfs/'
+                      'mipsel64/rootfs.mipsel64r1.cpio.gz')
+        initrd_hash = '1dbb8a396e916847325284dbe2151167'
+        initrd_path_gz = self.fetch_asset(initrd_url, algorithm='md5',
+                                          asset_hash=initrd_hash)
+        initrd_path = self.workdir + "rootfs.cpio"
+        archive.gzip_uncompress(initrd_path_gz, initrd_path)
+
+        self.vm.set_machine('malta')
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
+                               + 'console=ttyS0 console=tty '
+                               + 'rdinit=/sbin/init noreboot')
+        self.vm.add_args('-cpu', '5KEc',
+                         '-kernel', kernel_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'Boot successful.')
+
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
+                                                'MIPS 5KE')
+        exec_command_and_wait_for_pattern(self, 'uname -a',
+                                                '3.19.3.mtoman.20150408')
+        exec_command_and_wait_for_pattern(self, 'reboot',
+                                                'reboot: Restarting system')
+
     def do_test_mips_malta32el_nanomips(self, kernel_url, kernel_hash):
         kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
         kernel_path = self.workdir + "kernel"
-- 
2.21.0


