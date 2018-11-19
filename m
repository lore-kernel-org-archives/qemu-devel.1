Received: from eggs.gnu.org ([2001:4830:134:3::10]:36687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOk50-0003ZC-1O
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:59:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOk4w-0006mk-PF
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:59:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gOk4w-0006mC-Jm
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:59:06 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon, 19 Nov 2018 13:59:03 +0000
Message-Id: <20181119135903.11729-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] qom: avoid reporting errors for NULL error
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

When debugging QEMU it is often useful to put a breakpoint on the
error_setg_internal method impl.

Unfortunately the object_property_add / object_class_property_add
methods call object_property_find / object_class_property_find methods
to check if a property exists already before adding the new property.

As a result there are a huge number of calls to error_setg_internal
on startup of most QEMU commands, making it very painful to set a
breakpoint on this method.

This puts a minor optimization on the code so that we avoid calling
error_setg() when errp is NULL. Functionally there's no difference
since error_setg() is a no-op when errp is NULL, but this lets us
use breakpoints in GDB in a practical way.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 qom/object.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 547dcf97c3..ddd5e7a30e 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1087,7 +1087,12 @@ ObjectProperty *object_property_find(Object *obj, =
const char *name,
         return prop;
     }
=20
-    error_setg(errp, "Property '.%s' not found", name);
+    /* Optimized to avoid calling error_setg if errp =3D=3D NULL
+     * otherwise every property add call hits error_setg
+     * making it impratical to set breakpoints in GDB */
+    if (errp) {
+        error_setg(errp, "Property '.%s' not found", name);
+    }
     return NULL;
 }
=20
@@ -1133,7 +1138,10 @@ ObjectProperty *object_class_property_find(ObjectC=
lass *klass, const char *name,
     }
=20
     prop =3D g_hash_table_lookup(klass->properties, name);
-    if (!prop) {
+    /* Optimized to avoid calling error_setg if errp =3D=3D NULL
+     * otherwise every property add call hits error_setg
+     * making it impratical to set breakpoints in GDB */
+    if (!prop && errp) {
         error_setg(errp, "Property '.%s' not found", name);
     }
     return prop;
--=20
2.19.1
