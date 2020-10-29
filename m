Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A129BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:27:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D7520729
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqPbK8L5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D7520729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYGOW-00026j-G2
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 18:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG1l-0003xP-TW
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:04:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45650)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG1b-0006fT-Oy
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604009041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7IMJp8wu1DOWBwwx/gtg4UHBliHUY0+W5uz2+SzU98U=;
 b=SqPbK8L5Em35w3vfLvDc3xJZKRsmln31qkMKatcVGOKMJqFwQlrpupw/kgUst9P9T9cKNP
 CU+xF1Cw7Sh/jV/Hb+TyNoA+SRA7OSCWjrYrfWCTdJWmg5dxzE4R+74jAWXncWVXpTKuLm
 mI4Yl2ODkn1yyW1BzF7y9D6bX+zQh64=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-8F8K1WzAObG_0h-HvQPlTA-1; Thu, 29 Oct 2020 18:03:59 -0400
X-MC-Unique: 8F8K1WzAObG_0h-HvQPlTA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AA5610E2184
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 22:03:58 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 96F4C1975F;
 Thu, 29 Oct 2020 22:03:57 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 32/36] qdev: Move base property types to qom/property-types.c
Date: Thu, 29 Oct 2020 18:02:42 -0400
Message-Id: <20201029220246.472693-33-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-1-ehabkost@redhat.com>
References: <20201029220246.472693-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move all property types from qdev-properties.c to
qom/property-types.c.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 include/hw/qdev-properties.h  | 130 -------
 include/qom/static-property.h | 128 +++++++
 hw/core/qdev-properties.c     | 642 ---------------------------------
 qom/property-types.c          | 649 ++++++++++++++++++++++++++++++++++
 qom/meson.build               |   1 +
 5 files changed, 778 insertions(+), 772 deletions(-)
 create mode 100644 qom/property-types.c

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 7a08946448..a4ac1e6972 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -4,136 +4,6 @@
 #include "hw/qdev-core.h"
 #include "qom/static-property.h"
 
-/*** qdev-properties.c ***/
-
-extern const PropertyInfo prop_info_bit;
-extern const PropertyInfo prop_info_bit64;
-extern const PropertyInfo prop_info_bool;
-extern const PropertyInfo prop_info_enum;
-extern const PropertyInfo prop_info_uint8;
-extern const PropertyInfo prop_info_uint16;
-extern const PropertyInfo prop_info_uint32;
-extern const PropertyInfo prop_info_int32;
-extern const PropertyInfo prop_info_uint64;
-extern const PropertyInfo prop_info_int64;
-extern const PropertyInfo prop_info_size;
-extern const PropertyInfo prop_info_string;
-extern const PropertyInfo prop_info_on_off_auto;
-extern const PropertyInfo prop_info_size32;
-extern const PropertyInfo prop_info_uuid;
-extern const PropertyInfo prop_info_arraylen;
-extern const PropertyInfo prop_info_link;
-
-#define DEFINE_PROP(_name, _state, _field, _prop, _type, ...) {  \
-        .name      = (_name),                                    \
-        .info      = &(_prop),                                   \
-        .offset    = offsetof(_state, _field)                    \
-            + type_check(_type, typeof_field(_state, _field)),   \
-        __VA_ARGS__                                              \
-        }
-
-#define DEFINE_PROP_SIGNED(_name, _state, _field, _defval, _prop, _type) \
-    DEFINE_PROP(_name, _state, _field, _prop, _type,                     \
-                .set_default = true,                                     \
-                .defval.i    = (_type)_defval)
-
-#define DEFINE_PROP_SIGNED_NODEFAULT(_name, _state, _field, _prop, _type) \
-    DEFINE_PROP(_name, _state, _field, _prop, _type)
-
-#define DEFINE_PROP_BIT(_name, _state, _field, _bit, _defval)   \
-    DEFINE_PROP(_name, _state, _field, prop_info_bit, uint32_t, \
-                .bitnr       = (_bit),                          \
-                .set_default = true,                            \
-                .defval.u    = (bool)_defval)
-
-#define DEFINE_PROP_UNSIGNED(_name, _state, _field, _defval, _prop, _type) \
-    DEFINE_PROP(_name, _state, _field, _prop, _type,                       \
-                .set_default = true,                                       \
-                .defval.u  = (_type)_defval)
-
-#define DEFINE_PROP_UNSIGNED_NODEFAULT(_name, _state, _field, _prop, _type) \
-    DEFINE_PROP(_name, _state, _field, _prop, _type)
-
-#define DEFINE_PROP_BIT64(_name, _state, _field, _bit, _defval)   \
-    DEFINE_PROP(_name, _state, _field, prop_info_bit64, uint64_t, \
-                .bitnr    = (_bit),                               \
-                .set_default = true,                              \
-                .defval.u  = (bool)_defval)
-
-#define DEFINE_PROP_BOOL(_name, _state, _field, _defval)     \
-    DEFINE_PROP(_name, _state, _field, prop_info_bool, bool, \
-                .set_default = true,                         \
-                .defval.u    = (bool)_defval)
-
-#define PROP_ARRAY_LEN_PREFIX "len-"
-
-/**
- * DEFINE_PROP_ARRAY:
- * @_name: name of the array
- * @_state: name of the device state structure type
- * @_field: uint32_t field in @_state to hold the array length
- * @_arrayfield: field in @_state (of type '@_arraytype *') which
- *               will point to the array
- * @_arrayprop: PropertyInfo defining what property the array elements have
- * @_arraytype: C type of the array elements
- *
- * Define device properties for a variable-length array _name.  A
- * static property "len-arrayname" is defined. When the device creator
- * sets this property to the desired length of array, further dynamic
- * properties "arrayname[0]", "arrayname[1]", ...  are defined so the
- * device creator can set the array element values. Setting the
- * "len-arrayname" property more than once is an error.
- *
- * When the array length is set, the @_field member of the device
- * struct is set to the array length, and @_arrayfield is set to point
- * to (zero-initialised) memory allocated for the array.  For a zero
- * length array, @_field will be set to 0 and @_arrayfield to NULL.
- * It is the responsibility of the device deinit code to free the
- * @_arrayfield memory.
- */
-#define DEFINE_PROP_ARRAY(_name, _state, _field,               \
-                          _arrayfield, _arrayprop, _arraytype) \
-    DEFINE_PROP((PROP_ARRAY_LEN_PREFIX _name),                 \
-                _state, _field, prop_info_arraylen, uint32_t,  \
-                .set_default = true,                           \
-                .defval.u = 0,                                 \
-                .arrayinfo = &(_arrayprop),                    \
-                .arrayfieldsize = sizeof(_arraytype),          \
-                .arrayoffset = offsetof(_state, _arrayfield))
-
-#define DEFINE_PROP_LINK(_name, _state, _field, _type, _ptr_type)     \
-    DEFINE_PROP(_name, _state, _field, prop_info_link, _ptr_type,     \
-                .link_type  = _type)
-
-#define DEFINE_PROP_UINT8(_n, _s, _f, _d)                       \
-    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_uint8, uint8_t)
-#define DEFINE_PROP_UINT16(_n, _s, _f, _d)                      \
-    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_uint16, uint16_t)
-#define DEFINE_PROP_UINT32(_n, _s, _f, _d)                      \
-    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_uint32, uint32_t)
-#define DEFINE_PROP_INT32(_n, _s, _f, _d)                      \
-    DEFINE_PROP_SIGNED(_n, _s, _f, _d, prop_info_int32, int32_t)
-#define DEFINE_PROP_UINT64(_n, _s, _f, _d)                      \
-    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_uint64, uint64_t)
-#define DEFINE_PROP_INT64(_n, _s, _f, _d)                      \
-    DEFINE_PROP_SIGNED(_n, _s, _f, _d, prop_info_int64, int64_t)
-#define DEFINE_PROP_SIZE(_n, _s, _f, _d)                       \
-    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_size, uint64_t)
-#define DEFINE_PROP_STRING(_n, _s, _f)             \
-    DEFINE_PROP(_n, _s, _f, prop_info_string, char*)
-#define DEFINE_PROP_ON_OFF_AUTO(_n, _s, _f, _d) \
-    DEFINE_PROP_SIGNED(_n, _s, _f, _d, prop_info_on_off_auto, OnOffAuto)
-#define DEFINE_PROP_SIZE32(_n, _s, _f, _d)                       \
-    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_size32, uint32_t)
-#define DEFINE_PROP_UUID(_name, _state, _field)                      \
-    DEFINE_PROP(_name, _state, _field, prop_info_uuid, QemuUUID,     \
-                .set_default = true)
-#define DEFINE_PROP_UUID_NODEFAULT(_name, _state, _field) \
-    DEFINE_PROP(_name, _state, _field, prop_info_uuid, QemuUUID)
-
-#define DEFINE_PROP_END_OF_LIST()               \
-    {}
-
 /*
  * Set properties between creation and realization.
  *
diff --git a/include/qom/static-property.h b/include/qom/static-property.h
index 125ff06327..779918c947 100644
--- a/include/qom/static-property.h
+++ b/include/qom/static-property.h
@@ -76,4 +76,132 @@ void object_class_add_static_props(ObjectClass *oc, Property *props,
 
 void *object_static_prop_ptr(Object *obj, Property *prop);
 
+extern const PropertyInfo prop_info_bit;
+extern const PropertyInfo prop_info_bit64;
+extern const PropertyInfo prop_info_bool;
+extern const PropertyInfo prop_info_enum;
+extern const PropertyInfo prop_info_uint8;
+extern const PropertyInfo prop_info_uint16;
+extern const PropertyInfo prop_info_uint32;
+extern const PropertyInfo prop_info_int32;
+extern const PropertyInfo prop_info_uint64;
+extern const PropertyInfo prop_info_int64;
+extern const PropertyInfo prop_info_size;
+extern const PropertyInfo prop_info_string;
+extern const PropertyInfo prop_info_on_off_auto;
+extern const PropertyInfo prop_info_size32;
+extern const PropertyInfo prop_info_uuid;
+extern const PropertyInfo prop_info_arraylen;
+extern const PropertyInfo prop_info_link;
+
+#define DEFINE_PROP(_name, _state, _field, _prop, _type, ...) {  \
+        .name      = (_name),                                    \
+        .info      = &(_prop),                                   \
+        .offset    = offsetof(_state, _field)                    \
+            + type_check(_type, typeof_field(_state, _field)),   \
+        __VA_ARGS__                                              \
+        }
+
+#define DEFINE_PROP_SIGNED(_name, _state, _field, _defval, _prop, _type) \
+    DEFINE_PROP(_name, _state, _field, _prop, _type,                     \
+                .set_default = true,                                     \
+                .defval.i    = (_type)_defval)
+
+#define DEFINE_PROP_SIGNED_NODEFAULT(_name, _state, _field, _prop, _type) \
+    DEFINE_PROP(_name, _state, _field, _prop, _type)
+
+#define DEFINE_PROP_BIT(_name, _state, _field, _bit, _defval)   \
+    DEFINE_PROP(_name, _state, _field, prop_info_bit, uint32_t, \
+                .bitnr       = (_bit),                          \
+                .set_default = true,                            \
+                .defval.u    = (bool)_defval)
+
+#define DEFINE_PROP_UNSIGNED(_name, _state, _field, _defval, _prop, _type) \
+    DEFINE_PROP(_name, _state, _field, _prop, _type,                       \
+                .set_default = true,                                       \
+                .defval.u  = (_type)_defval)
+
+#define DEFINE_PROP_UNSIGNED_NODEFAULT(_name, _state, _field, _prop, _type) \
+    DEFINE_PROP(_name, _state, _field, _prop, _type)
+
+#define DEFINE_PROP_BIT64(_name, _state, _field, _bit, _defval)   \
+    DEFINE_PROP(_name, _state, _field, prop_info_bit64, uint64_t, \
+                .bitnr    = (_bit),                               \
+                .set_default = true,                              \
+                .defval.u  = (bool)_defval)
+
+#define DEFINE_PROP_BOOL(_name, _state, _field, _defval)     \
+    DEFINE_PROP(_name, _state, _field, prop_info_bool, bool, \
+                .set_default = true,                         \
+                .defval.u    = (bool)_defval)
+
+#define PROP_ARRAY_LEN_PREFIX "len-"
+
+/**
+ * DEFINE_PROP_ARRAY:
+ * @_name: name of the array
+ * @_state: name of the device state structure type
+ * @_field: uint32_t field in @_state to hold the array length
+ * @_arrayfield: field in @_state (of type '@_arraytype *') which
+ *               will point to the array
+ * @_arrayprop: PropertyInfo defining what property the array elements have
+ * @_arraytype: C type of the array elements
+ *
+ * Define device properties for a variable-length array _name.  A
+ * static property "len-arrayname" is defined. When the device creator
+ * sets this property to the desired length of array, further dynamic
+ * properties "arrayname[0]", "arrayname[1]", ...  are defined so the
+ * device creator can set the array element values. Setting the
+ * "len-arrayname" property more than once is an error.
+ *
+ * When the array length is set, the @_field member of the device
+ * struct is set to the array length, and @_arrayfield is set to point
+ * to (zero-initialised) memory allocated for the array.  For a zero
+ * length array, @_field will be set to 0 and @_arrayfield to NULL.
+ * It is the responsibility of the device deinit code to free the
+ * @_arrayfield memory.
+ */
+#define DEFINE_PROP_ARRAY(_name, _state, _field,               \
+                          _arrayfield, _arrayprop, _arraytype) \
+    DEFINE_PROP((PROP_ARRAY_LEN_PREFIX _name),                 \
+                _state, _field, prop_info_arraylen, uint32_t,  \
+                .set_default = true,                           \
+                .defval.u = 0,                                 \
+                .arrayinfo = &(_arrayprop),                    \
+                .arrayfieldsize = sizeof(_arraytype),          \
+                .arrayoffset = offsetof(_state, _arrayfield))
+
+#define DEFINE_PROP_LINK(_name, _state, _field, _type, _ptr_type)     \
+    DEFINE_PROP(_name, _state, _field, prop_info_link, _ptr_type,     \
+                .link_type  = _type)
+
+#define DEFINE_PROP_UINT8(_n, _s, _f, _d)                       \
+    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_uint8, uint8_t)
+#define DEFINE_PROP_UINT16(_n, _s, _f, _d)                      \
+    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_uint16, uint16_t)
+#define DEFINE_PROP_UINT32(_n, _s, _f, _d)                      \
+    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_uint32, uint32_t)
+#define DEFINE_PROP_INT32(_n, _s, _f, _d)                      \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, prop_info_int32, int32_t)
+#define DEFINE_PROP_UINT64(_n, _s, _f, _d)                      \
+    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_uint64, uint64_t)
+#define DEFINE_PROP_INT64(_n, _s, _f, _d)                      \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, prop_info_int64, int64_t)
+#define DEFINE_PROP_SIZE(_n, _s, _f, _d)                       \
+    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_size, uint64_t)
+#define DEFINE_PROP_STRING(_n, _s, _f)             \
+    DEFINE_PROP(_n, _s, _f, prop_info_string, char*)
+#define DEFINE_PROP_ON_OFF_AUTO(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, prop_info_on_off_auto, OnOffAuto)
+#define DEFINE_PROP_SIZE32(_n, _s, _f, _d)                       \
+    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_size32, uint32_t)
+#define DEFINE_PROP_UUID(_name, _state, _field)                      \
+    DEFINE_PROP(_name, _state, _field, prop_info_uuid, QemuUUID,     \
+                .set_default = true)
+#define DEFINE_PROP_UUID_NODEFAULT(_name, _state, _field) \
+    DEFINE_PROP(_name, _state, _field, prop_info_uuid, QemuUUID)
+
+#define DEFINE_PROP_END_OF_LIST()               \
+    {}
+
 #endif
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 5b9907e8ba..c03842e89a 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -51,602 +51,6 @@ void qdev_prop_allow_set_link_before_realize(const Object *obj,
     }
 }
 
-void object_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
-                            void *opaque, Error **errp)
-{
-    Property *prop = opaque;
-    int *ptr = object_static_prop_ptr(obj, prop);
-
-    visit_type_enum(v, prop->name, ptr, prop->info->enum_table, errp);
-}
-
-void object_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
-                            void *opaque, Error **errp)
-{
-    Property *prop = opaque;
-    int *ptr = object_static_prop_ptr(obj, prop);
-
-    visit_type_enum(v, prop->name, ptr, prop->info->enum_table, errp);
-}
-
-void object_propinfo_set_default_value_enum(ObjectProperty *op,
-                                          const Property *prop)
-{
-    object_property_set_default_str(op,
-        qapi_enum_lookup(prop->info->enum_table, prop->defval.i));
-}
-
-const PropertyInfo prop_info_enum = {
-    .name  = "enum",
-    .get   = object_propinfo_get_enum,
-    .set   = object_propinfo_set_enum,
-    .set_default_value = object_propinfo_set_default_value_enum,
-};
-
-/* Bit */
-
-static uint32_t qdev_get_prop_mask(Property *prop)
-{
-    assert(prop->info == &prop_info_bit);
-    return 0x1 << prop->bitnr;
-}
-
-static void bit_prop_set(Object *obj, Property *props, bool val)
-{
-    uint32_t *p = object_static_prop_ptr(obj, props);
-    uint32_t mask = qdev_get_prop_mask(props);
-    if (val) {
-        *p |= mask;
-    } else {
-        *p &= ~mask;
-    }
-}
-
-static void prop_get_bit(Object *obj, Visitor *v, const char *name,
-                         void *opaque, Error **errp)
-{
-    Property *prop = opaque;
-    uint32_t *p = object_static_prop_ptr(obj, prop);
-    bool value = (*p & qdev_get_prop_mask(prop)) != 0;
-
-    visit_type_bool(v, name, &value, errp);
-}
-
-static void prop_set_bit(Object *obj, Visitor *v, const char *name,
-                         void *opaque, Error **errp)
-{
-    Property *prop = opaque;
-    bool value;
-
-    if (!visit_type_bool(v, name, &value, errp)) {
-        return;
-    }
-    bit_prop_set(obj, prop, value);
-}
-
-static void set_default_value_bool(ObjectProperty *op, const Property *prop)
-{
-    object_property_set_default_bool(op, prop->defval.u);
-}
-
-const PropertyInfo prop_info_bit = {
-    .name  = "bool",
-    .description = "on/off",
-    .get   = prop_get_bit,
-    .set   = prop_set_bit,
-    .set_default_value = set_default_value_bool,
-};
-
-/* Bit64 */
-
-static uint64_t qdev_get_prop_mask64(Property *prop)
-{
-    assert(prop->info == &prop_info_bit64);
-    return 0x1ull << prop->bitnr;
-}
-
-static void bit64_prop_set(Object *obj, Property *props, bool val)
-{
-    uint64_t *p = object_static_prop_ptr(obj, props);
-    uint64_t mask = qdev_get_prop_mask64(props);
-    if (val) {
-        *p |= mask;
-    } else {
-        *p &= ~mask;
-    }
-}
-
-static void prop_get_bit64(Object *obj, Visitor *v, const char *name,
-                           void *opaque, Error **errp)
-{
-    Property *prop = opaque;
-    uint64_t *p = object_static_prop_ptr(obj, prop);
-    bool value = (*p & qdev_get_prop_mask64(prop)) != 0;
-
-    visit_type_bool(v, name, &value, errp);
-}
-
-static void prop_set_bit64(Object *obj, Visitor *v, const char *name,
-                           void *opaque, Error **errp)
-{
-    Property *prop = opaque;
-    bool value;
-
-    if (!visit_type_bool(v, name, &value, errp)) {
-        return;
-    }
-    bit64_prop_set(obj, prop, value);
-}
-
-const PropertyInfo prop_info_bit64 = {
-    .name  = "bool",
-    .description = "on/off",
-    .get   = prop_get_bit64,
-    .set   = prop_set_bit64,
-    .set_default_value = set_default_value_bool,
-};
-
-/* --- bool --- */
-
-static void get_bool(Object *obj, Visitor *v, const char *name, void *opaque,
-                     Error **errp)
-{
-    Property *prop = opaque;
-    bool *ptr = object_static_prop_ptr(obj, prop);
-
-    visit_type_bool(v, name, ptr, errp);
-}
-
-static void set_bool(Object *obj, Visitor *v, const char *name, void *opaque,
-                     Error **errp)
-{
-    Property *prop = opaque;
-    bool *ptr = object_static_prop_ptr(obj, prop);
-
-    visit_type_bool(v, name, ptr, errp);
-}
-
-const PropertyInfo prop_info_bool = {
-    .name  = "bool",
-    .get   = get_bool,
-    .set   = set_bool,
-    .set_default_value = set_default_value_bool,
-};
-
-/* --- 8bit integer --- */
-
-static void get_uint8(Object *obj, Visitor *v, const char *name, void *opaque,
-                      Error **errp)
-{
-    Property *prop = opaque;
-    uint8_t *ptr = object_static_prop_ptr(obj, prop);
-
-    visit_type_uint8(v, name, ptr, errp);
-}
-
-static void set_uint8(Object *obj, Visitor *v, const char *name, void *opaque,
-                      Error **errp)
-{
-    Property *prop = opaque;
-    uint8_t *ptr = object_static_prop_ptr(obj, prop);
-
-    visit_type_uint8(v, name, ptr, errp);
-}
-
-void object_propinfo_set_default_value_int(ObjectProperty *op,
-                                         const Property *prop)
-{
-    object_property_set_default_int(op, prop->defval.i);
-}
-
-void object_propinfo_set_default_value_uint(ObjectProperty *op,
-                                          const Property *prop)
-{
-    object_property_set_default_uint(op, prop->defval.u);
-}
-
-const PropertyInfo prop_info_uint8 = {
-    .name  = "uint8",
-    .get   = get_uint8,
-    .set   = set_uint8,
-    .set_default_value = object_propinfo_set_default_value_uint,
-};
-
-/* --- 16bit integer --- */
-
-static void get_uint16(Object *obj, Visitor *v, const char *name,
-                       void *opaque, Error **errp)
-{
-    Property *prop = opaque;
-    uint16_t *ptr = object_static_prop_ptr(obj, prop);
-
-    visit_type_uint16(v, name, ptr, errp);
-}
-
-static void set_uint16(Object *obj, Visitor *v, const char *name,
-                       void *opaque, Error **errp)
-{
-    Property *prop = opaque;
-    uint16_t *ptr = object_static_prop_ptr(obj, prop);
-
-    visit_type_uint16(v, name, ptr, errp);
-}
-
-const PropertyInfo prop_info_uint16 = {
-    .name  = "uint16",
-    .get   = get_uint16,
-    .set   = set_uint16,
-    .set_default_value = object_propinfo_set_default_value_uint,
-};
-
-/* --- 32bit integer --- */
-
-static void get_uint32(Object *obj, Visitor *v, const char *name,
-                       void *opaque, Error **errp)
-{
-    Property *prop = opaque;
-    uint32_t *ptr = object_static_prop_ptr(obj, prop);
-
-    visit_type_uint32(v, name, ptr, errp);
-}
-
-static void set_uint32(Object *obj, Visitor *v, const char *name,
-                       void *opaque, Error **errp)
-{
-    Property *prop = opaque;
-    uint32_t *ptr = object_static_prop_ptr(obj, prop);
-
-    visit_type_uint32(v, name, ptr, errp);
-}
-
-void object_propinfo_get_int32(Object *obj, Visitor *v, const char *name,
-                             void *opaque, Error **errp)
-{
-    Property *prop = opaque;
-    int32_t *ptr = object_static_prop_ptr(obj, prop);
-
-    visit_type_int32(v, name, ptr, errp);
-}
-
-static void set_int32(Object *obj, Visitor *v, const char *name, void *opaque,
-                      Error **errp)
-{
-    Property *prop = opaque;
-    int32_t *ptr = object_static_prop_ptr(obj, prop);
-
-    visit_type_int32(v, name, ptr, errp);
-}
-
-const PropertyInfo prop_info_uint32 = {
-    .name  = "uint32",
-    .get   = get_uint32,
-    .set   = set_uint32,
-    .set_default_value = object_propinfo_set_default_value_uint,
-};
-
-const PropertyInfo prop_info_int32 = {
-    .name  = "int32",
-    .get   = object_propinfo_get_int32,
-    .set   = set_int32,
-    .set_default_value = object_propinfo_set_default_value_int,
-};
-
-/* --- 64bit integer --- */
-
-static void get_uint64(Object *obj, Visitor *v, const char *name,
-                       void *opaque, Error **errp)
-{
-    Property *prop = opaque;
-    uint64_t *ptr = object_static_prop_ptr(obj, prop);
-
-    visit_type_uint64(v, name, ptr, errp);
-}
-
-static void set_uint64(Object *obj, Visitor *v, const char *name,
-                       void *opaque, Error **errp)
-{
-    Property *prop = opaque;
-    uint64_t *ptr = object_static_prop_ptr(obj, prop);
-
-    visit_type_uint64(v, name, ptr, errp);
-}
-
-static void get_int64(Object *obj, Visitor *v, const char *name,
-                      void *opaque, Error **errp)
-{
-    Property *prop = opaque;
-    int64_t *ptr = object_static_prop_ptr(obj, prop);
-
-    visit_type_int64(v, name, ptr, errp);
-}
-
-static void set_int64(Object *obj, Visitor *v, const char *name,
-                      void *opaque, Error **errp)
-{
-    Property *prop = opaque;
-    int64_t *ptr = object_static_prop_ptr(obj, prop);
-
-    visit_type_int64(v, name, ptr, errp);
-}
-
-const PropertyInfo prop_info_uint64 = {
-    .name  = "uint64",
-    .get   = get_uint64,
-    .set   = set_uint64,
-    .set_default_value = object_propinfo_set_default_value_uint,
-};
-
-const PropertyInfo prop_info_int64 = {
-    .name  = "int64",
-    .get   = get_int64,
-    .set   = set_int64,
-    .set_default_value = object_propinfo_set_default_value_int,
-};
-
-/* --- string --- */
-
-static void release_string(Object *obj, const char *name, void *opaque)
-{
-    Property *prop = opaque;
-    g_free(*(char **)object_static_prop_ptr(obj, prop));
-}
-
-static void get_string(Object *obj, Visitor *v, const char *name,
-                       void *opaque, Error **errp)
-{
-    Property *prop = opaque;
-    char **ptr = object_static_prop_ptr(obj, prop);
-
-    if (!*ptr) {
-        char *str = (char *)"";
-        visit_type_str(v, name, &str, errp);
-    } else {
-        visit_type_str(v, name, ptr, errp);
-    }
-}
-
-static void set_string(Object *obj, Visitor *v, const char *name,
-                       void *opaque, Error **errp)
-{
-    Property *prop = opaque;
-    char **ptr = object_static_prop_ptr(obj, prop);
-    char *str;
-
-    if (!visit_type_str(v, name, &str, errp)) {
-        return;
-    }
-    g_free(*ptr);
-    *ptr = str;
-}
-
-const PropertyInfo prop_info_string = {
-    .name  = "str",
-    .release = release_string,
-    .get   = get_string,
-    .set   = set_string,
-};
-
-/* --- on/off/auto --- */
-
-const PropertyInfo prop_info_on_off_auto = {
-    .name = "OnOffAuto",
-    .description = "on/off/auto",
-    .enum_table = &OnOffAuto_lookup,
-    .get = object_propinfo_get_enum,
-    .set = object_propinfo_set_enum,
-    .set_default_value = object_propinfo_set_default_value_enum,
-};
-
-/* --- 32bit unsigned int 'size' type --- */
-
-void object_propinfo_get_size32(Object *obj, Visitor *v, const char *name,
-                              void *opaque, Error **errp)
-{
-    Property *prop = opaque;
-    uint32_t *ptr = object_static_prop_ptr(obj, prop);
-    uint64_t value = *ptr;
-
-    visit_type_size(v, name, &value, errp);
-}
-
-static void set_size32(Object *obj, Visitor *v, const char *name, void *opaque,
-                       Error **errp)
-{
-    Property *prop = opaque;
-    uint32_t *ptr = object_static_prop_ptr(obj, prop);
-    uint64_t value;
-
-    if (!visit_type_size(v, name, &value, errp)) {
-        return;
-    }
-
-    if (value > UINT32_MAX) {
-        error_setg(errp,
-                   "Property %s.%s doesn't take value %" PRIu64
-                   " (maximum: %u)",
-                   object_get_typename(obj), name, value, UINT32_MAX);
-        return;
-    }
-
-    *ptr = value;
-}
-
-const PropertyInfo prop_info_size32 = {
-    .name  = "size",
-    .get = object_propinfo_get_size32,
-    .set = set_size32,
-    .set_default_value = object_propinfo_set_default_value_uint,
-};
-
-/* --- UUID --- */
-
-static void get_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
-                     Error **errp)
-{
-    Property *prop = opaque;
-    QemuUUID *uuid = object_static_prop_ptr(obj, prop);
-    char buffer[UUID_FMT_LEN + 1];
-    char *p = buffer;
-
-    qemu_uuid_unparse(uuid, buffer);
-
-    visit_type_str(v, name, &p, errp);
-}
-
-#define UUID_VALUE_AUTO        "auto"
-
-static void set_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
-                    Error **errp)
-{
-    Property *prop = opaque;
-    QemuUUID *uuid = object_static_prop_ptr(obj, prop);
-    char *str;
-
-    if (!visit_type_str(v, name, &str, errp)) {
-        return;
-    }
-
-    if (!strcmp(str, UUID_VALUE_AUTO)) {
-        qemu_uuid_generate(uuid);
-    } else if (qemu_uuid_parse(str, uuid) < 0) {
-        error_setg(errp, "invalid UUID: '%s'", str);
-    }
-    g_free(str);
-}
-
-static void set_default_uuid_auto(ObjectProperty *op, const Property *prop)
-{
-    object_property_set_default_str(op, UUID_VALUE_AUTO);
-}
-
-const PropertyInfo prop_info_uuid = {
-    .name  = "str",
-    .description = "UUID (aka GUID) or \"" UUID_VALUE_AUTO
-        "\" for random value (default)",
-    .get   = get_uuid,
-    .set   = set_uuid,
-    .set_default_value = set_default_uuid_auto,
-};
-
-/* --- support for array properties --- */
-
-/* Used as an opaque for the object properties we add for each
- * array element. Note that the struct Property must be first
- * in the struct so that a pointer to this works as the opaque
- * for the underlying element's property hooks as well as for
- * our own release callback.
- */
-typedef struct {
-    struct Property prop;
-    char *propname;
-    ObjectPropertyRelease *release;
-} ArrayElementProperty;
-
-/**
- * Create ArrayElementProperty based on array length property
- * @array_len_prop (which was previously defined using DEFINE_PROP_ARRAY()).
- */
-static ArrayElementProperty *array_element_new(Object *obj,
-                                               Property *array_len_prop,
-                                               const char *arrayname,
-                                               int index,
-                                               void *eltptr)
-{
-    char *propname = g_strdup_printf("%s[%d]", arrayname, index);
-    ArrayElementProperty *arrayprop = g_new0(ArrayElementProperty, 1);
-    arrayprop->propname = propname;
-    arrayprop->prop.info = array_len_prop->arrayinfo;
-    arrayprop->prop.name = propname;
-    /* This ugly piece of pointer arithmetic sets up the offset so
-     * that when the underlying get/set hooks call qdev_get_prop_ptr
-     * they get the right answer despite the array element not actually
-     * being inside the device struct.
-     */
-    arrayprop->prop.offset = eltptr - (void *)obj;
-    assert(object_static_prop_ptr(obj, &arrayprop->prop) == eltptr);
-    return arrayprop;
-}
-
-/* object property release callback for array element properties:
- * we call the underlying element's property release hook, and
- * then free the memory we allocated when we added the property.
- */
-static void array_element_release(Object *obj, const char *name, void *opaque)
-{
-    ArrayElementProperty *p = opaque;
-    if (p->release) {
-        p->release(obj, name, opaque);
-    }
-    g_free(p->propname);
-    g_free(p);
-}
-
-static void object_property_add_array_element(Object *obj,
-                                              Property *array_len_prop,
-                                              ArrayElementProperty *prop)
-{
-    ObjectProperty *array_op = object_property_find(obj, array_len_prop->name);
-    ObjectProperty *op = object_property_add_static(obj, &prop->prop,
-                                                    array_op->allow_set);
-
-    assert((void *)prop == (void *)&prop->prop);
-    prop->release = op->release;
-    /* array_element_release() will call the original release function */
-    op->release = array_element_release;
-}
-
-static void set_prop_arraylen(Object *obj, Visitor *v, const char *name,
-                              void *opaque, Error **errp)
-{
-    /* Setter for the property which defines the length of a
-     * variable-sized property array. As well as actually setting the
-     * array-length field in the device struct, we have to create the
-     * array itself and dynamically add the corresponding properties.
-     */
-    Property *prop = opaque;
-    uint32_t *alenptr = object_static_prop_ptr(obj, prop);
-    void **arrayptr = (void *)obj + prop->arrayoffset;
-    void *eltptr;
-    const char *arrayname;
-    int i;
-
-    if (*alenptr) {
-        error_setg(errp, "array size property %s may not be set more than once",
-                   name);
-        return;
-    }
-    if (!visit_type_uint32(v, name, alenptr, errp)) {
-        return;
-    }
-    if (!*alenptr) {
-        return;
-    }
-
-    /* DEFINE_PROP_ARRAY guarantees that name should start with this prefix;
-     * strip it off so we can get the name of the array itself.
-     */
-    assert(strncmp(name, PROP_ARRAY_LEN_PREFIX,
-                   strlen(PROP_ARRAY_LEN_PREFIX)) == 0);
-    arrayname = name + strlen(PROP_ARRAY_LEN_PREFIX);
-
-    /* Note that it is the responsibility of the individual device's deinit
-     * to free the array proper.
-     */
-    *arrayptr = eltptr = g_malloc0(*alenptr * prop->arrayfieldsize);
-    for (i = 0; i < *alenptr; i++, eltptr += prop->arrayfieldsize) {
-        ArrayElementProperty *elt_prop = array_element_new(obj, prop, arrayname,
-                                                           i, eltptr);
-        object_property_add_array_element(obj, prop, elt_prop);
-    }
-}
-
-const PropertyInfo prop_info_arraylen = {
-    .name = "uint32",
-    .get = get_uint32,
-    .set = set_prop_arraylen,
-    .set_default_value = object_propinfo_set_default_value_uint,
-};
-
 /* --- public helpers --- */
 
 static Property *qdev_prop_walk(Property *props, const char *name)
@@ -819,52 +223,6 @@ void qdev_prop_set_globals(DeviceState *dev)
                               dev->hotplugged ? NULL : &error_fatal);
 }
 
-/* --- 64bit unsigned int 'size' type --- */
-
-static void get_size(Object *obj, Visitor *v, const char *name, void *opaque,
-                     Error **errp)
-{
-    Property *prop = opaque;
-    uint64_t *ptr = object_static_prop_ptr(obj, prop);
-
-    visit_type_size(v, name, ptr, errp);
-}
-
-static void set_size(Object *obj, Visitor *v, const char *name, void *opaque,
-                     Error **errp)
-{
-    Property *prop = opaque;
-    uint64_t *ptr = object_static_prop_ptr(obj, prop);
-
-    visit_type_size(v, name, ptr, errp);
-}
-
-const PropertyInfo prop_info_size = {
-    .name  = "size",
-    .get = get_size,
-    .set = set_size,
-    .set_default_value = object_propinfo_set_default_value_uint,
-};
-
-/* --- object link property --- */
-
-static ObjectProperty *create_link_property(ObjectClass *oc, Property *prop)
-{
-    /*
-     * NOTE: object_property_allow_set_link is unconditional, but
-     *       ObjectProperty.allow_set may be set for the property too.
-     */
-    return object_class_property_add_link(oc, prop->name, prop->link_type,
-                                          prop->offset,
-                                          object_property_allow_set_link,
-                                          OBJ_PROP_LINK_STRONG);
-}
-
-const PropertyInfo prop_info_link = {
-    .name = "link",
-    .create = create_link_property,
-};
-
 void qdev_property_add_static(DeviceState *dev, Property *prop)
 {
     object_property_add_static(OBJECT(dev), prop, qdev_prop_allow_set);
diff --git a/qom/property-types.c b/qom/property-types.c
new file mode 100644
index 0000000000..55d8759f06
--- /dev/null
+++ b/qom/property-types.c
@@ -0,0 +1,649 @@
+#include "qemu/osdep.h"
+#include "qom/static-property.h"
+#include "qom/static-property-internal.h"
+#include "qapi/qapi-types-common.h"
+#include "qapi/visitor.h"
+#include "qapi/error.h"
+#include "qemu/uuid.h"
+
+void object_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    int *ptr = object_static_prop_ptr(obj, prop);
+
+    visit_type_enum(v, prop->name, ptr, prop->info->enum_table, errp);
+}
+
+void object_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    int *ptr = object_static_prop_ptr(obj, prop);
+
+    visit_type_enum(v, prop->name, ptr, prop->info->enum_table, errp);
+}
+
+void object_propinfo_set_default_value_enum(ObjectProperty *op,
+                                          const Property *prop)
+{
+    object_property_set_default_str(op,
+        qapi_enum_lookup(prop->info->enum_table, prop->defval.i));
+}
+
+const PropertyInfo prop_info_enum = {
+    .name  = "enum",
+    .get   = object_propinfo_get_enum,
+    .set   = object_propinfo_set_enum,
+    .set_default_value = object_propinfo_set_default_value_enum,
+};
+
+/* Bit */
+
+static uint32_t qdev_get_prop_mask(Property *prop)
+{
+    assert(prop->info == &prop_info_bit);
+    return 0x1 << prop->bitnr;
+}
+
+static void bit_prop_set(Object *obj, Property *props, bool val)
+{
+    uint32_t *p = object_static_prop_ptr(obj, props);
+    uint32_t mask = qdev_get_prop_mask(props);
+    if (val) {
+        *p |= mask;
+    } else {
+        *p &= ~mask;
+    }
+}
+
+static void prop_get_bit(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    uint32_t *p = object_static_prop_ptr(obj, prop);
+    bool value = (*p & qdev_get_prop_mask(prop)) != 0;
+
+    visit_type_bool(v, name, &value, errp);
+}
+
+static void prop_set_bit(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    bool value;
+
+    if (!visit_type_bool(v, name, &value, errp)) {
+        return;
+    }
+    bit_prop_set(obj, prop, value);
+}
+
+static void set_default_value_bool(ObjectProperty *op, const Property *prop)
+{
+    object_property_set_default_bool(op, prop->defval.u);
+}
+
+const PropertyInfo prop_info_bit = {
+    .name  = "bool",
+    .description = "on/off",
+    .get   = prop_get_bit,
+    .set   = prop_set_bit,
+    .set_default_value = set_default_value_bool,
+};
+
+/* Bit64 */
+
+static uint64_t qdev_get_prop_mask64(Property *prop)
+{
+    assert(prop->info == &prop_info_bit64);
+    return 0x1ull << prop->bitnr;
+}
+
+static void bit64_prop_set(Object *obj, Property *props, bool val)
+{
+    uint64_t *p = object_static_prop_ptr(obj, props);
+    uint64_t mask = qdev_get_prop_mask64(props);
+    if (val) {
+        *p |= mask;
+    } else {
+        *p &= ~mask;
+    }
+}
+
+static void prop_get_bit64(Object *obj, Visitor *v, const char *name,
+                           void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    uint64_t *p = object_static_prop_ptr(obj, prop);
+    bool value = (*p & qdev_get_prop_mask64(prop)) != 0;
+
+    visit_type_bool(v, name, &value, errp);
+}
+
+static void prop_set_bit64(Object *obj, Visitor *v, const char *name,
+                           void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    bool value;
+
+    if (!visit_type_bool(v, name, &value, errp)) {
+        return;
+    }
+    bit64_prop_set(obj, prop, value);
+}
+
+const PropertyInfo prop_info_bit64 = {
+    .name  = "bool",
+    .description = "on/off",
+    .get   = prop_get_bit64,
+    .set   = prop_set_bit64,
+    .set_default_value = set_default_value_bool,
+};
+
+/* --- bool --- */
+
+static void get_bool(Object *obj, Visitor *v, const char *name, void *opaque,
+                     Error **errp)
+{
+    Property *prop = opaque;
+    bool *ptr = object_static_prop_ptr(obj, prop);
+
+    visit_type_bool(v, name, ptr, errp);
+}
+
+static void set_bool(Object *obj, Visitor *v, const char *name, void *opaque,
+                     Error **errp)
+{
+    Property *prop = opaque;
+    bool *ptr = object_static_prop_ptr(obj, prop);
+
+    visit_type_bool(v, name, ptr, errp);
+}
+
+const PropertyInfo prop_info_bool = {
+    .name  = "bool",
+    .get   = get_bool,
+    .set   = set_bool,
+    .set_default_value = set_default_value_bool,
+};
+
+/* --- 8bit integer --- */
+
+static void get_uint8(Object *obj, Visitor *v, const char *name, void *opaque,
+                      Error **errp)
+{
+    Property *prop = opaque;
+    uint8_t *ptr = object_static_prop_ptr(obj, prop);
+
+    visit_type_uint8(v, name, ptr, errp);
+}
+
+static void set_uint8(Object *obj, Visitor *v, const char *name, void *opaque,
+                      Error **errp)
+{
+    Property *prop = opaque;
+    uint8_t *ptr = object_static_prop_ptr(obj, prop);
+
+    visit_type_uint8(v, name, ptr, errp);
+}
+
+void object_propinfo_set_default_value_int(ObjectProperty *op,
+                                         const Property *prop)
+{
+    object_property_set_default_int(op, prop->defval.i);
+}
+
+void object_propinfo_set_default_value_uint(ObjectProperty *op,
+                                          const Property *prop)
+{
+    object_property_set_default_uint(op, prop->defval.u);
+}
+
+const PropertyInfo prop_info_uint8 = {
+    .name  = "uint8",
+    .get   = get_uint8,
+    .set   = set_uint8,
+    .set_default_value = object_propinfo_set_default_value_uint,
+};
+
+/* --- 16bit integer --- */
+
+static void get_uint16(Object *obj, Visitor *v, const char *name,
+                       void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    uint16_t *ptr = object_static_prop_ptr(obj, prop);
+
+    visit_type_uint16(v, name, ptr, errp);
+}
+
+static void set_uint16(Object *obj, Visitor *v, const char *name,
+                       void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    uint16_t *ptr = object_static_prop_ptr(obj, prop);
+
+    visit_type_uint16(v, name, ptr, errp);
+}
+
+const PropertyInfo prop_info_uint16 = {
+    .name  = "uint16",
+    .get   = get_uint16,
+    .set   = set_uint16,
+    .set_default_value = object_propinfo_set_default_value_uint,
+};
+
+/* --- 32bit integer --- */
+
+static void get_uint32(Object *obj, Visitor *v, const char *name,
+                       void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    uint32_t *ptr = object_static_prop_ptr(obj, prop);
+
+    visit_type_uint32(v, name, ptr, errp);
+}
+
+static void set_uint32(Object *obj, Visitor *v, const char *name,
+                       void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    uint32_t *ptr = object_static_prop_ptr(obj, prop);
+
+    visit_type_uint32(v, name, ptr, errp);
+}
+
+void object_propinfo_get_int32(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    int32_t *ptr = object_static_prop_ptr(obj, prop);
+
+    visit_type_int32(v, name, ptr, errp);
+}
+
+static void set_int32(Object *obj, Visitor *v, const char *name, void *opaque,
+                      Error **errp)
+{
+    Property *prop = opaque;
+    int32_t *ptr = object_static_prop_ptr(obj, prop);
+
+    visit_type_int32(v, name, ptr, errp);
+}
+
+const PropertyInfo prop_info_uint32 = {
+    .name  = "uint32",
+    .get   = get_uint32,
+    .set   = set_uint32,
+    .set_default_value = object_propinfo_set_default_value_uint,
+};
+
+const PropertyInfo prop_info_int32 = {
+    .name  = "int32",
+    .get   = object_propinfo_get_int32,
+    .set   = set_int32,
+    .set_default_value = object_propinfo_set_default_value_int,
+};
+
+/* --- 64bit integer --- */
+
+static void get_uint64(Object *obj, Visitor *v, const char *name,
+                       void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    uint64_t *ptr = object_static_prop_ptr(obj, prop);
+
+    visit_type_uint64(v, name, ptr, errp);
+}
+
+static void set_uint64(Object *obj, Visitor *v, const char *name,
+                       void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    uint64_t *ptr = object_static_prop_ptr(obj, prop);
+
+    visit_type_uint64(v, name, ptr, errp);
+}
+
+static void get_int64(Object *obj, Visitor *v, const char *name,
+                      void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    int64_t *ptr = object_static_prop_ptr(obj, prop);
+
+    visit_type_int64(v, name, ptr, errp);
+}
+
+static void set_int64(Object *obj, Visitor *v, const char *name,
+                      void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    int64_t *ptr = object_static_prop_ptr(obj, prop);
+
+    visit_type_int64(v, name, ptr, errp);
+}
+
+const PropertyInfo prop_info_uint64 = {
+    .name  = "uint64",
+    .get   = get_uint64,
+    .set   = set_uint64,
+    .set_default_value = object_propinfo_set_default_value_uint,
+};
+
+const PropertyInfo prop_info_int64 = {
+    .name  = "int64",
+    .get   = get_int64,
+    .set   = set_int64,
+    .set_default_value = object_propinfo_set_default_value_int,
+};
+
+/* --- string --- */
+
+static void release_string(Object *obj, const char *name, void *opaque)
+{
+    Property *prop = opaque;
+    g_free(*(char **)object_static_prop_ptr(obj, prop));
+}
+
+static void get_string(Object *obj, Visitor *v, const char *name,
+                       void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    char **ptr = object_static_prop_ptr(obj, prop);
+
+    if (!*ptr) {
+        char *str = (char *)"";
+        visit_type_str(v, name, &str, errp);
+    } else {
+        visit_type_str(v, name, ptr, errp);
+    }
+}
+
+static void set_string(Object *obj, Visitor *v, const char *name,
+                       void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    char **ptr = object_static_prop_ptr(obj, prop);
+    char *str;
+
+    if (!visit_type_str(v, name, &str, errp)) {
+        return;
+    }
+    g_free(*ptr);
+    *ptr = str;
+}
+
+const PropertyInfo prop_info_string = {
+    .name  = "str",
+    .release = release_string,
+    .get   = get_string,
+    .set   = set_string,
+};
+
+/* --- on/off/auto --- */
+
+const PropertyInfo prop_info_on_off_auto = {
+    .name = "OnOffAuto",
+    .description = "on/off/auto",
+    .enum_table = &OnOffAuto_lookup,
+    .get = object_propinfo_get_enum,
+    .set = object_propinfo_set_enum,
+    .set_default_value = object_propinfo_set_default_value_enum,
+};
+
+/* --- 32bit unsigned int 'size' type --- */
+
+void object_propinfo_get_size32(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    uint32_t *ptr = object_static_prop_ptr(obj, prop);
+    uint64_t value = *ptr;
+
+    visit_type_size(v, name, &value, errp);
+}
+
+static void set_size32(Object *obj, Visitor *v, const char *name, void *opaque,
+                       Error **errp)
+{
+    Property *prop = opaque;
+    uint32_t *ptr = object_static_prop_ptr(obj, prop);
+    uint64_t value;
+
+    if (!visit_type_size(v, name, &value, errp)) {
+        return;
+    }
+
+    if (value > UINT32_MAX) {
+        error_setg(errp,
+                   "Property %s.%s doesn't take value %" PRIu64
+                   " (maximum: %u)",
+                   object_get_typename(obj), name, value, UINT32_MAX);
+        return;
+    }
+
+    *ptr = value;
+}
+
+const PropertyInfo prop_info_size32 = {
+    .name  = "size",
+    .get = object_propinfo_get_size32,
+    .set = set_size32,
+    .set_default_value = object_propinfo_set_default_value_uint,
+};
+
+/* --- UUID --- */
+
+static void get_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
+                     Error **errp)
+{
+    Property *prop = opaque;
+    QemuUUID *uuid = object_static_prop_ptr(obj, prop);
+    char buffer[UUID_FMT_LEN + 1];
+    char *p = buffer;
+
+    qemu_uuid_unparse(uuid, buffer);
+
+    visit_type_str(v, name, &p, errp);
+}
+
+#define UUID_VALUE_AUTO        "auto"
+
+static void set_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
+                    Error **errp)
+{
+    Property *prop = opaque;
+    QemuUUID *uuid = object_static_prop_ptr(obj, prop);
+    char *str;
+
+    if (!visit_type_str(v, name, &str, errp)) {
+        return;
+    }
+
+    if (!strcmp(str, UUID_VALUE_AUTO)) {
+        qemu_uuid_generate(uuid);
+    } else if (qemu_uuid_parse(str, uuid) < 0) {
+        error_setg(errp, "invalid UUID: '%s'", str);
+    }
+    g_free(str);
+}
+
+static void set_default_uuid_auto(ObjectProperty *op, const Property *prop)
+{
+    object_property_set_default_str(op, UUID_VALUE_AUTO);
+}
+
+const PropertyInfo prop_info_uuid = {
+    .name  = "str",
+    .description = "UUID (aka GUID) or \"" UUID_VALUE_AUTO
+        "\" for random value (default)",
+    .get   = get_uuid,
+    .set   = set_uuid,
+    .set_default_value = set_default_uuid_auto,
+};
+
+/* --- support for array properties --- */
+
+/* Used as an opaque for the object properties we add for each
+ * array element. Note that the struct Property must be first
+ * in the struct so that a pointer to this works as the opaque
+ * for the underlying element's property hooks as well as for
+ * our own release callback.
+ */
+typedef struct {
+    struct Property prop;
+    char *propname;
+    ObjectPropertyRelease *release;
+} ArrayElementProperty;
+
+/**
+ * Create ArrayElementProperty based on array length property
+ * @array_len_prop (which was previously defined using DEFINE_PROP_ARRAY()).
+ */
+static ArrayElementProperty *array_element_new(Object *obj,
+                                               Property *array_len_prop,
+                                               const char *arrayname,
+                                               int index,
+                                               void *eltptr)
+{
+    char *propname = g_strdup_printf("%s[%d]", arrayname, index);
+    ArrayElementProperty *arrayprop = g_new0(ArrayElementProperty, 1);
+    arrayprop->propname = propname;
+    arrayprop->prop.info = array_len_prop->arrayinfo;
+    arrayprop->prop.name = propname;
+    /* This ugly piece of pointer arithmetic sets up the offset so
+     * that when the underlying get/set hooks call qdev_get_prop_ptr
+     * they get the right answer despite the array element not actually
+     * being inside the device struct.
+     */
+    arrayprop->prop.offset = eltptr - (void *)obj;
+    assert(object_static_prop_ptr(obj, &arrayprop->prop) == eltptr);
+    return arrayprop;
+}
+
+/* object property release callback for array element properties:
+ * we call the underlying element's property release hook, and
+ * then free the memory we allocated when we added the property.
+ */
+static void array_element_release(Object *obj, const char *name, void *opaque)
+{
+    ArrayElementProperty *p = opaque;
+    if (p->release) {
+        p->release(obj, name, opaque);
+    }
+    g_free(p->propname);
+    g_free(p);
+}
+
+static void object_property_add_array_element(Object *obj,
+                                              Property *array_len_prop,
+                                              ArrayElementProperty *prop)
+{
+    ObjectProperty *array_op = object_property_find(obj, array_len_prop->name);
+    ObjectProperty *op = object_property_add_static(obj, &prop->prop,
+                                                    array_op->allow_set);
+
+    assert((void *)prop == (void *)&prop->prop);
+    prop->release = op->release;
+    /* array_element_release() will call the original release function */
+    op->release = array_element_release;
+}
+
+static void set_prop_arraylen(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp)
+{
+    /* Setter for the property which defines the length of a
+     * variable-sized property array. As well as actually setting the
+     * array-length field in the device struct, we have to create the
+     * array itself and dynamically add the corresponding properties.
+     */
+    Property *prop = opaque;
+    uint32_t *alenptr = object_static_prop_ptr(obj, prop);
+    void **arrayptr = (void *)obj + prop->arrayoffset;
+    void *eltptr;
+    const char *arrayname;
+    int i;
+
+    if (*alenptr) {
+        error_setg(errp, "array size property %s may not be set more than once",
+                   name);
+        return;
+    }
+    if (!visit_type_uint32(v, name, alenptr, errp)) {
+        return;
+    }
+    if (!*alenptr) {
+        return;
+    }
+
+    /* DEFINE_PROP_ARRAY guarantees that name should start with this prefix;
+     * strip it off so we can get the name of the array itself.
+     */
+    assert(strncmp(name, PROP_ARRAY_LEN_PREFIX,
+                   strlen(PROP_ARRAY_LEN_PREFIX)) == 0);
+    arrayname = name + strlen(PROP_ARRAY_LEN_PREFIX);
+
+    /* Note that it is the responsibility of the individual device's deinit
+     * to free the array proper.
+     */
+    *arrayptr = eltptr = g_malloc0(*alenptr * prop->arrayfieldsize);
+    for (i = 0; i < *alenptr; i++, eltptr += prop->arrayfieldsize) {
+        ArrayElementProperty *elt_prop = array_element_new(obj, prop, arrayname,
+                                                           i, eltptr);
+        object_property_add_array_element(obj, prop, elt_prop);
+    }
+}
+
+const PropertyInfo prop_info_arraylen = {
+    .name = "uint32",
+    .get = get_uint32,
+    .set = set_prop_arraylen,
+    .set_default_value = object_propinfo_set_default_value_uint,
+};
+
+/* --- 64bit unsigned int 'size' type --- */
+
+static void get_size(Object *obj, Visitor *v, const char *name, void *opaque,
+                     Error **errp)
+{
+    Property *prop = opaque;
+    uint64_t *ptr = object_static_prop_ptr(obj, prop);
+
+    visit_type_size(v, name, ptr, errp);
+}
+
+static void set_size(Object *obj, Visitor *v, const char *name, void *opaque,
+                     Error **errp)
+{
+    Property *prop = opaque;
+    uint64_t *ptr = object_static_prop_ptr(obj, prop);
+
+    visit_type_size(v, name, ptr, errp);
+}
+
+const PropertyInfo prop_info_size = {
+    .name  = "size",
+    .get = get_size,
+    .set = set_size,
+    .set_default_value = object_propinfo_set_default_value_uint,
+};
+
+/* --- object link property --- */
+
+static ObjectProperty *create_link_property(ObjectClass *oc, Property *prop)
+{
+    /*
+     * NOTE: object_property_allow_set_link is unconditional, but
+     *       ObjectProperty.allow_set may be set for the property too.
+     */
+    return object_class_property_add_link(oc, prop->name, prop->link_type,
+                                          prop->offset,
+                                          object_property_allow_set_link,
+                                          OBJ_PROP_LINK_STRONG);
+}
+
+const PropertyInfo prop_info_link = {
+    .name = "link",
+    .create = create_link_property,
+};
diff --git a/qom/meson.build b/qom/meson.build
index aaebae66b4..8f746e4a0a 100644
--- a/qom/meson.build
+++ b/qom/meson.build
@@ -5,6 +5,7 @@ qom_ss.add(files(
   'object_interfaces.c',
   'qom-qobject.c',
   'static-property.c',
+  'property-types.c',
 ))
 
 qmp_ss.add(files('qom-qmp-cmds.c'))
-- 
2.28.0


