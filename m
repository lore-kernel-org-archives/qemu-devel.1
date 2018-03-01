Received: from eggs.gnu.org ([2001:4830:134:3::10]:40545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6r-0000r1-Iz
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6q-0007c0-Oa
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erU6q-0007aT-IY
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:20 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C42C081E1A
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 19:43:19 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu,  1 Mar 2018 13:42:29 -0600
Message-Id: <20180301194245.29854-15-eblake@redhat.com>
In-Reply-To: <20180301194245.29854-1-eblake@redhat.com>
References: <20180301194245.29854-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/30] qapi: Concentrate QAPISchemaParser.exprs
 updates in .__init__()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

From: Markus Armbruster <armbru@redhat.com>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180211093607.27351-15-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/common.py | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 4cc4d3ee8f4..1d0d30f9ece 100644
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

     def _pragma(self, name, value, info):
         global doc_required, returns_whitelist, name_case_whitelist
--=20
2.14.3
