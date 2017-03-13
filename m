Received: from eggs.gnu.org ([2001:4830:134:3::10]:52365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJp-0007Zs-W6
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJk-0003aD-Rb
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnJJk-0003Ym-JU
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:52 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 13 Mar 2017 07:18:14 +0100
Message-Id: <1489385927-6735-15-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-1-git-send-email-armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 14/47] qapi: Prepare for requiring more
 complete documentation
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

We currently neglect to check all enumeration values, common members
of object types and members of alternate types are documented.
Unsurprisingly, many aren't.

Add the necessary plumbing to find undocumented ones, except for
variant members of object types.  Don't enforce anything just yet, but
connect each QAPIDoc.ArgSection to its QAPISchemaMember.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi.py | 110 +++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 65 insertions(+), 45 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 7a2b6ab..4886417 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -116,7 +116,12 @@ class QAPIDoc(object):
             return "\n".join(self.content).strip()
 
     class ArgSection(Section):
-        pass
+        def __init__(self, name):
+            QAPIDoc.Section.__init__(self, name)
+            self.member = None
+
+        def connect(self, member):
+            self.member = member
 
     def __init__(self, parser, info):
         # self.parser is used to report errors with QAPIParseError.  The
@@ -216,6 +221,13 @@ class QAPIDoc(object):
             line = line.strip()
         self.section.append(line)
 
+    def connect_member(self, member):
+        if not member.name in self.args:
+            # Undocumented TODO outlaw
+            pass
+        else:
+            self.args[member.name].connect(member)
+
 
 class QAPISchemaParser(object):
 
@@ -1017,7 +1029,7 @@ def check_docs(docs):
 #
 
 class QAPISchemaEntity(object):
-    def __init__(self, name, info):
+    def __init__(self, name, info, doc):
         assert isinstance(name, str)
         self.name = name
         # For explicitly defined entities, info points to the (explicit)
@@ -1026,6 +1038,7 @@ class QAPISchemaEntity(object):
         # triggered the implicit definition (there may be more than one
         # such place).
         self.info = info
+        self.doc = doc
 
     def c_name(self):
         return c_name(self.name)
@@ -1107,7 +1120,7 @@ class QAPISchemaType(QAPISchemaEntity):
 
 class QAPISchemaBuiltinType(QAPISchemaType):
     def __init__(self, name, json_type, c_type):
-        QAPISchemaType.__init__(self, name, None)
+        QAPISchemaType.__init__(self, name, None, None)
         assert not c_type or isinstance(c_type, str)
         assert json_type in ('string', 'number', 'int', 'boolean', 'null',
                              'value')
@@ -1133,8 +1146,8 @@ class QAPISchemaBuiltinType(QAPISchemaType):
 
 
 class QAPISchemaEnumType(QAPISchemaType):
-    def __init__(self, name, info, values, prefix):
-        QAPISchemaType.__init__(self, name, info)
+    def __init__(self, name, info, doc, values, prefix):
+        QAPISchemaType.__init__(self, name, info, doc)
         for v in values:
             assert isinstance(v, QAPISchemaMember)
             v.set_owner(name)
@@ -1146,6 +1159,8 @@ class QAPISchemaEnumType(QAPISchemaType):
         seen = {}
         for v in self.values:
             v.check_clash(self.info, seen)
+            if self.doc:
+                self.doc.connect_member(v)
 
     def is_implicit(self):
         # See QAPISchema._make_implicit_enum_type() and ._def_predefineds()
@@ -1167,7 +1182,7 @@ class QAPISchemaEnumType(QAPISchemaType):
 
 class QAPISchemaArrayType(QAPISchemaType):
     def __init__(self, name, info, element_type):
-        QAPISchemaType.__init__(self, name, info)
+        QAPISchemaType.__init__(self, name, info, None)
         assert isinstance(element_type, str)
         self._element_type_name = element_type
         self.element_type = None
@@ -1190,11 +1205,11 @@ class QAPISchemaArrayType(QAPISchemaType):
 
 
 class QAPISchemaObjectType(QAPISchemaType):
-    def __init__(self, name, info, base, local_members, variants):
+    def __init__(self, name, info, doc, base, local_members, variants):
         # struct has local_members, optional base, and no variants
         # flat union has base, variants, and no local_members
         # simple union has local_members, variants, and no base
-        QAPISchemaType.__init__(self, name, info)
+        QAPISchemaType.__init__(self, name, info, doc)
         assert base is None or isinstance(base, str)
         for m in local_members:
             assert isinstance(m, QAPISchemaObjectTypeMember)
@@ -1224,6 +1239,8 @@ class QAPISchemaObjectType(QAPISchemaType):
         for m in self.local_members:
             m.check(schema)
             m.check_clash(self.info, seen)
+            if self.doc:
+                self.doc.connect_member(m)
         self.members = seen.values()
         if self.variants:
             self.variants.check(schema, seen)
@@ -1378,8 +1395,8 @@ class QAPISchemaObjectTypeVariant(QAPISchemaObjectTypeMember):
 
 
 class QAPISchemaAlternateType(QAPISchemaType):
-    def __init__(self, name, info, variants):
-        QAPISchemaType.__init__(self, name, info)
+    def __init__(self, name, info, doc, variants):
+        QAPISchemaType.__init__(self, name, info, doc)
         assert isinstance(variants, QAPISchemaObjectTypeVariants)
         assert variants.tag_member
         variants.set_owner(name)
@@ -1396,6 +1413,8 @@ class QAPISchemaAlternateType(QAPISchemaType):
         seen = {}
         for v in self.variants.variants:
             v.check_clash(self.info, seen)
+            if self.doc:
+                self.doc.connect_member(v)
 
     def c_type(self):
         return c_name(self.name) + pointer_suffix
@@ -1411,9 +1430,9 @@ class QAPISchemaAlternateType(QAPISchemaType):
 
 
 class QAPISchemaCommand(QAPISchemaEntity):
-    def __init__(self, name, info, arg_type, ret_type, gen, success_response,
-                 boxed):
-        QAPISchemaEntity.__init__(self, name, info)
+    def __init__(self, name, info, doc, arg_type, ret_type,
+                 gen, success_response, boxed):
+        QAPISchemaEntity.__init__(self, name, info, doc)
         assert not arg_type or isinstance(arg_type, str)
         assert not ret_type or isinstance(ret_type, str)
         self._arg_type_name = arg_type
@@ -1450,8 +1469,8 @@ class QAPISchemaCommand(QAPISchemaEntity):
 
 
 class QAPISchemaEvent(QAPISchemaEntity):
-    def __init__(self, name, info, arg_type, boxed):
-        QAPISchemaEntity.__init__(self, name, info)
+    def __init__(self, name, info, doc, arg_type, boxed):
+        QAPISchemaEntity.__init__(self, name, info, doc)
         assert not arg_type or isinstance(arg_type, str)
         self._arg_type_name = arg_type
         self.arg_type = None
@@ -1533,14 +1552,14 @@ class QAPISchema(object):
                   ('bool',   'boolean', 'bool'),
                   ('any',    'value',   'QObject' + pointer_suffix)]:
             self._def_builtin_type(*t)
-        self.the_empty_object_type = QAPISchemaObjectType('q_empty', None,
-                                                          None, [], None)
+        self.the_empty_object_type = QAPISchemaObjectType(
+            'q_empty', None, None, None, [], None)
         self._def_entity(self.the_empty_object_type)
         qtype_values = self._make_enum_members(['none', 'qnull', 'qint',
                                                 'qstring', 'qdict', 'qlist',
                                                 'qfloat', 'qbool'])
-        self._def_entity(QAPISchemaEnumType('QType', None, qtype_values,
-                                            'QTYPE'))
+        self._def_entity(QAPISchemaEnumType('QType', None, None,
+                                            qtype_values, 'QTYPE'))
 
     def _make_enum_members(self, values):
         return [QAPISchemaMember(v) for v in values]
@@ -1549,7 +1568,7 @@ class QAPISchema(object):
         # See also QAPISchemaObjectTypeMember._pretty_owner()
         name = name + 'Kind'   # Use namespace reserved by add_name()
         self._def_entity(QAPISchemaEnumType(
-            name, info, self._make_enum_members(values), None))
+            name, info, None, self._make_enum_members(values), None))
         return name
 
     def _make_array_type(self, element_type, info):
@@ -1558,22 +1577,22 @@ class QAPISchema(object):
             self._def_entity(QAPISchemaArrayType(name, info, element_type))
         return name
 
-    def _make_implicit_object_type(self, name, info, role, members):
+    def _make_implicit_object_type(self, name, info, doc, role, members):
         if not members:
             return None
         # See also QAPISchemaObjectTypeMember._pretty_owner()
         name = 'q_obj_%s-%s' % (name, role)
         if not self.lookup_entity(name, QAPISchemaObjectType):
-            self._def_entity(QAPISchemaObjectType(name, info, None,
+            self._def_entity(QAPISchemaObjectType(name, info, doc, None,
                                                   members, None))
         return name
 
-    def _def_enum_type(self, expr, info):
+    def _def_enum_type(self, expr, info, doc):
         name = expr['enum']
         data = expr['data']
         prefix = expr.get('prefix')
         self._def_entity(QAPISchemaEnumType(
-            name, info, self._make_enum_members(data), prefix))
+            name, info, doc, self._make_enum_members(data), prefix))
 
     def _make_member(self, name, typ, info):
         optional = False
@@ -1589,11 +1608,11 @@ class QAPISchema(object):
         return [self._make_member(key, value, info)
                 for (key, value) in data.iteritems()]
 
-    def _def_struct_type(self, expr, info):
+    def _def_struct_type(self, expr, info, doc):
         name = expr['struct']
         base = expr.get('base')
         data = expr['data']
-        self._def_entity(QAPISchemaObjectType(name, info, base,
+        self._def_entity(QAPISchemaObjectType(name, info, doc, base,
                                               self._make_members(data, info),
                                               None))
 
@@ -1605,10 +1624,10 @@ class QAPISchema(object):
             assert len(typ) == 1
             typ = self._make_array_type(typ[0], info)
         typ = self._make_implicit_object_type(
-            typ, info, 'wrapper', [self._make_member('data', typ, info)])
+            typ, info, None, 'wrapper', [self._make_member('data', typ, info)])
         return QAPISchemaObjectTypeVariant(case, typ)
 
-    def _def_union_type(self, expr, info):
+    def _def_union_type(self, expr, info, doc):
         name = expr['union']
         data = expr['data']
         base = expr.get('base')
@@ -1616,7 +1635,7 @@ class QAPISchema(object):
         tag_member = None
         if isinstance(base, dict):
             base = (self._make_implicit_object_type(
-                    name, info, 'base', self._make_members(base, info)))
+                    name, info, doc, 'base', self._make_members(base, info)))
         if tag_name:
             variants = [self._make_variant(key, value)
                         for (key, value) in data.iteritems()]
@@ -1629,24 +1648,24 @@ class QAPISchema(object):
             tag_member = QAPISchemaObjectTypeMember('type', typ, False)
             members = [tag_member]
         self._def_entity(
-            QAPISchemaObjectType(name, info, base, members,
+            QAPISchemaObjectType(name, info, doc, base, members,
                                  QAPISchemaObjectTypeVariants(tag_name,
                                                               tag_member,
                                                               variants)))
 
-    def _def_alternate_type(self, expr, info):
+    def _def_alternate_type(self, expr, info, doc):
         name = expr['alternate']
         data = expr['data']
         variants = [self._make_variant(key, value)
                     for (key, value) in data.iteritems()]
         tag_member = QAPISchemaObjectTypeMember('type', 'QType', False)
         self._def_entity(
-            QAPISchemaAlternateType(name, info,
+            QAPISchemaAlternateType(name, info, doc,
                                     QAPISchemaObjectTypeVariants(None,
                                                                  tag_member,
                                                                  variants)))
 
-    def _def_command(self, expr, info):
+    def _def_command(self, expr, info, doc):
         name = expr['command']
         data = expr.get('data')
         rets = expr.get('returns')
@@ -1655,38 +1674,39 @@ class QAPISchema(object):
         boxed = expr.get('boxed', False)
         if isinstance(data, OrderedDict):
             data = self._make_implicit_object_type(
-                name, info, 'arg', self._make_members(data, info))
+                name, info, doc, 'arg', self._make_members(data, info))
         if isinstance(rets, list):
             assert len(rets) == 1
             rets = self._make_array_type(rets[0], info)
-        self._def_entity(QAPISchemaCommand(name, info, data, rets, gen,
-                                           success_response, boxed))
+        self._def_entity(QAPISchemaCommand(name, info, doc, data, rets,
+                                           gen, success_response, boxed))
 
-    def _def_event(self, expr, info):
+    def _def_event(self, expr, info, doc):
         name = expr['event']
         data = expr.get('data')
         boxed = expr.get('boxed', False)
         if isinstance(data, OrderedDict):
             data = self._make_implicit_object_type(
-                name, info, 'arg', self._make_members(data, info))
-        self._def_entity(QAPISchemaEvent(name, info, data, boxed))
+                name, info, doc, 'arg', self._make_members(data, info))
+        self._def_entity(QAPISchemaEvent(name, info, doc, data, boxed))
 
     def _def_exprs(self):
         for expr_elem in self.exprs:
             expr = expr_elem['expr']
             info = expr_elem['info']
+            doc = expr_elem.get('doc')
             if 'enum' in expr:
-                self._def_enum_type(expr, info)
+                self._def_enum_type(expr, info, doc)
             elif 'struct' in expr:
-                self._def_struct_type(expr, info)
+                self._def_struct_type(expr, info, doc)
             elif 'union' in expr:
-                self._def_union_type(expr, info)
+                self._def_union_type(expr, info, doc)
             elif 'alternate' in expr:
-                self._def_alternate_type(expr, info)
+                self._def_alternate_type(expr, info, doc)
             elif 'command' in expr:
-                self._def_command(expr, info)
+                self._def_command(expr, info, doc)
             elif 'event' in expr:
-                self._def_event(expr, info)
+                self._def_event(expr, info, doc)
             else:
                 assert False
 
-- 
2.7.4
