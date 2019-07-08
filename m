Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D9CC606BD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 14:22:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89E0B20844
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 14:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E0B20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkUXg-0006Ez-Jj
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 10:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39926)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hkUTd-0001t0-Mp
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 10:18:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hkUTc-0008VZ-AX
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 10:18:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47578)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hkUTZ-0008Nh-79; Mon, 08 Jul 2019 10:18:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4DD722E95AF;
 Mon,  8 Jul 2019 14:18:26 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-204.ams2.redhat.com
 [10.36.116.204])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4520551F00;
 Mon,  8 Jul 2019 14:18:24 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  8 Jul 2019 16:18:08 +0200
Message-Id: <20190708141812.3974-3-kwolf@redhat.com>
In-Reply-To: <20190708141812.3974-1-kwolf@redhat.com>
References: <20190708141812.3974-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 08 Jul 2019 14:18:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/6] qdev: add qdev_add_vm_change_state_handler()
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Children sometimes depend on their parent's vm change state handler
having completed.  Add a vm change state handler API for devices that
guarantees tree depth ordering.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/hw/qdev-core.h            |  5 +++
 hw/core/vm-change-state-handler.c | 61 +++++++++++++++++++++++++++++++
 hw/core/Makefile.objs             |  1 +
 3 files changed, 67 insertions(+)
 create mode 100644 hw/core/vm-change-state-handler.c

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index fa55dc10ae..e157fc4acd 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -6,6 +6,7 @@
 #include "qom/object.h"
 #include "hw/irq.h"
 #include "hw/hotplug.h"
+#include "sysemu/sysemu.h"
=20
 enum {
     DEV_NVECTORS_UNSPECIFIED =3D -1,
@@ -450,4 +451,8 @@ static inline bool qbus_is_hotpluggable(BusState *bus=
)
 void device_listener_register(DeviceListener *listener);
 void device_listener_unregister(DeviceListener *listener);
=20
+VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
+                                                     VMChangeStateHandle=
r *cb,
+                                                     void *opaque);
+
 #endif
diff --git a/hw/core/vm-change-state-handler.c b/hw/core/vm-change-state-=
handler.c
new file mode 100644
index 0000000000..f814813bdd
--- /dev/null
+++ b/hw/core/vm-change-state-handler.c
@@ -0,0 +1,61 @@
+/*
+ *  qdev vm change state handlers
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License,
+ *  or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/qdev.h"
+
+static int qdev_get_dev_tree_depth(DeviceState *dev)
+{
+    int depth;
+
+    for (depth =3D 0; dev; depth++) {
+        BusState *bus =3D dev->parent_bus;
+
+        if (!bus) {
+            break;
+        }
+
+        dev =3D bus->parent;
+    }
+
+    return depth;
+}
+
+/**
+ * qdev_add_vm_change_state_handler:
+ * @dev: the device that owns this handler
+ * @cb: the callback function to be invoked
+ * @opaque: user data passed to the callback function
+ *
+ * This function works like qemu_add_vm_change_state_handler() except ca=
llbacks
+ * are invoked in qdev tree depth order.  Ordering is desirable when cal=
lbacks
+ * of children depend on their parent's callback having completed first.
+ *
+ * For example, when qdev_add_vm_change_state_handler() is used, a host
+ * controller's callback is invoked before the children on its bus when =
the VM
+ * starts running.  The order is reversed when the VM stops running.
+ *
+ * Returns: an entry to be freed with qemu_del_vm_change_state_handler()
+ */
+VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
+                                                     VMChangeStateHandle=
r *cb,
+                                                     void *opaque)
+{
+    int depth =3D qdev_get_dev_tree_depth(dev);
+
+    return qemu_add_vm_change_state_handler_prio(cb, opaque, depth);
+}
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index 585b734358..f8481d959f 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -7,6 +7,7 @@ common-obj-$(CONFIG_SOFTMMU) +=3D fw-path-provider.o
 common-obj-y +=3D irq.o
 common-obj-y +=3D hotplug.o
 common-obj-$(CONFIG_SOFTMMU) +=3D nmi.o
+common-obj-$(CONFIG_SOFTMMU) +=3D vm-change-state-handler.o
=20
 common-obj-$(CONFIG_EMPTY_SLOT) +=3D empty_slot.o
 common-obj-$(CONFIG_XILINX_AXI) +=3D stream.o
--=20
2.20.1


