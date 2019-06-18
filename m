Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D86C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 18:05:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75DF42063F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 18:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75DF42063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60836 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdITr-0000Uo-AV
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 14:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50938)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1hdIR4-0007Fs-Mj
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 14:02:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1hdIR3-0003dp-28
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 14:02:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52592)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1hdIR2-0003cl-LV
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 14:02:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A9F4C23E6E7;
 Tue, 18 Jun 2019 18:02:19 +0000 (UTC)
Received: from unused.bos.redhat.com (unknown [10.16.197.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A1495E7C6;
 Tue, 18 Jun 2019 18:02:16 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jun 2019 14:02:15 -0400
Message-Id: <20190618180215.25896-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 18 Jun 2019 18:02:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] Acceptance tests: workaround for serial
 devices / console socket issue
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We're seeing constant failures on aarch64 and arm targets on CI
on tests that have a kernel writing to a serial device used as console,
and a socket file connected to it.

After investigation, it was noticed that when interacting with some
devices, by means of the sockets around serial devices used as
console, QEMU may block an entire thread (see 6ab3fc32e).

This attempts to work around the behavior of those devices, by
closing the socket file connected to the chardev given to the
serial device.

Related to bug: https://bugs.launchpad.net/qemu/+bug/1829779

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index 32159503e9..ae31d914a8 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -30,12 +30,15 @@ class BootLinuxConsole(Test):
     KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
=20
     def wait_for_console_pattern(self, success_message,
-                                 failure_message=3D'Kernel panic - not s=
yncing'):
+                                 failure_message=3D'Kernel panic - not s=
yncing',
+                                 close=3DTrue):
         """
         Waits for messages to appear on the console, while logging the c=
ontent
=20
         :param success_message: if this message appears, test succeeds
         :param failure_message: if this message appears, test fails
+        :param close: close the socket file once the a final (success or
+                      failure) message is found
         """
         console =3D self.vm.console_socket.makefile()
         console_logger =3D logging.getLogger('console')
@@ -45,15 +48,20 @@ class BootLinuxConsole(Test):
                 continue
             console_logger.debug(msg)
             if success_message in msg:
+                if close:
+                    self.vm.console_socket.close()
                 break
             if failure_message in msg:
+                if close:
+                    self.vm.console_socket.close()
                 fail =3D 'Failure message found in console: %s' % failur=
e_message
                 self.fail(fail)
=20
-    def exec_command_and_wait_for_pattern(self, command, success_message=
):
+    def exec_command_and_wait_for_pattern(self, command, success_message=
,
+                                          close):
         command +=3D '\n'
         self.vm.console_socket.sendall(command.encode())
-        self.wait_for_console_pattern(success_message)
+        self.wait_for_console_pattern(success_message, close=3Dclose)
=20
     def extract_from_deb(self, deb, path):
         """
@@ -180,14 +188,15 @@ class BootLinuxConsole(Test):
                          '-append', kernel_command_line,
                          '-no-reboot')
         self.vm.launch()
-        self.wait_for_console_pattern('Boot successful.')
+        self.wait_for_console_pattern('Boot successful.', close=3DFalse)
=20
         self.exec_command_and_wait_for_pattern('cat /proc/cpuinfo',
-                                               'BogoMIPS')
+                                               'BogoMIPS', close=3DFalse=
)
         self.exec_command_and_wait_for_pattern('uname -a',
-                                               'Debian')
+                                               'Debian', close=3DFalse)
         self.exec_command_and_wait_for_pattern('reboot',
-                                               'reboot: Restarting syste=
m')
+                                               'reboot: Restarting syste=
m',
+                                               close=3DTrue)
=20
     def do_test_mips_malta32el_nanomips(self, kernel_url, kernel_hash):
         kernel_path_xz =3D self.fetch_asset(kernel_url, asset_hash=3Dker=
nel_hash)
--=20
2.21.0


