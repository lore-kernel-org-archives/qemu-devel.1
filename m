Received: from eggs.gnu.org ([2001:4830:134:3::10]:57514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dfBI6-0008Hn-3g
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dfBI4-0000MU-S9
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:39:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dfBI4-0000Lp-Jg
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:39:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 98329552E9
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 20:39:47 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  8 Aug 2017 17:39:31 -0300
Message-Id: <20170808203935.30021-2-ehabkost@redhat.com>
In-Reply-To: <20170808203935.30021-1-ehabkost@redhat.com>
References: <20170808203935.30021-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 v2 1/5] qmp-shell: Use optparse module
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

It makes command-line parsing and generation of help text much
simpler.

The optparse module is deprecated since Python 2.7, but argparse
is not available in Python 2.6 (the minimum Python version
required for building QEMU).

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Use optparse module, as the minimum Python version for building
  QEMU is 2.6
  * Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
  * Suggested-by: "Daniel P. Berrange" <berrange@redhat.com>
---
 scripts/qmp/qmp-shell | 63 +++++++++++++++++++--------------------------------
 1 file changed, 23 insertions(+), 40 deletions(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 860ffb2..ad72ef9 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -73,6 +73,7 @@ import sys
 import os
 import errno
 import atexit
+import optparse
 
 class QMPCompleter(list):
     def complete(self, text, state):
@@ -393,52 +394,34 @@ def die(msg):
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
+    parser = optparse.OptionParser(description='QMP shell utility')
+    parser.set_usage("%prog [options] <UNIX socket path> | <TCP address:port>")
+    parser.add_option('-v', action='store_true', dest='verbose',
+        help='Verbose (echo command sent and received)')
+    parser.add_option('-p', action='store_true', dest='pretty',
+        help='Pretty-print JSON')
+    parser.add_option('-H', action='store_true', dest='hmp',
+        help='Use HMP interface')
+    parser.add_option('-N', action='store_false', dest='negotiate',
+        default=True, help='Skip negotiate (for qemu-ga)')
+    opts,args = parser.parse_args()
+
+    if len(args) != 1:
+        parser.print_help(sys.stderr)
+        sys.exit(1)
+    addr = args[0]
 
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
+        if opts.hmp:
+            qemu = HMPShell(addr)
+        else:
+            qemu = QMPShell(addr, opts.pretty)
     except QMPShellBadPort:
         die('bad port number in command-line')
 
     try:
-        qemu.connect(negotiate)
+        qemu.connect(opts.negotiate)
     except qmp.QMPConnectError:
         die('Didn\'t get QMP greeting message')
     except qmp.QMPCapabilitiesError:
@@ -447,7 +430,7 @@ def main():
         die('Could not connect to %s' % addr)
 
     qemu.show_banner()
-    qemu.set_verbosity(verbose)
+    qemu.set_verbosity(opts.verbose)
     while qemu.read_exec_command(qemu.get_prompt()):
         pass
     qemu.close()
-- 
2.9.4
