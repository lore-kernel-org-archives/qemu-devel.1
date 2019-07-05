Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2097C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 19:55:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8304E2133F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 19:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qE9W2cIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8304E2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjUIa-0002HO-SS
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 15:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55631)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUEN-0005RV-7X
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUEL-00049o-Tl
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:50:51 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:35417)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hjUEL-000485-Lx
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:50:49 -0400
Received: by mail-wm1-x330.google.com with SMTP id l2so3468596wmg.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 12:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YbMFVYWCeviKweLwBNufDDcBIGFAoGlnFAeGpWGi3rw=;
 b=qE9W2cIL23CVTGW+X14b90rTfKOUhIlYYXjIAK8YD3iypSxlE82hInzAS1Znvz/o1e
 OPoiWMXtE9fJayXuphV0drkNMS+xKkDbUumidYBHuqsMKIC6S5/EgbAISWRdf4xDa42L
 yM6Pxslvny15/Awhl0MtyHhaP4umf1u+cSyu5q3v2ma15lFUGegRi5eNGQb3AqTzaoHj
 vRRKFhBiA4AeXEOeh2Pkw4VoG0oWt4T0TAXsoBtl2IKubot16wQ2QVGgFquPZW3H4hAb
 jdj02khXtZ/OL6evzY+Sl1fw6oLYfe5dXe1QV5yJNI/akI4VuQjR3x9F/HjUI0SfI2MV
 uXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=YbMFVYWCeviKweLwBNufDDcBIGFAoGlnFAeGpWGi3rw=;
 b=lLL763Qi813Vd9pzcw+djlBE4Ark4/yNt5lPRsbrRLFTC7wdQvltki6tg7I7EXMUXz
 wkwJ10MnPqVx2pvYgBYHgPwEvyieA6S5zVsYCqtAU1EaDJzKE6/2PsJ6F9udf7h4J/cQ
 LyL0wVYXZ+QWtD9yte0McsrA051d8vjHGx4ZYr3GmzWxYnAxBPIzWb77w1K/KI58iZ49
 21vTwAyG6uqpKLho/M5Qjlgdfz/AZgmNQHO2KhiSBDAIVF7EcJJjho4PgO+lzNYXhicS
 HuzJbL7fWZ0MGTCk5Zm7tqGF/YukXdGShJxdF+WPMsqEH95r82OG+mrzyWboFuHlxiHD
 qrPQ==
X-Gm-Message-State: APjAAAU22J70nCwKr2QNw1EODlyEuZq2TCYBMtw55nm/HetlSS+C8HEO
 /zpgZRJ8zZs/ZAsFpu3/E4Se3dicRb0=
X-Google-Smtp-Source: APXvYqwEyitwbtNRDOID1X7VFatWnWuQRkvLRpu2pvbM+42pyKqc+olna+JN9w2y5HRLw6DhlavX6A==
X-Received: by 2002:a1c:f519:: with SMTP id t25mr4633720wmh.58.1562356248249; 
 Fri, 05 Jul 2019 12:50:48 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id d10sm11478625wro.18.2019.07.05.12.50.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 12:50:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 21:50:32 +0200
Message-Id: <1562356239-19391-6-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562356239-19391-1-git-send-email-pbonzini@redhat.com>
References: <1562356239-19391-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
Subject: [Qemu-devel] [PULL 05/12] intel_iommu: Fix unexpected unmaps during
 global unmap
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
Cc: Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

This is an replacement work of Yan Zhao's patch:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg625340.html

vtd_address_space_unmap() will do proper page mask alignment to make
sure each IOTLB message will have correct masks for notification
messages (2^N-1), but sometimes it can be expanded to even supercede
the registered range.  That could lead to unexpected UNMAP of already
mapped regions in some other notifiers.

Instead of doing mindless expension of the start address and address
mask, we split the range into smaller ones and guarantee that each
small range will have correct masks (2^N-1) and at the same time we
should also try our best to generate as less IOTLB messages as
possible.

Reported-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Yan Zhao <yan.y.zhao@intel.com>
Message-Id: <20190624091811.30412-3-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/intel_iommu.c | 67 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 26 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 719ce19..de86f53 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3363,11 +3363,28 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
     return vtd_dev_as;
 }
 
+static uint64_t get_naturally_aligned_size(uint64_t start,
+                                           uint64_t size, int gaw)
+{
+    uint64_t max_mask = 1ULL << gaw;
+    uint64_t alignment = start ? start & -start : max_mask;
+
+    alignment = MIN(alignment, max_mask);
+    size = MIN(size, max_mask);
+
+    if (alignment <= size) {
+        /* Increase the alignment of start */
+        return alignment;
+    } else {
+        /* Find the largest page mask from size */
+        return 1ULL << (63 - clz64(size));
+    }
+}
+
 /* Unmap the whole range in the notifier's scope. */
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
 {
-    IOMMUTLBEntry entry;
-    hwaddr size;
+    hwaddr size, remain;
     hwaddr start = n->start;
     hwaddr end = n->end;
     IntelIOMMUState *s = as->iommu_state;
@@ -3388,39 +3405,37 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
     }
 
     assert(start <= end);
-    size = end - start;
+    size = remain = end - start + 1;
 
-    if (ctpop64(size) != 1) {
-        /*
-         * This size cannot format a correct mask. Let's enlarge it to
-         * suite the minimum available mask.
-         */
-        int n = 64 - clz64(size);
-        if (n > s->aw_bits) {
-            /* should not happen, but in case it happens, limit it */
-            n = s->aw_bits;
-        }
-        size = 1ULL << n;
+    while (remain >= VTD_PAGE_SIZE) {
+        IOMMUTLBEntry entry;
+        uint64_t mask = get_naturally_aligned_size(start, remain, s->aw_bits);
+
+        assert(mask);
+
+        entry.iova = start;
+        entry.addr_mask = mask - 1;
+        entry.target_as = &address_space_memory;
+        entry.perm = IOMMU_NONE;
+        /* This field is meaningless for unmap */
+        entry.translated_addr = 0;
+
+        memory_region_notify_one(n, &entry);
+
+        start += mask;
+        remain -= mask;
     }
 
-    entry.target_as = &address_space_memory;
-    /* Adjust iova for the size */
-    entry.iova = n->start & ~(size - 1);
-    /* This field is meaningless for unmap */
-    entry.translated_addr = 0;
-    entry.perm = IOMMU_NONE;
-    entry.addr_mask = size - 1;
+    assert(!remain);
 
     trace_vtd_as_unmap_whole(pci_bus_num(as->bus),
                              VTD_PCI_SLOT(as->devfn),
                              VTD_PCI_FUNC(as->devfn),
-                             entry.iova, size);
+                             n->start, size);
 
-    map.iova = entry.iova;
-    map.size = entry.addr_mask;
+    map.iova = n->start;
+    map.size = size;
     iova_tree_remove(as->iova_tree, &map);
-
-    memory_region_notify_one(n, &entry);
 }
 
 static void vtd_address_space_unmap_all(IntelIOMMUState *s)
-- 
1.8.3.1



