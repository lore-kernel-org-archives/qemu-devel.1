Received: from eggs.gnu.org ([2001:4830:134:3::10]:49474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cWNEO-0001Rh-4n
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:03:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cWNEN-0000G0-1E
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:03:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cWNEM-0000FE-PV
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:03:18 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E93893A768D
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 13:03:18 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 25 Jan 2017 17:03:07 +0400
Message-Id: <20170125130308.16104-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170125130308.16104-1-marcandre.lureau@redhat.com>
References: <20170125130308.16104-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] qapi2texi: change texi formatters
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

STRUCT_FMT is generic enough, rename it to TYPE_FMT, use it for unions.

Rename COMMAND_FMT to MSG_FMT, since it applies to both commands and
events.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi2texi.py | 46 +++++++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 83ded95c2d..e1b79c2ad3 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -9,7 +9,7 @@ import sys
=20
 import qapi
=20
-COMMAND_FMT =3D """
+MSG_FMT =3D """
 @deftypefn {type} {{}} {name}
=20
 {body}
@@ -18,16 +18,7 @@ COMMAND_FMT =3D """
=20
 """.format
=20
-ENUM_FMT =3D """
-@deftp Enum {name}
-
-{body}
-
-@end deftp
-
-""".format
-
-STRUCT_FMT =3D """
+TYPE_FMT =3D """
 @deftp {{{type}}} {name}
=20
 {body}
@@ -172,9 +163,9 @@ def texi_body(doc):
 def texi_alternate(expr, doc):
     """Format an alternate to texi"""
     body =3D texi_body(doc)
-    return STRUCT_FMT(type=3D"Alternate",
-                      name=3Ddoc.symbol,
-                      body=3Dbody)
+    return TYPE_FMT(type=3D"Alternate",
+                    name=3Ddoc.symbol,
+                    body=3Dbody)
=20
=20
 def texi_union(expr, doc):
@@ -186,9 +177,9 @@ def texi_union(expr, doc):
         union =3D "Simple Union"
=20
     body =3D texi_body(doc)
-    return STRUCT_FMT(type=3Dunion,
-                      name=3Ddoc.symbol,
-                      body=3Dbody)
+    return TYPE_FMT(type=3Dunion,
+                    name=3Ddoc.symbol,
+                    body=3Dbody)
=20
=20
 def texi_enum(expr, doc):
@@ -197,32 +188,33 @@ def texi_enum(expr, doc):
         if i not in doc.args:
             doc.args[i] =3D ''
     body =3D texi_body(doc)
-    return ENUM_FMT(name=3Ddoc.symbol,
+    return TYPE_FMT(type=3D"Enum",
+                    name=3Ddoc.symbol,
                     body=3Dbody)
=20
=20
 def texi_struct(expr, doc):
     """Format a struct to texi"""
     body =3D texi_body(doc)
-    return STRUCT_FMT(type=3D"Struct",
-                      name=3Ddoc.symbol,
-                      body=3Dbody)
+    return TYPE_FMT(type=3D"Struct",
+                    name=3Ddoc.symbol,
+                    body=3Dbody)
=20
=20
 def texi_command(expr, doc):
     """Format a command to texi"""
     body =3D texi_body(doc)
-    return COMMAND_FMT(type=3D"Command",
-                       name=3Ddoc.symbol,
-                       body=3Dbody)
+    return MSG_FMT(type=3D"Command",
+                   name=3Ddoc.symbol,
+                   body=3Dbody)
=20
=20
 def texi_event(expr, doc):
     """Format an event to texi"""
     body =3D texi_body(doc)
-    return COMMAND_FMT(type=3D"Event",
-                       name=3Ddoc.symbol,
-                       body=3Dbody)
+    return MSG_FMT(type=3D"Event",
+                   name=3Ddoc.symbol,
+                   body=3Dbody)
=20
=20
 def texi_expr(expr, doc):
--=20
2.11.0.295.gd7dffce1c
