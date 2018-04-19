Received: from eggs.gnu.org ([2001:4830:134:3::10]:33159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9CiC-0003Hu-88
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Ci8-0007PY-5n
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:47:08 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 19 Apr 2018 13:46:37 -0300
Message-Id: <20180419164642.9536-3-f4bug@amsat.org>
In-Reply-To: <20180419164642.9536-1-f4bug@amsat.org>
References: <20180419164642.9536-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 2/7] avocado: Update python scripts to
 upstream codebase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Cleber Rosa <crosa@redhat.com>, Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Zheng Xiang <xiang.zheng@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Alistair Francis <alistair23@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

QEMUMachine arguments member is called '_args'.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/qemu.py                    | 14 +++++++-------
 tests/avocado/avocado_qemu/test.py | 12 ++++++------
 tests/qemu-iotests/iotests.py      | 28 ++++++++++++++--------------
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index bd66620f45..0eecc44d09 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -81,7 +81,7 @@ class QEMUMachine(object):
         self._qemu_log_file = None
         self._popen = None
         self._binary = binary
-        self.args = list(args)     # Force copy args in case we modify them
+        self._args = list(args)     # Force copy args in case we modify them
         self._wrapper = wrapper
         self._events = []
         self._iolog = None
@@ -109,8 +109,8 @@ class QEMUMachine(object):
     # This can be used to add an unused monitor instance.
     def add_monitor_telnet(self, ip, port):
         args = 'tcp:%s:%d,server,nowait,telnet' % (ip, port)
-        self.args.append('-monitor')
-        self.args.append(args)
+        self._args.append('-monitor')
+        self._args.append(args)
 
     def add_fd(self, fd, fdset, opaque, opts=''):
         '''Pass a file descriptor to the VM'''
@@ -120,8 +120,8 @@ class QEMUMachine(object):
         if opts:
             options.append(opts)
 
-        self.args.append('-add-fd')
-        self.args.append(','.join(options))
+        self._args.append('-add-fd')
+        self._args.append(','.join(options))
         return self
 
     def send_fd_scm(self, fd_file_path):
@@ -184,7 +184,7 @@ class QEMUMachine(object):
                 '-display', 'none', '-vga', 'none']
 
     def _create_console(self, console_address):
-        for item in self.args:
+        for item in self._args:
             for option in ['isa-serial', 'spapr-vty', 'sclpconsole']:
                 if option in item:
                     return []
@@ -274,7 +274,7 @@ class QEMUMachine(object):
         bargs = self._base_args()
         bargs.extend(self._create_console(console_address))
         self._qemu_full_args = (self._wrapper + [self._binary] +
-                                bargs + self.args)
+                                bargs + self._args)
         self._popen = subprocess.Popen(self._qemu_full_args,
                                        stdin=devnull,
                                        stdout=self._qemu_log_file,
diff --git a/tests/avocado/avocado_qemu/test.py b/tests/avocado/avocado_qemu/test.py
index 5a08dace45..1ead917014 100644
--- a/tests/avocado/avocado_qemu/test.py
+++ b/tests/avocado/avocado_qemu/test.py
@@ -297,8 +297,8 @@ class _VM(qemu.QEMUMachine):
         port = self.ports.find_free_port()
         newvm = _VM(self.qemu_dst_bin, self._arch, username=self.username,
                     password=self.password)
-        newvm.args = self.args
-        newvm.args.extend(['-incoming', 'tcp:0:%s' % port])
+        newvm._args = self._args
+        newvm._args.extend(['-incoming', 'tcp:0:%s' % port])
         newvm.username = self.username
         newvm.password = self.password
 
@@ -329,7 +329,7 @@ class _VM(qemu.QEMUMachine):
         :param extra: Extra parameters to the -drive option
         """
         file_option = 'file=%s' % path
-        for item in self.args:
+        for item in self._args:
             if file_option in item:
                 logging.error('Image %s already present', path)
                 return
@@ -340,7 +340,7 @@ class _VM(qemu.QEMUMachine):
         if snapshot:
             file_option += ',snapshot=on'
 
-        self.args.extend(['-drive', file_option])
+        self._args.extend(['-drive', file_option])
 
         if username is not None:
             self.username = username
@@ -387,7 +387,7 @@ class _VM(qemu.QEMUMachine):
         process.run("%s -output %s -volid cidata -joliet -rock %s %s" %
                     (geniso_bin, iso_path, metadata_path, userdata_path))
 
-        self.args.extend(['-cdrom', iso_path])
+        self._args.extend(['-cdrom', iso_path])
 
 class QemuTest(Test):
 
@@ -415,4 +415,4 @@ class QemuTest(Test):
         if machine_kvm_type is not None:
             machine += "kvm-type=%s," % machine_kvm_type
         if machine:
-            self.vm.args.extend(['-machine', machine])
+            self.vm._args.extend(['-machine', machine])
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index a2e4f03743..b25d48a91b 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -293,18 +293,18 @@ class VM(qtest.QEMUQtestMachine):
         self._num_drives = 0
 
     def add_object(self, opts):
-        self.args.append('-object')
-        self.args.append(opts)
+        self._args.append('-object')
+        self._args.append(opts)
         return self
 
     def add_device(self, opts):
-        self.args.append('-device')
-        self.args.append(opts)
+        self._args.append('-device')
+        self._args.append(opts)
         return self
 
     def add_drive_raw(self, opts):
-        self.args.append('-drive')
-        self.args.append(opts)
+        self._args.append('-drive')
+        self._args.append(opts)
         return self
 
     def add_drive(self, path, opts='', interface='virtio', format=imgfmt):
@@ -322,27 +322,27 @@ class VM(qtest.QEMUQtestMachine):
 
         if format == 'luks' and 'key-secret' not in opts:
             # default luks support
-            if luks_default_secret_object not in self.args:
+            if luks_default_secret_object not in self._args:
                 self.add_object(luks_default_secret_object)
 
             options.append(luks_default_key_secret_opt)
 
-        self.args.append('-drive')
-        self.args.append(','.join(options))
+        self._args.append('-drive')
+        self._args.append(','.join(options))
         self._num_drives += 1
         return self
 
     def add_blockdev(self, opts):
-        self.args.append('-blockdev')
+        self._args.append('-blockdev')
         if isinstance(opts, str):
-            self.args.append(opts)
+            self._args.append(opts)
         else:
-            self.args.append(','.join(opts))
+            self._args.append(','.join(opts))
         return self
 
     def add_incoming(self, addr):
-        self.args.append('-incoming')
-        self.args.append(addr)
+        self._args.append('-incoming')
+        self._args.append(addr)
         return self
 
     def pause_drive(self, drive, event=None):
-- 
2.17.0
