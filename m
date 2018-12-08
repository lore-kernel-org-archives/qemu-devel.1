Received: from eggs.gnu.org ([2001:4830:134:3::10]:59755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVabv-0004Th-JL
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:17:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVabu-0003yO-Gw
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:17:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gVabp-0003uu-LJ
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:17:23 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat,  8 Dec 2018 15:15:46 +0400
Message-Id: <20181208111606.8505-8-marcandre.lureau@redhat.com>
In-Reply-To: <20181208111606.8505-1-marcandre.lureau@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0 v7 07/27] qapi: improve reporting of
 unknown or missing keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Report the set of missing or unknown keys. And give a hint about the
accepted keys.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py                  | 23 +++++++++++++++--------
 tests/qapi-schema/alternate-base.err    |  1 +
 tests/qapi-schema/double-type.err       |  1 +
 tests/qapi-schema/unknown-expr-key.err  |  3 ++-
 tests/qapi-schema/unknown-expr-key.json |  2 +-
 5 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 18f5872808..f205805751 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -874,14 +874,21 @@ def check_struct(expr, info):
=20
=20
 def check_known_keys(info, source, keys, required, optional):
-    for key in keys:
-        if key not in required and key not in optional:
-            raise QAPISemError(info, "Unknown key '%s' in %s" % (key, so=
urce))
-
-    for key in required:
-        if key not in keys:
-            raise QAPISemError(info, "Key '%s' is missing from %s"
-                               % (key, source))
+
+    def pprint(elems):
+        return ', '.join("'" + e + "'" for e in sorted(elems))
+
+    missing =3D set(required) - set(keys)
+    if missing:
+        raise QAPISemError(info, "Key%s %s %s missing from %s"
+                           % ('s' if len(missing) > 1 else '', pprint(mi=
ssing),
+                              'are' if len(missing) > 1 else 'is', sourc=
e))
+    allowed =3D set(required + optional)
+    unknown =3D set(keys) - allowed
+    if unknown:
+        raise QAPISemError(info, "Unknown key%s %s in %s\nValid keys are=
 %s."
+                           % ('s' if len(unknown) > 1 else '', pprint(un=
known),
+                              source, pprint(allowed)))
=20
=20
 def check_keys(expr_elem, meta, required, optional=3D[]):
diff --git a/tests/qapi-schema/alternate-base.err b/tests/qapi-schema/alt=
ernate-base.err
index 30d8a34373..ebe05bc898 100644
--- a/tests/qapi-schema/alternate-base.err
+++ b/tests/qapi-schema/alternate-base.err
@@ -1 +1,2 @@
 tests/qapi-schema/alternate-base.json:4: Unknown key 'base' in alternate=
 'Alt'
+Valid keys are 'alternate', 'data', 'if'.
diff --git a/tests/qapi-schema/double-type.err b/tests/qapi-schema/double=
-type.err
index f9613c6d6b..799193dba1 100644
--- a/tests/qapi-schema/double-type.err
+++ b/tests/qapi-schema/double-type.err
@@ -1 +1,2 @@
 tests/qapi-schema/double-type.json:2: Unknown key 'command' in struct 'b=
ar'
+Valid keys are 'base', 'data', 'if', 'struct'.
diff --git a/tests/qapi-schema/unknown-expr-key.err b/tests/qapi-schema/u=
nknown-expr-key.err
index 12f5ed5b43..6ff8bb99c5 100644
--- a/tests/qapi-schema/unknown-expr-key.err
+++ b/tests/qapi-schema/unknown-expr-key.err
@@ -1 +1,2 @@
-tests/qapi-schema/unknown-expr-key.json:2: Unknown key 'bogus' in struct=
 'bar'
+tests/qapi-schema/unknown-expr-key.json:2: Unknown keys 'bogus', 'phony'=
 in struct 'bar'
+Valid keys are 'base', 'data', 'if', 'struct'.
diff --git a/tests/qapi-schema/unknown-expr-key.json b/tests/qapi-schema/=
unknown-expr-key.json
index 3b2be00cc4..13292d75ed 100644
--- a/tests/qapi-schema/unknown-expr-key.json
+++ b/tests/qapi-schema/unknown-expr-key.json
@@ -1,2 +1,2 @@
 # we reject an expression with unknown top-level keys
-{ 'struct': 'bar', 'data': { 'string': 'str'}, 'bogus': { } }
+{ 'struct': 'bar', 'data': { 'string': 'str'}, 'bogus': { }, 'phony': { =
} }
--=20
2.20.0.rc1
