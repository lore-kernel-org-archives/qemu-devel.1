Received: from eggs.gnu.org ([2001:4830:134:3::10]:57729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dfBID-0008LW-Aa
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:39:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dfBIA-0000RY-5E
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:39:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35835)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dfBI9-0000QK-Ve
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:39:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E273066199
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 20:39:52 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  8 Aug 2017 17:39:32 -0300
Message-Id: <20170808203935.30021-3-ehabkost@redhat.com>
In-Reply-To: <20170808203935.30021-1-ehabkost@redhat.com>
References: <20170808203935.30021-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 v2 2/5] qmp-shell: Pass split cmdargs
 to __build_cmd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>

This will allow us to implement a method to run a command that is
already split in a list.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Tested-by: John Snow <jsnow@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* (none)
---
 scripts/qmp/qmp-shell | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index ad72ef9..f93c1cf 100755
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
