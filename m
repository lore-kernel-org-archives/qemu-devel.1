Received: from eggs.gnu.org ([2001:4830:134:3::10]:49530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cWNEX-0001Xu-2x
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:03:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cWNES-0000Jo-Vq
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:03:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cWNES-0000J9-NR
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:03:24 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DAFCA3D955
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 13:03:24 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 25 Jan 2017 17:03:08 +0400
Message-Id: <20170125130308.16104-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170125130308.16104-1-marcandre.lureau@redhat.com>
References: <20170125130308.16104-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] qapi2texi: produce type information
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

Add type information to the generated documentation. Without it the
written documentation is not explicit enough to know how to handle
the various arguments and members.

Array types have the following syntax: type[]. Ex: str[].

- Struct, commands and events use the following members syntax:

  { 'member': type, ('foo': str), ... }

Optional members are under parentheses.

A structure with a base type will have 'BaseStruct +' prepended.

- Alternates use the following syntax:

  [ 'foo': type, 'bar': type, ... ]

- Simple unions use the following syntax:

  { 'type': str, 'data': 'type' =3D [ 'foo': type, 'bar': type... ] }

- Flat unions use the following syntax:

  BaseStruct + 'discriminator' =3D [ 'foo': type, 'bar': type... ]

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi2texi.py | 68 ++++++++++++++++++++++++++++++++++++++++++++++=
++++--
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index e1b79c2ad3..d632c72139 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -10,7 +10,8 @@ import sys
 import qapi
=20
 MSG_FMT =3D """
-@deftypefn {type} {{}} {name}
+@deftypefn {type} {{{ret}}} {name} @
+{{{args}}}
=20
 {body}
=20
@@ -19,7 +20,8 @@ MSG_FMT =3D """
 """.format
=20
 TYPE_FMT =3D """
-@deftp {{{type}}} {name}
+@deftp {{{type}}} {name} @
+{{{members}}}
=20
 {body}
=20
@@ -123,6 +125,36 @@ def texi_format(doc):
     return "\n".join(lines)
=20
=20
+def texi_type(typ):
+    """Format a type"""
+    if isinstance(typ, list):
+        # must contain single type name
+        typ =3D "%s[]" % typ[0]
+
+    return '@t{%s}' % typ
+
+
+def texi_args(expr, key=3D"data", fmt=3D"@{%s@}"):
+    """Format the functions/structure/events arguments/members"""
+    if key not in expr:
+        return ""
+    args =3D expr[key]
+    if isinstance(args, str) or isinstance(args, list):
+        ret =3D texi_type(args)
+    else:
+        arg_list =3D []
+        for name, typ in args.iteritems():
+            # optional
+            if name.startswith("*"):
+                name =3D name[1:]
+                arg_list.append("('%s': %s)" % (name, texi_type(typ)))
+            else:
+                arg_list.append("'%s': %s" % (name, texi_type(typ)))
+        ret =3D fmt % ", ".join(arg_list)
+
+    return ret
+
+
 def texi_body(doc):
     """
     Format the body of a symbol documentation:
@@ -162,9 +194,11 @@ def texi_body(doc):
=20
 def texi_alternate(expr, doc):
     """Format an alternate to texi"""
+    members =3D texi_args(expr, fmt=3D"[%s]")
     body =3D texi_body(doc)
     return TYPE_FMT(type=3D"Alternate",
                     name=3Ddoc.symbol,
+                    members=3Dmembers,
                     body=3Dbody)
=20
=20
@@ -172,13 +206,26 @@ def texi_union(expr, doc):
     """Format a union to texi"""
     discriminator =3D expr.get("discriminator")
     if discriminator:
+        is_flat =3D True
         union =3D "Flat Union"
     else:
+        is_flat =3D False
         union =3D "Simple Union"
+        discriminator =3D "type"
=20
+    members =3D ""
+    if is_flat:
+        members +=3D texi_args(expr, "base") + " + "
+    else:
+        members +=3D "@{ 'type': @t{str}, 'data': "
+    members +=3D "'%s' =3D " % discriminator
+    members +=3D texi_args(expr, "data", fmt=3D"[%s]")
+    if not is_flat:
+        members +=3D " @}"
     body =3D texi_body(doc)
     return TYPE_FMT(type=3Dunion,
                     name=3Ddoc.symbol,
+                    members=3Dmembers,
                     body=3Dbody)
=20
=20
@@ -190,30 +237,47 @@ def texi_enum(expr, doc):
     body =3D texi_body(doc)
     return TYPE_FMT(type=3D"Enum",
                     name=3Ddoc.symbol,
+                    members=3D"",
                     body=3Dbody)
=20
=20
 def texi_struct(expr, doc):
     """Format a struct to texi"""
     body =3D texi_body(doc)
+    args =3D texi_args(expr)
+    base =3D expr.get("base")
+    members =3D ""
+    if base:
+        members +=3D "%s" % base
+        if args:
+            members +=3D " + "
+    members +=3D args
     return TYPE_FMT(type=3D"Struct",
                     name=3Ddoc.symbol,
+                    members=3Dmembers,
                     body=3Dbody)
=20
=20
 def texi_command(expr, doc):
     """Format a command to texi"""
     body =3D texi_body(doc)
+    args =3D texi_args(expr)
+    ret =3D texi_args(expr, "returns")
     return MSG_FMT(type=3D"Command",
                    name=3Ddoc.symbol,
+                   ret=3Dret,
+                   args=3Dargs,
                    body=3Dbody)
=20
=20
 def texi_event(expr, doc):
     """Format an event to texi"""
     body =3D texi_body(doc)
+    args =3D texi_args(expr)
     return MSG_FMT(type=3D"Event",
                    name=3Ddoc.symbol,
+                   ret=3D"",
+                   args=3Dargs,
                    body=3Dbody)
=20
=20
--=20
2.11.0.295.gd7dffce1c
