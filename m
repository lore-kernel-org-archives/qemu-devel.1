Received: from eggs.gnu.org ([2001:4830:134:3::10]:40592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6u-0000tB-IW
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6r-0007da-G7
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erU6r-0007br-8I
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:21 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A48C5F7B1
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 19:43:20 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu,  1 Mar 2018 13:42:30 -0600
Message-Id: <20180301194245.29854-16-eblake@redhat.com>
In-Reply-To: <20180301194245.29854-1-eblake@redhat.com>
References: <20180301194245.29854-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/30] qapi: Record 'include' directives in
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
Cc: Markus Armbruster <armbru@redhat.com>

From: Markus Armbruster <armbru@redhat.com>

The parse tree is a list of expressions.  Except include expressions
currently get replaced by the included file's parse tree.

Instead of throwing away the include expression, keep it with the file
name expanded so you don't have to track the including file's
directory to make sense of it.

A future commit will put this include expression to use.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180211093607.27351-16-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: fix check of expr after assignment]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/common.py | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 1d0d30f9ece..961331a210c 100644
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

-    def _include(self, include, info, base_dir, previously_included):
-        incl_fname =3D os.path.join(base_dir, include)
+    def _include(self, include, info, incl_fname, previously_included):
         incl_abs_fname =3D os.path.abspath(incl_fname)
         # catch inclusion cycle
         inf =3D info
@@ -893,6 +895,9 @@ def check_exprs(exprs):
         info =3D expr_elem['info']
         doc =3D expr_elem.get('doc')

+        if 'include' in expr:
+            continue
+
         if not doc and doc_required:
             raise QAPISemError(info,
                                "Expression missing documentation comment=
")
@@ -932,6 +937,9 @@ def check_exprs(exprs):
     # Try again for hidden UnionKind enum
     for expr_elem in exprs:
         expr =3D expr_elem['expr']
+
+        if 'include' in expr:
+            continue
         if 'union' in expr and not discriminator_find_enum_define(expr):
             name =3D '%sKind' % expr['union']
         elif 'alternate' in expr:
@@ -947,6 +955,8 @@ def check_exprs(exprs):
         info =3D expr_elem['info']
         doc =3D expr_elem.get('doc')

+        if 'include' in expr:
+            continue
         if 'enum' in expr:
             check_enum(expr, info)
         elif 'union' in expr:
@@ -1667,6 +1677,8 @@ class QAPISchema(object):
                 self._def_command(expr, info, doc)
             elif 'event' in expr:
                 self._def_event(expr, info, doc)
+            elif 'include' in expr:
+                pass
             else:
                 assert False

--=20
2.14.3
