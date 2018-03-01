Received: from eggs.gnu.org ([2001:4830:134:3::10]:40472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6n-0000oY-Ub
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6m-0007Uo-Q5
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erU6m-0007T8-HB
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:16 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu,  1 Mar 2018 13:42:24 -0600
Message-Id: <20180301194245.29854-10-eblake@redhat.com>
In-Reply-To: <20180301194245.29854-1-eblake@redhat.com>
References: <20180301194245.29854-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/30] qapi-gen: Convert from getopt to argparse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

From: Markus Armbruster <armbru@redhat.com>

argparse is nicer to use than getopt, and gives us --help almost for
free.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180211093607.27351-10-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
[eblake: Fix --output-dir editing accident]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi-gen.py    | 48 ++++++++++++++++++++++++++++++--------------=
----
 scripts/qapi/common.py | 43 -------------------------------------------
 2 files changed, 30 insertions(+), 61 deletions(-)

diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
index 2100ca11452..cb56ba7cff7 100755
--- a/scripts/qapi-gen.py
+++ b/scripts/qapi-gen.py
@@ -4,8 +4,11 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
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
-    (input_file, output_dir, prefix, opts) =3D \
-        parse_command_line('bu', ['builtins', 'unmask-non-abi-names'])
+    parser =3D argparse.ArgumentParser(
+        description=3D'Generate code from a QAPI schema')
+    parser.add_argument('-b', '--builtins', action=3D'store_true',
+                        help=3D"generate code for built-in types")
+    parser.add_argument('-o', '--output-dir', action=3D'store', default=3D=
'',
+                        help=3D"write output to directory OUTPUT_DIR")
+    parser.add_argument('-p', '--prefix', action=3D'store', default=3D''=
,
+                        help=3D"prefix for symbols")
+    parser.add_argument('-u', '--unmask-non-abi-names', action=3D'store_=
true',
+                        dest=3D'unmask',
+                        help=3D"expose non-ABI names in introspection")
+    parser.add_argument('schema', action=3D'store')
+    args =3D parser.parse_args()

-    opt_builtins =3D False
-    opt_unmask =3D False
+    match =3D re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', args.prefix)
+    if match.end() !=3D len(args.prefix):
+        print("%s: 'funny character '%s' in argument of --prefix"
+              % (sys.argv[0], args.prefix[match.end()]),
+              file=3Dsys.stderr)
+        sys.exit(1)

-    for o, a in opts:
-        if o in ('-b', '--builtins'):
-            opt_builtins =3D True
-        if o in ('-u', '--unmask-non-abi-names'):
-            opt_unmask =3D True
+    schema =3D QAPISchema(args.schema)

-    schema =3D QAPISchema(input_file)
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


 if __name__ =3D=3D '__main__':
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 3bc31a03ce1..c3ae590202a 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -13,7 +13,6 @@

 from __future__ import print_function
 import errno
-import getopt
 import os
 import re
 import string
@@ -1923,48 +1922,6 @@ def build_params(arg_type, boxed, extra):
     return ret


-#
-# Common command line parsing
-#
-
-
-def parse_command_line(extra_options=3D'', extra_long_options=3D[]):
-
-    try:
-        opts, args =3D getopt.gnu_getopt(sys.argv[1:],
-                                       'p:o:' + extra_options,
-                                       ['prefix=3D', 'output-dir=3D']
-                                       + extra_long_options)
-    except getopt.GetoptError as err:
-        print("%s: %s" % (sys.argv[0], str(err)), file=3Dsys.stderr)
-        sys.exit(1)
-
-    output_dir =3D ''
-    prefix =3D ''
-    extra_opts =3D []
-
-    for oa in opts:
-        o, a =3D oa
-        if o in ('-p', '--prefix'):
-            match =3D re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', a)
-            if match.end() !=3D len(a):
-                print("%s: 'funny character '%s' in argument of --prefix=
" \
-                      % (sys.argv[0], a[match.end()]), file=3Dsys.stderr=
)
-                sys.exit(1)
-            prefix =3D a
-        elif o in ('-o', '--output-dir'):
-            output_dir =3D a + '/'
-        else:
-            extra_opts.append(oa)
-
-    if len(args) !=3D 1:
-        print("%s: need exactly one argument" % sys.argv[0], file=3Dsys.=
stderr)
-        sys.exit(1)
-    fname =3D args[0]
-
-    return (fname, output_dir, prefix, extra_opts)
-
-
 #
 # Accumulate and write output
 #
--=20
2.14.3
