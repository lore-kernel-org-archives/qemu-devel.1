Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C64C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:25:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32CE021734
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSJeB1hy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CE021734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufIq-0002cb-SJ
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:25:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iucuN-0001LQ-1b
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iucuM-0001Gz-1e
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57272
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iucuL-0001Gn-UR
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IHfd+wKG0HObWs0T+rNYcGUQGmZU6V/Hd1C2C2od1NE=;
 b=JSJeB1hyZyGUkPzduos2stnILZRgmy7/0/I2UDwxZrNo0ZS6wQ3UNgPOFOMAJUVLl7lvxi
 MlaqM8c6shABAyxdNeVIvhBYWo3SiRNJlsWXJxWxYrqDuefryKTd6RLz8wJ605veuHCcHi
 jkkGIzrRcWUt1yDF9c17Ay1529LOmlo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-8TqNCaWnOv2nCET-3CkjGQ-1; Thu, 23 Jan 2020 08:52:27 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10C4C1137840
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:52:27 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E6638575C;
 Thu, 23 Jan 2020 13:52:25 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 46/59] object: release all props
Date: Thu, 23 Jan 2020 14:50:36 +0100
Message-Id: <1579787449-27599-47-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 8TqNCaWnOv2nCET-3CkjGQ-1
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

Class properties may have to release resources when the object is
destroyed. Let's use the existing release() callback for that, but
class properties must not release ObjectProperty, as it can be shared
by various instances.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-18-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/object.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index a3da546..66c4a5f 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -592,23 +592,22 @@ static inline bool object_property_is_child(ObjectPro=
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
1.8.3.1



