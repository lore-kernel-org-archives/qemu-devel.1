Received: from eggs.gnu.org ([2001:4830:134:3::10]:38759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ddkM9-0002IL-P0
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 17:42:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ddkM6-0005lJ-J8
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 17:42:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ddkM6-0005k9-AQ
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 17:42:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 80F5A6147D
	for <qemu-devel@nongnu.org>; Fri,  4 Aug 2017 21:36:29 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  4 Aug 2017 18:36:21 -0300
Message-Id: <20170804213625.3756-2-ehabkost@redhat.com>
In-Reply-To: <20170804213625.3756-1-ehabkost@redhat.com>
References: <20170804213625.3756-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 1/5] qmp-shell: Use argparse module
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

It makes command-line parsing and generation of help text much
simpler.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qmp/qmp-shell | 61 +++++++++++++++++----------------------------------
 1 file changed, 20 insertions(+), 41 deletions(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 860ffb2..c276b90 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -73,6 +73,7 @@ import sys
 import os
 import errno
 import atexit
+import argparse
 
 class QMPCompleter(list):
     def complete(self, text, state):
@@ -393,61 +394,39 @@ def die(msg):
     sys.stderr.write('ERROR: %s\n' % msg)
     sys.exit(1)
 
-def fail_cmdline(option=None):
-    if option:
-        sys.stderr.write('ERROR: bad command-line option \'%s\'\n' % option)
-    sys.stderr.write('qmp-shell [ -v ] [ -p ] [ -H ] [ -N ] < UNIX socket path> | < TCP address:port >\n')
-    sys.stderr.write('    -v     Verbose (echo command sent and received)\n')
-    sys.stderr.write('    -p     Pretty-print JSON\n')
-    sys.stderr.write('    -H     Use HMP interface\n')
-    sys.stderr.write('    -N     Skip negotiate (for qemu-ga)\n')
-    sys.exit(1)
-
 def main():
-    addr = ''
-    qemu = None
-    hmp = False
-    pretty = False
-    verbose = False
-    negotiate = True
+    parser = argparse.ArgumentParser(description='QMP shell utility')
+    parser.add_argument('-v', action='store_true', dest='verbose',
+        help='Verbose (echo command sent and received)')
+    parser.add_argument('-p', action='store_true', dest='pretty',
+        help='Pretty-print JSON')
+    parser.add_argument('-H', action='store_true', dest='hmp',
+        help='Use HMP interface')
+    parser.add_argument('-N', action='store_false', dest='negotiate',
+        default=True, help='Skip negotiate (for qemu-ga)')
+    parser.add_argument('addr', metavar='ADDRESS',
+        help='QMP socket address (Unix socket path or TCP address:port)')
+    args = parser.parse_args()
 
     try:
-        for arg in sys.argv[1:]:
-            if arg == "-H":
-                if qemu is not None:
-                    fail_cmdline(arg)
-                hmp = True
-            elif arg == "-p":
-                pretty = True
-            elif arg == "-N":
-                negotiate = False
-            elif arg == "-v":
-                verbose = True
-            else:
-                if qemu is not None:
-                    fail_cmdline(arg)
-                if hmp:
-                    qemu = HMPShell(arg)
-                else:
-                    qemu = QMPShell(arg, pretty)
-                addr = arg
-
-        if qemu is None:
-            fail_cmdline()
+        if args.hmp:
+            qemu = HMPShell(args.addr)
+        else:
+            qemu = QMPShell(args.addr, args.pretty)
     except QMPShellBadPort:
         die('bad port number in command-line')
 
     try:
-        qemu.connect(negotiate)
+        qemu.connect(args.negotiate)
     except qmp.QMPConnectError:
         die('Didn\'t get QMP greeting message')
     except qmp.QMPCapabilitiesError:
         die('Could not negotiate capabilities')
     except qemu.error:
-        die('Could not connect to %s' % addr)
+        die('Could not connect to %s' % args.addr)
 
     qemu.show_banner()
-    qemu.set_verbosity(verbose)
+    qemu.set_verbosity(args.verbose)
     while qemu.read_exec_command(qemu.get_prompt()):
         pass
     qemu.close()
-- 
2.9.4
