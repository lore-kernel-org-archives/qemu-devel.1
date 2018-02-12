Received: from eggs.gnu.org ([2001:4830:134:3::10]:38178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1el8RN-0000jG-DM
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:22:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1el8RK-0005vq-Mz
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:22:17 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43070 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1el8RK-0005uW-Cw
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:22:14 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 12 Feb 2018 08:22:05 +0100
Message-Id: <20180212072207.9367-13-armbru@redhat.com>
In-Reply-To: <20180212072207.9367-1-armbru@redhat.com>
References: <20180212072207.9367-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH RFC 12/14] qapi-introspect: modify to_qlit() to
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
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The following patch is going to break list entries with #if/#endif, so
they should have the trailing ',' as suffix.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/introspect.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index e5c491d936..c02df95e72 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -29,7 +29,7 @@ def to_qlit(obj, level=3D0, suppress_first_indent=3DFal=
se):
                 for elt in obj]
         elts.append(indent(level + 1) + "{}")
         ret =3D 'QLIT_QLIST(((QLitObject[]) {\n'
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
2.13.6
