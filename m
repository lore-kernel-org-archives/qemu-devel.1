Received: from eggs.gnu.org ([2001:4830:134:3::10]:33071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cjAAx-0002nK-G1
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 14:44:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cjAAu-0001HI-Rz
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 14:44:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1cjAAu-0001Ge-Ll
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 14:44:36 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7CB247E9D3
	for <qemu-devel@nongnu.org>; Wed,  1 Mar 2017 19:44:36 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
Date: Wed,  1 Mar 2017 14:44:33 -0500
Message-Id: <20170301194433.23379-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH] qmp-shell: add persistent command history
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, kchamart@redhat.com, John Snow <jsnow@redhat.com>

Use the existing readline history function we are utilizing
to provide persistent command history across instances of qmp-shell.

This assists entering debug commands across sessions that may be
interrupted by QEMU sessions terminating, where the qmp-shell has
to be relaunched.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qmp/qmp-shell | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 0373b24..b19f44b 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -70,6 +70,7 @@ import json
 import ast
 import readline
 import sys
+import os
 
 class QMPCompleter(list):
     def complete(self, text, state):
@@ -109,6 +110,8 @@ class QMPShell(qmp.QEMUMonitorProtocol):
         self._pretty = pretty
         self._transmode = False
         self._actions = list()
+        self._histfile = os.path.join(os.path.expanduser('~'),
+                                      '.qmp_history')
 
     def __get_address(self, arg):
         """
@@ -137,6 +140,16 @@ class QMPShell(qmp.QEMUMonitorProtocol):
         # XXX: default delimiters conflict with some command names (eg. query-),
         # clearing everything as it doesn't seem to matter
         readline.set_completer_delims('')
+        try:
+            readline.read_history_file(self._histfile)
+        except:
+            pass
+
+    def __save_history(self):
+        try:
+            readline.write_history_file(self._histfile)
+        except:
+            pass
 
     def __parse_value(self, val):
         try:
@@ -244,6 +257,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
             print 'command format: <command-name> ',
             print '[arg-name1=arg1] ... [arg-nameN=argN]'
             return True
+        self.__save_history()
         # For transaction mode, we may have just cached the action:
         if qmpcmd is None:
             return True
-- 
2.9.3
