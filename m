Received: from eggs.gnu.org ([2001:4830:134:3::10]:33875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d3s1f-0005aN-EO
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 18:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d3s1b-0002Nn-I1
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 18:36:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1d3s1b-0002NA-Az
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 18:36:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 30B1680041
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 22:36:34 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
Date: Thu, 27 Apr 2017 18:36:28 -0400
Message-Id: <20170427223628.20893-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3] qmp-shell: add persistent command history
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

v3: Hardcoded limit of 1024 lines of history for now,
    as setting limits in ~/.inputrc does not appear to work (Nir)

v2: Adjusted the errors to whine about non-ENOENT errors, but still
    intercept all errors as non-fatal.
    Save history atexit() to match bash standard behavior

 scripts/qmp/qmp-shell | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index eccb88a..6ece6e7 100755
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
@@ -109,6 +112,8 @@ class QMPShell(qmp.QEMUMonitorProtocol):
         self._pretty = pretty
         self._transmode = False
         self._actions = list()
+        self._histfile = os.path.join(os.path.expanduser('~'),
+                                      '.qmp-shell_history')
 
     def __get_address(self, arg):
         """
@@ -132,11 +137,27 @@ class QMPShell(qmp.QEMUMonitorProtocol):
     def __completer_setup(self):
         self._completer = QMPCompleter()
         self._fill_completion()
+        readline.set_history_length(1024)
         readline.set_completer(self._completer.complete)
         readline.parse_and_bind("tab: complete")
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
