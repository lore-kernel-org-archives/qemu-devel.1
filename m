Received: from eggs.gnu.org ([2001:4830:134:3::10]:54090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3e-00072Y-I3
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3Y-0006N1-HR
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:26 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41710 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eko3Y-0006HU-3q
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:20 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun, 11 Feb 2018 10:35:47 +0100
Message-Id: <20180211093607.27351-10-armbru@redhat.com>
In-Reply-To: <20180211093607.27351-1-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/29] qapi-gen: Convert from getopt to
 argparse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com

argparse is nicer to use than getopt, and gives us --help almost for
free.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi-gen.py    | 48 ++++++++++++++++++++++++++++++------------------
 scripts/qapi/common.py | 43 -------------------------------------------
 2 files changed, 30 insertions(+), 61 deletions(-)

diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
index 2100ca1145..e5be484e3e 100755
--- a/scripts/qapi-gen.py
+++ b/scripts/qapi-gen.py
@@ -4,8 +4,11 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or later.
 # See the COPYING file in the top-level directory.
 
+from __future__ import print_function
+import argparse
+import re
 import sys
-from qapi.common import parse_command_line, QAPISchema
+from qapi.common import QAPISchema
 from qapi.types import gen_types
 from qapi.visit import gen_visit
 from qapi.commands import gen_commands
@@ -15,26 +18,35 @@ from qapi.doc import gen_doc
 
 
 def main(argv):
-    (input_file, output_dir, prefix, opts) = \
-        parse_command_line('bu', ['builtins', 'unmask-non-abi-names'])
+    parser = argparse.ArgumentParser(
+        description='Generate code from a QAPI schema')
+    parser.add_argument('-b', '--builtins', action='store_true',
+                        help="generate code for built-in types")
+    parser.add_argument('-o', '--output_dir', action='store', default='',
+                        help="write output to directory OUTPUT_DIR")
+    parser.add_argument('-p', '--prefix', action='store', default='',
+                        help="prefix for symbols")
+    parser.add_argument('-u', '--unmask-non-abi-names', action='store_true',
+                        dest='unmask',
+                        help="expose non-ABI names in introspection")
+    parser.add_argument('schema', action='store')
+    args = parser.parse_args()
 
-    opt_builtins = False
-    opt_unmask = False
+    match = re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', args.prefix)
+    if match.end() != len(args.prefix):
+        print("%s: 'funny character '%s' in argument of --prefix"
+              % (sys.argv[0], args.prefix[match.end()]),
+              file=sys.stderr)
+        sys.exit(1)
 
-    for o, a in opts:
-        if o in ('-b', '--builtins'):
-            opt_builtins = True
-        if o in ('-u', '--unmask-non-abi-names'):
-            opt_unmask = True
+    schema = QAPISchema(args.schema)
 
-    schema = QAPISchema(input_file)
-
-    gen_types(schema, output_dir, prefix, opt_builtins)
-    gen_visit(schema, output_dir, prefix, opt_builtins)
-    gen_commands(schema, output_dir, prefix)
-    gen_events(schema, output_dir, prefix)
-    gen_introspect(schema, output_dir, prefix, opt_unmask)
-    gen_doc(schema, output_dir, prefix)
+    gen_types(schema, args.output_dir, args.prefix, args.builtins)
+    gen_visit(schema, args.output_dir, args.prefix, args.builtins)
+    gen_commands(schema, args.output_dir, args.prefix)
+    gen_events(schema, args.output_dir, args.prefix)
+    gen_introspect(schema, args.output_dir, args.prefix, args.unmask)
+    gen_doc(schema, args.output_dir, args.prefix)
 
 
 if __name__ == '__main__':
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 868ec25deb..8290795dc1 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -13,7 +13,6 @@
 
 from __future__ import print_function
 import errno
-import getopt
 import os
 import re
 import string
@@ -1924,48 +1923,6 @@ def build_params(arg_type, boxed, extra):
 
 
 #
-# Common command line parsing
-#
-
-
-def parse_command_line(extra_options='', extra_long_options=[]):
-
-    try:
-        opts, args = getopt.gnu_getopt(sys.argv[1:],
-                                       'p:o:' + extra_options,
-                                       ['prefix=', 'output-dir=']
-                                       + extra_long_options)
-    except getopt.GetoptError as err:
-        print("%s: %s" % (sys.argv[0], str(err)), file=sys.stderr)
-        sys.exit(1)
-
-    output_dir = ''
-    prefix = ''
-    extra_opts = []
-
-    for oa in opts:
-        o, a = oa
-        if o in ('-p', '--prefix'):
-            match = re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', a)
-            if match.end() != len(a):
-                print("%s: 'funny character '%s' in argument of --prefix" \
-                      % (sys.argv[0], a[match.end()]), file=sys.stderr)
-                sys.exit(1)
-            prefix = a
-        elif o in ('-o', '--output-dir'):
-            output_dir = a + '/'
-        else:
-            extra_opts.append(oa)
-
-    if len(args) != 1:
-        print("%s: need exactly one argument" % sys.argv[0], file=sys.stderr)
-        sys.exit(1)
-    fname = args[0]
-
-    return (fname, output_dir, prefix, extra_opts)
-
-
-#
 # Accumulate and write output
 #
 
-- 
2.13.6
