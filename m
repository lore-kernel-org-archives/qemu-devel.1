Received: from eggs.gnu.org ([2001:4830:134:3::10]:39911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebRW4-0007AS-MZ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:43:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebRW1-0000Ty-Fi
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:43:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ebRW1-0000SD-74
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:43:01 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 16 Jan 2018 13:42:04 +0000
Message-Id: <20180116134217.8725-2-berrange@redhat.com>
In-Reply-To: <20180116134217.8725-1-berrange@redhat.com>
References: <20180116134217.8725-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 01/14] qapi: convert to use python print
 function instead of statement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Python 3 no longer supports the bare "print" statement, it must be
called as a normal function with round brackets. It is possible to
opt-in to this new syntax with Python 2.6 onwards by importing the
"print_function" from the "__future__" module, making it easy to
support Python 2 and 3 in parallel.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 scripts/qapi.py                | 12 ++++++------
 scripts/qapi2texi.py           |  9 +++++----
 tests/qapi-schema/test-qapi.py | 41 +++++++++++++++++++++---------------=
-----
 3 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 43a54bf40f..64fde4b6c5 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -11,6 +11,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
=20
+from __future__ import print_function
 import errno
 import getopt
 import os
@@ -1467,7 +1468,7 @@ class QAPISchema(object):
             self._def_exprs()
             self.check()
         except QAPIError as err:
-            print >>sys.stderr, err
+            print(err, file=3Dsys.stderr)
             exit(1)
=20
     def _def_entity(self, ent):
@@ -1931,7 +1932,7 @@ def parse_command_line(extra_options=3D'', extra_lo=
ng_options=3D[]):
                                        ['source', 'header', 'prefix=3D',
                                         'output-dir=3D'] + extra_long_op=
tions)
     except getopt.GetoptError as err:
-        print >>sys.stderr, "%s: %s" % (sys.argv[0], str(err))
+        print("%s: %s" % (sys.argv[0], str(err)), file=3Dsys.stderr)
         sys.exit(1)
=20
     output_dir =3D ''
@@ -1945,9 +1946,8 @@ def parse_command_line(extra_options=3D'', extra_lo=
ng_options=3D[]):
         if o in ('-p', '--prefix'):
             match =3D re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', a)
             if match.end() !=3D len(a):
-                print >>sys.stderr, \
-                    "%s: 'funny character '%s' in argument of --prefix" =
\
-                    % (sys.argv[0], a[match.end()])
+                print("%s: 'funny character '%s' in argument of --prefix=
" \
+                      % (sys.argv[0], a[match.end()]), file=3Dsys.stderr=
)
                 sys.exit(1)
             prefix =3D a
         elif o in ('-o', '--output-dir'):
@@ -1964,7 +1964,7 @@ def parse_command_line(extra_options=3D'', extra_lo=
ng_options=3D[]):
         do_h =3D True
=20
     if len(args) !=3D 1:
-        print >>sys.stderr, "%s: need exactly one argument" % sys.argv[0=
]
+        print("%s: need exactly one argument" % sys.argv[0], file=3Dsys.=
stderr)
         sys.exit(1)
     fname =3D args[0]
=20
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 92e2af2cd6..70e1fe76ef 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -4,6 +4,7 @@
 # This work is licensed under the terms of the GNU LGPL, version 2+.
 # See the COPYING file in the top-level directory.
 """This script produces the documentation of a qapi schema in texinfo fo=
rmat"""
+from __future__ import print_function
 import re
 import sys
=20
@@ -274,15 +275,15 @@ def texi_schema(schema):
 def main(argv):
     """Takes schema argument, prints result to stdout"""
     if len(argv) !=3D 2:
-        print >>sys.stderr, "%s: need exactly 1 argument: SCHEMA" % argv=
[0]
+        print("%s: need exactly 1 argument: SCHEMA" % argv[0], file=3Dsy=
s.stderr)
         sys.exit(1)
=20
     schema =3D qapi.QAPISchema(argv[1])
     if not qapi.doc_required:
-        print >>sys.stderr, ("%s: need pragma 'doc-required' "
-                             "to generate documentation" % argv[0])
+        print("%s: need pragma 'doc-required' "
+               "to generate documentation" % argv[0], file=3Dsys.stderr)
         sys.exit(1)
-    print texi_schema(schema)
+    print(texi_schema(schema))
=20
=20
 if __name__ =3D=3D '__main__':
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index fe0ca08d78..a43fa873e1 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -10,6 +10,7 @@
 # See the COPYING file in the top-level directory.
 #
=20
+from __future__ import print_function
 from qapi import *
 from pprint import pprint
 import os
@@ -18,51 +19,51 @@ import sys
=20
 class QAPISchemaTestVisitor(QAPISchemaVisitor):
     def visit_enum_type(self, name, info, values, prefix):
-        print 'enum %s %s' % (name, values)
+        print('enum %s %s' % (name, values))
         if prefix:
-            print '    prefix %s' % prefix
+            print('    prefix %s' % prefix)
=20
     def visit_object_type(self, name, info, base, members, variants):
-        print 'object %s' % name
+        print('object %s' % name)
         if base:
-            print '    base %s' % base.name
+            print('    base %s' % base.name)
         for m in members:
-            print '    member %s: %s optional=3D%s' % \
-                (m.name, m.type.name, m.optional)
+            print('    member %s: %s optional=3D%s' % \
+                  (m.name, m.type.name, m.optional))
         self._print_variants(variants)
=20
     def visit_alternate_type(self, name, info, variants):
-        print 'alternate %s' % name
+        print('alternate %s' % name)
         self._print_variants(variants)
=20
     def visit_command(self, name, info, arg_type, ret_type,
                       gen, success_response, boxed):
-        print 'command %s %s -> %s' % \
-            (name, arg_type and arg_type.name, ret_type and ret_type.nam=
e)
-        print '   gen=3D%s success_response=3D%s boxed=3D%s' % \
-            (gen, success_response, boxed)
+        print('command %s %s -> %s' % \
+              (name, arg_type and arg_type.name, ret_type and ret_type.n=
ame))
+        print('   gen=3D%s success_response=3D%s boxed=3D%s' % \
+              (gen, success_response, boxed))
=20
     def visit_event(self, name, info, arg_type, boxed):
-        print 'event %s %s' % (name, arg_type and arg_type.name)
-        print '   boxed=3D%s' % boxed
+        print('event %s %s' % (name, arg_type and arg_type.name))
+        print('   boxed=3D%s' % boxed)
=20
     @staticmethod
     def _print_variants(variants):
         if variants:
-            print '    tag %s' % variants.tag_member.name
+            print('    tag %s' % variants.tag_member.name)
             for v in variants.variants:
-                print '    case %s: %s' % (v.name, v.type.name)
+                print('    case %s: %s' % (v.name, v.type.name))
=20
 schema =3D QAPISchema(sys.argv[1])
 schema.visit(QAPISchemaTestVisitor())
=20
 for doc in schema.docs:
     if doc.symbol:
-        print 'doc symbol=3D%s' % doc.symbol
+        print('doc symbol=3D%s' % doc.symbol)
     else:
-        print 'doc freeform'
-    print '    body=3D\n%s' % doc.body.text
+        print('doc freeform')
+    print('    body=3D\n%s' % doc.body.text)
     for arg, section in doc.args.iteritems():
-        print '    arg=3D%s\n%s' % (arg, section.text)
+        print('    arg=3D%s\n%s' % (arg, section.text))
     for section in doc.sections:
-        print '    section=3D%s\n%s' % (section.name, section.text)
+        print('    section=3D%s\n%s' % (section.name, section.text))
--=20
2.14.3
