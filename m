Received: from eggs.gnu.org ([2001:4830:134:3::10]:47024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXQFy-0000SZ-GC
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:38:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXQFo-0006Bu-Ut
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:38:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gXQFh-0005gv-Qt
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:38:08 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0D32B811D5
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 12:38:01 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 16:37:08 +0400
Message-Id: <20181213123724.4866-7-marcandre.lureau@redhat.com>
In-Reply-To: <20181213123724.4866-1-marcandre.lureau@redhat.com>
References: <20181213123724.4866-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 06/22] qapi: add a dictionary form with
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
Cc: armbru@redhat.com

Desugar the enum NAME form to { 'name': NAME }. This will allow to add
new enum members, such as 'if' in the following patch.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py                        | 38 +++++++++++++++----
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
 12 files changed, 40 insertions(+), 12 deletions(-)
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
index f205805751..bb928d2f7d 100644
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
@@ -847,19 +851,29 @@ def check_alternate(expr, info):
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
-    if not isinstance(members, list):
-        raise QAPISemError(info,
-                           "Enum '%s' requires an array for 'data'" % na=
me)
     if prefix is not None and not isinstance(prefix, str):
         raise QAPISemError(info,
                            "Enum '%s' requires a string for 'prefix'" % =
name)
+
+    if not isinstance(members, list):
+        raise QAPISemError(info,
+                           "Enum '%s' requires an array for 'data'" % na=
me)
+
     for member in members:
-        check_name(info, "Member of enum '%s'" % name, member,
+        source =3D "dictionary member of enum '%s'" % name
+        check_known_keys(info, source, member, ['name'], [])
+        check_name(info, "Member of enum '%s'" % name, member['name'],
                    enum_member=3DTrue)
=20
=20
@@ -937,6 +951,7 @@ def check_exprs(exprs):
         if 'enum' in expr:
             meta =3D 'enum'
             check_keys(expr_elem, 'enum', ['data'], ['if', 'prefix'])
+            normalize_enum(expr)
             enum_types[expr[meta]] =3D expr
         elif 'union' in expr:
             meta =3D 'union'
@@ -1640,7 +1655,14 @@ class QAPISchema(object):
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
2.20.0
