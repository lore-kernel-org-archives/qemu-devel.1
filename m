Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8599BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:20:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5507C20723
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjbqJG23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5507C20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHrv-0007ie-Jl
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHey-0005NL-VG
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:07:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45569
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHew-0004yS-Su
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593767222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QL569dPvFUzG3LRggM07g4Qliw+yzL9OH4YIUOzaWWE=;
 b=AjbqJG23+1ApWn9YbYZfPMK4L6F0mRri6FNYVslDGohvikbULkwl0AfhmfAK8YwIIl/NBJ
 55LtFyJJfAmezvUX7YXmeGEDcbWvNdoXUzCXGiC7kC0ygCUb2/I9bRLkxm4tY8TKtXCZy+
 DhPUBq9XaCLniKQUEsgy/tPIZxPyN10=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-o0aPy3O6Mj2Dia1w1iUxqQ-1; Fri, 03 Jul 2020 05:04:25 -0400
X-MC-Unique: o0aPy3O6Mj2Dia1w1iUxqQ-1
Received: by mail-wm1-f69.google.com with SMTP id s134so34552299wme.6
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 02:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QL569dPvFUzG3LRggM07g4Qliw+yzL9OH4YIUOzaWWE=;
 b=hmQZJY1B8FcSsrk2JGtbZwyja/sCDG5ldkeIOe6koVUDt13JVMHFqp4/7C0BCppdro
 q+SPL2iZvEU8oQw0uYH84EnlJTMmuE8rJSu2a/hRk8U0P6SUciAHHQTR4dW5KNKHDCSr
 DgsUfpq3WC96635wK9FEWIIrh/TQtJxV3NNa9Ic7tiWMZksdrbmIo75q63/ly1KBLra5
 Qb3bKIvbOsinPiIYB7lALf/KiOZMXtTByYVKjxqgQ6FFvL4ayFT+ETuRw4cXxqivv364
 aZRbveOYQIhMlrLTbFL0vce4bGBHIaDze4Aa45tE4NSmGEyto7FSVqoU6zNxtX0u8rJR
 ngtg==
X-Gm-Message-State: AOAM533/3/DRHWoROzzc6byQFLulbwQqij2tErYsUbr5yTAEJe7ku7cg
 4wAMPb74LUkRetupny4vnuvPGQYdy6gStemzr9FHuX7N1AmzGWJ/9Ep15wn2TJMRnKVOCAeEn7X
 yRYFdQ9fT0UhPIPU=
X-Received: by 2002:a05:6000:1008:: with SMTP id
 a8mr36837796wrx.416.1593767063857; 
 Fri, 03 Jul 2020 02:04:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxP1o7esVN4yIiQeE/fa9oq5EysEalIma9POx2y1Sykx8g4c9XWKz+RdLq6uRzqkdeGZ600vg==
X-Received: by 2002:a05:6000:1008:: with SMTP id
 a8mr36837775wrx.416.1593767063625; 
 Fri, 03 Jul 2020 02:04:23 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 v9sm5089346wri.3.2020.07.03.02.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 02:04:23 -0700 (PDT)
Date: Fri, 3 Jul 2020 05:04:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/41] virtio-mem: Allow notifiers for size changes
Message-ID: <20200703090252.368694-20-mst@redhat.com>
References: <20200703090252.368694-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200703090252.368694-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:34:15
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
 Igor Mammedov <imammedo@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

We want to send qapi events in case the size of a virtio-mem device
changes. This allows upper layers to always know how much memory is
actually currently consumed via a virtio-mem device.

Unfortuantely, we have to report the id of our proxy device. Let's provide
an easy way for our proxy device to register, so it can send the qapi
events. Piggy-backing on the notifier infrastructure (although we'll
only ever have one notifier registered) seems to be an easy way.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200626072248.78761-17-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-mem.h |  5 +++++
 hw/virtio/virtio-mem.c         | 21 ++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio-mem.h b/include/hw/virtio/virtio-mem.h
index 6981096f7c..b74c77cd42 100644
--- a/include/hw/virtio/virtio-mem.h
+++ b/include/hw/virtio/virtio-mem.h
@@ -64,6 +64,9 @@ typedef struct VirtIOMEM {
 
     /* block size and alignment */
     uint64_t block_size;
+
+    /* notifiers to notify when "size" changes */
+    NotifierList size_change_notifiers;
 } VirtIOMEM;
 
 typedef struct VirtIOMEMClass {
@@ -73,6 +76,8 @@ typedef struct VirtIOMEMClass {
     /* public */
     void (*fill_device_info)(const VirtIOMEM *vmen, VirtioMEMDeviceInfo *vi);
     MemoryRegion *(*get_memory_region)(VirtIOMEM *vmem, Error **errp);
+    void (*add_size_change_notifier)(VirtIOMEM *vmem, Notifier *notifier);
+    void (*remove_size_change_notifier)(VirtIOMEM *vmem, Notifier *notifier);
 } VirtIOMEMClass;
 
 #endif
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index d8a0c974d3..2df33f9125 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -184,6 +184,7 @@ static int virtio_mem_state_change_request(VirtIOMEM *vmem, uint64_t gpa,
     } else {
         vmem->size -= size;
     }
+    notifier_list_notify(&vmem->size_change_notifiers, &vmem->size);
     return VIRTIO_MEM_RESP_ACK;
 }
 
@@ -242,7 +243,10 @@ static int virtio_mem_unplug_all(VirtIOMEM *vmem)
         return -EBUSY;
     }
     bitmap_clear(vmem->bitmap, 0, vmem->bitmap_size);
-    vmem->size = 0;
+    if (vmem->size) {
+        vmem->size = 0;
+        notifier_list_notify(&vmem->size_change_notifiers, &vmem->size);
+    }
 
     virtio_mem_resize_usable_region(vmem, vmem->requested_size, true);
     return 0;
@@ -561,6 +565,18 @@ static MemoryRegion *virtio_mem_get_memory_region(VirtIOMEM *vmem, Error **errp)
     return &vmem->memdev->mr;
 }
 
+static void virtio_mem_add_size_change_notifier(VirtIOMEM *vmem,
+                                                Notifier *notifier)
+{
+    notifier_list_add(&vmem->size_change_notifiers, notifier);
+}
+
+static void virtio_mem_remove_size_change_notifier(VirtIOMEM *vmem,
+                                                   Notifier *notifier)
+{
+    notifier_remove(notifier);
+}
+
 static void virtio_mem_get_size(Object *obj, Visitor *v, const char *name,
                                 void *opaque, Error **errp)
 {
@@ -668,6 +684,7 @@ static void virtio_mem_instance_init(Object *obj)
     VirtIOMEM *vmem = VIRTIO_MEM(obj);
 
     vmem->block_size = VIRTIO_MEM_MIN_BLOCK_SIZE;
+    notifier_list_init(&vmem->size_change_notifiers);
 
     object_property_add(obj, VIRTIO_MEM_SIZE_PROP, "size", virtio_mem_get_size,
                         NULL, NULL, NULL);
@@ -705,6 +722,8 @@ static void virtio_mem_class_init(ObjectClass *klass, void *data)
 
     vmc->fill_device_info = virtio_mem_fill_device_info;
     vmc->get_memory_region = virtio_mem_get_memory_region;
+    vmc->add_size_change_notifier = virtio_mem_add_size_change_notifier;
+    vmc->remove_size_change_notifier = virtio_mem_remove_size_change_notifier;
 }
 
 static const TypeInfo virtio_mem_info = {
-- 
MST


