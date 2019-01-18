Received: from eggs.gnu.org ([209.51.188.92]:52447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gkUW1-0000HZ-Vw
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:48:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gkUVz-0003OO-Qn
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:48:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gkUVx-0003Im-SX
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:48:54 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 68D09C067831
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:48:50 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 18 Jan 2019 17:48:43 +0400
Message-Id: <20190118134843.28916-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] qemu-gdb: add a QObject pretty printer
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
 scripts/qemu-gdb.py | 58 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 mode change 100644 =3D> 100755 scripts/qemu-gdb.py

diff --git a/scripts/qemu-gdb.py b/scripts/qemu-gdb.py
old mode 100644
new mode 100755
index 690827e6fc6..90c6fd13b93
--- a/scripts/qemu-gdb.py
+++ b/scripts/qemu-gdb.py
@@ -21,6 +21,9 @@ import gdb
=20
 import os, sys
=20
+if sys.version_info[0] >=3D 3:
+    long =3D int
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
+            return ("0x%x [%s]")% (long(self.val), name)
+        return  ("0x%x") % (long(self.val))
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
