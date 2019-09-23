Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46885C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:43:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A5FB20665
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5FB20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCOcL-0000oi-8u
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 09:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iCOZy-0007OK-6g
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iCOZw-0007Z7-Ug
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:40:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24076)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iCOZw-0007Ys-Mz
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:40:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EFE621196E60;
 Mon, 23 Sep 2019 13:40:35 +0000 (UTC)
Received: from dhcp-17-179.bos.redhat.com (dhcp-17-179.bos.redhat.com
 [10.18.17.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D0DAE19C78;
 Mon, 23 Sep 2019 13:40:34 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PULL 5/7] tests/acceptance: Refactor and improve reporting in
 linux_ssh_mips_malta.py
Date: Mon, 23 Sep 2019 09:40:17 -0400
Message-Id: <20190923134019.8548-6-crosa@redhat.com>
In-Reply-To: <20190923134019.8548-1-crosa@redhat.com>
References: <20190923134019.8548-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Mon, 23 Sep 2019 13:40:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
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
Message-Id: <1564760158-27536-2-git-send-email-aleksandar.markovic@rt-rk.=
com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/acceptance/linux_ssh_mips_malta.py | 36 ++++++++++++++----------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/=
linux_ssh_mips_malta.py
index 7200507a3a..7fc44f43d1 100644
--- a/tests/acceptance/linux_ssh_mips_malta.py
+++ b/tests/acceptance/linux_ssh_mips_malta.py
@@ -145,27 +145,33 @@ class LinuxSSH(Test):
         self.ssh_disconnect_vm()
         self.wait_for_console_pattern('Power down')
=20
+    def ssh_command_output_contains(self, cmd, exp):
+        stdout, _ =3D self.ssh_command(cmd)
+        for line in stdout:
+            if exp in line:
+                break
+        else:
+            self.fail('"%s" output does not contain "%s"' % (cmd, exp))
+
     def run_common_commands(self):
-        stdout, stderr =3D self.ssh_command('lspci -d 11ab:4620')
-        self.assertIn(True, ["GT-64120" in line for line in stdout])
-
-        stdout, stderr =3D self.ssh_command('cat /sys/bus/i2c/devices/i2=
c-0/name')
-        self.assertIn(True, ["SMBus PIIX4 adapter" in line
-                             for line in stdout])
-
-        stdout, stderr =3D self.ssh_command('cat /proc/mtd')
-        self.assertIn(True, ["YAMON" in line
-                             for line in stdout])
-
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
-        stdout, stderr =3D self.ssh_command('md5sum /dev/mtd2ro')
-        self.assertIn(True, ["0dfbe8aa4c20b52e1b8bf3cb6cbdf193" in line
-                             for line in stdout])
+        self.ssh_command_output_contains(
+            'md5sum /dev/mtd2ro',
+            '0dfbe8aa4c20b52e1b8bf3cb6cbdf193')
=20
     def check_mips_malta(self, endianess, kernel_path, uname_m):
         self.boot_debian_wheezy_image_and_ssh_login(endianess, kernel_pa=
th)
=20
-        stdout, stderr =3D self.ssh_command('uname -a')
+        stdout, _ =3D self.ssh_command('uname -a')
         self.assertIn(True, [uname_m + " GNU/Linux" in line for line in =
stdout])
=20
         self.run_common_commands()
--=20
2.21.0


