Received: from eggs.gnu.org ([2001:4830:134:3::10]:33257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9CiM-0003SO-Hd
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:47:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9CiI-0007Uu-OH
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:47:18 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:40308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9CiI-0007Ud-Ji
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:47:14 -0400
Received: by mail-qk0-x243.google.com with SMTP id o64so5953555qkl.7
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 09:47:14 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 19 Apr 2018 13:46:40 -0300
Message-Id: <20180419164642.9536-6-f4bug@amsat.org>
In-Reply-To: <20180419164642.9536-1-f4bug@amsat.org>
References: <20180419164642.9536-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 5/7] avocado: Add an optional flag 'login'
 to get_console()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Cleber Rosa <crosa@redhat.com>, Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Zheng Xiang <xiang.zheng@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Alistair Francis <alistair23@gmail.com>

Not all consoles require users to log in :/

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/avocado/avocado_qemu/test.py | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/tests/avocado/avocado_qemu/test.py b/tests/avocado/avocado_qemu/test.py
index 1ead917014..ac8ee6d250 100644
--- a/tests/avocado/avocado_qemu/test.py
+++ b/tests/avocado/avocado_qemu/test.py
@@ -244,7 +244,7 @@ class _VM(qemu.QEMUMachine):
         super(_VM, self).__init__(qemu_bin, name=self.name, arch=arch)
         logging.getLogger('QMP').setLevel(logging.INFO)
 
-    def get_console(self, console_address=None, prompt=r"[\#\$] "):
+    def get_console(self, console_address=None, prompt=r"[\#\$] ", login=True):
         """
         :param address: Socket address, can be either a unix socket path
                         (string) or a tuple in the form (address, port)
@@ -252,9 +252,6 @@ class _VM(qemu.QEMUMachine):
         :param prompt: The regex to identify we reached the prompt.
         """
 
-        if not all((self.username, self.password)):
-            raise QEMULoginError('Username or password not set.')
-
         if not self.is_running():
             raise QEMULoginError('VM is not running.')
 
@@ -272,13 +269,17 @@ class _VM(qemu.QEMUMachine):
             nc_cmd += ' -U %s' % console_address
 
         console = aexpect.ShellSession(nc_cmd)
-        try:
-            logging.info('Console: Waiting login prompt...')
-            _handle_prompts(console, self.username, self.password, prompt)
-            logging.info('Console: Ready!')
-        except:
-            console.close()
-            raise
+        if login:
+            if not all((self.username, self.password)):
+                raise QEMULoginError('Username or password not set.')
+
+            try:
+                logging.info('Console: Waiting login prompt...')
+                _handle_prompts(console, self.username, self.password, prompt)
+            except:
+                console.close()
+                raise
+        logging.info('Console: Ready!')
 
         return console
 
-- 
2.17.0
