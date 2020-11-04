Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC132C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:23:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA58206A5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQjyrYqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA58206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaLYs-0007xy-3K
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 11:23:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLFW-000379-4F
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:03:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44798)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLFP-0005fE-2O
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:03:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604505774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w0qlDVkSCLKR1bNv6qNzKzrUrp2LYDPUr6Bjx2oiUuw=;
 b=jQjyrYqMZbOqNKxqVIWKdxOuqGQjJC6sFfcI8BqppHuRP0IIJ6XH63L8Ink+gFu2+Koyeg
 iKFdbaKCYOh9Z/dqMUHmPlUb3pQMWlJI2FjmKFuhOMXe2bjcjzRSOeq3IzX34RMPkPNE6x
 neLqYabNrk68FJc8yrvKDHELdlSsu/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-X2V4zEmuOryG2jDtEG1prA-1; Wed, 04 Nov 2020 11:02:51 -0500
X-MC-Unique: X2V4zEmuOryG2jDtEG1prA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B5301966335;
 Wed,  4 Nov 2020 16:01:55 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF57C19C4F;
 Wed,  4 Nov 2020 16:01:54 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 26/44] qdev: Rename Property.name to Property.qdev_prop_name
Date: Wed,  4 Nov 2020 11:00:03 -0500
Message-Id: <20201104160021.2342108-27-ehabkost@redhat.com>
In-Reply-To: <20201104160021.2342108-1-ehabkost@redhat.com>
References: <20201104160021.2342108-1-ehabkost@redhat.com>
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

The Property.name field won't always be set and we need to be
100% sure its usage will be restricted to qdev/TYPE_DEVICE code.
Renaming the field is a good way to ensure that and make its
purpose more clear.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
This is a new patch added in v2 of the series
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 include/hw/qdev-properties.h | 11 +++++++++--
 hw/core/qdev-properties.c    | 20 ++++++++++----------
 softmmu/qdev-monitor.c       |  8 ++++----
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index bbc5244ed0..b301fe64d7 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -13,7 +13,14 @@
  *     is true.
  */
 struct Property {
-    const char   *name;
+    /**
+     * @qdev_prop_name: qdev property name
+     *
+     * qdev_prop_name is used only by TYPE_DEVICE code
+     * (device_class_set_props(), qdev_class_add_property(), and
+     * others).
+     */
+    const char   *qdev_prop_name;
     const PropertyInfo *info;
     ptrdiff_t    offset;
     uint8_t      bitnr;
@@ -63,7 +70,7 @@ extern const PropertyInfo qdev_prop_arraylen;
 extern const PropertyInfo qdev_prop_link;
 
 #define DEFINE_PROP(_name, _state, _field, _prop, _type, ...) {  \
-        .name      = (_name),                                    \
+        .qdev_prop_name      = (_name),                          \
         .info      = &(_prop),                                   \
         .offset    = offsetof(_state, _field)                    \
             + type_check(_type, typeof_field(_state, _field)),   \
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index e9e2a34f3b..5a4aa87fc9 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -596,7 +596,7 @@ static void set_prop_arraylen(Object *obj, Visitor *v, const char *name,
         arrayprop->release = prop->arrayinfo->release;
         arrayprop->propname = propname;
         arrayprop->prop.info = prop->arrayinfo;
-        arrayprop->prop.name = propname;
+        arrayprop->prop.qdev_prop_name = propname;
         /* This ugly piece of pointer arithmetic sets up the offset so
          * that when the underlying get/set hooks call qdev_get_prop_ptr
          * they get the right answer despite the array element not actually
@@ -627,8 +627,8 @@ static Property *qdev_prop_walk(Property *props, const char *name)
     if (!props) {
         return NULL;
     }
-    while (props->name) {
-        if (strcmp(props->name, name) == 0) {
+    while (props->qdev_prop_name) {
+        if (strcmp(props->qdev_prop_name, name) == 0) {
             return props;
         }
         props++;
@@ -889,7 +889,7 @@ object_class_property_add_field(ObjectClass *oc, const char *name,
 
 void qdev_property_add_static(DeviceState *dev, Property *prop)
 {
-    object_property_add_field(OBJECT(dev), prop->name, prop);
+    object_property_add_field(OBJECT(dev), prop->qdev_prop_name, prop);
 }
 
 /**
@@ -932,7 +932,7 @@ static void qdev_class_add_legacy_property(DeviceClass *dc, Property *prop)
         return;
     }
 
-    name = g_strdup_printf("legacy-%s", prop->name);
+    name = g_strdup_printf("legacy-%s", prop->qdev_prop_name);
     object_class_property_add(OBJECT_CLASS(dc), name, "str",
         prop->info->print ? qdev_get_legacy_property : prop->info->get,
         NULL, NULL, prop);
@@ -944,9 +944,9 @@ void device_class_set_props(DeviceClass *dc, Property *props)
     Property *prop;
 
     dc->props_ = props;
-    for (prop = props; prop && prop->name; prop++) {
+    for (prop = props; prop && prop->qdev_prop_name; prop++) {
         qdev_class_add_legacy_property(dc, prop);
-        object_class_property_add_field(oc, prop->name, prop);
+        object_class_property_add_field(oc, prop->qdev_prop_name, prop);
     }
 }
 
@@ -959,9 +959,9 @@ void qdev_alias_all_properties(DeviceState *target, Object *source)
     do {
         DeviceClass *dc = DEVICE_CLASS(class);
 
-        for (prop = dc->props_; prop && prop->name; prop++) {
-            object_property_add_alias(source, prop->name,
-                                      OBJECT(target), prop->name);
+        for (prop = dc->props_; prop && prop->qdev_prop_name; prop++) {
+            object_property_add_alias(source, prop->qdev_prop_name,
+                                      OBJECT(target), prop->qdev_prop_name);
         }
         class = object_class_get_parent(class);
     } while (class != object_class_by_name(TYPE_DEVICE));
diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
index 79164e4a3f..786b9ce572 100644
--- a/softmmu/qdev-monitor.c
+++ b/softmmu/qdev-monitor.c
@@ -697,14 +697,14 @@ static void qdev_print_props(Monitor *mon, DeviceState *dev, Property *props,
 {
     if (!props)
         return;
-    for (; props->name; props++) {
+    for (; props->qdev_prop_name; props++) {
         char *value;
-        char *legacy_name = g_strdup_printf("legacy-%s", props->name);
+        char *legacy_name = g_strdup_printf("legacy-%s", props->qdev_prop_name);
 
         if (object_property_get_type(OBJECT(dev), legacy_name, NULL)) {
             value = object_property_get_str(OBJECT(dev), legacy_name, NULL);
         } else {
-            value = object_property_print(OBJECT(dev), props->name, true,
+            value = object_property_print(OBJECT(dev), props->qdev_prop_name, true,
                                           NULL);
         }
         g_free(legacy_name);
@@ -712,7 +712,7 @@ static void qdev_print_props(Monitor *mon, DeviceState *dev, Property *props,
         if (!value) {
             continue;
         }
-        qdev_printf("%s = %s\n", props->name,
+        qdev_printf("%s = %s\n", props->qdev_prop_name,
                     *value ? value : "<null>");
         g_free(value);
     }
-- 
2.28.0


