Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C50C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:23:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C244621734
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h3KWZpgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C244621734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufGi-0007Pf-9L
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:23:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iucuK-0001H8-ED
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iucuJ-0001FP-Bv
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23806
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iucuJ-0001FB-8Y
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MOgcG9+yeYfqXwpXoejUxtJaBTPmZdn6SO0MP6lruHY=;
 b=h3KWZpggPsGSzJGt425VQyF1bSduV6tYMhbA08MmEdhF+C3BPAgBSJ++0dGhd+5WUUVEsV
 vaIAlvNdVXR8ltXuxQuXcco30zFosBOFA5HR89HQC30ybzOYobj2zBCfB5QP0VaxXIQWXR
 Htv8lYH0koWSxegyi18hUKLMsMxc2ls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-JQCRYsiBOcmOzAiUpvXXWg-1; Thu, 23 Jan 2020 08:52:25 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B3851005F9D
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:52:24 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16AE21CB;
 Thu, 23 Jan 2020 13:52:22 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 44/59] object: express const link with link property
Date: Thu, 23 Jan 2020 14:50:34 +0100
Message-Id: <1579787449-27599-45-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: JQCRYsiBOcmOzAiUpvXXWg-1
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

Let's not mix child property and link property callbacks, as this is
confusing, use LinkProperty with DIRECT flag to hold the target pointer.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-16-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/object.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index a9760d5..b2bc87b 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1844,19 +1844,23 @@ static void object_release_link_property(Object *ob=
j, const char *name,
     g_free(prop);
 }
=20
-void object_property_add_link(Object *obj, const char *name,
-                              const char *type, Object **targetp,
-                              void (*check)(const Object *, const char *,
-                                            Object *, Error **),
-                              ObjectPropertyLinkFlags flags,
-                              Error **errp)
+static void object_add_link_prop(Object *obj, const char *name,
+                                 const char *type, void *ptr,
+                                 void (*check)(const Object *, const char =
*,
+                                               Object *, Error **),
+                                 ObjectPropertyLinkFlags flags,
+                                 Error **errp)
 {
     Error *local_err =3D NULL;
     LinkProperty *prop =3D g_malloc(sizeof(*prop));
     gchar *full_type;
     ObjectProperty *op;
=20
-    prop->targetp =3D targetp;
+    if (flags & OBJ_PROP_LINK_DIRECT) {
+        prop->target =3D ptr;
+    } else {
+        prop->targetp =3D ptr;
+    }
     prop->check =3D check;
     prop->flags =3D flags;
=20
@@ -1880,20 +1884,21 @@ out:
     g_free(full_type);
 }
=20
+void object_property_add_link(Object *obj, const char *name,
+                              const char *type, Object **targetp,
+                              void (*check)(const Object *, const char *,
+                                            Object *, Error **),
+                              ObjectPropertyLinkFlags flags,
+                              Error **errp)
+{
+    object_add_link_prop(obj, name, type, targetp, check, flags, errp);
+}
+
 void object_property_add_const_link(Object *obj, const char *name,
                                     Object *target, Error **errp)
 {
-    char *link_type;
-    ObjectProperty *op;
-
-    link_type =3D g_strdup_printf("link<%s>", object_get_typename(target))=
;
-    op =3D object_property_add(obj, name, link_type,
-                             object_get_child_property, NULL,
-                             NULL, target, errp);
-    if (op !=3D NULL) {
-        op->resolve =3D object_resolve_child_property;
-    }
-    g_free(link_type);
+    object_add_link_prop(obj, name, object_get_typename(target), target,
+                         NULL, OBJ_PROP_LINK_DIRECT, errp);
 }
=20
 gchar *object_get_canonical_path_component(Object *obj)
--=20
1.8.3.1



