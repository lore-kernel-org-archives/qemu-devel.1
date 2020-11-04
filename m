Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D47C56201
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41B54206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dL0YUyXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B54206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaLd2-0005SK-3G
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 11:27:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLFc-0003Mi-9G
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:03:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24193)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLFT-0005gE-1j
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604505778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JusAU4ZVcNlVO9yNQkafrHuHhs7zVpSsuF0b0bb2xWg=;
 b=dL0YUyXgFnMIzNpEaRERqOgFifbFHo32qDWtA3IiW1W4FUb5e9SFwk8/iakTkYVDh9RIdn
 cnykH7YQx1Pp3Vpw3R6iJJy9EV3zFk4w69tk5RtdU9PFDN0Vo5Ndc+vf/fkF9v0eng/Hdn
 6XjH2i3xVls8vHLe2hsYJ1PJcDI1EIY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-7o8RlAOzPOGzmI8b-s57vw-1; Wed, 04 Nov 2020 11:02:56 -0500
X-MC-Unique: 7o8RlAOzPOGzmI8b-s57vw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDF071099F88;
 Wed,  4 Nov 2020 16:01:53 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F6706266E;
 Wed,  4 Nov 2020 16:01:53 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 25/44] qdev: Separate generic and device-specific property
 registration
Date: Wed,  4 Nov 2020 11:00:02 -0500
Message-Id: <20201104160021.2342108-26-ehabkost@redhat.com>
In-Reply-To: <20201104160021.2342108-1-ehabkost@redhat.com>
References: <20201104160021.2342108-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

qdev_class_add_property() and qdev_property_add_static() will
have code that's specific for device types.

object_class_property_add_field() and object_property_add_static()
will be generic and part of the QOM field property API.  Note
that the new functions have a `name` parameter because the plan
is to eventually get rid of the Property.name field.

The declarations for the new functions are being added to
qdev-properties.h, but they will be moved to a QOM header later.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Patch redone after changes in previous patches in the series
* Rename new functions to object*_property_add_field()
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/core/qdev-prop-internal.h | 13 +++++++++++++
 include/hw/qdev-properties.h | 16 ++++++++++++++++
 hw/core/qdev-properties.c    | 25 +++++++++++++++++--------
 3 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/hw/core/qdev-prop-internal.h b/hw/core/qdev-prop-internal.h
index 9cf5cc1d51..0e16d28171 100644
--- a/hw/core/qdev-prop-internal.h
+++ b/hw/core/qdev-prop-internal.h
@@ -27,4 +27,17 @@ void qdev_propinfo_get_int32(Object *obj, Visitor *v, const char *name,
 void qdev_propinfo_get_size32(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp);
 
+/**
+ * object_property_add_field: Add a field property to an object instance
+ * @obj: object instance
+ * @name: property name
+ * @prop: property definition
+ *
+ * This function should not be used in new code.  Please add class properties
+ * instead, using object_class_add_field().
+ */
+ObjectProperty *
+object_property_add_field(Object *obj, const char *name,
+                          Property *prop);
+
 #endif
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index aae882317a..bbc5244ed0 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -167,6 +167,22 @@ extern const PropertyInfo qdev_prop_link;
 #define DEFINE_PROP_END_OF_LIST()               \
     {}
 
+/**
+ * object_class_property_add_field: Add a field property to object class
+ * @oc: object class
+ * @name: property name
+ * @prop: property definition
+ *
+ * Add a field property to an object class.  A field property is
+ * a property that will change a field at a specific offset of the
+ * object instance struct.
+ *
+ * *@prop must exist for the life time of @oc.
+ */
+ObjectProperty *
+object_class_property_add_field(ObjectClass *oc, const char *name,
+                                Property *prop);
+
 /*
  * Set properties between creation and realization.
  *
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index a5d5d74f32..e9e2a34f3b 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -835,20 +835,20 @@ const PropertyInfo qdev_prop_link = {
     .create = create_link_property,
 };
 
-void qdev_property_add_static(DeviceState *dev, Property *prop)
+ObjectProperty *
+object_property_add_field(Object *obj, const char *name, Property *prop)
 {
-    Object *obj = OBJECT(dev);
     ObjectProperty *op;
 
     assert(!prop->info->create);
 
-    op = object_property_add(obj, prop->name, prop->info->name,
+    op = object_property_add(obj, name, prop->info->name,
                              field_prop_getter(prop->info),
                              field_prop_setter(prop->info),
                              prop->info->release,
                              prop);
 
-    object_property_set_description(obj, prop->name,
+    object_property_set_description(obj, name,
                                     prop->info->description);
 
     if (prop->set_default) {
@@ -857,12 +857,14 @@ void qdev_property_add_static(DeviceState *dev, Property *prop)
             op->init(obj, op);
         }
     }
+
+    return op;
 }
 
-static void qdev_class_add_property(DeviceClass *klass, const char *name,
-                                    Property *prop)
+ObjectProperty *
+object_class_property_add_field(ObjectClass *oc, const char *name,
+                                Property *prop)
 {
-    ObjectClass *oc = OBJECT_CLASS(klass);
     ObjectProperty *op;
 
     if (prop->info->create) {
@@ -882,6 +884,12 @@ static void qdev_class_add_property(DeviceClass *klass, const char *name,
         object_class_property_set_description(oc, name,
                                               prop->info->description);
     }
+    return op;
+}
+
+void qdev_property_add_static(DeviceState *dev, Property *prop)
+{
+    object_property_add_field(OBJECT(dev), prop->name, prop);
 }
 
 /**
@@ -932,12 +940,13 @@ static void qdev_class_add_legacy_property(DeviceClass *dc, Property *prop)
 
 void device_class_set_props(DeviceClass *dc, Property *props)
 {
+    ObjectClass *oc = OBJECT_CLASS(dc);
     Property *prop;
 
     dc->props_ = props;
     for (prop = props; prop && prop->name; prop++) {
         qdev_class_add_legacy_property(dc, prop);
-        qdev_class_add_property(dc, prop->name, prop);
+        object_class_property_add_field(oc, prop->name, prop);
     }
 }
 
-- 
2.28.0


