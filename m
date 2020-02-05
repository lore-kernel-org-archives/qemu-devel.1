Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F93C33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:37:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74E0F2082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IlFZSBp8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E0F2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izH7o-0005yQ-KI
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 04:37:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izH3f-0000hF-Sv
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izH3e-0004xI-4J
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:19 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41525)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izH3d-0004T7-Pm
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:18 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200205093315euoutp02481d807c3c8de208aa0fce5275384064~wd83QouJs1428814288euoutp02b
 for <qemu-devel@nongnu.org>; Wed,  5 Feb 2020 09:33:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200205093315euoutp02481d807c3c8de208aa0fce5275384064~wd83QouJs1428814288euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580895195;
 bh=VI8ZZsYihdmS6uzzMRU8CCMFMKBACwzdMDlOnQ0OCcE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IlFZSBp8C1ioTsnT+EIDWeNrj6VY9CSdAM8I06Gr57O/Ue9D6+hF7LjBBBDHS6RuE
 Nq2NdIEE17FmXgDViEB0ni4jQ893CfSWNd1yQJpWTJHgOrR82bygY82TitHpw8k2SW
 FGAWHAqNHh9uFI3WIXSoZVus+JaJhFbSSbPRurgs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200205093314eucas1p1e652240bb7dc2f6f398ec5965bbffc3c~wd83CLIxv3063130631eucas1p1S;
 Wed,  5 Feb 2020 09:33:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id CC.8A.60698.ADB8A3E5; Wed,  5
 Feb 2020 09:33:14 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200205093314eucas1p15a5cc16c92fd8004343acb1fd551f42a~wd82piy9L3273232732eucas1p1R;
 Wed,  5 Feb 2020 09:33:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200205093314eusmtrp1cb67ae381efaf7f721ba2b96b24f08c9~wd82pDnt11029010290eusmtrp1S;
 Wed,  5 Feb 2020 09:33:14 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-bd-5e3a8bdada91
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 6D.8D.08375.ADB8A3E5; Wed,  5
 Feb 2020 09:33:14 +0000 (GMT)
Received: from AMDC3304.digital.local (unknown [106.120.51.21]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200205093314eusmtip267a15f48e03480c51a79618a064617a4~wd82YhnTK3043930439eusmtip2B;
 Wed,  5 Feb 2020 09:33:14 +0000 (GMT)
From: i.kotrasinsk@partner.samsung.com
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 1/9] memory: Add function for finding flat memory ranges
Date: Wed,  5 Feb 2020 10:32:57 +0100
Message-Id: <1580895185-24341-2-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580895185-24341-1-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWy7djPc7q3uq3iDHZe0LbYc+Exm8X+bf9Y
 LeacecBicbx3B4sDi8eda3vYPJ5c28zkcfDdHiaP9/uusgWwRHHZpKTmZJalFunbJXBlLGhc
 x1bwQrPic/8SxgbGiXJdjJwcEgImEn++XWPpYuTiEBJYwSixtfk/M4TzhVHiy9sVrBDOZ0aJ
 2U+/MMO0HOm6xwiRWM4osWvZc3a4llWtb9lBqtgE1CR2HvnMCGKLCEhK/O46DdbNLJAh8XxW
 N5gtLBAosXNTHxOIzSKgKtH2axZYPa9AgMSpL41sENvkJG6e6wSr5wSq3/TpIxvIMgmBy2wS
 VyefZIIocpHYdGITlC0s8er4FnYIW0bi9OQeFgi7XqLlzg4miOYORom+ldOhNlhLfNmwFKiI
 A+g6TYn1u/Qhwo4Sq+6cZwYJSwjwSdx4KwhxP5/EpG3TocK8Eh1tQhDVehLdT24ywWxd1vgI
 aquHxLmD79gg4bOEUWLR5qOMExjlZyEsW8DIuIpRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93
 EyMwAZz+d/zrDsZ9f5IOMQpwMCrx8AZMsIwTYk0sK67MPcQowcGsJMJ7Xh8oxJuSWFmVWpQf
 X1Sak1p8iFGag0VJnNd40ctYIYH0xJLU7NTUgtQimCwTB6dUA6P24wjDef1Wcj9Nj21os1vm
 u6Y4uTLx795yR84klaoP0cFPNvLvPrRj0RzrwIC04+y2p/U3nvm4MbPubojIKd8HEec09uoe
 EC7r/bR6+SWrJXse3vapnmM++1efZbNaEfOLTUy8pyeFM5yvCLfuW2WucP/66vxImwnXm9ft
 nhYS8/Litsrqx5pKLMUZiYZazEXFiQD3F0Gb/AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t/xe7q3uq3iDK7MErPYc+Exm8X+bf9Y
 LeacecBicbx3B4sDi8eda3vYPJ5c28zkcfDdHiaP9/uusgWwROnZFOWXlqQqZOQXl9gqRRta
 GOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlLGhcx1bwQrPic/8SxgbGiXJdjJwc
 EgImEke67jF2MXJxCAksZZToefabFSIhI/Hj9Bo2CFtY4s+1LjaIok+MEutndzGBJNgE1CR2
 HvnMCGKLCEhK/O46zQxiMwtkSeycfR+sRljAX+LCgh3sIDaLgKpE269ZYPW8AgESp740Qi2Q
 k7h5rhOsl1MgUGLTp49gcSGgmmtfv7JOYORbwMiwilEktbQ4Nz232FCvODG3uDQvXS85P3cT
 IzActx37uXkH46WNwYcYBTgYlXh4V0yyjBNiTSwrrsw9xCjBwawkwnteHyjEm5JYWZValB9f
 VJqTWnyI0RToqInMUqLJ+cBYySuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE
 08fEwSnVwGiUqMmQ/KxypwyP+qdUzv+piVb120x3rlVsZTyQsv4Li8bmXMajr3+7m5923uPG
 86FK/Oi6jesyJZ0uljm4tMVPsDoider4Z86VjnN27/H4LPxRa/mlow8Mrn/i+pDE+LVo8+E3
 vXm7NOtnH+14ombbx9v7Ju8XxwtlkUdHIjtOus+6aHC7xFSJpTgj0VCLuag4EQCePDhwXQIA
 AA==
X-CMS-MailID: 20200205093314eucas1p15a5cc16c92fd8004343acb1fd551f42a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200205093314eucas1p15a5cc16c92fd8004343acb1fd551f42a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200205093314eucas1p15a5cc16c92fd8004343acb1fd551f42a
References: <1580895185-24341-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <CGME20200205093314eucas1p15a5cc16c92fd8004343acb1fd551f42a@eucas1p1.samsung.com>
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
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>, pbonzini@redhat.com
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
index aeaa8dc..e9f37e7 100644
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
+    MemoryRegionSection ret = { .mr = NULL, .size = 0 };
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


