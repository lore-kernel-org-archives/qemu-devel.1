Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A1AC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 15:38:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D02B020665
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 15:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02B020665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htZd5-0000dM-43
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 11:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53567)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1htZcH-0008Cv-1n
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 11:37:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1htZcF-0000R4-Te
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 11:37:12 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:58571 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1htZcF-0008QC-NK
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 11:37:11 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id D81A41A2205;
 Fri,  2 Aug 2019 17:36:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id BAD9C1A21F4;
 Fri,  2 Aug 2019 17:36:08 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Fri,  2 Aug 2019 17:35:57 +0200
Message-Id: <1564760158-27536-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564760158-27536-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1564760158-27536-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 1/2] tests/acceptance: Refactor and improve
 reporting in linux_ssh_mips_malta.py
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
Cc: ehabkost@redhat.com, cohuck@redhat.com, f4bug@amsat.org, crosa@redhat.com,
 amarkovic@wavecomp.com, ccarrara@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

This patch restructures code organization around the test case
executions. At the same time, rather than outputing a cryptic message:

FAIL: True not found in [False],

the following will be reported too, if the command output does not meet
specified expectations:

'lspci -d 11ab:4620' output doesn't contain the word 'GT-64120'

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/acceptance/linux_ssh_mips_malta.py | 36 +++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/linux_ssh_mips_malta.py
index aafb0c3..8368e1f 100644
--- a/tests/acceptance/linux_ssh_mips_malta.py
+++ b/tests/acceptance/linux_ssh_mips_malta.py
@@ -145,27 +145,33 @@ class LinuxSSH(Test):
         self.ssh_disconnect_vm()
         self.wait_for_console_pattern('Power down')
 
-    def run_common_commands(self):
-        stdout, stderr = self.ssh_command('lspci -d 11ab:4620')
-        self.assertIn(True, ["GT-64120" in line for line in stdout])
-
-        stdout, stderr = self.ssh_command('cat /sys/bus/i2c/devices/i2c-0/name')
-        self.assertIn(True, ["SMBus PIIX4 adapter" in line
-                             for line in stdout])
-
-        stdout, stderr = self.ssh_command('cat /proc/mtd')
-        self.assertIn(True, ["YAMON" in line
-                             for line in stdout])
+    def ssh_command_output_contains(self, cmd, exp):
+        stdout, _ = self.ssh_command(cmd)
+        for line in stdout:
+            if exp in line:
+                break
+        else:
+            self.fail('"%s" output does not contain "%s"' % (cmd, exp))
 
+    def run_common_commands(self):
+        self.ssh_command_output_contains(
+            'lspci -d 11ab:4620',
+            'GT-64120')
+        self.ssh_command_output_contains(
+            'cat /sys/bus/i2c/devices/i2c-0/name',
+            'SMBus PIIX4 adapter')
+        self.ssh_command_output_contains(
+            'cat /proc/mtd',
+            'YAMON')
         # Empty 'Board Config'
-        stdout, stderr = self.ssh_command('md5sum /dev/mtd2ro')
-        self.assertIn(True, ["0dfbe8aa4c20b52e1b8bf3cb6cbdf193" in line
-                             for line in stdout])
+        self.ssh_command_output_contains(
+            'md5sum /dev/mtd2ro',
+            '0dfbe8aa4c20b52e1b8bf3cb6cbdf193')
 
     def do_test_mips_malta(self, endianess, kernel_path, uname_m):
         self.boot_debian_wheezy_image_and_ssh_login(endianess, kernel_path)
 
-        stdout, stderr = self.ssh_command('uname -a')
+        stdout, _ = self.ssh_command('uname -a')
         self.assertIn(True, [uname_m + " GNU/Linux" in line for line in stdout])
 
         self.run_common_commands()
-- 
2.7.4


