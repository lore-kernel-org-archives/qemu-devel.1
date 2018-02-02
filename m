Received: from eggs.gnu.org ([208.118.235.92]:55862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdMa-0002hf-Sm
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:35:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdLV-0004e8-OH
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:34:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehdLU-0004cE-Uv
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:33:45 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  2 Feb 2018 14:03:22 +0100
Message-Id: <20180202130336.24719-8-armbru@redhat.com>
In-Reply-To: <20180202130336.24719-1-armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 07/21] qapi: Move parse_command_line() next
 to its only use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi-gen.py    | 52 +++++++++++++++++++++++++++++++++++++++++++++++-
 scripts/qapi/common.py | 54 --------------------------------------------------
 2 files changed, 51 insertions(+), 55 deletions(-)

diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
index 575c938a1b..6302fd0d55 100755
--- a/scripts/qapi-gen.py
+++ b/scripts/qapi-gen.py
@@ -4,8 +4,10 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or later.
 # See the COPYING file in the top-level directory.
 
+import getopt
+import re
 import sys
-from qapi.common import parse_command_line, QAPISchema
+from qapi.common import QAPISchema
 from qapi.types import gen_types
 from qapi.visit import gen_visit
 from qapi.commands import gen_commands
@@ -14,6 +16,54 @@ from qapi.introspect import gen_introspect
 from qapi.doc import gen_doc
 
 
+def parse_command_line(extra_options='', extra_long_options=[]):
+
+    try:
+        opts, args = getopt.gnu_getopt(sys.argv[1:],
+                                       'chp:o:' + extra_options,
+                                       ['source', 'header', 'prefix=',
+                                        'output-dir='] + extra_long_options)
+    except getopt.GetoptError as err:
+        print >>sys.stderr, "%s: %s" % (sys.argv[0], str(err))
+        sys.exit(1)
+
+    output_dir = ''
+    prefix = ''
+    do_c = False
+    do_h = False
+    extra_opts = []
+
+    for oa in opts:
+        o, a = oa
+        if o in ('-p', '--prefix'):
+            match = re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', a)
+            if match.end() != len(a):
+                print >>sys.stderr, \
+                    "%s: 'funny character '%s' in argument of --prefix" \
+                    % (sys.argv[0], a[match.end()])
+                sys.exit(1)
+            prefix = a
+        elif o in ('-o', '--output-dir'):
+            output_dir = a + '/'
+        elif o in ('-c', '--source'):
+            do_c = True
+        elif o in ('-h', '--header'):
+            do_h = True
+        else:
+            extra_opts.append(oa)
+
+    if not do_c and not do_h:
+        do_c = True
+        do_h = True
+
+    if len(args) != 1:
+        print >>sys.stderr, "%s: need exactly one argument" % sys.argv[0]
+        sys.exit(1)
+    fname = args[0]
+
+    return (fname, output_dir, do_c, do_h, prefix, extra_opts)
+
+
 def main(argv):
     (input_file, output_dir, do_c, do_h, prefix, opts) = \
         parse_command_line('bu', ['builtins', 'unmask-non-abi-names'])
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index d73ef618e2..cfa2671ca3 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -12,7 +12,6 @@
 # See the COPYING file in the top-level directory.
 
 import errno
-import getopt
 import os
 import re
 import string
@@ -1917,59 +1916,6 @@ def build_params(arg_type, boxed, extra):
 
 
 #
-# Common command line parsing
-#
-
-
-def parse_command_line(extra_options='', extra_long_options=[]):
-
-    try:
-        opts, args = getopt.gnu_getopt(sys.argv[1:],
-                                       'chp:o:' + extra_options,
-                                       ['source', 'header', 'prefix=',
-                                        'output-dir='] + extra_long_options)
-    except getopt.GetoptError as err:
-        print >>sys.stderr, "%s: %s" % (sys.argv[0], str(err))
-        sys.exit(1)
-
-    output_dir = ''
-    prefix = ''
-    do_c = False
-    do_h = False
-    extra_opts = []
-
-    for oa in opts:
-        o, a = oa
-        if o in ('-p', '--prefix'):
-            match = re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', a)
-            if match.end() != len(a):
-                print >>sys.stderr, \
-                    "%s: 'funny character '%s' in argument of --prefix" \
-                    % (sys.argv[0], a[match.end()])
-                sys.exit(1)
-            prefix = a
-        elif o in ('-o', '--output-dir'):
-            output_dir = a + '/'
-        elif o in ('-c', '--source'):
-            do_c = True
-        elif o in ('-h', '--header'):
-            do_h = True
-        else:
-            extra_opts.append(oa)
-
-    if not do_c and not do_h:
-        do_c = True
-        do_h = True
-
-    if len(args) != 1:
-        print >>sys.stderr, "%s: need exactly one argument" % sys.argv[0]
-        sys.exit(1)
-    fname = args[0]
-
-    return (fname, output_dir, do_c, do_h, prefix, extra_opts)
-
-
-#
 # Accumulate and write output
 #
 
-- 
2.13.6
