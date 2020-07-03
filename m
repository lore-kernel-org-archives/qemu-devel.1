Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF67CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CAE820836
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KixL9Ry/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAE820836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHml-00054t-Pc
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHcb-0008MO-Iv
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:04:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26760
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHcZ-0004Ty-Iv
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593767074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zKfOMeb80edcLFenYqj0ugS/WcCDRNzf8rPuIVf+r7A=;
 b=KixL9Ry/e3Z1Roi07rrLqiPHid40S5HEUBRSoSPmz04eDnvjOAH4eL6mmJc/lvIc64w+t7
 OpGJStunmXlGABCZgLLfJqtErYkYHFAwJ794k37lFgQYrjCrs+eyWhA0SOhjWN1xYV/0Bt
 GDYhQBs3FNfocr/MIvxYoK6nd7t8LR0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-5ttbS1-mNoy-3ByITTVypA-1; Fri, 03 Jul 2020 05:04:33 -0400
X-MC-Unique: 5ttbS1-mNoy-3ByITTVypA-1
Received: by mail-wr1-f72.google.com with SMTP id b8so17078036wro.19
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 02:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zKfOMeb80edcLFenYqj0ugS/WcCDRNzf8rPuIVf+r7A=;
 b=Rydwiw/06l0IaJKOOuTK0YbWIVD1j6Lt9158fL011J+HRe7pma1L7oslviDko41mRP
 uBUhPPnfEDXuGiB3DzSOObizUm26GCwnEmZZKKOb9wqEVIq6Cg7Mu5YD1KcomzGeeEWQ
 7sraGLjQtlQ9P88pbX4UkQMIMOabHATA8CLdRJWYdRgJfo6iUn0tJbZK3X7WUbSa3YEl
 lEDbr6JEWpoKlvrZSTreEHcO4Vo2Gmbl5PQVH9xPDsu57q4AY9qF844d2ZS5Hdv4X/fn
 DED0EEbqTWE+a3UUXYfBGZ0d8MSge3afNnF9o40yyW4ZLGxITOnxqsmFbmJCpBFndt4M
 KVBg==
X-Gm-Message-State: AOAM531Nk2ZhpIiRrrYvasfvN5iDYAN3Jhy0LUwkrSL7Vfty4AMUSIyV
 Z2yJ5poCH5YMRmSXrFSHig6aP7uPHcEWVFr8CQYwFyMg4PxPFFisqMTPCXE5LFByKvCDwSWtvvw
 8xR+8l4bWeo6xCf0=
X-Received: by 2002:a1c:2842:: with SMTP id o63mr20443804wmo.169.1593767071569; 
 Fri, 03 Jul 2020 02:04:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzloWGEE4QTiyiBS6m7hTJJ+iumHhz4F90o9MEyRgcBgspemvVJD3D4UJrzq1galFpln8iL7Q==
X-Received: by 2002:a1c:2842:: with SMTP id o63mr20443789wmo.169.1593767071392; 
 Fri, 03 Jul 2020 02:04:31 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 w17sm14404130wra.42.2020.07.03.02.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 02:04:30 -0700 (PDT)
Date: Fri, 3 Jul 2020 05:04:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/41] virtio-mem: Add trace events
Message-ID: <20200703090252.368694-23-mst@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:38:32
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

Let's add some trace events that might come in handy later.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200626072248.78761-20-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-mem.c | 10 +++++++++-
 hw/virtio/trace-events | 10 ++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 6ed5409669..fdd4dbb42c 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -30,6 +30,7 @@
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "config-devices.h"
+#include "trace.h"
 
 /*
  * Use QEMU_VMALLOC_ALIGN, so no THP will have to be split when unplugging
@@ -100,6 +101,7 @@ static void virtio_mem_send_response(VirtIOMEM *vmem, VirtQueueElement *elem,
     VirtIODevice *vdev = VIRTIO_DEVICE(vmem);
     VirtQueue *vq = vmem->vq;
 
+    trace_virtio_mem_send_response(le16_to_cpu(resp->type));
     iov_from_buf(elem->in_sg, elem->in_num, 0, resp, sizeof(*resp));
 
     virtqueue_push(vq, elem, sizeof(*resp));
@@ -195,6 +197,7 @@ static void virtio_mem_plug_request(VirtIOMEM *vmem, VirtQueueElement *elem,
     const uint16_t nb_blocks = le16_to_cpu(req->u.plug.nb_blocks);
     uint16_t type;
 
+    trace_virtio_mem_plug_request(gpa, nb_blocks);
     type = virtio_mem_state_change_request(vmem, gpa, nb_blocks, true);
     virtio_mem_send_response_simple(vmem, elem, type);
 }
@@ -206,6 +209,7 @@ static void virtio_mem_unplug_request(VirtIOMEM *vmem, VirtQueueElement *elem,
     const uint16_t nb_blocks = le16_to_cpu(req->u.unplug.nb_blocks);
     uint16_t type;
 
+    trace_virtio_mem_unplug_request(gpa, nb_blocks);
     type = virtio_mem_state_change_request(vmem, gpa, nb_blocks, false);
     virtio_mem_send_response_simple(vmem, elem, type);
 }
@@ -225,6 +229,7 @@ static void virtio_mem_resize_usable_region(VirtIOMEM *vmem,
         return;
     }
 
+    trace_virtio_mem_resized_usable_region(vmem->usable_region_size, newsize);
     vmem->usable_region_size = newsize;
 }
 
@@ -247,7 +252,7 @@ static int virtio_mem_unplug_all(VirtIOMEM *vmem)
         vmem->size = 0;
         notifier_list_notify(&vmem->size_change_notifiers, &vmem->size);
     }
-
+    trace_virtio_mem_unplugged_all();
     virtio_mem_resize_usable_region(vmem, vmem->requested_size, true);
     return 0;
 }
@@ -255,6 +260,7 @@ static int virtio_mem_unplug_all(VirtIOMEM *vmem)
 static void virtio_mem_unplug_all_request(VirtIOMEM *vmem,
                                           VirtQueueElement *elem)
 {
+    trace_virtio_mem_unplug_all_request();
     if (virtio_mem_unplug_all(vmem)) {
         virtio_mem_send_response_simple(vmem, elem, VIRTIO_MEM_RESP_BUSY);
     } else {
@@ -272,6 +278,7 @@ static void virtio_mem_state_request(VirtIOMEM *vmem, VirtQueueElement *elem,
         .type = cpu_to_le16(VIRTIO_MEM_RESP_ACK),
     };
 
+    trace_virtio_mem_state_request(gpa, nb_blocks);
     if (!virtio_mem_valid_range(vmem, gpa, size)) {
         virtio_mem_send_response_simple(vmem, elem, VIRTIO_MEM_RESP_ERROR);
         return;
@@ -284,6 +291,7 @@ static void virtio_mem_state_request(VirtIOMEM *vmem, VirtQueueElement *elem,
     } else {
         resp.u.state.state = cpu_to_le16(VIRTIO_MEM_STATE_MIXED);
     }
+    trace_virtio_mem_state_response(le16_to_cpu(resp.u.state.state));
     virtio_mem_send_response(vmem, elem, &resp);
 }
 
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 6427a0047d..292fc15e29 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -74,3 +74,13 @@ virtio_iommu_get_domain(uint32_t domain_id) "Alloc domain=%d"
 virtio_iommu_put_domain(uint32_t domain_id) "Free domain=%d"
 virtio_iommu_translate_out(uint64_t virt_addr, uint64_t phys_addr, uint32_t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=%d"
 virtio_iommu_report_fault(uint8_t reason, uint32_t flags, uint32_t endpoint, uint64_t addr) "FAULT reason=%d flags=%d endpoint=%d address =0x%"PRIx64
+
+# virtio-mem.c
+virtio_mem_send_response(uint16_t type) "type=%" PRIu16
+virtio_mem_plug_request(uint64_t addr, uint16_t nb_blocks) "addr=0x%" PRIx64 " nb_blocks=%" PRIu16
+virtio_mem_unplug_request(uint64_t addr, uint16_t nb_blocks) "addr=0x%" PRIx64 " nb_blocks=%" PRIu16
+virtio_mem_unplugged_all(void) ""
+virtio_mem_unplug_all_request(void) ""
+virtio_mem_resized_usable_region(uint64_t old_size, uint64_t new_size) "old_size=0x%" PRIx64 "new_size=0x%" PRIx64
+virtio_mem_state_request(uint64_t addr, uint16_t nb_blocks) "addr=0x%" PRIx64 " nb_blocks=%" PRIu16
+virtio_mem_state_response(uint16_t state) "state=%" PRIu16
-- 
MST


