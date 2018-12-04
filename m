Received: from eggs.gnu.org ([2001:4830:134:3::10]:47529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUBZS-0004VI-EX
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:21:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUBZM-0006qw-Hs
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:21:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gUBZM-0006qT-9h
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:21:00 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  4 Dec 2018 18:20:07 +0400
Message-Id: <20181204142023.15982-4-marcandre.lureau@redhat.com>
In-Reply-To: <20181204142023.15982-1-marcandre.lureau@redhat.com>
References: <20181204142023.15982-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v5 03/19] qom: make
 user_creatable_complete() specific to UserCreatable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, ehabkost@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>

Instead of accepting any Object*, change user_creatable_complete() to
require a UserCreatable*. Modify the callers to pass the appropriate
argument, removing redundant dynamic cast checks in object creation.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/object_interfaces.h |  4 ++--
 hw/misc/ivshmem.c               |  2 +-
 hw/virtio/virtio-rng.c          |  2 +-
 qom/object.c                    | 12 ++++++++----
 qom/object_interfaces.c         | 14 +++-----------
 5 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfa=
ces.h
index 652a16d2ba..682ba1d9b0 100644
--- a/include/qom/object_interfaces.h
+++ b/include/qom/object_interfaces.h
@@ -51,14 +51,14 @@ typedef struct UserCreatableClass {
=20
 /**
  * user_creatable_complete:
- * @obj: the object whose complete() method is called if defined
+ * @uc: the user-creatable object whose complete() method is called if d=
efined
  * @errp: if an error occurs, a pointer to an area to store the error
  *
  * Wrapper to call complete() method if one of types it's inherited
  * from implements USER_CREATABLE interface, otherwise the call does
  * nothing.
  */
-void user_creatable_complete(Object *obj, Error **errp);
+void user_creatable_complete(UserCreatable *uc, Error **errp);
=20
 /**
  * user_creatable_can_be_deleted:
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index ecfd10a29a..8213659602 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -1280,7 +1280,7 @@ static void desugar_shm(IVShmemState *s)
     object_property_add_child(OBJECT(s), "internal-shm-backend", obj,
                               &error_abort);
     object_unref(obj);
-    user_creatable_complete(obj, &error_abort);
+    user_creatable_complete(USER_CREATABLE(obj), &error_abort);
     s->hostmem =3D MEMORY_BACKEND(obj);
 }
=20
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 855f1b41d1..30493a2586 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -191,7 +191,7 @@ static void virtio_rng_device_realize(DeviceState *de=
v, Error **errp)
     if (vrng->conf.rng =3D=3D NULL) {
         vrng->conf.default_backend =3D RNG_RANDOM(object_new(TYPE_RNG_RA=
NDOM));
=20
-        user_creatable_complete(OBJECT(vrng->conf.default_backend),
+        user_creatable_complete(USER_CREATABLE(vrng->conf.default_backen=
d),
                                 &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
diff --git a/qom/object.c b/qom/object.c
index 547dcf97c3..eb770dbf7f 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -417,6 +417,7 @@ void object_initialize_childv(Object *parentobj, cons=
t char *propname,
 {
     Error *local_err =3D NULL;
     Object *obj;
+    UserCreatable *uc;
=20
     object_initialize(childobj, size, type);
     obj =3D OBJECT(childobj);
@@ -431,8 +432,9 @@ void object_initialize_childv(Object *parentobj, cons=
t char *propname,
         goto out;
     }
=20
-    if (object_dynamic_cast(obj, TYPE_USER_CREATABLE)) {
-        user_creatable_complete(obj, &local_err);
+    uc =3D (UserCreatable *)object_dynamic_cast(obj, TYPE_USER_CREATABLE=
);
+    if (uc) {
+        user_creatable_complete(uc, &local_err);
         if (local_err) {
             object_unparent(obj);
             goto out;
@@ -590,6 +592,7 @@ Object *object_new_with_propv(const char *typename,
     Object *obj;
     ObjectClass *klass;
     Error *local_err =3D NULL;
+    UserCreatable *uc;
=20
     klass =3D object_class_by_name(typename);
     if (!klass) {
@@ -612,8 +615,9 @@ Object *object_new_with_propv(const char *typename,
         goto error;
     }
=20
-    if (object_dynamic_cast(obj, TYPE_USER_CREATABLE)) {
-        user_creatable_complete(obj, &local_err);
+    uc =3D (UserCreatable *)object_dynamic_cast(obj, TYPE_USER_CREATABLE=
);
+    if (uc) {
+        user_creatable_complete(uc, &local_err);
         if (local_err) {
             object_unparent(obj);
             goto error;
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 97b79b48bb..db85d1eb75 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -8,18 +8,10 @@
 #include "qapi/opts-visitor.h"
 #include "qemu/config-file.h"
=20
-void user_creatable_complete(Object *obj, Error **errp)
+void user_creatable_complete(UserCreatable *uc, Error **errp)
 {
+    UserCreatableClass *ucc =3D USER_CREATABLE_GET_CLASS(uc);
=20
-    UserCreatableClass *ucc;
-    UserCreatable *uc =3D
-        (UserCreatable *)object_dynamic_cast(obj, TYPE_USER_CREATABLE);
-
-    if (!uc) {
-        return;
-    }
-
-    ucc =3D USER_CREATABLE_GET_CLASS(uc);
     if (ucc->complete) {
         ucc->complete(uc, errp);
     }
@@ -89,7 +81,7 @@ Object *user_creatable_add_type(const char *type, const=
 char *id,
         goto out;
     }
=20
-    user_creatable_complete(obj, &local_err);
+    user_creatable_complete(USER_CREATABLE(obj), &local_err);
     if (local_err) {
         object_property_del(object_get_objects_root(),
                             id, &error_abort);
--=20
2.20.0.rc1
