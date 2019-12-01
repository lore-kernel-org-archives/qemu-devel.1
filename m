Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5046C432C3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E6B20833
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XfrDpYWy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E6B20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibNYY-0007Lj-6h
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 06:38:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNFx-0002zZ-1Q
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:19:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNFt-0001e2-7x
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:19:11 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50419
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ibNFr-0001Y8-8C
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:19:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575199145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VrZTg3pTZw4WvT6qYfw4aYHeFEkfHH58fQ3DhtoxVaI=;
 b=XfrDpYWyLoF5EUwHcS8DpbZs9R3ajwO6houWaC47/Y+69RQBJv9jmojWAA9ycwi3vl77Bh
 7Vyl1vzM5dDlKSYyqlXMMpXgOQFRxQpnhU5dHDRx4TZKGuz4QiQgkeBo6i3wifoxOrkVTa
 wUb17s72pO3GDQDI/kbT6wfWoc2IH8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-OC_FA6hAOPqQDEWWGn8wMw-1; Sun, 01 Dec 2019 06:19:04 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 812EA80183C
 for <qemu-devel@nongnu.org>; Sun,  1 Dec 2019 11:19:03 +0000 (UTC)
Received: from localhost (unknown [10.36.112.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE7C610013A7;
 Sun,  1 Dec 2019 11:18:59 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/26] qdev: move instance properties to class properties
Date: Sun,  1 Dec 2019 15:15:25 +0400
Message-Id: <20191201111531.1136947-21-marcandre.lureau@redhat.com>
In-Reply-To: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
References: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: OC_FA6hAOPqQDEWWGn8wMw-1
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/core/qdev.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 9e70b32c4b..dabf927eaa 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -944,14 +944,6 @@ static void device_initfn(Object *obj)
     dev->realized =3D false;
     dev->allow_unplug_during_migration =3D false;
=20
-    object_property_add_bool(obj, "realized",
-                             device_get_realized, device_set_realized, NUL=
L);
-    object_property_add_bool(obj, "hotpluggable",
-                             device_get_hotpluggable, NULL, NULL);
-    object_property_add_bool(obj, "hotplugged",
-                             device_get_hotplugged, NULL,
-                             &error_abort);
-
     class =3D object_get_class(OBJECT(dev));
     do {
         for (prop =3D DEVICE_CLASS(class)->props; prop && prop->name; prop=
++) {
@@ -961,9 +953,6 @@ static void device_initfn(Object *obj)
         class =3D object_class_get_parent(class);
     } while (class !=3D object_class_by_name(TYPE_DEVICE));
=20
-    object_property_add_link(OBJECT(dev), "parent_bus", TYPE_BUS,
-                             (Object **)&dev->parent_bus, NULL, 0,
-                             &error_abort);
     QLIST_INIT(&dev->gpios);
 }
=20
@@ -1049,6 +1038,19 @@ static void device_class_init(ObjectClass *class, vo=
id *data)
      */
     dc->hotpluggable =3D true;
     dc->user_creatable =3D true;
+
+    object_class_property_add_bool(class, "realized",
+                                   device_get_realized, device_set_realize=
d,
+                                   &error_abort);
+    object_class_property_add_bool(class, "hotpluggable",
+                                   device_get_hotpluggable, NULL,
+                                   &error_abort);
+    object_class_property_add_bool(class, "hotplugged",
+                                   device_get_hotplugged, NULL,
+                                   &error_abort);
+    object_class_property_add_link(class, "parent_bus", TYPE_BUS,
+                                   offsetof(DeviceState, parent_bus), NULL=
, 0,
+                                   &error_abort);
 }
=20
 void device_class_set_props(DeviceClass *dc, Property *props)
--=20
2.24.0


