Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED56C432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:34:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECC9D20725
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Re7jfChT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC9D20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibNUX-00033i-Tj
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 06:34:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNEs-0002PQ-KF
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:18:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNEn-0000on-LN
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:18:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52701
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ibNEm-0000n4-2u
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:18:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575199079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CMihN+BsMGu4Ikrcgc5BLp6qnfAv8aFjTDUPCrwOS5A=;
 b=Re7jfChTfCOqrTfzii3IzdB63pUT/aH9MOzlCCx52di8qnx0QRQqDQ+n78m7kbX1D0km/+
 vPg64MVrslR24NPSut3f39nI0tEAv61uMNLyLKE85HxSc8g5O0dcLJ39jPUqg6sVkwC4E9
 lIBiw8pCJwURg5nM7NfyGBSIKPU5jPo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-TNLCX_F1Mki2WjweZHyQPg-1; Sun, 01 Dec 2019 06:17:58 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A665D10054E3
 for <qemu-devel@nongnu.org>; Sun,  1 Dec 2019 11:17:57 +0000 (UTC)
Received: from localhost (unknown [10.36.112.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16CF05D6A0;
 Sun,  1 Dec 2019 11:17:52 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/26] object: add direct link flag
Date: Sun,  1 Dec 2019 15:15:19 +0400
Message-Id: <20191201111531.1136947-15-marcandre.lureau@redhat.com>
In-Reply-To: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
References: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: TNLCX_F1Mki2WjweZHyQPg-1
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

Allow the link property to hold the pointer to the target, instead of
indirectly through another variable.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h |  3 +++
 qom/object.c         | 26 ++++++++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 0ac1a9acca..9bef5783f1 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1509,6 +1509,9 @@ void object_property_add_child(Object *obj, const cha=
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
index 6f3800c693..d9fc71c284 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1696,17 +1696,30 @@ void object_property_allow_set_link(const Object *o=
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
@@ -1765,7 +1778,7 @@ static void object_set_link_property(Object *obj, Vis=
itor *v,
 {
     Error *local_err =3D NULL;
     LinkProperty *prop =3D opaque;
-    Object **targetp =3D prop->targetp;
+    Object **targetp =3D object_link_get_targetp(obj, prop);
     Object *old_target =3D *targetp;
     Object *new_target =3D NULL;
     char *path =3D NULL;
@@ -1799,16 +1812,17 @@ static Object *object_resolve_link_property(Object =
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
2.24.0


