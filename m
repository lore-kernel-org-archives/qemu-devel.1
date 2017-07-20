Received: from eggs.gnu.org ([2001:4830:134:3::10]:49086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dY7dg-0000Ux-7Y
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:20:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dY7dd-0004kx-2M
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:20:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1dY7dc-0004kO-Pf
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:20:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C5EBA7A16A
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 09:20:51 +0000 (UTC)
From: Amador Pahim <apahim@redhat.com>
Date: Thu, 20 Jul 2017 11:19:02 +0200
Message-Id: <20170720091902.22476-4-apahim@redhat.com>
In-Reply-To: <20170720091902.22476-1-apahim@redhat.com>
References: <20170720091902.22476-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/3] qemu.py: make 'args' public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, berrange@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, crosa@redhat.com, ldoktor@redhat.com, Amador Pahim <apahim@redhat.com>

Let's make args public so users can extend it without feeling like
abusing the internal API.

Signed-off-by: Amador Pahim <apahim@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 scripts/qemu.py               | 13 +++++++------
 tests/qemu-iotests/iotests.py | 18 +++++++++---------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 2707ae7f75..2c2043f89a 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -34,7 +34,7 @@ class QEMUMachine(object):
         self._qemu_log_path = os.path.join(test_dir, name + ".log")
         self._popen = None
         self._binary = binary
-        self._args = list(args) # Force copy args in case we modify them
+        self.args = list(args) # Force copy args in case we modify them
         self._wrapper = wrapper
         self._events = []
         self._iolog = None
@@ -44,8 +44,8 @@ class QEMUMachine(object):
     # This can be used to add an unused monitor instance.
     def add_monitor_telnet(self, ip, port):
         args = 'tcp:%s:%d,server,nowait,telnet' % (ip, port)
-        self._args.append('-monitor')
-        self._args.append(args)
+        self.args.append('-monitor')
+        self.args.append(args)
 
     def add_fd(self, fd, fdset, opaque, opts=''):
         '''Pass a file descriptor to the VM'''
@@ -55,8 +55,8 @@ class QEMUMachine(object):
         if opts:
             options.append(opts)
 
-        self._args.append('-add-fd')
-        self._args.append(','.join(options))
+        self.args.append('-add-fd')
+        self.args.append(','.join(options))
         return self
 
     def send_fd_scm(self, fd_file_path):
@@ -168,7 +168,8 @@ class QEMUMachine(object):
 
             exitcode = self._popen.wait()
             if exitcode < 0:
-                sys.stderr.write('qemu received signal %i: %s\n' % (-exitcode, ' '.join(self._args)))
+                sys.stderr.write('qemu received signal %i: %s\n' %
+                                 (-exitcode, ' '.join(self.args)))
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
