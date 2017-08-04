Received: from eggs.gnu.org ([2001:4830:134:3::10]:39484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ddkNT-0002zM-80
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 17:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ddkNQ-0006hL-4M
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 17:43:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ddkNP-0006gU-Uy
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 17:43:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6533B4629B
	for <qemu-devel@nongnu.org>; Fri,  4 Aug 2017 21:36:31 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  4 Aug 2017 18:36:22 -0300
Message-Id: <20170804213625.3756-3-ehabkost@redhat.com>
In-Reply-To: <20170804213625.3756-1-ehabkost@redhat.com>
References: <20170804213625.3756-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 2/5] qmp-shell: Pass split cmdargs to
 __build_cmd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

This will allow us to implement a method to run a command that is
already split in a list.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qmp/qmp-shell | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index c276b90..5fe6162 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -212,15 +212,13 @@ class QMPShell(qmp.QEMUMonitorProtocol):
                     raise QMPShellError('Cannot set "%s" multiple times' % key)
             parent[optpath[-1]] = value
 
-    def __build_cmd(self, cmdline):
+    def __build_cmd(self, cmdargs):
         """
         Build a QMP input object from a user provided command-line in the
         following format:
 
             < command-name > [ arg-name1=arg1 ] ... [ arg-nameN=argN ]
         """
-        cmdargs = cmdline.split()
-
         # Transactional CLI entry/exit:
         if cmdargs[0] == 'transaction(':
             self._transmode = True
@@ -247,7 +245,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
                 finalize = True
             self.__cli_expr(cmdargs[1:], action['data'])
             self._actions.append(action)
-            return self.__build_cmd(')') if finalize else None
+            return self.__build_cmd([')']) if finalize else None
 
         # Standard command: parse and return it to be executed.
         qmpcmd = { 'execute': cmdargs[0], 'arguments': {} }
@@ -262,8 +260,9 @@ class QMPShell(qmp.QEMUMonitorProtocol):
         print str(jsobj)
 
     def _execute_cmd(self, cmdline):
+        cmdargs = cmdline.split()
         try:
-            qmpcmd = self.__build_cmd(cmdline)
+            qmpcmd = self.__build_cmd(cmdargs)
         except Exception as e:
             print 'Error while parsing command line: %s' % e
             print 'command format: <command-name> ',
-- 
2.9.4
