Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E54C432C3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:41:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E863720833
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFrpInsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E863720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibNbr-00034t-Ru
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 06:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNG4-00030a-PS
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:19:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNG0-0001fm-TC
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:19:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52166
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ibNG0-0001fM-Jd
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:19:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575199155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hiB1wTOw+I/v/WCXcO6jbMmPkmm7WpPvFYujbvJmha8=;
 b=JFrpInsGDhsXxon+YssJb2w71eaeXQC/gRLFbHl/RoYV6qJ9RbDaozmIGo4jSseEYPoKa3
 IjauJR8Sw8AshczRqSbbi+b4aK7G7dvkZzsxjltsA11CuVWDpe/OrYWq6l+sPtu8/BSpcA
 T1xlqR9Ga++361v6E0apI6R71GpwjKc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-srAWmO8ZMVSE9th7MxhZ6A-1; Sun, 01 Dec 2019 06:19:14 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1194E80183C
 for <qemu-devel@nongnu.org>; Sun,  1 Dec 2019 11:19:14 +0000 (UTC)
Received: from localhost (unknown [10.36.112.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9FD705C3FA;
 Sun,  1 Dec 2019 11:19:09 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 21/26] qdev: register properties as class properties
Date: Sun,  1 Dec 2019 15:15:26 +0400
Message-Id: <20191201111531.1136947-22-marcandre.lureau@redhat.com>
In-Reply-To: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
References: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: srAWmO8ZMVSE9th7MxhZ6A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use class properties facilities to add properties to the class during
device_class_set_props().

qdev_property_add_static() must be adapted as PropertyInfo now
operates with classes (and not instances), so we must
set_default_value() on the ObjectProperty, before calling its init()
method on the object instance.

Also, PropertyInfo.create() is now exclusively used for class
properties. Fortunately, qdev_property_add_static() is only used in
target/arm/cpu.c so far, which doesn't use "link" properties (that
require create()).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/core/qdev-properties.c | 38 ++++++++----------
 hw/core/qdev.c            | 83 ++++++++++++++++++++++-----------------
 include/hw/qdev-core.h    |  4 +-
 3 files changed, 65 insertions(+), 60 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 6271169d7d..3cb45931ac 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -73,12 +73,10 @@ static void set_enum(Object *obj, Visitor *v, const cha=
r *name, void *opaque,
     visit_type_enum(v, prop->name, ptr, prop->info->enum_table, errp);
 }
=20
-static void set_default_value_enum(Object *obj, const Property *prop)
+static void set_default_value_enum(ObjectProperty *op, const Property *pro=
p)
 {
-    object_property_set_str(obj,
-                            qapi_enum_lookup(prop->info->enum_table,
-                                             prop->defval.i),
-                            prop->name, &error_abort);
+    object_property_set_defaut_str(op,
+        qapi_enum_lookup(prop->info->enum_table, prop->defval.i));
 }
=20
 /* Bit */
@@ -132,9 +130,9 @@ static void prop_set_bit(Object *obj, Visitor *v, const=
 char *name,
     bit_prop_set(dev, prop, value);
 }
=20
-static void set_default_value_bool(Object *obj, const Property *prop)
+static void set_default_value_bool(ObjectProperty *op, const Property *pro=
p)
 {
-    object_property_set_bool(obj, prop->defval.u, prop->name, &error_abort=
);
+    object_property_set_defaut_bool(op, prop->defval.u);
 }
=20
 const PropertyInfo qdev_prop_bit =3D {
@@ -265,14 +263,14 @@ static void set_uint8(Object *obj, Visitor *v, const =
char *name, void *opaque,
     visit_type_uint8(v, name, ptr, errp);
 }
=20
-static void set_default_value_int(Object *obj, const Property *prop)
+static void set_default_value_int(ObjectProperty *op, const Property *prop=
)
 {
-    object_property_set_int(obj, prop->defval.i, prop->name, &error_abort)=
;
+    object_property_set_defaut_int(op, prop->defval.i);
 }
=20
-static void set_default_value_uint(Object *obj, const Property *prop)
+static void set_default_value_uint(ObjectProperty *op, const Property *pro=
p)
 {
-    object_property_set_uint(obj, prop->defval.u, prop->name, &error_abort=
);
+    object_property_set_defaut_uint(op, prop->defval.u);
 }
=20
 const PropertyInfo qdev_prop_uint8 =3D {
@@ -893,9 +891,9 @@ static void set_uuid(Object *obj, Visitor *v, const cha=
r *name, void *opaque,
     g_free(str);
 }
=20
-static void set_default_uuid_auto(Object *obj, const Property *prop)
+static void set_default_uuid_auto(ObjectProperty *op, const Property *prop=
)
 {
-    object_property_set_str(obj, UUID_VALUE_AUTO, prop->name, &error_abort=
);
+    object_property_set_defaut_str(op, UUID_VALUE_AUTO);
 }
=20
 const PropertyInfo qdev_prop_uuid =3D {
@@ -1211,15 +1209,13 @@ const PropertyInfo qdev_prop_size =3D {
=20
 /* --- object link property --- */
=20
-static void create_link_property(Object *obj, Property *prop, Error **errp=
)
+static void create_link_property(ObjectClass *oc, Property *prop, Error **=
errp)
 {
-    Object **child =3D qdev_get_prop_ptr(DEVICE(obj), prop);
-
-    object_property_add_link(obj, prop->name, prop->link_type,
-                             child,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_STRONG,
-                             errp);
+    object_class_property_add_link(oc, prop->name, prop->link_type,
+                                   prop->offset,
+                                   qdev_prop_allow_set_link_before_realize=
,
+                                   OBJ_PROP_LINK_STRONG,
+                                   errp);
 }
=20
 const PropertyInfo qdev_prop_link =3D {
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index dabf927eaa..7a73d50345 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -678,13 +678,11 @@ static void qdev_get_legacy_property(Object *obj, Vis=
itor *v,
 }
=20
 /**
- * qdev_property_add_legacy:
+ * qdev_class_add_legacy_property:
  * @dev: Device to add the property to.
  * @prop: The qdev property definition.
- * @errp: location to store error information.
  *
  * Add a legacy QOM property to @dev for qdev property @prop.
- * On error, store error in @errp.
  *
  * Legacy properties are string versions of QOM properties.  The format of
  * the string depends on the property type.  Legacy properties are only
@@ -693,52 +691,68 @@ static void qdev_get_legacy_property(Object *obj, Vis=
itor *v,
  * Do not use this in new code!  QOM Properties added through this interfa=
ce
  * will be given names in the "legacy" namespace.
  */
-static void qdev_property_add_legacy(DeviceState *dev, Property *prop,
-                                     Error **errp)
+static void qdev_class_add_legacy_property(DeviceClass *dc, Property *prop=
)
 {
-    gchar *name;
+    g_autofree char *name =3D NULL;
=20
     /* Register pointer properties as legacy properties */
     if (!prop->info->print && prop->info->get) {
         return;
     }
=20
-    if (prop->info->create) {
-        return;
-    }
-
     name =3D g_strdup_printf("legacy-%s", prop->name);
-    object_property_add(OBJECT(dev), name, "str",
-                        prop->info->print ? qdev_get_legacy_property : pro=
p->info->get,
-                        NULL,
-                        NULL,
-                        prop, errp);
-
-    g_free(name);
+    object_class_property_add(OBJECT_CLASS(dc), name, "str",
+        prop->info->print ? qdev_get_legacy_property : prop->info->get,
+        NULL, NULL, prop, &error_abort);
 }
=20
 void qdev_property_add_static(DeviceState *dev, Property *prop)
 {
     Object *obj =3D OBJECT(dev);
+    ObjectProperty *op;
=20
-    if (prop->info->create) {
-        prop->info->create(obj, prop, &error_abort);
-    } else {
-        object_property_add(obj, prop->name, prop->info->name,
-                            prop->info->get, prop->info->set,
-                            prop->info->release,
-                            prop, &error_abort);
-    }
+    assert(!prop->info->create);
+
+    op =3D object_property_add(obj, prop->name, prop->info->name,
+                             prop->info->get, prop->info->set,
+                             prop->info->release,
+                             prop, &error_abort);
=20
     object_property_set_description(obj, prop->name,
                                     prop->info->description,
                                     &error_abort);
=20
     if (prop->set_default) {
-        prop->info->set_default_value(obj, prop);
+        prop->info->set_default_value(op, prop);
+        if (op->init) {
+            op->init(obj, op);
+        }
     }
 }
=20
+static void qdev_class_add_property(DeviceClass *klass, Property *prop)
+{
+    ObjectClass *oc =3D OBJECT_CLASS(klass);
+
+    if (prop->info->create) {
+        prop->info->create(oc, prop, &error_abort);
+    } else {
+        ObjectProperty *op;
+
+        op =3D object_class_property_add(oc,
+                                       prop->name, prop->info->name,
+                                       prop->info->get, prop->info->set,
+                                       prop->info->release,
+                                       prop, &error_abort);
+        if (prop->set_default) {
+            prop->info->set_default_value(op, prop);
+        }
+    }
+    object_class_property_set_description(oc, prop->name,
+                                          prop->info->description,
+                                          &error_abort);
+}
+
 /* @qdev_alias_all_properties - Add alias properties to the source object =
for
  * all qdev properties on the target DeviceState.
  */
@@ -932,8 +946,6 @@ static bool device_get_hotplugged(Object *obj, Error **=
err)
 static void device_initfn(Object *obj)
 {
     DeviceState *dev =3D DEVICE(obj);
-    ObjectClass *class;
-    Property *prop;
=20
     if (qdev_hotplug) {
         dev->hotplugged =3D 1;
@@ -944,15 +956,6 @@ static void device_initfn(Object *obj)
     dev->realized =3D false;
     dev->allow_unplug_during_migration =3D false;
=20
-    class =3D object_get_class(OBJECT(dev));
-    do {
-        for (prop =3D DEVICE_CLASS(class)->props; prop && prop->name; prop=
++) {
-            qdev_property_add_legacy(dev, prop, &error_abort);
-            qdev_property_add_static(dev, prop);
-        }
-        class =3D object_class_get_parent(class);
-    } while (class !=3D object_class_by_name(TYPE_DEVICE));
-
     QLIST_INIT(&dev->gpios);
 }
=20
@@ -1055,7 +1058,13 @@ static void device_class_init(ObjectClass *class, vo=
id *data)
=20
 void device_class_set_props(DeviceClass *dc, Property *props)
 {
+    Property *prop;
+
     dc->props =3D props;
+    for (prop =3D dc->props; prop && prop->name; prop++) {
+        qdev_class_add_legacy_property(dc, prop);
+        qdev_class_add_property(dc, prop);
+    }
 }
=20
 void device_class_set_parent_reset(DeviceClass *dc,
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 4065162251..e3bdfb669f 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -258,8 +258,8 @@ struct PropertyInfo {
     const char *description;
     const QEnumLookup *enum_table;
     int (*print)(DeviceState *dev, Property *prop, char *dest, size_t len)=
;
-    void (*set_default_value)(Object *obj, const Property *prop);
-    void (*create)(Object *obj, Property *prop, Error **errp);
+    void (*set_default_value)(ObjectProperty *op, const Property *prop);
+    void (*create)(ObjectClass *oc, Property *prop, Error **errp);
     ObjectPropertyAccessor *get;
     ObjectPropertyAccessor *set;
     ObjectPropertyRelease *release;
--=20
2.24.0


