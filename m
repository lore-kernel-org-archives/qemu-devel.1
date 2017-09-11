Received: from eggs.gnu.org ([2001:4830:134:3::10]:42817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMYM-00058A-Gj
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:06:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMYL-0006Bd-Jl
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:06:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1drMYL-0006BL-Eh
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:06:57 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 11 Sep 2017 13:05:44 +0200
Message-Id: <20170911110623.24981-12-marcandre.lureau@redhat.com>
In-Reply-To: <20170911110623.24981-1-marcandre.lureau@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 11/50] qapi-introspect: modify to_qlit() to
 generate #if code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

The generator now accepts (obj, condition) tuples to wrap generated
QLit objects for 'obj' with #if/#endif conditions.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi-introspect.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index b1d08ec97b..dc70954e8a 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -17,6 +17,13 @@ def to_qlit(obj, level=3D0, suppress_first_indent=3DFa=
lse):
     def indent(level):
         return level * 4 * ' '
=20
+    if isinstance(obj, tuple):
+        ifobj, ifcond =3D obj
+        ret =3D gen_if(ifcond)
+        ret +=3D to_qlit(ifobj, level)
+        ret +=3D '\n' + gen_endif(ifcond)
+        return ret
+
     ret =3D ''
     if not suppress_first_indent:
         ret +=3D indent(level)
--=20
2.14.1.146.gd35faa819
