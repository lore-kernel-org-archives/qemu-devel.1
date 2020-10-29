Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432C6C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:18:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 758B7206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFR+jV6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758B7206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYGF7-0006RJ-7Y
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 18:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG1e-0003uD-2b
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:04:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26893)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG1U-0006en-AK
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604009035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EZwRkpA4UFOU6kfQSPFytgZn4L9sDCp6w7eB/PgKLuc=;
 b=VFR+jV6vdHSZkzf9njM6D9PnCyzEv5hAiodCJnskbFrsr/u6niPM2vF1oLM7IFEpA2Adh3
 KBBmtXtLlW5sG0ijopGnBJO3TCPrM7L9g/vQgmYt7pQo6SElDHZ3LTiTrEptPF3rX+4xO1
 7dSvAwLTAmVFSf+OSSQU575bzLtGgiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-PmvdXd_2NK6wJm4HJzrdAg-1; Thu, 29 Oct 2020 18:03:53 -0400
X-MC-Unique: PmvdXd_2NK6wJm4HJzrdAg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D59B1842169
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 22:03:52 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E69475C1C4;
 Thu, 29 Oct 2020 22:03:51 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 28/36] qdev: Move core static property code to QOM
Date: Thu, 29 Oct 2020 18:02:38 -0400
Message-Id: <20201029220246.472693-29-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-1-ehabkost@redhat.com>
References: <20201029220246.472693-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
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
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the core of the static property code to qom/static-property.c.

The actual property type implementations are still in
qdev-properties.c, they will be moved later.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 include/hw/qdev-properties.h                  |  71 +----------
 .../qom/static-property-internal.h            |   6 +-
 include/qom/static-property.h                 |  79 ++++++++++++
 hw/core/qdev-properties-system.c              |   2 +-
 hw/core/qdev-properties.c                     | 110 +----------------
 qom/static-property.c                         | 114 ++++++++++++++++++
 qom/meson.build                               |   1 +
 7 files changed, 200 insertions(+), 183 deletions(-)
 rename hw/core/qdev-prop-internal.h => include/qom/static-property-internal.h (91%)
 create mode 100644 include/qom/static-property.h
 create mode 100644 qom/static-property.c

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index f9a4c132e7..e1ef466790 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -2,44 +2,7 @@
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
-    const char   *name;
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
-    ObjectProperty *(*create)(ObjectClass *oc, Property *prop);
-    ObjectPropertyAccessor *get;
-    ObjectPropertyAccessor *set;
-    ObjectPropertyRelease *release;
-};
-
+#include "qom/static-property.h"
 
 /*** qdev-properties.c ***/
 
@@ -172,36 +135,6 @@ extern const PropertyInfo qdev_prop_link;
 #define DEFINE_PROP_END_OF_LIST()               \
     {}
 
-/**
- * object_class_property_add_static: Add a static property to object class
- * @oc: object class
- * @prop: property definition
- * @allow_set: optional check function
- *
- * Add a property to an object class based on the property definition
- * at @prop.
- *
- * If @allow_set is NULL, the property will always be allowed to be set.
- *
- * The property definition at @prop should be defined using the
- * ``DEFINE_PROP`` family of macros.  *@prop must exist for the
- * life time of @oc.
- */
-ObjectProperty *
-object_class_property_add_static(ObjectClass *oc, Property *prop,
-                                 ObjectPropertyAllowSet allow_set);
-
-/**
- * object_class_add_static_props: Add multiple static properties to object class
- * @oc: object class
- * @props: property definition array, terminated by DEFINED_PROP_END_OF_LIST()
- * @allow_set: optional check function
- *
- * Add properties from @props using object_class_property_add_static()
- */
-void object_class_add_static_props(ObjectClass *oc, Property *props,
-                                   ObjectPropertyAllowSet allow_set);
-
 /*
  * Set properties between creation and realization.
  *
@@ -229,8 +162,6 @@ void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
                            const uint8_t *value);
 void qdev_prop_set_enum(DeviceState *dev, const char *name, int value);
 
-void *object_static_prop_ptr(Object *obj, Property *prop);
-
 void qdev_prop_register_global(GlobalProperty *prop);
 const GlobalProperty *qdev_find_global_prop(Object *obj,
                                             const char *name);
diff --git a/hw/core/qdev-prop-internal.h b/include/qom/static-property-internal.h
similarity index 91%
rename from hw/core/qdev-prop-internal.h
rename to include/qom/static-property-internal.h
index 41ec9e8942..7cde883a04 100644
--- a/hw/core/qdev-prop-internal.h
+++ b/include/qom/static-property-internal.h
@@ -1,12 +1,12 @@
 /*
- * qdev property parsing
+ * QOM static property internal API (for implementing custom types)
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
 
-#ifndef HW_CORE_QDEV_PROP_INTERNAL_H
-#define HW_CORE_QDEV_PROP_INTERNAL_H
+#ifndef QOM_STATIC_PROPERTY_INTERNAL_H
+#define QOM_STATIC_PROPERTY_INTERNAL_H
 
 void object_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp);
diff --git a/include/qom/static-property.h b/include/qom/static-property.h
new file mode 100644
index 0000000000..125ff06327
--- /dev/null
+++ b/include/qom/static-property.h
@@ -0,0 +1,79 @@
+/*
+ * QOM static property API
+ */
+#ifndef QOM_STATIC_PROPERTY_H
+#define QOM_STATIC_PROPERTY_H
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
+    const char   *name;
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
+    ObjectProperty *(*create)(ObjectClass *oc, Property *prop);
+    ObjectPropertyAccessor *get;
+    ObjectPropertyAccessor *set;
+    ObjectPropertyRelease *release;
+};
+
+/**
+ * object_class_property_add_static: Add a static property to object class
+ * @oc: object class
+ * @prop: property definition
+ * @allow_set: optional check function
+ *
+ * Add a property to an object class based on the property definition
+ * at @prop.
+ *
+ * If @allow_set is NULL, the property will always be allowed to be set.
+ *
+ * The property definition at @prop should be defined using the
+ * ``DEFINE_PROP`` family of macros.  *@prop must exist for the
+ * life time of @oc.
+ */
+ObjectProperty *
+object_class_property_add_static(ObjectClass *oc, Property *prop,
+                                 ObjectPropertyAllowSet allow_set);
+
+/**
+ * object_class_add_static_props: Add multiple static properties to object class
+ * @oc: object class
+ * @props: property definition array, terminated by DEFINED_PROP_END_OF_LIST()
+ * @allow_set: optional check function
+ *
+ * Add properties from @props using object_class_property_add_static()
+ */
+void object_class_add_static_props(ObjectClass *oc, Property *props,
+                                   ObjectPropertyAllowSet allow_set);
+
+void *object_static_prop_ptr(Object *obj, Property *prop);
+
+#endif
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 8cfa9a3d20..232ff955fa 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -23,7 +23,7 @@
 #include "qemu/cutils.h"
 #include "qemu/units.h"
 #include "qemu/error-report.h"
-#include "qdev-prop-internal.h"
+#include "qom/static-property-internal.h"
 
 #include "audio/audio.h"
 #include "chardev/char-fe.h"
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 0b53e5ba63..1b27ba7236 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -9,7 +9,7 @@
 #include "qemu/uuid.h"
 #include "qemu/units.h"
 #include "qemu/cutils.h"
-#include "qdev-prop-internal.h"
+#include "qom/static-property-internal.h"
 
 void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
                                   Error **errp)
@@ -51,48 +51,6 @@ void qdev_prop_allow_set_link_before_realize(const Object *obj,
     }
 }
 
-void *object_static_prop_ptr(Object *obj, Property *prop)
-{
-    void *ptr = obj;
-    ptr += prop->offset;
-    return ptr;
-}
-
-static void static_prop_get(Object *obj, Visitor *v, const char *name,
-                            void *opaque, Error **errp)
-{
-    Property *prop = opaque;
-    return prop->info->get(obj, v, name, opaque, errp);
-}
-
-/**
- * static_prop_getter: Return getter function to be used for property
- *
- * Return value can be NULL if @info has no getter function.
- */
-static ObjectPropertyAccessor *static_prop_getter(const PropertyInfo *info)
-{
-    return info->get ? static_prop_get : NULL;
-}
-
-static void static_prop_set(Object *obj, Visitor *v, const char *name,
-                            void *opaque, Error **errp)
-{
-    Property *prop = opaque;
-
-    return prop->info->set(obj, v, name, opaque, errp);
-}
-
-/**
- * static_prop_setter: Return setter function to be used for property
- *
- * Return value can be NULL if @info has not setter function.
- */
-static ObjectPropertyAccessor *static_prop_setter(const PropertyInfo *info)
-{
-    return info->set ? static_prop_set : NULL;
-}
-
 void object_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
@@ -907,72 +865,6 @@ const PropertyInfo qdev_prop_link = {
     .create = create_link_property,
 };
 
-ObjectProperty *
-object_property_add_static(Object *obj, Property *prop,
-                           ObjectPropertyAllowSet allow_set)
-{
-    ObjectProperty *op;
-
-    assert(!prop->info->create);
-
-    op = object_property_add(obj, prop->name, prop->info->name,
-                             static_prop_getter(prop->info),
-                             static_prop_setter(prop->info),
-                             prop->info->release,
-                             prop);
-
-    object_property_set_description(obj, prop->name,
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
-object_class_property_add_static(ObjectClass *oc, Property *prop,
-                                 ObjectPropertyAllowSet allow_set)
-{
-    ObjectProperty *op;
-
-    if (prop->info->create) {
-        op = prop->info->create(oc, prop);
-    } else {
-        op = object_class_property_add(oc,
-                                       prop->name, prop->info->name,
-                                       static_prop_getter(prop->info),
-                                       static_prop_setter(prop->info),
-                                       prop->info->release,
-                                       prop);
-    }
-    if (prop->set_default) {
-        prop->info->set_default_value(op, prop);
-    }
-    if (prop->info->description) {
-        object_class_property_set_description(oc, prop->name,
-                                            prop->info->description);
-    }
-
-    op->allow_set = allow_set;
-    return op;
-}
-
-void object_class_add_static_props(ObjectClass *oc, Property *props,
-                                   ObjectPropertyAllowSet allow_set)
-{
-    Property *prop;
-
-    for (prop = props; prop && prop->name; prop++) {
-        object_class_property_add_static(oc, prop, allow_set);
-    }
-}
-
 void qdev_property_add_static(DeviceState *dev, Property *prop)
 {
     object_property_add_static(OBJECT(dev), prop, qdev_prop_allow_set);
diff --git a/qom/static-property.c b/qom/static-property.c
new file mode 100644
index 0000000000..a9e0b8a48b
--- /dev/null
+++ b/qom/static-property.c
@@ -0,0 +1,114 @@
+/*
+ * QOM static property API implementation
+ */
+#include "qemu/osdep.h"
+#include "qom/static-property.h"
+#include "qom/static-property-internal.h"
+
+void *object_static_prop_ptr(Object *obj, Property *prop)
+{
+    void *ptr = obj;
+    ptr += prop->offset;
+    return ptr;
+}
+
+static void static_prop_get(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    return prop->info->get(obj, v, name, opaque, errp);
+}
+
+/**
+ * static_prop_getter: Return getter function to be used for property
+ *
+ * Return value can be NULL if @info has no getter function.
+ */
+static ObjectPropertyAccessor *static_prop_getter(const PropertyInfo *info)
+{
+    return info->get ? static_prop_get : NULL;
+}
+
+static void static_prop_set(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+
+    return prop->info->set(obj, v, name, opaque, errp);
+}
+
+/**
+ * static_prop_setter: Return setter function to be used for property
+ *
+ * Return value can be NULL if @info has not setter function.
+ */
+static ObjectPropertyAccessor *static_prop_setter(const PropertyInfo *info)
+{
+    return info->set ? static_prop_set : NULL;
+}
+
+ObjectProperty *
+object_property_add_static(Object *obj, Property *prop,
+                           ObjectPropertyAllowSet allow_set)
+{
+    ObjectProperty *op;
+
+    assert(!prop->info->create);
+
+    op = object_property_add(obj, prop->name, prop->info->name,
+                             static_prop_getter(prop->info),
+                             static_prop_setter(prop->info),
+                             prop->info->release,
+                             prop);
+
+    object_property_set_description(obj, prop->name,
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
+object_class_property_add_static(ObjectClass *oc, Property *prop,
+                                 ObjectPropertyAllowSet allow_set)
+{
+    ObjectProperty *op;
+
+    if (prop->info->create) {
+        op = prop->info->create(oc, prop);
+    } else {
+        op = object_class_property_add(oc,
+                                       prop->name, prop->info->name,
+                                       static_prop_getter(prop->info),
+                                       static_prop_setter(prop->info),
+                                       prop->info->release,
+                                       prop);
+    }
+    if (prop->set_default) {
+        prop->info->set_default_value(op, prop);
+    }
+    if (prop->info->description) {
+        object_class_property_set_description(oc, prop->name,
+                                            prop->info->description);
+    }
+
+    op->allow_set = allow_set;
+    return op;
+}
+
+void object_class_add_static_props(ObjectClass *oc, Property *props,
+                                   ObjectPropertyAllowSet allow_set)
+{
+    Property *prop;
+
+    for (prop = props; prop && prop->name; prop++) {
+        object_class_property_add_static(oc, prop, allow_set);
+    }
+}
diff --git a/qom/meson.build b/qom/meson.build
index 062a3789d8..aaebae66b4 100644
--- a/qom/meson.build
+++ b/qom/meson.build
@@ -4,6 +4,7 @@ qom_ss.add(files(
   'object.c',
   'object_interfaces.c',
   'qom-qobject.c',
+  'static-property.c',
 ))
 
 qmp_ss.add(files('qom-qmp-cmds.c'))
-- 
2.28.0


