Received: from eggs.gnu.org ([2001:4830:134:3::10]:56714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0CF-0005nY-GB
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0CE-0003LY-L7
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dt0CD-0003IS-V1
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:54 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 15 Sep 2017 20:37:38 -0300
Message-Id: <20170915233739.26860-15-ehabkost@redhat.com>
In-Reply-To: <20170915233739.26860-1-ehabkost@redhat.com>
References: <20170915233739.26860-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 14/15] qemu.py: improve message on negative exit
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Amador Pahim <apahim@redhat.com>

From: Amador Pahim <apahim@redhat.com>

The current message shows 'self._args', which contains only part of the
options used in the Qemu command line.

This patch makes the qemu full args list an instance variable and then
uses it in the negative exit code message.

Message was moved outside the 'if is_running' block to make sure it will
be logged if the VM finishes before the call to shutdown().

Signed-off-by: Amador Pahim <apahim@redhat.com>
Message-Id: <20170901112829.2571-5-apahim@redhat.com>
[ehabkost: removed superfluous parenthesis]
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index c9bcaafe41..9440261ac3 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -87,6 +87,7 @@ class QEMUMachine(object):
         self._socket_scm_helper = socket_scm_helper
         self._debug = debug
         self._qmp = None
+        self._qemu_full_args = None
 
     def __enter__(self):
         return self
@@ -186,13 +187,16 @@ class QEMUMachine(object):
 
     def launch(self):
         '''Launch the VM and establish a QMP connection'''
+        self._qemu_full_args = None
         devnull = open(os.path.devnull, 'rb')
         qemulog = open(self._qemu_log_path, 'wb')
         try:
             self._pre_launch()
-            args = (self._wrapper + [self._binary] + self._base_args() +
-                    self._args)
-            self._popen = subprocess.Popen(args, stdin=devnull, stdout=qemulog,
+            self._qemu_full_args = self._wrapper + [self._binary] +
+                                    self._base_args() + self._args
+            self._popen = subprocess.Popen(self._qemu_full_args,
+                                           stdin=devnull,
+                                           stdout=qemulog,
                                            stderr=subprocess.STDOUT,
                                            shell=False)
             self._post_launch()
@@ -212,14 +216,20 @@ class QEMUMachine(object):
                 self._qmp.close()
             except:
                 self._popen.kill()
+            self._popen.wait()
 
-            exitcode = self._popen.wait()
-            if exitcode < 0:
-                LOG.warn('qemu received signal %i: %s', -exitcode,
-                          ' '.join(self._args))
             self._load_io_log()
             self._post_shutdown()
 
+        exitcode = self.exitcode()
+        if exitcode is not None and exitcode < 0:
+            msg = 'qemu received signal %i: %s'
+            if self._qemu_full_args:
+                command = ' '.join(self._qemu_full_args)
+            else:
+                command = ''
+            LOG.warn(msg, exitcode, command)
+
     def qmp(self, cmd, conv_keys=True, **args):
         '''Invoke a QMP command and return the response dict'''
         qmp_args = dict()
-- 
2.13.5
