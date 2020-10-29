Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56DEC55179
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:12:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 007D7206CA
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UK7tChVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007D7206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYG9z-000748-Gl
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 18:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG16-0003R3-Ep
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:03:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35649)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG12-0006a9-Ip
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604009007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1iU7FBW2AnSjr1/4AFTqBtTUMBpLm1nVKWMNcWb1Dvg=;
 b=UK7tChVO72EB83gdzZGlrUN127saJ059k3wMHsDK4XS2kSBby/yQyozmTEnr5kNKwAty9Q
 yVDgruQE09GU1+z7Y1erurrjs3fD8lIVE4qFk8+4ZflymxYwICckSYbFObWAatCneA5l5g
 ts9/FQH38v/TH9cDYdJnWfIWjYll8qI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-grCTXJQgOX-FnTOWGF5Kkg-1; Thu, 29 Oct 2020 18:03:23 -0400
X-MC-Unique: grCTXJQgOX-FnTOWGF5Kkg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E3061018F7B
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 22:03:22 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C42B1002D48;
 Thu, 29 Oct 2020 22:03:21 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/36] qdev: Wrap getters and setters in separate helpers
Date: Thu, 29 Oct 2020 18:02:23 -0400
Message-Id: <20201029220246.472693-14-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-1-ehabkost@redhat.com>
References: <20201029220246.472693-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

We'll add extra code to the qdev property getters and setters, so
add wrapper functions where additional actions can be performed.

The new functions have a "static_prop_" prefix instead of "qdev_"
because the code will eventually be moved outside
qdev-properties.c, to common QOM code.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/core/qdev-properties.c | 44 +++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 5e010afdb8..aab9e65e97 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -45,6 +45,40 @@ void *qdev_get_prop_ptr(Object *obj, Property *prop)
     return ptr;
 }
 
+static void static_prop_get(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    return prop->info->get(obj, v, name, opaque, errp);
+}
+
+/**
+ * static_prop_getter: Return getter function to be used for property
+ *
+ * Return value can be NULL if @info has no getter function.
+ */
+static ObjectPropertyAccessor *static_prop_getter(const PropertyInfo *info)
+{
+    return info->get ? static_prop_get : NULL;
+}
+
+static void static_prop_set(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    return prop->info->set(obj, v, name, opaque, errp);
+}
+
+/**
+ * static_prop_setter: Return setter function to be used for property
+ *
+ * Return value can be NULL if @info has not setter function.
+ */
+static ObjectPropertyAccessor *static_prop_setter(const PropertyInfo *info)
+{
+    return info->set ? static_prop_set : NULL;
+}
+
 void qdev_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
@@ -687,8 +721,8 @@ static void set_prop_arraylen(Object *obj, Visitor *v, const char *name,
         assert(qdev_get_prop_ptr(obj, &arrayprop->prop) == eltptr);
         object_property_add(obj, propname,
                             arrayprop->prop.info->name,
-                            arrayprop->prop.info->get,
-                            arrayprop->prop.info->set,
+                            static_prop_getter(arrayprop->prop.info),
+                            static_prop_setter(arrayprop->prop.info),
                             array_element_release,
                             arrayprop);
     }
@@ -929,7 +963,8 @@ void qdev_property_add_static(DeviceState *dev, Property *prop)
     assert(!prop->info->create);
 
     op = object_property_add(obj, prop->name, prop->info->name,
-                             prop->info->get, prop->info->set,
+                             static_prop_getter(prop->info),
+                             static_prop_setter(prop->info),
                              prop->info->release,
                              prop);
 
@@ -955,7 +990,8 @@ static void qdev_class_add_property(DeviceClass *klass, Property *prop)
 
         op = object_class_property_add(oc,
                                        prop->name, prop->info->name,
-                                       prop->info->get, prop->info->set,
+                                       static_prop_getter(prop->info),
+                                       static_prop_setter(prop->info),
                                        prop->info->release,
                                        prop);
         if (prop->set_default) {
-- 
2.28.0


