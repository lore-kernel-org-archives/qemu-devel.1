Received: from eggs.gnu.org ([2001:4830:134:3::10]:47665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUBZi-0004fE-8G
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:21:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUBZg-0006zE-Df
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:21:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gUBZg-0006z0-6Z
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:21:20 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  4 Dec 2018 18:20:10 +0400
Message-Id: <20181204142023.15982-7-marcandre.lureau@redhat.com>
In-Reply-To: <20181204142023.15982-1-marcandre.lureau@redhat.com>
References: <20181204142023.15982-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v5 06/19] qom: remove unimplemented
 class_finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, ehabkost@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>

Instead of trying to implement something that isn't well specified,
remove it. (it would be tricky to implement, since a class struct is
memcpy on children types...)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/object.h |  7 ++-----
 hw/core/machine.c    | 11 -----------
 qom/object.c         |  2 --
 3 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index f0b0bf39cc..0139838b69 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -455,10 +455,8 @@ struct Object
  *   parent class initialization has occurred, but before the class itse=
lf
  *   is initialized.  This is the function to use to undo the effects of
  *   memcpy from the parent class to the descendants.
- * @class_finalize: This function is called during class destruction and=
 is
- *   meant to release and dynamic parameters allocated by @class_init.
- * @class_data: Data to pass to the @class_init, @class_base_init and
- *   @class_finalize functions.  This can be useful when building dynami=
c
+ * @class_data: Data to pass to the @class_init,
+ *   @class_base_init. This can be useful when building dynamic
  *   classes.
  * @interfaces: The list of interfaces associated with this type.  This
  *   should point to a static array that's terminated with a zero filled
@@ -479,7 +477,6 @@ struct TypeInfo
=20
     void (*class_init)(ObjectClass *klass, void *data);
     void (*class_base_init)(ObjectClass *klass, void *data);
-    void (*class_finalize)(ObjectClass *klass, void *data);
     void *class_data;
=20
     InterfaceInfo *interfaces;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index da50ad6de7..c51423b647 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -834,16 +834,6 @@ void machine_run_board_init(MachineState *machine)
     machine_class->init(machine);
 }
=20
-static void machine_class_finalize(ObjectClass *klass, void *data)
-{
-    MachineClass *mc =3D MACHINE_CLASS(klass);
-
-    if (mc->compat_props) {
-        g_array_free(mc->compat_props, true);
-    }
-    g_free(mc->name);
-}
-
 void machine_register_compat_props(MachineState *machine)
 {
     MachineClass *mc =3D MACHINE_GET_CLASS(machine);
@@ -869,7 +859,6 @@ static const TypeInfo machine_info =3D {
     .class_size =3D sizeof(MachineClass),
     .class_init    =3D machine_class_init,
     .class_base_init =3D machine_class_base_init,
-    .class_finalize =3D machine_class_finalize,
     .instance_size =3D sizeof(MachineState),
     .instance_init =3D machine_initfn,
     .instance_finalize =3D machine_finalize,
diff --git a/qom/object.c b/qom/object.c
index eb770dbf7f..17921c0a71 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -49,7 +49,6 @@ struct TypeImpl
=20
     void (*class_init)(ObjectClass *klass, void *data);
     void (*class_base_init)(ObjectClass *klass, void *data);
-    void (*class_finalize)(ObjectClass *klass, void *data);
=20
     void *class_data;
=20
@@ -114,7 +113,6 @@ static TypeImpl *type_new(const TypeInfo *info)
=20
     ti->class_init =3D info->class_init;
     ti->class_base_init =3D info->class_base_init;
-    ti->class_finalize =3D info->class_finalize;
     ti->class_data =3D info->class_data;
=20
     ti->instance_init =3D info->instance_init;
--=20
2.20.0.rc1
