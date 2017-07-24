Received: from eggs.gnu.org ([2001:4830:134:3::10]:42312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZhZW-0006N8-9z
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZhZR-0007VA-F6
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:55:10 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:54108)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZhZR-0007U6-3P
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:55:05 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Mon, 24 Jul 2017 20:54:54 +0300
Message-Id: <150091889458.30739.16324719944323757435.stgit@frigg.lan>
In-Reply-To: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 13/13] trace: Rename C++-specific names in
 event arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>

Allows instrumentation clients in C++ to use the auto-generated headers.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 scripts/tracetool/__init__.py |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.p=
y
index 7c19dc8c94..be7f28d2be 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -42,6 +42,8 @@ def out(*lines, **kwargs):
     sys.stdout.writelines("\n".join(lines) + "\n")
=20
=20
+FORBIDDEN =3D ["new", "class"]
+
 class Arguments:
     """Event arguments description."""
=20
@@ -85,6 +87,9 @@ class Arguments:
             else:
                 arg_type, identifier =3D arg.rsplit(None, 1)
=20
+            if identifier in FORBIDDEN:
+                identifier +=3D "_"
+
             res.append((arg_type, identifier))
         return Arguments(res)
=20
@@ -230,7 +235,10 @@ class Event(object):
         fmt_trans =3D groups["fmt_trans"]
         if len(fmt_trans) > 0:
             fmt =3D [fmt_trans, fmt]
-        args =3D Arguments.build(groups["args"])
+        try:
+            args =3D Arguments.build(groups["args"])
+        except ForbiddenArgumentError as e:
+            error("Error: event '%s' uses forbidden argument name '%s'" =
% (name, e.name))
=20
         if "tcg-trans" in props:
             raise ValueError("Invalid property 'tcg-trans'")
