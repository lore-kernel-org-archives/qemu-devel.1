Received: from eggs.gnu.org ([2001:4830:134:3::10]:34776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb8A2-0000CA-CD
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:03:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb8A0-0006OO-Ll
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:03:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eb8A0-0006Np-Dn
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:03:00 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 15 Jan 2018 17:02:31 +0000
Message-Id: <20180115170243.24578-2-berrange@redhat.com>
In-Reply-To: <20180115170243.24578-1-berrange@redhat.com>
References: <20180115170243.24578-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 01/13] qapi: use items()/values() intead of
 iteritems()/itervalues()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The iteritems()/itervalues() methods are gone in py3, but the
items()/values() methods are still around. The latter are less
efficient than the former in py2, but this has unmeasurably
small impact on QEMU build time, so taking portability over
efficiency is a net win.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 scripts/qapi.py                | 24 +++++++++++------------
 scripts/qapi2texi.py           | 11 ++++++-----
 tests/qapi-schema/test-qapi.py | 43 +++++++++++++++++++++---------------=
------
 3 files changed, 40 insertions(+), 38 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 43a54bf40f..98d7123d27 100644
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
@@ -244,7 +245,7 @@ class QAPIDoc(object):
                                "'Returns:' is only valid for commands")
=20
     def check(self):
-        bogus =3D [name for name, section in self.args.iteritems()
+        bogus =3D [name for name, section in self.args.items()
                  if not section.member]
         if bogus:
             raise QAPISemError(
@@ -299,7 +300,7 @@ class QAPISchemaParser(object):
                 if not isinstance(pragma, dict):
                     raise QAPISemError(
                         info, "Value of 'pragma' must be a dictionary")
-                for name, value in pragma.iteritems():
+                for name, value in pragma.items():
                     self._pragma(name, value, info)
             else:
                 expr_elem =3D {'expr': expr,
@@ -1467,7 +1468,7 @@ class QAPISchema(object):
             self._def_exprs()
             self.check()
         except QAPIError as err:
-            print >>sys.stderr, err
+            print(err, file=3Dsys.stderr)
             exit(1)
=20
     def _def_entity(self, ent):
@@ -1565,7 +1566,7 @@ class QAPISchema(object):
=20
     def _make_members(self, data, info):
         return [self._make_member(key, value, info)
-                for (key, value) in data.iteritems()]
+                for (key, value) in data.items()]
=20
     def _def_struct_type(self, expr, info, doc):
         name =3D expr['struct']
@@ -1597,11 +1598,11 @@ class QAPISchema(object):
                 name, info, doc, 'base', self._make_members(base, info))=
)
         if tag_name:
             variants =3D [self._make_variant(key, value)
-                        for (key, value) in data.iteritems()]
+                        for (key, value) in data.items()]
             members =3D []
         else:
             variants =3D [self._make_simple_variant(key, value, info)
-                        for (key, value) in data.iteritems()]
+                        for (key, value) in data.items()]
             typ =3D self._make_implicit_enum_type(name, info,
                                                 [v.name for v in variant=
s])
             tag_member =3D QAPISchemaObjectTypeMember('type', typ, False=
)
@@ -1616,7 +1617,7 @@ class QAPISchema(object):
         name =3D expr['alternate']
         data =3D expr['data']
         variants =3D [self._make_variant(key, value)
-                    for (key, value) in data.iteritems()]
+                    for (key, value) in data.items()]
         tag_member =3D QAPISchemaObjectTypeMember('type', 'QType', False=
)
         self._def_entity(
             QAPISchemaAlternateType(name, info, doc,
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
index 92e2af2cd6..bf1c57b2e2 100755
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
@@ -145,7 +146,7 @@ def texi_member(member, suffix=3D''):
 def texi_members(doc, what, base, variants, member_func):
     """Format the table of members"""
     items =3D ''
-    for section in doc.args.itervalues():
+    for section in doc.args.values():
         # TODO Drop fallbacks when undocumented members are outlawed
         if section.text:
             desc =3D texi_format(section.text)
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
index fe0ca08d78..ac43d3458e 100644
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
-    for arg, section in doc.args.iteritems():
-        print '    arg=3D%s\n%s' % (arg, section.text)
+        print('doc freeform')
+    print('    body=3D\n%s' % doc.body.text)
+    for arg, section in doc.args.items():
+        print('    arg=3D%s\n%s' % (arg, section.text))
     for section in doc.sections:
-        print '    section=3D%s\n%s' % (section.name, section.text)
+        print('    section=3D%s\n%s' % (section.name, section.text))
--=20
2.14.3
