Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97C2C388F9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:08:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 661E620825
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2SIX7Jo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 661E620825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaLL4-0001xQ-6t
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 11:08:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLFG-0002R8-CQ
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:02:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24928)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLF8-0005bQ-MV
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604505757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cQkyAB5uO5eBdwxS0N1a5YFH1on9Cak26DvNwadfjjc=;
 b=U2SIX7JoVYCoq81TWqXdrRLzjfxFVJJzF6shxJUskpWGXfkJa8iZrzecJ7SXXkEXoFUXJI
 BGQWE8xJqzXui5EgKW2MuKsz91cp4ZWqQ7N9MUEFAyKVzt+FtmMAuCo8r1g9iH4tMwQ4U7
 JjSCyPumcIvNixdBnQKp4Xf9IM92avU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-ZcIhgctjPkCe0GM9EwOyiw-1; Wed, 04 Nov 2020 11:02:35 -0500
X-MC-Unique: ZcIhgctjPkCe0GM9EwOyiw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BF81101F012;
 Wed,  4 Nov 2020 16:01:31 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC53973675;
 Wed,  4 Nov 2020 16:01:30 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/44] qdev: Move UUID property to qdev-properties-system.c
Date: Wed,  4 Nov 2020 10:59:50 -0500
Message-Id: <20201104160021.2342108-14-ehabkost@redhat.com>
In-Reply-To: <20201104160021.2342108-1-ehabkost@redhat.com>
References: <20201104160021.2342108-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only softmmu code uses DEFINE_PROP_UUID, and it currently depends
on error_set_from_qdev_prop_error().  Move it to
qdev-properties-system.c to get out of our way when refactoring
the qdev property system.

We can eventually move it back to the core property system later,
after removing usage of error_set_from_qdev_prop_error().

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
This is a new patch added in series v2
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/core/qdev-properties-system.c | 57 ++++++++++++++++++++++++++++++++
 hw/core/qdev-properties.c        | 57 --------------------------------
 2 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index fca1b694ca..35515886a9 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -21,6 +21,7 @@
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/units.h"
+#include "qemu/uuid.h"
 #include "qemu/error-report.h"
 #include "qdev-prop-internal.h"
 
@@ -1105,3 +1106,59 @@ const PropertyInfo qdev_prop_pcie_link_width = {
     .set = set_prop_pcielinkwidth,
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
+
+/* --- UUID --- */
+
+static void get_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
+                     Error **errp)
+{
+    Property *prop = opaque;
+    QemuUUID *uuid = qdev_get_prop_ptr(obj, prop);
+    char buffer[UUID_FMT_LEN + 1];
+    char *p = buffer;
+
+    qemu_uuid_unparse(uuid, buffer);
+
+    visit_type_str(v, name, &p, errp);
+}
+
+#define UUID_VALUE_AUTO        "auto"
+
+static void set_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
+                    Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    QemuUUID *uuid = qdev_get_prop_ptr(obj, prop);
+    char *str;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    if (!visit_type_str(v, name, &str, errp)) {
+        return;
+    }
+
+    if (!strcmp(str, UUID_VALUE_AUTO)) {
+        qemu_uuid_generate(uuid);
+    } else if (qemu_uuid_parse(str, uuid) < 0) {
+        error_set_from_qdev_prop_error(errp, EINVAL, obj, prop, str);
+    }
+    g_free(str);
+}
+
+static void set_default_uuid_auto(ObjectProperty *op, const Property *prop)
+{
+    object_property_set_default_str(op, UUID_VALUE_AUTO);
+}
+
+const PropertyInfo qdev_prop_uuid = {
+    .name  = "str",
+    .description = "UUID (aka GUID) or \"" UUID_VALUE_AUTO
+        "\" for random value (default)",
+    .get   = get_uuid,
+    .set   = set_uuid,
+    .set_default_value = set_default_uuid_auto,
+};
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 5e010afdb8..d7796e8cc3 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -6,7 +6,6 @@
 #include "qemu/ctype.h"
 #include "qemu/error-report.h"
 #include "qapi/visitor.h"
-#include "qemu/uuid.h"
 #include "qemu/units.h"
 #include "qemu/cutils.h"
 #include "qdev-prop-internal.h"
@@ -544,62 +543,6 @@ const PropertyInfo qdev_prop_size32 = {
     .set_default_value = qdev_propinfo_set_default_value_uint,
 };
 
-/* --- UUID --- */
-
-static void get_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
-                     Error **errp)
-{
-    Property *prop = opaque;
-    QemuUUID *uuid = qdev_get_prop_ptr(obj, prop);
-    char buffer[UUID_FMT_LEN + 1];
-    char *p = buffer;
-
-    qemu_uuid_unparse(uuid, buffer);
-
-    visit_type_str(v, name, &p, errp);
-}
-
-#define UUID_VALUE_AUTO        "auto"
-
-static void set_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
-                    Error **errp)
-{
-    DeviceState *dev = DEVICE(obj);
-    Property *prop = opaque;
-    QemuUUID *uuid = qdev_get_prop_ptr(obj, prop);
-    char *str;
-
-    if (dev->realized) {
-        qdev_prop_set_after_realize(dev, name, errp);
-        return;
-    }
-
-    if (!visit_type_str(v, name, &str, errp)) {
-        return;
-    }
-
-    if (!strcmp(str, UUID_VALUE_AUTO)) {
-        qemu_uuid_generate(uuid);
-    } else if (qemu_uuid_parse(str, uuid) < 0) {
-        error_set_from_qdev_prop_error(errp, EINVAL, obj, prop, str);
-    }
-    g_free(str);
-}
-
-static void set_default_uuid_auto(ObjectProperty *op, const Property *prop)
-{
-    object_property_set_default_str(op, UUID_VALUE_AUTO);
-}
-
-const PropertyInfo qdev_prop_uuid = {
-    .name  = "str",
-    .description = "UUID (aka GUID) or \"" UUID_VALUE_AUTO
-        "\" for random value (default)",
-    .get   = get_uuid,
-    .set   = set_uuid,
-    .set_default_value = set_default_uuid_auto,
-};
-
 /* --- support for array properties --- */
 
 /* Used as an opaque for the object properties we add for each
-- 
2.28.0


