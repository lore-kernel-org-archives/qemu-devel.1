Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E672AC35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:34:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F4521741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="I3N1/6Ow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F4521741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izKp9-0006rK-Tn
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 08:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izKjZ-0007kN-S6
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izKjX-0004qP-3l
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:28:49 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50229)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izKjW-0004eX-RK
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:28:47 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200205132843euoutp02a187a439e7362049af8e18bdfb64e4e5~whKd0Q0hZ0765407654euoutp02f
 for <qemu-devel@nongnu.org>; Wed,  5 Feb 2020 13:28:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200205132843euoutp02a187a439e7362049af8e18bdfb64e4e5~whKd0Q0hZ0765407654euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580909323;
 bh=03o3yCccCxhdD1rH9hs4xTIKjls4LwW1ZtXaMwsmbBM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=I3N1/6OwpPVYBPaWq8O3ey9w6sRbSmafhgssocra/bhaji7/K2VAXai1euvXuY2wG
 KIhPOi392idg3RumMXhbJjqcA4dRQUYYInsvnvGHlQblvfz+sbfgC6XBmBZC9WELWy
 XOOf2GCtpT5f9x0e22gKLqyuxaeCpqtZEddVGCgo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200205132843eucas1p19a8bb84801ce06848c8ac6d9430d829b~whKdli5tB2963229632eucas1p1d;
 Wed,  5 Feb 2020 13:28:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id B6.1E.61286.B03CA3E5; Wed,  5
 Feb 2020 13:28:43 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200205132843eucas1p11260d148e32a9663d0b472ce3ab01cbd~whKdNOnko2967829678eucas1p1R;
 Wed,  5 Feb 2020 13:28:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200205132843eusmtrp2527c02a178f6cf6b09aab6bd2bea66f7~whKdMqp4Z3037330373eusmtrp2V;
 Wed,  5 Feb 2020 13:28:43 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-9e-5e3ac30bcffb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 69.FC.07950.B03CA3E5; Wed,  5
 Feb 2020 13:28:43 +0000 (GMT)
Received: from AMDC3304.digital.local (unknown [106.120.51.21]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200205132842eusmtip28f466d97de5ab873cf56af2d1730c8a2~whKc0jjrB0153301533eusmtip21;
 Wed,  5 Feb 2020 13:28:42 +0000 (GMT)
From: i.kotrasinsk@partner.samsung.com
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 1/9] memory: Add function for finding flat memory ranges
Date: Wed,  5 Feb 2020 14:28:29 +0100
Message-Id: <1580909317-23884-2-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580909317-23884-1-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsWy7djPc7rch63iDM4cVbXYc+Exm8W9mzeZ
 LfZv+8dqMefMAxaL4707WBxYPe5c28Pm8eTaZiaPg+/2MHm833eVzWP7yUlMAaxRXDYpqTmZ
 ZalF+nYJXBktDy8zF3zRrDi0fBJjA+NcuS5GTg4JAROJT6s+snUxcnEICaxglNj+8QELhPOF
 UeJa7xco5zOjRPOOw0wwLU8WnmaGSCxnlLizcBUrXMu7dffYQKrYBNQkdh75zAhiiwhISvzu
 guhgFmhglHh0/SxQgoNDWCBQ4uE1L5AaFgFVibvzZoPV8woESDQcms4IsU1O4ua5TmYQmxOo
 /PKzKWDLJAQes0lsvLWICWSOhICLxMErJRD1whKvjm9hh7BlJP7vnA91db1Ey50dTBC9HYwS
 fSuns0EkrCW+bFjKAjKHWUBTYv0ufYiwo8SL6RtYIMbzSdx4KwgSZgYyJ22bzgwR5pXoaBOC
 qNaT6H5ykwlm67LGR1CdHhJvf0GDagmjxJIdT5knMMrPQti1gJFxFaN4amlxbnpqsWFearle
 cWJucWleul5yfu4mRmBCOP3v+KcdjF8vJR1iFOBgVOLhXTHJMk6INbGsuDL3EKMEB7OSCO95
 faAQb0piZVVqUX58UWlOavEhRmkOFiVxXuNFL2OFBNITS1KzU1MLUotgskwcnFINjCv7Zc80
 S+36o+P1OvvQG4MtHpUbLvW1f5jqu82gK0J9mjjfXxvp1/p7BYM8uVYcaZbr3RU68bxNb727
 R3t0mK338r3Lfy3bxOs/6cfPuRWZ3k//BQW90Z9SdM7gifYx1zwl+e3/9mosU0jndJvlP+3C
 897rXyd/OeIoIjllY+iiXO63dwt3yCuxFGckGmoxFxUnAgAtt91QBAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsVy+t/xe7rch63iDM7P5LPYc+Exm8W9mzeZ
 LfZv+8dqMefMAxaL4707WBxYPe5c28Pm8eTaZiaPg+/2MHm833eVzWP7yUlMAaxRejZF+aUl
 qQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehktDy8zF3zRrDi0
 fBJjA+NcuS5GTg4JAROJJwtPM3cxcnEICSxllHjX84EFIiEj8eP0GjYIW1jiz7UuNoiiT4wS
 L059BitiE1CT2HnkMyOILSIgKfG7C2ISs0ALo8SzJ+1MIAlhAX+Jfae+sIPYLAKqEnfnzQZr
 4BUIkGg4NJ0RYoOcxM1zncwgNqdAoMTlZ1NYQWwhoJrXE68wT2DkW8DIsIpRJLW0ODc9t9hI
 rzgxt7g0L10vOT93EyMwSLcd+7llB2PXu+BDjAIcjEo8vAETLOOEWBPLiitzDzFKcDArifCe
 1wcK8aYkVlalFuXHF5XmpBYfYjQFOmois5Rocj4wgvJK4g1NDc0tLA3Njc2NzSyUxHk7BA7G
 CAmkJ5akZqemFqQWwfQxcXBKNTDar680nZVf735M+NQBNuWVd0xz9M+ac2pqP4me0HMm2kfj
 X5L2kgSF3Q1dBot/KjgIJE9+dJ+tVmPqf9kZLVcfu8ZOOBrufNaIJztvyyXFn03y5/5c+2F/
 Prnm1K4Wfg1ptYv7J/qGqalwcfH/WHa03/BeSV323u8mNa85Q2QObMmYsP9HloMSS3FGoqEW
 c1FxIgBeHjPAaAIAAA==
X-CMS-MailID: 20200205132843eucas1p11260d148e32a9663d0b472ce3ab01cbd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200205132843eucas1p11260d148e32a9663d0b472ce3ab01cbd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200205132843eucas1p11260d148e32a9663d0b472ce3ab01cbd
References: <1580909317-23884-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <CGME20200205132843eucas1p11260d148e32a9663d0b472ce3ab01cbd@eucas1p1.samsung.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.12
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
Cc: peter.maydell@linaro.org,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>, jan.kiszka@siemens.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>

Given an address this lets us find the largest contiguous memory range
at that address.

Signed-off-by: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
---
 include/exec/memory.h | 19 +++++++++++++
 memory.c              | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index e85b7de..ac09221 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1915,6 +1915,25 @@ MemoryRegionSection memory_region_find(MemoryRegion *mr,
                                        hwaddr addr, uint64_t size);
 
 /**
+ * memory_region_find_flat_range: translate an address/size relative to
+ * a MemoryRegion into a FlatRange containing it.
+ *
+ * Returns a #MemoryRegionSection that describes this FlatRange.
+ * It will have the following characteristics:
+ * - @size = 0 iff no containing FlatRange was found
+ * - @mr is non-%NULL iff a containing FlatRange was found
+ *
+ * Remember that in the return value the @offset_within_region is
+ * relative to the returned region (in the .@mr field), not to the
+ * @mr argument.
+ *
+ * @mr: a MemoryRegion within which @addr is a relative address
+ * @addr: start of the area within @as to be searched
+ * @size: size of the area to be searched
+ */
+MemoryRegionSection memory_region_find_flat_range(MemoryRegion *mr,
+                                                  hwaddr addr, uint64_t size);
+/**
  * memory_global_dirty_log_sync: synchronize the dirty log for all memory
  *
  * Synchronizes the dirty page log for all address spaces.
diff --git a/memory.c b/memory.c
index aeaa8dc..0973c44 100644
--- a/memory.c
+++ b/memory.c
@@ -2523,6 +2523,25 @@ static FlatRange *flatview_lookup(FlatView *view, AddrRange addr)
                    sizeof(FlatRange), cmp_flatrange_addr);
 }
 
+static int cmp_flatrange_addr_containing(const void *addr_, const void *fr_)
+{
+    const AddrRange *addr = addr_;
+    const FlatRange *fr = fr_;
+
+    if (int128_le(addr->start, fr->addr.start)) {
+        return -1;
+    } else if (int128_ge(addrrange_end(*addr), addrrange_end(fr->addr))) {
+        return 1;
+    }
+    return 0;
+}
+
+static FlatRange *flatview_lookup_containing(FlatView *view, AddrRange addr)
+{
+    return bsearch(&addr, view->ranges, view->nr,
+                   sizeof(FlatRange), cmp_flatrange_addr_containing);
+}
+
 bool memory_region_is_mapped(MemoryRegion *mr)
 {
     return mr->container ? true : false;
@@ -2532,7 +2551,8 @@ bool memory_region_is_mapped(MemoryRegion *mr)
  * returned region.  It must be called from an RCU critical section.
  */
 static MemoryRegionSection memory_region_find_rcu(MemoryRegion *mr,
-                                                  hwaddr addr, uint64_t size)
+                                                  hwaddr addr,
+                                                  uint64_t size)
 {
     MemoryRegionSection ret = { .mr = NULL };
     MemoryRegion *root;
@@ -2576,6 +2596,50 @@ static MemoryRegionSection memory_region_find_rcu(MemoryRegion *mr,
     return ret;
 }
 
+/*
+ * Same as memory_region_find_flat_range, but it does not add a reference to
+ * the returned region.  It must be called from an RCU critical section.
+ */
+static MemoryRegionSection memory_region_find_flat_range_rcu(MemoryRegion *mr,
+                                                             hwaddr addr,
+                                                             uint64_t size)
+{
+    MemoryRegionSection ret = { .size = int128_zero(), .mr = NULL };
+    MemoryRegion *root;
+    AddressSpace *as;
+    AddrRange range;
+    FlatView *view;
+    FlatRange *fr;
+
+    addr += mr->addr;
+    for (root = mr; root->container; ) {
+        root = root->container;
+        addr += root->addr;
+    }
+
+    as = memory_region_to_address_space(root);
+    if (!as) {
+        return ret;
+    }
+    range = addrrange_make(int128_make64(addr), int128_make64(size));
+
+    view = address_space_to_flatview(as);
+    fr = flatview_lookup_containing(view, range);
+    if (!fr) {
+        return ret;
+    }
+
+    ret.mr = fr->mr;
+    ret.fv = view;
+    range = fr->addr;
+    ret.offset_within_region = fr->offset_in_region;
+    ret.size = range.size;
+    ret.offset_within_address_space = int128_get64(range.start);
+    ret.readonly = fr->readonly;
+    ret.nonvolatile = fr->nonvolatile;
+    return ret;
+}
+
 MemoryRegionSection memory_region_find(MemoryRegion *mr,
                                        hwaddr addr, uint64_t size)
 {
@@ -2588,6 +2652,19 @@ MemoryRegionSection memory_region_find(MemoryRegion *mr,
     return ret;
 }
 
+MemoryRegionSection memory_region_find_flat_range(MemoryRegion *mr,
+                                                  hwaddr addr, uint64_t size)
+{
+    MemoryRegionSection ret;
+    rcu_read_lock();
+    ret = memory_region_find_flat_range_rcu(mr, addr, size);
+    if (ret.mr) {
+        memory_region_ref(ret.mr);
+    }
+    rcu_read_unlock();
+    return ret;
+}
+
 bool memory_region_present(MemoryRegion *container, hwaddr addr)
 {
     MemoryRegion *mr;
-- 
2.7.4


