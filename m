Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAC1C2D0E2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:39:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5979423741
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OSigXw2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5979423741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLUHg-00074L-7f
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 12:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kLTkN-0002Ds-MF
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 12:05:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31094)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kLTkF-0003bq-LH
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 12:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600963514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T/ZKOQNJcI2maVD2pHtRKj9D8ra+xSOLD0oKJHjr4E4=;
 b=OSigXw2CqvQFQh1XQHIBzCPab6fEzhDUMR9C8WdC8thlGVdbO8XV5e/Pr7gwolXq2UbPXX
 X2CL3Up5SJHdB5WkZl3yOcTjGUyQIZKP3FHfS1WlFp/Sh7zDq5LeJKTrIepON72IGH9bBE
 h6CWd1JUux+a5MwdCuhUtUXTq3feNqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-t5RGKrAvOdmNOHXtgOY4HA-1; Thu, 24 Sep 2020 12:05:12 -0400
X-MC-Unique: t5RGKrAvOdmNOHXtgOY4HA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D29AA18BA284;
 Thu, 24 Sep 2020 16:05:11 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-4.ams2.redhat.com [10.36.114.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A058F19C66;
 Thu, 24 Sep 2020 16:05:00 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH PROTOTYPE 2/6] virtio-mem: Impelement SparseRAMHandler
 interface
Date: Thu, 24 Sep 2020 18:04:19 +0200
Message-Id: <20200924160423.106747-3-david@redhat.com>
In-Reply-To: <20200924160423.106747-1-david@redhat.com>
References: <20200924160423.106747-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Luiz Capitulino <lcapitulino@redhat.com>, Auger Eric <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's properly notify when (un)plugging blocks. Handle errors from
notifiers gracefully when mapping, rolling back the change and telling
the guest that the VM is busy.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem.c         | 158 ++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-mem.h |   3 +
 2 files changed, 160 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 8fbec77ccc..e23969eaed 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -72,6 +72,64 @@ static bool virtio_mem_is_busy(void)
     return migration_in_incoming_postcopy() || !migration_is_idle();
 }
 
+static void virtio_mem_srh_notify_unmap(VirtIOMEM *vmem, uint64_t offset,
+                                        uint64_t size)
+{
+    SparseRAMNotifier *notifier;
+
+    QLIST_FOREACH(notifier, &vmem->sram_notify, next) {
+        notifier->notify_unmap(notifier, &vmem->memdev->mr, offset, size);
+    }
+}
+
+static int virtio_mem_srh_notify_map(VirtIOMEM *vmem, uint64_t offset,
+                                     uint64_t size)
+{
+    SparseRAMNotifier *notifier, *notifier2;
+    int ret = 0;
+
+    QLIST_FOREACH(notifier, &vmem->sram_notify, next) {
+        ret = notifier->notify_map(notifier, &vmem->memdev->mr, offset, size);
+        if (ret) {
+            break;
+        }
+    }
+
+    /* In case any notifier failed, undo the whole operation. */
+    if (ret) {
+        QLIST_FOREACH(notifier2, &vmem->sram_notify, next) {
+            if (notifier2 == notifier) {
+                break;
+            }
+            notifier2->notify_unmap(notifier2, &vmem->memdev->mr, offset, size);
+        }
+    }
+    return ret;
+}
+
+/*
+ * TODO: Maybe we could notify directly that everything is unmapped/discarded.
+ * at least vfio should be able to deal with that.
+ */
+static void virtio_mem_srh_notify_unplug_all(VirtIOMEM *vmem)
+{
+    unsigned long first_zero_bit, last_zero_bit;
+    uint64_t offset, length;
+
+    /* Find consecutive unplugged blocks and notify */
+    first_zero_bit = find_first_zero_bit(vmem->bitmap, vmem->bitmap_size);
+    while (first_zero_bit < vmem->bitmap_size) {
+        offset = first_zero_bit * vmem->block_size;
+        last_zero_bit = find_next_bit(vmem->bitmap, vmem->bitmap_size,
+                                      first_zero_bit + 1) - 1;
+        length = (last_zero_bit - first_zero_bit + 1) * vmem->block_size;
+
+        virtio_mem_srh_notify_unmap(vmem, offset, length);
+        first_zero_bit = find_next_zero_bit(vmem->bitmap, vmem->bitmap_size,
+                                            last_zero_bit + 2);
+    }
+}
+
 static bool virtio_mem_test_bitmap(VirtIOMEM *vmem, uint64_t start_gpa,
                                    uint64_t size, bool plugged)
 {
@@ -146,7 +204,7 @@ static int virtio_mem_set_block_state(VirtIOMEM *vmem, uint64_t start_gpa,
                                       uint64_t size, bool plug)
 {
     const uint64_t offset = start_gpa - vmem->addr;
-    int ret;
+    int ret, ret2;
 
     if (virtio_mem_is_busy()) {
         return -EBUSY;
@@ -159,6 +217,23 @@ static int virtio_mem_set_block_state(VirtIOMEM *vmem, uint64_t start_gpa,
                          strerror(-ret));
             return -EBUSY;
         }
+        /*
+         * We'll notify *after* discarding succeeded, because we might not be
+         * able to map again ...
+         */
+        virtio_mem_srh_notify_unmap(vmem, offset, size);
+    } else if (virtio_mem_srh_notify_map(vmem, offset, size)) {
+        /*
+         * Could be a mapping attempt already already resulted in memory
+         * getting populated.
+         */
+        ret2 = ram_block_discard_range(vmem->memdev->mr.ram_block, offset,
+                                       size);
+        if (ret2) {
+            error_report("Unexpected error discarding RAM: %s",
+                         strerror(-ret2));
+        }
+        return -EBUSY;
     }
     virtio_mem_set_bitmap(vmem, start_gpa, size, plug);
     return 0;
@@ -253,6 +328,8 @@ static int virtio_mem_unplug_all(VirtIOMEM *vmem)
         error_report("Unexpected error discarding RAM: %s", strerror(-ret));
         return -EBUSY;
     }
+    virtio_mem_srh_notify_unplug_all(vmem);
+
     bitmap_clear(vmem->bitmap, 0, vmem->bitmap_size);
     if (vmem->size) {
         vmem->size = 0;
@@ -480,6 +557,13 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
     vmstate_register_ram(&vmem->memdev->mr, DEVICE(vmem));
     qemu_register_reset(virtio_mem_system_reset, vmem);
     precopy_add_notifier(&vmem->precopy_notifier);
+
+    /*
+     * Set it to sparse, so everybody is aware of it before the plug handler
+     * exposes the region to the system.
+     */
+    memory_region_set_sparse_ram_handler(&vmem->memdev->mr,
+                                         SPARSE_RAM_HANDLER(vmem));
 }
 
 static void virtio_mem_device_unrealize(DeviceState *dev)
@@ -487,6 +571,7 @@ static void virtio_mem_device_unrealize(DeviceState *dev)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOMEM *vmem = VIRTIO_MEM(dev);
 
+    memory_region_set_sparse_ram_handler(&vmem->memdev->mr, NULL);
     precopy_remove_notifier(&vmem->precopy_notifier);
     qemu_unregister_reset(virtio_mem_system_reset, vmem);
     vmstate_unregister_ram(&vmem->memdev->mr, DEVICE(vmem));
@@ -813,6 +898,7 @@ static void virtio_mem_instance_init(Object *obj)
     vmem->block_size = VIRTIO_MEM_MIN_BLOCK_SIZE;
     notifier_list_init(&vmem->size_change_notifiers);
     vmem->precopy_notifier.notify = virtio_mem_precopy_notify;
+    QLIST_INIT(&vmem->sram_notify);
 
     object_property_add(obj, VIRTIO_MEM_SIZE_PROP, "size", virtio_mem_get_size,
                         NULL, NULL, NULL);
@@ -832,11 +918,72 @@ static Property virtio_mem_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static uint64_t virtio_mem_srh_get_granularity(const SparseRAMHandler *srh,
+                                               const MemoryRegion *mr)
+{
+    const VirtIOMEM *vmem = VIRTIO_MEM(srh);
+
+    g_assert(mr == &vmem->memdev->mr);
+    return vmem->block_size;
+}
+
+static void virtio_mem_srh_register_listener(SparseRAMHandler *srh,
+                                             const MemoryRegion *mr,
+                                             SparseRAMNotifier *notifier)
+{
+    VirtIOMEM *vmem = VIRTIO_MEM(srh);
+
+    g_assert(mr == &vmem->memdev->mr);
+    QLIST_INSERT_HEAD(&vmem->sram_notify, notifier, next);
+}
+
+static void virtio_mem_srh_unregister_listener(SparseRAMHandler *srh,
+                                               const MemoryRegion *mr,
+                                               SparseRAMNotifier *notifier)
+{
+    VirtIOMEM *vmem = VIRTIO_MEM(srh);
+
+    g_assert(mr == &vmem->memdev->mr);
+    QLIST_REMOVE(notifier, next);
+}
+
+static int virtio_mem_srh_replay_mapped(SparseRAMHandler *srh,
+                                        const MemoryRegion *mr,
+                                        SparseRAMNotifier *notifier)
+{
+    VirtIOMEM *vmem = VIRTIO_MEM(srh);
+    unsigned long first_bit, last_bit;
+    uint64_t offset, length;
+    int ret = 0;
+
+    g_assert(mr == &vmem->memdev->mr);
+
+    /* Find consecutive plugged blocks and notify */
+    first_bit = find_first_bit(vmem->bitmap, vmem->bitmap_size);
+    while (first_bit < vmem->bitmap_size) {
+        offset = first_bit * vmem->block_size;
+        last_bit = find_next_zero_bit(vmem->bitmap, vmem->bitmap_size,
+                                      first_bit + 1) - 1;
+        length = (last_bit - first_bit + 1) * vmem->block_size;
+
+        ret = notifier->notify_map(notifier, mr, offset, length);
+        if (ret) {
+            break;
+        }
+        first_bit = find_next_bit(vmem->bitmap, vmem->bitmap_size,
+                                  last_bit + 2);
+    }
+
+    /* TODO: cleanup on error if necessary. */
+    return ret;
+}
+
 static void virtio_mem_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
     VirtIOMEMClass *vmc = VIRTIO_MEM_CLASS(klass);
+    SparseRAMHandlerClass *srhc = SPARSE_RAM_HANDLER_CLASS(klass);
 
     device_class_set_props(dc, virtio_mem_properties);
     dc->vmsd = &vmstate_virtio_mem;
@@ -852,6 +999,11 @@ static void virtio_mem_class_init(ObjectClass *klass, void *data)
     vmc->get_memory_region = virtio_mem_get_memory_region;
     vmc->add_size_change_notifier = virtio_mem_add_size_change_notifier;
     vmc->remove_size_change_notifier = virtio_mem_remove_size_change_notifier;
+
+    srhc->get_granularity = virtio_mem_srh_get_granularity;
+    srhc->register_listener = virtio_mem_srh_register_listener;
+    srhc->unregister_listener = virtio_mem_srh_unregister_listener;
+    srhc->replay_mapped = virtio_mem_srh_replay_mapped;
 }
 
 static const TypeInfo virtio_mem_info = {
@@ -861,6 +1013,10 @@ static const TypeInfo virtio_mem_info = {
     .instance_init = virtio_mem_instance_init,
     .class_init = virtio_mem_class_init,
     .class_size = sizeof(VirtIOMEMClass),
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_SPARSE_RAM_HANDLER },
+        { }
+    },
 };
 
 static void virtio_register_types(void)
diff --git a/include/hw/virtio/virtio-mem.h b/include/hw/virtio/virtio-mem.h
index 4eeb82d5dd..91d9b48ba0 100644
--- a/include/hw/virtio/virtio-mem.h
+++ b/include/hw/virtio/virtio-mem.h
@@ -67,6 +67,9 @@ struct VirtIOMEM {
 
     /* don't migrate unplugged memory */
     NotifierWithReturn precopy_notifier;
+
+    /* SparseRAMNotifier list to be notified on plug/unplug events. */
+    QLIST_HEAD(, SparseRAMNotifier) sram_notify;
 };
 
 struct VirtIOMEMClass {
-- 
2.26.2


