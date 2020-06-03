Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9465AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:59:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62E0E20679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I97d60m6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E0E20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgUrC-0002b9-LM
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 10:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jgUjO-0001jK-IQ
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:51:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30435
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jgUjN-0000DL-Fd
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591195860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBYEFdYdkABkg9+O7p8/xUrnUZ/fh19orpc9DCmzgVw=;
 b=I97d60m6SDgi17imucZ+z3r/DFGsC6Wvzfou0cKrveN5R2BS3tAm74Vw4yibTymFIce8ye
 Ouvx7GrOV4gsnBpTUdX93azUvxYNKQmp5lNu7Yn1Xcr3GOtzV7E6mxbWUf1Ze2S3Vj2XjD
 bix6rg85JXKdCY4u22RbX/M4iTqC+MM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-W4LMdl8jM7GNXFt5acYupw-1; Wed, 03 Jun 2020 10:50:58 -0400
X-MC-Unique: W4LMdl8jM7GNXFt5acYupw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 856BB835B41;
 Wed,  3 Jun 2020 14:50:57 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-192.ams2.redhat.com [10.36.113.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A907D5D9CD;
 Wed,  3 Jun 2020 14:50:55 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 20/20] virtio-mem: Exclude unplugged memory during migration
Date: Wed,  3 Jun 2020 16:49:14 +0200
Message-Id: <20200603144914.41645-21-david@redhat.com>
In-Reply-To: <20200603144914.41645-1-david@redhat.com>
References: <20200603144914.41645-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: pass client-ip=205.139.110.120; envelope-from=david@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:04:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The content of unplugged memory is undefined and should not be migrated,
ever. Exclude all unplugged memory during precopy using the precopy notifier
infrastructure introduced for free page hinting in virtio-balloon.

Unplugged memory is marked as "not dirty", meaning it won't be
considered for migration.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem.c         | 54 +++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-mem.h |  3 ++
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 4d0a2e78c0..e278b213e2 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -62,8 +62,14 @@ static bool virtio_mem_is_busy(void)
     /*
      * Postcopy cannot handle concurrent discards and we don't want to migrate
      * pages on-demand with stale content when plugging new blocks.
+     *
+     * For precopy, we don't want unplugged blocks in our migration stream, and
+     * when plugging new blocks, the page content might differ between source
+     * and destination (observable by the guest when not initializing pages
+     * after plugging them) until we're running on the destination (as we didn't
+     * migrate these blocks when they were unplugged).
      */
-    return migration_in_incoming_postcopy();
+    return migration_in_incoming_postcopy() || !migration_is_idle();
 }
 
 static bool virtio_mem_test_bitmap(VirtIOMEM *vmem, uint64_t start_gpa,
@@ -475,6 +481,7 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
     host_memory_backend_set_mapped(vmem->memdev, true);
     vmstate_register_ram(&vmem->memdev->mr, DEVICE(vmem));
     qemu_register_reset(virtio_mem_system_reset, vmem);
+    precopy_add_notifier(&vmem->precopy_notifier);
 }
 
 static void virtio_mem_device_unrealize(DeviceState *dev)
@@ -482,6 +489,7 @@ static void virtio_mem_device_unrealize(DeviceState *dev)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOMEM *vmem = VIRTIO_MEM(dev);
 
+    precopy_remove_notifier(&vmem->precopy_notifier);
     qemu_unregister_reset(virtio_mem_system_reset, vmem);
     vmstate_unregister_ram(&vmem->memdev->mr, DEVICE(vmem));
     host_memory_backend_set_mapped(vmem->memdev, false);
@@ -760,12 +768,56 @@ static void virtio_mem_set_block_size(Object *obj, Visitor *v, const char *name,
     vmem->block_size = value;
 }
 
+static void virtio_mem_precopy_exclude_unplugged(VirtIOMEM *vmem)
+{
+    void * const host = qemu_ram_get_host_addr(vmem->memdev->mr.ram_block);
+    unsigned long first_zero_bit, last_zero_bit;
+    uint64_t offset, length;
+
+    /*
+     * Find consecutive unplugged blocks and exclude them from migration.
+     *
+     * Note: Blocks cannot get (un)plugged during precopy, no locking needed.
+     */
+    first_zero_bit = find_first_zero_bit(vmem->bitmap, vmem->bitmap_size);
+    while (first_zero_bit < vmem->bitmap_size) {
+        offset = first_zero_bit * vmem->block_size;
+        last_zero_bit = find_next_bit(vmem->bitmap, vmem->bitmap_size,
+                                      first_zero_bit + 1) - 1;
+        length = (last_zero_bit - first_zero_bit + 1) * vmem->block_size;
+
+        qemu_guest_free_page_hint(host + offset, length);
+        first_zero_bit = find_next_zero_bit(vmem->bitmap, vmem->bitmap_size,
+                                            last_zero_bit + 2);
+    }
+}
+
+static int virtio_mem_precopy_notify(NotifierWithReturn *n, void *data)
+{
+    VirtIOMEM *vmem = container_of(n, VirtIOMEM, precopy_notifier);
+    PrecopyNotifyData *pnd = data;
+
+    switch (pnd->reason) {
+    case PRECOPY_NOTIFY_SETUP:
+        precopy_enable_free_page_optimization();
+        break;
+    case PRECOPY_NOTIFY_AFTER_BITMAP_SYNC:
+        virtio_mem_precopy_exclude_unplugged(vmem);
+        break;
+    default:
+        break;
+    }
+
+    return 0;
+}
+
 static void virtio_mem_instance_init(Object *obj)
 {
     VirtIOMEM *vmem = VIRTIO_MEM(obj);
 
     vmem->block_size = VIRTIO_MEM_MIN_BLOCK_SIZE;
     notifier_list_init(&vmem->size_change_notifiers);
+    vmem->precopy_notifier.notify = virtio_mem_precopy_notify;
 
     object_property_add(obj, VIRTIO_MEM_SIZE_PROP, "size", virtio_mem_get_size,
                         NULL, NULL, NULL);
diff --git a/include/hw/virtio/virtio-mem.h b/include/hw/virtio/virtio-mem.h
index 408a6ede50..ddb3822375 100644
--- a/include/hw/virtio/virtio-mem.h
+++ b/include/hw/virtio/virtio-mem.h
@@ -67,6 +67,9 @@ typedef struct VirtIOMEM {
 
     /* notifiers to notify when "size" changes */
     NotifierList size_change_notifiers;
+
+    /* don't migrate unplugged memory */
+    NotifierWithReturn precopy_notifier;
 } VirtIOMEM;
 
 typedef struct VirtIOMEMClass {
-- 
2.25.4


