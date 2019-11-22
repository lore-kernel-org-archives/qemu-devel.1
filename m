Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C002C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:48:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB05B20721
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tgw4hJro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB05B20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYDyg-0001ak-CO
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 13:48:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iYDjM-0001us-6S
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:32:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iYDjJ-0000oF-La
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:32:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34867
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iYDjH-0000o1-LB
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574447547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FH18n8gL+YCFEKuqvhyl1UKyiT9gf7yTQQ3G6LrFWao=;
 b=Tgw4hJroTk/2sLcXadlsTvmXeJFrhFCEynh3nien5ahBr+lKX3kW8yvOvt53U7LiN11/2O
 qFS3gle891V91cuI/xWDsxgvfKPP1OPKO09m/pOA2pZg7liIcWzxwySkXIHkfHLTaIYXi8
 9sLgCsgmoLWxa0emHxAvZThbkerq+fE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-zGnxj3RaNsWfCxjK8mi69A-1; Fri, 22 Nov 2019 13:32:26 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 055B31005502;
 Fri, 22 Nov 2019 18:32:24 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE40D6E712;
 Fri, 22 Nov 2019 18:32:14 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 armbru@redhat.com, jean-philippe.brucker@arm.com, bharatb.linux@gmail.com,
 yang.zhong@intel.com, dgilbert@redhat.com, quintela@redhat.com
Subject: [PATCH for-5.0 v11 20/20] tests: Add virtio-iommu test
Date: Fri, 22 Nov 2019 19:29:43 +0100
Message-Id: <20191122182943.4656-21-eric.auger@redhat.com>
In-Reply-To: <20191122182943.4656-1-eric.auger@redhat.com>
References: <20191122182943.4656-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: zGnxj3RaNsWfCxjK8mi69A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kevin.tian@intel.com, peterx@redhat.com, tnowicki@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds the framework to test the virtio-iommu-pci device
and tests exercising the attach/detach, map/unmap API.

To run the tests:
make tests/qos-test
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 tests/qos-test V=3D1

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 tests/Makefile.include      |   2 +
 tests/libqos/virtio-iommu.c | 177 ++++++++++++++++++++++++
 tests/libqos/virtio-iommu.h |  45 +++++++
 tests/virtio-iommu-test.c   | 261 ++++++++++++++++++++++++++++++++++++
 4 files changed, 485 insertions(+)
 create mode 100644 tests/libqos/virtio-iommu.c
 create mode 100644 tests/libqos/virtio-iommu.h
 create mode 100644 tests/virtio-iommu-test.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 8566f5f119..76a303c4fb 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -734,6 +734,7 @@ qos-test-obj-y +=3D tests/libqos/virtio-net.o
 qos-test-obj-y +=3D tests/libqos/virtio-pci.o
 qos-test-obj-y +=3D tests/libqos/virtio-pci-modern.o
 qos-test-obj-y +=3D tests/libqos/virtio-rng.o
+qos-test-obj-y +=3D tests/libqos/virtio-iommu.o
 qos-test-obj-y +=3D tests/libqos/virtio-scsi.o
 qos-test-obj-y +=3D tests/libqos/virtio-serial.o
=20
@@ -773,6 +774,7 @@ qos-test-obj-$(CONFIG_VIRTFS) +=3D tests/virtio-9p-test=
.o
 qos-test-obj-y +=3D tests/virtio-blk-test.o
 qos-test-obj-y +=3D tests/virtio-net-test.o
 qos-test-obj-y +=3D tests/virtio-rng-test.o
+qos-test-obj-y +=3D tests/virtio-iommu-test.o
 qos-test-obj-y +=3D tests/virtio-scsi-test.o
 qos-test-obj-y +=3D tests/virtio-serial-test.o
 qos-test-obj-y +=3D tests/vmxnet3-test.o
diff --git a/tests/libqos/virtio-iommu.c b/tests/libqos/virtio-iommu.c
new file mode 100644
index 0000000000..b4e9ea44fb
--- /dev/null
+++ b/tests/libqos/virtio-iommu.c
@@ -0,0 +1,177 @@
+/*
+ * libqos driver framework
+ *
+ * Copyright (c) 2018 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail=
.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License version 2 as published by the Free Software Foundation.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licens=
es/>
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/module.h"
+#include "libqos/qgraph.h"
+#include "libqos/virtio-iommu.h"
+#include "hw/virtio/virtio-iommu.h"
+
+static QGuestAllocator *alloc;
+
+/* virtio-iommu-device */
+static void *qvirtio_iommu_get_driver(QVirtioIOMMU *v_iommu,
+                                      const char *interface)
+{
+    if (!g_strcmp0(interface, "virtio-iommu")) {
+        return v_iommu;
+    }
+    if (!g_strcmp0(interface, "virtio")) {
+        return v_iommu->vdev;
+    }
+
+    fprintf(stderr, "%s not present in virtio-iommu-device\n", interface);
+    g_assert_not_reached();
+}
+
+static void *qvirtio_iommu_device_get_driver(void *object,
+                                             const char *interface)
+{
+    QVirtioIOMMUDevice *v_iommu =3D object;
+    return qvirtio_iommu_get_driver(&v_iommu->iommu, interface);
+}
+
+static void virtio_iommu_cleanup(QVirtioIOMMU *interface)
+{
+    qvirtqueue_cleanup(interface->vdev->bus, interface->vq, alloc);
+}
+
+static void virtio_iommu_setup(QVirtioIOMMU *interface)
+{
+    QVirtioDevice *vdev =3D interface->vdev;
+    uint64_t features;
+
+    features =3D qvirtio_get_features(vdev);
+    features &=3D ~(QVIRTIO_F_BAD_FEATURE |
+                  (1ull << VIRTIO_RING_F_INDIRECT_DESC) |
+                  (1ull << VIRTIO_RING_F_EVENT_IDX) |
+                  (1ull << VIRTIO_IOMMU_F_BYPASS));
+    qvirtio_set_features(vdev, features);
+    interface->vq =3D qvirtqueue_setup(interface->vdev, alloc, 0);
+    qvirtio_set_driver_ok(interface->vdev);
+}
+
+static void qvirtio_iommu_device_destructor(QOSGraphObject *obj)
+{
+    QVirtioIOMMUDevice *v_iommu =3D (QVirtioIOMMUDevice *) obj;
+    QVirtioIOMMU *iommu =3D &v_iommu->iommu;
+
+    virtio_iommu_cleanup(iommu);
+}
+
+static void qvirtio_iommu_device_start_hw(QOSGraphObject *obj)
+{
+    QVirtioIOMMUDevice *v_iommu =3D (QVirtioIOMMUDevice *) obj;
+    QVirtioIOMMU *iommu =3D &v_iommu->iommu;
+
+    virtio_iommu_setup(iommu);
+}
+
+static void *virtio_iommu_device_create(void *virtio_dev,
+                                        QGuestAllocator *t_alloc,
+                                        void *addr)
+{
+    QVirtioIOMMUDevice *virtio_rdevice =3D g_new0(QVirtioIOMMUDevice, 1);
+    QVirtioIOMMU *interface =3D &virtio_rdevice->iommu;
+
+    interface->vdev =3D virtio_dev;
+    alloc =3D t_alloc;
+
+    virtio_rdevice->obj.get_driver =3D qvirtio_iommu_device_get_driver;
+    virtio_rdevice->obj.destructor =3D qvirtio_iommu_device_destructor;
+    virtio_rdevice->obj.start_hw =3D qvirtio_iommu_device_start_hw;
+
+    return &virtio_rdevice->obj;
+}
+
+/* virtio-iommu-pci */
+static void *qvirtio_iommu_pci_get_driver(void *object, const char *interf=
ace)
+{
+    QVirtioIOMMUPCI *v_iommu =3D object;
+    if (!g_strcmp0(interface, "pci-device")) {
+        return v_iommu->pci_vdev.pdev;
+    }
+    return qvirtio_iommu_get_driver(&v_iommu->iommu, interface);
+}
+
+static void qvirtio_iommu_pci_destructor(QOSGraphObject *obj)
+{
+    QVirtioIOMMUPCI *iommu_pci =3D (QVirtioIOMMUPCI *) obj;
+    QVirtioIOMMU *interface =3D &iommu_pci->iommu;
+    QOSGraphObject *pci_vobj =3D  &iommu_pci->pci_vdev.obj;
+
+    virtio_iommu_cleanup(interface);
+    qvirtio_pci_destructor(pci_vobj);
+}
+
+static void qvirtio_iommu_pci_start_hw(QOSGraphObject *obj)
+{
+    QVirtioIOMMUPCI *iommu_pci =3D (QVirtioIOMMUPCI *) obj;
+    QVirtioIOMMU *interface =3D &iommu_pci->iommu;
+    QOSGraphObject *pci_vobj =3D  &iommu_pci->pci_vdev.obj;
+
+    qvirtio_pci_start_hw(pci_vobj);
+    virtio_iommu_setup(interface);
+}
+
+
+static void *virtio_iommu_pci_create(void *pci_bus, QGuestAllocator *t_all=
oc,
+                                   void *addr)
+{
+    QVirtioIOMMUPCI *virtio_rpci =3D g_new0(QVirtioIOMMUPCI, 1);
+    QVirtioIOMMU *interface =3D &virtio_rpci->iommu;
+    QOSGraphObject *obj =3D &virtio_rpci->pci_vdev.obj;
+
+    virtio_pci_init(&virtio_rpci->pci_vdev, pci_bus, addr);
+    interface->vdev =3D &virtio_rpci->pci_vdev.vdev;
+    alloc =3D t_alloc;
+
+    obj->get_driver =3D qvirtio_iommu_pci_get_driver;
+    obj->start_hw =3D qvirtio_iommu_pci_start_hw;
+    obj->destructor =3D qvirtio_iommu_pci_destructor;
+
+    return obj;
+}
+
+static void virtio_iommu_register_nodes(void)
+{
+    QPCIAddress addr =3D {
+        .devfn =3D QPCI_DEVFN(4, 0),
+    };
+
+    QOSGraphEdgeOptions opts =3D {
+        .extra_device_opts =3D "addr=3D04.0",
+    };
+
+    /* virtio-iommu-device */
+    qos_node_create_driver("virtio-iommu-device", virtio_iommu_device_crea=
te);
+    qos_node_consumes("virtio-iommu-device", "virtio-bus", NULL);
+    qos_node_produces("virtio-iommu-device", "virtio");
+    qos_node_produces("virtio-iommu-device", "virtio-iommu");
+
+    /* virtio-iommu-pci */
+    add_qpci_address(&opts, &addr);
+    qos_node_create_driver("virtio-iommu-pci", virtio_iommu_pci_create);
+    qos_node_consumes("virtio-iommu-pci", "pci-bus", &opts);
+    qos_node_produces("virtio-iommu-pci", "pci-device");
+    qos_node_produces("virtio-iommu-pci", "virtio");
+    qos_node_produces("virtio-iommu-pci", "virtio-iommu");
+}
+
+libqos_init(virtio_iommu_register_nodes);
diff --git a/tests/libqos/virtio-iommu.h b/tests/libqos/virtio-iommu.h
new file mode 100644
index 0000000000..6970b45a01
--- /dev/null
+++ b/tests/libqos/virtio-iommu.h
@@ -0,0 +1,45 @@
+/*
+ * libqos driver framework
+ *
+ * Copyright (c) 2018 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail=
.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License version 2 as published by the Free Software Foundation.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licens=
es/>
+ */
+
+#ifndef TESTS_LIBQOS_VIRTIO_IOMMU_H
+#define TESTS_LIBQOS_VIRTIO_IOMMU_H
+
+#include "libqos/qgraph.h"
+#include "libqos/virtio.h"
+#include "libqos/virtio-pci.h"
+
+typedef struct QVirtioIOMMU QVirtioIOMMU;
+typedef struct QVirtioIOMMUPCI QVirtioIOMMUPCI;
+typedef struct QVirtioIOMMUDevice QVirtioIOMMUDevice;
+
+struct QVirtioIOMMU {
+    QVirtioDevice *vdev;
+    QVirtQueue *vq;
+};
+
+struct QVirtioIOMMUPCI {
+    QVirtioPCIDevice pci_vdev;
+    QVirtioIOMMU iommu;
+};
+
+struct QVirtioIOMMUDevice {
+    QOSGraphObject obj;
+    QVirtioIOMMU iommu;
+};
+
+#endif
diff --git a/tests/virtio-iommu-test.c b/tests/virtio-iommu-test.c
new file mode 100644
index 0000000000..1d93d686bc
--- /dev/null
+++ b/tests/virtio-iommu-test.c
@@ -0,0 +1,261 @@
+/*
+ * QTest testcase for VirtIO IOMMU
+ *
+ * Copyright (c) 2014 SUSE LINUX Products GmbH
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+#include "qemu/module.h"
+#include "libqos/qgraph.h"
+#include "libqos/virtio-iommu.h"
+#include "hw/virtio/virtio-iommu.h"
+
+#define PCI_SLOT_HP             0x06
+#define QVIRTIO_IOMMU_TIMEOUT_US (30 * 1000 * 1000)
+
+static QGuestAllocator *alloc;
+
+static void iommu_hotplug(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QVirtioPCIDevice *dev =3D obj;
+    QTestState *qts =3D dev->pdev->bus->qts;
+
+    qtest_qmp_device_add(qts, "virtio-iommu-pci", "iommu1",
+                         "{'addr': %s}", stringify(PCI_SLOT_HP));
+
+}
+
+static void pci_config(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    QVirtioIOMMU *v_iommu =3D obj;
+    QVirtioDevice *dev =3D v_iommu->vdev;
+    uint64_t input_range_start =3D qvirtio_config_readq(dev, 8);
+    uint64_t input_range_end =3D qvirtio_config_readq(dev, 16);
+    uint32_t domain_range_start =3D qvirtio_config_readl(dev, 24);
+    uint32_t domain_range_end =3D qvirtio_config_readl(dev, 28);
+    uint32_t probe_size =3D qvirtio_config_readl(dev, 32);
+
+    g_assert_cmpint(input_range_start, =3D=3D, 0);
+    g_assert_cmphex(input_range_end, =3D=3D, 0xFFFFFFFFFFFFFFFF);
+    g_assert_cmpint(domain_range_start, =3D=3D, 0);
+    g_assert_cmpint(domain_range_end, =3D=3D, 32);
+    g_assert_cmphex(probe_size, =3D=3D, 0x200);
+}
+
+/**
+ * send_attach_detach - Send an attach/detach command to the device
+ * @type: VIRTIO_IOMMU_T_ATTACH/VIRTIO_IOMMU_T_DETACH
+ * @domain: domain the end point is attached to
+ * @ep: end-point
+ */
+static int send_attach_detach(QTestState *qts, QVirtioIOMMU *v_iommu,
+                              uint8_t type, uint32_t domain, uint32_t ep)
+{
+    QVirtioDevice *dev =3D v_iommu->vdev;
+    QVirtQueue *vq =3D v_iommu->vq;
+    uint64_t ro_addr, wr_addr;
+    uint32_t free_head;
+    struct virtio_iommu_req_attach req; /* same layout as detach */
+    size_t ro_size =3D sizeof(req) - sizeof(struct virtio_iommu_req_tail);
+    size_t wr_size =3D sizeof(struct virtio_iommu_req_tail);
+    char buffer[64];
+    int ret;
+
+    req.head.type =3D type;
+    req.domain =3D domain;
+    req.endpoint =3D ep;
+
+    ro_addr =3D guest_alloc(alloc, ro_size);
+    wr_addr =3D guest_alloc(alloc, wr_size);
+
+    qtest_memwrite(qts, ro_addr, &req, ro_size);
+    free_head =3D qvirtqueue_add(qts, vq, ro_addr, ro_size, false, true);
+    qvirtqueue_add(qts, vq, wr_addr, wr_size, true, false);
+    qvirtqueue_kick(qts, dev, vq, free_head);
+    qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
+                           QVIRTIO_IOMMU_TIMEOUT_US);
+    qtest_memread(qts, wr_addr, buffer, wr_size);
+    ret =3D ((struct virtio_iommu_req_tail *)buffer)->status;
+    guest_free(alloc, ro_addr);
+    guest_free(alloc, wr_addr);
+    return ret;
+}
+
+/**
+ * send_map - Send a map command to the device
+ * @domain: domain the new binding is attached to
+ * @virt_start: iova start
+ * @virt_end: iova end
+ * @phys_start: base physical address
+ * @flags: mapping flags
+ */
+static int send_map(QTestState *qts, QVirtioIOMMU *v_iommu,
+                    uint32_t domain, uint64_t virt_start, uint64_t virt_en=
d,
+                    uint64_t phys_start, uint32_t flags)
+{
+    QVirtioDevice *dev =3D v_iommu->vdev;
+    QVirtQueue *vq =3D v_iommu->vq;
+    uint64_t ro_addr, wr_addr;
+    uint32_t free_head;
+    struct virtio_iommu_req_map req;
+    size_t ro_size =3D sizeof(req) - sizeof(struct virtio_iommu_req_tail);
+    size_t wr_size =3D sizeof(struct virtio_iommu_req_tail);
+    char buffer[64];
+    int ret;
+
+    req.head.type =3D VIRTIO_IOMMU_T_MAP;
+    req.domain =3D domain;
+    req.virt_start =3D virt_start;
+    req.virt_end =3D virt_end;
+    req.phys_start =3D phys_start;
+    req.flags =3D flags;
+
+    ro_addr =3D guest_alloc(alloc, ro_size);
+    wr_addr =3D guest_alloc(alloc, wr_size);
+
+    qtest_memwrite(qts, ro_addr, &req, ro_size);
+    free_head =3D qvirtqueue_add(qts, vq, ro_addr, ro_size, false, true);
+    qvirtqueue_add(qts, vq, wr_addr, wr_size, true, false);
+    qvirtqueue_kick(qts, dev, vq, free_head);
+    qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
+                           QVIRTIO_IOMMU_TIMEOUT_US);
+    memread(wr_addr, buffer, wr_size);
+    ret =3D ((struct virtio_iommu_req_tail *)buffer)->status;
+    guest_free(alloc, ro_addr);
+    guest_free(alloc, wr_addr);
+    return ret;
+}
+
+/**
+ * send_unmap - Send an unmap command to the device
+ * @domain: domain the new binding is attached to
+ * @virt_start: iova start
+ * @virt_end: iova end
+ */
+static int send_unmap(QTestState *qts, QVirtioIOMMU *v_iommu,
+                      uint32_t domain, uint64_t virt_start, uint64_t virt_=
end)
+{
+    QVirtioDevice *dev =3D v_iommu->vdev;
+    QVirtQueue *vq =3D v_iommu->vq;
+    uint64_t ro_addr, wr_addr;
+    uint32_t free_head;
+    struct virtio_iommu_req_unmap req;
+    size_t ro_size =3D sizeof(req) - sizeof(struct virtio_iommu_req_tail);
+    size_t wr_size =3D sizeof(struct virtio_iommu_req_tail);
+    char buffer[64];
+    int ret;
+
+    req.head.type =3D VIRTIO_IOMMU_T_UNMAP;
+    req.domain =3D domain;
+    req.virt_start =3D virt_start;
+    req.virt_end =3D virt_end;
+
+    ro_addr =3D guest_alloc(alloc, ro_size);
+    wr_addr =3D guest_alloc(alloc, wr_size);
+
+    qtest_memwrite(qts, ro_addr, &req, ro_size);
+    free_head =3D qvirtqueue_add(qts, vq, ro_addr, ro_size, false, true);
+    qvirtqueue_add(qts, vq, wr_addr, wr_size, true, false);
+    qvirtqueue_kick(qts, dev, vq, free_head);
+    qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
+                           QVIRTIO_IOMMU_TIMEOUT_US);
+    memread(wr_addr, buffer, wr_size);
+    ret =3D ((struct virtio_iommu_req_tail *)buffer)->status;
+    guest_free(alloc, ro_addr);
+    guest_free(alloc, wr_addr);
+    return ret;
+}
+
+/* Test unmap scenari documented in the spec v0.12 */
+static void test_attach_detach(void *obj, void *data, QGuestAllocator *t_a=
lloc)
+{
+    QVirtioIOMMU *v_iommu =3D obj;
+    QTestState *qts =3D global_qtest;
+    int ret;
+
+    alloc =3D t_alloc;
+
+    /* type, domain, ep */
+    ret =3D send_attach_detach(qts, v_iommu, VIRTIO_IOMMU_T_ATTACH, 0, 0);
+    g_assert_cmpint(ret, =3D=3D, 0);
+    ret =3D send_attach_detach(qts, v_iommu, VIRTIO_IOMMU_T_ATTACH, 1, 2);
+    g_assert_cmpint(ret, =3D=3D, 0);
+    ret =3D send_attach_detach(qts, v_iommu, VIRTIO_IOMMU_T_ATTACH, 1, 2);
+    g_assert_cmpint(ret, =3D=3D, 0);
+    ret =3D send_attach_detach(qts, v_iommu, VIRTIO_IOMMU_T_ATTACH, 0, 2);
+    g_assert_cmpint(ret, =3D=3D, 0);
+
+    /* domain, virt start, virt end, phys start, flags */
+    ret =3D send_map(qts, v_iommu, 0, 0, 0xFFF, 0xa1000, VIRTIO_IOMMU_MAP_=
F_READ);
+    g_assert_cmpint(ret, =3D=3D, 0);
+
+    ret =3D send_unmap(qts, v_iommu, 4, 0x10, 0xFFF);
+    g_assert_cmpint(ret, =3D=3D, VIRTIO_IOMMU_S_NOENT);
+
+    ret =3D send_unmap(qts, v_iommu, 0, 0x10, 0xFFF);
+    g_assert_cmpint(ret, =3D=3D, VIRTIO_IOMMU_S_RANGE);
+
+    /* Spec example sequence */
+
+    /* 1 */
+    ret =3D send_unmap(qts, v_iommu, 1, 0, 4);
+    g_assert_cmpint(ret, =3D=3D, 0); /* doesn't unmap anything */
+
+    /* 2 */
+    send_map(qts, v_iommu, 1, 0, 9, 0xa1000, VIRTIO_IOMMU_MAP_F_READ);
+    ret =3D send_unmap(qts, v_iommu, 1, 0, 9);
+    g_assert_cmpint(ret, =3D=3D, 0); /* unmaps [0,9] */
+
+    /* 3 */
+    send_map(qts, v_iommu, 1, 0, 4, 0xb1000, VIRTIO_IOMMU_MAP_F_READ);
+    send_map(qts, v_iommu, 1, 5, 9, 0xb2000, VIRTIO_IOMMU_MAP_F_READ);
+    ret =3D send_unmap(qts, v_iommu, 1, 0, 9);
+    g_assert_cmpint(ret, =3D=3D, 0); /* unmaps [0,4] and [5,9] */
+
+    /* 4 */
+    send_map(qts, v_iommu, 1, 0, 9, 0xc1000, VIRTIO_IOMMU_MAP_F_READ);
+    ret =3D send_unmap(qts, v_iommu, 1, 0, 4);
+    g_assert_cmpint(ret, =3D=3D, VIRTIO_IOMMU_S_RANGE); /* doesn't unmap a=
nything */
+
+    ret =3D send_unmap(qts, v_iommu, 1, 0, 10);
+    g_assert_cmpint(ret, =3D=3D, 0);
+
+    /* 5 */
+    send_map(qts, v_iommu, 1, 0, 4, 0xd1000, VIRTIO_IOMMU_MAP_F_READ);
+    send_map(qts, v_iommu, 1, 5, 9, 0xd2000, VIRTIO_IOMMU_MAP_F_READ);
+    ret =3D send_unmap(qts, v_iommu, 1, 0, 4);
+    g_assert_cmpint(ret, =3D=3D, 0); /* unmaps [0,4] */
+
+    ret =3D send_unmap(qts, v_iommu, 1, 5, 9);
+    g_assert_cmpint(ret, =3D=3D, 0);
+
+    /* 6 */
+    send_map(qts, v_iommu, 1, 0, 4, 0xe2000, VIRTIO_IOMMU_MAP_F_READ);
+    ret =3D send_unmap(qts, v_iommu, 1, 0, 9);
+    g_assert_cmpint(ret, =3D=3D, 0); /* unmaps [0,4] */
+
+    /* 7 */
+    send_map(qts, v_iommu, 1, 0, 4, 0xf2000, VIRTIO_IOMMU_MAP_F_READ);
+    send_map(qts, v_iommu, 1, 10, 14, 0xf3000, VIRTIO_IOMMU_MAP_F_READ);
+    ret =3D send_unmap(qts, v_iommu, 1, 0, 14);
+    g_assert_cmpint(ret, =3D=3D, 0); /* unmaps [0,4] and [10,14] */
+
+    send_unmap(qts, v_iommu, 1, 0, 100);
+    send_map(qts, v_iommu, 1, 10, 14, 0xf3000, VIRTIO_IOMMU_MAP_F_READ);
+    send_map(qts, v_iommu, 1, 0, 4, 0xf2000, VIRTIO_IOMMU_MAP_F_READ);
+    ret =3D send_unmap(qts, v_iommu, 1, 0, 4);
+    g_assert_cmpint(ret, =3D=3D, 0); /* unmaps [0,4] and [10,14] */
+}
+
+static void register_virtio_iommu_test(void)
+{
+    qos_add_test("hotplug", "virtio-iommu-pci", iommu_hotplug, NULL);
+    qos_add_test("config", "virtio-iommu", pci_config, NULL);
+    qos_add_test("attach_detach", "virtio-iommu", test_attach_detach, NULL=
);
+}
+
+libqos_init(register_virtio_iommu_test);
--=20
2.20.1


