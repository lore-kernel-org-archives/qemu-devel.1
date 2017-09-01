Received: from eggs.gnu.org ([2001:4830:134:3::10]:59655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dnkAt-0001BH-EI
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:31:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dnkAq-0006tS-8y
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:31:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1dnkAq-0006tK-2X
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:31:44 -0400
From: Amador Pahim <apahim@redhat.com>
Date: Fri,  1 Sep 2017 13:28:21 +0200
Message-Id: <20170901112829.2571-6-apahim@redhat.com>
In-Reply-To: <20170901112829.2571-1-apahim@redhat.com>
References: <20170901112829.2571-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v8 05/13] qemu.py: include debug information on
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
initiated, it might be useful to see the qemu command line and
the qemu command output.

This patch creates that message. Notice that self._iolog needs to be
cleaned up in the beginning of the launch() to make sure we will not
expose the qemu log from a previous launch if the current one fails.

Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 670c048569..3ebe5ee0a4 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -141,6 +141,7 @@ class QEMUMachine(object):
 
     def launch(self):
         '''Launch the VM and establish a QMP connection'''
+        self._iolog = None
         self._qemu_full_args = None
         devnull = open(os.path.devnull, 'rb')
         qemulog = open(self._qemu_log_path, 'wb')
@@ -160,6 +161,12 @@ class QEMUMachine(object):
                 self._popen.wait()
             self._load_io_log()
             self._post_shutdown()
+
+            LOG.debug('Error launching VM')
+            if self._qemu_full_args:
+                LOG.debug('Command: %r', ' '.join(self._qemu_full_args))
+            if self._iolog:
+                LOG.debug('Output: %r', self._iolog)
             raise
 
     def shutdown(self):
-- 
2.13.5
