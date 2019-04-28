Return-Path: <SRS0=GiFh=S6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE750C43219
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 13:28:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DD0C206A3
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 13:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD0C206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44264 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKjrM-0006su-NT
	for qemu-devel@archiver.kernel.org; Sun, 28 Apr 2019 09:28:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1hKjqX-0006bY-6q
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 09:27:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1hKjqV-0004vg-2o
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 09:27:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ybettan@redhat.com>) id 1hKjqU-0004u7-Qm
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 09:27:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 115A081DE6;
	Sun, 28 Apr 2019 13:27:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.39])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EE02D17989;
	Sun, 28 Apr 2019 13:27:47 +0000 (UTC)
From: Yoni Bettan <ybettan@redhat.com>
To: qemu-devel@nongnu.org
Date: Sun, 28 Apr 2019 16:26:31 +0300
Message-Id: <20190428132631.37430-1-ybettan@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Sun, 28 Apr 2019 13:27:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH V1] Introducing virtio-example.
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: stefanha@gmail.com, Yoni Bettan <ybettan@redhat.com>, ailan@redhat.com,
	ehabkost@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190428132631.jrYQPnCrRxcnkbmQJmUO11vlDU2zy7OKPpcaUq5VyBs@z>

The main goal is to create an example to be used as template or
guideline for contributors when they wish to create a new virtio
device and to document "the right way" to do so.

It consists of several parts:

    1. The device specification
        * it can be found in the device header
        * it will hopefully be added to the official virtio specification

    2. The device implementation for Qemu-KVM hypervisor
        * this patch content

    3. The device driver for linux
        * it will hopefully be added to linux
        * for now it can be found at https://github.com/ybettan/\
                QemuDeviceDrivers/blob/master/virtio/virtio_example_driver.c

    4. A blog on virtio
        * introducing the virtio concept
        * gives some motivation for virtio-devices to be used
        * bring extra documentation on "how to write":
            - device specification
            - device implementation
            - device driver for linux
        * it can be found at https://howtovms.wordpress.com

Signed-off-by: Yoni Bettan <ybettan@redhat.com>
---

RFC -> V1:
    
    * Updated the commit message to be more informative about the full
      working flow.

    * Added the device specification to the device header.

    * Removed the PCI-ID given for the device.
      This was done by forcing the device to be in modern-only mode therefore
      the PCI-ID is now generated automatically.
    
    * Made all requests consist of both input and output buffer instead
      of separating them into 2 different requests.

    * Made the device IO deal with integers instead of strings.
      The user have read/write access to the device using sysfs,
      therefore the driver's input are strings, in the RFC version
      those strings where passed directly to the device and the integer
      conversion was done inside the device, now the driver is handling those
      conversions and the device is unaware of them.

    * Added more documentation for the get_features() function.

    * Simplified the error propagation in virtio_example_pci_realize()
      function.

    * Removed all code of previous previous patch from standard-headers.


 hw/virtio/Makefile.objs            |   1 +
 hw/virtio/virtio-example.c         | 110 +++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.c             |  47 ++++++++++++
 hw/virtio/virtio-pci.h             |  14 ++++
 include/hw/virtio/virtio-example.h |  92 ++++++++++++++++++++++++
 5 files changed, 264 insertions(+)
 create mode 100644 hw/virtio/virtio-example.c
 create mode 100644 include/hw/virtio/virtio-example.h

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 1b2799cfd8..7a6fb2505c 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -7,6 +7,7 @@ common-obj-$(CONFIG_VIRTIO_PCI) += virtio-pci.o
 common-obj-$(CONFIG_VIRTIO_MMIO) += virtio-mmio.o
 obj-$(CONFIG_VIRTIO_BALLOON) += virtio-balloon.o
 obj-$(CONFIG_VIRTIO_CRYPTO) += virtio-crypto.o
+obj-$(CONFIG_VIRTIO_CRYPTO) += virtio-example.o
 obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-pci.o
 
 obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
diff --git a/hw/virtio/virtio-example.c b/hw/virtio/virtio-example.c
new file mode 100644
index 0000000000..fd72f7c3a5
--- /dev/null
+++ b/hw/virtio/virtio-example.c
@@ -0,0 +1,110 @@
+/*
+ * A virtio device example.
+ *
+ * Copyright 2019 Red Hat, Inc.
+ * Copyright 2019 Yoni Bettan <ybettan@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/iov.h"
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/virtio-example.h"
+
+
+/*
+ * this function is called when the driver 'kick' the virtqueue.
+ * since we can have more than 1 virtqueue we need the vq argument in order to
+ * know which one was kicked by the driver.
+ */
+static void handle_input(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtQueueElement *elem;
+    int data;
+
+    /*
+     * get the virtqueue element sent from the driver.
+     * in_sg are the driver inputs (device outputs)
+     * out_sg are the driver output (device input)
+     */
+    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
+
+    /* read the driver output sg (device input sg) into a buffer */
+    iov_to_buf(elem->out_sg, elem->out_num, 0, &data, sizeof(int));
+
+    /* process the data */
+    data++;
+
+    /* write the result to the driver input sg (device output sg) */
+    iov_from_buf(elem->in_sg, elem->in_num, 0, &data, sizeof(int));
+
+    /* push back the result into the virtqueue */
+    virtqueue_push(vq, elem, 1);
+
+    /* interrupt the driver */
+    virtio_notify(vdev, vq);
+
+    return;
+}
+
+/*
+ * This function gets the host features as a parameter and add to it all the
+ * features supported by the device.
+ * This example-device has no currently defined feature bits but we still need
+ * this function because when a device is plugged this function is called to
+ * check the features offer by the device so it must exist and return the
+ * host features without any change.
+ */
+static uint64_t
+get_features(VirtIODevice *vdev, uint64_t features, Error **errp)
+{
+    return features;
+}
+
+static void virtio_example_device_realize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtIOEXAMPLE *vexmp = VIRTIO_EXAMPLE(dev);
+
+    /* common virtio device initialization */
+    virtio_init(vdev, "virtio-example", VIRTIO_ID_EXAMPLE, 0);
+
+    /* this device suppot 1 virtqueue */
+    vexmp->vq = virtio_add_queue(vdev, 1, handle_input);
+}
+
+static void virtio_example_device_unrealize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+
+    /* common virtio device cleanup */
+    virtio_cleanup(vdev);
+}
+
+static void virtio_example_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    vdc->realize = virtio_example_device_realize;
+    vdc->unrealize = virtio_example_device_unrealize;
+    vdc->get_features = get_features;
+}
+
+static const TypeInfo virtio_example_info = {
+    .name = TYPE_VIRTIO_EXAMPLE,
+    .parent = TYPE_VIRTIO_DEVICE,
+    .instance_size = sizeof(VirtIOEXAMPLE),
+    .class_init = virtio_example_class_init,
+};
+
+static void virtio_register_types(void)
+{
+    type_register_static(&virtio_example_info);
+}
+
+type_init(virtio_register_types)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 3a01fe90f0..36333168ad 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2521,6 +2521,52 @@ static const TypeInfo virtio_rng_pci_info = {
     .class_init    = virtio_rng_pci_class_init,
 };
 
+/* virtio-example-pci */
+
+static void virtio_example_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VirtIOExamplePCI *vexmp = VIRTIO_EXAMPLE_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&vexmp->vdev);
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    /*
+     * force modern-only mode on the device, now a PCI-ID will be generated
+     * automatically according to the VIRTIO-ID.
+     */
+    virtio_pci_force_virtio_1(vpci_dev);
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void virtio_example_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+
+    k->realize = virtio_example_pci_realize;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
+    pcidev_k->class_id = PCI_CLASS_OTHERS;
+}
+
+static void virtio_example_initfn(Object *obj)
+{
+    VirtIOExamplePCI *dev = VIRTIO_EXAMPLE_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_EXAMPLE);
+}
+
+static const TypeInfo virtio_example_pci_info = {
+    .name          = TYPE_VIRTIO_EXAMPLE_PCI,
+    .parent        = TYPE_VIRTIO_PCI,
+    .instance_size = sizeof(VirtIOExamplePCI),
+    .instance_init = virtio_example_initfn,
+    .class_init    = virtio_example_pci_class_init,
+};
+
 /* virtio-input-pci */
 
 static Property virtio_input_pci_properties[] = {
@@ -2693,6 +2739,7 @@ static const TypeInfo virtio_pci_bus_info = {
 static void virtio_pci_register_types(void)
 {
     type_register_static(&virtio_rng_pci_info);
+    type_register_static(&virtio_example_pci_info);
     type_register_static(&virtio_input_pci_info);
     type_register_static(&virtio_input_hid_pci_info);
     type_register_static(&virtio_keyboard_pci_info);
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 813082b0d7..db3f5ec17d 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -19,6 +19,7 @@
 #include "hw/virtio/virtio-blk.h"
 #include "hw/virtio/virtio-net.h"
 #include "hw/virtio/virtio-rng.h"
+#include "hw/virtio/virtio-example.h"
 #include "hw/virtio/virtio-serial.h"
 #include "hw/virtio/virtio-scsi.h"
 #include "hw/virtio/virtio-balloon.h"
@@ -51,6 +52,7 @@ typedef struct VHostSCSIPCI VHostSCSIPCI;
 typedef struct VHostUserSCSIPCI VHostUserSCSIPCI;
 typedef struct VHostUserBlkPCI VHostUserBlkPCI;
 typedef struct VirtIORngPCI VirtIORngPCI;
+typedef struct VirtIOExamplePCI VirtIOExamplePCI;
 typedef struct VirtIOInputPCI VirtIOInputPCI;
 typedef struct VirtIOInputHIDPCI VirtIOInputHIDPCI;
 typedef struct VirtIOInputHostPCI VirtIOInputHostPCI;
@@ -339,6 +341,18 @@ struct VirtIORngPCI {
     VirtIORNG vdev;
 };
 
+/*
+ * virtio-example-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VIRTIO_EXAMPLE_PCI "virtio-example-pci"
+#define VIRTIO_EXAMPLE_PCI(obj) \
+        OBJECT_CHECK(VirtIOExamplePCI, (obj), TYPE_VIRTIO_EXAMPLE_PCI)
+
+struct VirtIOExamplePCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIOEXAMPLE vdev;
+};
+
 /*
  * virtio-input-pci: This extends VirtioPCIProxy.
  */
diff --git a/include/hw/virtio/virtio-example.h b/include/hw/virtio/virtio-example.h
new file mode 100644
index 0000000000..48397af4e1
--- /dev/null
+++ b/include/hw/virtio/virtio-example.h
@@ -0,0 +1,92 @@
+/*
+ * Virtio EXAMPLE Support
+ *
+ * Copyright Red Hat, Inc. 2019
+ * Copyright Yoni Bettan <ybettan@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+
+/*
+ * ============================================================================
+ *                             Device specification
+ * ============================================================================
+ *
+ * 5.2 Example Device
+ *
+ * The virtio example device is a simple virtual block device. Read and write
+ * requests are placed in the queue, and serviced (probably out of order) by
+ * the device except where noted.
+ *
+ * 5.2.1 Device ID
+ *
+ * 21
+ *
+ * 5.2.2 Virtqueues
+ *
+ * 0 requestq
+ *
+ * 5.2.3 Feature bits
+ *
+ * None currently defined.
+ *
+ * 5.2.4 Device configuration layout
+ *
+ * None currently defined.
+ *
+ * 5.2.5 Device Initialization
+ *
+ * 1. The virtqueue is initialized.
+ *
+ * 5.2.6 Device Operation
+ *
+ * When the driver need computation, it places a request that consist of both
+ * input and output buffer into the queue.
+ * The first buffer is used as an input for the device and contain a single
+ * integer, represented by 4 or 8 bytes (depends on the architecture), and the
+ * second is given for the device to fill the result in it.
+ *
+ * The device is increasing this integer by 1, meaning the LSB will be
+ * increased by 1 and if needed the carry will be carried to the next byte.
+ *
+ * If the device get a number that is out of the range of an integer only the
+ * lower bytes that fit the size of an integer will represent the input and the
+ * upper bytes will be ignored.
+ * If the result is out of range then only the lower bytes will be written as
+ * result as well.
+ *
+ * 5.2.6.1 Driver Requirements: Device Operation
+ *
+ * The driver MUST place the 2 buffers in the same request in order to make a
+ * request atomically handled by the device, the first buffer contains the
+ * input and should be read-only and the second should be empty and write-only.
+ *
+ * 5.2.6.2 Device Requirements: Device Operation
+ *
+ * The device MUST place the result inside the output buffer allocated by the
+ * driver.
+ */
+
+#ifndef QEMU_VIRTIO_EXAMPLE_H
+#define QEMU_VIRTIO_EXAMPLE_H
+
+#define VIRTIO_ID_EXAMPLE 21
+
+#define TYPE_VIRTIO_EXAMPLE "virtio-example-device"
+#define VIRTIO_EXAMPLE(obj) \
+        OBJECT_CHECK(VirtIOEXAMPLE, (obj), TYPE_VIRTIO_EXAMPLE)
+#define VIRTIO_EXAMPLE_GET_PARENT_CLASS(obj) \
+        OBJECT_GET_PARENT_CLASS(obj, TYPE_VIRTIO_EXAMPLE)
+
+typedef struct VirtIOEXAMPLE {
+    VirtIODevice parent_obj;
+
+    /* Only one vq - guest puts buffer(s) on it when it needs computation */
+    VirtQueue *vq;
+
+} VirtIOEXAMPLE;
+
+#endif
-- 
2.17.2


