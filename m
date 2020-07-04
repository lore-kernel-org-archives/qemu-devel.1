Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6BEC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:46:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6440320771
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLo6mZ/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6440320771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrnB8-0007zA-8y
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmvo-0003vJ-Ks
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44007
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmvm-0001RI-Fs
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=84z48SEDVIW4lHeSX/JWrxebkeh/PVqSS0PAVUgtM8I=;
 b=JLo6mZ/24MQCs4AXwIAUSXr7r9dd0Ro7E12sIP2uiQyduIAr/4PfB+tw82PCgdBxvO4rL2
 dXvQBi1ZG3g7xjl0sY5wj/nGgdvEUUa6ueusdyd2KgcvGdu/7F986QZCSJgxi7vJW3GGqR
 K1dGdQN16zUE13XOOMRJruiiKYz3zK8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-a_3ua2UjPuWPZdA0SB0H-w-1; Sat, 04 Jul 2020 14:30:27 -0400
X-MC-Unique: a_3ua2UjPuWPZdA0SB0H-w-1
Received: by mail-wr1-f69.google.com with SMTP id g14so36341439wrp.8
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=84z48SEDVIW4lHeSX/JWrxebkeh/PVqSS0PAVUgtM8I=;
 b=nujsIOjand6hj+9ms2NvNdT1YnTAv+xWVbyOTT45mMYO35LBQpBEngy1OEoNDBEHlv
 sAeG5F2BLgfvlqFnwT8R94KjGXJefQi+HdoyhNgonWtydMf3giFbIQPT2hSrBK1XC11Q
 /KP4LR9QmRt/0TMl3nb0plaI7xXMAges9y63ZEbt5O1xwNMWrAJc2crz/fK2r3Kr6lNj
 EWRFBt4mZaDRCkBFfV29idZfAw/GtUbwD9GKKLcr0tgcVq24R5mMdhwgjqATyhOtONxx
 7NLXR6bAV5cQAXY9sAOCKZYJKPoyfR7p+8GOIevvjNkgzrkNqN6si2GsclmVUGzId5rh
 vaGw==
X-Gm-Message-State: AOAM532o2/Np/UI2roDBb6E7IzHPRQYlID0TUPq/g/zTh6dunsg4Inqw
 b/WIiCWGJBtv+9EkuyKEvzIu72aijhxJ+o7DesoQQcjTmW1N2yN4ckQEBuFaiQJ1FdEMbCMGc51
 tb6qiWPsJOLGaTjQ=
X-Received: by 2002:a1c:99c2:: with SMTP id b185mr44654505wme.52.1593887426468; 
 Sat, 04 Jul 2020 11:30:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCryA6dX+fL8OLR9fS6X8IAgPieuRlD7P/JDWyluu3Ky07a5hGBsjv+Vy4/u11a5MxEI8B2w==
X-Received: by 2002:a1c:99c2:: with SMTP id b185mr44654495wme.52.1593887426294; 
 Sat, 04 Jul 2020 11:30:26 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 63sm18751488wra.86.2020.07.04.11.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:30:25 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:30:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 23/41] virtio-mem: Exclude unplugged memory during migration
Message-ID: <20200704182750.1088103-24-mst@redhat.com>
References: <20200704182750.1088103-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200704182750.1088103-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

The content of unplugged memory is undefined and should not be migrated,
ever. Exclude all unplugged memory during precopy using the precopy notifier
infrastructure introduced for free page hinting in virtio-balloon.

Unplugged memory is marked as "not dirty", meaning it won't be
considered for migration.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200626072248.78761-21-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-mem.h |  3 ++
 hw/virtio/virtio-mem.c         | 54 +++++++++++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio-mem.h b/include/hw/virtio/virtio-mem.h
index b74c77cd42..0778224964 100644
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
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 1ab9ef17fa..65850530e7 100644
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
@@ -757,12 +765,56 @@ static void virtio_mem_set_block_size(Object *obj, Visitor *v, const char *name,
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
-- 
MST


