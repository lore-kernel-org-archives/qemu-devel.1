Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BF4C432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:31:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B67320725
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OOi5hwoB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B67320725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibNRY-0000LU-0y
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 06:31:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNFH-0002Sd-7N
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:18:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNFB-00012P-Co
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:18:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33323
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ibNEz-0000wR-E3
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575199089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZSBpW6ce3yEYzYeWYEOTKB5zeO3HPhiloHWq9bYkp08=;
 b=OOi5hwoBxeA5gShstmnO7dBLeDa10K6xuthDEUv3bsK/UV51yfe5kTGq3snW8ESL412ic4
 P91nhrmpWDJXwXEem/v09yBHjBqwXDesK/Vu7HSq+Q0mdIdpM4GsB7S8GD9E09A9ZhPPNo
 RcxqgxdBIE5c6pnESPHAKMCb+x6KZkQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-V8ursnZ_M_a3U_CZyFptoA-1; Sun, 01 Dec 2019 06:18:08 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B59F184CABB
 for <qemu-devel@nongnu.org>; Sun,  1 Dec 2019 11:18:07 +0000 (UTC)
Received: from localhost (unknown [10.36.112.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A8E525D9E1;
 Sun,  1 Dec 2019 11:18:03 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/26] object: express const link with link property
Date: Sun,  1 Dec 2019 15:15:20 +0400
Message-Id: <20191201111531.1136947-16-marcandre.lureau@redhat.com>
In-Reply-To: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
References: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: V8ursnZ_M_a3U_CZyFptoA-1
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

Let's not mix child property and link property callbacks, as this is
confusing, use LinkProperty with DIRECT flag to hold the target pointer.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qom/object.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index d9fc71c284..b73fe66dc9 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1827,19 +1827,23 @@ static void object_release_link_property(Object *ob=
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
@@ -1863,20 +1867,21 @@ out:
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
2.24.0


