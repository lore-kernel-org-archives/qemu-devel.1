Received: from eggs.gnu.org ([2001:4830:134:3::10]:50696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkVh-0006pt-Mq
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkVf-00032h-2i
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkVe-00030P-Qb
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:39 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:21 +0100
Message-Id: <20180111213250.16511-23-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 22/51] qapi: add a dictionnary form with
 'name' key for enum members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Desugar the enum NAME form to { 'name': NAME }. This will allow to add
new enum members, such as 'if' in the following patch.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py                                    | 49 ++++++++++++++++=
++----
 tests/Makefile.include                             |  3 +-
 tests/qapi-schema/enum-bad-member.err              |  1 +
 ...{enum-dict-member.exit =3D> enum-bad-member.exit} |  0
 tests/qapi-schema/enum-bad-member.json             |  2 +
 .../{enum-dict-member.out =3D> enum-bad-member.out}  |  0
 tests/qapi-schema/enum-dict-member-unknown.err     |  1 +
 tests/qapi-schema/enum-dict-member-unknown.exit    |  1 +
 tests/qapi-schema/enum-dict-member-unknown.json    |  2 +
 tests/qapi-schema/enum-dict-member-unknown.out     |  0
 tests/qapi-schema/enum-dict-member.err             |  1 -
 tests/qapi-schema/enum-dict-member.json            |  2 -
 tests/qapi-schema/enum-missing-data.err            |  2 +-
 13 files changed, 51 insertions(+), 13 deletions(-)
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

diff --git a/scripts/qapi.py b/scripts/qapi.py
index a9dcfc064c..1338be4efe 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -731,6 +731,10 @@ def check_event(expr, info):
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
@@ -790,7 +794,7 @@ def check_union(expr, info):
         # If the discriminator names an enum type, then all members
         # of 'data' must also be members of the enum type.
         if enum_define:
-            if key not in enum_define['data']:
+            if key not in enum_get_names(enum_define):
                 raise QAPISemError(info,
                                    "Discriminator value '%s' is not foun=
d in "
                                    "enum '%s'"
@@ -798,7 +802,7 @@ def check_union(expr, info):
=20
     # If discriminator is user-defined, ensure all values are covered
     if enum_define:
-        for value in enum_define['data']:
+        for value in enum_get_names(enum_define):
             if value not in members.keys():
                 raise QAPISemError(info, "Union '%s' data missing '%s' b=
ranch"
                                    % (name, value))
@@ -829,10 +833,10 @@ def check_alternate(expr, info):
         if qtype =3D=3D 'QTYPE_QSTRING':
             enum_expr =3D enum_types.get(value)
             if enum_expr:
-                for v in enum_expr['data']:
+                for v in enum_get_names(enum_expr):
                     if v in ['on', 'off']:
                         conflicting.add('QTYPE_QBOOL')
-                    if re.match(r'[-+0-9.]', v): # lazy, could be tighte=
ned
+                    if re.match(r'[-+0-9.]', v):  # lazy, could be tight=
ened
                         conflicting.add('QTYPE_QNUM')
             else:
                 conflicting.add('QTYPE_QNUM')
@@ -845,19 +849,34 @@ def check_alternate(expr, info):
             types_seen[qt] =3D key
=20
=20
-def check_enum(expr, info):
+def normalize_enum(expr, info):
     name =3D expr['enum']
     members =3D expr.get('data')
-    prefix =3D expr.get('prefix')
=20
     if not isinstance(members, list):
         raise QAPISemError(info,
                            "Enum '%s' requires an array for 'data'" % na=
me)
+
+    # translate short member form to dict form
+    for i, member in enumerate(members):
+        if not isinstance(member, dict):
+            member =3D {'name': member}
+            members[i] =3D member
+
+
+def check_enum(expr, info):
+    name =3D expr['enum']
+    members =3D expr.get('data')
+    prefix =3D expr.get('prefix')
+
     if prefix is not None and not isinstance(prefix, str):
         raise QAPISemError(info,
                            "Enum '%s' requires a string for 'prefix'" % =
name)
+
     for member in members:
-        check_name(info, "Member of enum '%s'" % name, member,
+        source =3D "Dictionary member of enum '%s'" % name
+        check_known_keys(info, source, member, ['name'], [])
+        check_name(info, "Member of enum '%s'" % name, member['name'],
                    enum_member=3DTrue)
=20
=20
@@ -918,6 +937,13 @@ def check_exprs(exprs):
     for builtin in builtin_types.keys():
         all_names[builtin] =3D 'built-in'
=20
+    # Normalize exprs
+    for expr_elem in exprs:
+        expr =3D expr_elem['expr']
+        info =3D expr_elem['info']
+        if 'enum' in expr:
+            normalize_enum(expr, info)
+
     # Learn the types and check for valid expression keys
     for expr_elem in exprs:
         expr =3D expr_elem['expr']
@@ -1586,7 +1612,14 @@ class QAPISchema(object):
                                             qtype_values, 'QTYPE'))
=20
     def _make_enum_members(self, values):
-        return [QAPISchemaMember(v) for v in values]
+        enum =3D []
+        for v in values:
+            if isinstance(v, dict):
+                name =3D v['name']
+            else:
+                name =3D v
+            enum.append(QAPISchemaMember(name))
+        return enum
=20
     def _make_implicit_enum_type(self, name, info, ifcond, values):
         # See also QAPISchemaObjectTypeMember._pretty_owner()
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 501a5713b5..3634e8f67c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -450,10 +450,11 @@ qapi-schema +=3D double-data.json
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
index 0000000000..7ed48beb2e
--- /dev/null
+++ b/tests/qapi-schema/enum-dict-member-unknown.err
@@ -0,0 +1 @@
+tests/qapi-schema/enum-dict-member-unknown.json:2: Dictionary member of =
enum 'MyEnum' has unknown key 'bad-key' (allowed: 'name')
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
diff --git a/tests/qapi-schema/enum-missing-data.err b/tests/qapi-schema/=
enum-missing-data.err
index 68e286badc..b8ccae071b 100644
--- a/tests/qapi-schema/enum-missing-data.err
+++ b/tests/qapi-schema/enum-missing-data.err
@@ -1 +1 @@
-tests/qapi-schema/enum-missing-data.json:2: enum 'MyEnum' must have 'dat=
a' key
+tests/qapi-schema/enum-missing-data.json:2: Enum 'MyEnum' requires an ar=
ray for 'data'
--=20
2.16.0.rc1.1.gef27df75a1
