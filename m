Received: from eggs.gnu.org ([2001:4830:134:3::10]:33157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g04h0-0007i8-C9
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:56:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g04gx-0008Fe-6C
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:56:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49722 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g04gx-0008E2-0K
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:56:23 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 12 Sep 2018 16:55:28 +0400
Message-Id: <20180912125531.32131-7-marcandre.lureau@redhat.com>
In-Reply-To: <20180912125531.32131-1-marcandre.lureau@redhat.com>
References: <20180912125531.32131-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 6/9] qom/object: set globals when initializing
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, dgilbert@redhat.com, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Set globals for all objects, although only TYPE_DEVICE &
TYPE_USER_CREATABLE can have globals for now.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/core/qdev.c | 6 ------
 qom/object.c   | 2 ++
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 473060b551..28c6c8d7c9 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -974,11 +974,6 @@ static void device_initfn(Object *obj)
     QLIST_INIT(&dev->gpios);
 }
=20
-static void device_post_init(Object *obj)
-{
-    object_property_set_globals(obj);
-}
-
 /* Unlink device from bus and free the structure.  */
 static void device_finalize(Object *obj)
 {
@@ -1103,7 +1098,6 @@ static const TypeInfo device_type_info =3D {
     .parent =3D TYPE_OBJECT,
     .instance_size =3D sizeof(DeviceState),
     .instance_init =3D device_initfn,
-    .instance_post_init =3D device_post_init,
     .instance_finalize =3D device_finalize,
     .class_base_init =3D device_class_base_init,
     .class_init =3D device_class_init,
diff --git a/qom/object.c b/qom/object.c
index 0703e8e4ff..025ad0e191 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -12,6 +12,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qom/globals.h"
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
 #include "qemu/cutils.h"
@@ -382,6 +383,7 @@ static void object_initialize_with_type(void *data, s=
ize_t size, TypeImpl *type)
     obj->properties =3D g_hash_table_new_full(g_str_hash, g_str_equal,
                                             NULL, object_property_free);
     object_init_with_type(obj, type);
+    object_property_set_globals(obj);
     object_post_init_with_type(obj, type);
 }
=20
--=20
2.19.0.rc1
