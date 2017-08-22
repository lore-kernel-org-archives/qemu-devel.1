Received: from eggs.gnu.org ([2001:4830:134:3::10]:54744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9Hk-0006ba-SP
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:32:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9Hk-000642-49
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:32:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9Hj-00063O-TX
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:32:00 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:22 +0200
Message-Id: <20170822132255.23945-22-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 21/54] qapi-introspect: modify to_qlit() to
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

The generator now accepts (obj, condition) tuples to wrap generated
QLit objects with #if/#endif conditions.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi-introspect.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index dfb6d2ded4..9ef6f271d4 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -26,6 +26,12 @@ def to_qlit(obj, level=3D0, first_indent=3DTrue, suffi=
x=3D''):
         ret +=3D indent(level)
     if obj is None:
         ret +=3D 'QLIT_QNULL'
+    elif isinstance(obj, tuple):
+        obj, ifcond =3D obj
+        ret +=3D gen_if(ifcond)
+        ret +=3D to_qlit(obj, level, first_indent=3DFalse) + suffix
+        ret +=3D gen_endif(ifcond)
+        suffix =3D ''
     elif isinstance(obj, str):
         ret +=3D 'QLIT_QSTR(' + to_c_string(obj) + ')'
     elif isinstance(obj, list):
--=20
2.14.1.146.gd35faa819
