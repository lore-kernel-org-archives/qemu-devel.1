Received: from eggs.gnu.org ([2001:4830:134:3::10]:37211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9adt-0004Sg-S2
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9ads-0004bT-M6
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:20:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f9adr-0004Ws-Qg
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:20:16 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 20 Apr 2018 15:19:28 -0300
Message-Id: <20180420181951.7252-2-ehabkost@redhat.com>
In-Reply-To: <20180420181951.7252-1-ehabkost@redhat.com>
References: <20180420181951.7252-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 01/24] qemu.py: Introduce _create_console() method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Alistair Francis <alistair23@gmail.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>

From: Amador Pahim <apahim@redhat.com>

This patch adds the QEMUMachine._create_console() method, which
returns a list with the chardev console device arguments to be
used in the qemu command line.

Signed-off-by: Amador Pahim <apahim@redhat.com>
[ehabkost: reword commit message]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 49 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 08a3e9af5a..9e9d502543 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -55,7 +55,7 @@ class QEMUMachine(object):
 
     def __init__(self, binary, args=None, wrapper=None, name=None,
                  test_dir="/var/tmp", monitor_address=None,
-                 socket_scm_helper=None):
+                 socket_scm_helper=None, arch=None):
         '''
         Initialize a QEMUMachine
 
@@ -91,6 +91,10 @@ class QEMUMachine(object):
         self._test_dir = test_dir
         self._temp_dir = None
         self._launched = False
+        if arch is None:
+            arch = binary.split('-')[-1]
+        self._arch = arch
+        self._console_address = None
 
         # just in case logging wasn't configured by the main script:
         logging.basicConfig()
@@ -179,6 +183,39 @@ class QEMUMachine(object):
                 '-mon', 'chardev=mon,mode=control',
                 '-display', 'none', '-vga', 'none']
 
+    def _create_console(self, console_address):
+        for item in self._args:
+            for option in ['isa-serial', 'spapr-vty', 'sclpconsole']:
+                if option in item:
+                    return []
+
+        chardev = 'socket,id=console,{address},server,nowait'
+        if console_address is None:
+            console_address = tempfile.mktemp()
+            chardev = chardev.format(address='path=%s' %
+                                     console_address)
+        elif isinstance(console_address, tuple):
+            chardev = chardev.format(address='host=%s,port=%s' %
+                                     (console_address[0],
+                                     console_address[1]))
+        else:
+            chardev = chardev.format(address='path=%s' % console_address)
+
+        self._console_address = console_address
+
+        device = '{dev_type},chardev=console'
+        if '86' in self._arch:
+            device = device.format(dev_type='isa-serial')
+        elif 'ppc' in self._arch:
+            device = device.format(dev_type='spapr-vty')
+        elif 's390x' in self._arch:
+            device = device.format(dev_type='sclpconsole')
+        else:
+            return []
+
+        return ['-chardev', chardev,
+                '-device', device]
+
     def _pre_launch(self):
         self._temp_dir = tempfile.mkdtemp(dir=self._test_dir)
         if self._monitor_address is not None:
@@ -206,7 +243,7 @@ class QEMUMachine(object):
             shutil.rmtree(self._temp_dir)
             self._temp_dir = None
 
-    def launch(self):
+    def launch(self, console_address=None):
         """
         Launch the VM and make sure we cleanup and expose the
         command line/output in case of exception
@@ -218,7 +255,7 @@ class QEMUMachine(object):
         self._iolog = None
         self._qemu_full_args = None
         try:
-            self._launch()
+            self._launch(console_address)
             self._launched = True
         except:
             self.shutdown()
@@ -230,12 +267,14 @@ class QEMUMachine(object):
                 LOG.debug('Output: %r', self._iolog)
             raise
 
-    def _launch(self):
+    def _launch(self, console_address):
         '''Launch the VM and establish a QMP connection'''
         devnull = open(os.path.devnull, 'rb')
         self._pre_launch()
+        bargs = self._base_args()
+        bargs.extend(self._create_console(console_address))
         self._qemu_full_args = (self._wrapper + [self._binary] +
-                                self._base_args() + self._args)
+                                bargs + self.args)
         self._popen = subprocess.Popen(self._qemu_full_args,
                                        stdin=devnull,
                                        stdout=self._qemu_log_file,
-- 
2.14.3
