Received: from eggs.gnu.org ([2001:4830:134:3::10]:38165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1el8RN-0000j9-BL
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:22:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1el8RK-0005ve-JI
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:22:17 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49854 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1el8RK-0005uU-Ck
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:22:14 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 12 Feb 2018 08:22:04 +0100
Message-Id: <20180212072207.9367-12-armbru@redhat.com>
In-Reply-To: <20180212072207.9367-1-armbru@redhat.com>
References: <20180212072207.9367-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH RFC 11/14] qapi: add #if/#endif helpers
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

Add helpers to wrap generated code with #if/#endif lines.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 1b254d5b32..1a78dfaf3f 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1973,6 +1973,24 @@ def guardend(name):
                  name=3Dguardname(name))
=20
=20
+def gen_if(ifcond):
+    ret =3D ''
+    for ifc in ifcond:
+        ret +=3D mcgen('''
+#if %(cond)s
+''', cond=3Difc)
+    return ret
+
+
+def gen_endif(ifcond):
+    ret =3D ''
+    for ifc in reversed(ifcond):
+        ret +=3D mcgen('''
+#endif /* %(cond)s */
+''', cond=3Difc)
+    return ret
+
+
 def gen_enum_lookup(name, values, prefix=3DNone):
     ret =3D mcgen('''
=20
--=20
2.13.6
