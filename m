Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE177C4741F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:25:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FB61206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ly5lE5S/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB61206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaLbK-0002ub-6A
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 11:25:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLFa-0003Ii-Mm
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:03:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31067)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLFS-0005g7-B2
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604505777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uj+NvZ1l8bC6Bvg68x/tC2Tl1TJVsNfvAQrVINpztys=;
 b=Ly5lE5S/WGquTjDo7SqhyoowIQSAm/9K8N/S7KEgX6gX5oxVWuLsMSEVA7IpuAOUFQwhbr
 hW8OrsDIcieMxKhTqt4dQJXyjUIAdQONnDf4XxUkY3N76omBp/ACQnEe20F/mFg6cmFjFs
 sEKM2ntw20QEMlMBjxUqaXhM4tyZyCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-k8LwNk4GOTuAT-e01F-B9w-1; Wed, 04 Nov 2020 11:02:55 -0500
X-MC-Unique: k8LwNk4GOTuAT-e01F-B9w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A1C71888A2F;
 Wed,  4 Nov 2020 16:02:45 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0B235D9CC;
 Wed,  4 Nov 2020 16:02:41 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 43/44] tests: Use field properties at check-qom-proplist
 test case
Date: Wed,  4 Nov 2020 11:00:20 -0500
Message-Id: <20201104160021.2342108-44-ehabkost@redhat.com>
In-Reply-To: <20201104160021.2342108-1-ehabkost@redhat.com>
References: <20201104160021.2342108-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Use field properties for the bool and string properties used at
check-qom-proplist.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v2:
* Redone patch using PROP_* instead of DEFINE_PROP_*
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 include/qom/property-types.h |  2 +-
 tests/check-qom-proplist.c   | 64 +++++-------------------------------
 2 files changed, 10 insertions(+), 56 deletions(-)

diff --git a/include/qom/property-types.h b/include/qom/property-types.h
index a891dffb6e..3a36e1fec5 100644
--- a/include/qom/property-types.h
+++ b/include/qom/property-types.h
@@ -242,7 +242,7 @@ extern const PropertyInfo prop_info_link;
  */
 
 #define FIELD_PROP(def) \
-    ({ static Property _p = def; &p; })
+    ({ static Property _p = def; &_p; })
 
 #define PROP_SIGNED(...) \
     FIELD_PROP(DEFINE_PROP_SIGNED(NULL, __VA_ARGS__))
diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
index 1b76581980..b960df1964 100644
--- a/tests/check-qom-proplist.c
+++ b/tests/check-qom-proplist.c
@@ -26,6 +26,9 @@
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qom/object_interfaces.h"
+#include "qom/field-property.h"
+#include "qom/field-property-internal.h"
+#include "qom/property-types.h"
 
 
 #define TYPE_DUMMY "qemu-dummy"
@@ -68,24 +71,6 @@ struct DummyObjectClass {
 };
 
 
-static void dummy_set_bv(Object *obj,
-                         bool value,
-                         Error **errp)
-{
-    DummyObject *dobj = DUMMY_OBJECT(obj);
-
-    dobj->bv = value;
-}
-
-static bool dummy_get_bv(Object *obj,
-                         Error **errp)
-{
-    DummyObject *dobj = DUMMY_OBJECT(obj);
-
-    return dobj->bv;
-}
-
-
 static void dummy_set_av(Object *obj,
                          int value,
                          Error **errp)
@@ -103,39 +88,18 @@ static int dummy_get_av(Object *obj,
     return dobj->av;
 }
 
-
-static void dummy_set_sv(Object *obj,
-                         const char *value,
-                         Error **errp)
-{
-    DummyObject *dobj = DUMMY_OBJECT(obj);
-
-    g_free(dobj->sv);
-    dobj->sv = g_strdup(value);
-}
-
-static char *dummy_get_sv(Object *obj,
-                          Error **errp)
-{
-    DummyObject *dobj = DUMMY_OBJECT(obj);
-
-    return g_strdup(dobj->sv);
-}
-
-
 static void dummy_init(Object *obj)
 {
-    object_property_add_bool(obj, "bv",
-                             dummy_get_bv,
-                             dummy_set_bv);
+    object_property_add_field(obj, "bv",
+                              PROP_BOOL(DummyObject, bv, false),
+                              prop_allow_set_always);
 }
 
-
 static void dummy_class_init(ObjectClass *cls, void *data)
 {
-    object_class_property_add_str(cls, "sv",
-                                  dummy_get_sv,
-                                  dummy_set_sv);
+    object_class_property_add_field(cls, "sv",
+                                    PROP_STRING(DummyObject, sv),
+                                    prop_allow_set_always);
     object_class_property_add_enum(cls, "av",
                                    "DummyAnimal",
                                    &dummy_animal_map,
@@ -143,21 +107,11 @@ static void dummy_class_init(ObjectClass *cls, void *data)
                                    dummy_set_av);
 }
 
-
-static void dummy_finalize(Object *obj)
-{
-    DummyObject *dobj = DUMMY_OBJECT(obj);
-
-    g_free(dobj->sv);
-}
-
-
 static const TypeInfo dummy_info = {
     .name          = TYPE_DUMMY,
     .parent        = TYPE_OBJECT,
     .instance_size = sizeof(DummyObject),
     .instance_init = dummy_init,
-    .instance_finalize = dummy_finalize,
     .class_size = sizeof(DummyObjectClass),
     .class_init = dummy_class_init,
     .interfaces = (InterfaceInfo[]) {
-- 
2.28.0


