Received: from eggs.gnu.org ([2001:4830:134:3::10]:32973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fHC-0002SL-Db
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:40:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fHB-0001S1-Mw
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:40:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f1fHB-0001QX-Ep
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:40:05 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 29 Mar 2018 18:38:49 -0300
Message-Id: <20180329213857.15499-11-ehabkost@redhat.com>
In-Reply-To: <20180329213857.15499-1-ehabkost@redhat.com>
References: <20180329213857.15499-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 10/18] qemu.py: Set _launched = False on
 _post_shutdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel@redhat.com>, Amador Pahim <apahim@redhat.com>

This will allow a sequence like:

  vm.launch()
  vm.cmd('quit')
  vm.wait()  # triggers post-shutdown code
  vm.launch()

to work.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index e82540a235..226d2c4d48 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -225,6 +225,8 @@ class QEMUMachine(object):
             shutil.rmtree(self._temp_dir)
             self._temp_dir = None
 
+        self._launched = False
+
     def launch(self):
         """
         Launch the VM and make sure we cleanup and expose the
@@ -286,8 +288,6 @@ class QEMUMachine(object):
                 command = ''
             LOG.warn(msg, exitcode, command)
 
-        self._launched = False
-
     def qmp(self, cmd, conv_keys=True, **args):
         '''Invoke a QMP command and return the response dict'''
         qmp_args = dict()
-- 
2.14.3
