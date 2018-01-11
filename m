Received: from eggs.gnu.org ([2001:4830:134:3::10]:51060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkVx-00077m-PW
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkVw-0003Zm-Od
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkVw-0003Yc-GU
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:56 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:24 +0100
Message-Id: <20180111213250.16511-26-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 25/51] qapi: rename allow_dict to
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
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This makes it a bit clearer what is the intent of the dictionnary for
the check_type() function, since there was some confusion on a
previous iteration of this series.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index e203734254..5b41114949 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -652,7 +652,7 @@ def check_if(expr, info):
=20
=20
 def check_type(info, source, value, allow_array=3DFalse,
-               allow_dict=3DFalse, allow_optional=3DFalse,
+               allow_implicit=3DFalse, allow_optional=3DFalse,
                allow_metas=3D[]):
     global all_names
=20
@@ -679,7 +679,7 @@ def check_type(info, source, value, allow_array=3DFal=
se,
                                (source, all_names[value], value))
         return
=20
-    if not allow_dict:
+    if not allow_implicit:
         raise QAPISemError(info, "%s should be a type name" % source)
=20
     if not isinstance(value, OrderedDict):
@@ -709,7 +709,7 @@ def check_command(expr, info):
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
@@ -727,7 +727,7 @@ def check_event(expr, info):
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
@@ -755,7 +755,7 @@ def check_union(expr, info):
     else:
         # The object must have a string or dictionary 'base'.
         check_type(info, "'base' for union '%s'" % name,
-                   base, allow_dict=3DTrue, allow_optional=3DTrue,
+                   base, allow_implicit=3DTrue, allow_optional=3DTrue,
                    allow_metas=3D['struct'])
         if not base:
             raise QAPISemError(info, "Flat union '%s' must have a base"
@@ -886,7 +886,7 @@ def check_struct(expr, info):
     members =3D expr['data']
=20
     check_type(info, "'data' for struct '%s'" % name, members,
-               allow_dict=3DTrue, allow_optional=3DTrue)
+               allow_implicit=3DTrue, allow_optional=3DTrue)
     check_type(info, "'base' for struct '%s'" % name, expr.get('base'),
                allow_metas=3D['struct'])
=20
--=20
2.16.0.rc1.1.gef27df75a1
