Received: from eggs.gnu.org ([2001:4830:134:3::10]:45436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cnhp6-0005Ec-W6
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:28:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cnhp5-0000x8-KC
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:28:53 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:36374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cnhp5-0000ww-8B
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:28:51 -0400
Received: by mail-lf0-x241.google.com with SMTP id g70so13507200lfh.3
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 01:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-2-git-send-email-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 Mar 2017 08:28:39 +0000
Message-ID: <CAJ+F1CLyLuqPL4aPBYRyMhrJRkX-DCFXaAXDOiooK=12Jwmn5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 01/47] qapi: Factor
 QAPISchemaParser._include() out of .__init__()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

On Mon, Mar 13, 2017 at 10:20 AM Markus Armbruster <armbru@redhat.com>
wrote:

Signed-off-by: Markus Armbruster <armbru@redhat.com>



Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



---
 scripts/qapi.py | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 53a4477..345cde1 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -268,34 +268,15 @@ class QAPISchemaParser(object):
                 continue

             expr =3D self.get_expr(False)
-            if isinstance(expr, dict) and "include" in expr:
+            if 'include' in expr:
                 if len(expr) !=3D 1:
                     raise QAPISemError(info, "Invalid 'include' directive"=
)
                 include =3D expr["include"]
                 if not isinstance(include, str):
                     raise QAPISemError(info,
                                        "Value of 'include' must be a
string")
-                incl_abs_fname =3D os.path.join(os.path.dirname(abs_fname)=
,
-                                              include)
-                # catch inclusion cycle
-                inf =3D info
-                while inf:
-                    if incl_abs_fname =3D=3D os.path.abspath(inf['file']):
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
-                    raise QAPISemError(info, '%s: %s' % (e.strerror,
include))
-                exprs_include =3D QAPISchemaParser(fobj, previously_includ=
ed,
-                                                 info)
-                self.exprs.extend(exprs_include.exprs)
-                self.docs.extend(exprs_include.docs)
+                self._include(include, info, os.path.dirname(abs_fname),
+                              previously_included)
             else:
                 expr_elem =3D {'expr': expr,
                              'info': info}
@@ -307,6 +288,26 @@ class QAPISchemaParser(object):

                 self.exprs.append(expr_elem)

+    def _include(self, include, info, base_dir, previously_included):
+        incl_abs_fname =3D os.path.join(base_dir, include)
+        # catch inclusion cycle
+        inf =3D info
+        while inf:
+            if incl_abs_fname =3D=3D os.path.abspath(inf['file']):
+                raise QAPISemError(info, "Inclusion loop for %s" % include=
)
+            inf =3D inf['parent']
+
+        # skip multiple include of the same file
+        if incl_abs_fname in previously_included:
+            return
+        try:
+            fobj =3D open(incl_abs_fname, 'r')
+        except IOError as e:
+            raise QAPISemError(info, '%s: %s' % (e.strerror, include))
+        exprs_include =3D QAPISchemaParser(fobj, previously_included, info=
)
+        self.exprs.extend(exprs_include.exprs)
+        self.docs.extend(exprs_include.docs)
+
     def accept(self, skip_comment=3DTrue):
         while True:
             self.tok =3D self.src[self.cursor]
--
2.7.4


--=20
Marc-Andr=C3=A9 Lureau
