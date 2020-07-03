Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0853EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:13:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C21E520836
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8eAk4Te"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21E520836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHlD-00019E-Vp
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHcY-0008Hc-UC
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:04:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59455
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHcW-0004SS-UA
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593767072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uSInzZZOVtvDs03ohDRy+d+1DDBJCJjbf1omcuqWWj8=;
 b=D8eAk4TeNPouVDVz/rxAzZoZIrwRuDmnUAaFQaxoS6QqFaBEPPUZ4/ecsG6cmOhPswu9e+
 kvtRAfjBTMPbSFCyjFL1yUMdvXA46t/DvP+3sjTjFmbA3GpPxKvlAGrutvuB48wVRTmw1x
 aTrpFhsGl6+5OsrvaivW+/G7x0veKrw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-hI7QqC82Mx-LB-VTY_YCFg-1; Fri, 03 Jul 2020 05:04:30 -0400
X-MC-Unique: hI7QqC82Mx-LB-VTY_YCFg-1
Received: by mail-wm1-f72.google.com with SMTP id h25so20587980wmb.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 02:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uSInzZZOVtvDs03ohDRy+d+1DDBJCJjbf1omcuqWWj8=;
 b=JHavszoQOMzbUEsAY64iCsPzniBDgBugnvofFxM3tZ3JjpwccCWekaEd7A94VgbyeS
 mblnCItFiJD+kdC43AX5tr5O/fMd8F+Gfh4KFgHKJdHVOIVsEuyi1FPEiALzq1oESPIf
 3LA4sR9u5P7FFMJE+x44x9qtwYsdvCCaYGCFPqZgDIj0orSpQRjhYyG6HDbnnMUvVEPp
 pjbhNOQGE5iqsabbuuUpS8JpubDjMLi1BgN3d9AawNYi35euzjBdIFPcm9N5yai3y8f8
 sb1pDjsJZjbXTnJd/sVgqNpaHdwHNq4zyHm8g+8U9nill7eo6Oej2eUMRJN7vh2T/Ydz
 Ifjw==
X-Gm-Message-State: AOAM530+rvGyH8YtX9ZUd2wxi7HdWyjiiR3SeJnq5dIVVCv8syZW6yIv
 aOsZYmKgRFYhQXD+qfQnV+zmTfkoEgVMdG28ROLYpNqH3uVAcGpvQ+yTH7odd5eAPNAb4PcwPX5
 693YUFySPqNSgvnE=
X-Received: by 2002:a5d:4ecc:: with SMTP id s12mr35256296wrv.57.1593767069100; 
 Fri, 03 Jul 2020 02:04:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzH+oBuJjnQ6hLs899IiE80qK4i6kqsBvEONniO47iru7HYAFBSPpe4d1W2DdeB7iG/VHEhrg==
X-Received: by 2002:a5d:4ecc:: with SMTP id s12mr35256278wrv.57.1593767068874; 
 Fri, 03 Jul 2020 02:04:28 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 x124sm8139956wmx.16.2020.07.03.02.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 02:04:28 -0700 (PDT)
Date: Fri, 3 Jul 2020 05:04:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/41] virtio-mem: Migration sanity checks
Message-ID: <20200703090252.368694-22-mst@redhat.com>
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
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

We want to make sure that certain properties don't change during
migration, especially to catch user errors in a nice way. Let's migrate
a temporary structure and validate that the properties didn't change.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200626072248.78761-19-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-mem.c | 70 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 2df33f9125..6ed5409669 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -519,12 +519,82 @@ static int virtio_mem_post_load(void *opaque, int version_id)
     return virtio_mem_restore_unplugged(VIRTIO_MEM(opaque));
 }
 
+typedef struct VirtIOMEMMigSanityChecks {
+    VirtIOMEM *parent;
+    uint64_t addr;
+    uint64_t region_size;
+    uint64_t block_size;
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
+        error_report("Property '%s' size changed from 0x%" PRIx64 " to 0x%"
+                     PRIx64, VIRTIO_MEM_MEMDEV_PROP, tmp->region_size,
+                     new_region_size);
+        return -EINVAL;
+    }
+    if (tmp->block_size != vmem->block_size) {
+        error_report("Property '%s' changed from 0x%" PRIx64 " to 0x%" PRIx64,
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
+        VMSTATE_UINT64(block_size, VirtIOMEMMigSanityChecks),
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
MST


