Received: from eggs.gnu.org ([2001:4830:134:3::10]:54632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtQ-00065O-8K
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtO-00070i-Ox
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1coOtO-0006zu-FK
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 85E473DBDF
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Mar 2017 07:27:17 +0100
Message-Id: <1489645685-4750-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1489645685-4750-1-git-send-email-armbru@redhat.com>
References: <1489645685-4750-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for 2.9 01/49] qapi2texi: change texi formatters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

STRUCT_FMT is generic enough, rename it to TYPE_FMT, use it for unions.

Rename COMMAND_FMT to MSG_FMT, since it applies to both commands and
events.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170125130308.16104-2-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi2texi.py | 46 +++++++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index c1071c6..69f5edc 100755
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
@@ -170,9 +161,9 @@ def texi_body(doc):
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
@@ -184,9 +175,9 @@ def texi_union(expr, doc):
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
@@ -195,32 +186,33 @@ def texi_enum(expr, doc):
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
2.7.4
