Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01220C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:31:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B08D721D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LIQ7v/of"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08D721D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufOX-0001OB-K1
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:31:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iucuZ-0001eQ-5K
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iucuX-0001Me-5C
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52297
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iucuX-0001MQ-0M
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=btLQyL+yd283t5WvK+tdG0NDcYL50a5N6l4RQUA+SwE=;
 b=LIQ7v/of/Fz861hSWtnig+qdIboHUtPJdZXPuMXqbMrCMFrDmAWEXeM/Oj4Lt9WZpeihK6
 UpEGJ6eKCx4Ea8noHqE3CqAsePJg5D45ulB4xJh4JIF3Ar6BENInCTec7kH2cE0o7ofHt5
 T6Izj9i3NR8H2zuCb5qBMCwr/JCs1Es=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-poqPct0bNWGBIqrkoYTt-g-1; Thu, 23 Jan 2020 08:52:38 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6634100EC8E
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:52:37 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C44C78575C;
 Thu, 23 Jan 2020 13:52:36 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 51/59] qdev: register properties as class properties
Date: Thu, 23 Jan 2020 14:50:41 +0100
Message-Id: <1579787449-27599-52-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: poqPct0bNWGBIqrkoYTt-g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

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
Message-Id: <20200110153039.1379601-22-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev-properties.c | 38 ++++++++++------------
 hw/core/qdev.c            | 83 ++++++++++++++++++++++++++-----------------=
----
 include/hw/qdev-core.h    |  4 +--
 3 files changed, 65 insertions(+), 60 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 43a9153..7f93bfe 100644
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
+    object_property_set_default_str(op,
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
+    object_property_set_default_bool(op, prop->defval.u);
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
+    object_property_set_default_int(op, prop->defval.i);
 }
=20
-static void set_default_value_uint(Object *obj, const Property *prop)
+static void set_default_value_uint(ObjectProperty *op, const Property *pro=
p)
 {
-    object_property_set_uint(obj, prop->defval.u, prop->name, &error_abort=
);
+    object_property_set_default_uint(op, prop->defval.u);
 }
=20
 const PropertyInfo qdev_prop_uint8 =3D {
@@ -925,9 +923,9 @@ static void set_uuid(Object *obj, Visitor *v, const cha=
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
+    object_property_set_default_str(op, UUID_VALUE_AUTO);
 }
=20
 const PropertyInfo qdev_prop_uuid =3D {
@@ -1243,15 +1241,13 @@ const PropertyInfo qdev_prop_size =3D {
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
index 6e4dca1..05c31df 100644
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
errp)
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
-        for (prop =3D DEVICE_CLASS(class)->props_; prop && prop->name; pro=
p++) {
-            qdev_property_add_legacy(dev, prop, &error_abort);
-            qdev_property_add_static(dev, prop);
-        }
-        class =3D object_class_get_parent(class);
-    } while (class !=3D object_class_by_name(TYPE_DEVICE));
-
     QLIST_INIT(&dev->gpios);
 }
=20
@@ -1065,7 +1068,13 @@ static void device_class_init(ObjectClass *class, vo=
id *data)
=20
 void device_class_set_props(DeviceClass *dc, Property *props)
 {
+    Property *prop;
+
     dc->props_ =3D props;
+    for (prop =3D props; prop && prop->name; prop++) {
+        qdev_class_add_legacy_property(dc, prop);
+        qdev_class_add_property(dc, prop);
+    }
 }
=20
 void device_class_set_parent_reset(DeviceClass *dc,
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 506ad35..5da94f8 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -263,8 +263,8 @@ struct PropertyInfo {
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
1.8.3.1



