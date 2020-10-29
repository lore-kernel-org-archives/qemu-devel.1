Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E28C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:19:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4954920FC3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMpHTDHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4954920FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYGGJ-0008OS-2e
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 18:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG1J-0003V7-JC
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:03:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50661)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG1F-0006b5-Bu
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604009014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ozq5c29ToMtZxIRD7Q8p4k7GFhu4PcpfAP54MD07co=;
 b=bMpHTDHMzkZk2sKivqnWxVRoS0trNN8gxF84Dlm1f+uy9O0dadBDewHB5Fxm/6sdExqf35
 p6qGHYJSFMO6iOMA7rZWRbemf0mYR0aj1nDLrSX9N5SNpg4FiImiNdxqiNF9dBBgZZy0qg
 hH9TYj5inn1syo8v9EEq0mNFBwETz0U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-lkZv34lnNp2JL_nI0GYTYg-1; Thu, 29 Oct 2020 18:03:32 -0400
X-MC-Unique: lkZv34lnNp2JL_nI0GYTYg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEECE8030BD
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 22:03:31 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90EC76EF68;
 Thu, 29 Oct 2020 22:03:31 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/36] qdev: Separate generic and device-specific property
 registration
Date: Thu, 29 Oct 2020 18:02:27 -0400
Message-Id: <20201029220246.472693-18-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-1-ehabkost@redhat.com>
References: <20201029220246.472693-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

qdev_class_add_property() and qdev_property_add_static() will
have code that's specific for device types.

object_class_property_add_static(),
object_class_add_static_props(), and object_property_add_static()
will be generic and part of the QOM static property API.

The declarations for the new functions are being added to
qdev-properties.h, but they will be moved to a QOM header later.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/core/qdev-prop-internal.h | 11 +++++++++++
 include/hw/qdev-properties.h | 24 ++++++++++++++++++++++++
 hw/core/qdev-properties.c    | 36 ++++++++++++++++++++++++++++--------
 3 files changed, 63 insertions(+), 8 deletions(-)

diff --git a/hw/core/qdev-prop-internal.h b/hw/core/qdev-prop-internal.h
index 9cf5cc1d51..858f844504 100644
--- a/hw/core/qdev-prop-internal.h
+++ b/hw/core/qdev-prop-internal.h
@@ -27,4 +27,15 @@ void qdev_propinfo_get_int32(Object *obj, Visitor *v, const char *name,
 void qdev_propinfo_get_size32(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp);
 
+/**
+ * object_property_add_static: Add a static property to an object instance
+ * @obj: object instance
+ * @prop: property definition
+ *
+ * This function should not be used in new code.  Please add class properties
+ * instead, using object_class_add_static_props().
+ */
+ObjectProperty *
+object_property_add_static(Object *obj, Property *prop);
+
 #endif
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 7f8e4daade..c94301c349 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -275,6 +275,30 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
 #define DEFINE_PROP_END_OF_LIST()               \
     {}
 
+/**
+ * object_class_property_add_static: Add a static property to object class
+ * @oc: object class
+ * @prop: property definition
+ *
+ * Add a property to an object class based on the property definition
+ * at @prop.
+ *
+ * The property definition at @prop should be defined using the
+ * ``DEFINE_PROP`` family of macros.  *@prop must exist for the
+ * life time of @oc.
+ */
+ObjectProperty *
+object_class_property_add_static(ObjectClass *oc, Property *prop);
+
+/**
+ * object_class_add_static_props: Add multiple static properties to object class
+ * @oc: object class
+ * @props: property definition array, terminated by DEFINED_PROP_END_OF_LIST()
+ *
+ * Add properties from @props using object_class_property_add_static()
+ */
+void object_class_add_static_props(ObjectClass *oc, Property *props);
+
 /*
  * Set properties between creation and realization.
  *
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index ad685f371d..68b1666e14 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -885,9 +885,9 @@ const PropertyInfo qdev_prop_link = {
     .create = create_link_property,
 };
 
-void qdev_property_add_static(DeviceState *dev, Property *prop)
+ObjectProperty *
+object_property_add_static(Object *obj, Property *prop)
 {
-    Object *obj = OBJECT(dev);
     ObjectProperty *op;
 
     assert(!prop->info->create);
@@ -907,11 +907,13 @@ void qdev_property_add_static(DeviceState *dev, Property *prop)
             op->init(obj, op);
         }
     }
+
+    return op;
 }
 
-static void qdev_class_add_property(DeviceClass *klass, Property *prop)
+ObjectProperty *
+object_class_property_add_static(ObjectClass *oc, Property *prop)
 {
-    ObjectClass *oc = OBJECT_CLASS(klass);
     ObjectProperty *op;
 
     if (prop->info->create) {
@@ -931,6 +933,21 @@ static void qdev_class_add_property(DeviceClass *klass, Property *prop)
         object_class_property_set_description(oc, prop->name,
                                             prop->info->description);
     }
+    return op;
+}
+
+void object_class_add_static_props(ObjectClass *oc, Property *props)
+{
+    Property *prop;
+
+    for (prop = props; prop && prop->name; prop++) {
+        object_class_property_add_static(oc, prop);
+    }
+}
+
+void qdev_property_add_static(DeviceState *dev, Property *prop)
+{
+    object_property_add_static(OBJECT(dev), prop);
 }
 
 /**
@@ -979,16 +996,19 @@ static void qdev_class_add_legacy_property(DeviceClass *dc, Property *prop)
         NULL, NULL, prop);
 }
 
-void device_class_set_props(DeviceClass *dc, Property *props)
+static void qdev_class_add_legacy_properties(DeviceClass *dc, Property *props)
 {
     Property *prop;
-
-    dc->props_ = props;
     for (prop = props; prop && prop->name; prop++) {
         qdev_class_add_legacy_property(dc, prop);
-        qdev_class_add_property(dc, prop);
     }
 }
+void device_class_set_props(DeviceClass *dc, Property *props)
+{
+    dc->props_ = props;
+    qdev_class_add_legacy_properties(dc, props);
+    object_class_add_static_props(OBJECT_CLASS(dc), props);
+}
 
 void qdev_alias_all_properties(DeviceState *target, Object *source)
 {
-- 
2.28.0


