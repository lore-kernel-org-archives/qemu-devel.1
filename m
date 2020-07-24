Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6ACC433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:41:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 884432065F
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZ9+pzgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884432065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyytB-0007Iz-La
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 10:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jyyrl-0005Wn-PT
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:40:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24803
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jyyri-0005mp-Bz
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595601601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4hu+Vsr13CWYOJ8jNwgQZ6Ll5tqppdT69qgnw+1BdTc=;
 b=cZ9+pzgrPiOCTqSi/yki/es+/bVshxNC+bkfO1pGGaOmeVr4RpZtcrHLfsgEME9aOyZcJA
 cQHNAKuEtWETCJZiRYvdghqv3JnKjb/rtf5gt1xe2hfLgg+rdhGe7AwVw2M4/l1y3MKCdq
 EOg3CMG5nGU44JOx7KZZjBtHfBAc5HU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-fconsG5YNeWXPNbSXM59yA-1; Fri, 24 Jul 2020 10:38:28 -0400
X-MC-Unique: fconsG5YNeWXPNbSXM59yA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD0CB800597;
 Fri, 24 Jul 2020 14:38:26 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-94.ams2.redhat.com [10.36.113.94])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C0FD6710AC;
 Fri, 24 Jul 2020 14:38:23 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFCv3 8/9] s390x: implement virtio-mem-ccw
Date: Fri, 24 Jul 2020 16:37:49 +0200
Message-Id: <20200724143750.59836-9-david@redhat.com>
In-Reply-To: <20200724143750.59836-1-david@redhat.com>
References: <20200724143750.59836-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 00:00:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a proper CCW proxy device, similar to the PCI variant.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/virtio-ccw-mem.c | 167 ++++++++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw.h     |  13 +++
 2 files changed, 180 insertions(+)
 create mode 100644 hw/s390x/virtio-ccw-mem.c

diff --git a/hw/s390x/virtio-ccw-mem.c b/hw/s390x/virtio-ccw-mem.c
new file mode 100644
index 0000000000..c38dafd7f0
--- /dev/null
+++ b/hw/s390x/virtio-ccw-mem.c
@@ -0,0 +1,167 @@
+/*
+ * Virtio MEM CCW device
+ *
+ * Copyright (C) 2020 Red Hat, Inc.
+ *
+ * Authors:
+ *  David Hildenbrand <david@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
+#include "hw/virtio/virtio.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "virtio-ccw.h"
+#include "hw/mem/memory-device.h"
+#include "qapi/qapi-events-misc.h"
+
+static void virtio_ccw_mem_realize(VirtioCcwDevice *ccw_dev, Error **errp)
+{
+    VirtIOMEMCcw *ccw_mem = VIRTIO_MEM_CCW(ccw_dev);
+    DeviceState *vdev = DEVICE(&ccw_mem->vdev);
+
+    qdev_realize(vdev, BUS(&ccw_dev->bus), errp);
+}
+
+static void virtio_ccw_mem_set_addr(MemoryDeviceState *md, uint64_t addr,
+                                    Error **errp)
+{
+    object_property_set_uint(OBJECT(md), VIRTIO_MEM_ADDR_PROP, addr, errp);
+}
+
+static uint64_t virtio_ccw_mem_get_addr(const MemoryDeviceState *md)
+{
+    return object_property_get_uint(OBJECT(md), VIRTIO_MEM_ADDR_PROP,
+                                    &error_abort);
+}
+
+static MemoryRegion *virtio_ccw_mem_get_memory_region(MemoryDeviceState *md,
+                                                      Error **errp)
+{
+    VirtIOMEMCcw *ccw_mem = VIRTIO_MEM_CCW(md);
+    VirtIOMEM *vmem = VIRTIO_MEM(&ccw_mem->vdev);
+    VirtIOMEMClass *vmc = VIRTIO_MEM_GET_CLASS(vmem);
+
+    return vmc->get_memory_region(vmem, errp);
+}
+
+static uint64_t virtio_ccw_mem_get_plugged_size(const MemoryDeviceState *md,
+                                                Error **errp)
+{
+    return object_property_get_uint(OBJECT(md), VIRTIO_MEM_SIZE_PROP,
+                                    errp);
+}
+
+static void virtio_ccw_mem_fill_device_info(const MemoryDeviceState *md,
+                                            MemoryDeviceInfo *info)
+{
+    VirtioMEMDeviceInfo *vi = g_new0(VirtioMEMDeviceInfo, 1);
+    VirtIOMEMCcw *ccw_mem = VIRTIO_MEM_CCW(md);
+    VirtIOMEM *vmem = VIRTIO_MEM(&ccw_mem->vdev);
+    VirtIOMEMClass *vpc = VIRTIO_MEM_GET_CLASS(vmem);
+    DeviceState *dev = DEVICE(md);
+
+    if (dev->id) {
+        vi->has_id = true;
+        vi->id = g_strdup(dev->id);
+    }
+
+    /* let the real device handle everything else */
+    vpc->fill_device_info(vmem, vi);
+
+    info->u.virtio_mem.data = vi;
+    info->type = MEMORY_DEVICE_INFO_KIND_VIRTIO_MEM;
+}
+
+static void virtio_ccw_mem_size_change_notify(Notifier *notifier, void *data)
+{
+    VirtIOMEMCcw *ccw_mem = container_of(notifier, VirtIOMEMCcw,
+                                         size_change_notifier);
+    DeviceState *dev = DEVICE(ccw_mem);
+    const uint64_t * const size_p = data;
+    const char *id = NULL;
+
+    if (dev->id) {
+        id = g_strdup(dev->id);
+    }
+
+    qapi_event_send_memory_device_size_change(!!id, id, *size_p);
+}
+
+static void virtio_ccw_mem_instance_init(Object *obj)
+{
+    VirtioCcwDevice *ccw_dev = VIRTIO_CCW_DEVICE(obj);
+    VirtIOMEMCcw *ccw_mem = VIRTIO_MEM_CCW(obj);
+    VirtIOMEMClass *vmc;
+    VirtIOMEM *vmem;
+
+    ccw_dev->force_revision_1 = true;
+    virtio_instance_init_common(obj, &ccw_mem->vdev, sizeof(ccw_mem->vdev),
+                                TYPE_VIRTIO_MEM);
+
+    ccw_mem->size_change_notifier.notify = virtio_ccw_mem_size_change_notify;
+    vmem = VIRTIO_MEM(&ccw_mem->vdev);
+    vmc = VIRTIO_MEM_GET_CLASS(vmem);
+    /*
+     * We never remove the notifier again, as we expect both devices to
+     * disappear at the same time.
+     */
+    vmc->add_size_change_notifier(vmem, &ccw_mem->size_change_notifier);
+
+    object_property_add_alias(obj, VIRTIO_MEM_BLOCK_SIZE_PROP,
+                              OBJECT(&ccw_mem->vdev),
+                              VIRTIO_MEM_BLOCK_SIZE_PROP);
+    object_property_add_alias(obj, VIRTIO_MEM_SIZE_PROP, OBJECT(&ccw_mem->vdev),
+                              VIRTIO_MEM_SIZE_PROP);
+    object_property_add_alias(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP,
+                              OBJECT(&ccw_mem->vdev),
+                              VIRTIO_MEM_REQUESTED_SIZE_PROP);
+}
+
+static Property virtio_ccw_mem_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
+                    VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
+                       VIRTIO_CCW_MAX_REV),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_ccw_mem_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
+    MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(klass);
+
+    k->realize = virtio_ccw_mem_realize;
+    device_class_set_props(dc, virtio_ccw_mem_properties);
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+
+    mdc->get_addr = virtio_ccw_mem_get_addr;
+    mdc->set_addr = virtio_ccw_mem_set_addr;
+    mdc->get_plugged_size = virtio_ccw_mem_get_plugged_size;
+    mdc->get_memory_region = virtio_ccw_mem_get_memory_region;
+    mdc->fill_device_info = virtio_ccw_mem_fill_device_info;
+}
+
+static const TypeInfo virtio_ccw_mem = {
+    .name = TYPE_VIRTIO_MEM_CCW,
+    .parent = TYPE_VIRTIO_CCW_DEVICE,
+    .instance_size = sizeof(VirtIOMEMCcw),
+    .instance_init = virtio_ccw_mem_instance_init,
+    .class_init = virtio_ccw_mem_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_MEMORY_DEVICE },
+        { }
+    },
+};
+
+static void virtio_ccw_mem_register(void)
+{
+    type_register_static(&virtio_ccw_mem);
+}
+
+type_init(virtio_ccw_mem_register)
diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
index c0e3355248..77aa87c41f 100644
--- a/hw/s390x/virtio-ccw.h
+++ b/hw/s390x/virtio-ccw.h
@@ -29,6 +29,7 @@
 #endif /* CONFIG_VHOST_VSOCK */
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-input.h"
+#include "hw/virtio/virtio-mem.h"
 
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/css.h"
@@ -256,4 +257,16 @@ typedef struct VirtIOInputHIDCcw {
     VirtIOInputHID vdev;
 } VirtIOInputHIDCcw;
 
+/* virtio-mem-ccw */
+
+#define TYPE_VIRTIO_MEM_CCW "virtio-mem-ccw"
+#define VIRTIO_MEM_CCW(obj) \
+        OBJECT_CHECK(VirtIOMEMCcw, (obj), TYPE_VIRTIO_MEM_CCW)
+
+typedef struct VirtIOMEMCcw {
+    VirtioCcwDevice parent_obj;
+    VirtIOMEM vdev;
+    Notifier size_change_notifier;
+} VirtIOMEMCcw;
+
 #endif
-- 
2.26.2


