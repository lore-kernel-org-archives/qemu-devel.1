Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7992AC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:51:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4665020658
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ityty5ml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4665020658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpPN-0000Gt-GT
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpKK-0000nh-RC
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpKJ-0006PZ-C8
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40402
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpKJ-0006OK-7z
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584125190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yWQ+u/Gvrhh9wC5eV7uQcIOMQ3Csdd6qcnMlGuSOykE=;
 b=Ityty5mlUZpC53wbZeAwfDy6Xphe0YXQUo6fq+kjV5SoM333uFw/AcRzlKVmWidB37hAt2
 hDCeCxwiyaARsbFux3TzsMB5zPpKyzYmc9ATEHx+k72E8PFIH74OGN7ptoXILM9/Jg9Hsp
 XBRo3Vd8udwA/Q8bCsl4flrYUiAi9uY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-zM0KANFsOiiop3MGo4DWFg-1; Fri, 13 Mar 2020 14:46:29 -0400
X-MC-Unique: zM0KANFsOiiop3MGo4DWFg-1
Received: by mail-wr1-f72.google.com with SMTP id l16so4001968wrr.6
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+yjBO8iHay02ZD3KnHa0RlYl6K1YM1XyiIX+fSk0A8A=;
 b=r0SwBihdslYvkbDlpU+p4fp+VXpVvEZR7Jc2bpT4MQephE1p4sLrxyJNpyquUZXOhJ
 63TCxk6IvUEG31TH/EwI0FDE2eksOQwaq05PF0/+mmqgeR0q5RYaOS6+vs7fshfEnlRf
 C5QA5oTFCdCZ0g+XXY2JjPISocLo9S0RfcbRcO4HKeBPbFmonoGXGYkoqtZxy3SkWLDz
 p/ykXNV46Gy6mxrN9fnkPpb/UjUd5SQUPxznlOl8PdrTMw8XpQsiUTOXkhvaMdeccKs2
 fbjckUa/vun/iZWDB5T8P1q1ch4DUPse7ZMyXc+u3/iczZNwumBFRP9RnenRc7lXkj0P
 wCjQ==
X-Gm-Message-State: ANhLgQ2QSmtXQ/flyC9NekMegiYaqgYXwDNl/vMJlYHe6FMNzWaUQRwx
 rTr1ZCNeVk9PRRPC7w4GU0y2GvlHffGBTJVJmyJkxe7gIoGG9aDPYO0NTY/l5bPlxEFf1zJWukC
 bl01lNyO9z7wLv6Y=
X-Received: by 2002:a5d:68cc:: with SMTP id p12mr18324421wrw.375.1584125187986; 
 Fri, 13 Mar 2020 11:46:27 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vunsX9isje9PNyybXJw8I2eLajg+PDfqu0SFFxSDQEjB5qaLi2j5/3jA9aLNFyiX4WAC9n9kw==
X-Received: by 2002:a5d:68cc:: with SMTP id p12mr18324400wrw.375.1584125187743; 
 Fri, 13 Mar 2020 11:46:27 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id u204sm15225081wmg.40.2020.03.13.11.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:46:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/9] hw/core/qdev-properties: Export enum-related functions
Date: Fri, 13 Mar 2020 19:46:02 +0100
Message-Id: <20200313184607.11792-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200313184607.11792-1-philmd@redhat.com>
References: <20200313184607.11792-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to split this file and reuse these static functions.
Add the local "qdev-prop-internal.h" header declaring them.

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
index ea5b59d5c5..9c383ffa44 100644
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


