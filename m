Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534F6C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:41:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1146420721
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/H3sb0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1146420721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipwQ1-0002oy-3Q
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 10:41:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59213)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwIO-0000ez-GG
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:33:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwIN-0003HF-Cl
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:33:56 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26310
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ipwIN-0003D6-8O
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:33:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578670433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RH7a5BXQLPq5MHdJHlXib9TDeL5lNo9hXa6Pnoasx1g=;
 b=F/H3sb0FwmzXRCmhU2clJKKV524ZD3SJjgEAaiT+E7vR/HSqGwQdRGQAiJDwd3SR6Yp1iP
 GJhXkdra1TbJX3iYg5zpvBX5B13Eo5jFd2mlSB2wNqyV2P/3N46FcCT8VFZdj/h8/5jdHZ
 VO99YTiHf8a41CaEF8HZhMHHkSTz04o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-zpUXrJeCPMGNKgJ3d_qTsQ-1; Fri, 10 Jan 2020 10:33:50 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86F831800D6B
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 15:33:49 +0000 (UTC)
Received: from localhost (ovpn-112-59.ams2.redhat.com [10.36.112.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60ECB5C1B5;
 Fri, 10 Jan 2020 15:33:42 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/26] object: express const link with link property
Date: Fri, 10 Jan 2020 19:30:28 +0400
Message-Id: <20200110153039.1379601-16-marcandre.lureau@redhat.com>
In-Reply-To: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
References: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: zpUXrJeCPMGNKgJ3d_qTsQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's not mix child property and link property callbacks, as this is
confusing, use LinkProperty with DIRECT flag to hold the target pointer.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qom/object.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 30eee0f36b..09d960f254 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1851,19 +1851,23 @@ static void object_release_link_property(Object *ob=
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
@@ -1887,20 +1891,21 @@ out:
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
2.25.0.rc1.20.g2443f3f80d.dirty


