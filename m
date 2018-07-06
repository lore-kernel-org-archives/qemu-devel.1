Received: from eggs.gnu.org ([2001:4830:134:3::10]:58465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbORS-0008OI-HV
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbORR-0008NG-LX
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40936 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fbORR-0008KX-G3
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA9BB40122D9
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 10:58:20 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  6 Jul 2018 12:57:41 +0200
Message-Id: <20180706105753.26700-16-marcandre.lureau@redhat.com>
In-Reply-To: <20180706105753.26700-1-marcandre.lureau@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 15/27] qapi: rename allow_dict to
 allow_implicit
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

This makes it a bit clearer what is the intent of the dictionnary for
the check_type() function, since there was some confusion on a
previous iteration of this series.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 95b7cd74ee..d83fa1900e 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -661,7 +661,7 @@ def check_if(expr, info):
=20
=20
 def check_type(info, source, value, allow_array=3DFalse,
-               allow_dict=3DFalse, allow_optional=3DFalse,
+               allow_implicit=3DFalse, allow_optional=3DFalse,
                allow_metas=3D[]):
     global all_names
=20
@@ -688,7 +688,7 @@ def check_type(info, source, value, allow_array=3DFal=
se,
                                (source, all_names[value], value))
         return
=20
-    if not allow_dict:
+    if not allow_implicit:
         raise QAPISemError(info, "%s should be a type name" % source)
=20
     if not isinstance(value, OrderedDict):
@@ -718,7 +718,7 @@ def check_command(expr, info):
     if boxed:
         args_meta +=3D ['union', 'alternate']
     check_type(info, "'data' for command '%s'" % name,
-               expr.get('data'), allow_dict=3Dnot boxed, allow_optional=3D=
True,
+               expr.get('data'), allow_implicit=3Dnot boxed, allow_optio=
nal=3DTrue,
                allow_metas=3Dargs_meta)
     returns_meta =3D ['union', 'struct']
     if name in returns_whitelist:
@@ -736,7 +736,7 @@ def check_event(expr, info):
     if boxed:
         meta +=3D ['union', 'alternate']
     check_type(info, "'data' for event '%s'" % name,
-               expr.get('data'), allow_dict=3Dnot boxed, allow_optional=3D=
True,
+               expr.get('data'), allow_implicit=3Dnot boxed, allow_optio=
nal=3DTrue,
                allow_metas=3Dmeta)
=20
=20
@@ -764,7 +764,7 @@ def check_union(expr, info):
     else:
         # The object must have a string or dictionary 'base'.
         check_type(info, "'base' for union '%s'" % name,
-                   base, allow_dict=3DTrue, allow_optional=3DTrue,
+                   base, allow_implicit=3DTrue, allow_optional=3DTrue,
                    allow_metas=3D['struct'])
         if not base:
             raise QAPISemError(info, "Flat union '%s' must have a base"
@@ -888,7 +888,7 @@ def check_struct(expr, info):
     members =3D expr['data']
=20
     check_type(info, "'data' for struct '%s'" % name, members,
-               allow_dict=3DTrue, allow_optional=3DTrue)
+               allow_implicit=3DTrue, allow_optional=3DTrue)
     check_type(info, "'base' for struct '%s'" % name, expr.get('base'),
                allow_metas=3D['struct'])
=20
--=20
2.18.0.rc1
