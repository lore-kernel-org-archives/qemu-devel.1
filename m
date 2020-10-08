Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC1BC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 08:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80798215A4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 08:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QG+UsuPg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80798215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQROx-0004eB-HN
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 04:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kQRKH-0007Zc-Bx
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 04:31:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58877)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kQRKF-0006Tr-BH
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 04:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602145858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9zvOsDpz0nGx5qNfhvymj/1LqA2ThYcDioxz90I6yh4=;
 b=QG+UsuPgSKCdn7vyn1B9PRtvjmN+DcLT/1kyGm+zGWJ3oBPjSoIzyO22VgvWFfnfA8RaRh
 SISeVHbEPUCMn8oPQUo74d0/ayn2wgqYs5boT9lYl83rmCl4W7uzk4gY+KAT+iSgyz8Vvr
 D0V2i4SoHq6m+xNu+fXxRpvDWmdliqM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-UHyC_S8XPrOAGvfDMIr_mA-1; Thu, 08 Oct 2020 04:30:54 -0400
X-MC-Unique: UHyC_S8XPrOAGvfDMIr_mA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FD8381EE70;
 Thu,  8 Oct 2020 08:30:53 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-112.ams2.redhat.com [10.36.114.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D4675C1C4;
 Thu,  8 Oct 2020 08:30:47 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/6] virtio-mem: Probe THP size to determine default block
 size
Date: Thu,  8 Oct 2020 10:30:26 +0200
Message-Id: <20201008083029.9504-4-david@redhat.com>
In-Reply-To: <20201008083029.9504-1-david@redhat.com>
References: <20201008083029.9504-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Let's allow a minimum block size of 1 MiB in all configurations. Select
the default block size based on
- The page size of the memory backend.
- The THP size if the memory backend size corresponds to the real host
  page size.
- The global minimum of 1 MiB.
and warn if something smaller is configured by the user.

VIRTIO_MEM only supports Linux (depends on LINUX), so we can probe the
THP size unconditionally.

For now we only support virtio-mem on x86-64 - there isn't a user-visible
change (x86-64 only supports 2 MiB THP on the PMD level) - the default
was, and will be 2 MiB.

If we ever have THP on the PUD level (e.g., 1 GiB THP on x86-64), we
expect it to be more transparent - e.g., to only optimize fully populated
ranges unless explicitly told /configured otherwise (in contrast to PMD
THP).

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem.c | 105 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 101 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 461ac68ee8..655824ff81 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -33,10 +33,83 @@
 #include "trace.h"
 
 /*
- * Use QEMU_VMALLOC_ALIGN, so no THP will have to be split when unplugging
- * memory (e.g., 2MB on x86_64).
+ * Let's not allow blocks smaller than 1 MiB, for example, to keep the tracking
+ * bitmap small.
  */
-#define VIRTIO_MEM_MIN_BLOCK_SIZE ((uint32_t)QEMU_VMALLOC_ALIGN)
+#define VIRTIO_MEM_MIN_BLOCK_SIZE ((uint32_t)(1 * MiB))
+
+#if defined(__x86_64__) || defined(__arm__) || defined(__aarch64__) || \
+    defined(__powerpc64__)
+#define VIRTIO_MEM_DEFAULT_THP_SIZE ((uint32_t)(2 * MiB))
+#else
+        /* fallback to 1 MiB (e.g., the THP size on s390x) */
+#define VIRTIO_MEM_DEFAULT_THP_SIZE VIRTIO_MEM_MIN_BLOCK_SIZE
+#endif
+
+/*
+ * We want to have a reasonable default block size such that
+ * 1. We avoid splitting THPs when unplugging memory, which degrades
+ *    performance.
+ * 2. We avoid placing THPs for plugged blocks that also cover unplugged
+ *    blocks.
+ *
+ * The actual THP size might differ between Linux kernels, so we try to probe
+ * it. In the future (if we ever run into issues regarding 2.), we might want
+ * to disable THP in case we fail to properly probe the THP size, or if the
+ * block size is configured smaller than the THP size.
+ */
+static uint32_t thp_size;
+
+#define HPAGE_PMD_SIZE_PATH "/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"
+static uint32_t virtio_mem_thp_size(void)
+{
+    gchar *content = NULL;
+    const char *endptr;
+    uint64_t tmp;
+
+    if (thp_size) {
+        return thp_size;
+    }
+
+    /*
+     * Try to probe the actual THP size, fallback to (sane but eventually
+     * incorrect) default sizes.
+     */
+    if (g_file_get_contents(HPAGE_PMD_SIZE_PATH, &content, NULL, NULL) &&
+        !qemu_strtou64(content, &endptr, 0, &tmp) &&
+        (!endptr || *endptr == '\n')) {
+        /*
+         * Sanity-check the value, if it's too big (e.g., aarch64 with 64k base
+         * pages) or weird, fallback to something smaller.
+         */
+        if (!tmp || !is_power_of_2(tmp) || tmp > 16 * MiB) {
+            warn_report("Read unsupported THP size: %" PRIx64, tmp);
+        } else {
+            thp_size = tmp;
+        }
+    }
+
+    if (!thp_size) {
+        thp_size = VIRTIO_MEM_DEFAULT_THP_SIZE;
+        warn_report("Could not detect THP size, falling back to %" PRIx64
+                    "  MiB.", thp_size / MiB);
+    }
+
+    g_free(content);
+    return thp_size;
+}
+
+static uint64_t virtio_mem_default_block_size(RAMBlock *rb)
+{
+    const uint64_t page_size = qemu_ram_pagesize(rb);
+
+    /* We can have hugetlbfs with a page size smaller than the THP size. */
+    if (page_size == qemu_real_host_page_size) {
+        return MAX(page_size, virtio_mem_thp_size());
+    }
+    return MAX(page_size, VIRTIO_MEM_MIN_BLOCK_SIZE);
+}
+
 /*
  * Size the usable region bigger than the requested size if possible. Esp.
  * Linux guests will only add (aligned) memory blocks in case they fully
@@ -443,10 +516,23 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
     rb = vmem->memdev->mr.ram_block;
     page_size = qemu_ram_pagesize(rb);
 
+    /*
+     * If the block size wasn't configured by the user, use a sane default. This
+     * allows using hugetlbfs backends of any page size without manual
+     * intervention.
+     */
+    if (!vmem->block_size) {
+        vmem->block_size = virtio_mem_default_block_size(rb);
+    }
+
     if (vmem->block_size < page_size) {
         error_setg(errp, "'%s' property has to be at least the page size (0x%"
                    PRIx64 ")", VIRTIO_MEM_BLOCK_SIZE_PROP, page_size);
         return;
+    } else if (vmem->block_size < virtio_mem_default_block_size(rb)) {
+        warn_report("'%s' property is smaller than the default block size (%"
+                    PRIx64 " MiB)", VIRTIO_MEM_BLOCK_SIZE_PROP,
+                    virtio_mem_default_block_size(rb) / MiB);
     } else if (!QEMU_IS_ALIGNED(vmem->requested_size, vmem->block_size)) {
         error_setg(errp, "'%s' property has to be multiples of '%s' (0x%" PRIx64
                    ")", VIRTIO_MEM_REQUESTED_SIZE_PROP,
@@ -742,6 +828,18 @@ static void virtio_mem_get_block_size(Object *obj, Visitor *v, const char *name,
     const VirtIOMEM *vmem = VIRTIO_MEM(obj);
     uint64_t value = vmem->block_size;
 
+    /*
+     * If not configured by the user (and we're not realized yet), use the
+     * default block size we would use with the current memory backend.
+     */
+    if (!value) {
+        if (vmem->memdev && memory_region_is_ram(&vmem->memdev->mr)) {
+            value = virtio_mem_default_block_size(vmem->memdev->mr.ram_block);
+        } else {
+            value = virtio_mem_thp_size();
+        }
+    }
+
     visit_type_size(v, name, &value, errp);
 }
 
@@ -821,7 +919,6 @@ static void virtio_mem_instance_init(Object *obj)
 {
     VirtIOMEM *vmem = VIRTIO_MEM(obj);
 
-    vmem->block_size = VIRTIO_MEM_MIN_BLOCK_SIZE;
     notifier_list_init(&vmem->size_change_notifiers);
     vmem->precopy_notifier.notify = virtio_mem_precopy_notify;
 
-- 
2.26.2


