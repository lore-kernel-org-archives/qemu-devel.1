Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E53C4741F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:13:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A48A2074B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cDpkyGKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A48A2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaLPB-00007C-VS
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 11:13:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLFZ-0003FV-Cj
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:03:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLFP-0005fK-E1
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604505774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0sT4tpQsx17JiJ7B1qaX/V9FQ6cli7bMhcm2UKKNARo=;
 b=cDpkyGKnDhpQgOGkDfn2xFl9ou7v5bUVo6lXu2wKHX3LX1AznwsOlHOp/e749vCRuf1nfm
 70zj81iBVNFj0Oa9UxnjXdyysX2X2D6QezCt606gwNuIKPmdzQFJQ2EZ+79lDZIiXhALZN
 IgtH7wJ8THpgo4yatMMwd1mwAYXYIHE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-Pye1aa0OMQOMM76YyZnDYg-1; Wed, 04 Nov 2020 11:02:51 -0500
X-MC-Unique: Pye1aa0OMQOMM76YyZnDYg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5C56196635B;
 Wed,  4 Nov 2020 16:02:01 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 66E536266E;
 Wed,  4 Nov 2020 16:02:01 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 30/44] qdev: Get rid of ArrayElementProperty struct
Date: Wed,  4 Nov 2020 11:00:07 -0500
Message-Id: <20201104160021.2342108-31-ehabkost@redhat.com>
In-Reply-To: <20201104160021.2342108-1-ehabkost@redhat.com>
References: <20201104160021.2342108-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Now that we don't store any additional data about the property in
AraryElementStruct, we don't need it anymore.  We can just
allocate a Property struct directly.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
This is a new patch added in v2 of the series
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/core/qdev-properties.c | 41 ++++++++-------------------------------
 1 file changed, 8 insertions(+), 33 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index a0192c3723..0aa482b3ab 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -525,30 +525,6 @@ const PropertyInfo qdev_prop_size32 = {
 
 /* --- support for array properties --- */
 
-/* Used as an opaque for the object properties we add for each
- * array element. Note that the struct Property must be first
- * in the struct so that a pointer to this works as the opaque
- * for the underlying element's property hooks as well as for
- * our own release callback.
- */
-typedef struct {
-    struct Property prop;
-    ObjectPropertyRelease *release;
-} ArrayElementProperty;
-
-/* object property release callback for array element properties:
- * we call the underlying element's property release hook, and
- * then free the memory we allocated when we added the property.
- */
-static void array_element_release(Object *obj, const char *name, void *opaque)
-{
-    ArrayElementProperty *p = opaque;
-    if (p->release) {
-        p->release(obj, name, opaque);
-    }
-    g_free(p);
-}
-
 static void set_prop_arraylen(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
@@ -589,21 +565,20 @@ static void set_prop_arraylen(Object *obj, Visitor *v, const char *name,
     *arrayptr = eltptr = g_malloc0(*alenptr * prop->arrayfieldsize);
     for (i = 0; i < *alenptr; i++, eltptr += prop->arrayfieldsize) {
         g_autofree char *propname = g_strdup_printf("%s[%d]", arrayname, i);
-        ArrayElementProperty *arrayprop = g_new0(ArrayElementProperty, 1);
-        arrayprop->release = prop->arrayinfo->release;
-        arrayprop->prop.info = prop->arrayinfo;
+        Property *arrayprop = g_new0(Property, 1);
+        arrayprop->info = prop->arrayinfo;
         /* This ugly piece of pointer arithmetic sets up the offset so
          * that when the underlying get/set hooks call qdev_get_prop_ptr
          * they get the right answer despite the array element not actually
          * being inside the device struct.
          */
-        arrayprop->prop.offset = eltptr - (void *)obj;
-        assert(qdev_get_prop_ptr(obj, &arrayprop->prop) == eltptr);
+        arrayprop->offset = eltptr - (void *)obj;
+        assert(qdev_get_prop_ptr(obj, arrayprop) == eltptr);
         object_property_add(obj, propname,
-                            arrayprop->prop.info->name,
-                            field_prop_getter(arrayprop->prop.info),
-                            field_prop_setter(arrayprop->prop.info),
-                            array_element_release,
+                            arrayprop->info->name,
+                            field_prop_getter(arrayprop->info),
+                            field_prop_setter(arrayprop->info),
+                            arrayprop->info->release,
                             arrayprop);
     }
 }
-- 
2.28.0


