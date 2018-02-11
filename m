Received: from eggs.gnu.org ([2001:4830:134:3::10]:54178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3h-00076r-SX
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3d-0006Qn-E7
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54018 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eko3c-0006Pi-QF
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:25 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun, 11 Feb 2018 10:35:52 +0100
Message-Id: <20180211093607.27351-15-armbru@redhat.com>
In-Reply-To: <20180211093607.27351-1-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 14/29] qapi: Concentrate
 QAPISchemaParser.exprs updates in .__init__()
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index dce289ae21..cc5a5941dd 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -290,8 +290,12 @@ class QAPISchemaParser(object):
                 if not isinstance(include, str):
                     raise QAPISemError(info,
                                        "Value of 'include' must be a str=
ing")
-                self._include(include, info, os.path.dirname(self.fname)=
,
-                              previously_included)
+                exprs_include =3D self._include(include, info,
+                                              os.path.dirname(self.fname=
),
+                                              previously_included)
+                if exprs_include:
+                    self.exprs.extend(exprs_include.exprs)
+                    self.docs.extend(exprs_include.docs)
             elif "pragma" in expr:
                 self.reject_expr_doc(cur_doc)
                 if len(expr) !=3D 1:
@@ -334,14 +338,13 @@ class QAPISchemaParser(object):
=20
         # skip multiple include of the same file
         if incl_abs_fname in previously_included:
-            return
+            return None
+
         try:
             fobj =3D open(incl_fname, 'r')
         except IOError as e:
             raise QAPISemError(info, '%s: %s' % (e.strerror, incl_fname)=
)
-        exprs_include =3D QAPISchemaParser(fobj, previously_included, in=
fo)
-        self.exprs.extend(exprs_include.exprs)
-        self.docs.extend(exprs_include.docs)
+        return QAPISchemaParser(fobj, previously_included, info)
=20
     def _pragma(self, name, value, info):
         global doc_required, returns_whitelist, name_case_whitelist
--=20
2.13.6
