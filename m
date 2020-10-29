Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6CBC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:17:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF465206CB
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7CArYqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF465206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYGEV-0005as-KX
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 18:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG1L-0003W0-KI
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:03:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53435)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG1F-0006bI-VY
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604009017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4HROLlXHlhYMQbZTAf6PS83/wxPe3JxmKVcuywy/oIE=;
 b=f7CArYqUQcryuUfzU8+rpEoLEWxBBtk1DIijzNHi3tIBnZUgjoWqkdsageiYfewmsnsY02
 6XQH1xM0fHuqAPs/KsfiiODfqh6oil+CCsTCENREqzwnk6xCkW93/2HKDkMLcfVCTD8Rf7
 /cJjt/bXGRcPlPBc0A7FEA7SWUnnU+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-N1rOvlYhN_K5PLiadHxQMw-1; Thu, 29 Oct 2020 18:03:35 -0400
X-MC-Unique: N1rOvlYhN_K5PLiadHxQMw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5802D9CC11
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 22:03:34 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7C545B4A4;
 Thu, 29 Oct 2020 22:03:33 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/36] qdev: Move array property creation/registration to
 separate functions
Date: Thu, 29 Oct 2020 18:02:29 -0400
Message-Id: <20201029220246.472693-20-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-1-ehabkost@redhat.com>
References: <20201029220246.472693-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

The array property registration code is hard to follow.  Move the
two steps into separate functions that have clear
responsibilities.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/core/qdev-properties.c | 60 ++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 27c09255d7..1f06dfb5d5 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -588,6 +588,32 @@ typedef struct {
     ObjectPropertyRelease *release;
 } ArrayElementProperty;
 
+/**
+ * Create ArrayElementProperty based on array length property
+ * @array_len_prop (which was previously defined using DEFINE_PROP_ARRAY()).
+ */
+static ArrayElementProperty *array_element_new(Object *obj,
+                                               Property *array_len_prop,
+                                               const char *arrayname,
+                                               int index,
+                                               void *eltptr)
+{
+    char *propname = g_strdup_printf("%s[%d]", arrayname, index);
+    ArrayElementProperty *arrayprop = g_new0(ArrayElementProperty, 1);
+    arrayprop->release = array_len_prop->arrayinfo->release;
+    arrayprop->propname = propname;
+    arrayprop->prop.info = array_len_prop->arrayinfo;
+    arrayprop->prop.name = propname;
+    /* This ugly piece of pointer arithmetic sets up the offset so
+     * that when the underlying get/set hooks call qdev_get_prop_ptr
+     * they get the right answer despite the array element not actually
+     * being inside the device struct.
+     */
+    arrayprop->prop.offset = eltptr - (void *)obj;
+    assert(qdev_get_prop_ptr(obj, &arrayprop->prop) == eltptr);
+    return arrayprop;
+}
+
 /* object property release callback for array element properties:
  * we call the underlying element's property release hook, and
  * then free the memory we allocated when we added the property.
@@ -602,6 +628,18 @@ static void array_element_release(Object *obj, const char *name, void *opaque)
     g_free(p);
 }
 
+static void object_property_add_array_element(Object *obj,
+                                              Property *array_len_prop,
+                                              ArrayElementProperty *prop)
+{
+    object_property_add(obj, prop->prop.name,
+                        prop->prop.info->name,
+                        static_prop_getter(prop->prop.info),
+                        static_prop_setter(prop->prop.info),
+                        array_element_release,
+                        prop);
+}
+
 static void set_prop_arraylen(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
@@ -641,25 +679,9 @@ static void set_prop_arraylen(Object *obj, Visitor *v, const char *name,
      */
     *arrayptr = eltptr = g_malloc0(*alenptr * prop->arrayfieldsize);
     for (i = 0; i < *alenptr; i++, eltptr += prop->arrayfieldsize) {
-        char *propname = g_strdup_printf("%s[%d]", arrayname, i);
-        ArrayElementProperty *arrayprop = g_new0(ArrayElementProperty, 1);
-        arrayprop->release = prop->arrayinfo->release;
-        arrayprop->propname = propname;
-        arrayprop->prop.info = prop->arrayinfo;
-        arrayprop->prop.name = propname;
-        /* This ugly piece of pointer arithmetic sets up the offset so
-         * that when the underlying get/set hooks call qdev_get_prop_ptr
-         * they get the right answer despite the array element not actually
-         * being inside the device struct.
-         */
-        arrayprop->prop.offset = eltptr - (void *)obj;
-        assert(qdev_get_prop_ptr(obj, &arrayprop->prop) == eltptr);
-        object_property_add(obj, propname,
-                            arrayprop->prop.info->name,
-                            static_prop_getter(arrayprop->prop.info),
-                            static_prop_setter(arrayprop->prop.info),
-                            array_element_release,
-                            arrayprop);
+        ArrayElementProperty *elt_prop = array_element_new(obj, prop, arrayname,
+                                                           i, eltptr);
+        object_property_add_array_element(obj, prop, elt_prop);
     }
 }
 
-- 
2.28.0


