Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A11C10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 205FE20663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nt2Mogq7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205FE20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDdfq-0006LH-PI
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 20:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDdMF-0008OS-FB
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDdMD-0005ii-Va
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:11:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24096
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDdMD-0005fV-Ql
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584317509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NQV7CZtJKHKQQmLYV48Ov4NqdR9xK+iLmNVfD84uGjo=;
 b=Nt2Mogq73Guqtekt67rQlMX9faTPgjGxp2gw73XeWG8AW9Qzh+H4AurqxgUUD5OJuYxtlg
 jYlWDwKu8vlZGoP5RJze4YYjuT6+qR8v8+ty1tmP9CqDmlK82FQy8tQoaN8GiY2AuJUj4g
 pnGT4MStBps/JOaPZ5uOLRL4QMAei4Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241--5x4IbVhOrW6Yr9mhnVXCQ-1; Sun, 15 Mar 2020 20:11:48 -0400
X-MC-Unique: -5x4IbVhOrW6Yr9mhnVXCQ-1
Received: by mail-wm1-f71.google.com with SMTP id a23so5028416wmm.8
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 17:11:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sul4SsJ9fMf6B2B0bf7J71c3twXqtltEHRq/Q0EYyuw=;
 b=AiyBNPyWW4DS7SP0/6AB8TofupuSbN7/DzZ/3nBrxk26Uw66fZZx7jhBHlC6GftpJB
 4j/tPXLGyVhF6UmhIKXrA0lZXjyqf1rJlANlUUvIi038iUVqL+PBk1tq7C76RzJZgcOQ
 iIcOhd2RKeb2lLwXJ+cgT9dU/avx4LYr6UYgabbGfi/64uT9o3T5hkQ8W53DkweqG/bZ
 lh64ES99ucZhurRYTLFeCHEwl93llJpYrCPcxIWH6ydzTiFFaVMkXkxGnGplVzZzvxC/
 Wq/SW6i6mUDSlncrFvwB9Veu4K6olwVgzy+jagFm1bwIakWs5Zs6jf3MM2gU6M5q4RLd
 3AGw==
X-Gm-Message-State: ANhLgQ2IQHc03BsxDSIlx088dba+hhIhjk6elDkNJbXPG8fuW3WtSj/s
 e87JXbpZ26PYNTScwjjSx1p2P+e3HYv48+CQgqNx+a3OvIe7CAM3wE3uz4h9GKlhuSoSjE5kl2g
 Wia48kun0dk2tv5w=
X-Received: by 2002:adf:82f4:: with SMTP id 107mr22300459wrc.126.1584317506570; 
 Sun, 15 Mar 2020 17:11:46 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuKXqlnbz8NPhewbFRkMJmaE6Y7q7lsNJV6XPkQxc/EXMwltlySq0Lqs1CkRkLoroaqxdHkqQ==
X-Received: by 2002:adf:82f4:: with SMTP id 107mr22300442wrc.126.1584317506388; 
 Sun, 15 Mar 2020 17:11:46 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id w19sm26685804wmc.22.2020.03.15.17.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 17:11:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/9] hw/core/qdev-properties: Export some integer-related
 functions
Date: Mon, 16 Mar 2020 01:11:08 +0100
Message-Id: <20200316001111.31004-7-philmd@redhat.com>
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
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to split this file and reuse these static functions.
Declare them in the local "qdev-prop-internal.h" header.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/core/qdev-prop-internal.h |  9 ++++++++
 hw/core/qdev-properties.c    | 42 +++++++++++++++++++-----------------
 2 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/hw/core/qdev-prop-internal.h b/hw/core/qdev-prop-internal.h
index 2a8c9a306a..dd2f215f1c 100644
--- a/hw/core/qdev-prop-internal.h
+++ b/hw/core/qdev-prop-internal.h
@@ -15,5 +15,14 @@ void qdev_propinfo_set_enum(Object *obj, Visitor *v, con=
st char *name,
=20
 void qdev_propinfo_set_default_value_enum(ObjectProperty *op,
                                           const Property *prop);
+void qdev_propinfo_set_default_value_int(ObjectProperty *op,
+                                         const Property *prop);
+void qdev_propinfo_set_default_value_uint(ObjectProperty *op,
+                                          const Property *prop);
+
+void qdev_propinfo_get_uint16(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp);
+void qdev_propinfo_get_int32(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp);
=20
 #endif
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 7e89c11dfd..8c85e0b648 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -275,12 +275,14 @@ static void set_uint8(Object *obj, Visitor *v, const =
char *name, void *opaque,
     visit_type_uint8(v, name, ptr, errp);
 }
=20
-static void set_default_value_int(ObjectProperty *op, const Property *prop=
)
+void qdev_propinfo_set_default_value_int(ObjectProperty *op,
+                                         const Property *prop)
 {
     object_property_set_default_int(op, prop->defval.i);
 }
=20
-static void set_default_value_uint(ObjectProperty *op, const Property *pro=
p)
+void qdev_propinfo_set_default_value_uint(ObjectProperty *op,
+                                          const Property *prop)
 {
     object_property_set_default_uint(op, prop->defval.u);
 }
@@ -289,13 +291,13 @@ const PropertyInfo qdev_prop_uint8 =3D {
     .name  =3D "uint8",
     .get   =3D get_uint8,
     .set   =3D set_uint8,
-    .set_default_value =3D set_default_value_uint,
+    .set_default_value =3D qdev_propinfo_set_default_value_uint,
 };
=20
 /* --- 16bit integer --- */
=20
-static void get_uint16(Object *obj, Visitor *v, const char *name,
-                       void *opaque, Error **errp)
+void qdev_propinfo_get_uint16(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp)
 {
     DeviceState *dev =3D DEVICE(obj);
     Property *prop =3D opaque;
@@ -321,9 +323,9 @@ static void set_uint16(Object *obj, Visitor *v, const c=
har *name,
=20
 const PropertyInfo qdev_prop_uint16 =3D {
     .name  =3D "uint16",
-    .get   =3D get_uint16,
+    .get   =3D qdev_propinfo_get_uint16,
     .set   =3D set_uint16,
-    .set_default_value =3D set_default_value_uint,
+    .set_default_value =3D qdev_propinfo_set_default_value_uint,
 };
=20
 /* --- 32bit integer --- */
@@ -353,8 +355,8 @@ static void set_uint32(Object *obj, Visitor *v, const c=
har *name,
     visit_type_uint32(v, name, ptr, errp);
 }
=20
-static void get_int32(Object *obj, Visitor *v, const char *name, void *opa=
que,
-                      Error **errp)
+void qdev_propinfo_get_int32(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
 {
     DeviceState *dev =3D DEVICE(obj);
     Property *prop =3D opaque;
@@ -382,14 +384,14 @@ const PropertyInfo qdev_prop_uint32 =3D {
     .name  =3D "uint32",
     .get   =3D get_uint32,
     .set   =3D set_uint32,
-    .set_default_value =3D set_default_value_uint,
+    .set_default_value =3D qdev_propinfo_set_default_value_uint,
 };
=20
 const PropertyInfo qdev_prop_int32 =3D {
     .name  =3D "int32",
-    .get   =3D get_int32,
+    .get   =3D qdev_propinfo_get_int32,
     .set   =3D set_int32,
-    .set_default_value =3D set_default_value_int,
+    .set_default_value =3D qdev_propinfo_set_default_value_int,
 };
=20
 /* --- 64bit integer --- */
@@ -448,14 +450,14 @@ const PropertyInfo qdev_prop_uint64 =3D {
     .name  =3D "uint64",
     .get   =3D get_uint64,
     .set   =3D set_uint64,
-    .set_default_value =3D set_default_value_uint,
+    .set_default_value =3D qdev_propinfo_set_default_value_uint,
 };
=20
 const PropertyInfo qdev_prop_int64 =3D {
     .name  =3D "int64",
     .get   =3D get_int64,
     .set   =3D set_int64,
-    .set_default_value =3D set_default_value_int,
+    .set_default_value =3D qdev_propinfo_set_default_value_int,
 };
=20
 /* --- string --- */
@@ -739,9 +741,9 @@ const PropertyInfo qdev_prop_pci_devfn =3D {
     .name  =3D "int32",
     .description =3D "Slot and optional function number, example: 06.0 or =
06",
     .print =3D print_pci_devfn,
-    .get   =3D get_int32,
+    .get   =3D qdev_propinfo_get_int32,
     .set   =3D set_pci_devfn,
-    .set_default_value =3D set_default_value_int,
+    .set_default_value =3D qdev_propinfo_set_default_value_uint,
 };
=20
 /* --- blocksize --- */
@@ -787,9 +789,9 @@ static void set_blocksize(Object *obj, Visitor *v, cons=
t char *name,
 const PropertyInfo qdev_prop_blocksize =3D {
     .name  =3D "uint16",
     .description =3D "A power of two between 512 and 32768",
-    .get   =3D get_uint16,
+    .get   =3D qdev_propinfo_get_uint16,
     .set   =3D set_blocksize,
-    .set_default_value =3D set_default_value_uint,
+    .set_default_value =3D qdev_propinfo_set_default_value_uint,
 };
=20
 /* --- pci host address --- */
@@ -1071,7 +1073,7 @@ const PropertyInfo qdev_prop_arraylen =3D {
     .name =3D "uint32",
     .get =3D get_uint32,
     .set =3D set_prop_arraylen,
-    .set_default_value =3D set_default_value_uint,
+    .set_default_value =3D qdev_propinfo_set_default_value_uint,
 };
=20
 /* --- public helpers --- */
@@ -1265,7 +1267,7 @@ const PropertyInfo qdev_prop_size =3D {
     .name  =3D "size",
     .get =3D get_size,
     .set =3D set_size,
-    .set_default_value =3D set_default_value_uint,
+    .set_default_value =3D qdev_propinfo_set_default_value_uint,
 };
=20
 /* --- object link property --- */
--=20
2.21.1


