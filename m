Received: from eggs.gnu.org ([2001:4830:134:3::10]:48543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycIj-0005KV-L3
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycIi-0007zh-J1
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34922 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eycIi-0007zK-Dt
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E4E6D76FB9
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:53:03 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 12:51:41 +0100
Message-Id: <20180321115211.17937-20-marcandre.lureau@redhat.com>
In-Reply-To: <20180321115211.17937-1-marcandre.lureau@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 19/49] qapi: factor out check_known_keys()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The following patches are going to need similar checks from various
code path. This refactoring will report all conflicting keys (instead
of the first one encountered).

Modify unknown-expr-key to check plural form.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py                  | 27 ++++++++++++++++++-------
 tests/qapi-schema/alternate-base.err    |  2 +-
 tests/qapi-schema/double-type.err       |  2 +-
 tests/qapi-schema/enum-missing-data.err |  2 +-
 tests/qapi-schema/unknown-expr-key.err  |  2 +-
 tests/qapi-schema/unknown-expr-key.json |  2 +-
 6 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 4d19146064..fdbb5f1823 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -879,6 +879,24 @@ def check_struct(expr, info):
                allow_metas=3D['struct'])
=20
=20
+def check_known_keys(info, source, keys, required, optional):
+
+    def pprint(elems):
+        return ', '.join("'" + e + "'" for e in sorted(elems))
+
+    missing =3D set(required) - set(keys)
+    if missing:
+        raise QAPISemError(info, "%s must have %s key%s"
+                           % (source, pprint(missing),
+                              's' if len(missing) > 1 else ''))
+    allowed =3D set(required + optional)
+    unknown =3D set(keys) - allowed
+    if unknown:
+        raise QAPISemError(info, "%s has unknown key%s %s (allowed: %s)"
+                           % (source, 's' if len(unknown) > 1 else '',
+                              pprint(unknown), pprint(allowed)))
+
+
 def check_keys(expr_elem, meta, required, optional=3D[]):
     expr =3D expr_elem['expr']
     info =3D expr_elem['info']
@@ -886,10 +904,9 @@ def check_keys(expr_elem, meta, required, optional=3D=
[]):
     if not isinstance(name, str):
         raise QAPISemError(info, "'%s' key must have a string value" % m=
eta)
     required =3D required + [meta]
+    source =3D "%s '%s'" % (meta, name)
+    check_known_keys(info, source, expr, required, optional)
     for (key, value) in expr.items():
-        if key not in required and key not in optional:
-            raise QAPISemError(info, "Unknown key '%s' in %s '%s'"
-                               % (key, meta, name))
         if (key =3D=3D 'gen' or key =3D=3D 'success-response') and value=
 is not False:
             raise QAPISemError(info,
                                "'%s' of %s '%s' should only use false va=
lue"
@@ -900,10 +917,6 @@ def check_keys(expr_elem, meta, required, optional=3D=
[]):
                                % (key, meta, name))
         if key =3D=3D 'if':
             check_if(expr, info)
-    for key in required:
-        if key not in expr:
-            raise QAPISemError(info, "Key '%s' is missing from %s '%s'"
-                               % (key, meta, name))
=20
=20
 def check_exprs(exprs):
diff --git a/tests/qapi-schema/alternate-base.err b/tests/qapi-schema/alt=
ernate-base.err
index 30d8a34373..2b09c4c7a3 100644
--- a/tests/qapi-schema/alternate-base.err
+++ b/tests/qapi-schema/alternate-base.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-base.json:4: Unknown key 'base' in alternate=
 'Alt'
+tests/qapi-schema/alternate-base.json:4: alternate 'Alt' has unknown key=
 'base' (allowed: 'alternate', 'data', 'if')
diff --git a/tests/qapi-schema/double-type.err b/tests/qapi-schema/double=
-type.err
index f9613c6d6b..a8c5637659 100644
--- a/tests/qapi-schema/double-type.err
+++ b/tests/qapi-schema/double-type.err
@@ -1 +1 @@
-tests/qapi-schema/double-type.json:2: Unknown key 'command' in struct 'b=
ar'
+tests/qapi-schema/double-type.json:2: struct 'bar' has unknown key 'comm=
and' (allowed: 'base', 'data', 'if', 'struct')
diff --git a/tests/qapi-schema/enum-missing-data.err b/tests/qapi-schema/=
enum-missing-data.err
index ba4873ae69..68e286badc 100644
--- a/tests/qapi-schema/enum-missing-data.err
+++ b/tests/qapi-schema/enum-missing-data.err
@@ -1 +1 @@
-tests/qapi-schema/enum-missing-data.json:2: Key 'data' is missing from e=
num 'MyEnum'
+tests/qapi-schema/enum-missing-data.json:2: enum 'MyEnum' must have 'dat=
a' key
diff --git a/tests/qapi-schema/unknown-expr-key.err b/tests/qapi-schema/u=
nknown-expr-key.err
index 12f5ed5b43..d9f4e41cac 100644
--- a/tests/qapi-schema/unknown-expr-key.err
+++ b/tests/qapi-schema/unknown-expr-key.err
@@ -1 +1 @@
-tests/qapi-schema/unknown-expr-key.json:2: Unknown key 'bogus' in struct=
 'bar'
+tests/qapi-schema/unknown-expr-key.json:2: struct 'bar' has unknown keys=
 'bogus', 'foo' (allowed: 'base', 'data', 'if', 'struct')
diff --git a/tests/qapi-schema/unknown-expr-key.json b/tests/qapi-schema/=
unknown-expr-key.json
index 3b2be00cc4..5bcb8efd1d 100644
--- a/tests/qapi-schema/unknown-expr-key.json
+++ b/tests/qapi-schema/unknown-expr-key.json
@@ -1,2 +1,2 @@
 # we reject an expression with unknown top-level keys
-{ 'struct': 'bar', 'data': { 'string': 'str'}, 'bogus': { } }
+{ 'struct': 'bar', 'data': { 'string': 'str'}, 'bogus': { }, 'foo': { } =
}
--=20
2.16.2.521.g9aa15f885a
