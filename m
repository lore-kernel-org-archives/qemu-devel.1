Received: from eggs.gnu.org ([2001:4830:134:3::10]:50708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fNJOf-0008OA-1e
	for qemu-devel@nongnu.org; Mon, 28 May 2018 10:45:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fNJOZ-0005dG-Vw
	for qemu-devel@nongnu.org; Mon, 28 May 2018 10:45:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50106 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fNJOZ-0005cC-RP
	for qemu-devel@nongnu.org; Mon, 28 May 2018 10:45:11 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 28 May 2018 16:45:09 +0200
Message-Id: <20180528144509.15812-5-armbru@redhat.com>
In-Reply-To: <20180528144509.15812-1-armbru@redhat.com>
References: <20180528144509.15812-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 4/4] qdev: Remove DeviceClass::init() and
 ::exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: f4bug@amsat.org, ehabkost@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com, thuth@redhat.com

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Since no devices use it, we can safely remove it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180419212727.26095-5-f4bug@amsat.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Removal of DeviceClass::init() moved from previous patch, missing
documentation updates supplied]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/core/qdev.c         | 28 ----------------------------
 include/hw/qdev-core.h | 20 ++++----------------
 2 files changed, 4 insertions(+), 44 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index f6f92473b8..ffec461791 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -208,32 +208,6 @@ void device_listener_unregister(DeviceListener *list=
ener)
     QTAILQ_REMOVE(&device_listeners, listener, link);
 }
=20
-static void device_realize(DeviceState *dev, Error **errp)
-{
-    DeviceClass *dc =3D DEVICE_GET_CLASS(dev);
-
-    if (dc->init) {
-        int rc =3D dc->init(dev);
-        if (rc < 0) {
-            error_setg(errp, "Device initialization failed.");
-            return;
-        }
-    }
-}
-
-static void device_unrealize(DeviceState *dev, Error **errp)
-{
-    DeviceClass *dc =3D DEVICE_GET_CLASS(dev);
-
-    if (dc->exit) {
-        int rc =3D dc->exit(dev);
-        if (rc < 0) {
-            error_setg(errp, "Device exit failed.");
-            return;
-        }
-    }
-}
-
 void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
                                  int required_for_version)
 {
@@ -1065,8 +1039,6 @@ static void device_class_init(ObjectClass *class, v=
oid *data)
     DeviceClass *dc =3D DEVICE_CLASS(class);
=20
     class->unparent =3D device_unparent;
-    dc->realize =3D device_realize;
-    dc->unrealize =3D device_unrealize;
=20
     /* by default all devices were considered as hotpluggable,
      * so with intent to check it in generic qdev_unplug() /
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 9453588160..f1fd0f8736 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -29,8 +29,6 @@ typedef enum DeviceCategory {
     DEVICE_CATEGORY_MAX
 } DeviceCategory;
=20
-typedef int (*qdev_initfn)(DeviceState *dev);
-typedef int (*qdev_event)(DeviceState *dev);
 typedef void (*DeviceRealize)(DeviceState *dev, Error **errp);
 typedef void (*DeviceUnrealize)(DeviceState *dev, Error **errp);
 typedef void (*DeviceReset)(DeviceState *dev);
@@ -43,13 +41,9 @@ struct VMStateDescription;
  * DeviceClass:
  * @props: Properties accessing state fields.
  * @realize: Callback function invoked when the #DeviceState:realized
- * property is changed to %true. The default invokes @init if not %NULL.
+ * property is changed to %true.
  * @unrealize: Callback function invoked when the #DeviceState:realized
  * property is changed to %false.
- * @init: Callback function invoked when the #DeviceState::realized prop=
erty
- * is changed to %true. Deprecated, new types inheriting directly from
- * TYPE_DEVICE should use @realize instead, new leaf types should consul=
t
- * their respective parent type.
  * @hotpluggable: indicates if #DeviceClass is hotpluggable, available
  * as readonly "hotpluggable" property of #DeviceState instance
  *
@@ -73,19 +67,15 @@ struct VMStateDescription;
  * object_initialize() in their own #TypeInfo.instance_init and forward =
the
  * realization events appropriately.
  *
- * The @init callback is considered private to a particular bus implemen=
tation
- * (immediate abstract child types of TYPE_DEVICE). Derived leaf types s=
et an
- * "init" callback on their parent class instead.
- *
  * Any type may override the @realize and/or @unrealize callbacks but ne=
eds
  * to call the parent type's implementation if keeping their functionali=
ty
  * is desired. Refer to QOM documentation for further discussion and exa=
mples.
  *
  * <note>
  *   <para>
- * If a type derived directly from TYPE_DEVICE implements @realize, it d=
oes
- * not need to implement @init and therefore does not need to store and =
call
- * #DeviceClass' default @realize callback.
+ * Since TYPE_DEVICE doesn't implement @realize and @unrealize, types
+ * derived directly from it need not call their parent's @realize and
+ * @unrealize.
  * For other types consult the documentation and implementation of the
  * respective parent types.
  *   </para>
@@ -124,8 +114,6 @@ typedef struct DeviceClass {
     const struct VMStateDescription *vmsd;
=20
     /* Private to qdev / bus.  */
-    qdev_initfn init; /* TODO remove, once users are converted to realiz=
e */
-    qdev_event exit; /* TODO remove, once users are converted to unreali=
ze */
     const char *bus_type;
 } DeviceClass;
=20
--=20
2.13.6
