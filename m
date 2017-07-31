Received: from eggs.gnu.org ([2001:4830:134:3::10]:53375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dc6R2-0006Ij-DH
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:52:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dc6Qy-0000Xv-I6
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:52:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1dc6Qy-0000Xn-B9
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:52:16 -0400
From: Amador Pahim <apahim@redhat.com>
Date: Mon, 31 Jul 2017 10:51:07 +0200
Message-Id: <20170731085110.1050-5-apahim@redhat.com>
In-Reply-To: <20170731085110.1050-1-apahim@redhat.com>
References: <20170731085110.1050-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v6 4/7] qemu.py: improve message on negative
 exit code
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

The current message shows 'self._args', which contains only part of the
options used in the qemu command line.

This patch makes the qemu full args list an instance variable and then
uses it in the negative exit code message.

Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index e3ea534ec4..9434ccc30b 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -48,6 +48,7 @@ class QEMUMachine(object):
         self._iolog = None
         self._socket_scm_helper = socket_scm_helper
         self._debug = debug
+        self._qemu_full_args = None
 
     # This can be used to add an unused monitor instance.
     def add_monitor_telnet(self, ip, port):
@@ -140,9 +141,14 @@ class QEMUMachine(object):
         qemulog = open(self._qemu_log_path, 'wb')
         try:
             self._pre_launch()
-            args = self._wrapper + [self._binary] + self._base_args() + self._args
-            self._popen = subprocess.Popen(args, stdin=devnull, stdout=qemulog,
-                                           stderr=subprocess.STDOUT, shell=False)
+            self._qemu_full_args = None
+            self._qemu_full_args = (self._wrapper + [self._binary] +
+                                    self._base_args() + self._args)
+            self._popen = subprocess.Popen(self._qemu_full_args,
+                                           stdin=devnull,
+                                           stdout=qemulog,
+                                           stderr=subprocess.STDOUT,
+                                           shell=False)
             self._post_launch()
         except:
             if self.is_running():
@@ -163,8 +169,9 @@ class QEMUMachine(object):
 
             exitcode = self._popen.wait()
             if exitcode < 0:
-                LOG.error('qemu received signal %i: %s', -exitcode,
-                          ' '.join(self._args))
+                LOG.error('qemu received signal %i:%s', -exitcode,
+                          ' Command: %r.' % ' '.join(self._qemu_full_args)
+                          if self._qemu_full_args else '')
             self._load_io_log()
             self._post_shutdown()
 
-- 
2.13.3
