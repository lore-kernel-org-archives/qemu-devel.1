Received: from eggs.gnu.org ([2001:4830:134:3::10]:58425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbORO-0008LH-7F
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbORL-0007yD-BN
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39264 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fbORL-0007vt-4r
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A9C3A81A4EA9
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 10:58:14 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  6 Jul 2018 12:57:38 +0200
Message-Id: <20180706105753.26700-13-marcandre.lureau@redhat.com>
In-Reply-To: <20180706105753.26700-1-marcandre.lureau@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 12/27] qapi: add a dictionnary form with
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
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Desugar the enum NAME form to { 'name': NAME }. This will allow to add
new enum members, such as 'if' in the following patch.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py                        | 47 ++++++++++++++++---
 tests/Makefile.include                        |  3 +-
 tests/qapi-schema/enum-bad-member.err         |  1 +
 ...-dict-member.exit =3D> enum-bad-member.exit} |  0
 tests/qapi-schema/enum-bad-member.json        |  2 +
 ...um-dict-member.out =3D> enum-bad-member.out} |  0
 .../qapi-schema/enum-dict-member-unknown.err  |  2 +
 .../qapi-schema/enum-dict-member-unknown.exit |  1 +
 .../qapi-schema/enum-dict-member-unknown.json |  2 +
 .../qapi-schema/enum-dict-member-unknown.out  |  0
 tests/qapi-schema/enum-dict-member.err        |  1 -
 tests/qapi-schema/enum-dict-member.json       |  2 -
 tests/qapi-schema/enum-missing-data.err       |  2 +-
 13 files changed, 51 insertions(+), 12 deletions(-)
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
index cf8dab2866..e9fb736d46 100644
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
@@ -831,10 +835,10 @@ def check_alternate(expr, info):
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
@@ -847,19 +851,34 @@ def check_alternate(expr, info):
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
+        source =3D "dictionary member of enum '%s'" % name
+        check_known_keys(info, source, member, ['name'], [])
+        check_name(info, "Member of enum '%s'" % name, member['name'],
                    enum_member=3DTrue)
=20
=20
@@ -921,6 +940,13 @@ def check_exprs(exprs):
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
@@ -1640,7 +1666,14 @@ class QAPISchema(object):
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
index a49282704e..8e1b122cf2 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -482,10 +482,11 @@ qapi-schema +=3D double-data.json
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
diff --git a/tests/qapi-schema/enum-missing-data.err b/tests/qapi-schema/=
enum-missing-data.err
index ba4873ae69..b8ccae071b 100644
--- a/tests/qapi-schema/enum-missing-data.err
+++ b/tests/qapi-schema/enum-missing-data.err
@@ -1 +1 @@
-tests/qapi-schema/enum-missing-data.json:2: Key 'data' is missing from e=
num 'MyEnum'
+tests/qapi-schema/enum-missing-data.json:2: Enum 'MyEnum' requires an ar=
ray for 'data'
--=20
2.18.0.rc1
