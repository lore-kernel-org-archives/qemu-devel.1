Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E38C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:34:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D48FE20673
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PqkHp2iD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D48FE20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipwJ7-0000vH-7X
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 10:34:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwGv-00078k-7D
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:32:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwGt-0006Lz-9f
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:32:25 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43496
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ipwGt-0006KA-35
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:32:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578670342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O4UVi3TzSWJaOBDb31vHmvxKuIe5kx5L8jAvH04lmfw=;
 b=PqkHp2iDcow1lpeHwdEP5UUAOYmmZxrUHL5h1vmRK1aHxhS8epBAaFL6M6yN8BIOMgcoKv
 2b/iF7XxKziyCU+pQoezW9UxXlMQW4XwHm0bTWUJ1q2maHVl+9bmyWpz6/hIMuYAE4boHL
 tMaqIsz4914iFnupRcGhsWVw2vhHu+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-6ngto2FWN_WN7P3d__djhQ-1; Fri, 10 Jan 2020 10:32:21 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87AC3108839F
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 15:32:20 +0000 (UTC)
Received: from localhost (ovpn-112-59.ams2.redhat.com [10.36.112.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30202277A4;
 Fri, 10 Jan 2020 15:32:12 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/26] object: make object_class_property_add* return property
Date: Fri, 10 Jan 2020 19:30:21 +0400
Message-Id: <20200110153039.1379601-9-marcandre.lureau@redhat.com>
In-Reply-To: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
References: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 6ngto2FWN_WN7P3d__djhQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
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
index ca47308ac4..9f52bc365b 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1556,7 +1556,8 @@ void object_property_add_str(Object *obj, const char =
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
@@ -1578,7 +1579,8 @@ void object_property_add_bool(Object *obj, const char=
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
@@ -1602,7 +1604,8 @@ void object_property_add_enum(Object *obj, const char=
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
@@ -1623,7 +1626,8 @@ void object_property_add_tm(Object *obj, const char *=
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
@@ -1639,7 +1643,8 @@ void object_class_property_add_tm(ObjectClass *klass,=
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
@@ -1654,7 +1659,8 @@ void object_class_property_add_uint8_ptr(ObjectClass =
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
@@ -1669,7 +1675,8 @@ void object_class_property_add_uint16_ptr(ObjectClass=
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
@@ -1684,7 +1691,8 @@ void object_class_property_add_uint32_ptr(ObjectClass=
 *klass, const char *name,
  */
 void object_property_add_uint64_ptr(Object *obj, const char *name,
                                     const uint64_t *v, Error **errp);
-void object_class_property_add_uint64_ptr(ObjectClass *klass, const char *=
name,
+ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
+                                          const char *name,
                                           const uint64_t *v, Error **errp)=
;
=20
 /**
diff --git a/qom/object.c b/qom/object.c
index b319db4ac6..a4c7bb01e6 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2065,7 +2065,8 @@ void object_property_add_str(Object *obj, const char =
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
@@ -2073,11 +2074,12 @@ void object_class_property_add_str(ObjectClass *kla=
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
@@ -2086,6 +2088,8 @@ void object_class_property_add_str(ObjectClass *klass=
, const char *name,
         error_propagate(errp, local_err);
         g_free(prop);
     }
+
+    return rv;
 }
=20
 typedef struct BoolProperty
@@ -2155,18 +2159,20 @@ void object_property_add_bool(Object *obj, const ch=
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
@@ -2175,6 +2181,8 @@ void object_class_property_add_bool(ObjectClass *klas=
s, const char *name,
         error_propagate(errp, local_err);
         g_free(prop);
     }
+
+    return rv;
 }
=20
 static void property_get_enum(Object *obj, Visitor *v, const char *name,
@@ -2240,7 +2248,8 @@ void object_property_add_enum(Object *obj, const char=
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
@@ -2249,12 +2258,13 @@ void object_class_property_add_enum(ObjectClass *kl=
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
@@ -2263,6 +2273,8 @@ void object_class_property_add_enum(ObjectClass *klas=
s, const char *name,
         error_propagate(errp, local_err);
         g_free(prop);
     }
+
+    return rv;
 }
=20
 typedef struct TMProperty {
@@ -2343,16 +2355,18 @@ void object_property_add_tm(Object *obj, const char=
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
@@ -2360,6 +2374,8 @@ void object_class_property_add_tm(ObjectClass *klass,=
 const char *name,
         error_propagate(errp, local_err);
         g_free(prop);
     }
+
+    return rv;
 }
=20
 static char *qdev_get_type(Object *obj, Error **errp)
@@ -2402,11 +2418,13 @@ void object_property_add_uint8_ptr(Object *obj, con=
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
@@ -2416,11 +2434,13 @@ void object_property_add_uint16_ptr(Object *obj, co=
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
@@ -2430,11 +2450,13 @@ void object_property_add_uint32_ptr(Object *obj, co=
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
@@ -2444,11 +2466,13 @@ void object_property_add_uint64_ptr(Object *obj, co=
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
2.25.0.rc1.20.g2443f3f80d.dirty


