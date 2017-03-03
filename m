Received: from eggs.gnu.org ([2001:4830:134:3::10]:43539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cjsLa-0001JK-Oz
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:54:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cjsLV-00077Y-T1
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:54:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1cjsLV-00076Z-N6
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:54:29 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8EB3EC0567A1
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 18:54:29 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
Date: Fri,  3 Mar 2017 13:54:27 -0500
Message-Id: <20170303185427.32681-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2] qmp-shell: add persistent command history
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

v2: Adjusted the errors to whine about non-ENOENT errors, but still
    intercept all errors as non-fatal.
    Save history atexit() to match bash standard behavior

 scripts/qmp/qmp-shell | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 0373b24..55a8285 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -70,6 +70,9 @@ import json
 import ast
 import readline
 import sys
+import os
+import errno
+import atexit
 
 class QMPCompleter(list):
     def complete(self, text, state):
@@ -109,6 +112,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
         self._pretty = pretty
         self._transmode = False
         self._actions = list()
+        self._histfile = os.path.join(os.path.expanduser('~'), '.qmp_history')
 
     def __get_address(self, arg):
         """
@@ -137,6 +141,21 @@ class QMPShell(qmp.QEMUMonitorProtocol):
         # XXX: default delimiters conflict with some command names (eg. query-),
         # clearing everything as it doesn't seem to matter
         readline.set_completer_delims('')
+        try:
+            readline.read_history_file(self._histfile)
+        except Exception as e:
+            if isinstance(e, IOError) and e.errno == errno.ENOENT:
+                # File not found. No problem.
+                pass
+            else:
+                print "Failed to read history '%s'; %s" % (self._histfile, e)
+        atexit.register(self.__save_history)
+
+    def __save_history(self):
+        try:
+            readline.write_history_file(self._histfile)
+        except Exception as e:
+            print "Failed to save history file '%s'; %s" % (self._histfile, e)
 
     def __parse_value(self, val):
         try:
-- 
2.9.3
