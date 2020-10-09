Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1131C43467
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:17:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B7332227E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fTlwzfFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7332227E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQxtW-0001j8-50
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 15:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQxrn-0000OR-2b
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:15:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31904)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQxrl-0000PT-BA
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602270944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=APMCuA+kGZhAUSQKhWHMtsGZmjMgpPqNQ7KZLQNpwwI=;
 b=fTlwzfFkFi4k+OSRf8gfzWKKTMQhK8OLb44HIx2pNfSDnAweQfMvDjEjlsDSgxlQNjpn/O
 yLtGeCG9GyqWG9RCsP4lP/4DZyKdRLDr0Uy0UJjLVqLJz/AEftnkNlBELOIvPi8QZ2tuT3
 Eqjg9n+5EjrAShucSLlk3WEhxA2I/1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-SNIYI9pHPjKWbOBaeLk78Q-1; Fri, 09 Oct 2020 15:15:42 -0400
X-MC-Unique: SNIYI9pHPjKWbOBaeLk78Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BA9F1084CA1;
 Fri,  9 Oct 2020 19:15:41 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C97D1A885;
 Fri,  9 Oct 2020 19:15:35 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] qom: Make object_property_add_uint*_ptr() get non-const
 pointers
Date: Fri,  9 Oct 2020 15:15:19 -0400
Message-Id: <20201009191520.1799419-3-ehabkost@redhat.com>
In-Reply-To: <20201009191520.1799419-1-ehabkost@redhat.com>
References: <20201009191520.1799419-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

Currently, the getter/setter functions are awkward because the
visit_type_uint*() functions provided by QAPI will always write a
value to the provided pointer.  Getting a non-const pointer will
allow us to simplify a lot of the getters/setters logic.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/object.h | 8 ++++----
 qom/object.c         | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index a124cf897d..1441807be6 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1744,7 +1744,7 @@ typedef enum {
  * Returns: The newly added property on success, or %NULL on failure.
  */
 ObjectProperty *object_property_add_uint8_ptr(Object *obj, const char *name,
-                                              const uint8_t *v,
+                                              uint8_t *v,
                                               ObjectPropertyFlags flags);
 
 ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
@@ -1765,7 +1765,7 @@ ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
  * Returns: The newly added property on success, or %NULL on failure.
  */
 ObjectProperty *object_property_add_uint16_ptr(Object *obj, const char *name,
-                                    const uint16_t *v,
+                                    uint16_t *v,
                                     ObjectPropertyFlags flags);
 
 ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
@@ -1786,7 +1786,7 @@ ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
  * Returns: The newly added property on success, or %NULL on failure.
  */
 ObjectProperty *object_property_add_uint32_ptr(Object *obj, const char *name,
-                                    const uint32_t *v,
+                                    uint32_t *v,
                                     ObjectPropertyFlags flags);
 
 ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
@@ -1807,7 +1807,7 @@ ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
  * Returns: The newly added property on success, or %NULL on failure.
  */
 ObjectProperty *object_property_add_uint64_ptr(Object *obj, const char *name,
-                                    const uint64_t *v,
+                                    uint64_t *v,
                                     ObjectPropertyFlags flags);
 
 ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
diff --git a/qom/object.c b/qom/object.c
index 73f27b8b7e..6b4dfc279a 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2623,7 +2623,7 @@ object_class_property_add_uint_ptr(ObjectClass *oc, const char *name,
 
 ObjectProperty *
 object_property_add_uint8_ptr(Object *obj, const char *name,
-                              const uint8_t *v,
+                              uint8_t *v,
                               ObjectPropertyFlags flags)
 {
     return object_property_add_uint_ptr(obj, name, "uint8",
@@ -2646,7 +2646,7 @@ object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
 
 ObjectProperty *
 object_property_add_uint16_ptr(Object *obj, const char *name,
-                               const uint16_t *v,
+                               uint16_t *v,
                                ObjectPropertyFlags flags)
 {
     return object_property_add_uint_ptr(obj, name, "uint16",
@@ -2669,7 +2669,7 @@ object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
 
 ObjectProperty *
 object_property_add_uint32_ptr(Object *obj, const char *name,
-                               const uint32_t *v,
+                               uint32_t *v,
                                ObjectPropertyFlags flags)
 {
     return object_property_add_uint_ptr(obj, name, "uint32",
@@ -2692,7 +2692,7 @@ object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
 
 ObjectProperty *
 object_property_add_uint64_ptr(Object *obj, const char *name,
-                               const uint64_t *v,
+                               uint64_t *v,
                                ObjectPropertyFlags flags)
 {
     return object_property_add_uint_ptr(obj, name, "uint64",
-- 
2.26.2


