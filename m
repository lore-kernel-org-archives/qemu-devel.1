Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51D4C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:13:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D2C22225D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDlJTjKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2C22225D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQv15-0008EF-Fg
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQupx-0003ig-39
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:01:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQupu-00018S-R7
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602259297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j8o0cMvoB1NfkCAmxv1Vhgzlg9+OlUbpZQtUOLLhGZY=;
 b=dDlJTjKbA0Nx7xFDDOHUhCk9qJedwioSoSoIwOkbdts0mn1Z5UCg1q+udx3b8k77wHehES
 1c1BlFC9p9GEUFktvT8WwBIc1ef+H1Cs9g060RueZcIc07wvXRNEKfRbfHMJUVaku9J9xl
 Jw1tbg7XVeNeefFsDp/+lXGSXMUOZeM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-n1mRpz7cOqmYpS_feHFrNg-1; Fri, 09 Oct 2020 12:01:36 -0400
X-MC-Unique: n1mRpz7cOqmYpS_feHFrNg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40836803F6A
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 16:01:35 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8575D55771;
 Fri,  9 Oct 2020 16:01:31 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/12] qom: Introduce PointerProperty struct
Date: Fri,  9 Oct 2020 12:01:12 -0400
Message-Id: <20201009160122.1662082-3-ehabkost@redhat.com>
In-Reply-To: <20201009160122.1662082-1-ehabkost@redhat.com>
References: <20201009160122.1662082-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

PointerProperty will hold additional info about pointer
properties.  It will allow us to implement more complex logic in
pointer property getters and setters.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 qom/object.c | 46 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 313d2f9834..17692ed5c3 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2449,17 +2449,30 @@ static char *object_get_type(Object *obj, Error **errp)
     return g_strdup(object_get_typename(obj));
 }
 
+typedef struct {
+    /* Pointer to property value */
+    void *ptr;
+} PointerProperty;
+
+static void *pointer_property_get_ptr(Object *obj, PointerProperty *prop)
+{
+    return prop->ptr;
+}
+
 static void property_get_uint8_ptr(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
-    uint8_t value = *(uint8_t *)opaque;
+    PointerProperty *prop = opaque;
+    uint8_t *field = pointer_property_get_ptr(obj, prop);
+    uint8_t value = *field;
     visit_type_uint8(v, name, &value, errp);
 }
 
 static void property_set_uint8_ptr(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
-    uint8_t *field = opaque;
+    PointerProperty *prop = opaque;
+    uint8_t *field = pointer_property_get_ptr(obj, prop);
     uint8_t value;
 
     if (!visit_type_uint8(v, name, &value, errp)) {
@@ -2472,14 +2485,17 @@ static void property_set_uint8_ptr(Object *obj, Visitor *v, const char *name,
 static void property_get_uint16_ptr(Object *obj, Visitor *v, const char *name,
                                     void *opaque, Error **errp)
 {
-    uint16_t value = *(uint16_t *)opaque;
+    PointerProperty *prop = opaque;
+    uint16_t *field = pointer_property_get_ptr(obj, prop);
+    uint16_t value = *field;
     visit_type_uint16(v, name, &value, errp);
 }
 
 static void property_set_uint16_ptr(Object *obj, Visitor *v, const char *name,
                                     void *opaque, Error **errp)
 {
-    uint16_t *field = opaque;
+    PointerProperty *prop = opaque;
+    uint16_t *field = pointer_property_get_ptr(obj, prop);
     uint16_t value;
 
     if (!visit_type_uint16(v, name, &value, errp)) {
@@ -2492,14 +2508,17 @@ static void property_set_uint16_ptr(Object *obj, Visitor *v, const char *name,
 static void property_get_uint32_ptr(Object *obj, Visitor *v, const char *name,
                                     void *opaque, Error **errp)
 {
-    uint32_t value = *(uint32_t *)opaque;
+    PointerProperty *prop = opaque;
+    uint32_t *field = pointer_property_get_ptr(obj, prop);
+    uint32_t value = *field;
     visit_type_uint32(v, name, &value, errp);
 }
 
 static void property_set_uint32_ptr(Object *obj, Visitor *v, const char *name,
                                     void *opaque, Error **errp)
 {
-    uint32_t *field = opaque;
+    PointerProperty *prop = opaque;
+    uint32_t *field = pointer_property_get_ptr(obj, prop);
     uint32_t value;
 
     if (!visit_type_uint32(v, name, &value, errp)) {
@@ -2512,14 +2531,17 @@ static void property_set_uint32_ptr(Object *obj, Visitor *v, const char *name,
 static void property_get_uint64_ptr(Object *obj, Visitor *v, const char *name,
                                     void *opaque, Error **errp)
 {
-    uint64_t value = *(uint64_t *)opaque;
+    PointerProperty *prop = opaque;
+    uint64_t *field = pointer_property_get_ptr(obj, prop);
+    uint64_t value = *field;
     visit_type_uint64(v, name, &value, errp);
 }
 
 static void property_set_uint64_ptr(Object *obj, Visitor *v, const char *name,
                                     void *opaque, Error **errp)
 {
-    uint64_t *field = opaque;
+    PointerProperty *prop = opaque;
+    uint64_t *field = pointer_property_get_ptr(obj, prop);
     uint64_t value;
 
     if (!visit_type_uint64(v, name, &value, errp)) {
@@ -2537,10 +2559,12 @@ object_property_add_uint_ptr(Object *obj, const char *name,
                             ObjectPropertyFlags flags,
                             void *ptr)
 {
+    PointerProperty *prop = g_new0(PointerProperty, 1);
+    prop->ptr = ptr;
     return object_property_add(obj, name, type,
                                (flags & OBJ_PROP_FLAG_READ) ? getter : NULL,
                                (flags & OBJ_PROP_FLAG_WRITE) ? setter : NULL,
-                               NULL, ptr);
+                               NULL, (void *)prop);
 }
 
 static ObjectProperty *
@@ -2551,10 +2575,12 @@ object_class_property_add_uint_ptr(ObjectClass *oc, const char *name,
                                    ObjectPropertyFlags flags,
                                    void *ptr)
 {
+    PointerProperty *prop = g_new0(PointerProperty, 1);
+    prop->ptr = ptr;
     return object_class_property_add(oc, name, type,
                                      (flags & OBJ_PROP_FLAG_READ) ? getter : NULL,
                                      (flags & OBJ_PROP_FLAG_WRITE) ? setter : NULL,
-                                     NULL, ptr);
+                                     NULL, (void *)prop);
 }
 
 ObjectProperty *
-- 
2.26.2


