Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83EBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:56:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F4EA207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlqhzEN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F4EA207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufm5-0004tI-0n
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:56:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iucu3-0000pV-Dm
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iucu2-0000td-3f
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34447
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iucu2-0000so-0L
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YakKicgq1yczgnsimWE5XO2RYGDnHLqN9vhs4Cs4jBM=;
 b=hlqhzEN1q8UeF8IlUPCnsIvguoxru5okssvQwU0KqCwsOUv3rYJi2IBYLU3UX0nOf51hwt
 YI7YUhPrnRxIPo92/8YFGAfOPxZfn9shf1avdYR//7dmiuqZuAnmybb9M7ELv+PACYvH4E
 kEgoUGN7kKfrI7JZ3lxp5m/ZvNwpzms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-T-vPD1tuOUWiDPm9JLYyzA-1; Thu, 23 Jan 2020 08:52:08 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FEB46C197
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:52:07 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0B698575A;
 Thu, 23 Jan 2020 13:52:03 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 34/59] qdev: move helper function to monitor/misc
Date: Thu, 23 Jan 2020 14:50:24 +0100
Message-Id: <1579787449-27599-35-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: T-vPD1tuOUWiDPm9JLYyzA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Move the one-user function to the place it is being used.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200110153039.1379601-5-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev.c         | 26 --------------------------
 include/hw/qdev-core.h |  2 --
 monitor/misc.c         | 26 ++++++++++++++++++++++++++
 3 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 60aec8b..8708605 100644
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
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 1518495..6b0e7b2 100644
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
diff --git a/monitor/misc.c b/monitor/misc.c
index de1ca4d..4752150 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -1959,6 +1959,32 @@ void object_add_completion(ReadLineState *rs, int nb=
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
1.8.3.1



