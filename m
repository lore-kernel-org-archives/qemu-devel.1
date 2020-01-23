Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ACDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:21:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E529B2071E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XujCjY1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E529B2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufEY-0003l3-J9
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:21:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iucuJ-0001FG-8N
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iucuI-0001EV-3u
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58812
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iucuH-0001E8-Vz
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/DL/TCYFmA6bmpfBPtbOJVRKkxK70kDc22k6XCUTUHU=;
 b=XujCjY1fbX1CT22BgBEmupzy+pf+H+qfyzfyn/KyJx3P1aKNV3wYVtu9zf2oMYqBRaeo4O
 LdEnZseut6gXLraTgDNBukCsJx6i0e4xdv4ITWRLViXY4JxxKJsY4fwyqPpJdoLAfiQuSm
 +DbCDm+a5mUipyUoDYSdAgMunNt/WBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-3ekynewHMb-YzCqp-4zehQ-1; Thu, 23 Jan 2020 08:52:23 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 985BF1B18BFE
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:52:22 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94EBF1CB;
 Thu, 23 Jan 2020 13:52:21 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 43/59] object: add direct link flag
Date: Thu, 23 Jan 2020 14:50:33 +0100
Message-Id: <1579787449-27599-44-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 3ekynewHMb-YzCqp-4zehQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Allow the link property to hold the pointer to the target, instead of
indirectly through another variable.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-15-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h |  3 +++
 qom/object.c         | 26 ++++++++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index a163adc..24d6ebe 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1511,6 +1511,9 @@ void object_property_add_child(Object *obj, const cha=
r *name,
 typedef enum {
     /* Unref the link pointer when the property is deleted */
     OBJ_PROP_LINK_STRONG =3D 0x1,
+
+    /* private */
+    OBJ_PROP_LINK_DIRECT =3D 0x2,
 } ObjectPropertyLinkFlags;
=20
 /**
diff --git a/qom/object.c b/qom/object.c
index bb5b739..a9760d5 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1713,17 +1713,30 @@ void object_property_allow_set_link(const Object *o=
bj, const char *name,
 }
=20
 typedef struct {
-    Object **targetp;
+    union {
+        Object **targetp;
+        Object *target; /* if OBJ_PROP_LINK_DIRECT, when holding the point=
er  */
+    };
     void (*check)(const Object *, const char *, Object *, Error **);
     ObjectPropertyLinkFlags flags;
 } LinkProperty;
=20
+static Object **
+object_link_get_targetp(Object *obj, LinkProperty *lprop)
+{
+    if (lprop->flags & OBJ_PROP_LINK_DIRECT) {
+        return &lprop->target;
+    } else {
+        return lprop->targetp;
+    }
+}
+
 static void object_get_link_property(Object *obj, Visitor *v,
                                      const char *name, void *opaque,
                                      Error **errp)
 {
     LinkProperty *lprop =3D opaque;
-    Object **targetp =3D lprop->targetp;
+    Object **targetp =3D object_link_get_targetp(obj, lprop);
     gchar *path;
=20
     if (*targetp) {
@@ -1782,7 +1795,7 @@ static void object_set_link_property(Object *obj, Vis=
itor *v,
 {
     Error *local_err =3D NULL;
     LinkProperty *prop =3D opaque;
-    Object **targetp =3D prop->targetp;
+    Object **targetp =3D object_link_get_targetp(obj, prop);
     Object *old_target =3D *targetp;
     Object *new_target =3D NULL;
     char *path =3D NULL;
@@ -1816,16 +1829,17 @@ static Object *object_resolve_link_property(Object =
*parent, void *opaque, const
 {
     LinkProperty *lprop =3D opaque;
=20
-    return *lprop->targetp;
+    return *object_link_get_targetp(parent, lprop);
 }
=20
 static void object_release_link_property(Object *obj, const char *name,
                                          void *opaque)
 {
     LinkProperty *prop =3D opaque;
+    Object **targetp =3D object_link_get_targetp(obj, prop);
=20
-    if ((prop->flags & OBJ_PROP_LINK_STRONG) && *prop->targetp) {
-        object_unref(*prop->targetp);
+    if ((prop->flags & OBJ_PROP_LINK_STRONG) && *targetp) {
+        object_unref(*targetp);
     }
     g_free(prop);
 }
--=20
1.8.3.1



