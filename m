Received: from eggs.gnu.org ([2001:4830:134:3::10]:33117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g04gp-0007Zk-WB
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:56:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g04gp-00088C-0b
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:56:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55040 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g04go-00087E-Pr
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:56:14 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 12 Sep 2018 16:55:27 +0400
Message-Id: <20180912125531.32131-6-marcandre.lureau@redhat.com>
In-Reply-To: <20180912125531.32131-1-marcandre.lureau@redhat.com>
References: <20180912125531.32131-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 5/9] qom/globals: generalize
 object_property_set_globals()
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

Handle calls of object_property_set_globals() with any object type,
but only apply globals to TYPE_DEVICE & TYPE_USER_CREATABLE.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qom/globals.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/qom/globals.c b/qom/globals.c
index 587f4a1b5c..8664baebe0 100644
--- a/qom/globals.c
+++ b/qom/globals.c
@@ -15,22 +15,28 @@ void object_property_register_global(GlobalProperty *=
prop)
=20
 void object_property_set_globals(Object *obj)
 {
-    DeviceState *dev =3D DEVICE(obj);
     GList *l;
+    DeviceState *dev =3D (DeviceState *)object_dynamic_cast(obj, TYPE_DE=
VICE);
+
+    if (!dev && !IS_USER_CREATABLE(obj)) {
+        /* only TYPE_DEVICE and TYPE_USER_CREATABLE support globals */
+        return;
+    }
=20
     for (l =3D global_props; l; l =3D l->next) {
         GlobalProperty *prop =3D l->data;
         Error *err =3D NULL;
=20
-        if (object_dynamic_cast(OBJECT(dev), prop->driver) =3D=3D NULL) =
{
+        if (object_dynamic_cast(obj, prop->driver) =3D=3D NULL) {
             continue;
         }
         prop->used =3D true;
-        object_property_parse(OBJECT(dev), prop->value, prop->property, =
&err);
+        object_property_parse(obj, prop->value, prop->property, &err);
         if (err !=3D NULL) {
             error_prepend(&err, "can't apply global %s.%s=3D%s: ",
                           prop->driver, prop->property, prop->value);
-            if (!dev->hotplugged && prop->errp) {
+
+            if (dev && !dev->hotplugged && prop->errp) {
                 error_propagate(prop->errp, err);
             } else {
                 assert(prop->user_provided);
@@ -56,15 +62,15 @@ int object_property_check_globals(void)
             continue;
         }
         oc =3D object_class_by_name(prop->driver);
-        oc =3D object_class_dynamic_cast(oc, TYPE_DEVICE);
-        if (!oc) {
+        dc =3D (DeviceClass *)object_class_dynamic_cast(oc, TYPE_DEVICE)=
;
+        if (!IS_USER_CREATABLE_CLASS(oc) && !dc) {
             warn_report("global %s.%s has invalid class name",
                         prop->driver, prop->property);
             ret =3D 1;
             continue;
         }
-        dc =3D DEVICE_CLASS(oc);
-        if (!dc->hotpluggable && !prop->used) {
+
+        if (dc && !dc->hotpluggable) {
             warn_report("global %s.%s=3D%s not used",
                         prop->driver, prop->property, prop->value);
             ret =3D 1;
--=20
2.19.0.rc1
