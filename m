Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6670C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 18:02:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97A9320656
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 18:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+cQHHD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A9320656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvljP-00049p-SB
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 14:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvlgF-0001DT-1H
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 13:58:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30146
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvlgD-0005iS-0q
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 13:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594835932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iQ244hAoGi3IzTNV0EQ3THzoSll/6gv8HvDdV/c+20I=;
 b=M+cQHHD1AnwtowOMRwaQj+EszFFtQmLsAUDsBAYz9DzuI7SVkJOZ20dkxqE3lb2ZqkCSp8
 RT6MESHxmrcoI4Qkzr7crQ0cOlb1oMTMst/yWrZhFzGfXb4CXjQgGOJRwq200yq1XC0FiJ
 /j/Yk14B/aFTTNcpgj61zabxPKsGSic=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-iC2Wp-ZMMNGFVJNvvIgfDQ-1; Wed, 15 Jul 2020 13:58:49 -0400
X-MC-Unique: iC2Wp-ZMMNGFVJNvvIgfDQ-1
Received: by mail-wr1-f70.google.com with SMTP id d11so1836721wrw.12
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 10:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iQ244hAoGi3IzTNV0EQ3THzoSll/6gv8HvDdV/c+20I=;
 b=eiZO5xNG20ZbvDMznnyDXcrYycLXT7mFhwH/E2dxpQU5HNZv8VQ2kO7sSaoFwrDWKB
 I06MFu68zJSv8B3rLYnWpilfhutqbkDnGPWxQYEvWJNeIEJBbbCe4JjnDlUAvD4T8Kt4
 u42Wf4d8X92poO7Qoxvp65A03wY5g2bfPgTAMVxErxyGjsWu7RTXsKR/DfsBxUIah2Pl
 bd1tU3NhK5equy4sm3yIVpj5+26JMvme2nRkdRXctaA/lm3sL7AapUq9GeU7v1gb6Fkx
 oWw7hhbXxG1xlj/f1CWKtxG/Wx/BXXsnpa15mqt1aoW+LPrDe3n/47PgF8Ij7esv9J++
 FWUw==
X-Gm-Message-State: AOAM533ng0i2Yw3SFPgBOpyXJM3NoxiCwZlc3nUZTq+BGPK/+6vQRdfy
 b3WL2DHippe2IRBJJSJ0MUgzp/ju+iVQLCfJu8wt2Yxw8ApXsM/uG0godJBEVIwoo/mTvinvUxi
 pYpKclefn2/AOQ9I=
X-Received: by 2002:adf:e684:: with SMTP id r4mr589109wrm.68.1594835927507;
 Wed, 15 Jul 2020 10:58:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgtfI0B57HqY3KN+gYhw8igk1TciTa0cEJZVEIhF87GAKjFLQsvm38a98uUXsW+H1iccQ8VA==
X-Received: by 2002:adf:e684:: with SMTP id r4mr589089wrm.68.1594835927244;
 Wed, 15 Jul 2020 10:58:47 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id v15sm4205562wmh.24.2020.07.15.10.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 10:58:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH-for-5.2 2/5] qom: Split ObjectPropertyAccessor as
 ObjectProperty[Get/Set]
Date: Wed, 15 Jul 2020 19:58:32 +0200
Message-Id: <20200715175835.27744-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200715175835.27744-1-philmd@redhat.com>
References: <20200715175835.27744-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:37:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To make refactors easier, split the common ObjectPropertyAccessor
type definition into ObjectPropertyGet() and ObjectPropertySet().

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/qdev-core.h |  4 ++--
 include/qom/object.h   | 48 ++++++++++++++++++++++++++++--------------
 hw/ppc/spapr_caps.c    |  4 ++--
 qom/object.c           | 44 +++++++++++++++++++-------------------
 4 files changed, 58 insertions(+), 42 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index fe78073c70..e2930beab8 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -287,8 +287,8 @@ struct PropertyInfo {
     int (*print)(DeviceState *dev, Property *prop, char *dest, size_t len);
     void (*set_default_value)(ObjectProperty *op, const Property *prop);
     void (*create)(ObjectClass *oc, Property *prop);
-    ObjectPropertyAccessor *get;
-    ObjectPropertyAccessor *set;
+    ObjectPropertyGet *get;
+    ObjectPropertySet *set;
     ObjectPropertyRelease *release;
 };
 
diff --git a/include/qom/object.h b/include/qom/object.h
index 79c8f838b6..e9496ba970 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -310,20 +310,36 @@ typedef struct InterfaceInfo InterfaceInfo;
 typedef struct ObjectProperty ObjectProperty;
 
 /**
- * ObjectPropertyAccessor:
+ * ObjectPropertySet:
  * @obj: the object that owns the property
  * @v: the visitor that contains the property data
  * @name: the name of the property
  * @opaque: the object property opaque
- * @errp: a pointer to an Error that is filled if getting/setting fails.
+ * @errp: a pointer to an Error that is filled if setting fails.
  *
- * Called when trying to get/set a property.
+ * Called when trying to set a property.
  */
-typedef void (ObjectPropertyAccessor)(Object *obj,
-                                      Visitor *v,
-                                      const char *name,
-                                      void *opaque,
-                                      Error **errp);
+typedef void (ObjectPropertySet)(Object *obj,
+                                 Visitor *v,
+                                 const char *name,
+                                 void *opaque,
+                                 Error **errp);
+
+/**
+ * ObjectPropertyGet:
+ * @obj: the object that owns the property
+ * @v: the visitor that contains the property data
+ * @name: the name of the property
+ * @opaque: the object property opaque
+ * @errp: a pointer to an Error that is filled if getting fails.
+ *
+ * Called when trying to get a property.
+ */
+typedef void (ObjectPropertyGet)(Object *obj,
+                                 Visitor *v,
+                                 const char *name,
+                                 void *opaque,
+                                 Error **errp);
 
 /**
  * ObjectPropertyResolve:
@@ -370,8 +386,8 @@ struct ObjectProperty
     char *name;
     char *type;
     char *description;
-    ObjectPropertyAccessor *get;
-    ObjectPropertyAccessor *set;
+    ObjectPropertyGet *get;
+    ObjectPropertySet *set;
     ObjectPropertyResolve *resolve;
     ObjectPropertyRelease *release;
     ObjectPropertyInit *init;
@@ -1071,8 +1087,8 @@ void object_unref(Object *obj);
  */
 ObjectProperty *object_property_try_add(Object *obj, const char *name,
                                         const char *type,
-                                        ObjectPropertyAccessor *get,
-                                        ObjectPropertyAccessor *set,
+                                        ObjectPropertyGet *get,
+                                        ObjectPropertySet *set,
                                         ObjectPropertyRelease *release,
                                         void *opaque, Error **errp);
 
@@ -1083,8 +1099,8 @@ ObjectProperty *object_property_try_add(Object *obj, const char *name,
  */
 ObjectProperty *object_property_add(Object *obj, const char *name,
                                     const char *type,
-                                    ObjectPropertyAccessor *get,
-                                    ObjectPropertyAccessor *set,
+                                    ObjectPropertyGet *get,
+                                    ObjectPropertySet *set,
                                     ObjectPropertyRelease *release,
                                     void *opaque);
 
@@ -1092,8 +1108,8 @@ void object_property_del(Object *obj, const char *name);
 
 ObjectProperty *object_class_property_add(ObjectClass *klass, const char *name,
                                           const char *type,
-                                          ObjectPropertyAccessor *get,
-                                          ObjectPropertyAccessor *set,
+                                          ObjectPropertyGet *get,
+                                          ObjectPropertySet *set,
                                           ObjectPropertyRelease *release,
                                           void *opaque);
 
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 3225fc5a2e..7558db0c8b 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -58,8 +58,8 @@ typedef struct SpaprCapabilityInfo {
     int index;
 
     /* Getter and Setter Function Pointers */
-    ObjectPropertyAccessor *get;
-    ObjectPropertyAccessor *set;
+    ObjectPropertyGet *get;
+    ObjectPropertySet *set;
     const char *type;
     /* Possible values if this is a custom string type */
     SpaprCapPossible *possible;
diff --git a/qom/object.c b/qom/object.c
index 76f5f75239..e5324f2af7 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1148,8 +1148,8 @@ void object_unref(Object *obj)
 
 ObjectProperty *
 object_property_try_add(Object *obj, const char *name, const char *type,
-                        ObjectPropertyAccessor *get,
-                        ObjectPropertyAccessor *set,
+                        ObjectPropertyGet *get,
+                        ObjectPropertySet *set,
                         ObjectPropertyRelease *release,
                         void *opaque, Error **errp)
 {
@@ -1198,8 +1198,8 @@ object_property_try_add(Object *obj, const char *name, const char *type,
 
 ObjectProperty *
 object_property_add(Object *obj, const char *name, const char *type,
-                    ObjectPropertyAccessor *get,
-                    ObjectPropertyAccessor *set,
+                    ObjectPropertyGet *get,
+                    ObjectPropertySet *set,
                     ObjectPropertyRelease *release,
                     void *opaque)
 {
@@ -1211,8 +1211,8 @@ ObjectProperty *
 object_class_property_add(ObjectClass *klass,
                           const char *name,
                           const char *type,
-                          ObjectPropertyAccessor *get,
-                          ObjectPropertyAccessor *set,
+                          ObjectPropertyGet *get,
+                          ObjectPropertySet *set,
                           ObjectPropertyRelease *release,
                           void *opaque)
 {
@@ -2486,8 +2486,8 @@ object_property_add_uint8_ptr(Object *obj, const char *name,
                               const uint8_t *v,
                               ObjectPropertyFlags flags)
 {
-    ObjectPropertyAccessor *getter = NULL;
-    ObjectPropertyAccessor *setter = NULL;
+    ObjectPropertyGet *getter = NULL;
+    ObjectPropertySet *setter = NULL;
 
     if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
         getter = property_get_uint8_ptr;
@@ -2506,8 +2506,8 @@ object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
                                     const uint8_t *v,
                                     ObjectPropertyFlags flags)
 {
-    ObjectPropertyAccessor *getter = NULL;
-    ObjectPropertyAccessor *setter = NULL;
+    ObjectPropertyGet *getter = NULL;
+    ObjectPropertySet *setter = NULL;
 
     if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
         getter = property_get_uint8_ptr;
@@ -2526,8 +2526,8 @@ object_property_add_uint16_ptr(Object *obj, const char *name,
                                const uint16_t *v,
                                ObjectPropertyFlags flags)
 {
-    ObjectPropertyAccessor *getter = NULL;
-    ObjectPropertyAccessor *setter = NULL;
+    ObjectPropertyGet *getter = NULL;
+    ObjectPropertySet *setter = NULL;
 
     if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
         getter = property_get_uint16_ptr;
@@ -2546,8 +2546,8 @@ object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
                                      const uint16_t *v,
                                      ObjectPropertyFlags flags)
 {
-    ObjectPropertyAccessor *getter = NULL;
-    ObjectPropertyAccessor *setter = NULL;
+    ObjectPropertyGet *getter = NULL;
+    ObjectPropertySet *setter = NULL;
 
     if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
         getter = property_get_uint16_ptr;
@@ -2566,8 +2566,8 @@ object_property_add_uint32_ptr(Object *obj, const char *name,
                                const uint32_t *v,
                                ObjectPropertyFlags flags)
 {
-    ObjectPropertyAccessor *getter = NULL;
-    ObjectPropertyAccessor *setter = NULL;
+    ObjectPropertyGet *getter = NULL;
+    ObjectPropertySet *setter = NULL;
 
     if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
         getter = property_get_uint32_ptr;
@@ -2586,8 +2586,8 @@ object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
                                      const uint32_t *v,
                                      ObjectPropertyFlags flags)
 {
-    ObjectPropertyAccessor *getter = NULL;
-    ObjectPropertyAccessor *setter = NULL;
+    ObjectPropertyGet *getter = NULL;
+    ObjectPropertySet *setter = NULL;
 
     if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
         getter = property_get_uint32_ptr;
@@ -2606,8 +2606,8 @@ object_property_add_uint64_ptr(Object *obj, const char *name,
                                const uint64_t *v,
                                ObjectPropertyFlags flags)
 {
-    ObjectPropertyAccessor *getter = NULL;
-    ObjectPropertyAccessor *setter = NULL;
+    ObjectPropertyGet *getter = NULL;
+    ObjectPropertySet *setter = NULL;
 
     if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
         getter = property_get_uint64_ptr;
@@ -2626,8 +2626,8 @@ object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
                                      const uint64_t *v,
                                      ObjectPropertyFlags flags)
 {
-    ObjectPropertyAccessor *getter = NULL;
-    ObjectPropertyAccessor *setter = NULL;
+    ObjectPropertyGet *getter = NULL;
+    ObjectPropertySet *setter = NULL;
 
     if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
         getter = property_get_uint64_ptr;
-- 
2.21.3


