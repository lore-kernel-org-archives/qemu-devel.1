Received: from eggs.gnu.org ([2001:4830:134:3::10]:37018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1diDnK-0004e8-Ah
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 01:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1diDnF-0008Mv-E6
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 01:56:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1diDnF-0008MK-7d
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 01:56:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DEB777CBA8
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 05:56:31 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu, 17 Aug 2017 13:56:14 +0800
Message-Id: <1502949374-3061-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11] intel_iommu: fix missing BQL in pt
 fast path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

In vtd_switch_address_space() we did the memory region switch, however
it's possible that the caller of it has not taken the BQL at all. Make
sure we have it.

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Jason Wang <jasowang@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---

Paolo: I noticed this qemu_mutex_iothread_locked() function, which might
simplify the fix, so I decided to use it. Using bottom half should be ok
as well, but after a second thought it can be complicated: consider the
case when guest firstly triggered the pt fast path then quickly
re-enables the IOMMU region before the bottom half being executed. Then
looks like we need special care on the sync of bottom half task as well.
That's over-complicated I guess (if with that, I'd prefer to remove the
pt fast path since it's even not really the default path when pt is
used...). Please let me know if you don't think so.
---
 hw/i386/intel_iommu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index a7bf87a..3a5bb0b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -957,6 +957,8 @@ static bool vtd_dev_pt_enabled(VTDAddressSpace *as)
 static bool vtd_switch_address_space(VTDAddressSpace *as)
 {
     bool use_iommu;
+    /* Whether we need to take the BQL on our own */
+    bool take_bql = !qemu_mutex_iothread_locked();
 
     assert(as);
 
@@ -967,6 +969,15 @@ static bool vtd_switch_address_space(VTDAddressSpace *as)
                                    VTD_PCI_FUNC(as->devfn),
                                    use_iommu);
 
+    /*
+     * It's possible that we reach here without BQL, e.g., when called
+     * from vtd_pt_enable_fast_path(). However the memory APIs need
+     * it. We'd better make sure we have had it already, or, take it.
+     */
+    if (take_bql) {
+        qemu_mutex_lock_iothread();
+    }
+
     /* Turn off first then on the other */
     if (use_iommu) {
         memory_region_set_enabled(&as->sys_alias, false);
@@ -976,6 +987,10 @@ static bool vtd_switch_address_space(VTDAddressSpace *as)
         memory_region_set_enabled(&as->sys_alias, true);
     }
 
+    if (take_bql) {
+        qemu_mutex_unlock_iothread();
+    }
+
     return use_iommu;
 }
 
-- 
2.7.4
