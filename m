Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BE4C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:11:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3D902084E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ujyg/d8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D902084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6sjD-0005AT-1f
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:11:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6seY-0004M5-Dj
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:06:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6seU-00082N-Q6
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:06:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24372
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6seU-0007zp-IU
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:06:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582708006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fxhD85QURMHEqGfAVjO06OKCuGPcyx+wfBWG1kQlMdk=;
 b=Ujyg/d8ysDx4TImx1O/ZATWy9TJYixldgOai6lj4uw9J2shIREV5oo0+raZLSmDiZt49J2
 OBaNfiyWBIW0gguM9CE1G+pJ5TcwuzC89QfQN6+YYi0spsPrQyB1TA3PmTnB9/4zGFGNG1
 m6D2T9Y5laIcDhVMDePbgi4KUJ8ey9w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-EyTUQFF7O8iZWFC9F8sCXA-1; Wed, 26 Feb 2020 04:06:40 -0500
X-MC-Unique: EyTUQFF7O8iZWFC9F8sCXA-1
Received: by mail-wr1-f69.google.com with SMTP id u18so1177777wrn.11
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 01:06:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Zhqx9qPWTMmN4vZaT6M30mfe2b5p6M/C9yj5xkhbUpA=;
 b=P600VclB4hIN7J5xgpWUGOkMi+AaukXjRt3dwHJBSw5T/L6cwePHvPGDs1BGFip6/H
 s6nsDlK7r0rjmlPwvrkQIWykIvLeanrS633YLX3SbfNlHI0rQOTwIJ5JxveeNk9j8+mx
 J/dpAucHch+86YBYrHK75oJB1DYIeoMV1tMeD01VLIieT27Hy5B/Gu61v4MJ/9dQcENr
 aO02GNmbxWXSLZR4xvOJ1HT+5uMqO+Sv6j/sSi49ihh/Bo1B20LFrvzubqjDTq3ESnbI
 ZV2jodTt5NeFTcO+DAJyskH0o60b1rQAFuLOUhswkUvUQUbAjMRYnf6doe7A5NPecKxf
 w1Eg==
X-Gm-Message-State: APjAAAXAWNW6/LjR4jKfodI9L0gcHRWPCBrEe89VqBZn9p73ENaV0z5w
 9bRAQ3G2hnFSjszJZj019PW8WTDc/E7XQU8ni5D+InkODq8PYL8GVuZG96Tr7+tl8dabmbOzdNJ
 5wv9d39Mjvd5VoiI=
X-Received: by 2002:a1c:4d03:: with SMTP id o3mr4108901wmh.164.1582707997734; 
 Wed, 26 Feb 2020 01:06:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqxXcGHQa1QtzgLI0R2UTRWUv5zbStxxo+HxVpIa3Mq2QPcQeV/tAodLaYnXu5Fn/gfDIvlC0Q==
X-Received: by 2002:a1c:4d03:: with SMTP id o3mr4108864wmh.164.1582707997349; 
 Wed, 26 Feb 2020 01:06:37 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 t131sm2153894wmb.13.2020.02.26.01.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 01:06:36 -0800 (PST)
Date: Wed, 26 Feb 2020 04:06:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 12/30] virtio-iommu: Add skeleton
Message-ID: <20200226090010.708934-13-mst@redhat.com>
References: <20200226090010.708934-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226090010.708934-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

This patchs adds the skeleton for the virtio-iommu device.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Message-Id: <20200214132745.23392-2-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-iommu.h |  57 +++++++
 hw/virtio/virtio-iommu.c         | 265 +++++++++++++++++++++++++++++++
 hw/virtio/Kconfig                |   5 +
 hw/virtio/Makefile.objs          |   1 +
 hw/virtio/trace-events           |   7 +
 5 files changed, 335 insertions(+)
 create mode 100644 include/hw/virtio/virtio-iommu.h
 create mode 100644 hw/virtio/virtio-iommu.c

diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-io=
mmu.h
new file mode 100644
index 0000000000..d24ba63305
--- /dev/null
+++ b/include/hw/virtio/virtio-iommu.h
@@ -0,0 +1,57 @@
+/*
+ * virtio-iommu device
+ *
+ * Copyright (c) 2020 Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along=
 with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef QEMU_VIRTIO_IOMMU_H
+#define QEMU_VIRTIO_IOMMU_H
+
+#include "standard-headers/linux/virtio_iommu.h"
+#include "hw/virtio/virtio.h"
+#include "hw/pci/pci.h"
+
+#define TYPE_VIRTIO_IOMMU "virtio-iommu-device"
+#define VIRTIO_IOMMU(obj) \
+        OBJECT_CHECK(VirtIOIOMMU, (obj), TYPE_VIRTIO_IOMMU)
+
+typedef struct IOMMUDevice {
+    void         *viommu;
+    PCIBus       *bus;
+    int           devfn;
+    IOMMUMemoryRegion  iommu_mr;
+    AddressSpace  as;
+} IOMMUDevice;
+
+typedef struct IOMMUPciBus {
+    PCIBus       *bus;
+    IOMMUDevice  *pbdev[0]; /* Parent array is sparse, so dynamically allo=
c */
+} IOMMUPciBus;
+
+typedef struct VirtIOIOMMU {
+    VirtIODevice parent_obj;
+    VirtQueue *req_vq;
+    VirtQueue *event_vq;
+    struct virtio_iommu_config config;
+    uint64_t features;
+    GHashTable *as_by_busptr;
+    PCIBus *primary_bus;
+    GTree *domains;
+    QemuMutex mutex;
+    GTree *endpoints;
+} VirtIOIOMMU;
+
+#endif
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
new file mode 100644
index 0000000000..30579267d5
--- /dev/null
+++ b/hw/virtio/virtio-iommu.c
@@ -0,0 +1,265 @@
+/*
+ * virtio-iommu device
+ *
+ * Copyright (c) 2020 Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along=
 with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/iov.h"
+#include "qemu-common.h"
+#include "hw/qdev-properties.h"
+#include "hw/virtio/virtio.h"
+#include "sysemu/kvm.h"
+#include "trace.h"
+
+#include "standard-headers/linux/virtio_ids.h"
+
+#include "hw/virtio/virtio-bus.h"
+#include "hw/virtio/virtio-access.h"
+#include "hw/virtio/virtio-iommu.h"
+
+/* Max size */
+#define VIOMMU_DEFAULT_QUEUE_SIZE 256
+
+static int virtio_iommu_handle_attach(VirtIOIOMMU *s,
+                                      struct iovec *iov,
+                                      unsigned int iov_cnt)
+{
+    return VIRTIO_IOMMU_S_UNSUPP;
+}
+static int virtio_iommu_handle_detach(VirtIOIOMMU *s,
+                                      struct iovec *iov,
+                                      unsigned int iov_cnt)
+{
+    return VIRTIO_IOMMU_S_UNSUPP;
+}
+static int virtio_iommu_handle_map(VirtIOIOMMU *s,
+                                   struct iovec *iov,
+                                   unsigned int iov_cnt)
+{
+    return VIRTIO_IOMMU_S_UNSUPP;
+}
+static int virtio_iommu_handle_unmap(VirtIOIOMMU *s,
+                                     struct iovec *iov,
+                                     unsigned int iov_cnt)
+{
+    return VIRTIO_IOMMU_S_UNSUPP;
+}
+
+static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIOIOMMU *s =3D VIRTIO_IOMMU(vdev);
+    struct virtio_iommu_req_head head;
+    struct virtio_iommu_req_tail tail =3D {};
+    VirtQueueElement *elem;
+    unsigned int iov_cnt;
+    struct iovec *iov;
+    size_t sz;
+
+    for (;;) {
+        elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
+        if (!elem) {
+            return;
+        }
+
+        if (iov_size(elem->in_sg, elem->in_num) < sizeof(tail) ||
+            iov_size(elem->out_sg, elem->out_num) < sizeof(head)) {
+            virtio_error(vdev, "virtio-iommu bad head/tail size");
+            virtqueue_detach_element(vq, elem, 0);
+            g_free(elem);
+            break;
+        }
+
+        iov_cnt =3D elem->out_num;
+        iov =3D elem->out_sg;
+        sz =3D iov_to_buf(iov, iov_cnt, 0, &head, sizeof(head));
+        if (unlikely(sz !=3D sizeof(head))) {
+            tail.status =3D VIRTIO_IOMMU_S_DEVERR;
+            goto out;
+        }
+        qemu_mutex_lock(&s->mutex);
+        switch (head.type) {
+        case VIRTIO_IOMMU_T_ATTACH:
+            tail.status =3D virtio_iommu_handle_attach(s, iov, iov_cnt);
+            break;
+        case VIRTIO_IOMMU_T_DETACH:
+            tail.status =3D virtio_iommu_handle_detach(s, iov, iov_cnt);
+            break;
+        case VIRTIO_IOMMU_T_MAP:
+            tail.status =3D virtio_iommu_handle_map(s, iov, iov_cnt);
+            break;
+        case VIRTIO_IOMMU_T_UNMAP:
+            tail.status =3D virtio_iommu_handle_unmap(s, iov, iov_cnt);
+            break;
+        default:
+            tail.status =3D VIRTIO_IOMMU_S_UNSUPP;
+        }
+        qemu_mutex_unlock(&s->mutex);
+
+out:
+        sz =3D iov_from_buf(elem->in_sg, elem->in_num, 0,
+                          &tail, sizeof(tail));
+        assert(sz =3D=3D sizeof(tail));
+
+        virtqueue_push(vq, elem, sizeof(tail));
+        virtio_notify(vdev, vq);
+        g_free(elem);
+    }
+}
+
+static void virtio_iommu_get_config(VirtIODevice *vdev, uint8_t *config_da=
ta)
+{
+    VirtIOIOMMU *dev =3D VIRTIO_IOMMU(vdev);
+    struct virtio_iommu_config *config =3D &dev->config;
+
+    trace_virtio_iommu_get_config(config->page_size_mask,
+                                  config->input_range.start,
+                                  config->input_range.end,
+                                  config->domain_range.end,
+                                  config->probe_size);
+    memcpy(config_data, &dev->config, sizeof(struct virtio_iommu_config));
+}
+
+static void virtio_iommu_set_config(VirtIODevice *vdev,
+                                      const uint8_t *config_data)
+{
+    struct virtio_iommu_config config;
+
+    memcpy(&config, config_data, sizeof(struct virtio_iommu_config));
+    trace_virtio_iommu_set_config(config.page_size_mask,
+                                  config.input_range.start,
+                                  config.input_range.end,
+                                  config.domain_range.end,
+                                  config.probe_size);
+}
+
+static uint64_t virtio_iommu_get_features(VirtIODevice *vdev, uint64_t f,
+                                          Error **errp)
+{
+    VirtIOIOMMU *dev =3D VIRTIO_IOMMU(vdev);
+
+    f |=3D dev->features;
+    trace_virtio_iommu_get_features(f);
+    return f;
+}
+
+/*
+ * Migration is not yet supported: most of the state consists
+ * of balanced binary trees which are not yet ready for getting
+ * migrated
+ */
+static const VMStateDescription vmstate_virtio_iommu_device =3D {
+    .name =3D "virtio-iommu-device",
+    .unmigratable =3D 1,
+};
+
+static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
+    VirtIOIOMMU *s =3D VIRTIO_IOMMU(dev);
+
+    virtio_init(vdev, "virtio-iommu", VIRTIO_ID_IOMMU,
+                sizeof(struct virtio_iommu_config));
+
+    s->req_vq =3D virtio_add_queue(vdev, VIOMMU_DEFAULT_QUEUE_SIZE,
+                             virtio_iommu_handle_command);
+    s->event_vq =3D virtio_add_queue(vdev, VIOMMU_DEFAULT_QUEUE_SIZE, NULL=
);
+
+    s->config.page_size_mask =3D TARGET_PAGE_MASK;
+    s->config.input_range.end =3D -1UL;
+    s->config.domain_range.end =3D 32;
+
+    virtio_add_feature(&s->features, VIRTIO_RING_F_EVENT_IDX);
+    virtio_add_feature(&s->features, VIRTIO_RING_F_INDIRECT_DESC);
+    virtio_add_feature(&s->features, VIRTIO_F_VERSION_1);
+    virtio_add_feature(&s->features, VIRTIO_IOMMU_F_INPUT_RANGE);
+    virtio_add_feature(&s->features, VIRTIO_IOMMU_F_DOMAIN_RANGE);
+    virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MAP_UNMAP);
+    virtio_add_feature(&s->features, VIRTIO_IOMMU_F_BYPASS);
+    virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MMIO);
+
+    qemu_mutex_init(&s->mutex);
+}
+
+static void virtio_iommu_device_unrealize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
+
+    virtio_cleanup(vdev);
+}
+
+static void virtio_iommu_device_reset(VirtIODevice *vdev)
+{
+    trace_virtio_iommu_device_reset();
+}
+
+static void virtio_iommu_set_status(VirtIODevice *vdev, uint8_t status)
+{
+    trace_virtio_iommu_device_status(status);
+}
+
+static void virtio_iommu_instance_init(Object *obj)
+{
+}
+
+static const VMStateDescription vmstate_virtio_iommu =3D {
+    .name =3D "virtio-iommu",
+    .minimum_version_id =3D 1,
+    .version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_VIRTIO_DEVICE,
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static Property virtio_iommu_properties[] =3D {
+    DEFINE_PROP_LINK("primary-bus", VirtIOIOMMU, primary_bus, "PCI", PCIBu=
s *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_iommu_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, virtio_iommu_properties);
+    dc->vmsd =3D &vmstate_virtio_iommu;
+
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    vdc->realize =3D virtio_iommu_device_realize;
+    vdc->unrealize =3D virtio_iommu_device_unrealize;
+    vdc->reset =3D virtio_iommu_device_reset;
+    vdc->get_config =3D virtio_iommu_get_config;
+    vdc->set_config =3D virtio_iommu_set_config;
+    vdc->get_features =3D virtio_iommu_get_features;
+    vdc->set_status =3D virtio_iommu_set_status;
+    vdc->vmsd =3D &vmstate_virtio_iommu_device;
+}
+
+static const TypeInfo virtio_iommu_info =3D {
+    .name =3D TYPE_VIRTIO_IOMMU,
+    .parent =3D TYPE_VIRTIO_DEVICE,
+    .instance_size =3D sizeof(VirtIOIOMMU),
+    .instance_init =3D virtio_iommu_instance_init,
+    .class_init =3D virtio_iommu_class_init,
+};
+
+static void virtio_register_types(void)
+{
+    type_register_static(&virtio_iommu_info);
+}
+
+type_init(virtio_register_types)
diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index f87def27a6..d29525b36f 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -9,6 +9,11 @@ config VIRTIO_RNG
     default y
     depends on VIRTIO
=20
+config VIRTIO_IOMMU
+    bool
+    default y
+    depends on VIRTIO
+
 config VIRTIO_PCI
     bool
     default y if PCI_DEVICES
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index de0f5fc39b..2fd9da7410 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -16,6 +16,7 @@ obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_P=
CI)) +=3D virtio-crypto-p
 obj-$(CONFIG_VIRTIO_PMEM) +=3D virtio-pmem.o
 common-obj-$(call land,$(CONFIG_VIRTIO_PMEM),$(CONFIG_VIRTIO_PCI)) +=3D vi=
rtio-pmem-pci.o
 obj-$(call land,$(CONFIG_VHOST_USER_FS),$(CONFIG_VIRTIO_PCI)) +=3D vhost-u=
ser-fs-pci.o
+obj-$(CONFIG_VIRTIO_IOMMU) +=3D virtio-iommu.o
 obj-$(CONFIG_VHOST_VSOCK) +=3D vhost-vsock.o
=20
 ifeq ($(CONFIG_VIRTIO_PCI),y)
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index e28ba48da6..02d93d7f63 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -53,3 +53,10 @@ virtio_mmio_write_offset(uint64_t offset, uint64_t value=
) "virtio_mmio_write off
 virtio_mmio_guest_page(uint64_t size, int shift) "guest page size 0x%" PRI=
x64 " shift %d"
 virtio_mmio_queue_write(uint64_t value, int max_size) "mmio_queue write 0x=
%" PRIx64 " max %d"
 virtio_mmio_setting_irq(int level) "virtio_mmio setting IRQ %d"
+
+# hw/virtio/virtio-iommu.c
+virtio_iommu_device_reset(void) "reset!"
+virtio_iommu_get_features(uint64_t features) "device supports features=3D0=
x%"PRIx64
+virtio_iommu_device_status(uint8_t status) "driver status =3D %d"
+virtio_iommu_get_config(uint64_t page_size_mask, uint64_t start, uint64_t =
end, uint32_t domain_range, uint32_t probe_size) "page_size_mask=3D0x%"PRIx=
64" start=3D0x%"PRIx64" end=3D0x%"PRIx64" domain_range=3D%d probe_size=3D0x=
%x"
+virtio_iommu_set_config(uint64_t page_size_mask, uint64_t start, uint64_t =
end, uint32_t domain_range, uint32_t probe_size) "page_size_mask=3D0x%"PRIx=
64" start=3D0x%"PRIx64" end=3D0x%"PRIx64" domain_bits=3D%d probe_size=3D0x%=
x"
--=20
MST


