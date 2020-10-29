Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A212C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:15:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBD83206CA
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gk6FUTjS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD83206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYGCW-0002w5-Kb
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 18:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG1O-0003cr-7a
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:03:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39658)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG1H-0006ba-AO
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604009021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=73dqo+DZjK9A2wR9mXizxxs4T9+NmFXNl0+jmr3inog=;
 b=gk6FUTjSFE3kFkizwwzXedZX3KV6pCRi9oN3JvlVg99ZIDI5y26B9S62adQNvePlBdyGuz
 1RhtR10L7ilb7eiqDx1oWnA11TpPFcJObKu4gtus/RINF4H+g5oMKbTRjSaXvTQZRCBjzs
 crnP7lXhssX2YE2J0i7S7jm27qNZz2E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-eyuuCOcLM0iNt4k5nrdBuw-1; Thu, 29 Oct 2020 18:03:39 -0400
X-MC-Unique: eyuuCOcLM0iNt4k5nrdBuw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2756518BA281
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 22:03:38 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CEFFA1975F;
 Thu, 29 Oct 2020 22:03:37 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 22/36] qdev: Make qdev_prop_allow_set() a property allow_set
 callback
Date: Thu, 29 Oct 2020 18:02:32 -0400
Message-Id: <20201029220246.472693-23-ehabkost@redhat.com>
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

This removes the last remaining DeviceState-specific line of code
inside qdev property registration code, and will allow us to make
static properties a core QOM feature.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/core/qdev-prop-internal.h |  4 +++-
 include/hw/qdev-core.h       | 10 ++++++++++
 include/hw/qdev-properties.h | 10 ++++++++--
 hw/core/qdev-properties.c    | 36 ++++++++++++++++++++++--------------
 4 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/hw/core/qdev-prop-internal.h b/hw/core/qdev-prop-internal.h
index 858f844504..49bf557fd5 100644
--- a/hw/core/qdev-prop-internal.h
+++ b/hw/core/qdev-prop-internal.h
@@ -31,11 +31,13 @@ void qdev_propinfo_get_size32(Object *obj, Visitor *v, const char *name,
  * object_property_add_static: Add a static property to an object instance
  * @obj: object instance
  * @prop: property definition
+ * @allow_set: optional check function
  *
  * This function should not be used in new code.  Please add class properties
  * instead, using object_class_add_static_props().
  */
 ObjectProperty *
-object_property_add_static(Object *obj, Property *prop);
+object_property_add_static(Object *obj, Property *prop,
+                           ObjectPropertyAllowSet allow_set);
 
 #endif
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index aea49355fa..e69d19d06b 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -765,6 +765,16 @@ void qdev_machine_init(void);
  */
 void device_legacy_reset(DeviceState *dev);
 
+/**
+ * device_class_set_props: Add class properties from #Property array
+ *
+ * @dc: Device class
+ * @props: array of device properties, terminated by DEFINE_PROP_END_OF_LIST
+ *
+ * Add class properties from the array at @props.
+ * Properties added using this function will be settable only
+ * before the device is realized.
+ */
 void device_class_set_props(DeviceClass *dc, Property *props);
 
 /**
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index c94301c349..0acc92ae2b 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -279,25 +279,31 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
  * object_class_property_add_static: Add a static property to object class
  * @oc: object class
  * @prop: property definition
+ * @allow_set: optional check function
  *
  * Add a property to an object class based on the property definition
  * at @prop.
  *
+ * If @allow_set is NULL, the property will always be allowed to be set.
+ *
  * The property definition at @prop should be defined using the
  * ``DEFINE_PROP`` family of macros.  *@prop must exist for the
  * life time of @oc.
  */
 ObjectProperty *
-object_class_property_add_static(ObjectClass *oc, Property *prop);
+object_class_property_add_static(ObjectClass *oc, Property *prop,
+                                 ObjectPropertyAllowSet allow_set);
 
 /**
  * object_class_add_static_props: Add multiple static properties to object class
  * @oc: object class
  * @props: property definition array, terminated by DEFINED_PROP_END_OF_LIST()
+ * @allow_set: optional check function
  *
  * Add properties from @props using object_class_property_add_static()
  */
-void object_class_add_static_props(ObjectClass *oc, Property *props);
+void object_class_add_static_props(ObjectClass *oc, Property *props,
+                                   ObjectPropertyAllowSet allow_set);
 
 /*
  * Set properties between creation and realization.
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 4fec9cb73b..4cb8baa6a0 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -26,13 +26,13 @@ void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
 }
 
 /* returns: true if property is allowed to be set, false otherwise */
-static bool qdev_prop_allow_set(Object *obj, const char *name,
+static bool qdev_prop_allow_set(Object *obj, ObjectProperty *op,
                                 Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
 
     if (dev->realized) {
-        qdev_prop_set_after_realize(dev, name, errp);
+        qdev_prop_set_after_realize(dev, op->name, errp);
         return false;
     }
     return true;
@@ -80,10 +80,6 @@ static void static_prop_set(Object *obj, Visitor *v, const char *name,
 {
     Property *prop = opaque;
 
-    if (!qdev_prop_allow_set(obj, name, errp)) {
-        return;
-    }
-
     return prop->info->set(obj, v, name, opaque, errp);
 }
 
@@ -631,7 +627,9 @@ static void object_property_add_array_element(Object *obj,
                                               Property *array_len_prop,
                                               ArrayElementProperty *prop)
 {
-    ObjectProperty *op = object_property_add_static(obj, &prop->prop);
+    ObjectProperty *array_op = object_property_find(obj, array_len_prop->name);
+    ObjectProperty *op = object_property_add_static(obj, &prop->prop,
+                                                    array_op->allow_set);
 
     assert((void *)prop == (void *)&prop->prop);
     prop->release = op->release;
@@ -894,9 +892,13 @@ const PropertyInfo qdev_prop_size = {
 
 static ObjectProperty *create_link_property(ObjectClass *oc, Property *prop)
 {
+    /*
+     * NOTE: object_property_allow_set_link is unconditional, but
+     *       ObjectProperty.allow_set may be set for the property too.
+     */
     return object_class_property_add_link(oc, prop->name, prop->link_type,
                                           prop->offset,
-                                          qdev_prop_allow_set_link_before_realize,
+                                          object_property_allow_set_link,
                                           OBJ_PROP_LINK_STRONG);
 }
 
@@ -906,7 +908,8 @@ const PropertyInfo qdev_prop_link = {
 };
 
 ObjectProperty *
-object_property_add_static(Object *obj, Property *prop)
+object_property_add_static(Object *obj, Property *prop,
+                           ObjectPropertyAllowSet allow_set)
 {
     ObjectProperty *op;
 
@@ -928,11 +931,13 @@ object_property_add_static(Object *obj, Property *prop)
         }
     }
 
+    op->allow_set = allow_set;
     return op;
 }
 
 ObjectProperty *
-object_class_property_add_static(ObjectClass *oc, Property *prop)
+object_class_property_add_static(ObjectClass *oc, Property *prop,
+                                 ObjectPropertyAllowSet allow_set)
 {
     ObjectProperty *op;
 
@@ -953,21 +958,24 @@ object_class_property_add_static(ObjectClass *oc, Property *prop)
         object_class_property_set_description(oc, prop->name,
                                             prop->info->description);
     }
+
+    op->allow_set = allow_set;
     return op;
 }
 
-void object_class_add_static_props(ObjectClass *oc, Property *props)
+void object_class_add_static_props(ObjectClass *oc, Property *props,
+                                   ObjectPropertyAllowSet allow_set)
 {
     Property *prop;
 
     for (prop = props; prop && prop->name; prop++) {
-        object_class_property_add_static(oc, prop);
+        object_class_property_add_static(oc, prop, allow_set);
     }
 }
 
 void qdev_property_add_static(DeviceState *dev, Property *prop)
 {
-    object_property_add_static(OBJECT(dev), prop);
+    object_property_add_static(OBJECT(dev), prop, qdev_prop_allow_set);
 }
 
 /**
@@ -1027,7 +1035,7 @@ void device_class_set_props(DeviceClass *dc, Property *props)
 {
     dc->props_ = props;
     qdev_class_add_legacy_properties(dc, props);
-    object_class_add_static_props(OBJECT_CLASS(dc), props);
+    object_class_add_static_props(OBJECT_CLASS(dc), props, qdev_prop_allow_set);
 }
 
 void qdev_alias_all_properties(DeviceState *target, Object *source)
-- 
2.28.0


