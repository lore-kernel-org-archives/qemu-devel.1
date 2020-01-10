Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2B2C33CA3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:37:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA2920721
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTgXvOPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA2920721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipwLd-00059M-7r
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 10:37:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwIn-0001HG-PD
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:34:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwIh-0004XV-6B
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:34:18 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59529
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ipwIh-0004RT-1W
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578670453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nwpk7VZAEQIMAD7TtXuj2pmlGsNRAk6j7Nvy1roySqc=;
 b=VTgXvOPsO2/2nCqW3B14Qq9PKz49tLdnUb0JOMjnVmn8dP8vVfOWtyfLXFZRwH49ZNwug2
 yT1gli2IOSyZZeKWF5YUQxxSyMV5Co4pjR+7t6hszLYGF5yMKgqm20VvSzSSrt6u3lwPSj
 z3DRLcvFzekAff8EP4PsafJ4E6ekI3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-BNlCamiwMWGsMpc4XlUqRw-1; Fri, 10 Jan 2020 10:34:12 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A20F41005502
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 15:34:09 +0000 (UTC)
Received: from localhost (ovpn-112-59.ams2.redhat.com [10.36.112.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 54CE678E77;
 Fri, 10 Jan 2020 15:34:07 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/26] object: release all props
Date: Fri, 10 Jan 2020 19:30:30 +0400
Message-Id: <20200110153039.1379601-18-marcandre.lureau@redhat.com>
In-Reply-To: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
References: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: BNlCamiwMWGsMpc4XlUqRw-1
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

Class properties may have to release resources when the object is
destroyed. Let's use the existing release() callback for that, but
class properties must not release ObjectProperty, as it can be shared
by various instances.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qom/object.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 04f2991716..3924678ec3 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -583,23 +583,22 @@ static inline bool object_property_is_child(ObjectPro=
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
2.25.0.rc1.20.g2443f3f80d.dirty


