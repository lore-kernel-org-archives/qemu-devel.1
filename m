Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB3CC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 23:00:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 600F9206C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 23:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600F9206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB5PM-0004q1-Dj
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 19:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iB5OP-0004MZ-RK
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iB5OM-0006d9-Q1
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:59:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49990)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iB5OM-0006cT-IG
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:59:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 40C2118CB8EF;
 Thu, 19 Sep 2019 22:59:13 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-123-8.rdu2.redhat.com
 [10.10.123.8])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 496E260BF1;
 Thu, 19 Sep 2019 22:59:06 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] Acceptance tests: use avocado.utils.ssh for SSH interaction
Date: Thu, 19 Sep 2019 18:59:05 -0400
Message-Id: <20190919225905.10829-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Thu, 19 Sep 2019 22:59:13 +0000 (UTC)
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This replaces paramiko with avocado.utils.ssh module, which is based
on a (open)ssh binary, supposedly more ubiquitous.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/linux_ssh_mips_malta.py | 74 ++++++++----------------
 tests/requirements.txt                   |  3 +-
 2 files changed, 25 insertions(+), 52 deletions(-)

diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/=
linux_ssh_mips_malta.py
index 134f10cac3..30c65568ce 100644
--- a/tests/acceptance/linux_ssh_mips_malta.py
+++ b/tests/acceptance/linux_ssh_mips_malta.py
@@ -9,13 +9,14 @@ import os
 import re
 import base64
 import logging
-import paramiko
 import time
=20
 from avocado import skipIf
+from avocado import skipUnless
 from avocado_qemu import Test
 from avocado.utils import process
 from avocado.utils import archive
+from avocado.utils import ssh
=20
=20
 class LinuxSSH(Test):
@@ -26,35 +27,18 @@ class LinuxSSH(Test):
     VM_IP =3D '127.0.0.1'
=20
     IMAGE_INFO =3D {
-        'be': {
-            'image_url': 'https://people.debian.org/~aurel32/qemu/mips/'
-                         'debian_wheezy_mips_standard.qcow2',
-            'image_hash': '8987a63270df67345b2135a6b7a4885a35e392d5',
-            'rsa_hostkey': b'AAAAB3NzaC1yc2EAAAADAQABAAABAQCca1VitiyLAdQ=
Old'
-                           b'zT43IOEVJZ0wHD78GJi8wDAjMiYWUzNSSn0rXGQsINH=
uH5'
-                           b'IlF+kBZsHinb/FtKCAyS9a8uCHhQI4SuB4QhAb0+39M=
lUw'
-                           b'Mm0CLkctgM2eUUZ6MQMQvDlqnue6CCkxN62EZYbaxmb=
y7j'
-                           b'CQa1125o1HRKBvdGm2zrJWxXAfA+f1v6jHLyE8Jnu83=
eQ+'
-                           b'BFY25G+Vzx1PVc3zQBwJ8r0NGTRqy2//oWQP0h+bMsg=
eFe'
-                           b'KH/J3RJM22vg6+I4JAdBFcxnK+l781h1FuRxOn4O/Xs=
lbg'
-                           b'go6WtB4V4TOsw2E/KfxI5IZ/icxF+swVcnvF46Hf3uQ=
c/0'
-                           b'BBqb',
-        },
-        'le': {
-            'image_url': 'https://people.debian.org/~aurel32/qemu/mipsel=
/'
-                         'debian_wheezy_mipsel_standard.qcow2',
-            'image_hash': '7866764d9de3ef536ffca24c9fb9f04ffdb45802',
-            'rsa_hostkey': b'AAAAB3NzaC1yc2EAAAADAQABAAABAQClXJlBT71HL5y=
Kvv'
-                           b'gfC7jmxSWx5zSBCzET6CLZczwAafSIs7YKfNOy/dQTx=
huk'
-                           b'yIGFUugZFoF3E9PzdhunuyvyTd56MPoNIqFbb5rGokw=
U5I'
-                           b'TOx3dBHZR0mClypL6MVrwe0bsiIb8GhF1zioNwcsaAZ=
nAi'
-                           b'KfXStVDtXvn/kLLq+xLABYt48CC5KYWoFaCoICskLAY=
+qo'
-                           b'L+LWyAnQisj4jAH8VSaSKIImFpfkHWEXPhHcC4ZBlDK=
tnH'
-                           b'po9vhfCHgnfW3Pzrqmk8BI4HysqPFVmJWkJGlGUL+sG=
eg3'
-                           b'ZZolAYuDXGuBrw8ooPJq2v2dOH+z6dyD2q/ypmAbyPq=
j5C'
-                           b'rc8H',
-        },
-    }
+        'be': {'image_url': ('https://people.debian.org/~aurel32/qemu/mi=
ps/'
+                             'debian_wheezy_mips_standard.qcow2'),
+               'image_hash': '8987a63270df67345b2135a6b7a4885a35e392d5'}=
,
+        'le': {'image_url': ('https://people.debian.org/~aurel32/qemu/mi=
psel/'
+                             'debian_wheezy_mipsel_standard.qcow2'),
+               'image_hash': '7866764d9de3ef536ffca24c9fb9f04ffdb45802'}
+        }
+
+
+    @skipUnless(ssh.SSH_CLIENT_BINARY, 'No SSH client available')
+    def setUp(self):
+        super(LinuxSSH, self).setUp()
=20
     def wait_for_console_pattern(self, success_message,
                                  failure_message=3D'Oops'):
@@ -78,23 +62,14 @@ class LinuxSSH(Test):
         self.log.debug("sshd listening on port:" + port)
         return port
=20
-    def ssh_connect(self, username, password, rsa_hostkey_b64=3DNone):
+    def ssh_connect(self, username, password):
         self.ssh_logger =3D logging.getLogger('ssh')
-        self.ssh_username =3D username
-        self.ssh_ps1 =3D '# ' if username is 'root' else '$ '
-        self.ssh_client =3D paramiko.SSHClient()
         port =3D self.get_portfwd()
-        if rsa_hostkey_b64:
-            rsa_hostkey_bin =3D base64.b64decode(rsa_hostkey_b64)
-            rsa_hostkey =3D paramiko.RSAKey(data =3D rsa_hostkey_bin)
-            ipport =3D '[%s]:%s' % (self.VM_IP, port)
-            self.ssh_logger.debug('ipport ' + ipport)
-            self.ssh_client.get_host_keys().add(ipport, 'ssh-rsa', rsa_h=
ostkey)
+        self.ssh_session =3D ssh.Session(self.VM_IP, port=3Dint(port),
+                                       user=3Dusername, password=3Dpassw=
ord)
         for i in range(10):
             try:
-                self.ssh_client.connect(self.VM_IP, int(port),
-                                        username, password, banner_timeo=
ut=3D90)
-                self.ssh_logger.info("Entering interactive session.")
+                self.ssh_session.connect()
                 return
             except:
                 time.sleep(4)
@@ -102,15 +77,15 @@ class LinuxSSH(Test):
         self.fail("sshd timeout")
=20
     def ssh_disconnect_vm(self):
-        self.ssh_client.close()
+        self.ssh_session.quit()
=20
     def ssh_command(self, command, is_root=3DTrue):
-        self.ssh_logger.info(self.ssh_ps1 + command)
-        stdin, stdout, stderr =3D self.ssh_client.exec_command(command)
-        stdout_lines =3D [line.strip('\n') for line in stdout]
+        self.ssh_logger.info(command)
+        result =3D self.ssh_session.cmd(command)
+        stdout_lines =3D [line.rstrip() for line in result.stdout_text.s=
plitlines()]
         for line in stdout_lines:
             self.ssh_logger.info(line)
-        stderr_lines =3D [line.strip('\n') for line in stderr]
+        stderr_lines =3D [line.rstrip() for line in result.stderr_text.s=
plitlines()]
         for line in stderr_lines:
             self.ssh_logger.warning(line)
         return stdout_lines, stderr_lines
@@ -119,7 +94,6 @@ class LinuxSSH(Test):
         image_url =3D self.IMAGE_INFO[endianess]['image_url']
         image_hash =3D self.IMAGE_INFO[endianess]['image_hash']
         image_path =3D self.fetch_asset(image_url, asset_hash=3Dimage_ha=
sh)
-        rsa_hostkey_b64 =3D self.IMAGE_INFO[endianess]['rsa_hostkey']
=20
         self.vm.set_machine('malta')
         self.vm.set_console()
@@ -138,7 +112,7 @@ class LinuxSSH(Test):
         self.wait_for_console_pattern(console_pattern)
         self.log.info('sshd ready')
=20
-        self.ssh_connect('root', 'root', rsa_hostkey_b64=3Drsa_hostkey_b=
64)
+        self.ssh_connect('root', 'root')
=20
     def shutdown_via_ssh(self):
         self.ssh_command('poweroff')
diff --git a/tests/requirements.txt b/tests/requirements.txt
index bd1f7590ed..a2a587223a 100644
--- a/tests/requirements.txt
+++ b/tests/requirements.txt
@@ -1,5 +1,4 @@
 # Add Python module requirements, one per line, to be installed
 # in the tests/venv Python virtual environment. For more info,
 # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
-avocado-framework=3D=3D68.0
-paramiko=3D=3D2.4.2
+avocado-framework=3D=3D72.0
--=20
2.21.0


