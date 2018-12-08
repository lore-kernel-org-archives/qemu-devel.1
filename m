Received: from eggs.gnu.org ([2001:4830:134:3::10]:59663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVabf-0004J6-6d
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:17:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVabV-0003u7-ST
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:17:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gVabV-0003tf-Ml
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:17:01 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat,  8 Dec 2018 15:15:45 +0400
Message-Id: <20181208111606.8505-7-marcandre.lureau@redhat.com>
In-Reply-To: <20181208111606.8505-1-marcandre.lureau@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0 v7 06/27] qapi: factor out checking for
 keys
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

Introduce a new helper function to check if the given keys are known,
and if mandatory keys are present. The function will be reused in
other places in the following code changes.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 1fa2f79990..18f5872808 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -873,6 +873,17 @@ def check_struct(expr, info):
                allow_metas=3D['struct'])
=20
=20
+def check_known_keys(info, source, keys, required, optional):
+    for key in keys:
+        if key not in required and key not in optional:
+            raise QAPISemError(info, "Unknown key '%s' in %s" % (key, so=
urce))
+
+    for key in required:
+        if key not in keys:
+            raise QAPISemError(info, "Key '%s' is missing from %s"
+                               % (key, source))
+
+
 def check_keys(expr_elem, meta, required, optional=3D[]):
     expr =3D expr_elem['expr']
     info =3D expr_elem['info']
@@ -880,10 +891,9 @@ def check_keys(expr_elem, meta, required, optional=3D=
[]):
     if not isinstance(name, str):
         raise QAPISemError(info, "'%s' key must have a string value" % m=
eta)
     required =3D required + [meta]
+    source =3D "%s '%s'" % (meta, name)
+    check_known_keys(info, source, expr.keys(), required, optional)
     for (key, value) in expr.items():
-        if key not in required and key not in optional:
-            raise QAPISemError(info, "Unknown key '%s' in %s '%s'"
-                               % (key, meta, name))
         if key in ['gen', 'success-response'] and value is not False:
             raise QAPISemError(info,
                                "'%s' of %s '%s' should only use false va=
lue"
@@ -895,10 +905,6 @@ def check_keys(expr_elem, meta, required, optional=3D=
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
--=20
2.20.0.rc1
