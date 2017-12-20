Received: from eggs.gnu.org ([2001:4830:134:3::10]:55660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRjaX-00029T-11
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRjaR-00060o-Iu
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eRjaR-0005zb-8a
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:27 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B7FE13AA3
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:59:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-74.ams2.redhat.com
	[10.36.116.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D4D881757A
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:59:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 20 Dec 2017 19:59:15 +0100
Message-Id: <20171220185924.32756-5-armbru@redhat.com>
In-Reply-To: <20171220185924.32756-1-armbru@redhat.com>
References: <20171220185924.32756-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/13] qapi: Make cur_doc local to
 QAPISchemaParser.__init__()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

QAPISchemaParser.cur_doc is used only by .__init__() and its helper
.reject_expr_doc().  Make it local to __init__() and pass it to
.reject_expr_doc() explicitly.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20171002141341.24616-5-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 6c8001e96d..2f2738f562 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -272,21 +272,21 @@ class QAPISchemaParser(object):
         self.line_pos =3D 0
         self.exprs =3D []
         self.docs =3D []
-        self.cur_doc =3D None
         self.accept()
+        cur_doc =3D None
=20
         while self.tok is not None:
             info =3D {'file': self.fname, 'line': self.line,
                     'parent': self.incl_info}
             if self.tok =3D=3D '#':
-                self.reject_expr_doc()
-                self.cur_doc =3D self.get_doc(info)
-                self.docs.append(self.cur_doc)
+                self.reject_expr_doc(cur_doc)
+                cur_doc =3D self.get_doc(info)
+                self.docs.append(cur_doc)
                 continue
=20
             expr =3D self.get_expr(False)
             if 'include' in expr:
-                self.reject_expr_doc()
+                self.reject_expr_doc(cur_doc)
                 if len(expr) !=3D 1:
                     raise QAPISemError(info, "Invalid 'include' directiv=
e")
                 include =3D expr['include']
@@ -296,7 +296,7 @@ class QAPISchemaParser(object):
                 self._include(include, info, os.path.dirname(abs_fname),
                               previously_included)
             elif "pragma" in expr:
-                self.reject_expr_doc()
+                self.reject_expr_doc(cur_doc)
                 if len(expr) !=3D 1:
                     raise QAPISemError(info, "Invalid 'pragma' directive=
")
                 pragma =3D expr['pragma']
@@ -308,22 +308,22 @@ class QAPISchemaParser(object):
             else:
                 expr_elem =3D {'expr': expr,
                              'info': info}
-                if self.cur_doc:
-                    if not self.cur_doc.symbol:
+                if cur_doc:
+                    if not cur_doc.symbol:
                         raise QAPISemError(
-                            self.cur_doc.info,
-                            "Expression documentation required")
-                    expr_elem['doc'] =3D self.cur_doc
+                            cur_doc.info, "Expression documentation requ=
ired")
+                    expr_elem['doc'] =3D cur_doc
                 self.exprs.append(expr_elem)
-            self.cur_doc =3D None
-        self.reject_expr_doc()
+            cur_doc =3D None
+        self.reject_expr_doc(cur_doc)
=20
-    def reject_expr_doc(self):
-        if self.cur_doc and self.cur_doc.symbol:
+    @staticmethod
+    def reject_expr_doc(doc):
+        if doc and doc.symbol:
             raise QAPISemError(
-                self.cur_doc.info,
+                doc.info,
                 "Documentation for '%s' is not followed by the definitio=
n"
-                % self.cur_doc.symbol)
+                % doc.symbol)
=20
     def _include(self, include, info, base_dir, previously_included):
         incl_abs_fname =3D os.path.join(base_dir, include)
--=20
2.13.6
