Received: from eggs.gnu.org ([2001:4830:134:3::10]:53395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVy7-00062K-1n
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVxx-00036K-96
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXVxr-0001eH-OU
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:05 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6A1D33082139
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 18:43:49 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 13 Dec 2018 19:43:28 +0100
Message-Id: <20181213184340.24037-21-armbru@redhat.com>
In-Reply-To: <20181213184340.24037-1-armbru@redhat.com>
References: <20181213184340.24037-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/32] qapi: add a dictionary form with 'name'
 key for enum members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Desugar the enum NAME form to { 'name': NAME }. This will allow to add
new enum members, such as 'if' in the following patch.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20181213123724.4866-7-marcandre.lureau@redhat.com>
Message-Id: <20181213123724.4866-8-marcandre.lureau@redhat.com>
Message-Id: <20181213123724.4866-9-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Harmless accidental move backed out, long line wrapped, patches
squashed]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py                        | 36 +++++++++++++------
 tests/Makefile.include                        |  3 +-
 tests/qapi-schema/enum-bad-member.err         |  1 +
 ...-dict-member.exit =3D> enum-bad-member.exit} |  0
 tests/qapi-schema/enum-bad-member.json        |  2 ++
 ...um-dict-member.out =3D> enum-bad-member.out} |  0
 .../qapi-schema/enum-dict-member-unknown.err  |  2 ++
 .../qapi-schema/enum-dict-member-unknown.exit |  1 +
 .../qapi-schema/enum-dict-member-unknown.json |  2 ++
 .../qapi-schema/enum-dict-member-unknown.out  |  0
 tests/qapi-schema/enum-dict-member.err        |  1 -
 tests/qapi-schema/enum-dict-member.json       |  2 --
 12 files changed, 36 insertions(+), 14 deletions(-)
 create mode 100644 tests/qapi-schema/enum-bad-member.err
 rename tests/qapi-schema/{enum-dict-member.exit =3D> enum-bad-member.exi=
t} (100%)
 create mode 100644 tests/qapi-schema/enum-bad-member.json
 rename tests/qapi-schema/{enum-dict-member.out =3D> enum-bad-member.out}=
 (100%)
 create mode 100644 tests/qapi-schema/enum-dict-member-unknown.err
 create mode 100644 tests/qapi-schema/enum-dict-member-unknown.exit
 create mode 100644 tests/qapi-schema/enum-dict-member-unknown.json
 create mode 100644 tests/qapi-schema/enum-dict-member-unknown.out
 delete mode 100644 tests/qapi-schema/enum-dict-member.err
 delete mode 100644 tests/qapi-schema/enum-dict-member.json

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index f205805751..b1cf33af21 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -740,6 +740,10 @@ def check_event(expr, info):
                allow_metas=3Dmeta)
=20
=20
+def enum_get_names(expr):
+    return [e['name'] for e in expr['data']]
+
+
 def check_union(expr, info):
     name =3D expr['union']
     base =3D expr.get('base')
@@ -799,7 +803,7 @@ def check_union(expr, info):
         # If the discriminator names an enum type, then all members
         # of 'data' must also be members of the enum type.
         if enum_define:
-            if key not in enum_define['data']:
+            if key not in enum_get_names(enum_define):
                 raise QAPISemError(info,
                                    "Discriminator value '%s' is not foun=
d in "
                                    "enum '%s'"
@@ -831,7 +835,7 @@ def check_alternate(expr, info):
         if qtype =3D=3D 'QTYPE_QSTRING':
             enum_expr =3D enum_types.get(value)
             if enum_expr:
-                for v in enum_expr['data']:
+                for v in enum_get_names(enum_expr):
                     if v in ['on', 'off']:
                         conflicting.add('QTYPE_QBOOL')
                     if re.match(r'[-+0-9.]', v): # lazy, could be tighte=
ned
@@ -847,9 +851,15 @@ def check_alternate(expr, info):
             types_seen[qt] =3D key
=20
=20
+def normalize_enum(expr):
+    if isinstance(expr['data'], list):
+        expr['data'] =3D [m if isinstance(m, dict) else {'name': m}
+                        for m in expr['data']]
+
+
 def check_enum(expr, info):
     name =3D expr['enum']
-    members =3D expr.get('data')
+    members =3D expr['data']
     prefix =3D expr.get('prefix')
=20
     if not isinstance(members, list):
@@ -858,8 +868,11 @@ def check_enum(expr, info):
     if prefix is not None and not isinstance(prefix, str):
         raise QAPISemError(info,
                            "Enum '%s' requires a string for 'prefix'" % =
name)
+
     for member in members:
-        check_name(info, "Member of enum '%s'" % name, member,
+        source =3D "dictionary member of enum '%s'" % name
+        check_known_keys(info, source, member, ['name'], [])
+        check_name(info, "Member of enum '%s'" % name, member['name'],
                    enum_member=3DTrue)
=20
=20
@@ -937,6 +950,7 @@ def check_exprs(exprs):
         if 'enum' in expr:
             meta =3D 'enum'
             check_keys(expr_elem, 'enum', ['data'], ['if', 'prefix'])
+            normalize_enum(expr)
             enum_types[expr[meta]] =3D expr
         elif 'union' in expr:
             meta =3D 'union'
@@ -1633,14 +1647,16 @@ class QAPISchema(object):
         self.the_empty_object_type =3D QAPISchemaObjectType(
             'q_empty', None, None, None, None, [], None)
         self._def_entity(self.the_empty_object_type)
-        qtype_values =3D self._make_enum_members(['none', 'qnull', 'qnum=
',
-                                                'qstring', 'qdict', 'qli=
st',
-                                                'qbool'])
+
+        qtypes =3D ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist'=
,
+                  'qbool']
+        qtype_values =3D self._make_enum_members([{'name': n} for n in q=
types])
+
         self._def_entity(QAPISchemaEnumType('QType', None, None, None,
                                             qtype_values, 'QTYPE'))
=20
     def _make_enum_members(self, values):
-        return [QAPISchemaMember(v) for v in values]
+        return [QAPISchemaMember(v['name']) for v in values]
=20
     def _make_implicit_enum_type(self, name, info, ifcond, values):
         # See also QAPISchemaObjectTypeMember._pretty_owner()
@@ -1740,8 +1756,8 @@ class QAPISchema(object):
         else:
             variants =3D [self._make_simple_variant(key, value, info)
                         for (key, value) in data.items()]
-            typ =3D self._make_implicit_enum_type(name, info, ifcond,
-                                                [v.name for v in variant=
s])
+            enum =3D [{'name': v.name} for v in variants]
+            typ =3D self._make_implicit_enum_type(name, info, ifcond, en=
um)
             tag_member =3D QAPISchemaObjectTypeMember('type', typ, False=
)
             members =3D [tag_member]
         self._def_entity(
diff --git a/tests/Makefile.include b/tests/Makefile.include
index fb0b449c02..2e894c1037 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -379,10 +379,11 @@ qapi-schema +=3D double-data.json
 qapi-schema +=3D double-type.json
 qapi-schema +=3D duplicate-key.json
 qapi-schema +=3D empty.json
+qapi-schema +=3D enum-bad-member.json
 qapi-schema +=3D enum-bad-name.json
 qapi-schema +=3D enum-bad-prefix.json
 qapi-schema +=3D enum-clash-member.json
-qapi-schema +=3D enum-dict-member.json
+qapi-schema +=3D enum-dict-member-unknown.json
 qapi-schema +=3D enum-int-member.json
 qapi-schema +=3D enum-member-case.json
 qapi-schema +=3D enum-missing-data.json
diff --git a/tests/qapi-schema/enum-bad-member.err b/tests/qapi-schema/en=
um-bad-member.err
new file mode 100644
index 0000000000..211db9e6fc
--- /dev/null
+++ b/tests/qapi-schema/enum-bad-member.err
@@ -0,0 +1 @@
+tests/qapi-schema/enum-bad-member.json:2: Member of enum 'MyEnum' requir=
es a string name
diff --git a/tests/qapi-schema/enum-dict-member.exit b/tests/qapi-schema/=
enum-bad-member.exit
similarity index 100%
rename from tests/qapi-schema/enum-dict-member.exit
rename to tests/qapi-schema/enum-bad-member.exit
diff --git a/tests/qapi-schema/enum-bad-member.json b/tests/qapi-schema/e=
num-bad-member.json
new file mode 100644
index 0000000000..98da6828b4
--- /dev/null
+++ b/tests/qapi-schema/enum-bad-member.json
@@ -0,0 +1,2 @@
+# we reject any enum member that is not a string
+{ 'enum': 'MyEnum', 'data': [ [ ] ] }
diff --git a/tests/qapi-schema/enum-dict-member.out b/tests/qapi-schema/e=
num-bad-member.out
similarity index 100%
rename from tests/qapi-schema/enum-dict-member.out
rename to tests/qapi-schema/enum-bad-member.out
diff --git a/tests/qapi-schema/enum-dict-member-unknown.err b/tests/qapi-=
schema/enum-dict-member-unknown.err
new file mode 100644
index 0000000000..76bd0471db
--- /dev/null
+++ b/tests/qapi-schema/enum-dict-member-unknown.err
@@ -0,0 +1,2 @@
+tests/qapi-schema/enum-dict-member-unknown.json:2: Unknown key 'bad-key'=
 in dictionary member of enum 'MyEnum'
+Valid keys are 'name'.
diff --git a/tests/qapi-schema/enum-dict-member-unknown.exit b/tests/qapi=
-schema/enum-dict-member-unknown.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/enum-dict-member-unknown.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/enum-dict-member-unknown.json b/tests/qapi=
-schema/enum-dict-member-unknown.json
new file mode 100644
index 0000000000..6664c59201
--- /dev/null
+++ b/tests/qapi-schema/enum-dict-member-unknown.json
@@ -0,0 +1,2 @@
+# we reject any enum member that is not a string or a dict with 'name'
+{ 'enum': 'MyEnum', 'data': [ { 'name': 'foo', 'bad-key': 'str' } ] }
diff --git a/tests/qapi-schema/enum-dict-member-unknown.out b/tests/qapi-=
schema/enum-dict-member-unknown.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/enum-dict-member.err b/tests/qapi-schema/e=
num-dict-member.err
deleted file mode 100644
index 8ca146ea59..0000000000
--- a/tests/qapi-schema/enum-dict-member.err
+++ /dev/null
@@ -1 +0,0 @@
-tests/qapi-schema/enum-dict-member.json:2: Member of enum 'MyEnum' requi=
res a string name
diff --git a/tests/qapi-schema/enum-dict-member.json b/tests/qapi-schema/=
enum-dict-member.json
deleted file mode 100644
index 79672e0f09..0000000000
--- a/tests/qapi-schema/enum-dict-member.json
+++ /dev/null
@@ -1,2 +0,0 @@
-# we reject any enum member that is not a string
-{ 'enum': 'MyEnum', 'data': [ { 'value': 'str' } ] }
--=20
2.17.2
