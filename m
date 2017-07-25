Received: from eggs.gnu.org ([2001:4830:134:3::10]:48426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1da3SN-0002wB-Vd
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:17:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1da3SJ-0007kK-Ub
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:17:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1da3SJ-0007iv-M3
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:17:11 -0400
From: Amador Pahim <apahim@redhat.com>
Date: Tue, 25 Jul 2017 19:10:09 +0200
Message-Id: <20170725171014.25193-2-apahim@redhat.com>
In-Reply-To: <20170725171014.25193-1-apahim@redhat.com>
References: <20170725171014.25193-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v5 1/6] qemu.py: make 'args' public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, famz@redhat.com, berrange@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, crosa@redhat.com, ldoktor@redhat.com, Amador Pahim <apahim@redhat.com>

Let's make args public so users can extend it in instances
without feeling like abusing the internal API.

Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py               | 14 +++++++-------
 tests/qemu-iotests/iotests.py | 18 +++++++++---------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 880e3e8219..59ed5270f8 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -33,7 +33,7 @@ class QEMUMachine(object):
         self._qemu_log_path = os.path.join(test_dir, name + ".log")
         self._popen = None
         self._binary = binary
-        self._args = list(args) # Force copy args in case we modify them
+        self.args = list(args) # Force copy args in case we modify them
         self._wrapper = wrapper
         self._events = []
         self._iolog = None
@@ -43,8 +43,8 @@ class QEMUMachine(object):
     # This can be used to add an unused monitor instance.
     def add_monitor_telnet(self, ip, port):
         args = 'tcp:%s:%d,server,nowait,telnet' % (ip, port)
-        self._args.append('-monitor')
-        self._args.append(args)
+        self.args.append('-monitor')
+        self.args.append(args)
 
     def add_fd(self, fd, fdset, opaque, opts=''):
         '''Pass a file descriptor to the VM'''
@@ -54,8 +54,8 @@ class QEMUMachine(object):
         if opts:
             options.append(opts)
 
-        self._args.append('-add-fd')
-        self._args.append(','.join(options))
+        self.args.append('-add-fd')
+        self.args.append(','.join(options))
         return self
 
     def send_fd_scm(self, fd_file_path):
@@ -131,7 +131,7 @@ class QEMUMachine(object):
         qemulog = open(self._qemu_log_path, 'wb')
         try:
             self._pre_launch()
-            args = self._wrapper + [self._binary] + self._base_args() + self._args
+            args = self._wrapper + [self._binary] + self._base_args() + self.args
             self._popen = subprocess.Popen(args, stdin=devnull, stdout=qemulog,
                                            stderr=subprocess.STDOUT, shell=False)
             self._post_launch()
@@ -154,7 +154,7 @@ class QEMUMachine(object):
 
             exitcode = self._popen.wait()
             if exitcode < 0:
-                sys.stderr.write('qemu received signal %i: %s\n' % (-exitcode, ' '.join(self._args)))
+                sys.stderr.write('qemu received signal %i: %s\n' % (-exitcode, ' '.join(self.args)))
             self._load_io_log()
             self._post_shutdown()
 
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index abcf3c10e2..6925d8841e 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -150,13 +150,13 @@ class VM(qtest.QEMUQtestMachine):
         self._num_drives = 0
 
     def add_device(self, opts):
-        self._args.append('-device')
-        self._args.append(opts)
+        self.args.append('-device')
+        self.args.append(opts)
         return self
 
     def add_drive_raw(self, opts):
-        self._args.append('-drive')
-        self._args.append(opts)
+        self.args.append('-drive')
+        self.args.append(opts)
         return self
 
     def add_drive(self, path, opts='', interface='virtio', format=imgfmt):
@@ -172,17 +172,17 @@ class VM(qtest.QEMUQtestMachine):
         if opts:
             options.append(opts)
 
-        self._args.append('-drive')
-        self._args.append(','.join(options))
+        self.args.append('-drive')
+        self.args.append(','.join(options))
         self._num_drives += 1
         return self
 
     def add_blockdev(self, opts):
-        self._args.append('-blockdev')
+        self.args.append('-blockdev')
         if isinstance(opts, str):
-            self._args.append(opts)
+            self.args.append(opts)
         else:
-            self._args.append(','.join(opts))
+            self.args.append(','.join(opts))
         return self
 
     def pause_drive(self, drive, event=None):
-- 
2.13.3
