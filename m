Received: from eggs.gnu.org ([2001:4830:134:3::10]:50214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkUq-00065E-06
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:34:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkUm-0002AB-S0
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:34:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkUm-00029B-MU
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:34:44 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:10 +0100
Message-Id: <20180111213250.16511-12-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 11/51] qapi-introspect: modify to_qlit() to
 append ', ' on level > 0
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

The following patch is going to break list entries with #if/#endif, so
they should have the trailing ',' as suffix.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi-introspect.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index 56c1f9d548..b1d08ec97b 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -29,7 +29,7 @@ def to_qlit(obj, level=3D0, suppress_first_indent=3DFal=
se):
                 for elt in obj]
         elts.append(indent(level + 1) + "{}")
         ret +=3D 'QLIT_QLIST(((QLitObject[]) {\n'
-        ret +=3D ',\n'.join(elts) + '\n'
+        ret +=3D '\n'.join(elts) + '\n'
         ret +=3D indent(level) + '}))'
     elif isinstance(obj, dict):
         elts =3D []
@@ -42,6 +42,8 @@ def to_qlit(obj, level=3D0, suppress_first_indent=3DFal=
se):
         ret +=3D indent(level) + '}))'
     else:
         assert False                # not implemented
+    if level > 0:
+        ret +=3D ','
     return ret
=20
=20
--=20
2.16.0.rc1.1.gef27df75a1
