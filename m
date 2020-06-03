Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A02C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:57:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34BD920738
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drS1Onkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BD920738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgUpU-0007fL-Cp
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 10:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jgUjL-0001cP-MJ
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:50:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28213
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jgUjK-0000Cz-N1
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591195857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x+fp0WxE0UpolDsMkUts/isrPy8C9jhd9TnRkt6Trl4=;
 b=drS1OnkmIZX7JPHfAb+zE1zWIH5g/bPGQMXjLBYHabODV8z4bjIwZfoqaEIMHJFlgR8o2m
 74ZdzhWXj7FCXEyqTBJs6drza1MrJdOkyeMvhi/EqdkJlDApELuGJqebeLV0lpnCI9OcAo
 +0ddm57nB0Dtx3+kFEe65CWVQrXmjto=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-9cNRuEqqNJyTeWRj5bPdhw-1; Wed, 03 Jun 2020 10:50:56 -0400
X-MC-Unique: 9cNRuEqqNJyTeWRj5bPdhw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E6C0461;
 Wed,  3 Jun 2020 14:50:55 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-192.ams2.redhat.com [10.36.113.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 81EAC5D9CD;
 Wed,  3 Jun 2020 14:50:53 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 19/20] virtio-mem: Add trace events
Date: Wed,  3 Jun 2020 16:49:13 +0200
Message-Id: <20200603144914.41645-20-david@redhat.com>
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

Let's add some trace events that might come in handy later.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/trace-events | 10 ++++++++++
 hw/virtio/virtio-mem.c | 10 +++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index e83500bee9..c40ad5ea27 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -73,3 +73,13 @@ virtio_iommu_get_domain(uint32_t domain_id) "Alloc domain=%d"
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
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 158215613c..4d0a2e78c0 100644
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
 
-- 
2.25.4


