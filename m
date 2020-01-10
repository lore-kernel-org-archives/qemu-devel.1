Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50E1C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70C0B2080D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XD3BxcmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C0B2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipwbT-0001Js-KZ
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 10:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59907)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwIa-00010F-6y
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:34:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwIX-0003yf-SN
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:34:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48071
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ipwIX-0003x1-OE
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578670445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rc6nApTJw8zuI2A8JlzpJpSuzLia3SLwY8UX9/HGp7Y=;
 b=XD3BxcmVEvNBVDM8WIwfy/PVLmWV0HUlx9IqZ07GYnIBHwK129/0Ygi3MwD9MUj8R6H7RQ
 7mI5GiEVCLIrHW0W9w8ovUVIsVpHtTjq07oNNZdDqdTfTJc0IE5Er4bQQsoUdgHfgv9lWp
 xyxglcisy87lQDbPSQeREmIXuSGqTkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-D07cb7pSNFCWpunkx01luQ-1; Fri, 10 Jan 2020 10:34:04 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1E1D801E67
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 15:34:02 +0000 (UTC)
Received: from localhost (ovpn-112-59.ams2.redhat.com [10.36.112.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8813E78E89;
 Fri, 10 Jan 2020 15:33:55 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/26] object: add object_class_property_add_link()
Date: Fri, 10 Jan 2020 19:30:29 +0400
Message-Id: <20200110153039.1379601-17-marcandre.lureau@redhat.com>
In-Reply-To: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
References: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: D07cb7pSNFCWpunkx01luQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h |  9 +++++++++
 qom/object.c         | 46 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 5b02be68ec..ead9129ac8 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1531,6 +1531,7 @@ typedef enum {
=20
     /* private */
     OBJ_PROP_LINK_DIRECT =3D 0x2,
+    OBJ_PROP_LINK_CLASS =3D 0x4,
 } ObjectPropertyLinkFlags;
=20
 /**
@@ -1579,6 +1580,14 @@ void object_property_add_link(Object *obj, const cha=
r *name,
                               ObjectPropertyLinkFlags flags,
                               Error **errp);
=20
+ObjectProperty *object_class_property_add_link(ObjectClass *oc,
+                              const char *name,
+                              const char *type, ptrdiff_t offset,
+                              void (*check)(const Object *obj, const char =
*name,
+                                            Object *val, Error **errp),
+                              ObjectPropertyLinkFlags flags,
+                              Error **errp);
+
 /**
  * object_property_add_str:
  * @obj: the object to add a property to
diff --git a/qom/object.c b/qom/object.c
index 09d960f254..04f2991716 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1723,6 +1723,7 @@ typedef struct {
     union {
         Object **targetp;
         Object *target; /* if OBJ_PROP_LINK_DIRECT, when holding the point=
er  */
+        ptrdiff_t offset; /* if OBJ_PROP_LINK_CLASS */
     };
     void (*check)(const Object *, const char *, Object *, Error **);
     ObjectPropertyLinkFlags flags;
@@ -1733,6 +1734,8 @@ object_link_get_targetp(Object *obj, LinkProperty *lp=
rop)
 {
     if (lprop->flags & OBJ_PROP_LINK_DIRECT) {
         return &lprop->target;
+    } else if (lprop->flags & OBJ_PROP_LINK_CLASS) {
+        return (void *)obj + lprop->offset;
     } else {
         return lprop->targetp;
     }
@@ -1848,7 +1851,9 @@ static void object_release_link_property(Object *obj,=
 const char *name,
     if ((prop->flags & OBJ_PROP_LINK_STRONG) && *targetp) {
         object_unref(*targetp);
     }
-    g_free(prop);
+    if (!(prop->flags & OBJ_PROP_LINK_CLASS)) {
+        g_free(prop);
+    }
 }
=20
 static void object_add_link_prop(Object *obj, const char *name,
@@ -1901,6 +1906,45 @@ void object_property_add_link(Object *obj, const cha=
r *name,
     object_add_link_prop(obj, name, type, targetp, check, flags, errp);
 }
=20
+ObjectProperty *
+object_class_property_add_link(ObjectClass *oc,
+    const char *name,
+    const char *type, ptrdiff_t offset,
+    void (*check)(const Object *obj, const char *name,
+                  Object *val, Error **errp),
+    ObjectPropertyLinkFlags flags,
+    Error **errp)
+{
+    Error *local_err =3D NULL;
+    LinkProperty *prop =3D g_new0(LinkProperty, 1);
+    gchar *full_type;
+    ObjectProperty *op;
+
+    prop->offset =3D offset;
+    prop->check =3D check;
+    prop->flags =3D flags | OBJ_PROP_LINK_CLASS;
+
+    full_type =3D g_strdup_printf("link<%s>", type);
+
+    op =3D object_class_property_add(oc, name, full_type,
+                                   object_get_link_property,
+                                   check ? object_set_link_property : NULL=
,
+                                   object_release_link_property,
+                                   prop,
+                                   &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        g_free(prop);
+        goto out;
+    }
+
+    op->resolve =3D object_resolve_link_property;
+
+out:
+    g_free(full_type);
+    return op;
+}
+
 void object_property_add_const_link(Object *obj, const char *name,
                                     Object *target, Error **errp)
 {
--=20
2.25.0.rc1.20.g2443f3f80d.dirty


