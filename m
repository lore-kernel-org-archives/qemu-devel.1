Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D86C2D0D2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 11:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F4B424679
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 11:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="edY8xwc7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4B424679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiGr1-0003tQ-Ku
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 06:53:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iiGnx-00027X-0V
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 06:50:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iiGnv-0006KA-0Q
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 06:50:48 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:45158)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iiGnu-0006DS-HM; Fri, 20 Dec 2019 06:50:46 -0500
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id 411A596F50;
 Fri, 20 Dec 2019 11:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1576842644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PpHoXuHlpJhTzZtQPwaaSA0+kK/O1IXO/0ZNsdEBgsk=;
 b=edY8xwc77KfJCrwsyoiBUwdIRvczjzrsUKJDVsZThVMawjj7mJY1quZUbdjTYs4uc+Q1fP
 ZFqQV4ibvr4wmbe52k8sQd3uAB8qF2+3ntNYXQjx0Mlq+3X4DvLPEZ0ZfvrEiVvIS1KXzQ
 HVVWTeUU3vPH72dlMHbjcGz5QmnaOlM=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 02/11] hw/core/qdev: add trace events to help with
 resettable transition
Date: Fri, 20 Dec 2019 12:50:26 +0100
Message-Id: <20191220115035.709876-3-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220115035.709876-1-damien.hedde@greensocs.com>
References: <20191220115035.709876-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1576842644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PpHoXuHlpJhTzZtQPwaaSA0+kK/O1IXO/0ZNsdEBgsk=;
 b=Ikp5OK1Xlh8o7o0fcCVgLacwhUAXz6MnUF6OL0+77Me27FYh0VjEdbVVV1Qa6aEY9vvmns
 nc76gypMeHrpmF/YV2WLIcz0SrawBGan/ZHqnx5/1B8pWWDaEXL4PzbEQkK1vRLsofqCd7
 Nv8dnKx3ot/qQ5+W1rOMZ02X294xc9M=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1576842644; a=rsa-sha256; cv=none;
 b=6yvyNkg4iaBKjqs28PKOD9f0awPzCpiMTpDgUEgHZ3dNq1VOQoLmukcNCOWmrZYub+6SCO
 /2rIvcOZ01zRcHnc0CfaVml/pkrVnUQRqP2DCoyBC1FtTQ9scJi0dHvu5ZB97oRipA1OXa
 cpiV+67BaYnNB56Dbkjs6CJBhMq2V84=
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
 berrange@redhat.com, ehabkost@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>, cohuck@redhat.com,
 mark.burton@greensocs.com, qemu-s390x@nongnu.org, edgari@xilinx.com,
 pbonzini@redhat.com, philmd@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adds trace events to reset procedure and when updating the parent
bus of a device.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/core/qdev.c       | 29 ++++++++++++++++++++++++++---
 hw/core/trace-events |  9 +++++++++
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 45564370f4..6cf01abea9 100644
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
@@ -98,7 +99,11 @@ void qdev_set_parent_bus(DeviceState *dev, BusState *b=
us)
     bool replugging =3D dev->parent_bus !=3D NULL;
=20
     if (replugging) {
-        /* Keep a reference to the device while it's not plugged into
+        trace_qdev_update_parent_bus(dev, object_get_typename(OBJECT(dev=
)),
+            dev->parent_bus, object_get_typename(OBJECT(dev->parent_bus)=
),
+            OBJECT(bus), object_get_typename(OBJECT(bus)));
+        /*
+         * Keep a reference to the device while it's not plugged into
          * any bus, to avoid it potentially evaporating when it is
          * dereffed in bus_remove_child().
          */
@@ -296,6 +301,18 @@ HotplugHandler *qdev_get_hotplug_handler(DeviceState=
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
@@ -306,6 +323,7 @@ static int qdev_reset_one(DeviceState *dev, void *opa=
que)
 static int qbus_reset_one(BusState *bus, void *opaque)
 {
     BusClass *bc =3D BUS_GET_CLASS(bus);
+    trace_qbus_reset(bus, object_get_typename(OBJECT(bus)));
     if (bc->reset) {
         bc->reset(bus);
     }
@@ -314,7 +332,9 @@ static int qbus_reset_one(BusState *bus, void *opaque=
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
@@ -324,7 +344,9 @@ void qdev_reset_all_fn(void *opaque)
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
@@ -1133,6 +1155,7 @@ void device_legacy_reset(DeviceState *dev)
 {
     DeviceClass *klass =3D DEVICE_GET_CLASS(dev);
=20
+    trace_qdev_reset(dev, object_get_typename(OBJECT(dev)));
     if (klass->reset) {
         klass->reset(dev);
     }
diff --git a/hw/core/trace-events b/hw/core/trace-events
index fe47a9c8cb..a375aa88a4 100644
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
+qdev_update_parent_bus(void *obj, const char *objtype, void *oldp, const=
 char *oldptype, void *newp, const char *newptype) "obj=3D%p(%s) old_pare=
nt=3D%p(%s) new_parent=3D%p(%s)"
--=20
2.24.0


