Received: from eggs.gnu.org ([2001:4830:134:3::10]:54212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3j-00078d-BE
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3d-0006RS-MY
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36022 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eko3c-0006Po-Tq
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:25 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun, 11 Feb 2018 10:35:53 +0100
Message-Id: <20180211093607.27351-16-armbru@redhat.com>
In-Reply-To: <20180211093607.27351-1-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 15/29] qapi: Record 'include' directives in
 parse tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com

The parse tree is a list of expressions.  Except include expressions
currently get replaced by the included file's parse tree.

Instead of throwing away the include expression, keep it with the file
name expanded so you don't have to track the including file's
directory to make sense of it.

A future commit will put this include expression to use.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index cc5a5941dd..6d49709784 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -290,8 +290,11 @@ class QAPISchemaParser(object):
                 if not isinstance(include, str):
                     raise QAPISemError(info,
                                        "Value of 'include' must be a str=
ing")
-                exprs_include =3D self._include(include, info,
-                                              os.path.dirname(self.fname=
),
+                incl_fname =3D os.path.join(os.path.dirname(self.fname),
+                                          include)
+                self.exprs.append({'expr': {'include': incl_fname},
+                                   'info': info})
+                exprs_include =3D self._include(include, info, incl_fnam=
e,
                                               previously_included)
                 if exprs_include:
                     self.exprs.extend(exprs_include.exprs)
@@ -326,8 +329,7 @@ class QAPISchemaParser(object):
                 "Documentation for '%s' is not followed by the definitio=
n"
                 % doc.symbol)
=20
-    def _include(self, include, info, base_dir, previously_included):
-        incl_fname =3D os.path.join(base_dir, include)
+    def _include(self, include, info, incl_fname, previously_included):
         incl_abs_fname =3D os.path.abspath(incl_fname)
         # catch inclusion cycle
         inf =3D info
@@ -893,6 +895,9 @@ def check_exprs(exprs):
         info =3D expr_elem['info']
         doc =3D expr_elem.get('doc')
=20
+        if 'include' in expr:
+            continue
+
         if not doc and doc_required:
             raise QAPISemError(info,
                                "Expression missing documentation comment=
")
@@ -931,6 +936,9 @@ def check_exprs(exprs):
=20
     # Try again for hidden UnionKind enum
     for expr_elem in exprs:
+        if 'include' in expr:
+            continue
+
         expr =3D expr_elem['expr']
         if 'union' in expr and not discriminator_find_enum_define(expr):
             name =3D '%sKind' % expr['union']
@@ -943,6 +951,9 @@ def check_exprs(exprs):
=20
     # Validate that exprs make sense
     for expr_elem in exprs:
+        if 'include' in expr:
+            continue
+
         expr =3D expr_elem['expr']
         info =3D expr_elem['info']
         doc =3D expr_elem.get('doc')
@@ -1667,6 +1678,8 @@ class QAPISchema(object):
                 self._def_command(expr, info, doc)
             elif 'event' in expr:
                 self._def_event(expr, info, doc)
+            elif 'include' in expr:
+                pass
             else:
                 assert False
=20
--=20
2.13.6
