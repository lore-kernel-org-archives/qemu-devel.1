Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12586C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:38:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA95620724
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tev7n6pM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA95620724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1sE0-0006je-Uf
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 08:38:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j1sBe-0001d0-JE
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j1sBb-00062k-6v
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34799
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j1sBb-000622-1b
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581514574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UEsjx+u11+BSH+XbJEMK/mUWJ7OoXzx/dv0URp7U+sw=;
 b=Tev7n6pM1+hVAt385ZxJbguMJGxp7JjfS3ha7l1dSladrQ4ynyS2397guClFzob/S+MGZi
 aD8ZRILUyoAXb37pWlgLfw5guWhuIYur1Dmlg7gWEQ3PYwHSkbhT1TDU2Hl4PhdlOwwBvp
 GLqdl0I+o8uEwAzzJqgsRDd/KjWa5rs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-xLUYHPi3OjWKAMbiyBoo7w-1; Wed, 12 Feb 2020 08:36:12 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80076800D5B;
 Wed, 12 Feb 2020 13:36:11 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-92.ams2.redhat.com [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8705819C69;
 Wed, 12 Feb 2020 13:36:09 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/16] virtio-mem: Prototype
Date: Wed, 12 Feb 2020 14:35:46 +0100
Message-Id: <20200212133601.10555-2-david@redhat.com>
In-Reply-To: <20200212133601.10555-1-david@redhat.com>
References: <20200212133601.10555-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: xLUYHPi3OjWKAMbiyBoo7w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/Kconfig              |  11 +
 hw/virtio/Makefile.objs        |   1 +
 hw/virtio/virtio-mem.c         | 805 +++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-mem.h |  83 ++++
 qapi/misc.json                 |  39 +-
 5 files changed, 938 insertions(+), 1 deletion(-)
 create mode 100644 hw/virtio/virtio-mem.c
 create mode 100644 include/hw/virtio/virtio-mem.h

diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index f87def27a6..638fe120b1 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -42,3 +42,14 @@ config VIRTIO_PMEM
     depends on VIRTIO
     depends on VIRTIO_PMEM_SUPPORTED
     select MEM_DEVICE
+
+config VIRTIO_MEM_SUPPORTED
+    bool
+
+config VIRTIO_MEM
+    bool
+    default y
+    depends on VIRTIO
+    depends on LINUX
+    depends on VIRTIO_MEM_SUPPORTED
+    select MEM_DEVICE
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index de0f5fc39b..3ed94c84d7 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -17,6 +17,7 @@ obj-$(CONFIG_VIRTIO_PMEM) +=3D virtio-pmem.o
 common-obj-$(call land,$(CONFIG_VIRTIO_PMEM),$(CONFIG_VIRTIO_PCI)) +=3D vi=
rtio-pmem-pci.o
 obj-$(call land,$(CONFIG_VHOST_USER_FS),$(CONFIG_VIRTIO_PCI)) +=3D vhost-u=
ser-fs-pci.o
 obj-$(CONFIG_VHOST_VSOCK) +=3D vhost-vsock.o
+obj-$(CONFIG_VIRTIO_MEM) +=3D virtio-mem.o
=20
 ifeq ($(CONFIG_VIRTIO_PCI),y)
 obj-$(CONFIG_VHOST_VSOCK) +=3D vhost-vsock-pci.o
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
new file mode 100644
index 0000000000..2f759578fe
--- /dev/null
+++ b/hw/virtio/virtio-mem.c
@@ -0,0 +1,805 @@
+/*
+ * Virtio MEM device
+ *
+ * Copyright (C) 2018-2019 Red Hat, Inc.
+ *
+ * Authors:
+ *  David Hildenbrand <david@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/iov.h"
+#include "qemu/cutils.h"
+#include "qemu/error-report.h"
+#include "qemu/units.h"
+#include "sysemu/kvm.h"
+#include "sysemu/numa.h"
+#include "sysemu/balloon.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/reset.h"
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/virtio-bus.h"
+#include "hw/virtio/virtio-access.h"
+#include "hw/virtio/virtio-mem.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "exec/ram_addr.h"
+#include "migration/postcopy-ram.h"
+#include "migration/misc.h"
+#include "hw/boards.h"
+#include "hw/qdev-properties.h"
+#include "config-devices.h"
+
+/*
+ * Use QEMU_VMALLOC_ALIGN, so no THP will have to be split when unplugging
+ * memory.
+ */
+#define VIRTIO_MEM_DEFAULT_BLOCK_SIZE QEMU_VMALLOC_ALIGN
+#define VIRTIO_MEM_MIN_BLOCK_SIZE QEMU_VMALLOC_ALIGN
+/*
+ * Size the usable region slightly bigger than the requested size if
+ * possible. This allows guests to make use of most requested memory even
+ * if the memory region in guest physical memory has strange alignment.
+ * E.g. x86-64 has alignment requirements for sections of 128 MiB.
+ */
+#define VIRTIO_MEM_USABLE_EXTENT (256 * MiB)
+
+static bool virtio_mem_busy(void)
+{
+    /*
+     * Better don't mess with dumps and migration - especially when
+     * resizing memory regions. Also, RDMA migration pins all memory.
+     */
+    if (!migration_is_idle()) {
+        return true;
+    }
+    if (dump_in_progress()) {
+        return true;
+    }
+    /*
+     * We can't use madvise(DONTNEED) e.g. with certain VFIO devices,
+     * also resizing memory regions might be problematic. Bad thing is,
+     * this might change suddenly, e.g. when hotplugging a VFIO device.
+     */
+    if (qemu_balloon_is_inhibited()) {
+        return true;
+    }
+    return false;
+}
+
+static bool virtio_mem_test_bitmap(VirtIOMEM *vm, uint64_t start_gpa,
+                                   uint64_t size, bool plug)
+{
+    uint64_t bit =3D (start_gpa - vm->addr) / vm->block_size;
+
+    g_assert(QEMU_IS_ALIGNED(start_gpa, vm->block_size));
+    g_assert(QEMU_IS_ALIGNED(size, vm->block_size));
+    g_assert(vm->bitmap);
+
+    while (size) {
+        g_assert((bit / BITS_PER_BYTE) <=3D vm->bitmap_size);
+
+        if (plug && !test_bit(bit, vm->bitmap)) {
+            return false;
+        } else if (!plug && test_bit(bit, vm->bitmap)) {
+            return false;
+        }
+        size -=3D vm->block_size;
+        bit++;
+    }
+    return true;
+}
+
+static void virtio_mem_set_bitmap(VirtIOMEM *vm, uint64_t start_gpa,
+                                  uint64_t size, bool plug)
+{
+    const uint64_t bit =3D (start_gpa - vm->addr) / vm->block_size;
+    const uint64_t nbits =3D size / vm->block_size;
+
+    g_assert(QEMU_IS_ALIGNED(start_gpa, vm->block_size));
+    g_assert(QEMU_IS_ALIGNED(size, vm->block_size));
+    g_assert(vm->bitmap);
+
+    if (plug) {
+        bitmap_set(vm->bitmap, bit, nbits);
+    } else {
+        bitmap_clear(vm->bitmap, bit, nbits);
+    }
+}
+
+static void virtio_mem_set_block_state(VirtIOMEM *vm, uint64_t start_gpa,
+                                       uint64_t size, bool plug)
+{
+    const uint64_t offset =3D start_gpa - vm->addr;
+
+    g_assert(start_gpa + size > start_gpa);
+    g_assert(QEMU_IS_ALIGNED(start_gpa, vm->block_size));
+    g_assert(size && QEMU_IS_ALIGNED(size, vm->block_size));
+    if (!plug) {
+        ram_block_discard_range(vm->memdev->mr.ram_block, offset, size);
+    }
+
+    virtio_mem_set_bitmap(vm, start_gpa, size, plug);
+}
+
+static void virtio_mem_send_response(VirtIOMEM *vm, VirtQueueElement *elem=
,
+                                     struct virtio_mem_resp *resp)
+{
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(vm);
+    VirtQueue *vq =3D vm->vq;
+
+    iov_from_buf(elem->in_sg, elem->in_num, 0, resp, sizeof(*resp));
+
+    virtqueue_push(vq, elem, sizeof(*resp));
+    virtio_notify(vdev, vq);
+}
+
+static void virtio_mem_send_response_simple(VirtIOMEM *vm,
+                                            VirtQueueElement *elem,
+                                            uint16_t type)
+{
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(vm);
+    struct virtio_mem_resp resp =3D {};
+
+    virtio_stw_p(vdev, &resp.type, type);
+    virtio_mem_send_response(vm, elem, &resp);
+}
+
+static void virtio_mem_bad_request(VirtIOMEM *vm, const char *msg)
+{
+    virtio_error(VIRTIO_DEVICE(vm), "virtio-mem protocol violation: %s", m=
sg);
+}
+
+static bool virtio_mem_valid_range(VirtIOMEM *vm, uint64_t gpa, uint64_t s=
ize)
+{
+    /* address properly aligned? */
+    if (!QEMU_IS_ALIGNED(gpa, vm->block_size)) {
+            return false;
+    }
+
+    /* reasonable size */
+    if (gpa + size <=3D gpa || size =3D=3D 0) {
+        return false;
+    }
+
+    /* start address in usable range? */
+    if (gpa < vm->addr ||
+        gpa >=3D vm->addr + vm->usable_region_size) {
+        return false;
+    }
+
+    /* end address in usable range? */
+    if (gpa + size - 1 >=3D vm->addr + vm->usable_region_size) {
+        return false;
+    }
+    return true;
+}
+
+static int virtio_mem_state_change_request(VirtIOMEM *vm, uint64_t gpa,
+                                           uint16_t nb_blocks, bool plug)
+{
+    const uint64_t size =3D nb_blocks * vm->block_size;
+
+    if (!virtio_mem_valid_range(vm, gpa, size)) {
+        return VIRTIO_MEM_RESP_ERROR;
+    }
+
+    /* trying to plug more than requested */
+    if (plug && (vm->size + size > vm->requested_size)) {
+        return VIRTIO_MEM_RESP_NACK;
+    }
+
+    /* sometimes we cannot discard blocks */
+    if (virtio_mem_busy()) {
+        return VIRTIO_MEM_RESP_BUSY;
+    }
+
+    /* test if really all blocks are in the opposite state */
+    if (!virtio_mem_test_bitmap(vm, gpa, size, !plug)) {
+        return VIRTIO_MEM_RESP_ERROR;
+    }
+
+    /* update the block state */
+    virtio_mem_set_block_state(vm, gpa, size, plug);
+
+    /* update the size */
+    if (plug) {
+        vm->size +=3D size;
+    } else {
+        vm->size -=3D size;
+    }
+    return VIRTIO_MEM_RESP_ACK;
+}
+
+static void virtio_mem_plug_request(VirtIOMEM *vm, VirtQueueElement *elem,
+                                    struct virtio_mem_req *req)
+{
+    const uint64_t gpa =3D le64_to_cpu(req->u.plug.addr);
+    const uint16_t nb_blocks =3D le16_to_cpu(req->u.plug.nb_blocks);
+    uint16_t type;
+
+    type =3D virtio_mem_state_change_request(vm, gpa, nb_blocks, true);
+    virtio_mem_send_response_simple(vm, elem, type);
+}
+
+static void virtio_mem_unplug_request(VirtIOMEM *vm, VirtQueueElement *ele=
m,
+                                      struct virtio_mem_req *req)
+{
+    const uint64_t gpa =3D le64_to_cpu(req->u.unplug.addr);
+    const uint16_t nb_blocks =3D le16_to_cpu(req->u.unplug.nb_blocks);
+    uint16_t type;
+
+    type =3D virtio_mem_state_change_request(vm, gpa, nb_blocks, false);
+    virtio_mem_send_response_simple(vm, elem, type);
+}
+
+/*
+ * Unplug all memory and shrink the usable region.
+ */
+static void virtio_mem_unplug_all(VirtIOMEM *vm)
+{
+    if (vm->size) {
+        virtio_mem_set_block_state(vm, vm->addr,
+                                   memory_region_size(&vm->memdev->mr), fa=
lse);
+        vm->size =3D 0;
+    }
+    vm->usable_region_size =3D MIN(memory_region_size(&vm->memdev->mr),
+                                 vm->requested_size + VIRTIO_MEM_USABLE_EX=
TENT);
+}
+
+static void virtio_mem_unplug_all_request(VirtIOMEM *vm, VirtQueueElement =
*elem)
+{
+
+    if (virtio_mem_busy()) {
+        virtio_mem_send_response_simple(vm, elem,  VIRTIO_MEM_RESP_BUSY);
+        return;
+    }
+
+    virtio_mem_unplug_all(vm);
+    virtio_mem_send_response_simple(vm, elem,  VIRTIO_MEM_RESP_ACK);
+}
+
+static void virtio_mem_state_request(VirtIOMEM *vm, VirtQueueElement *elem=
,
+                                     struct virtio_mem_req *req)
+{
+    const uint64_t gpa =3D le64_to_cpu(req->u.state.addr);
+    const uint16_t nb_blocks =3D le16_to_cpu(req->u.state.nb_blocks);
+    const uint64_t size =3D nb_blocks * vm->block_size;
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(vm);
+    struct virtio_mem_resp resp =3D {};
+
+    if (!virtio_mem_valid_range(vm, gpa, size)) {
+        virtio_mem_send_response_simple(vm, elem, VIRTIO_MEM_RESP_ERROR);
+        return;
+    }
+
+    virtio_stw_p(vdev, &resp.type, VIRTIO_MEM_RESP_ACK);
+    if (virtio_mem_test_bitmap(vm, gpa, size, true)) {
+        virtio_stw_p(vdev, &resp.u.state.state, VIRTIO_MEM_STATE_PLUGGED);
+    } else if (virtio_mem_test_bitmap(vm, gpa, size, false)) {
+        virtio_stw_p(vdev, &resp.u.state.state, VIRTIO_MEM_STATE_UNPLUGGED=
);
+    } else {
+        virtio_stw_p(vdev, &resp.u.state.state, VIRTIO_MEM_STATE_MIXED);
+    }
+    virtio_mem_send_response(vm, elem, &resp);
+}
+
+static void virtio_mem_handle_request(VirtIODevice *vdev, VirtQueue *vq)
+{
+    const int len =3D sizeof(struct virtio_mem_req);
+    VirtIOMEM *vm =3D VIRTIO_MEM(vdev);
+    VirtQueueElement *elem;
+    struct virtio_mem_req req;
+    uint64_t type;
+
+    elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
+    if (!elem) {
+        return;
+    }
+
+    if (iov_to_buf(elem->out_sg, elem->out_num, 0, &req, len) < len) {
+        virtio_mem_bad_request(vm, "invalid request size");
+        goto out_free;
+    }
+
+    if (iov_size(elem->in_sg, elem->in_num) < sizeof(struct virtio_mem_res=
p)) {
+        virtio_mem_bad_request(vm, "not enough space for response");
+        goto out_free;
+    }
+
+    type =3D le16_to_cpu(req.type);
+    switch (type) {
+    case VIRTIO_MEM_REQ_PLUG:
+        virtio_mem_plug_request(vm, elem, &req);
+        break;
+    case VIRTIO_MEM_REQ_UNPLUG:
+        virtio_mem_unplug_request(vm, elem, &req);
+        break;
+    case VIRTIO_MEM_REQ_UNPLUG_ALL:
+        virtio_mem_unplug_all_request(vm, elem);
+        break;
+    case VIRTIO_MEM_REQ_STATE:
+        virtio_mem_state_request(vm, elem, &req);
+        break;
+    default:
+        virtio_mem_bad_request(vm, "unknown request type");
+        goto out_free;
+    }
+
+out_free:
+    g_free(elem);
+}
+
+static void virtio_mem_get_config(VirtIODevice *vdev, uint8_t *config_data=
)
+{
+    VirtIOMEM *vm =3D VIRTIO_MEM(vdev);
+    struct virtio_mem_config *config =3D (void *) config_data;
+
+    config->block_size =3D cpu_to_le32(vm->block_size);
+    config->node_id =3D cpu_to_le16(vm->node);
+    config->requested_size =3D cpu_to_le64(vm->requested_size);
+    config->plugged_size =3D cpu_to_le64(vm->size);
+    config->addr =3D cpu_to_le64(vm->addr);
+    config->region_size =3D cpu_to_le64(memory_region_size(&vm->memdev->mr=
));
+    config->usable_region_size =3D cpu_to_le64(vm->usable_region_size);
+}
+
+static uint64_t virtio_mem_get_features(VirtIODevice *vdev, uint64_t featu=
res,
+                                        Error **errp)
+{
+    MachineState *ms =3D MACHINE(qdev_get_machine());
+
+    if (ms->numa_state) {
+#if defined(CONFIG_ACPI)
+        virtio_add_feature(&features, VIRTIO_MEM_F_ACPI_PXM);
+#endif
+    }
+    return features;
+}
+
+static void virtio_mem_system_reset(void *opaque)
+{
+    VirtIOMEM *vm =3D VIRTIO_MEM(opaque);
+
+    /*
+     * During usual resets, we will unplug all memory and shrink the usabl=
e
+     * region size. This is, however, not possible in all scenarios. Then,
+     * the guest has to deal with this manually (VIRTIO_MEM_REQ_UNPLUG_ALL=
).
+     */
+    if (virtio_mem_busy()) {
+        return;
+    }
+
+    virtio_mem_unplug_all(vm);
+}
+
+static int virtio_mem_postcopy_notifier(NotifierWithReturn *notifier,
+                                        void *opaque)
+{
+    struct PostcopyNotifyData *pnd =3D opaque;
+
+    /*
+     * TODO: We cannot use madvise(DONTNEED) with concurrent postcopy. Whi=
le
+     *       can simply tell the guest to retry later on plug/unplug reque=
sts,
+     *       system resets + restoring the unplugged state during migratio=
n
+     *       requires more thought.
+     *
+     *       We will have to delay such activity until postcopy is finishe=
d and
+     *       (notifies us via its notifier) and then restore the unplugged
+     *       state. When we switch to userfaultfd (WP), we will temporaril=
y
+     *       have to unregister our userfaultfd handler when postcopy is
+     *       about to start and reregister when postcopy is finished.
+     */
+    switch (pnd->reason) {
+    case POSTCOPY_NOTIFY_PROBE:
+        error_setg(pnd->errp, "virtio-mem does not support postcopy yet");
+        return -ENOENT;
+    default:
+        break;
+    }
+    return 0;
+}
+
+static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
+{
+    MachineState *ms =3D MACHINE(qdev_get_machine());
+    int nb_numa_nodes =3D ms->numa_state ? ms->numa_state->num_nodes : 0;
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
+    VirtIOMEM *vm =3D VIRTIO_MEM(dev);
+    Error *local_err =3D NULL;
+    uint64_t page_size;
+
+    /* verify the memdev */
+    if (!vm->memdev) {
+        error_setg(&local_err, "'%s' property must be set",
+                   VIRTIO_MEM_MEMDEV_PROP);
+        goto out;
+    } else if (host_memory_backend_is_mapped(vm->memdev)) {
+        char *path =3D object_get_canonical_path_component(OBJECT(vm->memd=
ev));
+
+        error_setg(&local_err, "can't use already busy memdev: %s", path);
+        g_free(path);
+        goto out;
+    }
+
+    /* verify the node */
+    if ((nb_numa_nodes && vm->node >=3D nb_numa_nodes) ||
+        (!nb_numa_nodes && vm->node)) {
+        error_setg(&local_err, "Property '%s' has value '%" PRIu32
+                   "', which exceeds the number of numa nodes: %d",
+                   VIRTIO_MEM_NODE_PROP, vm->node,
+                   nb_numa_nodes ? nb_numa_nodes : 1);
+        goto out;
+    }
+
+    /* mmap/madvise changes have to be reflected in guest physical memory =
*/
+    if (kvm_enabled() && !kvm_has_sync_mmu()) {
+        error_set(&local_err, ERROR_CLASS_KVM_MISSING_CAP,
+                  "Using KVM without synchronous MMU, virtio-mem unavailab=
le");
+        goto out;
+    }
+
+    /*
+     * TODO: madvise(DONTNEED) does not work with mlock. We might be able
+     * to temporarily unlock and relock at the right places to make it wor=
k.
+     */
+    if (enable_mlock) {
+        error_setg(&local_err, "Memory is locked, virtio-mem unavailable")=
;
+        goto out;
+    }
+
+    g_assert(memory_region_is_ram(&vm->memdev->mr));
+    g_assert(!memory_region_is_rom(&vm->memdev->mr));
+    g_assert(vm->memdev->mr.ram_block);
+
+    /*
+     * TODO: Huge pages under Linux don't support the zero page, therefore
+     * dump and migration could result in a high memory consumption. Disal=
low
+     * it.
+     */
+    page_size =3D qemu_ram_pagesize(vm->memdev->mr.ram_block);
+    if (page_size !=3D getpagesize()) {
+        error_setg(&local_err, "'%s' page size (0x%" PRIx64 ") not support=
ed",
+                   VIRTIO_MEM_MEMDEV_PROP, page_size);
+        goto out;
+    }
+
+    /* now that memdev and block_size is fixed, verify the properties */
+    if (vm->block_size < page_size) {
+        error_setg(&local_err, "'%s' has to be at least the page size (0x%=
"
+                   PRIx64 ")", VIRTIO_MEM_BLOCK_SIZE_PROP, page_size);
+        goto out;
+    } else if (!QEMU_IS_ALIGNED(vm->requested_size, vm->block_size)) {
+        error_setg(errp, "'%s' has to be multiples of '%s' (0x%" PRIx32
+                   ")", VIRTIO_MEM_REQUESTED_SIZE_PROP,
+                   VIRTIO_MEM_BLOCK_SIZE_PROP, vm->block_size);
+    } else if (!QEMU_IS_ALIGNED(memory_region_size(&vm->memdev->mr),
+                                vm->block_size)) {
+        error_setg(&local_err, "'%s' size has to be multiples of '%s' (0x%=
"
+                   PRIx32 ")", VIRTIO_MEM_MEMDEV_PROP,
+                   VIRTIO_MEM_BLOCK_SIZE_PROP, vm->block_size);
+        goto out;
+    }
+
+    /*
+     * If possible, we size the usable region a little bit bigger than the
+     * requested size, so the guest has more flexibility.
+     */
+    vm->usable_region_size =3D MIN(memory_region_size(&vm->memdev->mr),
+                                 vm->requested_size + VIRTIO_MEM_USABLE_EX=
TENT);
+
+    /* allocate the bitmap for tracking the state of a block */
+    vm->bitmap_size =3D memory_region_size(&vm->memdev->mr) / vm->block_si=
ze;
+    vm->bitmap =3D bitmap_new(vm->bitmap_size);
+
+    /* all memory is unplugged initially */
+    virtio_mem_set_block_state(vm, vm->addr,
+                               memory_region_size(&vm->memdev->mr), false)=
;
+
+    /* setup the virtqueue */
+    virtio_init(vdev, TYPE_VIRTIO_MEM, VIRTIO_ID_MEM,
+                sizeof(struct virtio_mem_config));
+    vm->vq =3D virtio_add_queue(vdev, 128, virtio_mem_handle_request);
+
+    host_memory_backend_set_mapped(vm->memdev, true);
+    vmstate_register_ram(&vm->memdev->mr, DEVICE(vm));
+    vm->postcopy_notifier.notify =3D virtio_mem_postcopy_notifier;
+    postcopy_add_notifier(&vm->postcopy_notifier);
+    qemu_register_reset(virtio_mem_system_reset, vm);
+out:
+    error_propagate(errp, local_err);
+}
+
+static void virtio_mem_device_unrealize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
+    VirtIOMEM *vm =3D VIRTIO_MEM(dev);
+
+    qemu_unregister_reset(virtio_mem_system_reset, vm);
+    postcopy_remove_notifier(&vm->postcopy_notifier);
+    vmstate_unregister_ram(&vm->memdev->mr, DEVICE(vm));
+    host_memory_backend_set_mapped(vm->memdev, false);
+    virtio_del_queue(vdev, 0);
+    virtio_cleanup(vdev);
+    g_free(vm->bitmap);
+}
+
+static int virtio_mem_pre_save(void *opaque)
+{
+    VirtIOMEM *vm =3D VIRTIO_MEM(opaque);
+
+    vm->migration_addr =3D vm->addr;
+    vm->migration_block_size =3D vm->block_size;
+
+    return 0;
+}
+
+static int virtio_mem_restore_unplugged(VirtIOMEM *vm)
+{
+    unsigned long bit;
+    uint64_t gpa;
+
+    /*
+     * Called after all migrated memory has been restored, but before post=
copy
+     * is enabled. Either way, we have to restore our state from the bitma=
p
+     * first.
+     */
+    bit =3D find_first_zero_bit(vm->bitmap, vm->bitmap_size);
+    while (bit < vm->bitmap_size) {
+        gpa =3D vm->addr + bit * vm->block_size;
+
+        virtio_mem_set_block_state(vm, gpa, vm->block_size, false);
+        bit =3D find_next_zero_bit(vm->bitmap, vm->bitmap_size, bit + 1);
+    }
+
+    return 0;
+}
+
+static int virtio_mem_post_load(void *opaque, int version_id)
+{
+    VirtIOMEM *vm =3D VIRTIO_MEM(opaque);
+
+    if (vm->migration_block_size !=3D vm->block_size) {
+        error_report("'%s' doesn't match", VIRTIO_MEM_BLOCK_SIZE_PROP);
+        return -EINVAL;
+    }
+    if (vm->migration_addr !=3D vm->addr) {
+        error_report("'%s' doesn't match", VIRTIO_MEM_ADDR_PROP);
+        return -EINVAL;
+    }
+    return virtio_mem_restore_unplugged(vm);
+}
+
+static const VMStateDescription vmstate_virtio_mem_device =3D {
+    .name =3D "virtio-mem-device",
+    .minimum_version_id =3D 1,
+    .version_id =3D 1,
+    .pre_save =3D virtio_mem_pre_save,
+    .post_load =3D virtio_mem_post_load,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT64(usable_region_size, VirtIOMEM),
+        VMSTATE_UINT64(size, VirtIOMEM),
+        VMSTATE_UINT64(requested_size, VirtIOMEM),
+        VMSTATE_UINT64(migration_addr, VirtIOMEM),
+        VMSTATE_UINT32(migration_block_size, VirtIOMEM),
+        VMSTATE_BITMAP(bitmap, VirtIOMEM, 0, bitmap_size),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const VMStateDescription vmstate_virtio_mem =3D {
+    .name =3D "virtio-mem",
+    .minimum_version_id =3D 1,
+    .version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_VIRTIO_DEVICE,
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void virtio_mem_fill_device_info(const VirtIOMEM *vmem,
+                                        VirtioMEMDeviceInfo *vi)
+{
+    vi->memaddr =3D vmem->addr;
+    vi->node =3D vmem->node;
+    vi->requested_size =3D vmem->requested_size;
+    vi->size =3D vmem->size;
+    vi->max_size =3D memory_region_size(&vmem->memdev->mr);
+    vi->block_size =3D vmem->block_size;
+    vi->memdev =3D object_get_canonical_path(OBJECT(vmem->memdev));
+}
+
+static MemoryRegion *virtio_mem_get_memory_region(VirtIOMEM *vmem, Error *=
*errp)
+{
+    if (!vmem->memdev) {
+        error_setg(errp, "'%s' property must be set", VIRTIO_MEM_MEMDEV_PR=
OP);
+        return NULL;
+    }
+
+    return &vmem->memdev->mr;
+}
+
+static void virtio_mem_get_size(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    const VirtIOMEM *vm =3D VIRTIO_MEM(obj);
+    uint64_t value =3D vm->size;
+
+    visit_type_size(v, name, &value, errp);
+}
+
+static void virtio_mem_get_requested_size(Object *obj, Visitor *v,
+                                          const char *name, void *opaque,
+                                          Error **errp)
+{
+    const VirtIOMEM *vm =3D VIRTIO_MEM(obj);
+    uint64_t value =3D vm->requested_size;
+
+    visit_type_size(v, name, &value, errp);
+}
+
+static void virtio_mem_set_requested_size(Object *obj, Visitor *v,
+                                          const char *name, void *opaque,
+                                          Error **errp)
+{
+    VirtIOMEM *vm =3D VIRTIO_MEM(obj);
+    Error *local_err =3D NULL;
+    uint64_t value;
+
+    visit_type_size(v, name, &value, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    /* Growing the usable region might later not be possible, disallow it.=
 */
+    if (virtio_mem_busy() && value > vm->requested_size) {
+        error_setg(errp, "'%s' cannot be increased while migrating,"
+                   " while dumping, or when certain vfio devices are used.=
",
+                   name);
+        return;
+    }
+
+    /*
+     * The block size and memory backend are not fixed until the device wa=
s
+     * realized. realize() will verify these properties then.
+     */
+    if (DEVICE(obj)->realized) {
+        if (!QEMU_IS_ALIGNED(value, vm->block_size)) {
+            error_setg(errp, "'%s' has to be multiples of '%s' (0x%" PRIx3=
2
+                       ")", name, VIRTIO_MEM_BLOCK_SIZE_PROP,
+                       vm->block_size);
+            return;
+        } else if (value > memory_region_size(&vm->memdev->mr)) {
+            error_setg(errp, "'%s' cannot exceed the memory backend size"
+                       "(0x%" PRIx64 ")", name,
+                       memory_region_size(&vm->memdev->mr));
+            return;
+        }
+
+        if (value !=3D vm->requested_size) {
+            uint64_t tmp_size;
+
+            vm->requested_size =3D value;
+
+            /* Grow the usable region if required */
+            tmp_size =3D MIN(memory_region_size(&vm->memdev->mr),
+                           vm->requested_size + VIRTIO_MEM_USABLE_EXTENT);
+            vm->usable_region_size =3D MAX(vm->usable_region_size, tmp_siz=
e);
+        }
+        /*
+         * Trigger a config update so the guest gets notified. We trigger
+         * even if the size didn't change (especially helpful for debuggin=
g).
+         */
+        virtio_notify_config(VIRTIO_DEVICE(vm));
+    } else {
+        vm->requested_size =3D value;
+    }
+}
+
+static void virtio_mem_get_block_size(Object *obj, Visitor *v, const char =
*name,
+                                      void *opaque, Error **errp)
+{
+    const VirtIOMEM *vm =3D VIRTIO_MEM(obj);
+    uint64_t value =3D vm->block_size;
+
+    visit_type_size(v, name, &value, errp);
+}
+
+static void virtio_mem_set_block_size(Object *obj, Visitor *v, const char =
*name,
+                                      void *opaque, Error **errp)
+{
+    VirtIOMEM *vm =3D VIRTIO_MEM(obj);
+    Error *local_err =3D NULL;
+    uint64_t value;
+
+    if (DEVICE(obj)->realized) {
+        error_setg(errp, "'%s' cannot be changed", name);
+        return;
+    }
+
+    visit_type_size(v, name, &value, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (value > UINT32_MAX) {
+        error_setg(errp, "'%s' has to be smaller than 0x%" PRIx32, name,
+                   UINT32_MAX);
+        return;
+    } else if (value < VIRTIO_MEM_MIN_BLOCK_SIZE) {
+        error_setg(errp, "'%s' has to be at least 0x%" PRIx32, name,
+                   VIRTIO_MEM_MIN_BLOCK_SIZE);
+        return;
+    } else if (!is_power_of_2(value)) {
+        error_setg(errp, "'%s' has to be a power of two", name);
+        return;
+    }
+    vm->block_size =3D value;
+}
+
+static void virtio_mem_instance_init(Object *obj)
+{
+    VirtIOMEM *vm =3D VIRTIO_MEM(obj);
+
+    vm->block_size =3D VIRTIO_MEM_DEFAULT_BLOCK_SIZE;
+
+    object_property_add(obj, VIRTIO_MEM_SIZE_PROP, "size", virtio_mem_get_=
size,
+                        NULL, NULL, NULL, &error_abort);
+    object_property_add(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP, "size",
+                        virtio_mem_get_requested_size,
+                        virtio_mem_set_requested_size, NULL, NULL,
+                        &error_abort);
+    object_property_add(obj, VIRTIO_MEM_BLOCK_SIZE_PROP, "size",
+                        virtio_mem_get_block_size, virtio_mem_set_block_si=
ze,
+                        NULL, NULL, &error_abort);
+}
+
+static Property virtio_mem_properties[] =3D {
+    DEFINE_PROP_UINT64(VIRTIO_MEM_ADDR_PROP, VirtIOMEM, addr, 0),
+    DEFINE_PROP_UINT32(VIRTIO_MEM_NODE_PROP, VirtIOMEM, node, 0),
+    DEFINE_PROP_LINK(VIRTIO_MEM_MEMDEV_PROP, VirtIOMEM, memdev,
+                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_mem_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_CLASS(klass);
+    VirtIOMEMClass *vmc =3D VIRTIO_MEM_CLASS(klass);
+
+    device_class_set_props(dc, virtio_mem_properties);
+    dc->vmsd =3D &vmstate_virtio_mem;
+
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    vdc->realize =3D virtio_mem_device_realize;
+    vdc->unrealize =3D virtio_mem_device_unrealize;
+    vdc->get_config =3D virtio_mem_get_config;
+    vdc->get_features =3D virtio_mem_get_features;
+    vdc->vmsd =3D &vmstate_virtio_mem_device;
+
+    vmc->fill_device_info =3D virtio_mem_fill_device_info;
+    vmc->get_memory_region =3D virtio_mem_get_memory_region;
+}
+
+static const TypeInfo virtio_mem_info =3D {
+    .name =3D TYPE_VIRTIO_MEM,
+    .parent =3D TYPE_VIRTIO_DEVICE,
+    .instance_size =3D sizeof(VirtIOMEM),
+    .instance_init =3D virtio_mem_instance_init,
+    .class_init =3D virtio_mem_class_init,
+    .class_size =3D sizeof(VirtIOMEMClass),
+};
+
+static void virtio_register_types(void)
+{
+    type_register_static(&virtio_mem_info);
+}
+
+type_init(virtio_register_types)
diff --git a/include/hw/virtio/virtio-mem.h b/include/hw/virtio/virtio-mem.=
h
new file mode 100644
index 0000000000..0a0d75ad6c
--- /dev/null
+++ b/include/hw/virtio/virtio-mem.h
@@ -0,0 +1,83 @@
+/*
+ * Virtio MEM device
+ *
+ * Copyright (C) 2018-2019 Red Hat, Inc.
+ *
+ * Authors:
+ *  David Hildenbrand <david@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_VIRTIO_MEM_H
+#define HW_VIRTIO_MEM_H
+
+#include "standard-headers/linux/virtio_mem.h"
+#include "hw/virtio/virtio.h"
+#include "qapi/qapi-types-misc.h"
+#include "sysemu/hostmem.h"
+
+#define TYPE_VIRTIO_MEM "virtio-mem"
+
+#define VIRTIO_MEM(obj) \
+        OBJECT_CHECK(VirtIOMEM, (obj), TYPE_VIRTIO_MEM)
+#define VIRTIO_MEM_CLASS(oc) \
+        OBJECT_CLASS_CHECK(VirtIOMEMClass, (oc), TYPE_VIRTIO_MEM)
+#define VIRTIO_MEM_GET_CLASS(obj) \
+        OBJECT_GET_CLASS(VirtIOMEMClass, (obj), TYPE_VIRTIO_MEM)
+
+#define VIRTIO_MEM_MEMDEV_PROP "memdev"
+#define VIRTIO_MEM_NODE_PROP "node"
+#define VIRTIO_MEM_SIZE_PROP "size"
+#define VIRTIO_MEM_REQUESTED_SIZE_PROP "requested-size"
+#define VIRTIO_MEM_BLOCK_SIZE_PROP "block-size"
+#define VIRTIO_MEM_ADDR_PROP "memaddr"
+
+typedef struct VirtIOMEM {
+    VirtIODevice parent_obj;
+
+    /* guest -> host request queue */
+    VirtQueue *vq;
+
+    /* postcopy notifier */
+    NotifierWithReturn postcopy_notifier;
+
+    /* bitmap used to track unplugged memory */
+    int32_t bitmap_size;
+    unsigned long *bitmap;
+
+    /* assigned memory backend and memory region */
+    HostMemoryBackend *memdev;
+
+    /* NUMA node */
+    uint32_t node;
+
+    /* assigned address of the region in guest physical memory */
+    uint64_t addr;
+    uint64_t migration_addr;
+
+    /* usable region size (<=3D region_size) */
+    uint64_t usable_region_size;
+
+    /* actual size (how much the guest plugged) */
+    uint64_t size;
+
+    /* requested size */
+    uint64_t requested_size;
+
+    /* block size and alignment */
+    uint32_t block_size;
+    uint32_t migration_block_size;
+} VirtIOMEM;
+
+typedef struct VirtIOMEMClass {
+    /* private */
+    VirtIODevice parent;
+
+    /* public */
+    void (*fill_device_info)(const VirtIOMEM *vmen, VirtioMEMDeviceInfo *v=
i);
+    MemoryRegion *(*get_memory_region)(VirtIOMEM *vmem, Error **errp);
+} VirtIOMEMClass;
+
+#endif
diff --git a/qapi/misc.json b/qapi/misc.json
index 33b94e3589..cbbb8a35e1 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1557,19 +1557,56 @@
           }
 }
=20
+##
+# @VirtioMEMDeviceInfo:
+#
+# VirtioMEMDevice state information
+#
+# @id: device's ID
+#
+# @memaddr: physical address in memory, where device is mapped
+#
+# @requested-size: the user requested size of the device
+#
+# @size: the (current) size of memory that the device provides
+#
+# @max-size: the maximum size of memory that the device can provide
+#
+# @block-size: the block size of memory that the device provides
+#
+# @node: NUMA node number where device is assigned to
+#
+# @memdev: memory backend linked with the region
+#
+# Since: 4.1
+##
+{ 'struct': 'VirtioMEMDeviceInfo',
+  'data': { '*id': 'str',
+            'memaddr': 'size',
+            'requested-size': 'size',
+            'size': 'size',
+            'max-size': 'size',
+            'block-size': 'size',
+            'node': 'int',
+            'memdev': 'str'
+          }
+}
+
 ##
 # @MemoryDeviceInfo:
 #
 # Union containing information about a memory device
 #
 # nvdimm is included since 2.12. virtio-pmem is included since 4.1.
+# virtio-mem is included since 4.2.
 #
 # Since: 2.1
 ##
 { 'union': 'MemoryDeviceInfo',
   'data': { 'dimm': 'PCDIMMDeviceInfo',
             'nvdimm': 'PCDIMMDeviceInfo',
-            'virtio-pmem': 'VirtioPMEMDeviceInfo'
+            'virtio-pmem': 'VirtioPMEMDeviceInfo',
+            'virtio-mem': 'VirtioMEMDeviceInfo'
           }
 }
=20
--=20
2.24.1


