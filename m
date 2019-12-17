Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27F5C2D0C5
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:42:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0B81206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A07vhD7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B81206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih6YR-0003I1-Da
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 01:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49319)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ih6KA-00014o-MI
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ih6K9-0002O0-F0
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50616
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ih6K9-0002MX-Ap
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576564032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C93fgCuYkcySyFZzbNYaKAJAO/+ByfBxZR60vnYOo/s=;
 b=A07vhD7wQJwGqg4HZkUx0lQCrO5oPVVMedQ164Afej3Hv9i6B/kdC1NCQhSY+M3nFlWY7R
 MKxx7yUcDc3xe7Pjk9abXhpRnTXv1P7aiyS8QqhLaPH0zjfq9xl6a1yigKkYJ4K2Y5Nyiw
 YFNUJnxo1vl9GjtAWLjnEuUIDkBwC3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-ZVjbZ_r9OLeqoDda1Tah-Q-1; Tue, 17 Dec 2019 01:27:01 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEE3C477;
 Tue, 17 Dec 2019 06:26:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 86CD8620B0;
 Tue, 17 Dec 2019 06:26:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8CB301136426; Tue, 17 Dec 2019 07:26:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/34] hw/core/qdev: cleanup Error ** variables
Date: Tue, 17 Dec 2019 07:26:39 +0100
Message-Id: <20191217062651.9687-23-armbru@redhat.com>
In-Reply-To: <20191217062651.9687-1-armbru@redhat.com>
References: <20191217062651.9687-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ZVjbZ_r9OLeqoDda1Tah-Q-1
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Rename Error ** parameter in check_only_migratable to common errp.

In device_set_realized:

 - Move "if (local_err !=3D NULL)" closer to error setters.

 - Drop 'Error **local_errp': it doesn't save any LoCs, but it's very
   unusual.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20191205174635.18758-10-vsementsov@virtuozzo.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/core/qdev.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index cf1ba28fe3..82d3ee590a 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -820,12 +820,12 @@ static bool device_get_realized(Object *obj, Error **=
errp)
     return dev->realized;
 }
=20
-static bool check_only_migratable(Object *obj, Error **err)
+static bool check_only_migratable(Object *obj, Error **errp)
 {
     DeviceClass *dc =3D DEVICE_GET_CLASS(obj);
=20
     if (!vmstate_check_only_migratable(dc->vmsd)) {
-        error_setg(err, "Device %s is not migratable, but "
+        error_setg(errp, "Device %s is not migratable, but "
                    "--only-migratable was specified",
                    object_get_typename(obj));
         return false;
@@ -874,10 +874,9 @@ static void device_set_realized(Object *obj, bool valu=
e, Error **errp)
=20
         if (dc->realize) {
             dc->realize(dev, &local_err);
-        }
-
-        if (local_err !=3D NULL) {
-            goto fail;
+            if (local_err !=3D NULL) {
+                goto fail;
+            }
         }
=20
         DEVICE_LISTENER_CALL(realize, Forward, dev);
@@ -918,27 +917,26 @@ static void device_set_realized(Object *obj, bool val=
ue, Error **errp)
        }
=20
     } else if (!value && dev->realized) {
-        Error **local_errp =3D NULL;
+        /* We want local_err to track only the first error */
         QLIST_FOREACH(bus, &dev->child_bus, sibling) {
-            local_errp =3D local_err ? NULL : &local_err;
             object_property_set_bool(OBJECT(bus), false, "realized",
-                                     local_errp);
+                                     local_err ? NULL : &local_err);
         }
         if (qdev_get_vmsd(dev)) {
             vmstate_unregister(dev, qdev_get_vmsd(dev), dev);
         }
         if (dc->unrealize) {
-            local_errp =3D local_err ? NULL : &local_err;
-            dc->unrealize(dev, local_errp);
+            dc->unrealize(dev, local_err ? NULL : &local_err);
         }
         dev->pending_deleted_event =3D true;
         DEVICE_LISTENER_CALL(unrealize, Reverse, dev);
-    }
=20
-    if (local_err !=3D NULL) {
-        goto fail;
+        if (local_err !=3D NULL) {
+            goto fail;
+        }
     }
=20
+    assert(local_err =3D=3D NULL);
     dev->realized =3D value;
     return;
=20
@@ -976,7 +974,7 @@ static bool device_get_hotpluggable(Object *obj, Error =
**errp)
                                 qbus_is_hotpluggable(dev->parent_bus));
 }
=20
-static bool device_get_hotplugged(Object *obj, Error **err)
+static bool device_get_hotplugged(Object *obj, Error **errp)
 {
     DeviceState *dev =3D DEVICE(obj);
=20
--=20
2.21.0


