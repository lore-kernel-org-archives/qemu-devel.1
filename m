Received: from eggs.gnu.org ([2001:4830:134:3::10]:38815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2be-0007z5-Cz
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bb-0007xe-Qe
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2bb-0007wB-DB
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:03 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:40 +0200
Message-Id: <20171002152552.27999-21-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 20/32] qapi: Frontend for defining command
 line options
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

TODO explain why
TODO update qapi-code-gen.txt
TODO negative tests

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi.py                         | 91 +++++++++++++++++++++++++++++++++
 tests/qapi-schema/qapi-schema-test.json | 19 +++++++
 tests/qapi-schema/qapi-schema-test.out  | 34 ++++++++++++
 tests/qapi-schema/test-qapi.py          | 10 ++++
 4 files changed, 154 insertions(+)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 18c8175866..1e03b62943 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -606,6 +606,11 @@ def check_name(info, source, name, meta):
         if meta != 'member-struct':
             raise QAPISemError(info, "%s does not allow optional name '%s'"
                                % (source, name))
+    # Options start with '--'
+    if meta == 'option':
+        if not name.startswith('--'):
+            raise QAPISemError(info, "%s must start with '--'" % source)
+        membername = name[2:]
     # Enum members can start with a digit, because the generated C
     # code always prefixes it with the enum name
     if meta == 'member-enum' and membername[0].isdigit():
@@ -708,6 +713,17 @@ def check_event(expr, info):
                expr.get('data'), allow_dict=not boxed, allow_metas=meta)
 
 
+def check_option(expr, info):
+    name = expr['option']
+    boxed = expr.get('boxed', False)
+
+    meta = ['built-in', 'struct', 'enum']
+    if boxed:
+        meta += ['union', 'alternate']
+    check_type(info, "'data' for option '%s'" % name,
+               expr.get('data'), allow_dict=not boxed, allow_metas=meta)
+
+
 def check_union(expr, info):
     name = expr['union']
     base = expr.get('base')
@@ -912,6 +928,10 @@ def check_exprs(exprs):
         elif 'event' in expr:
             meta = 'event'
             check_keys(expr_elem, 'event', [], ['data', 'boxed'])
+        elif 'option' in expr:
+            meta = 'option'
+            check_keys(expr_elem, 'option', ['help'],
+                       ['data', 'short', 'implied-key', 'boxed'])
         else:
             raise QAPISemError(expr_elem['info'],
                                "Expression is missing metatype")
@@ -951,6 +971,8 @@ def check_exprs(exprs):
             check_command(expr, info)
         elif 'event' in expr:
             check_event(expr, info)
+        elif 'option' in expr:
+            check_option(expr, info)
         else:
             assert False, 'unexpected meta type'
 
@@ -1025,6 +1047,10 @@ class QAPISchemaVisitor(object):
     def visit_event(self, name, info, arg_type, boxed):
         pass
 
+    def visit_option(self, name, info, arg_type, short, implied_key,
+                     boxed, help_):
+        pass
+
 
 class QAPISchemaType(QAPISchemaEntity):
     # Return the C type for common use.
@@ -1458,6 +1484,56 @@ class QAPISchemaEvent(QAPISchemaEntity):
         visitor.visit_event(self.name, self.info, self.arg_type, self.boxed)
 
 
+class QAPISchemaOption(QAPISchemaEntity):
+    def __init__(self, name, info, doc, arg_type, short, implied_key,
+                 boxed, help_):
+        QAPISchemaEntity.__init__(self, name, info, doc)
+        assert not arg_type or isinstance(arg_type, str)
+        self._arg_type_name = arg_type
+        self.arg_type = None
+        self.short = short
+        self.implied_key = implied_key
+        self.boxed = boxed
+        self.help = help_
+
+    def check(self, schema):
+        if self._arg_type_name:
+            self.arg_type = schema.lookup_type(self._arg_type_name)
+            assert (isinstance(self.arg_type, QAPISchemaType)
+                    and not isinstance(self.arg_type, QAPISchemaArrayType))
+            self.arg_type.check(schema)
+            if self.boxed:
+                if self.arg_type.is_empty():
+                    raise QAPISemError(self.info,
+                                       "Cannot use 'boxed' with empty type")
+            else:
+                assert not isinstance(self.arg_type, QAPISchemaAlternateType)
+                assert (not isinstance(self.arg_type, QAPISchemaObjectType)
+                        or not self.arg_type.variants)
+        elif self.boxed:
+            raise QAPISemError(self.info, "Use of 'boxed' requires 'data'")
+        if self.short and not (isinstance(self.short, str)
+                               and len(self.short) == 1):
+            raise QAPISemError(self.info,
+                               "Value of 'short' must be a character")
+        if self.implied_key and not isinstance(self.implied_key, str):
+            raise QAPISemError(self.info,
+                               "Value of 'implied-key' must be a string")
+        if self.help is None:
+            self.help = []
+        if not isinstance(self.help, list):
+            self.help = [self.help]
+        if not all([isinstance(elt, str) for elt in self.help]):
+            raise QAPISemError(
+                self.info,
+                "Value of 'help' must be a string or a list of strings")
+
+    def visit(self, visitor, builtins):
+        visitor.visit_option(self.name, self.info, self.arg_type,
+                             self.short, self.implied_key,
+                             self.boxed, self.help)
+
+
 class QAPISchema(object):
     def __init__(self, file):
         try:
@@ -1663,6 +1739,19 @@ class QAPISchema(object):
                 name, info, doc, 'arg', self._make_members(data, info))
         self._def_entity(QAPISchemaEvent(name, info, doc, data, boxed))
 
+    def _def_option(self, expr, info, doc):
+        name = expr['option']
+        data = expr.get('data')
+        short = expr.get('short')
+        implied_key = expr.get('implied-key')
+        boxed = expr.get('boxed', False)
+        help_ = expr.get('help')
+        if isinstance(data, OrderedDict):
+            data = self._make_implicit_object_type(
+                name[2:], info, doc, 'optarg', self._make_members(data, info))
+        self._def_entity(QAPISchemaOption(name, info, doc, data,
+                                          short, implied_key, boxed, help_))
+
     def _def_exprs(self):
         for expr_elem in self.exprs:
             expr = expr_elem['expr']
@@ -1680,6 +1769,8 @@ class QAPISchema(object):
                 self._def_command(expr, info, doc)
             elif 'event' in expr:
                 self._def_event(expr, info, doc)
+            elif 'option' in expr:
+                self._def_option(expr, info, doc)
             else:
                 assert False
 
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index c74d5632a5..42b9968c72 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -193,3 +193,22 @@
   'data': { 'a': ['__org.qemu_x-Enum'], 'b': ['__org.qemu_x-Struct'],
             'c': '__org.qemu_x-Union2', 'd': '__org.qemu_x-Alt' },
   'returns': '__org.qemu_x-Union1' }
+
+# testing option
+{ 'option': '--help', 'short': 'h',
+  'help': "option without an argument" }
+{ 'option': '--opt-str', 'data': 'str',
+  'help': "option's argument is a string" }
+{ 'option': '--opt-int', 'data': 'int',
+  'help': "option's argument is an integer" }
+{ 'option': '--opt-enum', 'data': 'EnumOne',
+  'help': "option's argument is an enumeration" }
+{ 'option': '--opt-any', 'data': 'any',
+  'help': "--opt-any INT   option's argument is an integer" }
+{ 'option': '--opt-struct', 'data': { 's': 'str', '*i': 'int' },
+  'implied-key': 's',
+  'help': [
+      "an option with a complex argument",
+      "and multi-line help" ] }
+{ 'option': '--opt-boxed', 'data': 'UserDefZero', 'boxed': true,
+  'help': null }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index fff25e26d0..9ee06539ac 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -1,3 +1,34 @@
+option --help None
+    short=h
+    boxed=False
+    help=
+option without an argument
+option --opt-any any
+    boxed=False
+    help=
+--opt-any INT   option's argument is an integer
+option --opt-boxed UserDefZero
+    boxed=True
+    help=
+
+option --opt-enum EnumOne
+    boxed=False
+    help=
+option's argument is an enumeration
+option --opt-int int
+    boxed=False
+    help=
+option's argument is an integer
+option --opt-str str
+    boxed=False
+    help=
+option's argument is a string
+option --opt-struct q_obj_opt-struct-optarg
+    implied-key=s
+    boxed=False
+    help=
+an option with a complex argument
+and multi-line help
 alternate AltEnumBool
     tag type
     case e: EnumOne
@@ -210,6 +241,9 @@ object q_obj_intList-wrapper
     member data: intList optional=False
 object q_obj_numberList-wrapper
     member data: numberList optional=False
+object q_obj_opt-struct-optarg
+    member s: str optional=False
+    member i: int optional=True
 object q_obj_sizeList-wrapper
     member data: sizeList optional=False
 object q_obj_strList-wrapper
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index 0294a66619..2e5e7bfeb1 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -45,6 +45,16 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         print 'event %s %s' % (name, arg_type and arg_type.name)
         print '   boxed=%s' % boxed
 
+    def visit_option(self, name, info, arg_type, short, implied_key,
+                     boxed, help):
+        print 'option %s %s' % (name, arg_type and arg_type.name)
+        if short:
+            print '    short=%s' % short
+        if implied_key:
+            print '    implied-key=%s' % implied_key
+        print '    boxed=%s' % boxed
+        print '    help=\n%s' % '\n'.join(help)
+
     @staticmethod
     def _print_variants(variants):
         if variants:
-- 
2.13.6
