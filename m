Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D90C4646C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 03:22:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3385206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 03:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3385206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56154 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfc2D-00013f-1o
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 23:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38724)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yan.y.zhao@intel.com>) id 1hfc1S-0000c4-3o
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 23:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1hfc1Q-0001yn-Vq
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 23:21:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:36846)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1hfc1Q-0001tt-Mj
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 23:21:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Jun 2019 20:21:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,413,1557212400"; d="scan'208";a="182789717"
Received: from joy-desktop.sh.intel.com ([10.239.13.126])
 by fmsmga001.fm.intel.com with ESMTP; 24 Jun 2019 20:21:21 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: pbonzini@redhat.com
Date: Tue, 25 Jun 2019 11:21:18 +0800
Message-Id: <1561432878-13754-1-git-send-email-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.100
Subject: [Qemu-devel] [PATCH v4] memory: assert on out of scope notification
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
Cc: Eric Auger <eric.auger@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is wrong for an entry to have parts out of scope of notifier's range.
assert this condition.

Out of scope mapping/unmapping would cause problem, as in below case:

1. initially there are two notifiers with ranges
0-0xfedfffff, 0xfef00000-0xffffffffffffffff,
IOVAs from 0x3c000000 - 0x3c1fffff is in shadow page table.

2. in vfio, memory_region_register_iommu_notifier() is followed by
memory_region_iommu_replay(), which will first call address space
unmap,
and walk and add back all entries in vtd shadow page table. e.g.
(1) for notifier 0-0xfedfffff,
    IOVAs from 0 - 0xffffffff get unmapped,
    and IOVAs from 0x3c000000 - 0x3c1fffff get mapped
(2) for notifier 0xfef00000-0xffffffffffffffff
    IOVAs from 0 - 0x7fffffffff get unmapped,
    but IOVAs from 0x3c000000 - 0x3c1fffff cannot get mapped back.

Cc: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>

---
v4:
1. modified commit title
2. using "assert" instead of printing warning message
(Eric Auger)

v3:
refined code style and message format

v2:
1. added a local variable entry_end (Eric Auger)
2. using PRIx64 as format for address range in warning message
(Eric Auger)
---
 memory.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/memory.c b/memory.c
index 0a089a7..35e8e77 100644
--- a/memory.c
+++ b/memory.c
@@ -1937,16 +1937,18 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
                               IOMMUTLBEntry *entry)
 {
     IOMMUNotifierFlag request_flags;
+    hwaddr entry_end = entry->iova + entry->addr_mask;
 
     /*
      * Skip the notification if the notification does not overlap
      * with registered range.
      */
-    if (notifier->start > entry->iova + entry->addr_mask ||
-        notifier->end < entry->iova) {
+    if (notifier->start > entry_end || notifier->end < entry->iova) {
         return;
     }
 
+    assert(entry->iova >= notifier->start && entry_end <= notifier->end);
+
     if (entry->perm & IOMMU_RW) {
         request_flags = IOMMU_NOTIFIER_MAP;
     } else {
-- 
2.7.4


