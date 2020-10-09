Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DA6C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 21:33:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82F2521D6C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 21:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBb8qpLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F2521D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR00t-0005qa-DD
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 17:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQzzX-0005Nt-B1
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 17:31:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45102)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQzzT-0000cV-VK
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 17:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602279110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ypkI9tRVj1LN2UT/ZgT9wIeE2U3jpshUd4zd5TXpgus=;
 b=jBb8qpLDVLmp3vCy7abIPF02bp6ElwjFmy12bXJ4NQOdo1+omuNXRrKOGochM1mDgt0VQ4
 +5nzzFhM9dqA9BYCX7rx30ZwpewzXADN1YZKGGijdZpNtjb1wy9eJC/jcJo/zZynGWAJqs
 3AUKILA1sApiPmpxHQzR2C33tK5k2vI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-pERrSbaIPW2-HC6rsJtBlg-1; Fri, 09 Oct 2020 17:31:48 -0400
X-MC-Unique: pERrSbaIPW2-HC6rsJtBlg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC6F2107AD64
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 21:31:47 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 76B071A3D6;
 Fri,  9 Oct 2020 21:31:44 +0000 (UTC)
Date: Fri, 9 Oct 2020 17:31:43 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] check-qom-proplist: Don't register instance props for
 user-creatable type
Message-ID: <20201009213143.GI7303@habkost.net>
References: <20201009160122.1662082-1-ehabkost@redhat.com>
 <20201009160122.1662082-13-ehabkost@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201009160122.1662082-13-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

user-creatable types will now be forbidden from registering
instance properties, but check-qom-proplist reuse the same type
for testing user_creatable_add_opts() and for testing
class/instance property enumeration.

To address those conflicting requirements, add two subclasses of
TYPE_DUMMY: one that's user-creatable and another one that has
instance properties.  Most test that set the "bv" property will
use the new TYPE_DUMMY_WITH_INSTANCE_PROPS type, but
test_dummy_createcmdl() will now TYPE_DUMMY_USER_CREATABLE.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
The patch
  [RFC] qom: Lock properties of all TYPE_USER_CREATABLE types
will break check-qom-proplist, unless this patch is applied
first.
---
 tests/check-qom-proplist.c | 59 +++++++++++++++++++++++++++-----------
 1 file changed, 43 insertions(+), 16 deletions(-)

diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
index fba30c20b2..e9d0eec0c2 100644
--- a/tests/check-qom-proplist.c
+++ b/tests/check-qom-proplist.c
@@ -124,14 +124,6 @@ static char *dummy_get_sv(Object *obj,
 }
 
 
-static void dummy_init(Object *obj)
-{
-    object_property_add_bool(obj, "bv",
-                             dummy_get_bv,
-                             dummy_set_bv);
-}
-
-
 static void dummy_class_init(ObjectClass *cls, void *data)
 {
     object_class_property_add_str(cls, "sv",
@@ -155,15 +147,48 @@ static void dummy_finalize(Object *obj)
     g_free(dobj->sv);
 }
 
-
 static const TypeInfo dummy_info = {
     .name          = TYPE_DUMMY,
     .parent        = TYPE_OBJECT,
     .instance_size = sizeof(DummyObject),
-    .instance_init = dummy_init,
     .instance_finalize = dummy_finalize,
     .class_size = sizeof(DummyObjectClass),
     .class_init = dummy_class_init,
+};
+
+static void dummy_with_instance_props_init(Object *obj)
+{
+    object_property_add_bool(obj, "bv",
+                             dummy_get_bv,
+                             dummy_set_bv);
+}
+
+/* Subclass of TYPE_DUMMY, but with a instance-level "bv" property */
+#define TYPE_DUMMY_WITH_INSTANCE_PROPS "qemu-dummy-with-intance-props"
+
+static const TypeInfo dummy_with_instance_props_info = {
+    .name          = TYPE_DUMMY_WITH_INSTANCE_PROPS,
+    .parent        = TYPE_DUMMY,
+    .instance_init = dummy_with_instance_props_init,
+};
+
+static void dummy_user_creatable_class_init(ObjectClass *cls, void *data)
+{
+    object_class_property_add_bool(cls, "bv",
+                                   dummy_get_bv,
+                                   dummy_set_bv);
+}
+
+/*
+ * Subclass of TYPE_DUMMY, but user-creatable and with a class-level
+ * "bv" property
+ */
+#define TYPE_DUMMY_USER_CREATABLE      "qemu-dummy-user-creatable"
+
+static const TypeInfo dummy_user_creatable_info = {
+    .name          = TYPE_DUMMY_USER_CREATABLE,
+    .parent        = TYPE_DUMMY,
+    .class_init    = dummy_user_creatable_class_init,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
@@ -341,7 +366,7 @@ static void test_dummy_createv(void)
     Error *err = NULL;
     Object *parent = object_get_objects_root();
     DummyObject *dobj = DUMMY_OBJECT(
-        object_new_with_props(TYPE_DUMMY,
+        object_new_with_props(TYPE_DUMMY_WITH_INSTANCE_PROPS,
                               parent,
                               "dummy0",
                               &err,
@@ -370,7 +395,7 @@ static Object *new_helper(Error **errp,
     Object *obj;
 
     va_start(vargs, parent);
-    obj = object_new_with_propv(TYPE_DUMMY,
+    obj = object_new_with_propv(TYPE_DUMMY_WITH_INSTANCE_PROPS,
                                 parent,
                                 "dummy0",
                                 errp,
@@ -409,7 +434,7 @@ static void test_dummy_createcmdl(void)
     QemuOpts *opts;
     DummyObject *dobj;
     Error *err = NULL;
-    const char *params = TYPE_DUMMY \
+    const char *params = TYPE_DUMMY_USER_CREATABLE \
                          ",id=dev0," \
                          "bv=yes,sv=Hiss hiss hiss,av=platypus";
 
@@ -449,7 +474,7 @@ static void test_dummy_badenum(void)
     Error *err = NULL;
     Object *parent = object_get_objects_root();
     Object *dobj =
-        object_new_with_props(TYPE_DUMMY,
+        object_new_with_props(TYPE_DUMMY_WITH_INSTANCE_PROPS,
                               parent,
                               "dummy0",
                               &err,
@@ -541,7 +566,7 @@ static void test_dummy_iterator(void)
         "bv"};                  /* instance property */
     Object *parent = object_get_objects_root();
     DummyObject *dobj = DUMMY_OBJECT(
-        object_new_with_props(TYPE_DUMMY,
+        object_new_with_props(TYPE_DUMMY_WITH_INSTANCE_PROPS,
                               parent,
                               "dummy0",
                               &error_abort,
@@ -560,7 +585,7 @@ static void test_dummy_class_iterator(void)
 {
     const char *expected[] = { "type", "av", "sv", "u8v" };
     ObjectPropertyIterator iter;
-    ObjectClass *klass = object_class_by_name(TYPE_DUMMY);
+    ObjectClass *klass = object_class_by_name(TYPE_DUMMY_WITH_INSTANCE_PROPS);
 
     object_class_property_iter_init(&iter, klass);
     test_dummy_prop_iterator(&iter, expected, ARRAY_SIZE(expected));
@@ -626,6 +651,8 @@ int main(int argc, char **argv)
 
     module_call_init(MODULE_INIT_QOM);
     type_register_static(&dummy_info);
+    type_register_static(&dummy_with_instance_props_info);
+    type_register_static(&dummy_user_creatable_info);
     type_register_static(&dummy_dev_info);
     type_register_static(&dummy_bus_info);
     type_register_static(&dummy_backend_info);
-- 
2.26.2

-- 
Eduardo


