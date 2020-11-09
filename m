Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA0AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:35:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A4BE206CB
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcd9trn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4BE206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcEoZ-0003wj-VC
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 16:35:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kcEg7-00041t-Oy
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 16:26:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22699)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kcEg5-0005cl-1e
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 16:26:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604957176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HNZ23P3owjXbOa0F7aY0nEo1VFpb+WZS7l4fYOJpfss=;
 b=gcd9trn+DL2TsdLGMjpCikyZk8LdmLb4LdRfWJRcATgahLvjLeUAF8IUZG5F+rU3ZHMzEs
 f4GEw7N+8wlwkknWcp5Xz+KdUdsBy/enMjNya5Ms9M/o+uU9CzozzUuV9pYE8P86I1BTWb
 fjwysqJmd5W27YmMMr0C7AkXQo1sDrI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-l2vnL5qpMxaYh-KnK_MLPQ-1; Mon, 09 Nov 2020 16:26:13 -0500
X-MC-Unique: l2vnL5qpMxaYh-KnK_MLPQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1913879517
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 21:26:12 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E13060BF1;
 Mon,  9 Nov 2020 21:26:12 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 8/8] qom: Use qlit to represent property defaults
Date: Mon,  9 Nov 2020 16:25:56 -0500
Message-Id: <20201109212556.3934583-9-ehabkost@redhat.com>
In-Reply-To: <20201109212556.3934583-1-ehabkost@redhat.com>
References: <20201109212556.3934583-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using QLitObject lets us get rid of most of the
.set_default_value functions, and just use
object_property_set_default() directly.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/qdev-properties-system.h   |  2 +-
 include/qom/field-property-internal.h |  4 ---
 include/qom/field-property.h          | 26 ++++++++-----------
 include/qom/property-types.h          | 21 +++++++---------
 hw/core/qdev-properties-system.c      |  8 ------
 qom/field-property.c                  | 27 ++++++++++++++------
 qom/property-types.c                  | 36 ++++-----------------------
 7 files changed, 44 insertions(+), 80 deletions(-)

diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
index 0ac327ae60..a586424a33 100644
--- a/include/hw/qdev-properties-system.h
+++ b/include/hw/qdev-properties-system.h
@@ -65,7 +65,7 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
 
 #define DEFINE_PROP_UUID(_name, _state, _field) \
     DEFINE_PROP(_name, _state, _field, qdev_prop_uuid, QemuUUID, \
-                .set_default = true)
+                .defval = QLIT_QSTR("auto"))
 
 #define DEFINE_PROP_AUDIODEV(_n, _s, _f) \
     DEFINE_PROP(_n, _s, _f, qdev_prop_audiodev, QEMUSoundCard)
diff --git a/include/qom/field-property-internal.h b/include/qom/field-property-internal.h
index 7aa27ce836..09877d9d6f 100644
--- a/include/qom/field-property-internal.h
+++ b/include/qom/field-property-internal.h
@@ -15,10 +15,6 @@ void field_prop_set_enum(Object *obj, Visitor *v, const char *name,
 
 void field_prop_set_default_value_enum(ObjectProperty *op,
                                        const Property *prop);
-void field_prop_set_default_value_int(ObjectProperty *op,
-                                      const Property *prop);
-void field_prop_set_default_value_uint(ObjectProperty *op,
-                                       const Property *prop);
 
 void field_prop_get_int32(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp);
diff --git a/include/qom/field-property.h b/include/qom/field-property.h
index bc866e1c93..b83b424a5e 100644
--- a/include/qom/field-property.h
+++ b/include/qom/field-property.h
@@ -6,6 +6,7 @@
 
 #include "qom/object.h"
 #include "qapi/util.h"
+#include "qapi/qmp/qlit.h"
 
 /**
  * struct Property: definition of a field property
@@ -29,21 +30,8 @@ struct Property {
     const PropertyInfo *info;
     ptrdiff_t    offset;
     uint8_t      bitnr;
-    /**
-     * @set_default: true if the default value should be set from @defval,
-     *    in which case @info->set_default_value must not be NULL
-     *    (if false then no default value is set by the property system
-     *     and the field retains whatever value it was given by instance_init).
-     */
-    bool         set_default;
-    /**
-     * @defval: default value for the property. This is used only if @set_default
-     *     is true.
-     */
-    union {
-        int64_t i;
-        uint64_t u;
-    } defval;
+    /** @defval: If not QNull, the default value for the property */
+    QLitObject defval;
     /* private: */
     int          arrayoffset;
     const PropertyInfo *arrayinfo;
@@ -63,7 +51,13 @@ struct PropertyInfo {
     const QEnumLookup *enum_table;
     /** @print: String formatting function, for the human monitor */
     int (*print)(Object *obj, Property *prop, char *dest, size_t len);
-    /** @set_default_value: Callback for initializing the default value */
+    /**
+     * @set_default_value: Optional callback for initializing the default value
+     *
+     * Most property types don't need to set this, as by default
+     * object_property_set_default() is called with the value at
+     * Property.defval.
+     */
     void (*set_default_value)(ObjectProperty *op, const Property *prop);
     /** @create: Optional callback for creation of property */
     ObjectProperty *(*create)(ObjectClass *oc, const char *name,
diff --git a/include/qom/property-types.h b/include/qom/property-types.h
index 3a36e1fec5..36ca6f9e55 100644
--- a/include/qom/property-types.h
+++ b/include/qom/property-types.h
@@ -5,6 +5,7 @@
 #define QOM_PROPERTY_TYPES_H
 
 #include "qom/field-property.h"
+#include "qapi/qmp/qlit.h"
 
 extern const PropertyInfo prop_info_bit;
 extern const PropertyInfo prop_info_bit64;
@@ -28,13 +29,14 @@ extern const PropertyInfo prop_info_link;
         .info      = &(_prop),                                   \
         .offset    = offsetof(_state, _field)                    \
             + type_check(_type, typeof_field(_state, _field)),   \
+        .defval = QLIT_QNULL,                                    \
+        /* Note that __VA_ARGS__ can still override .defval */   \
         __VA_ARGS__                                              \
         }
 
 #define DEFINE_PROP_SIGNED(_name, _state, _field, _defval, _prop, _type) \
     DEFINE_PROP(_name, _state, _field, _prop, _type,                     \
-                .set_default = true,                                     \
-                .defval.i    = (_type)_defval)
+                .defval = QLIT_QNUM_INT(_defval))
 
 #define DEFINE_PROP_SIGNED_NODEFAULT(_name, _state, _field, _prop, _type) \
     DEFINE_PROP(_name, _state, _field, _prop, _type)
@@ -50,13 +52,11 @@ extern const PropertyInfo prop_info_link;
 #define DEFINE_PROP_BIT(_name, _state, _field, _bit, _defval)   \
     DEFINE_PROP(_name, _state, _field, prop_info_bit, uint32_t, \
                 .bitnr       = (_bit),                          \
-                .set_default = true,                            \
-                .defval.u    = (bool)_defval)
+                .defval = QLIT_QBOOL(_defval))
 
 #define DEFINE_PROP_UNSIGNED(_name, _state, _field, _defval, _prop, _type) \
     DEFINE_PROP(_name, _state, _field, _prop, _type,                       \
-                .set_default = true,                                       \
-                .defval.u  = (_type)_defval)
+                .defval = QLIT_QNUM_UINT(_defval))
 
 #define DEFINE_PROP_UNSIGNED_NODEFAULT(_name, _state, _field, _prop, _type) \
     DEFINE_PROP(_name, _state, _field, _prop, _type)
@@ -72,8 +72,7 @@ extern const PropertyInfo prop_info_link;
 #define DEFINE_PROP_BIT64(_name, _state, _field, _bit, _defval)   \
     DEFINE_PROP(_name, _state, _field, prop_info_bit64, uint64_t, \
                 .bitnr    = (_bit),                               \
-                .set_default = true,                              \
-                .defval.u  = (bool)_defval)
+                .defval = QLIT_QBOOL(_defval))
 
 /**
  * DEFINE_PROP_BOOL:
@@ -84,8 +83,7 @@ extern const PropertyInfo prop_info_link;
  */
 #define DEFINE_PROP_BOOL(_name, _state, _field, _defval)     \
     DEFINE_PROP(_name, _state, _field, prop_info_bool, bool, \
-                .set_default = true,                         \
-                .defval.u    = (bool)_defval)
+                .defval = QLIT_QBOOL(_defval))
 
 #define PROP_ARRAY_LEN_PREFIX "len-"
 
@@ -118,8 +116,7 @@ extern const PropertyInfo prop_info_link;
                           _arrayfield, _arrayprop, _arraytype) \
     DEFINE_PROP((PROP_ARRAY_LEN_PREFIX _name),                 \
                 _state, _field, prop_info_arraylen, uint32_t,  \
-                .set_default = true,                           \
-                .defval.u = 0,                                 \
+                .defval = QLIT_QNUM_UINT(0),                   \
                 .arrayinfo = &(_arrayprop),                    \
                 .arrayfieldsize = sizeof(_arraytype),          \
                 .arrayoffset = offsetof(_state, _arrayfield))
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 8da68f076c..d9be5372f6 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -570,7 +570,6 @@ const PropertyInfo qdev_prop_blocksize = {
                    " and " MAX_BLOCK_SIZE_STR,
     .get   = field_prop_get_size32,
     .set   = set_blocksize,
-    .set_default_value = field_prop_set_default_value_uint,
 };
 
 /* --- Block device error handling policy --- */
@@ -768,7 +767,6 @@ const PropertyInfo qdev_prop_pci_devfn = {
     .print = print_pci_devfn,
     .get   = field_prop_get_int32,
     .set   = set_pci_devfn,
-    .set_default_value = field_prop_set_default_value_int,
 };
 
 /* --- pci host address --- */
@@ -1080,16 +1078,10 @@ static void set_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
     g_free(str);
 }
 
-static void set_default_uuid_auto(ObjectProperty *op, const Property *prop)
-{
-    object_property_set_default_str(op, UUID_VALUE_AUTO);
-}
-
 const PropertyInfo qdev_prop_uuid = {
     .name  = "str",
     .description = "UUID (aka GUID) or \"" UUID_VALUE_AUTO
         "\" for random value (default)",
     .get   = get_uuid,
     .set   = set_uuid,
-    .set_default_value = set_default_uuid_auto,
 };
diff --git a/qom/field-property.c b/qom/field-property.c
index 25a818bb69..727d7199ae 100644
--- a/qom/field-property.c
+++ b/qom/field-property.c
@@ -47,6 +47,20 @@ static ObjectPropertyAccessor *field_prop_setter(const PropertyInfo *info)
     return info->set ? field_prop_set : NULL;
 }
 
+static void field_prop_set_default_value(ObjectProperty *op,
+                                         Property *prop)
+{
+    if (qlit_type(&prop->defval) == QTYPE_QNULL) {
+        return;
+    }
+
+    if (prop->info->set_default_value) {
+        prop->info->set_default_value(op, prop);
+    } else {
+        object_property_set_default(op, qobject_from_qlit(&prop->defval));
+    }
+}
+
 ObjectProperty *
 object_property_add_field(Object *obj, const char *name, Property *prop,
                           ObjectPropertyAllowSet allow_set)
@@ -65,11 +79,9 @@ object_property_add_field(Object *obj, const char *name, Property *prop,
     object_property_set_description(obj, name,
                                     prop->info->description);
 
-    if (prop->set_default) {
-        prop->info->set_default_value(op, prop);
-        if (op->init) {
-            op->init(obj, op);
-        }
+    field_prop_set_default_value(op, prop);
+    if (op->init) {
+        op->init(obj, op);
     }
 
     op->allow_set = allow_set;
@@ -95,9 +107,8 @@ object_class_property_add_field(ObjectClass *oc, const char *name,
                                        prop->info->release,
                                        prop);
     }
-    if (prop->set_default) {
-        prop->info->set_default_value(op, prop);
-    }
+
+    field_prop_set_default_value(op, prop);
     if (prop->info->description) {
         object_class_property_set_description(oc, name,
                                               prop->info->description);
diff --git a/qom/property-types.c b/qom/property-types.c
index f566c05ec2..8bed83c712 100644
--- a/qom/property-types.c
+++ b/qom/property-types.c
@@ -28,8 +28,11 @@ void field_prop_set_enum(Object *obj, Visitor *v, const char *name,
 void field_prop_set_default_value_enum(ObjectProperty *op,
                                        const Property *prop)
 {
-    object_property_set_default_str(op,
-        qapi_enum_lookup(prop->info->enum_table, prop->defval.i));
+    QObject *defval = qobject_from_qlit(&prop->defval);
+    const char *str = qapi_enum_lookup(prop->info->enum_table,
+                                       qnum_get_int(qobject_to(QNum, defval)));
+    object_property_set_default_str(op, str);
+    qobject_unref(defval);
 }
 
 const PropertyInfo prop_info_enum = {
@@ -80,17 +83,11 @@ static void prop_set_bit(Object *obj, Visitor *v, const char *name,
     bit_prop_set(obj, prop, value);
 }
 
-static void set_default_value_bool(ObjectProperty *op, const Property *prop)
-{
-    object_property_set_default_bool(op, prop->defval.u);
-}
-
 const PropertyInfo prop_info_bit = {
     .name  = "bool",
     .description = "on/off",
     .get   = prop_get_bit,
     .set   = prop_set_bit,
-    .set_default_value = set_default_value_bool,
 };
 
 /* Bit64 */
@@ -139,7 +136,6 @@ const PropertyInfo prop_info_bit64 = {
     .description = "on/off",
     .get   = prop_get_bit64,
     .set   = prop_set_bit64,
-    .set_default_value = set_default_value_bool,
 };
 
 /* --- bool --- */
@@ -166,7 +162,6 @@ const PropertyInfo prop_info_bool = {
     .name  = "bool",
     .get   = get_bool,
     .set   = set_bool,
-    .set_default_value = set_default_value_bool,
 };
 
 /* --- 8bit integer --- */
@@ -189,23 +184,10 @@ static void set_uint8(Object *obj, Visitor *v, const char *name, void *opaque,
     visit_type_uint8(v, name, ptr, errp);
 }
 
-void field_prop_set_default_value_int(ObjectProperty *op,
-                                      const Property *prop)
-{
-    object_property_set_default_int(op, prop->defval.i);
-}
-
-void field_prop_set_default_value_uint(ObjectProperty *op,
-                                       const Property *prop)
-{
-    object_property_set_default_uint(op, prop->defval.u);
-}
-
 const PropertyInfo prop_info_uint8 = {
     .name  = "uint8",
     .get   = get_uint8,
     .set   = set_uint8,
-    .set_default_value = field_prop_set_default_value_uint,
 };
 
 /* --- 16bit integer --- */
@@ -232,7 +214,6 @@ const PropertyInfo prop_info_uint16 = {
     .name  = "uint16",
     .get   = get_uint16,
     .set   = set_uint16,
-    .set_default_value = field_prop_set_default_value_uint,
 };
 
 /* --- 32bit integer --- */
@@ -277,14 +258,12 @@ const PropertyInfo prop_info_uint32 = {
     .name  = "uint32",
     .get   = get_uint32,
     .set   = set_uint32,
-    .set_default_value = field_prop_set_default_value_uint,
 };
 
 const PropertyInfo prop_info_int32 = {
     .name  = "int32",
     .get   = field_prop_get_int32,
     .set   = set_int32,
-    .set_default_value = field_prop_set_default_value_int,
 };
 
 /* --- 64bit integer --- */
@@ -329,14 +308,12 @@ const PropertyInfo prop_info_uint64 = {
     .name  = "uint64",
     .get   = get_uint64,
     .set   = set_uint64,
-    .set_default_value = field_prop_set_default_value_uint,
 };
 
 const PropertyInfo prop_info_int64 = {
     .name  = "int64",
     .get   = get_int64,
     .set   = set_int64,
-    .set_default_value = field_prop_set_default_value_int,
 };
 
 /* --- string --- */
@@ -431,7 +408,6 @@ const PropertyInfo prop_info_size32 = {
     .name  = "size",
     .get = field_prop_get_size32,
     .set = set_size32,
-    .set_default_value = field_prop_set_default_value_uint,
 };
 
 /* --- support for array properties --- */
@@ -494,7 +470,6 @@ const PropertyInfo prop_info_arraylen = {
     .name = "uint32",
     .get = get_uint32,
     .set = set_prop_arraylen,
-    .set_default_value = field_prop_set_default_value_uint,
 };
 
 /* --- 64bit unsigned int 'size' type --- */
@@ -521,7 +496,6 @@ const PropertyInfo prop_info_size = {
     .name  = "size",
     .get = get_size,
     .set = set_size,
-    .set_default_value = field_prop_set_default_value_uint,
 };
 
 /* --- object link property --- */
-- 
2.28.0


