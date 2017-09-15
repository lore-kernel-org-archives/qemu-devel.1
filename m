Received: from eggs.gnu.org ([2001:4830:134:3::10]:56786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0CN-0005tE-Bq
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:39:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0CK-0003jn-9z
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:39:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dt0CK-0003gA-4T
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:39:00 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 15 Sep 2017 20:37:39 -0300
Message-Id: <20170915233739.26860-16-ehabkost@redhat.com>
In-Reply-To: <20170915233739.26860-1-ehabkost@redhat.com>
References: <20170915233739.26860-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 15/15] qemu.py: include debug information on
 launch error
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

When launching a VM, if an exception happens and the VM is not
initiated, it might be useful to see the qemu command line and
the qemu command output.

This patch creates that message. Notice that self._iolog needs to be
cleaned up in the beginning of the launch() to make sure we will not
expose the qemu log from a previous launch if the current one fails.

Signed-off-by: Amador Pahim <apahim@redhat.com>
Message-Id: <20170901112829.2571-6-apahim@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 9440261ac3..8c67595ec8 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -187,6 +187,7 @@ class QEMUMachine(object):
 
     def launch(self):
         '''Launch the VM and establish a QMP connection'''
+        self._iolog = None
         self._qemu_full_args = None
         devnull = open(os.path.devnull, 'rb')
         qemulog = open(self._qemu_log_path, 'wb')
@@ -206,6 +207,12 @@ class QEMUMachine(object):
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
