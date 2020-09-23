Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F338C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 11:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A7A120663
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 11:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hjW1spbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A7A120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL3CX-0004Pi-87
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 07:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kL37b-0008QH-RL
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 07:39:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39034)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kL37V-0006uo-0N
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 07:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600861159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uW1JAqLt4GRqGGLNCcSxkLCl6MbYNQ6yyMJyBwSaQ6U=;
 b=hjW1spbKE0lMWgZsOx69VlKqDPsDXyxbZLGBYzQRN2lGpK2Yjzna5pkU1zmwlmFZSFZaiL
 Cas37h+Wn57ocqpTJp/sxU0kY/1Rw60E8gZ2g6sh3aqoY0r92e4FJZkfVqYD2+8J6p/rTy
 xtH310PruTQm7mjSRY+SXu7IF67cLTE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-2kZ7HAhROoG-kBTn7Ma3SQ-1; Wed, 23 Sep 2020 07:39:18 -0400
X-MC-Unique: 2kZ7HAhROoG-kBTn7Ma3SQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 266CE427C4;
 Wed, 23 Sep 2020 11:39:17 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-54.ams2.redhat.com [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C712702E7;
 Wed, 23 Sep 2020 11:39:15 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 5/5] virito-mem: Implement get_min_alignment()
Date: Wed, 23 Sep 2020 13:39:00 +0200
Message-Id: <20200923113900.72718-6-david@redhat.com>
In-Reply-To: <20200923113900.72718-1-david@redhat.com>
References: <20200923113900.72718-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows auto-assignment of a properly aligned address in guest
physical address space. For example, when specifying a 2GB block size
for a virtio-mem device with 10GB with a memory setup "-m 4G, 20G",
we'll no longer fail when realizing.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem-pci.c | 14 ++++++++++++++
 hw/virtio/virtio-mem.c     |  8 ++++++++
 2 files changed, 22 insertions(+)

diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
index 590cec041b..2bfa2474fb 100644
--- a/hw/virtio/virtio-mem-pci.c
+++ b/hw/virtio/virtio-mem-pci.c
@@ -75,6 +75,19 @@ static void virtio_mem_pci_fill_device_info(const MemoryDeviceState *md,
     info->type = MEMORY_DEVICE_INFO_KIND_VIRTIO_MEM;
 }
 
+static uint64_t virtio_mem_pci_get_min_alignment(const MemoryDeviceState *md)
+{
+    /*
+     * If no block size was configured, returns the default block size.
+     * Before the device was realized, this might be smaller than the
+     * final block size (because it ignores the page size of the memory region).
+     * However, the alignment of the memory region properly considers the
+     * page size of the memory region.
+     */
+    return object_property_get_uint(OBJECT(md), VIRTIO_MEM_BLOCK_SIZE_PROP,
+                                    &error_abort);
+}
+
 static void virtio_mem_pci_size_change_notify(Notifier *notifier, void *data)
 {
     VirtIOMEMPCI *pci_mem = container_of(notifier, VirtIOMEMPCI,
@@ -109,6 +122,7 @@ static void virtio_mem_pci_class_init(ObjectClass *klass, void *data)
     mdc->get_plugged_size = virtio_mem_pci_get_plugged_size;
     mdc->get_memory_region = virtio_mem_pci_get_memory_region;
     mdc->fill_device_info = virtio_mem_pci_fill_device_info;
+    mdc->get_min_alignment = virtio_mem_pci_get_min_alignment;
 }
 
 static void virtio_mem_pci_instance_init(Object *obj)
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 716eddd792..d8222153cf 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -805,6 +805,14 @@ static void virtio_mem_get_block_size(Object *obj, Visitor *v, const char *name,
     const VirtIOMEM *vmem = VIRTIO_MEM(obj);
     uint64_t value = vmem->block_size;
 
+    /*
+     * If not configured by the user (and we're not realized yet), use the
+     * default block size.
+     */
+    if (!value) {
+        value = virtio_mem_default_block_size();
+    }
+
     visit_type_size(v, name, &value, errp);
 }
 
-- 
2.26.2


