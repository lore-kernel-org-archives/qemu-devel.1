Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EB9CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 23:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B99B20880
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 23:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHVPE16a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B99B20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPEtE-000284-8x
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 19:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iPEn3-00030E-Fg
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 19:51:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iPEma-00041n-Jh
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 19:50:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54333
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iPEma-00041H-Fg
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 19:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572306644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eNYuARwovOoLWb259uZR+n10D9sLe3CuNjzA1k/qwIs=;
 b=KHVPE16aYdhzgxRi/ZbEilf1+GDdL2nUEYxOOxEFZSRGeNe2hHs3jx6x1AZSqVwAwWdTvb
 bcHRAF+MUNgENGCB8IuB+mmQPs/F3zeyVLSlV01bRy6dzCR92uoG9/VU/f1eTpJ4SX43ln
 K77wOa8AwGEzobgYu/r8diOGWPgBY6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-AUkj7kUlO3uX1LW3udXcvg-1; Mon, 28 Oct 2019 19:50:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 991CC81A334;
 Mon, 28 Oct 2019 23:50:38 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9856D5C1B2;
 Mon, 28 Oct 2019 23:50:36 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PULL 7/16] tests/acceptance: Refactor
 exec_command_and_wait_for_pattern()
Date: Mon, 28 Oct 2019 19:49:53 -0400
Message-Id: <20191028235002.17691-8-crosa@redhat.com>
In-Reply-To: <20191028235002.17691-1-crosa@redhat.com>
References: <20191028235002.17691-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: AUkj7kUlO3uX1LW3udXcvg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Refactor the exec_command_and_wait_for_pattern() utility method
so we can reuse it in other files.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20191028073441.6448-6-philmd@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/avocado_qemu/__init__.py | 19 +++++++++++++++++++
 tests/acceptance/boot_linux_console.py    | 18 +++++++-----------
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/a=
vocado_qemu/__init__.py
index 393fc33f35..9a57c020d8 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -80,6 +80,25 @@ def wait_for_console_pattern(test, success_message, fail=
ure_message=3DNone):
             test.fail(fail)
=20
=20
+def exec_command_and_wait_for_pattern(test, command,
+                                      success_message, failure_message=3DN=
one):
+    """
+    Send a command to a console (appending CRLF characters), then wait
+    for success_message to appear on the console, while logging the.
+    content. Mark the test as failed if failure_message is found instead.
+
+    :param test: an Avocado test containing a VM that will have its consol=
e
+                 read and probed for a success or failure message
+    :type test: :class:`avocado_qemu.Test`
+    :param command: the command to send
+    :param success_message: if this message appears, test succeeds
+    :param failure_message: if this message appears, test fails
+    """
+    command +=3D '\r'
+    test.vm.console_socket.sendall(command.encode())
+    wait_for_console_pattern(test, success_message, failure_message)
+
+
 class Test(avocado.Test):
     def setUp(self):
         self._vms =3D {}
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py
index f9b77af359..4b419b0559 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -14,6 +14,7 @@ import gzip
 import shutil
=20
 from avocado_qemu import Test
+from avocado_qemu import exec_command_and_wait_for_pattern
 from avocado_qemu import wait_for_console_pattern
 from avocado.utils import process
 from avocado.utils import archive
@@ -33,11 +34,6 @@ class BootLinuxConsole(Test):
         wait_for_console_pattern(self, success_message,
                                  failure_message=3D'Kernel panic - not syn=
cing')
=20
-    def exec_command_and_wait_for_pattern(self, command, success_message):
-        command +=3D '\r'
-        self.vm.console_socket.sendall(command.encode())
-        wait_for_console_pattern(self, success_message)
-
     def extract_from_deb(self, deb, path):
         """
         Extracts a file from a deb package into the test workdir
@@ -166,12 +162,12 @@ class BootLinuxConsole(Test):
         self.vm.launch()
         self.wait_for_console_pattern('Boot successful.')
=20
-        self.exec_command_and_wait_for_pattern('cat /proc/cpuinfo',
-                                               'BogoMIPS')
-        self.exec_command_and_wait_for_pattern('uname -a',
-                                               'Debian')
-        self.exec_command_and_wait_for_pattern('reboot',
-                                               'reboot: Restarting system'=
)
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
+                                                'BogoMIPS')
+        exec_command_and_wait_for_pattern(self, 'uname -a',
+                                                'Debian')
+        exec_command_and_wait_for_pattern(self, 'reboot',
+                                                'reboot: Restarting system=
')
=20
     def do_test_mips_malta32el_nanomips(self, kernel_url, kernel_hash):
         kernel_path_xz =3D self.fetch_asset(kernel_url, asset_hash=3Dkerne=
l_hash)
--=20
2.21.0


