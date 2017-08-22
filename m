Received: from eggs.gnu.org ([2001:4830:134:3::10]:55186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9JL-000825-C6
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9JI-0006xN-38
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9JH-0006wk-SP
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:36 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:20 +0200
Message-Id: <20170822132255.23945-20-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 19/54] qapi: add #if/#endif helpers
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

Add helpers to generate #if/#endif and wrap visitor methods generating
code. Used in the following patches.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 86845a28f9..52099332f1 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1892,6 +1892,57 @@ def guardend(name):
                  name=3Dguardname(name))
=20
=20
+def gen_if(ifcond):
+    if not ifcond:
+        return ''
+    if isinstance(ifcond, str):
+        ifcond =3D [ifcond]
+    # Not using mcgen() because we don't want indent or \n stipped
+    ret =3D '\n'
+    for ifc in ifcond:
+        ret +=3D '#if %s\n' % ifc
+    ret +=3D '\n'
+    return ret
+
+
+def gen_endif(ifcond):
+    if not ifcond:
+        return ''
+    if isinstance(ifcond, str):
+        ifcond =3D [ifcond]
+    # Not using mcgen() because we don't want indent or \n stipped
+    ret =3D '\n'
+    for ifc in reversed(ifcond):
+        ret +=3D '#endif /* %s */\n' % ifc
+    ret +=3D '\n'
+    return ret
+
+
+# Wrap a method to add #if / #endif to generated code, only if some
+# code was generated.
+# self must have 'if_members' listing the attributes to wrap.
+# The last argument of the wrapped function must be the 'ifcond'.
+def ifcond_decorator(func):
+
+    def func_wrapper(self, *args, **kwargs):
+        ifcond =3D args[-1]
+        save =3D {}
+        for mem in self.if_members:
+            save[mem] =3D getattr(self, mem)
+        func(self, *args, **kwargs)
+        for mem, val in save.items():
+            newval =3D getattr(self, mem)
+            if newval !=3D val:
+                assert newval.startswith(val)
+                newval =3D newval[len(val):]
+                val +=3D gen_if(ifcond)
+                val +=3D newval
+                val +=3D gen_endif(ifcond)
+            setattr(self, mem, val)
+
+    return func_wrapper
+
+
 def gen_enum_lookup(name, values, prefix=3DNone):
     ret =3D mcgen('''
=20
--=20
2.14.1.146.gd35faa819
