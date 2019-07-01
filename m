Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64698C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 15:16:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38D40208E4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 15:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D40208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhy2C-0004Sy-76
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 11:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59525)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hhxar-0000vD-Qc
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:47:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hhxap-000610-IN
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:47:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34306)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hhxao-0005jq-Ke
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:47:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B132AC1EB207;
 Mon,  1 Jul 2019 14:47:22 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E6865BA4D;
 Mon,  1 Jul 2019 14:47:16 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, ehabkost@redhat.com, maran.wilson@oracle.com
Date: Mon,  1 Jul 2019 16:47:02 +0200
Message-Id: <20190701144705.102615-2-slp@redhat.com>
In-Reply-To: <20190701144705.102615-1-slp@redhat.com>
References: <20190701144705.102615-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 01 Jul 2019 14:47:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 1/4] hw/virtio: Factorize virtio-mmio headers
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
Cc: qemu-devel@nongnu.org, Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Put QOM and main struct definition in a separate header file, so it
can be accesed from other components.

This is needed for the microvm machine type implementation.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 hw/virtio/virtio-mmio.c | 35 +-----------------------
 hw/virtio/virtio-mmio.h | 60 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 34 deletions(-)
 create mode 100644 hw/virtio/virtio-mmio.h

diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 97b7f35496..87c7fe4d8d 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -26,44 +26,11 @@
 #include "qemu/host-utils.h"
 #include "qemu/module.h"
 #include "sysemu/kvm.h"
-#include "hw/virtio/virtio-bus.h"
+#include "virtio-mmio.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "trace.h"
=20
-/* QOM macros */
-/* virtio-mmio-bus */
-#define TYPE_VIRTIO_MMIO_BUS "virtio-mmio-bus"
-#define VIRTIO_MMIO_BUS(obj) \
-        OBJECT_CHECK(VirtioBusState, (obj), TYPE_VIRTIO_MMIO_BUS)
-#define VIRTIO_MMIO_BUS_GET_CLASS(obj) \
-        OBJECT_GET_CLASS(VirtioBusClass, (obj), TYPE_VIRTIO_MMIO_BUS)
-#define VIRTIO_MMIO_BUS_CLASS(klass) \
-        OBJECT_CLASS_CHECK(VirtioBusClass, (klass), TYPE_VIRTIO_MMIO_BUS=
)
-
-/* virtio-mmio */
-#define TYPE_VIRTIO_MMIO "virtio-mmio"
-#define VIRTIO_MMIO(obj) \
-        OBJECT_CHECK(VirtIOMMIOProxy, (obj), TYPE_VIRTIO_MMIO)
-
-#define VIRT_MAGIC 0x74726976 /* 'virt' */
-#define VIRT_VERSION 1
-#define VIRT_VENDOR 0x554D4551 /* 'QEMU' */
-
-typedef struct {
-    /* Generic */
-    SysBusDevice parent_obj;
-    MemoryRegion iomem;
-    qemu_irq irq;
-    /* Guest accessible state needing migration and reset */
-    uint32_t host_features_sel;
-    uint32_t guest_features_sel;
-    uint32_t guest_page_shift;
-    /* virtio-bus */
-    VirtioBusState bus;
-    bool format_transport_address;
-} VirtIOMMIOProxy;
-
 static bool virtio_mmio_ioeventfd_enabled(DeviceState *d)
 {
     return kvm_eventfds_enabled();
diff --git a/hw/virtio/virtio-mmio.h b/hw/virtio/virtio-mmio.h
new file mode 100644
index 0000000000..2f3973f8c7
--- /dev/null
+++ b/hw/virtio/virtio-mmio.h
@@ -0,0 +1,60 @@
+/*
+ * Virtio MMIO bindings
+ *
+ * Copyright (c) 2011 Linaro Limited
+ *
+ * Author:
+ *  Peter Maydell <peter.maydell@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License; either version =
2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License alo=
ng
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef QEMU_VIRTIO_MMIO_H
+#define QEMU_VIRTIO_MMIO_H
+
+#include "hw/virtio/virtio-bus.h"
+
+/* QOM macros */
+/* virtio-mmio-bus */
+#define TYPE_VIRTIO_MMIO_BUS "virtio-mmio-bus"
+#define VIRTIO_MMIO_BUS(obj) \
+        OBJECT_CHECK(VirtioBusState, (obj), TYPE_VIRTIO_MMIO_BUS)
+#define VIRTIO_MMIO_BUS_GET_CLASS(obj) \
+        OBJECT_GET_CLASS(VirtioBusClass, (obj), TYPE_VIRTIO_MMIO_BUS)
+#define VIRTIO_MMIO_BUS_CLASS(klass) \
+        OBJECT_CLASS_CHECK(VirtioBusClass, (klass), TYPE_VIRTIO_MMIO_BUS=
)
+
+/* virtio-mmio */
+#define TYPE_VIRTIO_MMIO "virtio-mmio"
+#define VIRTIO_MMIO(obj) \
+        OBJECT_CHECK(VirtIOMMIOProxy, (obj), TYPE_VIRTIO_MMIO)
+
+#define VIRT_MAGIC 0x74726976 /* 'virt' */
+#define VIRT_VERSION 1
+#define VIRT_VENDOR 0x554D4551 /* 'QEMU' */
+
+typedef struct {
+    /* Generic */
+    SysBusDevice parent_obj;
+    MemoryRegion iomem;
+    qemu_irq irq;
+    /* Guest accessible state needing migration and reset */
+    uint32_t host_features_sel;
+    uint32_t guest_features_sel;
+    uint32_t guest_page_shift;
+    /* virtio-bus */
+    VirtioBusState bus;
+    bool format_transport_address;
+} VirtIOMMIOProxy;
+
+#endif
--=20
2.21.0


