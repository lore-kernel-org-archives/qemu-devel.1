Received: from eggs.gnu.org ([2001:4830:134:3::10]:51209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkW4-0007Ew-R7
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkW2-0003mT-57
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkW1-0003kh-GE
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:02 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:25 +0100
Message-Id: <20180111213250.16511-27-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 26/51] qapi: add a dictionary form with
 'type' key for members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Wherever a struct/union/alternate/command/event member with NAME: TYPE
form is accepted, desugar it to a NAME: { 'type': TYPE } form.

This will allow to add new member details, such as 'if' in the
following patch to introduce conditionals, or 'default' for default
values etc.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py                                   | 57 +++++++++++++++--=
------
 tests/Makefile.include                            |  3 ++
 tests/qapi-schema/alternate-invalid-dict.err      |  1 +
 tests/qapi-schema/alternate-invalid-dict.exit     |  1 +
 tests/qapi-schema/alternate-invalid-dict.json     |  4 ++
 tests/qapi-schema/alternate-invalid-dict.out      |  0
 tests/qapi-schema/event-nest-struct.err           |  2 +-
 tests/qapi-schema/flat-union-inline.err           |  2 +-
 tests/qapi-schema/nested-struct-data.err          |  2 +-
 tests/qapi-schema/qapi-schema-test.json           | 10 ++--
 tests/qapi-schema/struct-member-invalid-dict.err  |  1 +
 tests/qapi-schema/struct-member-invalid-dict.exit |  1 +
 tests/qapi-schema/struct-member-invalid-dict.json |  3 ++
 tests/qapi-schema/struct-member-invalid-dict.out  |  0
 tests/qapi-schema/union-branch-invalid-dict.err   |  1 +
 tests/qapi-schema/union-branch-invalid-dict.exit  |  1 +
 tests/qapi-schema/union-branch-invalid-dict.json  |  4 ++
 tests/qapi-schema/union-branch-invalid-dict.out   |  0
 18 files changed, 66 insertions(+), 27 deletions(-)
 create mode 100644 tests/qapi-schema/alternate-invalid-dict.err
 create mode 100644 tests/qapi-schema/alternate-invalid-dict.exit
 create mode 100644 tests/qapi-schema/alternate-invalid-dict.json
 create mode 100644 tests/qapi-schema/alternate-invalid-dict.out
 create mode 100644 tests/qapi-schema/struct-member-invalid-dict.err
 create mode 100644 tests/qapi-schema/struct-member-invalid-dict.exit
 create mode 100644 tests/qapi-schema/struct-member-invalid-dict.json
 create mode 100644 tests/qapi-schema/struct-member-invalid-dict.out
 create mode 100644 tests/qapi-schema/union-branch-invalid-dict.err
 create mode 100644 tests/qapi-schema/union-branch-invalid-dict.exit
 create mode 100644 tests/qapi-schema/union-branch-invalid-dict.json
 create mode 100644 tests/qapi-schema/union-branch-invalid-dict.out

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 5b41114949..49fdf6bacf 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -579,11 +579,11 @@ def discriminator_find_enum_define(expr):
     if not base_members:
         return None
=20
-    discriminator_type =3D base_members.get(discriminator)
-    if not discriminator_type:
+    discriminator_member =3D base_members.get(discriminator)
+    if not discriminator_member:
         return None
=20
-    return enum_types.get(discriminator_type)
+    return enum_types.get(discriminator_member['type'])
=20
=20
 # Names must be letters, numbers, -, and _.  They must start with letter=
,
@@ -651,6 +651,15 @@ def check_if(expr, info):
         check_if_str(ifcond, info)
=20
=20
+def normalize_members(expr, field):
+    members =3D expr.get(field)
+    if isinstance(members, OrderedDict):
+        for key, arg in members.items():
+            if isinstance(arg, dict):
+                continue
+            members[key] =3D {'type': arg}
+
+
 def check_type(info, source, value, allow_array=3DFalse,
                allow_implicit=3DFalse, allow_optional=3DFalse,
                allow_metas=3D[]):
@@ -695,8 +704,9 @@ def check_type(info, source, value, allow_array=3DFal=
se,
                                % (source, key))
         # Todo: allow dictionaries to represent default values of
         # an optional argument.
-        check_type(info, "Member '%s' of %s" % (key, source), arg,
-                   allow_array=3DTrue,
+        member_source =3D "Member '%s' of %s" % (key, source)
+        check_known_keys(info, member_source, arg, ['type'], [])
+        check_type(info, member_source, arg['type'], allow_array=3DTrue,
                    allow_metas=3D['built-in', 'union', 'alternate', 'str=
uct',
                                 'enum'])
=20
@@ -767,13 +777,13 @@ def check_union(expr, info):
         # member of the base struct.
         check_name(info, "Discriminator of flat union '%s'" % name,
                    discriminator)
-        discriminator_type =3D base_members.get(discriminator)
-        if not discriminator_type:
+        discriminator_member =3D base_members.get(discriminator)
+        if not discriminator_member:
             raise QAPISemError(info,
                                "Discriminator '%s' is not a member of ba=
se "
                                "struct '%s'"
                                % (discriminator, base))
-        enum_define =3D enum_types.get(discriminator_type)
+        enum_define =3D enum_types.get(discriminator_member['type'])
         allow_metas =3D ['struct']
         # Do not allow string discriminator
         if not enum_define:
@@ -785,11 +795,14 @@ def check_union(expr, info):
     if len(members) =3D=3D 0:
         raise QAPISemError(info, "Union '%s' cannot have empty 'data'" %=
 name)
     for (key, value) in members.items():
-        check_name(info, "Member of union '%s'" % name, key)
+        source =3D "Member of union '%s'" % name
+        check_name(info, source, key)
+        check_known_keys(info, source, value, ['type'], [])
+        typ =3D value['type']
=20
         # Each value must name a known type
         check_type(info, "Member '%s' of union '%s'" % (key, name),
-                   value, allow_array=3Dnot base, allow_metas=3Dallow_me=
tas)
+                   typ, allow_array=3Dnot base, allow_metas=3Dallow_meta=
s)
=20
         # If the discriminator names an enum type, then all members
         # of 'data' must also be members of the enum type.
@@ -820,18 +833,20 @@ def check_alternate(expr, info):
                            "in 'data'" % name)
     for (key, value) in members.items():
         check_name(info, "Member of alternate '%s'" % name, key)
+        source =3D "Member '%s' of alternate '%s'" % (key, name)
+        check_known_keys(info, source, value, ['type'], [])
+        typ =3D value['type']
=20
         # Ensure alternates have no type conflicts.
-        check_type(info, "Member '%s' of alternate '%s'" % (key, name),
-                   value,
+        check_type(info, source, typ,
                    allow_metas=3D['built-in', 'union', 'struct', 'enum']=
)
-        qtype =3D find_alternate_member_qtype(value)
+        qtype =3D find_alternate_member_qtype(typ)
         if not qtype:
             raise QAPISemError(info, "Alternate '%s' member '%s' cannot =
use "
-                               "type '%s'" % (name, key, value))
+                               "type '%s'" % (name, key, typ))
         conflicting =3D set([qtype])
         if qtype =3D=3D 'QTYPE_QSTRING':
-            enum_expr =3D enum_types.get(value)
+            enum_expr =3D enum_types.get(typ)
             if enum_expr:
                 for v in enum_get_names(enum_expr):
                     if v in ['on', 'off']:
@@ -944,6 +959,10 @@ def check_exprs(exprs):
         info =3D expr_elem['info']
         if 'enum' in expr:
             normalize_enum(expr, info)
+        elif 'union' in expr:
+            normalize_members(expr, 'base')
+        if {'union', 'alternate', 'struct', 'command', 'event'} & set(ex=
pr):
+            normalize_members(expr, 'data')
=20
     # Learn the types and check for valid expression keys
     for expr_elem in exprs:
@@ -1681,7 +1700,7 @@ class QAPISchema(object):
         return QAPISchemaObjectTypeMember(name, typ, optional)
=20
     def _make_members(self, data, info):
-        return [self._make_member(key, value, info)
+        return [self._make_member(key, value['type'], info)
                 for (key, value) in data.iteritems()]
=20
     def _def_struct_type(self, expr, info, doc):
@@ -1717,11 +1736,11 @@ class QAPISchema(object):
                 name, info, doc, ifcond,
                 'base', self._make_members(base, info))
         if tag_name:
-            variants =3D [self._make_variant(key, value)
+            variants =3D [self._make_variant(key, value['type'])
                         for (key, value) in data.iteritems()]
             members =3D []
         else:
-            variants =3D [self._make_simple_variant(key, value, info)
+            variants =3D [self._make_simple_variant(key, value['type'], =
info)
                         for (key, value) in data.iteritems()]
             typ =3D self._make_implicit_enum_type(name, info, ifcond,
                                                 [v.name for v in variant=
s])
@@ -1737,7 +1756,7 @@ class QAPISchema(object):
         name =3D expr['alternate']
         data =3D expr['data']
         ifcond =3D expr.get('if')
-        variants =3D [self._make_variant(key, value)
+        variants =3D [self._make_variant(key, value['type'])
                     for (key, value) in data.iteritems()]
         tag_member =3D QAPISchemaObjectTypeMember('type', 'QType', False=
)
         self._def_entity(
diff --git a/tests/Makefile.include b/tests/Makefile.include
index aa5a572403..afd2971147 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -389,6 +389,7 @@ qapi-schema +=3D alternate-conflict-string.json
 qapi-schema +=3D alternate-conflict-bool-string.json
 qapi-schema +=3D alternate-conflict-num-string.json
 qapi-schema +=3D alternate-empty.json
+qapi-schema +=3D alternate-invalid-dict.json
 qapi-schema +=3D alternate-nested.json
 qapi-schema +=3D alternate-unknown.json
 qapi-schema +=3D args-alternate.json
@@ -530,6 +531,7 @@ qapi-schema +=3D returns-whitelist.json
 qapi-schema +=3D struct-base-clash-deep.json
 qapi-schema +=3D struct-base-clash.json
 qapi-schema +=3D struct-data-invalid.json
+qapi-schema +=3D struct-member-invalid-dict.json
 qapi-schema +=3D struct-member-invalid.json
 qapi-schema +=3D trailing-comma-list.json
 qapi-schema +=3D trailing-comma-object.json
@@ -541,6 +543,7 @@ qapi-schema +=3D unicode-str.json
 qapi-schema +=3D union-base-empty.json
 qapi-schema +=3D union-base-no-discriminator.json
 qapi-schema +=3D union-branch-case.json
+qapi-schema +=3D union-branch-invalid-dict.json
 qapi-schema +=3D union-clash-branches.json
 qapi-schema +=3D union-empty.json
 qapi-schema +=3D union-invalid-base.json
diff --git a/tests/qapi-schema/alternate-invalid-dict.err b/tests/qapi-sc=
hema/alternate-invalid-dict.err
new file mode 100644
index 0000000000..39d3b6bca5
--- /dev/null
+++ b/tests/qapi-schema/alternate-invalid-dict.err
@@ -0,0 +1 @@
+tests/qapi-schema/alternate-invalid-dict.json:2: Member 'two' of alterna=
te 'Alt' must have 'type' key
diff --git a/tests/qapi-schema/alternate-invalid-dict.exit b/tests/qapi-s=
chema/alternate-invalid-dict.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/alternate-invalid-dict.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/alternate-invalid-dict.json b/tests/qapi-s=
chema/alternate-invalid-dict.json
new file mode 100644
index 0000000000..45f2c8ebef
--- /dev/null
+++ b/tests/qapi-schema/alternate-invalid-dict.json
@@ -0,0 +1,4 @@
+# invalid field dictionnary, missing type
+{ 'alternate': 'Alt',
+  'data': { 'one': 'str',
+            'two': { 'if': 'foo' } } }
diff --git a/tests/qapi-schema/alternate-invalid-dict.out b/tests/qapi-sc=
hema/alternate-invalid-dict.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/event-nest-struct.err b/tests/qapi-schema/=
event-nest-struct.err
index 5a42701b8f..66cd141112 100644
--- a/tests/qapi-schema/event-nest-struct.err
+++ b/tests/qapi-schema/event-nest-struct.err
@@ -1 +1 @@
-tests/qapi-schema/event-nest-struct.json:1: Member 'a' of 'data' for eve=
nt 'EVENT_A' should be a type name
+tests/qapi-schema/event-nest-struct.json:1: Member 'a' of 'data' for eve=
nt 'EVENT_A' must have 'type' key
diff --git a/tests/qapi-schema/flat-union-inline.err b/tests/qapi-schema/=
flat-union-inline.err
index 2333358d28..82d511c7ef 100644
--- a/tests/qapi-schema/flat-union-inline.err
+++ b/tests/qapi-schema/flat-union-inline.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-inline.json:7: Member 'value1' of union 'Te=
stUnion' should be a type name
+tests/qapi-schema/flat-union-inline.json:7: Member of union 'TestUnion' =
must have 'type' key
diff --git a/tests/qapi-schema/nested-struct-data.err b/tests/qapi-schema=
/nested-struct-data.err
index da767bade2..728591fde3 100644
--- a/tests/qapi-schema/nested-struct-data.err
+++ b/tests/qapi-schema/nested-struct-data.err
@@ -1 +1 @@
-tests/qapi-schema/nested-struct-data.json:2: Member 'a' of 'data' for co=
mmand 'foo' should be a type name
+tests/qapi-schema/nested-struct-data.json:2: Member 'a' of 'data' for co=
mmand 'foo' must have 'type' key
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index 6a1d3b6337..71023fb277 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -11,7 +11,7 @@
         'guest-sync' ] } }
=20
 { 'struct': 'TestStruct',
-  'data': { 'integer': 'int', 'boolean': 'bool', 'string': 'str' } }
+  'data': { 'integer': {'type': 'int'}, 'boolean': 'bool', 'string': 'st=
r' } }
=20
 # for testing enums
 { 'struct': 'NestedEnumsOne',
@@ -74,7 +74,7 @@
 { 'union': 'UserDefFlatUnion',
   'base': 'UserDefUnionBase',   # intentional forward reference
   'discriminator': 'enum1',
-  'data': { 'value1' : 'UserDefA',
+  'data': { 'value1' : {'type': 'UserDefA'},
             'value2' : 'UserDefB',
             'value3' : 'UserDefB' } }
=20
@@ -93,7 +93,7 @@
 { 'struct': 'WrapAlternate',
   'data': { 'alt': 'UserDefAlternate' } }
 { 'alternate': 'UserDefAlternate',
-  'data': { 'udfu': 'UserDefFlatUnion', 'e': 'EnumOne', 'i': 'int',
+  'data': { 'udfu': {'type': 'UserDefFlatUnion'}, 'e': 'EnumOne', 'i': '=
int',
             'n': 'null' } }
=20
 { 'struct': 'UserDefC',
@@ -129,7 +129,7 @@
 { 'command': 'user_def_cmd', 'data': {} }
 { 'command': 'user_def_cmd1', 'data': {'ud1a': 'UserDefOne'} }
 { 'command': 'user_def_cmd2',
-  'data': {'ud1a': 'UserDefOne', '*ud1b': 'UserDefOne'},
+  'data': {'ud1a': {'type': 'UserDefOne'}, '*ud1b': 'UserDefOne'},
   'returns': 'UserDefTwo' }
=20
 # Returning a non-dictionary requires a name from the whitelist
@@ -156,7 +156,7 @@
=20
 # testing event
 { 'struct': 'EventStructOne',
-  'data': { 'struct1': 'UserDefOne', 'string': 'str', '*enum2': 'EnumOne=
' } }
+  'data': { 'struct1': {'type': 'UserDefOne'}, 'string': 'str', '*enum2'=
: 'EnumOne' } }
=20
 { 'event': 'EVENT_A' }
 { 'event': 'EVENT_B',
diff --git a/tests/qapi-schema/struct-member-invalid-dict.err b/tests/qap=
i-schema/struct-member-invalid-dict.err
new file mode 100644
index 0000000000..8435a78cb4
--- /dev/null
+++ b/tests/qapi-schema/struct-member-invalid-dict.err
@@ -0,0 +1 @@
+tests/qapi-schema/struct-member-invalid-dict.json:2: Member '*a' of 'dat=
a' for struct 'foo' must have 'type' key
diff --git a/tests/qapi-schema/struct-member-invalid-dict.exit b/tests/qa=
pi-schema/struct-member-invalid-dict.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/struct-member-invalid-dict.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/struct-member-invalid-dict.json b/tests/qa=
pi-schema/struct-member-invalid-dict.json
new file mode 100644
index 0000000000..ebd9733b49
--- /dev/null
+++ b/tests/qapi-schema/struct-member-invalid-dict.json
@@ -0,0 +1,3 @@
+# exploded member form must have a 'type'
+{ 'struct': 'foo',
+  'data': { '*a': { 'case': 'foo' } } }
diff --git a/tests/qapi-schema/struct-member-invalid-dict.out b/tests/qap=
i-schema/struct-member-invalid-dict.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/union-branch-invalid-dict.err b/tests/qapi=
-schema/union-branch-invalid-dict.err
new file mode 100644
index 0000000000..65f9999fc0
--- /dev/null
+++ b/tests/qapi-schema/union-branch-invalid-dict.err
@@ -0,0 +1 @@
+tests/qapi-schema/union-branch-invalid-dict.json:2: Member of union 'Uni=
onInvalidBranch' must have 'type' key
diff --git a/tests/qapi-schema/union-branch-invalid-dict.exit b/tests/qap=
i-schema/union-branch-invalid-dict.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/union-branch-invalid-dict.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/union-branch-invalid-dict.json b/tests/qap=
i-schema/union-branch-invalid-dict.json
new file mode 100644
index 0000000000..19c5d9cacd
--- /dev/null
+++ b/tests/qapi-schema/union-branch-invalid-dict.json
@@ -0,0 +1,4 @@
+# exploded member form must have a 'type'
+{ 'union': 'UnionInvalidBranch',
+  'data': { 'integer': { 'if': 'foo'},
+            's8': 'int8' } }
diff --git a/tests/qapi-schema/union-branch-invalid-dict.out b/tests/qapi=
-schema/union-branch-invalid-dict.out
new file mode 100644
index 0000000000..e69de29bb2
--=20
2.16.0.rc1.1.gef27df75a1
