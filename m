Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7759C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FC5F206CA
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GrofQy1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC5F206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQv0I-0007UA-5T
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQupt-0003go-8O
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:01:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24082)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQupp-000171-W9
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602259293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4X/fvZ/kZi/UkfY7ztpZ4N45ePgMV+T6iAaFy/ZC2/A=;
 b=GrofQy1rMjICp3oFviIcjirhDlWiPrVWEzSXTuDnQfZylH6PemH/hhZx0qyl7dkPx3sy0f
 zkqCPgxtvz4lZBtt2qAYkmhoa5qgxTQWkcvVIJKciACd7bzrhOHVhTSE2aVNkc68+vnU/b
 /l7J+5bksZl6oGgIw/8gyrWAviNdbj0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-ATYSDo_-MtaGmm9dTltc7A-1; Fri, 09 Oct 2020 12:01:31 -0400
X-MC-Unique: ATYSDo_-MtaGmm9dTltc7A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8418818A8233
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 16:01:30 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4982F5C1C7;
 Fri,  9 Oct 2020 16:01:27 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/12] qom: Helpers for pointer properties
Date: Fri,  9 Oct 2020 12:01:11 -0400
Message-Id: <20201009160122.1662082-2-ehabkost@redhat.com>
In-Reply-To: <20201009160122.1662082-1-ehabkost@redhat.com>
References: <20201009160122.1662082-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reduce some code duplication and make future refactoring easier,
by adding object_property_add_uint_ptr() and
object_class_property_add_uint_ptr() helpers.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 qom/object.c | 168 ++++++++++++++++++++-------------------------------
 1 file changed, 64 insertions(+), 104 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 1065355233..313d2f9834 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2529,24 +2529,44 @@ static void property_set_uint64_ptr(Object *obj, Visitor *v, const char *name,
     *field = value;
 }
 
+static ObjectProperty *
+object_property_add_uint_ptr(Object *obj, const char *name,
+                            const char *type,
+                            ObjectPropertyAccessor getter,
+                            ObjectPropertyAccessor setter,
+                            ObjectPropertyFlags flags,
+                            void *ptr)
+{
+    return object_property_add(obj, name, type,
+                               (flags & OBJ_PROP_FLAG_READ) ? getter : NULL,
+                               (flags & OBJ_PROP_FLAG_WRITE) ? setter : NULL,
+                               NULL, ptr);
+}
+
+static ObjectProperty *
+object_class_property_add_uint_ptr(ObjectClass *oc, const char *name,
+                                   const char *type,
+                                   ObjectPropertyAccessor getter,
+                                   ObjectPropertyAccessor setter,
+                                   ObjectPropertyFlags flags,
+                                   void *ptr)
+{
+    return object_class_property_add(oc, name, type,
+                                     (flags & OBJ_PROP_FLAG_READ) ? getter : NULL,
+                                     (flags & OBJ_PROP_FLAG_WRITE) ? setter : NULL,
+                                     NULL, ptr);
+}
+
 ObjectProperty *
 object_property_add_uint8_ptr(Object *obj, const char *name,
                               const uint8_t *v,
                               ObjectPropertyFlags flags)
 {
-    ObjectPropertyAccessor *getter = NULL;
-    ObjectPropertyAccessor *setter = NULL;
-
-    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
-        getter = property_get_uint8_ptr;
-    }
-
-    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
-        setter = property_set_uint8_ptr;
-    }
-
-    return object_property_add(obj, name, "uint8",
-                               getter, setter, NULL, (void *)v);
+    return object_property_add_uint_ptr(obj, name, "uint8",
+                                        property_get_uint8_ptr,
+                                        property_set_uint8_ptr,
+                                        flags,
+                                        (void *)v);
 }
 
 ObjectProperty *
@@ -2554,19 +2574,10 @@ object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
                                     const uint8_t *v,
                                     ObjectPropertyFlags flags)
 {
-    ObjectPropertyAccessor *getter = NULL;
-    ObjectPropertyAccessor *setter = NULL;
-
-    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
-        getter = property_get_uint8_ptr;
-    }
-
-    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
-        setter = property_set_uint8_ptr;
-    }
-
-    return object_class_property_add(klass, name, "uint8",
-                                     getter, setter, NULL, (void *)v);
+    return object_class_property_add_uint_ptr(klass, name, "uint8",
+                                              property_get_uint8_ptr,
+                                              property_set_uint8_ptr,
+                                              flags, (void *)v);
 }
 
 ObjectProperty *
@@ -2574,19 +2585,11 @@ object_property_add_uint16_ptr(Object *obj, const char *name,
                                const uint16_t *v,
                                ObjectPropertyFlags flags)
 {
-    ObjectPropertyAccessor *getter = NULL;
-    ObjectPropertyAccessor *setter = NULL;
-
-    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
-        getter = property_get_uint16_ptr;
-    }
-
-    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
-        setter = property_set_uint16_ptr;
-    }
-
-    return object_property_add(obj, name, "uint16",
-                               getter, setter, NULL, (void *)v);
+    return object_property_add_uint_ptr(obj, name, "uint16",
+                                        property_get_uint16_ptr,
+                                        property_set_uint16_ptr,
+                                        flags,
+                                        (void *)v);
 }
 
 ObjectProperty *
@@ -2594,19 +2597,10 @@ object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
                                      const uint16_t *v,
                                      ObjectPropertyFlags flags)
 {
-    ObjectPropertyAccessor *getter = NULL;
-    ObjectPropertyAccessor *setter = NULL;
-
-    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
-        getter = property_get_uint16_ptr;
-    }
-
-    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
-        setter = property_set_uint16_ptr;
-    }
-
-    return object_class_property_add(klass, name, "uint16",
-                                     getter, setter, NULL, (void *)v);
+    return object_class_property_add_uint_ptr(klass, name, "uint16",
+                                              property_get_uint16_ptr,
+                                              property_set_uint16_ptr,
+                                              flags, (void *)v);
 }
 
 ObjectProperty *
@@ -2614,19 +2608,11 @@ object_property_add_uint32_ptr(Object *obj, const char *name,
                                const uint32_t *v,
                                ObjectPropertyFlags flags)
 {
-    ObjectPropertyAccessor *getter = NULL;
-    ObjectPropertyAccessor *setter = NULL;
-
-    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
-        getter = property_get_uint32_ptr;
-    }
-
-    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
-        setter = property_set_uint32_ptr;
-    }
-
-    return object_property_add(obj, name, "uint32",
-                               getter, setter, NULL, (void *)v);
+    return object_property_add_uint_ptr(obj, name, "uint32",
+                                        property_get_uint32_ptr,
+                                        property_set_uint32_ptr,
+                                        flags,
+                                        (void *)v);
 }
 
 ObjectProperty *
@@ -2634,19 +2620,10 @@ object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
                                      const uint32_t *v,
                                      ObjectPropertyFlags flags)
 {
-    ObjectPropertyAccessor *getter = NULL;
-    ObjectPropertyAccessor *setter = NULL;
-
-    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
-        getter = property_get_uint32_ptr;
-    }
-
-    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
-        setter = property_set_uint32_ptr;
-    }
-
-    return object_class_property_add(klass, name, "uint32",
-                                     getter, setter, NULL, (void *)v);
+    return object_class_property_add_uint_ptr(klass, name, "uint32",
+                                              property_get_uint32_ptr,
+                                              property_set_uint32_ptr,
+                                              flags, (void *)v);
 }
 
 ObjectProperty *
@@ -2654,19 +2631,11 @@ object_property_add_uint64_ptr(Object *obj, const char *name,
                                const uint64_t *v,
                                ObjectPropertyFlags flags)
 {
-    ObjectPropertyAccessor *getter = NULL;
-    ObjectPropertyAccessor *setter = NULL;
-
-    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
-        getter = property_get_uint64_ptr;
-    }
-
-    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
-        setter = property_set_uint64_ptr;
-    }
-
-    return object_property_add(obj, name, "uint64",
-                               getter, setter, NULL, (void *)v);
+    return object_property_add_uint_ptr(obj, name, "uint64",
+                                        property_get_uint64_ptr,
+                                        property_set_uint64_ptr,
+                                        flags,
+                                        (void *)v);
 }
 
 ObjectProperty *
@@ -2674,19 +2643,10 @@ object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
                                      const uint64_t *v,
                                      ObjectPropertyFlags flags)
 {
-    ObjectPropertyAccessor *getter = NULL;
-    ObjectPropertyAccessor *setter = NULL;
-
-    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
-        getter = property_get_uint64_ptr;
-    }
-
-    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
-        setter = property_set_uint64_ptr;
-    }
-
-    return object_class_property_add(klass, name, "uint64",
-                                     getter, setter, NULL, (void *)v);
+    return object_class_property_add_uint_ptr(klass, name, "uint64",
+                                              property_get_uint64_ptr,
+                                              property_set_uint64_ptr,
+                                              flags, (void *)v);
 }
 
 typedef struct {
-- 
2.26.2


