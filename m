Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B5EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:16:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0FFB2064C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYAekpST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0FFB2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaLSc-0005ZK-K7
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 11:16:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLFN-0002jJ-Bz
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:02:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLFG-0005ch-14
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:02:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604505765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9+RB0ohNZPBr/GZJzS2SbdLTVuV1E5QY+/WtEjuGi3k=;
 b=TYAekpSTX5Li98RVFfyt7tQ0S/UD3sF1ZuS6VnVRRQVZHdpqUyVCjrtnW1moRa+8sjtCqq
 UfeX5y5nraVnzbzSwreOfEH5HGuetHJ5KUIE6g4J6HrZLHLWguK5EKzfmiL1RUKgXYwQc5
 56xG+FEvqt6eWzu4xZXM/VIFGMbwsr8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-xwxdWl-DPKSoyKefpKFftw-1; Wed, 04 Nov 2020 11:02:39 -0500
X-MC-Unique: xwxdWl-DPKSoyKefpKFftw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DDF510506E1;
 Wed,  4 Nov 2020 16:01:39 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D92326266E;
 Wed,  4 Nov 2020 16:01:38 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 18/44] qdev: Avoid using prop->name unnecessarily
Date: Wed,  4 Nov 2020 10:59:55 -0500
Message-Id: <20201104160021.2342108-19-ehabkost@redhat.com>
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already get the property name as argument to the property
getter and setters, we don't need to use prop->name.  This will
make it easier to remove the Property.name field in the future.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
This is a new patch added in series v2
---
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 backends/tpm/tpm_util.c          |  2 +-
 hw/core/qdev-properties-system.c | 14 +++++++-------
 hw/core/qdev-properties.c        |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index e91c21dd4a..dba2f6b04a 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -63,7 +63,7 @@ static void set_tpm(Object *obj, Visitor *v, const char *name, void *opaque,
     s = qemu_find_tpm_be(str);
     if (s == NULL) {
         error_setg(errp, "Property '%s.%s' can't find value '%s'",
-                   object_get_typename(obj), prop->name, str);
+                   object_get_typename(obj), name, str);
     } else if (tpm_backend_init(s, TPM_IF(obj), errp) == 0) {
         *be = s; /* weak reference, avoid cyclic ref */
     }
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 808e7136a0..202abd0e4b 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -141,7 +141,7 @@ static void set_drive_helper(Object *obj, Visitor *v, const char *name,
     }
     if (!blk) {
         error_setg(errp, "Property '%s.%s' can't find value '%s'",
-                   object_get_typename(OBJECT(dev)), prop->name, str);
+                   object_get_typename(OBJECT(dev)), name, str);
         goto fail;
     }
     if (blk_attach_dev(blk, dev) < 0) {
@@ -262,10 +262,10 @@ static void set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
     s = qemu_chr_find(str);
     if (s == NULL) {
         error_setg(errp, "Property '%s.%s' can't find value '%s'",
-                   object_get_typename(obj), prop->name, str);
+                   object_get_typename(obj), name, str);
     } else if (!qemu_chr_fe_init(be, s, errp)) {
         error_prepend(errp, "Property '%s.%s' can't take value '%s': ",
-                      object_get_typename(obj), prop->name, str);
+                      object_get_typename(obj), name, str);
     }
     g_free(str);
 }
@@ -965,7 +965,7 @@ static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
         abort();
     }
 
-    visit_type_enum(v, prop->name, &speed, prop->info->enum_table, errp);
+    visit_type_enum(v, name, &speed, prop->info->enum_table, errp);
 }
 
 static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
@@ -981,7 +981,7 @@ static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (!visit_type_enum(v, prop->name, &speed, prop->info->enum_table,
+    if (!visit_type_enum(v, name, &speed, prop->info->enum_table,
                          errp)) {
         return;
     }
@@ -1050,7 +1050,7 @@ static void get_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
         abort();
     }
 
-    visit_type_enum(v, prop->name, &width, prop->info->enum_table, errp);
+    visit_type_enum(v, name, &width, prop->info->enum_table, errp);
 }
 
 static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
@@ -1066,7 +1066,7 @@ static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (!visit_type_enum(v, prop->name, &width, prop->info->enum_table,
+    if (!visit_type_enum(v, name, &width, prop->info->enum_table,
                          errp)) {
         return;
     }
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index a7bbc1235a..69181ce31d 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -50,7 +50,7 @@ void qdev_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
     Property *prop = opaque;
     int *ptr = qdev_get_prop_ptr(obj, prop);
 
-    visit_type_enum(v, prop->name, ptr, prop->info->enum_table, errp);
+    visit_type_enum(v, name, ptr, prop->info->enum_table, errp);
 }
 
 void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
@@ -65,7 +65,7 @@ void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    visit_type_enum(v, prop->name, ptr, prop->info->enum_table, errp);
+    visit_type_enum(v, name, ptr, prop->info->enum_table, errp);
 }
 
 void qdev_propinfo_set_default_value_enum(ObjectProperty *op,
-- 
2.28.0


