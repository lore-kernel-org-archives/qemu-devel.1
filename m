Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAB7C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:13:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2955B2080C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2955B2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45102 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdt8T-0004MC-A4
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 05:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35916)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hdsjG-0006s7-26
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hdsXa-0007Sh-VI
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:35:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45117)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hdsXa-0007Qh-Mc
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:35:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so2042349wre.12
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 01:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y3Lz0C1nlETW71iyVwPlRcMb8BSYrpmr3Q/8SBuE/z8=;
 b=GJbFx2esNahxxw8nwbeUOoul0o42if6ojsEMLEAC+x5wR4SmwoOp2PH/wx06AXliMZ
 tzahJzSlRh4hUiYI9n/i885YA9BUA7qNLXyiG5b9QguQpoba8Bp2Ukt4JsdXyxZYXjoC
 vyp0i2QVJD24esza3ZcfvWF9dTgjR6v04fJhWPxetV5Z7gWPqRk3ocyfpSnJhvjQ8j89
 mk9HdvtZPi4nGf1OJb3XMMzCPdO4G0f9UJkqAni9GrzoQaQ0dfZJiXKxfIxo9UJT3QvV
 n9Mx/VAgg8sIwatwOy6kRGFNwwUJHktbzmMjiAVMZhtSOtc8x+/eQ9nfzA6UXRyPNkl6
 m46Q==
X-Gm-Message-State: APjAAAWoxsM7PeSc3SbrfKxoSp0ku+l6mTSJse3GQNwzxWrvprvRpX9h
 o6hvhYGFa7TjaXP/UFnj5GNf63esZnw=
X-Google-Smtp-Source: APXvYqwkCZPIb3ymMf4up+V2Zbi4694aUOJW6w1tzlHaVJdEfpEWKaW4V+IhpZkvwCvLm7s0T6Tlqg==
X-Received: by 2002:a5d:5186:: with SMTP id k6mr79061324wrv.30.1561019729356; 
 Thu, 20 Jun 2019 01:35:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7822:aa18:a9d8:39ab?
 ([2001:b07:6468:f312:7822:aa18:a9d8:39ab])
 by smtp.gmail.com with ESMTPSA id t198sm4983601wmt.2.2019.06.20.01.35.28
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 01:35:28 -0700 (PDT)
To: Peter Xu <peterx@redhat.com>, Auger Eric <eric.auger@redhat.com>
References: <1560934185-14152-1-git-send-email-yan.y.zhao@intel.com>
 <39c4c32b-e34a-8d8f-abbc-ab346ec5bed7@redhat.com>
 <20190620040230.GB9073@xz-x1>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6829b139-3eab-449e-04d6-07f1e381316d@redhat.com>
Date: Thu, 20 Jun 2019 10:35:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190620040230.GB9073@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
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
Cc: Yan Zhao <yan.y.zhao@intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/06/19 06:02, Peter Xu wrote:
> Seems workable, to be explicit - we can even cut it into chunks with
> different size to be efficient.

Yes, this is not hard (completely untested):

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 44b1231157..541538bc6c 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3388,39 +3388,34 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
     }
 
     assert(start <= end);
-    size = end - start;
+    while (end > start) {
+        size = end - start;
+        /* Only keep the lowest bit of either size or start.  */
+        size = MIN(size & -size, start & -start);
+        /* Should not happen, but limit to address width too just in case */
+        size = MIN(size, 1ULL << s->aw_bits);
 
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
+        assert((start & (size - 1)) == 0);
 
-    entry.target_as = &address_space_memory;
-    /* Adjust iova for the size */
-    entry.iova = n->start & ~(size - 1);
-    /* This field is meaningless for unmap */
-    entry.translated_addr = 0;
-    entry.perm = IOMMU_NONE;
-    entry.addr_mask = size - 1;
+        entry.target_as = &address_space_memory;
+        entry.iova = start;
+        /* This field is meaningless for unmap */
+        entry.translated_addr = 0;
+        entry.perm = IOMMU_NONE;
+        entry.addr_mask = size - 1;
 
-    trace_vtd_as_unmap_whole(pci_bus_num(as->bus),
-                             VTD_PCI_SLOT(as->devfn),
-                             VTD_PCI_FUNC(as->devfn),
-                             entry.iova, size);
+        trace_vtd_as_unmap_whole(pci_bus_num(as->bus),
+                                 VTD_PCI_SLOT(as->devfn),
+                                 VTD_PCI_FUNC(as->devfn),
+                                 entry.iova, size);
 
-    map.iova = entry.iova;
-    map.size = entry.addr_mask;
-    iova_tree_remove(as->iova_tree, &map);
+        map.iova = entry.iova;
+        map.size = entry.addr_mask;
+        iova_tree_remove(as->iova_tree, &map);
 
-    memory_region_notify_one(n, &entry);
+        memory_region_notify_one(n, &entry);
+        start += size;
+    }
 }
 
 static void vtd_address_space_unmap_all(IntelIOMMUState *s)


Yan,

if something like this works for you, let me know and I will submit it
as a proper patch.

Paolo

