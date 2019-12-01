Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDE2C432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:39:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6637820833
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rsvpseet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6637820833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibNZh-0000a8-D7
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 06:39:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNFV-0002VQ-IJ
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:18:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNFR-0001AQ-Oh
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:18:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35982
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ibNFP-00017O-L6
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575199111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bgNueKHODW6/ZFYS8VnwDlNSxwl1I49NzP+Ivr9lqAg=;
 b=RsvpseetJ+0xS/eH3N4kE61JeqwLYZmC6FOcsgwFtaMHyw9cyk7/HjdPjS34WUE3/1RZKK
 pGICycIUhJvwMFUxCTfJBYaxiL1sCHaJZUm3p61hFJUQ6xvYh5Znl/nj/hvgB4gxZg5E0H
 F3fYGqe5flT4hG6Q8PXi9AMO8Wzwbt0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-7f9aBezcOs-lO-LMoZm8YQ-1; Sun, 01 Dec 2019 06:18:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C48DB107ACC4
 for <qemu-devel@nongnu.org>; Sun,  1 Dec 2019 11:18:27 +0000 (UTC)
Received: from localhost (unknown [10.36.112.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC9336609E;
 Sun,  1 Dec 2019 11:18:23 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/26] object: release all props
Date: Sun,  1 Dec 2019 15:15:22 +0400
Message-Id: <20191201111531.1136947-18-marcandre.lureau@redhat.com>
In-Reply-To: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
References: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 7f9aBezcOs-lO-LMoZm8YQ-1
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Class properties may have to release resources when the object is
destroyed. Let's use the existing release() callback for that, but
class properties must not release ObjectProperty, as it can be shared
by various instances.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qom/object.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 9227dbc08b..10acf9bff9 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -564,23 +564,22 @@ static inline bool object_property_is_child(ObjectPro=
perty *prop)
=20
 static void object_property_del_all(Object *obj)
 {
+    g_autoptr(GHashTable) done =3D g_hash_table_new(NULL, NULL);
     ObjectProperty *prop;
-    GHashTableIter iter;
-    gpointer key, value;
+    ObjectPropertyIterator iter;
     bool released;
=20
     do {
         released =3D false;
-        g_hash_table_iter_init(&iter, obj->properties);
-        while (g_hash_table_iter_next(&iter, &key, &value)) {
-            prop =3D value;
-            if (prop->release) {
-                prop->release(obj, prop->name, prop->opaque);
-                prop->release =3D NULL;
-                released =3D true;
-                break;
+        object_property_iter_init(&iter, obj);
+        while ((prop =3D object_property_iter_next(&iter)) !=3D NULL) {
+            if (g_hash_table_add(done, prop)) {
+                if (prop->release) {
+                    prop->release(obj, prop->name, prop->opaque);
+                    released =3D true;
+                    break;
+                }
             }
-            g_hash_table_iter_remove(&iter);
         }
     } while (released);
=20
--=20
2.24.0


