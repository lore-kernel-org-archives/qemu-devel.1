Received: from eggs.gnu.org ([2001:4830:134:3::10]:33829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWACB-0003tC-TH
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 20:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWAC9-0000GD-GM
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 20:44:59 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWAC9-0000G5-C0
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 20:44:57 -0400
Received: by mail-qk0-x243.google.com with SMTP id c131-v6so2863609qkb.0
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 17:44:57 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 21 Jun 2018 21:44:34 -0300
Message-Id: <20180622004435.10291-6-f4bug@amsat.org>
In-Reply-To: <20180622004435.10291-1-f4bug@amsat.org>
References: <20180622004435.10291-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 5/6] tests/acceptance: Add a kludge to
 not use the default console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>

The board already instantiate the proper devices, we don't want to
add extra devices but connect the chardev to one of the serial already
available.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/qemu.py                        | 6 ++++--
 tests/acceptance/boot_linux_console.py | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index f099ce7278..7a975f4538 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -211,8 +211,10 @@ class QEMUMachine(object):
                                                  self._name + "-console.sock")
             chardev = ('socket,id=console,path=%s,server,nowait' %
                        self._console_address)
-            device = '%s,chardev=console' % self._console_device_type
-            args.extend(['-chardev', chardev, '-device', device])
+            args.extend(['-chardev', chardev])
+            if len(self._console_device_type):
+                device = '%s,chardev=console' % self._console_device_type
+                args.extend(['-device', device])
         return args
 
     def _pre_launch(self):
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 72cf5e943c..510742c4c7 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -69,9 +69,10 @@ class BootLinuxConsoleMips(Test):
         kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
 
         self.vm.set_machine('malta')
-        self.vm.set_console()
+        self.vm.set_console("") # FIXME this disable isa-serial to use -serial
         kernel_command_line = 'console=ttyS0 printk.time=0'
         self.vm.add_args('-m', "64",
+                         '-serial', "chardev:console", # FIXME ... here.
                          '-kernel', kernel_path,
                          '-append', kernel_command_line)
         self.vm.launch()
-- 
2.18.0.rc2
