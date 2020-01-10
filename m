Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BECC282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F7D120673
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WD3la8cJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7D120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipwKT-00038x-T8
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 10:36:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwGE-0006Ot-Ju
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:31:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwGD-0004HE-C4
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:31:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25065
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ipwGD-0004Dl-44
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:31:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578670296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6iwpJ+Xcza8S40JbJyuHHs29eFa1MUlrSIufdGxMdbs=;
 b=WD3la8cJz7PVKnlKvd/kNzjjEZtkaFB4qHOKUnSzQElpE582IAVg+t60IfuDwtBuzDOlZI
 sYQF0hoVRzYW2bhRvmjEQXthhOgC2+kF1GjdvzChC4H44he8uKxR2XujZOKT3DLCmpB/iR
 g0CYV6WdcK2Pps8N68bqBidEO33f9mA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-VPqZf1VMPBqMThgwf6C9rg-1; Fri, 10 Jan 2020 10:31:35 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76DB2911BD
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 15:31:34 +0000 (UTC)
Received: from localhost (ovpn-112-59.ams2.redhat.com [10.36.112.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C6C35C1B5;
 Fri, 10 Jan 2020 15:31:28 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/26] qdev: move helper function to monitor/misc
Date: Fri, 10 Jan 2020 19:30:17 +0400
Message-Id: <20200110153039.1379601-5-marcandre.lureau@redhat.com>
In-Reply-To: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
References: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: VPqZf1VMPBqMThgwf6C9rg-1
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

Move the one-user function to the place it is being used.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/qdev-core.h |  2 --
 hw/core/qdev.c         | 26 --------------------------
 monitor/misc.c         | 26 ++++++++++++++++++++++++++
 3 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 1518495b1e..6b0e7b265d 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -457,8 +457,6 @@ extern bool qdev_hot_removed;
=20
 char *qdev_get_dev_path(DeviceState *dev);
=20
-GSList *qdev_build_hotpluggable_device_list(Object *peripheral);
-
 void qbus_set_hotplug_handler(BusState *bus, Object *handler, Error **errp=
);
=20
 void qbus_set_bus_hotplug_handler(BusState *bus, Error **errp);
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index c2aa7f91a6..a520d7fa89 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -760,32 +760,6 @@ void qdev_alias_all_properties(DeviceState *target, Ob=
ject *source)
     } while (class !=3D object_class_by_name(TYPE_DEVICE));
 }
=20
-static int qdev_add_hotpluggable_device(Object *obj, void *opaque)
-{
-    GSList **list =3D opaque;
-    DeviceState *dev =3D (DeviceState *)object_dynamic_cast(OBJECT(obj),
-                                                          TYPE_DEVICE);
-
-    if (dev =3D=3D NULL) {
-        return 0;
-    }
-
-    if (dev->realized && object_property_get_bool(obj, "hotpluggable", NUL=
L)) {
-        *list =3D g_slist_append(*list, dev);
-    }
-
-    return 0;
-}
-
-GSList *qdev_build_hotpluggable_device_list(Object *peripheral)
-{
-    GSList *list =3D NULL;
-
-    object_child_foreach(peripheral, qdev_add_hotpluggable_device, &list);
-
-    return list;
-}
-
 static bool device_get_realized(Object *obj, Error **errp)
 {
     DeviceState *dev =3D DEVICE(obj);
diff --git a/monitor/misc.c b/monitor/misc.c
index a04d7edde0..be3c700511 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -1954,6 +1954,32 @@ void object_add_completion(ReadLineState *rs, int nb=
_args, const char *str)
     g_slist_free(list);
 }
=20
+static int qdev_add_hotpluggable_device(Object *obj, void *opaque)
+{
+    GSList **list =3D opaque;
+    DeviceState *dev =3D (DeviceState *)object_dynamic_cast(OBJECT(obj),
+                                                          TYPE_DEVICE);
+
+    if (dev =3D=3D NULL) {
+        return 0;
+    }
+
+    if (dev->realized && object_property_get_bool(obj, "hotpluggable", NUL=
L)) {
+        *list =3D g_slist_append(*list, dev);
+    }
+
+    return 0;
+}
+
+static GSList *qdev_build_hotpluggable_device_list(Object *peripheral)
+{
+    GSList *list =3D NULL;
+
+    object_child_foreach(peripheral, qdev_add_hotpluggable_device, &list);
+
+    return list;
+}
+
 static void peripheral_device_del_completion(ReadLineState *rs,
                                              const char *str, size_t len)
 {
--=20
2.25.0.rc1.20.g2443f3f80d.dirty


