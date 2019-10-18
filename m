Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6189CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:11:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F10421897
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="PBwy97xz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F10421897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLTv2-000122-KR
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 11:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iLTrA-0006i2-2X
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:07:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iLTr8-0000GG-OU
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:07:55 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:38632)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iLTr5-0000Bb-3T; Fri, 18 Oct 2019 11:07:51 -0400
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id 8F51196F50;
 Fri, 18 Oct 2019 15:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1571411270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zfp9zlChmuFK1Pa2AVwC8e4Fq2eoeBhB8UD5of7fOMs=;
 b=PBwy97xzkwO5a+WE8Uw44NrivQqmB6ffNzafEeuQfl8sehIeNzjrBr/GYcI+vFLhTATFFt
 l2WdumD/scex6A/CLEelHaClHtbN5ZPYPvkb4uNtqHWdrsk62RhpZsO5f03l9Qy7E7IuLW
 v1lDjra5z0hJWGKNRYlgJDxzKaMoZwU=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 02/13] hw/core/qdev: add trace events to help with
 resettable transition
Date: Fri, 18 Oct 2019 17:06:19 +0200
Message-Id: <20191018150630.31099-3-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018150630.31099-1-damien.hedde@greensocs.com>
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1571411270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zfp9zlChmuFK1Pa2AVwC8e4Fq2eoeBhB8UD5of7fOMs=;
 b=mESurmyKi15E7+sjU1odZZIJeXpGvKmr2vXUGCJNUOGVl63oaWILcJRkKOHwbl3AfFOe3/
 4y/+83014ICrz6f6uscPHY2T8Aa0DVd2AmURoe7EDugpBO8ueTnb2RXWkaE8O6SMjx8h95
 Hz39UGcezTQnZ8+gJVAvzx1YQ6Lsc7g=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1571411270; a=rsa-sha256; cv=none;
 b=ccxL60ncAMyHElXbkVU63rvERbdZAc1My1LAvQOJcMd77zQFJ78pI72WZk1B5AeEEMp1s9
 nQqRU7YLAsn0Tq/TQEyYZm7jjaVzPcmwyPdHJgF3JZuMTTdy/8rGHd0uk6e2/9hmeRxbQJ
 Xo42DMAB9xHNTmG4Md/u0J+jKt7MnHI=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, peter.maydell@linaro.org,
 berrange@redhat.com, ehabkost@redhat.com, cohuck@redhat.com,
 mark.burton@greensocs.com, qemu-s390x@nongnu.org, edgari@xilinx.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com, philmd@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adds trace events to reset procedure and when updating the parent
bus of a device.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/core/qdev.c       | 27 ++++++++++++++++++++++++---
 hw/core/trace-events |  9 +++++++++
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 60be2f2fef..f230063189 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -38,6 +38,7 @@
 #include "hw/boards.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
+#include "trace.h"
=20
 bool qdev_hotplug =3D false;
 static bool qdev_hot_added =3D false;
@@ -98,7 +99,9 @@ void qdev_set_parent_bus(DeviceState *dev, BusState *bu=
s)
     bool replugging =3D dev->parent_bus !=3D NULL;
=20
     if (replugging) {
-        /* Keep a reference to the device while it's not plugged into
+        trace_qdev_update_parent_bus(dev, dev->parent_bus, bus);
+        /*
+         * Keep a reference to the device while it's not plugged into
          * any bus, to avoid it potentially evaporating when it is
          * dereffed in bus_remove_child().
          */
@@ -272,6 +275,18 @@ HotplugHandler *qdev_get_hotplug_handler(DeviceState=
 *dev)
     return hotplug_ctrl;
 }
=20
+static int qdev_prereset(DeviceState *dev, void *opaque)
+{
+    trace_qdev_reset_tree(dev, object_get_typename(OBJECT(dev)));
+    return 0;
+}
+
+static int qbus_prereset(BusState *bus, void *opaque)
+{
+    trace_qbus_reset_tree(bus, object_get_typename(OBJECT(bus)));
+    return 0;
+}
+
 static int qdev_reset_one(DeviceState *dev, void *opaque)
 {
     device_legacy_reset(dev);
@@ -282,6 +297,7 @@ static int qdev_reset_one(DeviceState *dev, void *opa=
que)
 static int qbus_reset_one(BusState *bus, void *opaque)
 {
     BusClass *bc =3D BUS_GET_CLASS(bus);
+    trace_qbus_reset(bus, object_get_typename(OBJECT(bus)));
     if (bc->reset) {
         bc->reset(bus);
     }
@@ -290,7 +306,9 @@ static int qbus_reset_one(BusState *bus, void *opaque=
)
=20
 void qdev_reset_all(DeviceState *dev)
 {
-    qdev_walk_children(dev, NULL, NULL, qdev_reset_one, qbus_reset_one, =
NULL);
+    trace_qdev_reset_all(dev, object_get_typename(OBJECT(dev)));
+    qdev_walk_children(dev, qdev_prereset, qbus_prereset,
+                       qdev_reset_one, qbus_reset_one, NULL);
 }
=20
 void qdev_reset_all_fn(void *opaque)
@@ -300,7 +318,9 @@ void qdev_reset_all_fn(void *opaque)
=20
 void qbus_reset_all(BusState *bus)
 {
-    qbus_walk_children(bus, NULL, NULL, qdev_reset_one, qbus_reset_one, =
NULL);
+    trace_qbus_reset_all(bus, object_get_typename(OBJECT(bus)));
+    qbus_walk_children(bus, qdev_prereset, qbus_prereset,
+                       qdev_reset_one, qbus_reset_one, NULL);
 }
=20
 void qbus_reset_all_fn(void *opaque)
@@ -1108,6 +1128,7 @@ void device_legacy_reset(DeviceState *dev)
 {
     DeviceClass *klass =3D DEVICE_GET_CLASS(dev);
=20
+    trace_qdev_reset(dev, object_get_typename(OBJECT(dev)));
     if (klass->reset) {
         klass->reset(dev);
     }
diff --git a/hw/core/trace-events b/hw/core/trace-events
index fe47a9c8cb..1a669be0ea 100644
--- a/hw/core/trace-events
+++ b/hw/core/trace-events
@@ -1,2 +1,11 @@
 # loader.c
 loader_write_rom(const char *name, uint64_t gpa, uint64_t size, bool isr=
om) "%s: @0x%"PRIx64" size=3D0x%"PRIx64" ROM=3D%d"
+
+# qdev.c
+qdev_reset(void *obj, const char *objtype) "obj=3D%p(%s)"
+qdev_reset_all(void *obj, const char *objtype) "obj=3D%p(%s)"
+qdev_reset_tree(void *obj, const char *objtype) "obj=3D%p(%s)"
+qbus_reset(void *obj, const char *objtype) "obj=3D%p(%s)"
+qbus_reset_all(void *obj, const char *objtype) "obj=3D%p(%s)"
+qbus_reset_tree(void *obj, const char *objtype) "obj=3D%p(%s)"
+qdev_update_parent_bus(void *obj, void *oldp, void *newp) "obj=3D%p old_=
parent=3D%p new_parent=3D%p"
--=20
2.23.0


