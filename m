Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12038C10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 01:32:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB47F20663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 01:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GY1hy7my"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB47F20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDec5-0005Lr-Mv
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 21:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDdM7-0008KD-EW
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:11:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDdM3-0004y5-Si
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:11:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58961
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDdM3-0004wV-OC
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584317499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ua1jkYmzCnlEiV4PtiMK/WHhXHx6VUTub5ZWx4B5YBY=;
 b=GY1hy7myzlsCHyQ95o0OI/eGFrh8sYFD440uKdSuqKbVqZnA9yyGdIoFK4sWTfYAOgL039
 acch58wEMW3s4/S4n2ZHejPtzffdcWLiwJxpGtl7U1GUamS2XZ9ORRBjFdYnpEUJOtnipg
 VztSGkzxMCwVEdD54tBsE1YXwiFwxls=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-kfGGnpaxPgaaF73tWyaevA-1; Sun, 15 Mar 2020 20:11:37 -0400
X-MC-Unique: kfGGnpaxPgaaF73tWyaevA-1
Received: by mail-wr1-f69.google.com with SMTP id q18so8131215wrw.5
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 17:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s8oVuWi5Pwe/IVfF1LT+AZqvbsSLy1BWdX/KcJ8rJNU=;
 b=duEwFAB9ZyTwmi1k13lLnaPeS04XjK3Fe2zAUoCaVdB40uaWC6ON4iB7GFFwgUtfjW
 Vqa02jsRnuhCnOOKkAL25zHilRxOZglRLc74X6s4PjCZ2CWNH8TZJyVKfwvvj23zPaM0
 LNKh9XRFkylEVqVYxUPXmmrkcD2WoipyuYKqlSEAlKQLRB/C7GofiDwp0S/DVx7+kHzd
 R/OH2Z7Ajl5dyKFk2Ssyh4Wm8s1SlFyzYGtDZUiIPsriKQbXXzKeNhISHFOOvvFuI2TS
 vJNGvTrn1r/QENukO9nL0w6GFKXtJs/0yfILLW7UPWWgz6zx0NZwhzZ3xQE3MZNLBGhT
 ryaQ==
X-Gm-Message-State: ANhLgQ1TAIhBb0+YA2AnhtOAsldvwYleRmgATR+pP6n0YUDWhqlwODx+
 q1N2NoskOxmo6IVHaItqJ3YYR9T7zF/7khKABcnthbIQz9zc9RXptJ2oLyV7d2hyN/qAi8t/Rl3
 EWFukaLz6Q6bw3qQ=
X-Received: by 2002:a1c:c5:: with SMTP id 188mr24067955wma.89.1584317495996;
 Sun, 15 Mar 2020 17:11:35 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsbDylGOsx0xSgCsw4cxARby8HR/p4/6MAyhl7B/m0vIX81KejWyuePWiACp3gMq/bFnwWQ8w==
X-Received: by 2002:a1c:c5:: with SMTP id 188mr24067934wma.89.1584317495765;
 Sun, 15 Mar 2020 17:11:35 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id b5sm20354999wrw.86.2020.03.15.17.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 17:11:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/9] hw/core/qdev-properties: Export enum-related functions
Date: Mon, 16 Mar 2020 01:11:06 +0100
Message-Id: <20200316001111.31004-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316001111.31004-1-philmd@redhat.com>
References: <20200316001111.31004-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to split this file and reuse these static functions.
Add the local "qdev-prop-internal.h" header declaring them.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/core/qdev-prop-internal.h | 19 ++++++++++++
 hw/core/qdev-properties.c    | 58 +++++++++++++++++++-----------------
 2 files changed, 49 insertions(+), 28 deletions(-)
 create mode 100644 hw/core/qdev-prop-internal.h

diff --git a/hw/core/qdev-prop-internal.h b/hw/core/qdev-prop-internal.h
new file mode 100644
index 0000000000..2a8c9a306a
--- /dev/null
+++ b/hw/core/qdev-prop-internal.h
@@ -0,0 +1,19 @@
+/*
+ * qdev property parsing
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_CORE_QDEV_PROP_INTERNAL_H
+#define HW_CORE_QDEV_PROP_INTERNAL_H
+
+void qdev_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp);
+void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp);
+
+void qdev_propinfo_set_default_value_enum(ObjectProperty *op,
+                                          const Property *prop);
+
+#endif
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 8ef949e3bd..3f3a008938 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -16,6 +16,7 @@
 #include "qapi/visitor.h"
 #include "chardev/char.h"
 #include "qemu/uuid.h"
+#include "qdev-prop-internal.h"
=20
 void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
                                   Error **errp)
@@ -51,8 +52,8 @@ void *qdev_get_prop_ptr(DeviceState *dev, Property *prop)
     return ptr;
 }
=20
-static void get_enum(Object *obj, Visitor *v, const char *name, void *opaq=
ue,
-                     Error **errp)
+void qdev_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
 {
     DeviceState *dev =3D DEVICE(obj);
     Property *prop =3D opaque;
@@ -61,8 +62,8 @@ static void get_enum(Object *obj, Visitor *v, const char =
*name, void *opaque,
     visit_type_enum(v, prop->name, ptr, prop->info->enum_table, errp);
 }
=20
-static void set_enum(Object *obj, Visitor *v, const char *name, void *opaq=
ue,
-                     Error **errp)
+void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
 {
     DeviceState *dev =3D DEVICE(obj);
     Property *prop =3D opaque;
@@ -76,7 +77,8 @@ static void set_enum(Object *obj, Visitor *v, const char =
*name, void *opaque,
     visit_type_enum(v, prop->name, ptr, prop->info->enum_table, errp);
 }
=20
-static void set_default_value_enum(ObjectProperty *op, const Property *pro=
p)
+void qdev_propinfo_set_default_value_enum(ObjectProperty *op,
+                                          const Property *prop)
 {
     object_property_set_default_str(op,
         qapi_enum_lookup(prop->info->enum_table, prop->defval.i));
@@ -591,9 +593,9 @@ const PropertyInfo qdev_prop_on_off_auto =3D {
     .name =3D "OnOffAuto",
     .description =3D "on/off/auto",
     .enum_table =3D &OnOffAuto_lookup,
-    .get =3D get_enum,
-    .set =3D set_enum,
-    .set_default_value =3D set_default_value_enum,
+    .get =3D qdev_propinfo_get_enum,
+    .set =3D qdev_propinfo_set_enum,
+    .set_default_value =3D qdev_propinfo_set_default_value_enum,
 };
=20
 /* --- lost tick policy --- */
@@ -603,9 +605,9 @@ QEMU_BUILD_BUG_ON(sizeof(LostTickPolicy) !=3D sizeof(in=
t));
 const PropertyInfo qdev_prop_losttickpolicy =3D {
     .name  =3D "LostTickPolicy",
     .enum_table  =3D &LostTickPolicy_lookup,
-    .get   =3D get_enum,
-    .set   =3D set_enum,
-    .set_default_value =3D set_default_value_enum,
+    .get   =3D qdev_propinfo_get_enum,
+    .set   =3D qdev_propinfo_set_enum,
+    .set_default_value =3D qdev_propinfo_set_default_value_enum,
 };
=20
 /* --- Block device error handling policy --- */
@@ -617,9 +619,9 @@ const PropertyInfo qdev_prop_blockdev_on_error =3D {
     .description =3D "Error handling policy, "
                    "report/ignore/enospc/stop/auto",
     .enum_table =3D &BlockdevOnError_lookup,
-    .get =3D get_enum,
-    .set =3D set_enum,
-    .set_default_value =3D set_default_value_enum,
+    .get =3D qdev_propinfo_get_enum,
+    .set =3D qdev_propinfo_set_enum,
+    .set_default_value =3D qdev_propinfo_set_default_value_enum,
 };
=20
 /* --- BIOS CHS translation */
@@ -631,9 +633,9 @@ const PropertyInfo qdev_prop_bios_chs_trans =3D {
     .description =3D "Logical CHS translation algorithm, "
                    "auto/none/lba/large/rechs",
     .enum_table =3D &BiosAtaTranslation_lookup,
-    .get =3D get_enum,
-    .set =3D set_enum,
-    .set_default_value =3D set_default_value_enum,
+    .get =3D qdev_propinfo_get_enum,
+    .set =3D qdev_propinfo_set_enum,
+    .set_default_value =3D qdev_propinfo_set_default_value_enum,
 };
=20
 /* --- FDC default drive types */
@@ -643,9 +645,9 @@ const PropertyInfo qdev_prop_fdc_drive_type =3D {
     .description =3D "FDC drive type, "
                    "144/288/120/none/auto",
     .enum_table =3D &FloppyDriveType_lookup,
-    .get =3D get_enum,
-    .set =3D set_enum,
-    .set_default_value =3D set_default_value_enum,
+    .get =3D qdev_propinfo_get_enum,
+    .set =3D qdev_propinfo_set_enum,
+    .set_default_value =3D qdev_propinfo_set_default_value_enum,
 };
=20
 /* --- MultiFDCompression --- */
@@ -655,9 +657,9 @@ const PropertyInfo qdev_prop_multifd_compression =3D {
     .description =3D "multifd_compression values, "
                    "none/zlib/zstd",
     .enum_table =3D &MultiFDCompression_lookup,
-    .get =3D get_enum,
-    .set =3D set_enum,
-    .set_default_value =3D set_default_value_enum,
+    .get =3D qdev_propinfo_get_enum,
+    .set =3D qdev_propinfo_set_enum,
+    .set_default_value =3D qdev_propinfo_set_default_value_enum,
 };
=20
 /* --- pci address --- */
@@ -1281,9 +1283,9 @@ const PropertyInfo qdev_prop_off_auto_pcibar =3D {
     .name =3D "OffAutoPCIBAR",
     .description =3D "off/auto/bar0/bar1/bar2/bar3/bar4/bar5",
     .enum_table =3D &OffAutoPCIBAR_lookup,
-    .get =3D get_enum,
-    .set =3D set_enum,
-    .set_default_value =3D set_default_value_enum,
+    .get =3D qdev_propinfo_get_enum,
+    .set =3D qdev_propinfo_set_enum,
+    .set_default_value =3D qdev_propinfo_set_default_value_enum,
 };
=20
 /* --- PCIELinkSpeed 2_5/5/8/16 -- */
@@ -1362,7 +1364,7 @@ const PropertyInfo qdev_prop_pcie_link_speed =3D {
     .enum_table =3D &PCIELinkSpeed_lookup,
     .get =3D get_prop_pcielinkspeed,
     .set =3D set_prop_pcielinkspeed,
-    .set_default_value =3D set_default_value_enum,
+    .set_default_value =3D qdev_propinfo_set_default_value_enum,
 };
=20
 /* --- PCIELinkWidth 1/2/4/8/12/16/32 -- */
@@ -1459,5 +1461,5 @@ const PropertyInfo qdev_prop_pcie_link_width =3D {
     .enum_table =3D &PCIELinkWidth_lookup,
     .get =3D get_prop_pcielinkwidth,
     .set =3D set_prop_pcielinkwidth,
-    .set_default_value =3D set_default_value_enum,
+    .set_default_value =3D qdev_propinfo_set_default_value_enum,
 };
--=20
2.21.1


