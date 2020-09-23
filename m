Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90134C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 11:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1282C20663
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 11:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONMItf1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1282C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL3CU-0004J8-4D
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 07:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kL37H-0008LT-U7
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 07:39:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25644
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kL37C-0006tt-Qo
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 07:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600861152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=clGgZC2wlrYw0qQcMPAENuXwJPMUEhiR/ZdvV3W408E=;
 b=ONMItf1MMK8qhu13zLERMxAhgJwPEuKZ/uDnu8mTh8z9Mxs10DT7A/GauLtGGVEk+T4Que
 uPw7eaZGmvnKgyWgDHc5IY3z4onQZRazBmmnsHlmFXUqTovwHqAeVzeSG04/u7AMv+N9CS
 nX3mj3d825NmYhqRo4eX2y1LyUIRL4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-5WTCmKGaOpK7-V5zXn4Uxg-1; Wed, 23 Sep 2020 07:39:11 -0400
X-MC-Unique: 5WTCmKGaOpK7-V5zXn4Uxg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D45D11007464;
 Wed, 23 Sep 2020 11:39:09 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-54.ams2.redhat.com [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D3BF78816;
 Wed, 23 Sep 2020 11:39:05 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/5] virtio-mem: Probe THP size to determine default block
 size
Date: Wed, 23 Sep 2020 13:38:56 +0200
Message-Id: <20200923113900.72718-2-david@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.61; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 03:55:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Let's allow a minimum block size of 1 MiB in all configurations. Use
a default block size based on the THP size, and warn if something
smaller is configured by the user.

VIRTIO_MEM only supports Linux (depends on LINUX), so we can probe the
THP size unconditionally.

For now we only support virtio-mem on x86-64 - there isn't a user-visiable
change (x86-64 only supports 2 MiB THP on the PMD level) - the default
was, and will be 2 MiB.

If we ever have THP on the PUD level (e.g., 1 GiB THP on x86-64), we
expect to have a trigger to explicitly opt-in for the new THP granularity.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem.c | 82 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 8fbec77ccc..58098686ee 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -33,10 +33,70 @@
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
+static uint32_t default_block_size;
+
+#define HPAGE_PMD_SIZE_PATH "/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"
+static uint32_t virtio_mem_default_block_size(void)
+{
+    gchar *content = NULL;
+    const char *endptr;
+    uint64_t tmp;
+
+    if (default_block_size) {
+        return default_block_size;
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
+            warn_report("Detected a THP size of %" PRIx64
+                        " MiB, falling back to 1 MiB.", tmp / MiB);
+            default_block_size = 1 * MiB;
+        } else {
+            default_block_size = tmp;
+        }
+    } else {
+#if defined(__x86_64__) || defined(__arm__) || defined(__aarch64__) || \
+    defined(__powerpc64__)
+        default_block_size = 2 * MiB;
+#else
+        /* fallback to 1 MiB (e.g., the THP size on s390x) */
+        default_block_size = 1 * MiB;
+#endif
+        warn_report("Could not detect THP size, falling back to %" PRIx64
+                    "  MiB.", default_block_size / MiB);
+    }
+
+    g_free(content);
+    return default_block_size;
+}
+
 /*
  * Size the usable region bigger than the requested size if possible. Esp.
  * Linux guests will only add (aligned) memory blocks in case they fully
@@ -437,6 +497,15 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
     rb = vmem->memdev->mr.ram_block;
     page_size = qemu_ram_pagesize(rb);
 
+    /*
+     * If the block size wasn't configured by the user, use a sane default. This
+     * allows using hugetlbfs backends with a pagesize bigger than the detected
+     * THP size without manual intervention/configuration.
+     */
+    if (!vmem->block_size) {
+        vmem->block_size = MAX(page_size, virtio_mem_default_block_size());
+    }
+
     if (vmem->block_size < page_size) {
         error_setg(errp, "'%s' property has to be at least the page size (0x%"
                    PRIx64 ")", VIRTIO_MEM_BLOCK_SIZE_PROP, page_size);
@@ -760,6 +829,12 @@ static void virtio_mem_set_block_size(Object *obj, Visitor *v, const char *name,
         error_setg(errp, "'%s' property has to be a power of two", name);
         return;
     }
+
+    if (value < virtio_mem_default_block_size()) {
+        warn_report("'%s' property is smaller than the default block size "
+                    "(detected THP size) of %" PRIx64 " MiB", name,
+                    virtio_mem_default_block_size() / MiB);
+    }
     vmem->block_size = value;
 }
 
@@ -810,7 +885,6 @@ static void virtio_mem_instance_init(Object *obj)
 {
     VirtIOMEM *vmem = VIRTIO_MEM(obj);
 
-    vmem->block_size = VIRTIO_MEM_MIN_BLOCK_SIZE;
     notifier_list_init(&vmem->size_change_notifiers);
     vmem->precopy_notifier.notify = virtio_mem_precopy_notify;
 
-- 
2.26.2


