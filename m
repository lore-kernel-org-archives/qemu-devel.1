Received: from eggs.gnu.org ([2001:4830:134:3::10]:58410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbORL-0008Hr-05
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbORJ-0007rL-RE
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36388 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fbORJ-0007qR-Lo
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 34A27E9002
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 10:58:13 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  6 Jul 2018 12:57:37 +0200
Message-Id: <20180706105753.26700-12-marcandre.lureau@redhat.com>
In-Reply-To: <20180706105753.26700-1-marcandre.lureau@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 11/27] qapi: improve reporting of unknown or
 missing keys
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
index 8313c478c4..cf8dab2866 100644
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
index 12f5ed5b43..83b83121e0 100644
--- a/tests/qapi-schema/unknown-expr-key.err
+++ b/tests/qapi-schema/unknown-expr-key.err
@@ -1 +1,2 @@
-tests/qapi-schema/unknown-expr-key.json:2: Unknown key 'bogus' in struct=
 'bar'
+tests/qapi-schema/unknown-expr-key.json:2: Unknown keys 'bogus', 'foo' i=
n struct 'bar'
+Valid keys are 'base', 'data', 'if', 'struct'.
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
2.18.0.rc1
