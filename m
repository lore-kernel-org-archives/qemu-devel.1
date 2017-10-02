Received: from eggs.gnu.org ([2001:4830:134:3::10]:38763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bd-0007yL-5j
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bb-0007xU-PL
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2bb-0007wN-Fx
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:03 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:44 +0200
Message-Id: <20171002152552.27999-25-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 24/32] qapi-options: Generate help string
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi-options.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/qapi-options.py b/scripts/qapi-options.py
index 240c9021c7..820d70f71f 100644
--- a/scripts/qapi-options.py
+++ b/scripts/qapi-options.py
@@ -13,12 +13,15 @@ from qapi import *
 
 
 class QAPISchemaGenOptionVisitor(QAPISchemaVisitor):
+    # TODO keep help in source order
+    # TODO generate the part of help that shows syntax
     def __init__(self):
         self.decl = None
         self.defn = None
         self._shortopts = None
         self._longopts = None
         self._cases = None
+        self._help = None
 
     def visit_begin(self, schema):
         self.decl = ''
@@ -26,15 +29,22 @@ class QAPISchemaGenOptionVisitor(QAPISchemaVisitor):
         self._shortopts = ''
         self._longopts = ''
         self._cases = ''
+        self._help = []
 
     def visit_end(self):
         if self._cases:
             c_max = c_enum_const(args.prefix + 'QAPIOptionKind', '_MAX')
+            c_help = '\n    '.join([c_string(h) for h in self._help])
             self.decl += mcgen('''
+extern const char %(c_prefix)sqapi_options_help[];
+
 %(c_prefix)sQAPIOption *%(c_prefix)sqapi_options_parse(int argc, char *argv[]);
 ''',
                                c_prefix=c_name(args.prefix, protect=False))
             self.defn += mcgen('''
+const char %(c_prefix)sqapi_options_help[] =
+    %(c_help)s;
+
 %(c_prefix)sQAPIOption *%(c_prefix)sqapi_options_parse(int argc, char *argv[])
 {
     static const struct option longopts[] = {
@@ -72,6 +82,7 @@ class QAPISchemaGenOptionVisitor(QAPISchemaVisitor):
 }
 ''',
                                c_prefix=c_name(args.prefix, protect=False),
+                               c_help=c_help,
                                c_shortopts=c_string(self._shortopts),
                                longopts=self._longopts,
                                cases=self._cases,
@@ -79,6 +90,7 @@ class QAPISchemaGenOptionVisitor(QAPISchemaVisitor):
         self._shortopts = None
         self._longopts = None
         self._cases = None
+        self._help = None
 
     def visit_option(self, name, info, arg_type, short, implied_key,
                      boxed, help_):
@@ -140,6 +152,7 @@ case 256 + %(case)s:
 ''')
 
         pop_indent(8)
+        self._help += help_
 
 
 args = common_argument_parser().parse_args()
-- 
2.13.6
