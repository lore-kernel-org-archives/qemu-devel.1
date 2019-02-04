Received: from eggs.gnu.org ([209.51.188.92]:57178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gqb8S-0007Pp-Om
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:05:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gqb8Q-0001LH-Pp
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:05:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gqb8O-0000zH-SF
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:05:49 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A98C53DE0F
	for <qemu-devel@nongnu.org>; Mon,  4 Feb 2019 09:57:31 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  4 Feb 2019 10:57:25 +0100
Message-Id: <20190204095725.27259-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] qemu-gdb: add a QObject pretty printer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, crosa@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Inspired by GObject/GType pretty printer.

Example:
machine_set_accel (obj=3D0x555556807550 [pc-i440fx-4.0-machine],...

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---

v2:
 - simplify python 2 compatibility code, suggested by Eduardo

scripts/qemu-gdb.py | 58 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 mode change 100644 =3D> 100755 scripts/qemu-gdb.py

diff --git a/scripts/qemu-gdb.py b/scripts/qemu-gdb.py
old mode 100644
new mode 100755
index 690827e6fc..1ec666e841
--- a/scripts/qemu-gdb.py
+++ b/scripts/qemu-gdb.py
@@ -21,6 +21,9 @@ import gdb
=20
 import os, sys
=20
+if sys.version_info[0] < 3:
+    int =3D long
+
 # Annoyingly, gdb doesn't put the directory of scripts onto the
 # module search path. Do it manually.
=20
@@ -47,3 +50,58 @@ coroutine.CoroutinePCFunction()
 # Default to silently passing through SIGUSR1, because QEMU sends it
 # to itself a lot.
 gdb.execute('handle SIGUSR1 pass noprint nostop')
+
+
+def is_object(val):
+    def is_object_helper(type):
+        if str(type) =3D=3D "Object":
+            return True
+
+        while type.code =3D=3D gdb.TYPE_CODE_TYPEDEF:
+            type =3D type.target()
+
+        if type.code !=3D gdb.TYPE_CODE_STRUCT:
+            return False
+
+        fields =3D type.fields()
+        if len (fields) < 1:
+            return False
+
+        first_field =3D fields[0]
+        return is_object_helper(first_field.type)
+
+    type =3D val.type
+    if type.code !=3D gdb.TYPE_CODE_PTR:
+        return False
+    type =3D type.target()
+    return is_object_helper (type)
+
+
+def object_class_name(instance):
+    try:
+        inst =3D instance.cast(gdb.lookup_type("Object").pointer())
+        klass =3D inst["class"]
+        typ =3D klass["type"]
+        return typ["name"].string()
+    except RuntimeError:
+        pass
+
+
+class QObjectPrinter:
+    def __init__(self, val):
+        self.val =3D val
+
+    def to_string(self):
+        name =3D object_class_name(self.val)
+        if name:
+            return ("0x%x [%s]")% (int(self.val), name)
+        return  ("0x%x") % (int(self.val))
+
+
+def lookup_type(val):
+    if is_object(val):
+        return QObjectPrinter(val)
+    return None
+
+
+gdb.pretty_printers.append(lookup_type)
--=20
2.20.1.98.gecbdaf0899
