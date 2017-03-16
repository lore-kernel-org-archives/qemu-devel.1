Received: from eggs.gnu.org ([2001:4830:134:3::10]:54638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtQ-00065T-AA
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtN-0006zA-7D
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1coOtM-0006wx-VG
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D8BE13DBE6
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BBC8627D9
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:08 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Mar 2017 07:27:19 +0100
Message-Id: <1489645685-4750-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1489645685-4750-1-git-send-email-armbru@redhat.com>
References: <1489645685-4750-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for 2.9 03/49] qapi: Factor
 QAPISchemaParser._include() out of .__init__()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <1489582656-31133-2-git-send-email-armbru@redhat.com>
---
 scripts/qapi.py | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 53a4477..345cde1 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -268,34 +268,15 @@ class QAPISchemaParser(object):
                 continue
=20
             expr =3D self.get_expr(False)
-            if isinstance(expr, dict) and "include" in expr:
+            if 'include' in expr:
                 if len(expr) !=3D 1:
                     raise QAPISemError(info, "Invalid 'include' directiv=
e")
                 include =3D expr["include"]
                 if not isinstance(include, str):
                     raise QAPISemError(info,
                                        "Value of 'include' must be a str=
ing")
-                incl_abs_fname =3D os.path.join(os.path.dirname(abs_fnam=
e),
-                                              include)
-                # catch inclusion cycle
-                inf =3D info
-                while inf:
-                    if incl_abs_fname =3D=3D os.path.abspath(inf['file']=
):
-                        raise QAPISemError(info, "Inclusion loop for %s"
-                                           % include)
-                    inf =3D inf['parent']
-
-                # skip multiple include of the same file
-                if incl_abs_fname in previously_included:
-                    continue
-                try:
-                    fobj =3D open(incl_abs_fname, 'r')
-                except IOError as e:
-                    raise QAPISemError(info, '%s: %s' % (e.strerror, inc=
lude))
-                exprs_include =3D QAPISchemaParser(fobj, previously_incl=
uded,
-                                                 info)
-                self.exprs.extend(exprs_include.exprs)
-                self.docs.extend(exprs_include.docs)
+                self._include(include, info, os.path.dirname(abs_fname),
+                              previously_included)
             else:
                 expr_elem =3D {'expr': expr,
                              'info': info}
@@ -307,6 +288,26 @@ class QAPISchemaParser(object):
=20
                 self.exprs.append(expr_elem)
=20
+    def _include(self, include, info, base_dir, previously_included):
+        incl_abs_fname =3D os.path.join(base_dir, include)
+        # catch inclusion cycle
+        inf =3D info
+        while inf:
+            if incl_abs_fname =3D=3D os.path.abspath(inf['file']):
+                raise QAPISemError(info, "Inclusion loop for %s" % inclu=
de)
+            inf =3D inf['parent']
+
+        # skip multiple include of the same file
+        if incl_abs_fname in previously_included:
+            return
+        try:
+            fobj =3D open(incl_abs_fname, 'r')
+        except IOError as e:
+            raise QAPISemError(info, '%s: %s' % (e.strerror, include))
+        exprs_include =3D QAPISchemaParser(fobj, previously_included, in=
fo)
+        self.exprs.extend(exprs_include.exprs)
+        self.docs.extend(exprs_include.docs)
+
     def accept(self, skip_comment=3DTrue):
         while True:
             self.tok =3D self.src[self.cursor]
--=20
2.7.4
