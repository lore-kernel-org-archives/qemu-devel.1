Received: from eggs.gnu.org ([2001:4830:134:3::10]:51491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb1yV-00013u-Eg
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:26:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb1yT-0007Dj-Uk
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:26:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eb1yT-0007Bt-Mv
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:26:41 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 15 Jan 2018 10:26:09 +0000
Message-Id: <20180115102621.9183-2-berrange@redhat.com>
In-Reply-To: <20180115102621.9183-1-berrange@redhat.com>
References: <20180115102621.9183-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 01/13] qapi: convert to use python print
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Get Py2 + 3 compatibility by using the print function
instead of print statement. This works for 2.6 onwards.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 scripts/qapi.py                | 12 ++++++------
 scripts/qapi2texi.py           |  9 +++++----
 tests/qapi-schema/test-qapi.py | 41 +++++++++++++++++++++--------------------
 3 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 43a54bf40f..924c762381 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -11,6 +11,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
 
+from __future__ import print_function
 import errno
 import getopt
 import os
@@ -1467,7 +1468,7 @@ class QAPISchema(object):
             self._def_exprs()
             self.check()
         except QAPIError as err:
-            print >>sys.stderr, err
+            print (err, file=sys.stderr)
             exit(1)
 
     def _def_entity(self, ent):
@@ -1931,7 +1932,7 @@ def parse_command_line(extra_options='', extra_long_options=[]):
                                        ['source', 'header', 'prefix=',
                                         'output-dir='] + extra_long_options)
     except getopt.GetoptError as err:
-        print >>sys.stderr, "%s: %s" % (sys.argv[0], str(err))
+        print ("%s: %s" % (sys.argv[0], str(err)), file=sys.stderr)
         sys.exit(1)
 
     output_dir = ''
@@ -1945,9 +1946,8 @@ def parse_command_line(extra_options='', extra_long_options=[]):
         if o in ('-p', '--prefix'):
             match = re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', a)
             if match.end() != len(a):
-                print >>sys.stderr, \
-                    "%s: 'funny character '%s' in argument of --prefix" \
-                    % (sys.argv[0], a[match.end()])
+                print ("%s: 'funny character '%s' in argument of --prefix" \
+                       % (sys.argv[0], a[match.end()]), file=sys.stderr)
                 sys.exit(1)
             prefix = a
         elif o in ('-o', '--output-dir'):
@@ -1964,7 +1964,7 @@ def parse_command_line(extra_options='', extra_long_options=[]):
         do_h = True
 
     if len(args) != 1:
-        print >>sys.stderr, "%s: need exactly one argument" % sys.argv[0]
+        print ("%s: need exactly one argument" % sys.argv[0], file=sys.stderr)
         sys.exit(1)
     fname = args[0]
 
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 92e2af2cd6..6630138192 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -4,6 +4,7 @@
 # This work is licensed under the terms of the GNU LGPL, version 2+.
 # See the COPYING file in the top-level directory.
 """This script produces the documentation of a qapi schema in texinfo format"""
+from __future__ import print_function
 import re
 import sys
 
@@ -274,15 +275,15 @@ def texi_schema(schema):
 def main(argv):
     """Takes schema argument, prints result to stdout"""
     if len(argv) != 2:
-        print >>sys.stderr, "%s: need exactly 1 argument: SCHEMA" % argv[0]
+        print ("%s: need exactly 1 argument: SCHEMA" % argv[0], file=sys.stderr)
         sys.exit(1)
 
     schema = qapi.QAPISchema(argv[1])
     if not qapi.doc_required:
-        print >>sys.stderr, ("%s: need pragma 'doc-required' "
-                             "to generate documentation" % argv[0])
+        print ("%s: need pragma 'doc-required' "
+               "to generate documentation" % argv[0], file=sys.stderr)
         sys.exit(1)
-    print texi_schema(schema)
+    print (texi_schema(schema))
 
 
 if __name__ == '__main__':
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index fe0ca08d78..aad407e0df 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -10,6 +10,7 @@
 # See the COPYING file in the top-level directory.
 #
 
+from __future__ import print_function
 from qapi import *
 from pprint import pprint
 import os
@@ -18,51 +19,51 @@ import sys
 
 class QAPISchemaTestVisitor(QAPISchemaVisitor):
     def visit_enum_type(self, name, info, values, prefix):
-        print 'enum %s %s' % (name, values)
+        print ('enum %s %s' % (name, values))
         if prefix:
-            print '    prefix %s' % prefix
+            print ('    prefix %s' % prefix)
 
     def visit_object_type(self, name, info, base, members, variants):
-        print 'object %s' % name
+        print ('object %s' % name)
         if base:
-            print '    base %s' % base.name
+            print ('    base %s' % base.name)
         for m in members:
-            print '    member %s: %s optional=%s' % \
-                (m.name, m.type.name, m.optional)
+            print ('    member %s: %s optional=%s' % \
+                (m.name, m.type.name, m.optional))
         self._print_variants(variants)
 
     def visit_alternate_type(self, name, info, variants):
-        print 'alternate %s' % name
+        print ('alternate %s' % name)
         self._print_variants(variants)
 
     def visit_command(self, name, info, arg_type, ret_type,
                       gen, success_response, boxed):
-        print 'command %s %s -> %s' % \
-            (name, arg_type and arg_type.name, ret_type and ret_type.name)
-        print '   gen=%s success_response=%s boxed=%s' % \
-            (gen, success_response, boxed)
+        print ('command %s %s -> %s' % \
+            (name, arg_type and arg_type.name, ret_type and ret_type.name))
+        print ('   gen=%s success_response=%s boxed=%s' % \
+            (gen, success_response, boxed))
 
     def visit_event(self, name, info, arg_type, boxed):
-        print 'event %s %s' % (name, arg_type and arg_type.name)
-        print '   boxed=%s' % boxed
+        print ('event %s %s' % (name, arg_type and arg_type.name))
+        print ('   boxed=%s' % boxed)
 
     @staticmethod
     def _print_variants(variants):
         if variants:
-            print '    tag %s' % variants.tag_member.name
+            print ('    tag %s' % variants.tag_member.name)
             for v in variants.variants:
-                print '    case %s: %s' % (v.name, v.type.name)
+                print ('    case %s: %s' % (v.name, v.type.name))
 
 schema = QAPISchema(sys.argv[1])
 schema.visit(QAPISchemaTestVisitor())
 
 for doc in schema.docs:
     if doc.symbol:
-        print 'doc symbol=%s' % doc.symbol
+        print ('doc symbol=%s' % doc.symbol)
     else:
-        print 'doc freeform'
-    print '    body=\n%s' % doc.body.text
+        print ('doc freeform')
+    print ('    body=\n%s' % doc.body.text)
     for arg, section in doc.args.iteritems():
-        print '    arg=%s\n%s' % (arg, section.text)
+        print ('    arg=%s\n%s' % (arg, section.text))
     for section in doc.sections:
-        print '    section=%s\n%s' % (section.name, section.text)
+        print ('    section=%s\n%s' % (section.name, section.text))
-- 
2.14.3
