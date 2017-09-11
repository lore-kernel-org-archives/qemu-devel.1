Received: from eggs.gnu.org ([2001:4830:134:3::10]:42815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMYM-00057u-8J
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:07:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMYI-0006Ah-Ci
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:06:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1drMYI-0006AY-6q
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:06:54 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 11 Sep 2017 13:05:42 +0200
Message-Id: <20170911110623.24981-10-marcandre.lureau@redhat.com>
In-Reply-To: <20170911110623.24981-1-marcandre.lureau@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 09/50] qapi: add #if/#endif helpers
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

Add helpers to wrap generated code with #if/#endif lines.

Add a function decorator that will be used to wrap visitor methods.
The decorator will check if code was generated before adding #if/#endif
lines. Used in the following patches.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 55 insertions(+)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 2a8e60e975..94b735d8d6 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1897,6 +1897,61 @@ def guardend(name):
                  name=3Dguardname(name))
=20
=20
+def gen_if(ifcond):
+    if not ifcond:
+        return ''
+    if isinstance(ifcond, str):
+        ifcond =3D [ifcond]
+    ret =3D ''
+    for ifc in ifcond:
+        ret +=3D mcgen('''
+#if %(cond)s
+''', cond=3Difc)
+    return ret
+
+
+def gen_endif(ifcond):
+    if not ifcond:
+        return ''
+    if isinstance(ifcond, str):
+        ifcond =3D [ifcond]
+    ret =3D ''
+    for ifc in reversed(ifcond):
+        ret +=3D mcgen('''
+#endif /* %(cond)s */
+''', cond=3Difc)
+    return ret
+
+
+# Wrap a method to add #if / #endif to generated code, only if some
+# code was generated. The method must have an 'ifcond' argument.
+# self must have 'if_members' listing the attributes to wrap.
+def ifcond_decorator(func):
+
+    def func_wrapper(self, *args, **kwargs):
+        import inspect
+        idx =3D inspect.getargspec(func).args.index('ifcond')
+        ifcond =3D args[idx - 1]
+        save =3D {}
+        for mem in self.if_members:
+            save[mem] =3D getattr(self, mem)
+        func(self, *args, **kwargs)
+        for mem, val in save.items():
+            newval =3D getattr(self, mem)
+            if newval !=3D val:
+                assert newval.startswith(val)
+                newval =3D newval[len(val):]
+                if newval[0] =3D=3D '\n':
+                    val +=3D '\n'
+                    newval =3D newval[1:]
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
