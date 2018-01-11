Received: from eggs.gnu.org ([2001:4830:134:3::10]:50834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkVm-0006vr-Vp
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkVh-00037x-Tz
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkVh-00036W-Ku
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:41 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:20 +0100
Message-Id: <20180111213250.16511-22-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 21/51] qapi: factor out check_known_keys()
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

The following patches are going to need similar checks from various
code path. This refactoring will report all conflicting keys (instead
of the first one encountered).

Modify unknown-expr-key to check plural form.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py                         | 27 ++++++++++++++++++++-------
 tests/qapi-schema/alternate-base.err    |  2 +-
 tests/qapi-schema/double-type.err       |  2 +-
 tests/qapi-schema/enum-missing-data.err |  2 +-
 tests/qapi-schema/unknown-expr-key.err  |  2 +-
 tests/qapi-schema/unknown-expr-key.json |  2 +-
 6 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index f8c711b81b..a9dcfc064c 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -871,6 +871,24 @@ def check_struct(expr, info):
                allow_metas=3D['struct'])
=20
=20
+def check_known_keys(info, source, keys, required, optional):
+
+    def pprint(elems):
+        return ', '.join("'" + e + "'" for e in elems)
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
@@ -878,10 +896,9 @@ def check_keys(expr_elem, meta, required, optional=3D=
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
@@ -892,10 +909,6 @@ def check_keys(expr_elem, meta, required, optional=3D=
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
index f9613c6d6b..968fac6b66 100644
--- a/tests/qapi-schema/double-type.err
+++ b/tests/qapi-schema/double-type.err
@@ -1 +1 @@
-tests/qapi-schema/double-type.json:2: Unknown key 'command' in struct 'b=
ar'
+tests/qapi-schema/double-type.json:2: struct 'bar' has unknown key 'comm=
and' (allowed: 'base', 'data', 'struct', 'if')
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
index 12f5ed5b43..6a28af8ffc 100644
--- a/tests/qapi-schema/unknown-expr-key.err
+++ b/tests/qapi-schema/unknown-expr-key.err
@@ -1 +1 @@
-tests/qapi-schema/unknown-expr-key.json:2: Unknown key 'bogus' in struct=
 'bar'
+tests/qapi-schema/unknown-expr-key.json:2: struct 'bar' has unknown keys=
 'foo', 'bogus' (allowed: 'base', 'data', 'struct', 'if')
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
2.16.0.rc1.1.gef27df75a1
