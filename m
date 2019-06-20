Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49437C48BE3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 13:21:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2366B206E0
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 13:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2366B206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47696 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdx0M-0004qn-1q
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 09:21:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51218)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peterx@redhat.com>) id 1hdwxB-0002uC-LA
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hdwuq-0004oZ-Uw
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:15:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53750)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hdwgI-0007or-QD
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:00:46 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D66D43001D50;
 Thu, 20 Jun 2019 13:00:13 +0000 (UTC)
Received: from xz-x1 (ovpn-12-68.pek2.redhat.com [10.72.12.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B92519C4F;
 Thu, 20 Jun 2019 13:00:00 +0000 (UTC)
Date: Thu, 20 Jun 2019 20:59:55 +0800
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190620125955.GB9657@xz-x1>
References: <1560934185-14152-1-git-send-email-yan.y.zhao@intel.com>
 <39c4c32b-e34a-8d8f-abbc-ab346ec5bed7@redhat.com>
 <20190620040230.GB9073@xz-x1>
 <6829b139-3eab-449e-04d6-07f1e381316d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6829b139-3eab-449e-04d6-07f1e381316d@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 20 Jun 2019 13:00:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] memory: do not do out of bound notification
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
Cc: Auger Eric <eric.auger@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 20, 2019 at 10:35:29AM +0200, Paolo Bonzini wrote:
> On 20/06/19 06:02, Peter Xu wrote:
> > Seems workable, to be explicit - we can even cut it into chunks with
> > different size to be efficient.
> 
> Yes, this is not hard (completely untested):
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 44b1231157..541538bc6c 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3388,39 +3388,34 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>      }
>  
>      assert(start <= end);
> -    size = end - start;
> +    while (end > start) {
> +        size = end - start;
> +        /* Only keep the lowest bit of either size or start.  */
> +        size = MIN(size & -size, start & -start);

I feel like this can be problematic.  I'm imaging:

start=0x1000_0000, size=0x1000_1000

This will get size=0x1000 but actually we can do size=0x1000_0000 as
the first.

> +        /* Should not happen, but limit to address width too just in case */
> +        size = MIN(size, 1ULL << s->aw_bits);
>  
> -    if (ctpop64(size) != 1) {
> -        /*
> -         * This size cannot format a correct mask. Let's enlarge it to
> -         * suite the minimum available mask.
> -         */
> -        int n = 64 - clz64(size);
> -        if (n > s->aw_bits) {
> -            /* should not happen, but in case it happens, limit it */
> -            n = s->aw_bits;
> -        }
> -        size = 1ULL << n;
> -    }
> +        assert((start & (size - 1)) == 0);
>  
> -    entry.target_as = &address_space_memory;
> -    /* Adjust iova for the size */
> -    entry.iova = n->start & ~(size - 1);
> -    /* This field is meaningless for unmap */
> -    entry.translated_addr = 0;
> -    entry.perm = IOMMU_NONE;
> -    entry.addr_mask = size - 1;
> +        entry.target_as = &address_space_memory;
> +        entry.iova = start;
> +        /* This field is meaningless for unmap */
> +        entry.translated_addr = 0;
> +        entry.perm = IOMMU_NONE;
> +        entry.addr_mask = size - 1;

(some of the fields can be moved out of loop because they are
 constants)

>  
> -    trace_vtd_as_unmap_whole(pci_bus_num(as->bus),
> -                             VTD_PCI_SLOT(as->devfn),
> -                             VTD_PCI_FUNC(as->devfn),
> -                             entry.iova, size);
> +        trace_vtd_as_unmap_whole(pci_bus_num(as->bus),
> +                                 VTD_PCI_SLOT(as->devfn),
> +                                 VTD_PCI_FUNC(as->devfn),
> +                                 entry.iova, size);

Can move this out because this is a trace only so we don't have
restriction on mask?

>  
> -    map.iova = entry.iova;
> -    map.size = entry.addr_mask;
> -    iova_tree_remove(as->iova_tree, &map);
> +        map.iova = entry.iova;
> +        map.size = entry.addr_mask;
> +        iova_tree_remove(as->iova_tree, &map);

Same here?

>  
> -    memory_region_notify_one(n, &entry);
> +        memory_region_notify_one(n, &entry);
> +        start += size;
> +    }
>  }
>  
>  static void vtd_address_space_unmap_all(IntelIOMMUState *s)
> 
> 
> Yan,
> 
> if something like this works for you, let me know and I will submit it
> as a proper patch.
> 
> Paolo

Since during review I'm thinking how to generate a correct sequence of
these masks... here's my try below with above issues fixed... :)

I've tried compile but not tested.  Yan can test it, or I can do it
too tomorrow after I find some machines.

Thanks,

------------------------------------------------------------
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 44b1231157..cfbd225f0a 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3363,11 +3363,32 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
     return vtd_dev_as;
 }

+static uint64_t vtd_get_next_mask(uint64_t start, uint64_t size, int gaw)
+{
+    /* Tries to find smallest mask from start first */
+    uint64_t rmask = start & -start, max_mask = 1ULL << gaw;
+
+    assert(size && gaw > 0 && gaw < 64);
+
+    /* Zero start, or too big */
+    if (!rmask || rmask > max_mask) {
+        rmask = max_mask;
+    }
+
+    /* If the start mask worked, then use it */
+    if (rmask <= size) {
+        return rmask;
+    }
+
+    /* Find the largest page mask from size */
+    return 1ULL << (63 - clz64(size));
+}
+
 /* Unmap the whole range in the notifier's scope. */
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
 {
     IOMMUTLBEntry entry;
-    hwaddr size;
+    hwaddr size, remain;
     hwaddr start = n->start;
     hwaddr end = n->end;
     IntelIOMMUState *s = as->iommu_state;
@@ -3388,39 +3409,28 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
     }

     assert(start <= end);
-    size = end - start;
-
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
-    }
-
+    size = remain = end - start;
     entry.target_as = &address_space_memory;
-    /* Adjust iova for the size */
-    entry.iova = n->start & ~(size - 1);
+    entry.perm = IOMMU_NONE;
     /* This field is meaningless for unmap */
     entry.translated_addr = 0;
-    entry.perm = IOMMU_NONE;
-    entry.addr_mask = size - 1;
+
+    while (remain) {
+        uint64_t mask = vtd_get_next_mask(start, remain, s->aw_bits);
+
+        entry.iova = start;
+        entry.addr_mask = mask - 1;
+        memory_region_notify_one(n, &entry);
+    }

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
------------------------------------------------------------

Regards,

-- 
Peter Xu

