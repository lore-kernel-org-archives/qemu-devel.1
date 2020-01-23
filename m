Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8216C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A359121569
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHzOgtkg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A359121569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugIK-0003cq-8P
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iucuW-0001aH-JA
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iucuV-0001LT-DS
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26909
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iucuV-0001LL-9c
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ogljl5KfhNVv2vyCzFUPBamFIxFTcJlA1HisO0RvD8=;
 b=KHzOgtkgDX6LgAKuWDBq1VgWf8/qPvkto+yGFV4WmmgBTqBKbyaCjyPh4PWMgAaRHxYgtl
 vmqlEbgQDA+69tFP6+T7/H7T5wTPiWMB4R5OlWGZkJ7WoGT3cHdjRmMYMHdC1X5LoTJkBx
 ae3rHojMgzuZgb3kdNfZ1sCxCjWjKcM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-jZvSAUMPNv-QjOBaqRRwHQ-1; Thu, 23 Jan 2020 08:52:37 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51F5A100EC87
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:52:36 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 07BD71CB;
 Thu, 23 Jan 2020 13:52:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 50/59] qdev: move instance properties to class properties
Date: Thu, 23 Jan 2020 14:50:40 +0100
Message-Id: <1579787449-27599-51-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: jZvSAUMPNv-QjOBaqRRwHQ-1
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-21-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 100e266..6e4dca1 100644
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
         for (prop =3D DEVICE_CLASS(class)->props_; prop && prop->name; pro=
p++) {
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
@@ -1059,6 +1048,19 @@ static void device_class_init(ObjectClass *class, vo=
id *data)
     dc->hotpluggable =3D true;
     dc->user_creatable =3D true;
     vc->get_id =3D device_vmstate_if_get_id;
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
1.8.3.1



