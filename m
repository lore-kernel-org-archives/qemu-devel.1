Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24D1C432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DEA320725
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i851Vwgc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEA320725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibNKC-0007rK-0M
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 06:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNDm-0001Vx-Iz
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:17:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNDk-00008k-Ss
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:16:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31692
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ibNDk-00007S-GH
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:16:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575199016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T3a7HE0ymqxfhhzo/muumHux+x+kqshE/WjXiUl1mtg=;
 b=i851VwgckJ/jStDWeayQQpffSimVBiWqtK2XOoYiAjvCzAvjk/43K3NV/MFxCgMgNXtowh
 RrpP4Wf1IjG0i6n+F90KThwgZXc/OFrPkfFh05RPr1/kmpz/W8FkMWRAP6xK6yGyzO4wD0
 kNG63eXo+vViC0Ce1Z57+cdK/JlBMgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-qfd8ovITPAWg7L2FA5HzZQ-1; Sun, 01 Dec 2019 06:16:55 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3299A800D4E
 for <qemu-devel@nongnu.org>; Sun,  1 Dec 2019 11:16:54 +0000 (UTC)
Received: from localhost (unknown [10.36.112.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 904BF600C8;
 Sun,  1 Dec 2019 11:16:51 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/26] object: make object_class_property_add* return property
Date: Sun,  1 Dec 2019 15:15:13 +0400
Message-Id: <20191201111531.1136947-9-marcandre.lureau@redhat.com>
In-Reply-To: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
References: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: qfd8ovITPAWg7L2FA5HzZQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will help calling other ObjectProperty associated functions
easily after.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 24 +++++++++++------
 qom/object.c         | 64 ++++++++++++++++++++++++++++++--------------
 2 files changed, 60 insertions(+), 28 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 8d442cf633..102d941ca5 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1537,7 +1537,8 @@ void object_property_add_str(Object *obj, const char =
*name,
                              void (*set)(Object *, const char *, Error **)=
,
                              Error **errp);
=20
-void object_class_property_add_str(ObjectClass *klass, const char *name,
+ObjectProperty *object_class_property_add_str(ObjectClass *klass,
+                                   const char *name,
                                    char *(*get)(Object *, Error **),
                                    void (*set)(Object *, const char *,
                                                Error **),
@@ -1559,7 +1560,8 @@ void object_property_add_bool(Object *obj, const char=
 *name,
                               void (*set)(Object *, bool, Error **),
                               Error **errp);
=20
-void object_class_property_add_bool(ObjectClass *klass, const char *name,
+ObjectProperty *object_class_property_add_bool(ObjectClass *klass,
+                                    const char *name,
                                     bool (*get)(Object *, Error **),
                                     void (*set)(Object *, bool, Error **),
                                     Error **errp);
@@ -1583,7 +1585,8 @@ void object_property_add_enum(Object *obj, const char=
 *name,
                               void (*set)(Object *, int, Error **),
                               Error **errp);
=20
-void object_class_property_add_enum(ObjectClass *klass, const char *name,
+ObjectProperty *object_class_property_add_enum(ObjectClass *klass,
+                                    const char *name,
                                     const char *typename,
                                     const QEnumLookup *lookup,
                                     int (*get)(Object *, Error **),
@@ -1604,7 +1607,8 @@ void object_property_add_tm(Object *obj, const char *=
name,
                             void (*get)(Object *, struct tm *, Error **),
                             Error **errp);
=20
-void object_class_property_add_tm(ObjectClass *klass, const char *name,
+ObjectProperty *object_class_property_add_tm(ObjectClass *klass,
+                                  const char *name,
                                   void (*get)(Object *, struct tm *, Error=
 **),
                                   Error **errp);
=20
@@ -1620,7 +1624,8 @@ void object_class_property_add_tm(ObjectClass *klass,=
 const char *name,
  */
 void object_property_add_uint8_ptr(Object *obj, const char *name,
                                    const uint8_t *v, Error **errp);
-void object_class_property_add_uint8_ptr(ObjectClass *klass, const char *n=
ame,
+ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
+                                         const char *name,
                                          const uint8_t *v, Error **errp);
=20
 /**
@@ -1635,7 +1640,8 @@ void object_class_property_add_uint8_ptr(ObjectClass =
*klass, const char *name,
  */
 void object_property_add_uint16_ptr(Object *obj, const char *name,
                                     const uint16_t *v, Error **errp);
-void object_class_property_add_uint16_ptr(ObjectClass *klass, const char *=
name,
+ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
+                                          const char *name,
                                           const uint16_t *v, Error **errp)=
;
=20
 /**
@@ -1650,7 +1656,8 @@ void object_class_property_add_uint16_ptr(ObjectClass=
 *klass, const char *name,
  */
 void object_property_add_uint32_ptr(Object *obj, const char *name,
                                     const uint32_t *v, Error **errp);
-void object_class_property_add_uint32_ptr(ObjectClass *klass, const char *=
name,
+ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
+                                          const char *name,
                                           const uint32_t *v, Error **errp)=
;
=20
 /**
@@ -1665,7 +1672,8 @@ void object_class_property_add_uint32_ptr(ObjectClass=
 *klass, const char *name,
  */
 void object_property_add_uint64_ptr(Object *obj, const char *name,
                                     const uint64_t *v, Error **Errp);
-void object_class_property_add_uint64_ptr(ObjectClass *klass, const char *=
name,
+ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
+                                          const char *name,
                                           const uint64_t *v, Error **Errp)=
;
=20
 /**
diff --git a/qom/object.c b/qom/object.c
index 844a2d66bf..de43b30e5e 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2041,7 +2041,8 @@ void object_property_add_str(Object *obj, const char =
*name,
     }
 }
=20
-void object_class_property_add_str(ObjectClass *klass, const char *name,
+ObjectProperty *
+object_class_property_add_str(ObjectClass *klass, const char *name,
                                    char *(*get)(Object *, Error **),
                                    void (*set)(Object *, const char *,
                                                Error **),
@@ -2049,11 +2050,12 @@ void object_class_property_add_str(ObjectClass *kla=
ss, const char *name,
 {
     Error *local_err =3D NULL;
     StringProperty *prop =3D g_malloc0(sizeof(*prop));
+    ObjectProperty *rv;
=20
     prop->get =3D get;
     prop->set =3D set;
=20
-    object_class_property_add(klass, name, "string",
+    rv =3D object_class_property_add(klass, name, "string",
                               get ? property_get_str : NULL,
                               set ? property_set_str : NULL,
                               property_release_str,
@@ -2062,6 +2064,8 @@ void object_class_property_add_str(ObjectClass *klass=
, const char *name,
         error_propagate(errp, local_err);
         g_free(prop);
     }
+
+    return rv;
 }
=20
 typedef struct BoolProperty
@@ -2131,18 +2135,20 @@ void object_property_add_bool(Object *obj, const ch=
ar *name,
     }
 }
=20
-void object_class_property_add_bool(ObjectClass *klass, const char *name,
+ObjectProperty *
+object_class_property_add_bool(ObjectClass *klass, const char *name,
                                     bool (*get)(Object *, Error **),
                                     void (*set)(Object *, bool, Error **),
                                     Error **errp)
 {
     Error *local_err =3D NULL;
     BoolProperty *prop =3D g_malloc0(sizeof(*prop));
+    ObjectProperty *rv;
=20
     prop->get =3D get;
     prop->set =3D set;
=20
-    object_class_property_add(klass, name, "bool",
+    rv =3D object_class_property_add(klass, name, "bool",
                               get ? property_get_bool : NULL,
                               set ? property_set_bool : NULL,
                               property_release_bool,
@@ -2151,6 +2157,8 @@ void object_class_property_add_bool(ObjectClass *klas=
s, const char *name,
         error_propagate(errp, local_err);
         g_free(prop);
     }
+
+    return rv;
 }
=20
 static void property_get_enum(Object *obj, Visitor *v, const char *name,
@@ -2216,7 +2224,8 @@ void object_property_add_enum(Object *obj, const char=
 *name,
     }
 }
=20
-void object_class_property_add_enum(ObjectClass *klass, const char *name,
+ObjectProperty *
+object_class_property_add_enum(ObjectClass *klass, const char *name,
                                     const char *typename,
                                     const QEnumLookup *lookup,
                                     int (*get)(Object *, Error **),
@@ -2225,12 +2234,13 @@ void object_class_property_add_enum(ObjectClass *kl=
ass, const char *name,
 {
     Error *local_err =3D NULL;
     EnumProperty *prop =3D g_malloc(sizeof(*prop));
+    ObjectProperty *rv;
=20
     prop->lookup =3D lookup;
     prop->get =3D get;
     prop->set =3D set;
=20
-    object_class_property_add(klass, name, typename,
+    rv =3D object_class_property_add(klass, name, typename,
                               get ? property_get_enum : NULL,
                               set ? property_set_enum : NULL,
                               property_release_enum,
@@ -2239,6 +2249,8 @@ void object_class_property_add_enum(ObjectClass *klas=
s, const char *name,
         error_propagate(errp, local_err);
         g_free(prop);
     }
+
+    return rv;
 }
=20
 typedef struct TMProperty {
@@ -2319,16 +2331,18 @@ void object_property_add_tm(Object *obj, const char=
 *name,
     }
 }
=20
-void object_class_property_add_tm(ObjectClass *klass, const char *name,
+ObjectProperty *
+object_class_property_add_tm(ObjectClass *klass, const char *name,
                                   void (*get)(Object *, struct tm *, Error=
 **),
                                   Error **errp)
 {
     Error *local_err =3D NULL;
     TMProperty *prop =3D g_malloc0(sizeof(*prop));
+    ObjectProperty *rv;
=20
     prop->get =3D get;
=20
-    object_class_property_add(klass, name, "struct tm",
+    rv =3D object_class_property_add(klass, name, "struct tm",
                               get ? property_get_tm : NULL, NULL,
                               property_release_tm,
                               prop, &local_err);
@@ -2336,6 +2350,8 @@ void object_class_property_add_tm(ObjectClass *klass,=
 const char *name,
         error_propagate(errp, local_err);
         g_free(prop);
     }
+
+    return rv;
 }
=20
 static char *qdev_get_type(Object *obj, Error **errp)
@@ -2378,11 +2394,13 @@ void object_property_add_uint8_ptr(Object *obj, con=
st char *name,
                         NULL, NULL, (void *)v, errp);
 }
=20
-void object_class_property_add_uint8_ptr(ObjectClass *klass, const char *n=
ame,
+ObjectProperty *
+object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
                                          const uint8_t *v, Error **errp)
 {
-    object_class_property_add(klass, name, "uint8", property_get_uint8_ptr=
,
-                              NULL, NULL, (void *)v, errp);
+    return object_class_property_add(klass, name, "uint8",
+                                     property_get_uint8_ptr,
+                                     NULL, NULL, (void *)v, errp);
 }
=20
 void object_property_add_uint16_ptr(Object *obj, const char *name,
@@ -2392,11 +2410,13 @@ void object_property_add_uint16_ptr(Object *obj, co=
nst char *name,
                         NULL, NULL, (void *)v, errp);
 }
=20
-void object_class_property_add_uint16_ptr(ObjectClass *klass, const char *=
name,
+ObjectProperty *
+object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
                                           const uint16_t *v, Error **errp)
 {
-    object_class_property_add(klass, name, "uint16", property_get_uint16_p=
tr,
-                              NULL, NULL, (void *)v, errp);
+    return object_class_property_add(klass, name, "uint16",
+                                     property_get_uint16_ptr,
+                                     NULL, NULL, (void *)v, errp);
 }
=20
 void object_property_add_uint32_ptr(Object *obj, const char *name,
@@ -2406,11 +2426,13 @@ void object_property_add_uint32_ptr(Object *obj, co=
nst char *name,
                         NULL, NULL, (void *)v, errp);
 }
=20
-void object_class_property_add_uint32_ptr(ObjectClass *klass, const char *=
name,
+ObjectProperty *
+object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
                                           const uint32_t *v, Error **errp)
 {
-    object_class_property_add(klass, name, "uint32", property_get_uint32_p=
tr,
-                              NULL, NULL, (void *)v, errp);
+    return object_class_property_add(klass, name, "uint32",
+                                     property_get_uint32_ptr,
+                                     NULL, NULL, (void *)v, errp);
 }
=20
 void object_property_add_uint64_ptr(Object *obj, const char *name,
@@ -2420,11 +2442,13 @@ void object_property_add_uint64_ptr(Object *obj, co=
nst char *name,
                         NULL, NULL, (void *)v, errp);
 }
=20
-void object_class_property_add_uint64_ptr(ObjectClass *klass, const char *=
name,
+ObjectProperty *
+object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
                                           const uint64_t *v, Error **errp)
 {
-    object_class_property_add(klass, name, "uint64", property_get_uint64_p=
tr,
-                              NULL, NULL, (void *)v, errp);
+    return object_class_property_add(klass, name, "uint64",
+                                     property_get_uint64_ptr,
+                                     NULL, NULL, (void *)v, errp);
 }
=20
 typedef struct {
--=20
2.24.0


