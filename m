Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA77FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:01:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D4320679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OMvutoJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D4320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgUtd-0007Nj-05
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 11:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jgUjL-0001bT-An
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:50:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30379
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jgUjJ-0000Cm-DP
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591195856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+TR5hNY5EbtQOORuT09Z06OGgWI4/Y21uZ1Q7xkI7ZI=;
 b=OMvutoJibTSem08N/vNvGK7B0oF2lPfA0SpW/1pc3rHVburOf0D45QxUNvvv7dR5Reu34L
 6wvIDgQ2Ph/d08kU9tuQB2l1p4mVGgS3J4+wggc6fAOh9WctbM9aQO+EhVqvX/hO6MNoIf
 MbtgZ791mqW1BIcctVV0FLbuPDDcnkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-AinARblsMCqwTUrob1ftSw-1; Wed, 03 Jun 2020 10:50:55 -0400
X-MC-Unique: AinARblsMCqwTUrob1ftSw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31207EC1A1;
 Wed,  3 Jun 2020 14:50:53 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-192.ams2.redhat.com [10.36.113.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0563F5D9CD;
 Wed,  3 Jun 2020 14:50:44 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 18/20] virtio-mem: Migration sanity checks
Date: Wed,  3 Jun 2020 16:49:12 +0200
Message-Id: <20200603144914.41645-19-david@redhat.com>
In-Reply-To: <20200603144914.41645-1-david@redhat.com>
References: <20200603144914.41645-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: pass client-ip=205.139.110.61; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:04:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

We want to make sure that certain properties don't change during
migration, especially to catch user errors in a nice way. Let's migrate
a temporary structure and validate that the properties didn't change.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem.c | 69 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 455d957e17..158215613c 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -519,12 +519,81 @@ static int virtio_mem_post_load(void *opaque, int version_id)
     return virtio_mem_restore_unplugged(VIRTIO_MEM(opaque));
 }
 
+typedef struct VirtIOMEMMigSanityChecks {
+    VirtIOMEM *parent;
+    uint64_t addr;
+    uint64_t region_size;
+    uint32_t block_size;
+    uint32_t node;
+} VirtIOMEMMigSanityChecks;
+
+static int virtio_mem_mig_sanity_checks_pre_save(void *opaque)
+{
+    VirtIOMEMMigSanityChecks *tmp = opaque;
+    VirtIOMEM *vmem = tmp->parent;
+
+    tmp->addr = vmem->addr;
+    tmp->region_size = memory_region_size(&vmem->memdev->mr);
+    tmp->block_size = vmem->block_size;
+    tmp->node = vmem->node;
+    return 0;
+}
+
+static int virtio_mem_mig_sanity_checks_post_load(void *opaque, int version_id)
+{
+    VirtIOMEMMigSanityChecks *tmp = opaque;
+    VirtIOMEM *vmem = tmp->parent;
+    const uint64_t new_region_size = memory_region_size(&vmem->memdev->mr);
+
+    if (tmp->addr != vmem->addr) {
+        error_report("Property '%s' changed from 0x%" PRIx64 " to 0x%" PRIx64,
+                     VIRTIO_MEM_ADDR_PROP, tmp->addr, vmem->addr);
+        return -EINVAL;
+    }
+    /*
+     * Note: Preparation for resizeable memory regions. The maximum size
+     * of the memory region must not change during migration.
+     */
+    if (tmp->region_size != new_region_size) {
+        error_report("region size changed from 0x%" PRIx64 " to 0x%" PRIx64,
+                     tmp->region_size, new_region_size);
+        return -EINVAL;
+    }
+    if (tmp->block_size != vmem->block_size) {
+        error_report("Property '%s' changed from %0x" PRIx32 " to %0x" PRIx32,
+                     VIRTIO_MEM_BLOCK_SIZE_PROP, tmp->block_size,
+                     vmem->block_size);
+        return -EINVAL;
+    }
+    if (tmp->node != vmem->node) {
+        error_report("Property '%s' changed from %" PRIu32 " to %" PRIu32,
+                     VIRTIO_MEM_NODE_PROP, tmp->node, vmem->node);
+        return -EINVAL;
+    }
+    return 0;
+}
+
+static const VMStateDescription vmstate_virtio_mem_sanity_checks = {
+    .name = "virtio-mem-device/sanity-checks",
+    .pre_save = virtio_mem_mig_sanity_checks_pre_save,
+    .post_load = virtio_mem_mig_sanity_checks_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(addr, VirtIOMEMMigSanityChecks),
+        VMSTATE_UINT64(region_size, VirtIOMEMMigSanityChecks),
+        VMSTATE_UINT32(block_size, VirtIOMEMMigSanityChecks),
+        VMSTATE_UINT32(node, VirtIOMEMMigSanityChecks),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
 static const VMStateDescription vmstate_virtio_mem_device = {
     .name = "virtio-mem-device",
     .minimum_version_id = 1,
     .version_id = 1,
     .post_load = virtio_mem_post_load,
     .fields = (VMStateField[]) {
+        VMSTATE_WITH_TMP(VirtIOMEM, VirtIOMEMMigSanityChecks,
+                         vmstate_virtio_mem_sanity_checks),
         VMSTATE_UINT64(usable_region_size, VirtIOMEM),
         VMSTATE_UINT64(size, VirtIOMEM),
         VMSTATE_UINT64(requested_size, VirtIOMEM),
-- 
2.25.4


