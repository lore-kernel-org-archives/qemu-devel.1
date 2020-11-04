Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D13CC388F9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:27:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A64E20782
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FjLRAGWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A64E20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaMYt-00035L-0p
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 12:27:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaMXQ-0001Gn-A1
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:25:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54574)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaMXO-0008Hr-8Y
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604510733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eUqT7Z0R5qCCVThtevZpaE91ROAxKpPagPd6kCVEmTs=;
 b=FjLRAGWQrDzXPADRytkpEHZsRCNshw0rewks65DcucRj8u/CPTSKn1/ulZubU1dhRJJ0wc
 ffZMsoTyPkZDW1ROR2Ej7Xi9fwApxQAqdQrB29msdvCPt3ydpIWLsINqzBHwAp+1mPEO16
 5feMno9pH1ImXYDGdOR3bUVdpv6/zSI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-GF_OskxJP2Og_Or2BwSJ0w-1; Wed, 04 Nov 2020 12:25:31 -0500
X-MC-Unique: GF_OskxJP2Og_Or2BwSJ0w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE9128049C3;
 Wed,  4 Nov 2020 17:25:30 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75CCE5B4D7;
 Wed,  4 Nov 2020 17:25:30 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/7] qom: Replace void* parameter with Property* on
 PropertyInfo.release
Date: Wed,  4 Nov 2020 12:25:10 -0500
Message-Id: <20201104172512.2381656-6-ehabkost@redhat.com>
In-Reply-To: <20201104172512.2381656-1-ehabkost@redhat.com>
References: <20201104172512.2381656-1-ehabkost@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The release function must interpret the third argument as
Property*.  Change the signature of PropertyInfo.release to
indicate that.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 include/qom/field-property.h     | 11 ++++++++++-
 backends/tpm/tpm_util.c          |  3 +--
 hw/core/qdev-properties-system.c |  6 ++----
 qom/field-property.c             | 13 +++++++++++--
 qom/property-types.c             |  3 +--
 5 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/include/qom/field-property.h b/include/qom/field-property.h
index 438bb25896..1d3bf9699b 100644
--- a/include/qom/field-property.h
+++ b/include/qom/field-property.h
@@ -66,6 +66,15 @@ typedef void FieldAccessor(Object *obj, Visitor *v,
                            const char *name, Property *prop,
                            Error **errp);
 
+/**
+ * typedef FieldRelease:
+ * @obj: the object instance
+ * @name: the name of the property
+ * @prop: Field property definition
+ */
+typedef void FieldRelease(Object *obj, const char *name, Property *prop);
+
+
 /**
  * struct PropertyInfo: information on a specific QOM property type
  */
@@ -91,7 +100,7 @@ struct PropertyInfo {
      * @release: Optional release function, called when the object
      * is destroyed
      */
-    ObjectPropertyRelease *release;
+    FieldRelease *release;
 };
 
 /**
diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index e8837938e5..556e21388c 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -63,9 +63,8 @@ static void set_tpm(Object *obj, Visitor *v, const char *name,
     g_free(str);
 }
 
-static void release_tpm(Object *obj, const char *name, void *opaque)
+static void release_tpm(Object *obj, const char *name, Property *prop)
 {
-    Property *prop = opaque;
     TPMBackend **be = object_field_prop_ptr(obj, prop);
 
     if (*be) {
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 4c649cb4b2..2fdd5863bb 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -176,10 +176,9 @@ static void set_drive_iothread(Object *obj, Visitor *v, const char *name,
     set_drive_helper(obj, v, name, prop, true, errp);
 }
 
-static void release_drive(Object *obj, const char *name, void *opaque)
+static void release_drive(Object *obj, const char *name, Property *prop)
 {
     DeviceState *dev = DEVICE(obj);
-    Property *prop = opaque;
     BlockBackend **ptr = object_field_prop_ptr(obj, prop);
 
     if (*ptr) {
@@ -257,9 +256,8 @@ static void set_chr(Object *obj, Visitor *v, const char *name,
     g_free(str);
 }
 
-static void release_chr(Object *obj, const char *name, void *opaque)
+static void release_chr(Object *obj, const char *name, Property *prop)
 {
-    Property *prop = opaque;
     CharBackend *be = object_field_prop_ptr(obj, prop);
 
     qemu_chr_fe_deinit(be, false);
diff --git a/qom/field-property.c b/qom/field-property.c
index 25a818bb69..865d4929a3 100644
--- a/qom/field-property.c
+++ b/qom/field-property.c
@@ -47,6 +47,15 @@ static ObjectPropertyAccessor *field_prop_setter(const PropertyInfo *info)
     return info->set ? field_prop_set : NULL;
 }
 
+static void field_prop_release(Object *obj, const char *name, void *opaque)
+{
+    Property *prop = opaque;
+    if (prop->info->release) {
+        prop->info->release(obj, name, prop);
+    }
+}
+
+
 ObjectProperty *
 object_property_add_field(Object *obj, const char *name, Property *prop,
                           ObjectPropertyAllowSet allow_set)
@@ -59,7 +68,7 @@ object_property_add_field(Object *obj, const char *name, Property *prop,
     op = object_property_add(obj, name, prop->info->name,
                              field_prop_getter(prop->info),
                              field_prop_setter(prop->info),
-                             prop->info->release,
+                             field_prop_release,
                              prop);
 
     object_property_set_description(obj, name,
@@ -92,7 +101,7 @@ object_class_property_add_field(ObjectClass *oc, const char *name,
                                        name, prop->info->name,
                                        field_prop_getter(prop->info),
                                        field_prop_setter(prop->info),
-                                       prop->info->release,
+                                       field_prop_release,
                                        prop);
     }
     if (prop->set_default) {
diff --git a/qom/property-types.c b/qom/property-types.c
index 82a5932f4a..0182a73e38 100644
--- a/qom/property-types.c
+++ b/qom/property-types.c
@@ -321,9 +321,8 @@ const PropertyInfo prop_info_int64 = {
 
 /* --- string --- */
 
-static void release_string(Object *obj, const char *name, void *opaque)
+static void release_string(Object *obj, const char *name, Property *prop)
 {
-    Property *prop = opaque;
     g_free(*(char **)object_field_prop_ptr(obj, prop));
 }
 
-- 
2.28.0


