Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E12EC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:50:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C4E0216E3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEzBGU2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4E0216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjV9i-0004BJ-0l
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 16:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34184)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUk9-0004Le-W3
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:23:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUk4-0002na-1U
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:23:39 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:54295)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hjUjz-0002hm-UF
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:23:33 -0400
Received: by mail-wm1-x334.google.com with SMTP id p74so7245931wme.4
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 13:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YbMFVYWCeviKweLwBNufDDcBIGFAoGlnFAeGpWGi3rw=;
 b=KEzBGU2Ou3kgfZGkF5Ya6OSGrCnDBMFvgtGMofrjM19PvoAGDM5ohTQSiFJkGVYoYo
 +mzClx+Z2+zpwSekFPBKvUjDxma8KQNYa0m2wTxPwcr09d0kL8n6+xrOSdwBn1wW1Qf4
 tjKd3j7UPady/nKffKQD1CKOoW+iPshGiLv7C7W7OdLfsUIh6rDH5kZTDUh5yumGY+ep
 o/8Xv6O40dwpmHC8r7lA97uSU1n6zezCBGX441bItQ6hanmGWCBJ+oKCjYOiQ955nStU
 Lu5lQfiD5TbuMgoHgYbRamozwDskp7LCNyTj3PENMYWlVBkcf5dIN8qYNyvZCkP9FdB+
 L/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=YbMFVYWCeviKweLwBNufDDcBIGFAoGlnFAeGpWGi3rw=;
 b=sOZHiUVqvwxZFhJUSyprk5D4BZ3NBMytJ7h1DXMbPXnSjPRTVKS1cR9+viwv+GpTwo
 mKQZrpqlrzZLar4S4rhEvnJVl5fYpRJBLQ07E8iDhqss1oFTUzsmCQqCTfTl2uhhD+0x
 U6QVXtYLNOAJR+fJU2VRRwXpZd2V9y8h9AoOpclOrGsQxWHioImCgtAv0j0mCS0ARNnk
 C80jcVn+gVVBmIzZoHqhtq6/xs1vt41eJzVqV5+aSjlALNY7cp1+QKlpWAY4UxCxPjBl
 4USurWG7xm+oWrZSwd6YmZxeXY7jjtD0QQNKo5Yia/jmWh3S0pXWAGrks+lTdB0MHkOh
 91ZQ==
X-Gm-Message-State: APjAAAUkN+9+sHKbdZfi9AS8OwBDt+naWpcbzJ17Z3wVN0PC37N6DSrI
 PBel3ZALMVstQkm0TAonLuRq6+fcmMk=
X-Google-Smtp-Source: APXvYqymIRyzAL4rxwdCgo+OY1nYDJfeRjvyeW+ERyP9srQfUiOT1oQuR73YkMCqDve8ny1ntixC+Q==
X-Received: by 2002:a7b:c776:: with SMTP id x22mr4477030wmk.55.1562358208303; 
 Fri, 05 Jul 2019 13:23:28 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id v23sm3035875wmj.32.2019.07.05.13.23.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 13:23:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 22:23:15 +0200
Message-Id: <1562358202-28008-6-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562358202-28008-1-git-send-email-pbonzini@redhat.com>
References: <1562358202-28008-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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



