Received: from eggs.gnu.org ([2001:4830:134:3::10]:38829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2be-0007zn-T4
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bb-0007xp-TZ
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2bb-0007wU-GY
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:03 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:41 +0200
Message-Id: <20171002152552.27999-22-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 21/32] qapi: Define QAPIOptionKind and
 QAPIOption automatically
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

Enumeration type QAPIOptionKind enumerates the command line options.

Flat union QAPIOption captures a single command line option.  Its tag
is QAPIOptionKind, and the variants are the option argument types.

FIXME implement missing clash checking in QAPISchemaObjectType.check_clash()
FIXME potential clash in QAPISchema._def_autos()
FIXME made up info in QAPISchema._def_autos()
TODO can we avoid the wrappers around non-object option argument types?

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi-commands.py               |  2 +-
 scripts/qapi-event.py                  |  2 +-
 scripts/qapi-introspect.py             |  2 +-
 scripts/qapi-types.py                  |  2 +-
 scripts/qapi-visit.py                  |  2 +-
 scripts/qapi.py                        | 42 ++++++++++++++++++++++++++++++++--
 scripts/qapi2texi.py                   |  2 +-
 tests/qapi-schema/qapi-schema-test.out | 14 ++++++++++++
 tests/qapi-schema/test-qapi.py         |  2 +-
 9 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index 76cc9cc8a4..fdd3492f87 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -315,7 +315,7 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
                   prefix=args.prefix,
                   c_prefix=c_name(args.prefix, protect=False)))
 
-schema = QAPISchema(args.schema)
+schema = QAPISchema(args.schema, args.prefix)
 gen = QAPISchemaGenCommandVisitor()
 schema.visit(gen)
 fdef.write(gen.defn)
diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
index 1c61751bc0..64a4a02757 100644
--- a/scripts/qapi-event.py
+++ b/scripts/qapi-event.py
@@ -226,7 +226,7 @@ fdecl.write(mcgen('''
 
 event_enum_name = c_name(args.prefix + 'QAPIEvent', protect=False)
 
-schema = QAPISchema(args.schema)
+schema = QAPISchema(args.schema, args.prefix)
 gen = QAPISchemaGenEventVisitor()
 schema.visit(gen)
 fdef.write(gen.defn)
diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index cc4ff01cd4..89365449b0 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -206,7 +206,7 @@ fdef.write(mcgen('''
 ''',
                  prefix=args.prefix))
 
-schema = QAPISchema(args.schema)
+schema = QAPISchema(args.schema, args.prefix)
 gen = QAPISchemaGenIntrospectVisitor(args.unmask_non_abi_names)
 schema.visit(gen, builtins=True)
 fdef.write(gen.defn)
diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index c058540e4d..5c53c56e45 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -276,7 +276,7 @@ else:
 #include "qapi/util.h"
 '''))
 
-schema = QAPISchema(args.schema)
+schema = QAPISchema(args.schema, args.prefix)
 gen = QAPISchemaGenTypeVisitor()
 schema.visit(gen, builtins=not args.schema)
 fdef.write(gen.defn)
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index e756ef98ee..3182b860af 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -359,7 +359,7 @@ else:
 
 '''))
 
-schema = QAPISchema(args.schema)
+schema = QAPISchema(args.schema, args.prefix)
 gen = QAPISchemaGenVisitVisitor()
 schema.visit(gen, builtins=not args.schema)
 fdef.write(gen.defn)
diff --git a/scripts/qapi.py b/scripts/qapi.py
index 1e03b62943..efc128eee0 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1235,7 +1235,12 @@ class QAPISchemaObjectType(QAPISchemaType):
     # and update seen to track the members seen so far. Report any errors
     # on behalf of info, which is not necessarily self.info
     def check_clash(self, info, seen):
-        assert not self.variants       # not implemented
+        # check_union() ensures the following assertion holds, but
+        # QAPIUnion violates it.  Disable it for now, so we can play
+        # with QAPIUnion without having to implement the missing clash
+        # checking first.
+        # FIXME implement missing clash checking
+        # assert not self.variants       # not implemented
         for m in self.members:
             m.check_clash(info, seen)
 
@@ -1535,8 +1540,9 @@ class QAPISchemaOption(QAPISchemaEntity):
 
 
 class QAPISchema(object):
-    def __init__(self, file):
+    def __init__(self, file, prefix):
         try:
+            self.prefix = prefix
             if file:
                 parser = QAPISchemaParser(file)
                 self.exprs = check_exprs(parser.exprs)
@@ -1545,10 +1551,14 @@ class QAPISchema(object):
                 self.exprs = []
                 self.docs = []
             self._entity_dict = {}
+            self._option_arg = {}
             self._predefining = True
             self._def_predefineds()
             self._predefining = False
             self._def_exprs()
+            self._predefining = True
+            self._def_autos()
+            self._predefining = False
             self.check()
         except QAPIError as err:
             print >>sys.stderr, err
@@ -1751,6 +1761,7 @@ class QAPISchema(object):
                 name[2:], info, doc, 'optarg', self._make_members(data, info))
         self._def_entity(QAPISchemaOption(name, info, doc, data,
                                           short, implied_key, boxed, help_))
+        self._option_arg[name[2:]] = data
 
     def _def_exprs(self):
         for expr_elem in self.exprs:
@@ -1774,6 +1785,33 @@ class QAPISchema(object):
             else:
                 assert False
 
+    def _def_autos(self):
+        info = {'file': None, 'line': 0, 'parent': None}  # FIXME
+        if self._option_arg:
+            name = self.prefix + 'QAPIOption'
+            self._make_implicit_enum_type(name, info,
+                                          sorted(self._option_arg.keys()))
+            # FIXME what if these members clash with variant members?
+            members = [
+                QAPISchemaObjectTypeMember('type', name + 'Kind', False),
+                QAPISchemaObjectTypeMember('idx', 'int32', False),
+                QAPISchemaObjectTypeMember('cnt', 'int32', False)]
+            variants = []
+            for (key, value) in sorted(self._option_arg.items()):
+                if not value:
+                    continue
+                typ = self.lookup_type(value)
+                if isinstance(typ, QAPISchemaObjectType):
+                    v = self._make_variant(key, value)
+                else:
+                    # TODO can we avoid the wrapper?
+                    v = self._make_simple_variant(key, value, typ.info)
+                variants.append(v)
+            self._def_entity(QAPISchemaObjectType(
+                name, info, None, None, members,
+                QAPISchemaObjectTypeVariants('type', None, variants)
+                if variants else None))
+
     def check(self):
         for ent in self._entity_dict.values():
             ent.check(self)
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 071abc9d5d..0e099ebaa2 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -286,7 +286,7 @@ def main(argv):
                         help='QAPI schema source file')
     args = parser.parse_args()
 
-    schema = qapi.QAPISchema(args.schema)
+    schema = qapi.QAPISchema(args.schema, '')
     if not qapi.doc_required:
         print >>sys.stderr, ("%s: need pragma 'doc-required' "
                              "to generate documentation" % argv[0])
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index 9ee06539ac..16dc30dd99 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -79,6 +79,18 @@ object NestedEnumsOne
     member enum2: EnumOne optional=True
     member enum3: EnumOne optional=False
     member enum4: EnumOne optional=True
+object QAPIOption
+    member type: QAPIOptionKind optional=False
+    member idx: int32 optional=False
+    member cnt: int32 optional=False
+    tag type
+    case opt-any: q_obj_any-wrapper
+    case opt-boxed: UserDefZero
+    case opt-enum: q_obj_EnumOne-wrapper
+    case opt-int: q_obj_int-wrapper
+    case opt-str: q_obj_str-wrapper
+    case opt-struct: q_obj_opt-struct-optarg
+enum QAPIOptionKind ['help', 'opt-any', 'opt-boxed', 'opt-enum', 'opt-int', 'opt-str', 'opt-struct']
 enum QEnumTwo ['value1', 'value2']
     prefix QENUM_TWO
 object TestStruct
@@ -207,6 +219,8 @@ object q_obj_EVENT_D-arg
     member b: str optional=False
     member c: str optional=True
     member enum3: EnumOne optional=True
+object q_obj_EnumOne-wrapper
+    member data: EnumOne optional=False
 object q_obj_UserDefA-wrapper
     member data: UserDefA optional=False
 object q_obj_UserDefB-wrapper
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index 2e5e7bfeb1..7de7d6dc53 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -67,7 +67,7 @@ parser.add_argument('schema', type=argparse.FileType('r'), nargs='?',
                     help='QAPI schema source file')
 args = parser.parse_args()
 
-schema = QAPISchema(args.schema)
+schema = QAPISchema(args.schema, '')
 schema.visit(QAPISchemaTestVisitor(), builtins=not args.schema)
 
 for doc in schema.docs:
-- 
2.13.6
