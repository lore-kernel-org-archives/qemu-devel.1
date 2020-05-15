Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D730FC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:25:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 664532076A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbaQzksl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664532076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZcDm-0003E9-Fi
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 11:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1jZc9L-0005RZ-9B
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:21:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60380
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1jZc9I-0006sb-Au
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589556079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EBBqIrjwLmRlKj8GHQsnVJV8Ka/DtTZDiJbzF2P/z04=;
 b=MbaQzksl54LBwumIoLAujagPP3li/kaA6U0hbxZzwtgY2HTZz1vNOxKghe1mpmCWl/xnB1
 8/Eka5jT9aaFx+pK5qipjvA3n3KobcZEFpFvx1Uc69g3xUUE946xo7zxQuUQWADY21xdhN
 0eLw62dzJ9iNGsYHAgQ84NXD+HJlJaQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-tng-umM0OMScW5pPRW2F0g-1; Fri, 15 May 2020 11:21:18 -0400
X-MC-Unique: tng-umM0OMScW5pPRW2F0g-1
Received: by mail-wm1-f72.google.com with SMTP id 23so1325960wma.8
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 08:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EBBqIrjwLmRlKj8GHQsnVJV8Ka/DtTZDiJbzF2P/z04=;
 b=T6nzki3bIZ/h6HNMQ309Cc6A5Tt3PQ3xJWYGv18M3ovsp2Ooltzt+zdyJNeRU5LQJ4
 rhGESEAJ3QHWQYtBKNyLFYD7DBCH64mStikVSDRzFeEA1YN1E1YK/kzlKIWhbEc5gWFz
 xGABnCVyBR1reZnvLmW3CcktpP4fIurs8+GCwp3F8g7nBqTipwWOsLG3AVa7pgS9bSSD
 HmN3xY+4dJ57KFwwvFn5FyN3HfJzOJmIivCC8mY5jUqnxJgWfPFTF0B0Rc4N4mYP8WM0
 XaR8PaBa0ISq+NIUKl+mv3objNo8niEVqCIgxV795PDl+X1IZbeiQRO0LNw4XLXB9six
 qtKw==
X-Gm-Message-State: AOAM533rDmotQIfNjxYtqnEgY1CIIdxQVzORiWciXJoM7G4sIcxwq2OZ
 xl8ikLAkSOWpuBUAtbWh09Xt+EPBVmeiQ4xrKSOuNMeyubdgrtR5PF+NqNVjCUXyCMb1MejzOa4
 WqweCSmRjdv0w3DM=
X-Received: by 2002:a1c:5a82:: with SMTP id o124mr3991883wmb.188.1589556076282; 
 Fri, 15 May 2020 08:21:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZaCwjLtzD+XX10FaQcnhA3Fl/c2SVhO+Q5YN0miVrPV10DXVL0Qh2HHYagf7bWlJpqmIAXA==
X-Received: by 2002:a1c:5a82:: with SMTP id o124mr3991863wmb.188.1589556076047; 
 Fri, 15 May 2020 08:21:16 -0700 (PDT)
Received: from steredhat.redhat.com ([79.49.207.108])
 by smtp.gmail.com with ESMTPSA id q9sm3913849wmb.34.2020.05.15.08.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 08:21:15 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] virtio: add vhost-user-vsock-pci device
Date: Fri, 15 May 2020 17:21:10 +0200
Message-Id: <20200515152110.202917-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200515152110.202917-1-sgarzare@redhat.com>
References: <20200515152110.202917-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Julio Montes <julio.montes@intel.com>,
 Sebastien Boeuf <sebastien.boeuf@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the PCI version of vhost-user-vsock

Launch QEMU like this:

  qemu -chardev socket,path=/tmp/vm.vsock,id=chr0 \
       -device vhost-user-vsock-pci,chardev=chr0

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 hw/virtio/vhost-user-vsock-pci.c | 84 ++++++++++++++++++++++++++++++++
 hw/virtio/Makefile.objs          |  1 +
 2 files changed, 85 insertions(+)
 create mode 100644 hw/virtio/vhost-user-vsock-pci.c

diff --git a/hw/virtio/vhost-user-vsock-pci.c b/hw/virtio/vhost-user-vsock-pci.c
new file mode 100644
index 0000000000..0a6847e6fc
--- /dev/null
+++ b/hw/virtio/vhost-user-vsock-pci.c
@@ -0,0 +1,84 @@
+/*
+ * Vhost-user vsock PCI Bindings
+ *
+ * Copyright 2020 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "virtio-pci.h"
+#include "hw/qdev-properties.h"
+#include "hw/virtio/vhost-user-vsock.h"
+
+typedef struct VHostUserVSockPCI VHostUserVSockPCI;
+
+/*
+ * vhost-user-vsock-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VHOST_USER_VSOCK_PCI "vhost-user-vsock-pci-base"
+#define VHOST_USER_VSOCK_PCI(obj) \
+        OBJECT_CHECK(VHostUserVSockPCI, (obj), TYPE_VHOST_USER_VSOCK_PCI)
+
+struct VHostUserVSockPCI {
+    VirtIOPCIProxy parent_obj;
+    VHostUserVSock vdev;
+};
+
+/* vhost-user-vsock-pci */
+
+static Property vhost_user_vsock_pci_properties[] = {
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 3),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vhost_user_vsock_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VHostUserVSockPCI *dev = VHOST_USER_VSOCK_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void vhost_user_vsock_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+    k->realize = vhost_user_vsock_pci_realize;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    device_class_set_props(dc, vhost_user_vsock_pci_properties);
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_VSOCK;
+    pcidev_k->revision = 0x00;
+    pcidev_k->class_id = PCI_CLASS_COMMUNICATION_OTHER;
+}
+
+static void vhost_user_vsock_pci_instance_init(Object *obj)
+{
+    VHostUserVSockPCI *dev = VHOST_USER_VSOCK_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_USER_VSOCK);
+}
+
+static const VirtioPCIDeviceTypeInfo vhost_user_vsock_pci_info = {
+    .base_name             = TYPE_VHOST_USER_VSOCK_PCI,
+    .generic_name          = "vhost-user-vsock-pci",
+    .transitional_name     = "vhost-user-vsock-pci-transitional",
+    .non_transitional_name = "vhost-user-vsock-pci-non-transitional",
+    .instance_size = sizeof(VHostUserVSockPCI),
+    .instance_init = vhost_user_vsock_pci_instance_init,
+    .class_init    = vhost_user_vsock_pci_class_init,
+};
+
+static void virtio_pci_vhost_register(void)
+{
+    virtio_pci_types_register(&vhost_user_vsock_pci_info);
+}
+
+type_init(virtio_pci_vhost_register)
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index dd42daedb1..13e75f171f 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -22,6 +22,7 @@ obj-$(CONFIG_VHOST_USER_VSOCK) += vhost-vsock-common.o vhost-user-vsock.o
 
 ifeq ($(CONFIG_VIRTIO_PCI),y)
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-pci.o
+obj-$(CONFIG_VHOST_USER_VSOCK) += vhost-user-vsock-pci.o
 obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk-pci.o
 obj-$(CONFIG_VHOST_USER_INPUT) += vhost-user-input-pci.o
 obj-$(CONFIG_VHOST_USER_SCSI) += vhost-user-scsi-pci.o
-- 
2.25.4


