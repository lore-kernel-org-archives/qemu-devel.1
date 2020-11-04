Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E69FC388F9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:16:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 605A52074B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTRYx0o9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605A52074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaLS5-0004cQ-BL
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 11:16:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLFT-00030M-Vv
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:03:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46623)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLFO-0005f3-OW
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604505772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q4HBX1Y9w8+tXKmIifZ7lHIrg14H1BX5cITXea4Z3us=;
 b=LTRYx0o9CiW8kBF53exYILrGHxtavivl+69J4jQcLeaatkHAlvCcHWwkZJFcgtls/CR2M9
 3AgkCSF+osMfW3TLU4dLrAW6XC3VjnflYOQ9GyBSsYpId6N2mBltJUc2kUtVqLFtSl79hV
 a6AmkSmlPMbh+TSHDUNg//k/Olh0hU0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-J9XAnrO_MNOrM-4l6hAEEw-1; Wed, 04 Nov 2020 11:02:49 -0500
X-MC-Unique: J9XAnrO_MNOrM-4l6hAEEw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F124B10A4D77;
 Wed,  4 Nov 2020 16:02:30 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 755C85DA6B;
 Wed,  4 Nov 2020 16:02:30 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 40/44] qdev: Move core field property code to QOM
Date: Wed,  4 Nov 2020 11:00:17 -0500
Message-Id: <20201104160021.2342108-41-ehabkost@redhat.com>
In-Reply-To: <20201104160021.2342108-1-ehabkost@redhat.com>
References: <20201104160021.2342108-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the core of the static property code to qom/field-property.c.

The actual property type implementations are still in
qdev-properties.c, they will be moved later.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Rename static-property.* to field-property.*
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 include/hw/qdev-properties.h                  |  71 +-----------
 .../qom/field-property-internal.h             |   6 +-
 include/qom/field-property.h                  |  79 +++++++++++++
 hw/core/qdev-properties-system.c              |   2 +-
 hw/core/qdev-properties.c                     | 104 +----------------
 qom/field-property.c                          | 108 ++++++++++++++++++
 qom/meson.build                               |   1 +
 7 files changed, 194 insertions(+), 177 deletions(-)
 rename hw/core/qdev-prop-internal.h => include/qom/field-property-internal.h (91%)
 create mode 100644 include/qom/field-property.h
 create mode 100644 qom/field-property.c

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 89c820eeb7..bee26d0319 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -2,52 +2,7 @@
 #define QEMU_QDEV_PROPERTIES_H
 
 #include "hw/qdev-core.h"
-
-/**
- * Property:
- * @set_default: true if the default value should be set from @defval,
- *    in which case @info->set_default_value must not be NULL
- *    (if false then no default value is set by the property system
- *     and the field retains whatever value it was given by instance_init).
- * @defval: default value for the property. This is used only if @set_default
- *     is true.
- */
-struct Property {
-    /**
-     * @qdev_prop_name: qdev property name
-     *
-     * qdev_prop_name is used only by TYPE_DEVICE code
-     * (device_class_set_props(), qdev_class_add_property(), and
-     * others).
-     */
-    const char   *qdev_prop_name;
-    const PropertyInfo *info;
-    ptrdiff_t    offset;
-    uint8_t      bitnr;
-    bool         set_default;
-    union {
-        int64_t i;
-        uint64_t u;
-    } defval;
-    int          arrayoffset;
-    const PropertyInfo *arrayinfo;
-    int          arrayfieldsize;
-    const char   *link_type;
-};
-
-struct PropertyInfo {
-    const char *name;
-    const char *description;
-    const QEnumLookup *enum_table;
-    int (*print)(Object *obj, Property *prop, char *dest, size_t len);
-    void (*set_default_value)(ObjectProperty *op, const Property *prop);
-    ObjectProperty *(*create)(ObjectClass *oc, const char *name,
-                              Property *prop);
-    ObjectPropertyAccessor *get;
-    ObjectPropertyAccessor *set;
-    ObjectPropertyRelease *release;
-};
-
+#include "qom/field-property.h"
 
 /*** qdev-properties.c ***/
 
@@ -227,28 +182,6 @@ extern const PropertyInfo prop_info_link;
 #define PROP_END_OF_LIST(...) \
     FIELD_PROP(DEFINE_PROP_END_OF_LIST(NULL, __VA_ARGS__))
 
-/**
- * object_class_property_add_field: Add a field property to object class
- * @oc: object class
- * @name: property name
- * @prop: property definition
- * @allow_set: check function called when property is set
- *
- * Add a field property to an object class.  A field property is
- * a property that will change a field at a specific offset of the
- * object instance struct.
- *
- * *@prop must exist for the life time of @oc.
- *
- * @allow_set should not be NULL.  If the property can always be
- * set, `prop_allow_set_always` can be used.  If the property can
- * never be set, `prop_allow_set_never` can be used.
- */
-ObjectProperty *
-object_class_property_add_field(ObjectClass *oc, const char *name,
-                                Property *prop,
-                                ObjectPropertyAllowSet allow_set);
-
 /*
  * Set properties between creation and realization.
  *
@@ -276,8 +209,6 @@ void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
                            const uint8_t *value);
 void qdev_prop_set_enum(DeviceState *dev, const char *name, int value);
 
-void *object_field_prop_ptr(Object *obj, Property *prop);
-
 void qdev_prop_register_global(GlobalProperty *prop);
 const GlobalProperty *qdev_find_global_prop(Object *obj,
                                             const char *name);
diff --git a/hw/core/qdev-prop-internal.h b/include/qom/field-property-internal.h
similarity index 91%
rename from hw/core/qdev-prop-internal.h
rename to include/qom/field-property-internal.h
index bdcb37f14f..7aa27ce836 100644
--- a/hw/core/qdev-prop-internal.h
+++ b/include/qom/field-property-internal.h
@@ -1,12 +1,12 @@
 /*
- * qdev property parsing
+ * QOM field property internal API (for implementing custom types)
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
 
-#ifndef HW_CORE_QDEV_PROP_INTERNAL_H
-#define HW_CORE_QDEV_PROP_INTERNAL_H
+#ifndef QOM_STATIC_PROPERTY_INTERNAL_H
+#define QOM_STATIC_PROPERTY_INTERNAL_H
 
 void field_prop_get_enum(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp);
diff --git a/include/qom/field-property.h b/include/qom/field-property.h
new file mode 100644
index 0000000000..bdc89b38a6
--- /dev/null
+++ b/include/qom/field-property.h
@@ -0,0 +1,79 @@
+/*
+ * QOM field property API
+ */
+#ifndef QOM_FIELD_PROPERTY_H
+#define QOM_FIELD_PROPERTY_H
+
+#include "qom/object.h"
+#include "qapi/util.h"
+
+/**
+ * Property:
+ * @set_default: true if the default value should be set from @defval,
+ *    in which case @info->set_default_value must not be NULL
+ *    (if false then no default value is set by the property system
+ *     and the field retains whatever value it was given by instance_init).
+ * @defval: default value for the property. This is used only if @set_default
+ *     is true.
+ */
+struct Property {
+    /**
+     * @qdev_prop_name: qdev property name
+     *
+     * qdev_prop_name is used only by TYPE_DEVICE code
+     * (device_class_set_props(), qdev_class_add_property(), and
+     * others).
+     */
+    const char   *qdev_prop_name;
+    const PropertyInfo *info;
+    ptrdiff_t    offset;
+    uint8_t      bitnr;
+    bool         set_default;
+    union {
+        int64_t i;
+        uint64_t u;
+    } defval;
+    int          arrayoffset;
+    const PropertyInfo *arrayinfo;
+    int          arrayfieldsize;
+    const char   *link_type;
+};
+
+struct PropertyInfo {
+    const char *name;
+    const char *description;
+    const QEnumLookup *enum_table;
+    int (*print)(Object *obj, Property *prop, char *dest, size_t len);
+    void (*set_default_value)(ObjectProperty *op, const Property *prop);
+    ObjectProperty *(*create)(ObjectClass *oc, const char *name,
+                              Property *prop);
+    ObjectPropertyAccessor *get;
+    ObjectPropertyAccessor *set;
+    ObjectPropertyRelease *release;
+};
+
+/**
+ * object_class_property_add_field: Add a field property to object class
+ * @oc: object class
+ * @name: property name
+ * @prop: property definition
+ * @allow_set: check function called when property is set
+ *
+ * Add a field property to an object class.  A field property is
+ * a property that will change a field at a specific offset of the
+ * object instance struct.
+ *
+ * *@prop must exist for the life time of @oc.
+ *
+ * @allow_set should not be NULL.  If the property can always be
+ * set, `prop_allow_set_always` can be used.  If the property can
+ * never be set, `prop_allow_set_never` can be used.
+ */
+ObjectProperty *
+object_class_property_add_field(ObjectClass *oc, const char *name,
+                                Property *prop,
+                                ObjectPropertyAllowSet allow_set);
+
+void *object_field_prop_ptr(Object *obj, Property *prop);
+
+#endif
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 8781b856d3..8da68f076c 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -24,7 +24,7 @@
 #include "qemu/units.h"
 #include "qemu/uuid.h"
 #include "qemu/error-report.h"
-#include "qdev-prop-internal.h"
+#include "qom/field-property-internal.h"
 
 #include "audio/audio.h"
 #include "chardev/char-fe.h"
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 64b803a200..b75730f15c 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -8,7 +8,7 @@
 #include "qapi/visitor.h"
 #include "qemu/units.h"
 #include "qemu/cutils.h"
-#include "qdev-prop-internal.h"
+#include "qom/field-property-internal.h"
 
 void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
                                   Error **errp)
@@ -50,48 +50,6 @@ void qdev_prop_allow_set_link_before_realize(const Object *obj,
     }
 }
 
-void *object_field_prop_ptr(Object *obj, Property *prop)
-{
-    void *ptr = obj;
-    ptr += prop->offset;
-    return ptr;
-}
-
-static void field_prop_get(Object *obj, Visitor *v, const char *name,
-                           void *opaque, Error **errp)
-{
-    Property *prop = opaque;
-    return prop->info->get(obj, v, name, opaque, errp);
-}
-
-/**
- * field_prop_getter: Return getter function to be used for property
- *
- * Return value can be NULL if @info has no getter function.
- */
-static ObjectPropertyAccessor *field_prop_getter(const PropertyInfo *info)
-{
-    return info->get ? field_prop_get : NULL;
-}
-
-static void field_prop_set(Object *obj, Visitor *v, const char *name,
-                           void *opaque, Error **errp)
-{
-    Property *prop = opaque;
-
-    return prop->info->set(obj, v, name, opaque, errp);
-}
-
-/**
- * field_prop_setter: Return setter function to be used for property
- *
- * Return value can be NULL if @info has not setter function.
- */
-static ObjectPropertyAccessor *field_prop_setter(const PropertyInfo *info)
-{
-    return info->set ? field_prop_set : NULL;
-}
-
 void field_prop_get_enum(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
@@ -801,66 +759,6 @@ const PropertyInfo prop_info_link = {
     .create = create_link_property,
 };
 
-ObjectProperty *
-object_property_add_field(Object *obj, const char *name, Property *prop,
-                          ObjectPropertyAllowSet allow_set)
-{
-    ObjectProperty *op;
-
-    assert(allow_set);
-    assert(!prop->info->create);
-
-    op = object_property_add(obj, name, prop->info->name,
-                             field_prop_getter(prop->info),
-                             field_prop_setter(prop->info),
-                             prop->info->release,
-                             prop);
-
-    object_property_set_description(obj, name,
-                                    prop->info->description);
-
-    if (prop->set_default) {
-        prop->info->set_default_value(op, prop);
-        if (op->init) {
-            op->init(obj, op);
-        }
-    }
-
-    op->allow_set = allow_set;
-    return op;
-}
-
-ObjectProperty *
-object_class_property_add_field(ObjectClass *oc, const char *name,
-                                Property *prop,
-                                ObjectPropertyAllowSet allow_set)
-{
-    ObjectProperty *op;
-
-    assert(allow_set);
-
-    if (prop->info->create) {
-        op = prop->info->create(oc, name, prop);
-    } else {
-        op = object_class_property_add(oc,
-                                       name, prop->info->name,
-                                       field_prop_getter(prop->info),
-                                       field_prop_setter(prop->info),
-                                       prop->info->release,
-                                       prop);
-    }
-    if (prop->set_default) {
-        prop->info->set_default_value(op, prop);
-    }
-    if (prop->info->description) {
-        object_class_property_set_description(oc, name,
-                                              prop->info->description);
-    }
-
-    op->allow_set = allow_set;
-    return op;
-}
-
 void qdev_property_add_static(DeviceState *dev, Property *prop)
 {
     object_property_add_field(OBJECT(dev), prop->qdev_prop_name, prop,
diff --git a/qom/field-property.c b/qom/field-property.c
new file mode 100644
index 0000000000..25a818bb69
--- /dev/null
+++ b/qom/field-property.c
@@ -0,0 +1,108 @@
+/*
+ * QOM field property API implementation
+ */
+#include "qemu/osdep.h"
+#include "qom/field-property.h"
+#include "qom/field-property-internal.h"
+
+void *object_field_prop_ptr(Object *obj, Property *prop)
+{
+    void *ptr = obj;
+    ptr += prop->offset;
+    return ptr;
+}
+
+static void field_prop_get(Object *obj, Visitor *v, const char *name,
+                           void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    return prop->info->get(obj, v, name, opaque, errp);
+}
+
+/**
+ * field_prop_getter: Return getter function to be used for property
+ *
+ * Return value can be NULL if @info has no getter function.
+ */
+static ObjectPropertyAccessor *field_prop_getter(const PropertyInfo *info)
+{
+    return info->get ? field_prop_get : NULL;
+}
+
+static void field_prop_set(Object *obj, Visitor *v, const char *name,
+                           void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+
+    return prop->info->set(obj, v, name, opaque, errp);
+}
+
+/**
+ * field_prop_setter: Return setter function to be used for property
+ *
+ * Return value can be NULL if @info has not setter function.
+ */
+static ObjectPropertyAccessor *field_prop_setter(const PropertyInfo *info)
+{
+    return info->set ? field_prop_set : NULL;
+}
+
+ObjectProperty *
+object_property_add_field(Object *obj, const char *name, Property *prop,
+                          ObjectPropertyAllowSet allow_set)
+{
+    ObjectProperty *op;
+
+    assert(allow_set);
+    assert(!prop->info->create);
+
+    op = object_property_add(obj, name, prop->info->name,
+                             field_prop_getter(prop->info),
+                             field_prop_setter(prop->info),
+                             prop->info->release,
+                             prop);
+
+    object_property_set_description(obj, name,
+                                    prop->info->description);
+
+    if (prop->set_default) {
+        prop->info->set_default_value(op, prop);
+        if (op->init) {
+            op->init(obj, op);
+        }
+    }
+
+    op->allow_set = allow_set;
+    return op;
+}
+
+ObjectProperty *
+object_class_property_add_field(ObjectClass *oc, const char *name,
+                                Property *prop,
+                                ObjectPropertyAllowSet allow_set)
+{
+    ObjectProperty *op;
+
+    assert(allow_set);
+
+    if (prop->info->create) {
+        op = prop->info->create(oc, name, prop);
+    } else {
+        op = object_class_property_add(oc,
+                                       name, prop->info->name,
+                                       field_prop_getter(prop->info),
+                                       field_prop_setter(prop->info),
+                                       prop->info->release,
+                                       prop);
+    }
+    if (prop->set_default) {
+        prop->info->set_default_value(op, prop);
+    }
+    if (prop->info->description) {
+        object_class_property_set_description(oc, name,
+                                              prop->info->description);
+    }
+
+    op->allow_set = allow_set;
+    return op;
+}
diff --git a/qom/meson.build b/qom/meson.build
index 062a3789d8..e83794454d 100644
--- a/qom/meson.build
+++ b/qom/meson.build
@@ -4,6 +4,7 @@ qom_ss.add(files(
   'object.c',
   'object_interfaces.c',
   'qom-qobject.c',
+  'field-property.c',
 ))
 
 qmp_ss.add(files('qom-qmp-cmds.c'))
-- 
2.28.0


