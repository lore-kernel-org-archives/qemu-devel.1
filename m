Received: from eggs.gnu.org ([2001:4830:134:3::10]:53476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dc6RF-0006S0-01
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dc6RD-0000gv-P2
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:52:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1dc6RD-0000g2-FK
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:52:31 -0400
From: Amador Pahim <apahim@redhat.com>
Date: Mon, 31 Jul 2017 10:51:10 +0200
Message-Id: <20170731085110.1050-8-apahim@redhat.com>
In-Reply-To: <20170731085110.1050-1-apahim@redhat.com>
References: <20170731085110.1050-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v6 7/7] qemu.py: include debug information on
 launch error
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

When launching a VM, if an exception happens and the VM is not
initiated, it is useful to see the qemu command line that was executed
and the output of that command.

Before this patch:

    >>> import qemu
    >>> vm = qemu.QEMUMachine('qemu-system-aarch64', debug=True)
    >>> vm.launch()
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
      File "qemu.py", line 175, in launch
        self._launch()
      File "qemu.py", line 189, in _launch
        self._post_launch()
      File "qemu.py", line 154, in _post_launch
        self._qmp.accept()
      File "qmp/qmp.py", line 145, in accept
        self.__sock, _ = self.__sock.accept()
      File "/usr/lib64/python2.7/socket.py", line 206, in accept
        sock, addr = self._sock.accept()
    socket.timeout: timed out
    >>>

After this patch:

    >>> import qemu
    >>> vm = qemu.QEMUMachine('qemu-system-aarch64', debug=True)
    >>> vm.launch()
    DEBUG:qemu:Error launching VM. Command: 'qemu-system-aarch64
    -chardev socket,id=mon,path=/var/tmp/qemu-5298-monitor.sock
    -mon chardev=mon,mode=control -display none -vga none'.
    Output: 'qemu-system-aarch64: No machine specified, and there
    is no default\nUse -machine help to list supported machines\n'.
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
      File "qemu.py", line 175, in launch
        self._launch()
      File "qemu.py", line 189, in _launch
        self._post_launch()
      File "qemu.py", line 154, in _post_launch
        self._qmp.accept()
      File "qmp/qmp.py", line 145, in accept
        self.__sock, _ = self.__sock.accept()
      File "/usr/lib64/python2.7/socket.py", line 206, in accept
        sock, addr = self._sock.accept()
    socket.timeout: timed out
    >>>

Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index e9a3a96d13..43fd0b072c 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -158,7 +158,10 @@ class QEMUMachine(object):
             self._remove_if_exists(self._created_files.pop())
 
     def launch(self):
-        '''Launch the VM and establish a QMP connection'''
+        '''
+        Try to launch the VM and make sure we cleanup and expose the
+        command line/output in case of exception.
+        '''
 
         if self.is_running():
             raise QEMULaunchError('VM already running.')
@@ -169,6 +172,7 @@ class QEMUMachine(object):
                                   'before launching again.')
 
         try:
+            self._iolog = None
             self._qemu_full_args = None
             self._qemu_full_args = (self._wrapper + [self._binary] +
                                     self._base_args() + self._args)
@@ -176,9 +180,15 @@ class QEMUMachine(object):
             self._pending_shutdown = True
         except:
             self.shutdown()
+            LOG.debug('Error launching VM.%s%s',
+                      ' Command: %r.' % ' '.join(self._qemu_full_args)
+                      if self._qemu_full_args else '',
+                      ' Output: %r.' % self._iolog
+                      if self._iolog else '')
             raise
 
     def _launch(self):
+        '''Launch the VM and establish a QMP connection.'''
         self._pre_launch()
         devnull = open(os.path.devnull, 'rb')
         self._popen = subprocess.Popen(self._qemu_full_args,
-- 
2.13.3
