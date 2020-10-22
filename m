Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B10AC388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 22:34:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F4D24658
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 22:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gk+60wrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F4D24658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVjAE-0007fU-I0
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 18:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kVj7p-0006Ji-08
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 18:32:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51261)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kVj7l-0007qj-6R
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 18:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603405913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DbvZDt2YjT+OqOP+SYWN4gNFNx/iigt/9Fry3BpCckE=;
 b=Gk+60wrQo7Xu9/VLFHvEodh/3tVRBzws7MbrRptEEtUwhXad55SDvjIqGdsSYpDmtbYSzr
 NmNAOVolKvadVuE+pJmmZMuDJ2T7Lr1sZ+uFNsZrXg6wohtxvsCNxGVGD7aMxiS31oDyLS
 wMSSwtCASpeKoJ+xNe6rPWfWh1QEJZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-m8O5ulxoO92EE6qiO8qzhg-1; Thu, 22 Oct 2020 18:31:51 -0400
X-MC-Unique: m8O5ulxoO92EE6qiO8qzhg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D393800050;
 Thu, 22 Oct 2020 22:31:50 +0000 (UTC)
Received: from localhost (ovpn-66-44.rdu2.redhat.com [10.10.66.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C1B76266E;
 Thu, 22 Oct 2020 22:31:45 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] qom: object*_property_add_bool_ptr() functions
Date: Thu, 22 Oct 2020 18:31:37 -0400
Message-Id: <20201022223140.2083123-2-ehabkost@redhat.com>
In-Reply-To: <20201022223140.2083123-1-ehabkost@redhat.com>
References: <20201022223140.2083123-1-ehabkost@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:09:01
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
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Provide helpers for registering boolean properties that simply
read/write a struct field, to reduce the need to manually write
property getters and setters.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 include/qom/object.h | 23 +++++++++++++++++++++++
 qom/object.c         | 31 +++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index a124cf897d..954a26c567 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1815,6 +1815,29 @@ ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
                                           ptrdiff_t offset,
                                           ObjectPropertyFlags flags);
 
+/**
+ * object_property_add_bool_ptr:
+ * @obj: the object to add a property to
+ * @name: the name of the property
+ * @v: pointer to value
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an bool property in memory.  This function will add a
+ * property of type 'bool'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *
+object_property_add_bool_ptr(Object *obj, const char *name,
+                             bool *v,
+                             ObjectPropertyFlags flags);
+
+ObjectProperty *
+object_class_property_add_bool_ptr(ObjectClass *klass,
+                                   const char *name,
+                                   ptrdiff_t offset,
+                                   ObjectPropertyFlags flags);
+
 /**
  * object_property_add_alias:
  * @obj: the object to add a property to
diff --git a/qom/object.c b/qom/object.c
index 73f27b8b7e..2abc2bda33 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2713,6 +2713,37 @@ object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
                                               flags, offset);
 }
 
+static void property_visit_bool_ptr(Object *obj, Visitor *v, const char *name,
+                                    void *opaque, Error **errp)
+{
+    PointerProperty *prop = opaque;
+    bool *field = pointer_property_get_ptr(obj, prop);
+    visit_type_bool(v, name, field, errp);
+}
+
+ObjectProperty *
+object_property_add_bool_ptr(Object *obj, const char *name,
+                             bool *v,
+                             ObjectPropertyFlags flags)
+{
+    return object_property_add_uint_ptr(obj, name, "bool",
+                                        property_visit_bool_ptr,
+                                        property_visit_bool_ptr,
+                                        flags,
+                                        (void *)v);
+}
+
+ObjectProperty *
+object_class_property_add_bool_ptr(ObjectClass *klass, const char *name,
+                                   ptrdiff_t offset,
+                                   ObjectPropertyFlags flags)
+{
+    return object_class_property_add_uint_ptr(klass, name, "bool",
+                                              property_visit_bool_ptr,
+                                              property_visit_bool_ptr,
+                                              flags, offset);
+}
+
 typedef struct {
     Object *target_obj;
     char *target_name;
-- 
2.28.0


