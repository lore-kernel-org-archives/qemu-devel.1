Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F623C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 095132227E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHaGURhG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095132227E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQxvG-0003Vc-1Z
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 15:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQxrt-0000bV-SS
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:15:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31392)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQxrr-0000S8-SC
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602270951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ogH/FuOlxStCUd7+LcfJbj3FDvyHTMFFmUxuDa2v9/E=;
 b=VHaGURhG9ct8JU6LDzAAjNbqJsGC0k5JuxJQA3MaY8BiHlpw6EfsVZv0UJhUdHzPEDU1Xt
 +eX3jXHAlX+OkkpcZl24wcqwpmf3Lv72AL/MclAyc3NYi8tyG9wRcRVpwTs43CnUsEMZOH
 laGP4mTpYD7RhpgcN2c/kWA3kw3ujN0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-jM3NiHPtPMWWS0LmpjGjUQ-1; Fri, 09 Oct 2020 15:15:49 -0400
X-MC-Unique: jM3NiHPtPMWWS0LmpjGjUQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2216C80403A;
 Fri,  9 Oct 2020 19:15:48 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 531AD5C1BB;
 Fri,  9 Oct 2020 19:15:42 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] qom: Simplify and merge pointer property getters/setters
Date: Fri,  9 Oct 2020 15:15:20 -0400
Message-Id: <20201009191520.1799419-4-ehabkost@redhat.com>
In-Reply-To: <20201009191520.1799419-1-ehabkost@redhat.com>
References: <20201009191520.1799419-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both the property getter and setter for pointer properties can
simply call the visitor functions directly, instead of making
extra copies and requiring additional logic.

Remove the extra copying logic, and merge the getter and setter
functions in object_visit_uint*_ptr() accessors.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qom/object.c | 114 ++++++++++-----------------------------------------
 1 file changed, 22 insertions(+), 92 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 6b4dfc279a..3b343fd118 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2496,119 +2496,57 @@ static void *pointer_property_get_ptr(Object *obj, PointerProperty *prop)
     }
 }
 
-static void property_get_uint8_ptr(Object *obj, Visitor *v, const char *name,
+static void property_visit_uint8_ptr(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
     PointerProperty *prop = opaque;
     uint8_t *field = pointer_property_get_ptr(obj, prop);
-    uint8_t value = *field;
-    visit_type_uint8(v, name, &value, errp);
+    visit_type_uint8(v, name, field, errp);
 }
 
-static void property_set_uint8_ptr(Object *obj, Visitor *v, const char *name,
-                                   void *opaque, Error **errp)
-{
-    PointerProperty *prop = opaque;
-    uint8_t *field = pointer_property_get_ptr(obj, prop);
-    uint8_t value;
-
-    if (!visit_type_uint8(v, name, &value, errp)) {
-        return;
-    }
-
-    *field = value;
-}
-
-static void property_get_uint16_ptr(Object *obj, Visitor *v, const char *name,
+static void property_visit_uint16_ptr(Object *obj, Visitor *v, const char *name,
                                     void *opaque, Error **errp)
 {
     PointerProperty *prop = opaque;
     uint16_t *field = pointer_property_get_ptr(obj, prop);
-    uint16_t value = *field;
-    visit_type_uint16(v, name, &value, errp);
-}
-
-static void property_set_uint16_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
-{
-    PointerProperty *prop = opaque;
-    uint16_t *field = pointer_property_get_ptr(obj, prop);
-    uint16_t value;
-
-    if (!visit_type_uint16(v, name, &value, errp)) {
-        return;
-    }
-
-    *field = value;
+    visit_type_uint16(v, name, field, errp);
 }
 
-static void property_get_uint32_ptr(Object *obj, Visitor *v, const char *name,
+static void property_visit_uint32_ptr(Object *obj, Visitor *v, const char *name,
                                     void *opaque, Error **errp)
 {
     PointerProperty *prop = opaque;
     uint32_t *field = pointer_property_get_ptr(obj, prop);
-    uint32_t value = *field;
-    visit_type_uint32(v, name, &value, errp);
+    visit_type_uint32(v, name, field, errp);
 }
 
-static void property_set_uint32_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
-{
-    PointerProperty *prop = opaque;
-    uint32_t *field = pointer_property_get_ptr(obj, prop);
-    uint32_t value;
-
-    if (!visit_type_uint32(v, name, &value, errp)) {
-        return;
-    }
-
-    *field = value;
-}
-
-static void property_get_uint64_ptr(Object *obj, Visitor *v, const char *name,
+static void property_visit_uint64_ptr(Object *obj, Visitor *v, const char *name,
                                     void *opaque, Error **errp)
 {
     PointerProperty *prop = opaque;
     uint64_t *field = pointer_property_get_ptr(obj, prop);
-    uint64_t value = *field;
-    visit_type_uint64(v, name, &value, errp);
-}
-
-static void property_set_uint64_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
-{
-    PointerProperty *prop = opaque;
-    uint64_t *field = pointer_property_get_ptr(obj, prop);
-    uint64_t value;
-
-    if (!visit_type_uint64(v, name, &value, errp)) {
-        return;
-    }
-
-    *field = value;
+    visit_type_uint64(v, name, field, errp);
 }
 
 static ObjectProperty *
 object_property_add_uint_ptr(Object *obj, const char *name,
                             const char *type,
-                            ObjectPropertyAccessor getter,
-                            ObjectPropertyAccessor setter,
+                            ObjectPropertyAccessor accessor,
                             ObjectPropertyFlags flags,
                             void *ptr)
 {
     PointerProperty *prop = g_new0(PointerProperty, 1);
     prop->ptr = ptr;
     return object_property_add(obj, name, type,
-                               (flags & OBJ_PROP_FLAG_READ) ? getter : NULL,
-                               (flags & OBJ_PROP_FLAG_WRITE) ? setter : NULL,
+                               (flags & OBJ_PROP_FLAG_READ) ? accessor : NULL,
+                               (flags & OBJ_PROP_FLAG_WRITE) ? accessor : NULL,
                                NULL, (void *)prop);
 }
 
 static ObjectProperty *
 object_class_property_add_uint_ptr(ObjectClass *oc, const char *name,
                                    const char *type,
-                                   ObjectPropertyAccessor getter,
-                                   ObjectPropertyAccessor setter,
+                                   ObjectPropertyAccessor accessor,
                                    ObjectPropertyFlags flags,
                                    ptrdiff_t offset)
 {
@@ -2616,8 +2554,8 @@ object_class_property_add_uint_ptr(ObjectClass *oc, const char *name,
     prop->is_offset = true;
     prop->offset = offset;
     return object_class_property_add(oc, name, type,
-                                     (flags & OBJ_PROP_FLAG_READ) ? getter : NULL,
-                                     (flags & OBJ_PROP_FLAG_WRITE) ? setter : NULL,
+                                     (flags & OBJ_PROP_FLAG_READ) ? accessor : NULL,
+                                     (flags & OBJ_PROP_FLAG_WRITE) ? accessor : NULL,
                                      NULL, (void *)prop);
 }
 
@@ -2627,8 +2565,7 @@ object_property_add_uint8_ptr(Object *obj, const char *name,
                               ObjectPropertyFlags flags)
 {
     return object_property_add_uint_ptr(obj, name, "uint8",
-                                        property_get_uint8_ptr,
-                                        property_set_uint8_ptr,
+                                        property_visit_uint8_ptr,
                                         flags,
                                         (void *)v);
 }
@@ -2639,8 +2576,7 @@ object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
                                     ObjectPropertyFlags flags)
 {
     return object_class_property_add_uint_ptr(klass, name, "uint8",
-                                              property_get_uint8_ptr,
-                                              property_set_uint8_ptr,
+                                              property_visit_uint8_ptr,
                                               flags, offset);
 }
 
@@ -2650,8 +2586,7 @@ object_property_add_uint16_ptr(Object *obj, const char *name,
                                ObjectPropertyFlags flags)
 {
     return object_property_add_uint_ptr(obj, name, "uint16",
-                                        property_get_uint16_ptr,
-                                        property_set_uint16_ptr,
+                                        property_visit_uint16_ptr,
                                         flags,
                                         (void *)v);
 }
@@ -2662,8 +2597,7 @@ object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
                                      ObjectPropertyFlags flags)
 {
     return object_class_property_add_uint_ptr(klass, name, "uint16",
-                                              property_get_uint16_ptr,
-                                              property_set_uint16_ptr,
+                                              property_visit_uint16_ptr,
                                               flags, offset);
 }
 
@@ -2673,8 +2607,7 @@ object_property_add_uint32_ptr(Object *obj, const char *name,
                                ObjectPropertyFlags flags)
 {
     return object_property_add_uint_ptr(obj, name, "uint32",
-                                        property_get_uint32_ptr,
-                                        property_set_uint32_ptr,
+                                        property_visit_uint32_ptr,
                                         flags,
                                         (void *)v);
 }
@@ -2685,8 +2618,7 @@ object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
                                      ObjectPropertyFlags flags)
 {
     return object_class_property_add_uint_ptr(klass, name, "uint32",
-                                              property_get_uint32_ptr,
-                                              property_set_uint32_ptr,
+                                              property_visit_uint32_ptr,
                                               flags, offset);
 }
 
@@ -2696,8 +2628,7 @@ object_property_add_uint64_ptr(Object *obj, const char *name,
                                ObjectPropertyFlags flags)
 {
     return object_property_add_uint_ptr(obj, name, "uint64",
-                                        property_get_uint64_ptr,
-                                        property_set_uint64_ptr,
+                                        property_visit_uint64_ptr,
                                         flags,
                                         (void *)v);
 }
@@ -2708,8 +2639,7 @@ object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
                                      ObjectPropertyFlags flags)
 {
     return object_class_property_add_uint_ptr(klass, name, "uint64",
-                                              property_get_uint64_ptr,
-                                              property_set_uint64_ptr,
+                                              property_visit_uint64_ptr,
                                               flags, offset);
 }
 
-- 
2.26.2


