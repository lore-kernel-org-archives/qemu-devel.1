Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B19EC43457
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:10:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8838C2227E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MdH67Bdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8838C2227E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQuy0-0004fk-KO
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQuqX-0003zi-GG
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:02:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49653)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQuqR-0001Dg-Qn
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602259329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V6ZeMhapG7XRhWAt5UK9AHGNMYXnP5KbDP4eNV88Xtw=;
 b=MdH67BdvSL4hmpgVwvkmeuBWeHNWB8of4fH0XYL6L8s70wsGPzolncVCXn5x3BLV2zf5wW
 88UOMAiBW2A4OWGkbV/uCPQ9FkkltxYhRpRwDk2DtegDCj8/Yss59wgcUPxRKeJLxZYEmH
 gmS5YKkWGvztMKHy1njKYuAWNx05kps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-330oxqEBOomz438RgQoKhA-1; Fri, 09 Oct 2020 12:02:07 -0400
X-MC-Unique: 330oxqEBOomz438RgQoKhA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 798351007B00
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 16:02:06 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46E157665B;
 Fri,  9 Oct 2020 16:02:03 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/12] [RFC] qom: Property lock mechanism
Date: Fri,  9 Oct 2020 12:01:21 -0400
Message-Id: <20201009160122.1662082-12-ehabkost@redhat.com>
In-Reply-To: <20201009160122.1662082-1-ehabkost@redhat.com>
References: <20201009160122.1662082-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a mechanism to allow QOM types to prevent writable instance
properties from being registered.  This will be used by types
that expose all QOM properties in user-visible interfaces like
object-add and device_add, to ensure our external interfaces are
not affected by dynamic QOM properties.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 include/qom/object.h           | 17 +++++++++
 qom/object.c                   | 28 ++++++++++++++
 tests/test-qdev-global-props.c | 70 ++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 1634294e4f..a124cf897d 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -137,6 +137,8 @@ struct ObjectClass
     ObjectUnparent *unparent;
 
     GHashTable *properties;
+    /* instance properties locked.  See object_class_lock_properties() */
+    bool properties_locked;
 };
 
 /**
@@ -1867,6 +1869,21 @@ void object_property_set_description(Object *obj, const char *name,
 void object_class_property_set_description(ObjectClass *klass, const char *name,
                                            const char *description);
 
+/**
+ * object_class_lock_properties:
+ * @oc: the object class to have properties locked
+ *
+ * Prevent all subtypes of @oc from having writeable instance
+ * properties. If @oc is an interface type, this also affects all
+ * classes implementing the interface.
+ *
+ * This can be used by QOM types that have all QOM properties
+ * exposed to the external world (e.g. #TYPE_USER_CREATABLE) to
+ * ensure all user-writable properties are introspectable at the
+ * class level.
+ */
+void object_class_lock_properties(ObjectClass *oc);
+
 /**
  * object_child_foreach:
  * @obj: the object whose children will be navigated
diff --git a/qom/object.c b/qom/object.c
index bb32f5d3ad..73f27b8b7e 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -498,6 +498,27 @@ static void object_class_property_init_all(Object *obj)
     }
 }
 
+void object_class_lock_properties(ObjectClass *oc)
+{
+    oc->properties_locked = true;
+}
+
+static bool object_class_properties_locked(ObjectClass *oc)
+{
+    GSList *i = NULL;
+
+    if (oc->properties_locked) {
+        return true;
+    }
+    for (i = oc->interfaces; i; i = i->next) {
+        ObjectClass *ic = i->data;
+        if (ic->properties_locked) {
+            return true;
+        }
+    }
+    return false;
+}
+
 static void object_initialize_with_type(Object *obj, size_t size, TypeImpl *type)
 {
     type_initialize(type);
@@ -1192,8 +1213,15 @@ object_property_try_add(Object *obj, const char *name, const char *type,
                         void *opaque, Error **errp)
 {
     ObjectProperty *prop;
+    ObjectClass *oc = object_get_class(obj);
     size_t name_len = strlen(name);
 
+    if (set && object_class_properties_locked(oc)) {
+        error_setg(errp, "writable instance property not allowed for type %s",
+                   object_class_get_name(oc));
+        return NULL;
+    }
+
     if (name_len >= 3 && !memcmp(name + name_len - 3, "[*]", 4)) {
         int i;
         ObjectProperty *ret;
diff --git a/tests/test-qdev-global-props.c b/tests/test-qdev-global-props.c
index c8862cac5f..590c916c4b 100644
--- a/tests/test-qdev-global-props.c
+++ b/tests/test-qdev-global-props.c
@@ -58,6 +58,9 @@ static void static_prop_class_init(ObjectClass *oc, void *data)
 
     dc->realize = NULL;
     device_class_set_props(dc, static_props);
+
+    /* test_proplist_lock() will check if property locking works */
+    object_class_lock_properties(oc);
 }
 
 static const TypeInfo static_prop_type = {
@@ -213,6 +216,69 @@ static const TypeInfo nondevice_type = {
     .parent = TYPE_OBJECT,
 };
 
+static void locked_interface_class_base_init(ObjectClass *klass, void *data)
+{
+    object_class_lock_properties(klass);
+}
+
+#define TYPE_LOCKED_INTERFACE "locked-interface"
+static const TypeInfo locked_interface_type = {
+    .name            = TYPE_LOCKED_INTERFACE,
+    .parent          = TYPE_INTERFACE,
+    .class_base_init = locked_interface_class_base_init,
+};
+
+#define TYPE_LOCKED_BY_INTERFACE "locked-by-interface"
+static const TypeInfo locked_by_interface_type = {
+    .name   = TYPE_LOCKED_BY_INTERFACE,
+    .parent = TYPE_OBJECT,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_LOCKED_INTERFACE },
+        { },
+    },
+};
+
+/* Make sure QOM property locking works as expected */
+static void test_proplist_lock(void)
+{
+    g_autoptr(Object) dynamic_obj = object_new(TYPE_DYNAMIC_PROPS);
+    g_autoptr(Object) static_obj = object_new(TYPE_STATIC_PROPS);
+    g_autoptr(Object) locked = object_new(TYPE_LOCKED_BY_INTERFACE);
+    Error *err = NULL;
+
+    /* read-only property: should always work */
+    object_property_try_add(dynamic_obj, "dynamic-prop-ro", "uint32",
+                            prop1_accessor, NULL,
+                            NULL, NULL, &error_abort);
+    object_property_try_add(static_obj, "dynamic-prop-ro", "uint32",
+                            prop1_accessor, NULL,
+                            NULL, NULL, &error_abort);
+    object_property_try_add(locked, "dynamic-prop-ro", "uint32",
+                            prop1_accessor, NULL,
+                            NULL, NULL, &error_abort);
+
+
+    /* read-write property: */
+
+    /* TYPE_DYNAMIC_PROPS is not locked */
+    object_property_try_add(dynamic_obj, "dynamic-prop-rw", "uint32",
+                            prop1_accessor, prop1_accessor,
+                            NULL, NULL, &error_abort);
+
+    /* TYPE_STATIC_PROPS is locked */
+    object_property_try_add(static_obj, "dynamic-prop-rw", "uint32",
+                            prop1_accessor, prop1_accessor,
+                            NULL, NULL, &err);
+    error_free_or_abort(&err);
+
+    /* TYPE_LOCKED_BY_INTERFACE is locked by interface type */
+    object_property_try_add(locked, "dynamic-prop-rw", "uint32",
+                            prop1_accessor, prop1_accessor,
+                            NULL, NULL, &err);
+    error_free_or_abort(&err);
+}
+
+
 /* Test setting of dynamic properties using global properties */
 static void test_dynamic_globalprop_subprocess(void)
 {
@@ -294,6 +360,10 @@ int main(int argc, char **argv)
     type_register_static(&hotplug_type);
     type_register_static(&nohotplug_type);
     type_register_static(&nondevice_type);
+    type_register_static(&locked_interface_type);
+    type_register_static(&locked_by_interface_type);
+
+    g_test_add_func("/qdev/properties/locking", test_proplist_lock);
 
     g_test_add_func("/qdev/properties/static/default/subprocess",
                     test_static_prop_subprocess);
-- 
2.26.2


