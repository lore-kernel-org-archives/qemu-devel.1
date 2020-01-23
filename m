Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54402C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:03:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F8F7214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQs/G6Gm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8F7214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuexN-0001Uy-K4
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:03:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iucu8-0000xf-9Y
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iucu6-0000zc-Gs
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24188
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iucu6-0000z4-C3
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cxjukf8dwnJmXEIJ5SE66uhpu+tjG3UeTYibKiR6zJ0=;
 b=iQs/G6GmZwBnqgUaX2nhV4htLl0b9ZZhRB+2PwMo19bPbi3V88XsFU2XRsv08w501ptmgC
 M4xFiYIExjQhNyYRnqzlLccCudT5o9ou76EqcFfEiogiq4Qe8C011dhV0fHA5UOTdrcda+
 NfS0MOwJNw5QTUXx8we1+UFw7tLSATk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-rB4ossySONSd-l7c9hD9Bw-1; Thu, 23 Jan 2020 08:52:12 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7058C1080D76
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:52:11 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EB1D1CB;
 Thu, 23 Jan 2020 13:52:10 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 37/59] object: make object_class_property_add* return property
Date: Thu, 23 Jan 2020 14:50:27 +0100
Message-Id: <1579787449-27599-38-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: rB4ossySONSd-l7c9hD9Bw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

This will help calling other ObjectProperty associated functions
easily after.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-9-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h | 24 +++++++++++++-------
 qom/object.c         | 64 ++++++++++++++++++++++++++++++++++++------------=
----
 2 files changed, 60 insertions(+), 28 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 29f47d3..afe658c 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1539,7 +1539,8 @@ void object_property_add_str(Object *obj, const char =
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
@@ -1561,7 +1562,8 @@ void object_property_add_bool(Object *obj, const char=
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
@@ -1585,7 +1587,8 @@ void object_property_add_enum(Object *obj, const char=
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
@@ -1606,7 +1609,8 @@ void object_property_add_tm(Object *obj, const char *=
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
@@ -1622,7 +1626,8 @@ void object_class_property_add_tm(ObjectClass *klass,=
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
@@ -1637,7 +1642,8 @@ void object_class_property_add_uint8_ptr(ObjectClass =
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
@@ -1652,7 +1658,8 @@ void object_class_property_add_uint16_ptr(ObjectClass=
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
@@ -1667,7 +1674,8 @@ void object_class_property_add_uint32_ptr(ObjectClass=
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
index cd7ce81..4ade409 100644
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
1.8.3.1



