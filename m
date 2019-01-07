Received: from eggs.gnu.org ([209.51.188.92]:51029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ggU7L-0001Hp-Ol
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 07:34:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ggU7K-0003um-Uo
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 07:34:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ggU7K-0003rB-OT
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 07:34:54 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  7 Jan 2019 16:23:02 +0400
Message-Id: <20190107122304.22997-27-marcandre.lureau@redhat.com>
In-Reply-To: <20190107122304.22997-1-marcandre.lureau@redhat.com>
References: <20190107122304.22997-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 26/28] qdev-props: call
 object_apply_global_props()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

It's now possible to use the common function.

Teach object_apply_global_props() to warn if Error argument is NULL.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/qdev-properties.c | 24 ++----------------------
 qom/object.c              | 12 +++++++++++-
 2 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 5f9046b84a..5da1439a8b 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1223,28 +1223,8 @@ int qdev_prop_check_globals(void)
=20
 void qdev_prop_set_globals(DeviceState *dev)
 {
-    int i;
-
-    for (i =3D 0; i < global_props()->len; i++) {
-        GlobalProperty *prop;
-        Error *err =3D NULL;
-
-        prop =3D g_ptr_array_index(global_props(), i);
-        if (object_dynamic_cast(OBJECT(dev), prop->driver) =3D=3D NULL) =
{
-            continue;
-        }
-        prop->used =3D true;
-        object_property_parse(OBJECT(dev), prop->value, prop->property, =
&err);
-        if (err !=3D NULL) {
-            error_prepend(&err, "can't apply global %s.%s=3D%s: ",
-                          prop->driver, prop->property, prop->value);
-            if (!dev->hotplugged) {
-                error_propagate(&error_fatal, err);
-            } else {
-                warn_report_err(err);
-            }
-        }
-    }
+    object_apply_global_props(OBJECT(dev), global_props(),
+                              dev->hotplugged ? NULL : &error_fatal);
 }
=20
 /* --- 64bit unsigned int 'size' type --- */
diff --git a/qom/object.c b/qom/object.c
index dbdab0aead..aa6f3a2a71 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -390,7 +390,17 @@ void object_apply_global_props(Object *obj, const GP=
trArray *props, Error **errp
         if (err !=3D NULL) {
             error_prepend(&err, "can't apply global %s.%s=3D%s: ",
                           p->driver, p->property, p->value);
-            error_propagate(errp, err);
+            /*
+             * If errp !=3D NULL, propagate error and return.
+             * If errp =3D=3D NULL, report a warning, but keep going
+             * with the remaining globals.
+             */
+            if (errp) {
+                error_propagate(errp, err);
+                return;
+            } else {
+                warn_report_err(err);
+            }
         }
     }
 }
--=20
2.20.1.2.gb21ebb671b
