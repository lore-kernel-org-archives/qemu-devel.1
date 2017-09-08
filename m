Received: from eggs.gnu.org ([2001:4830:134:3::10]:49142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dqK81-0006lQ-9d
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:19:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dqK7x-000550-DD
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:19:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dqK7x-000549-6S
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:19:25 -0400
Date: Fri, 8 Sep 2017 17:19:19 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1504880304-12069-11-git-send-email-mst@redhat.com>
References: <1504880304-12069-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504880304-12069-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 10/17] intel_iommu: fix missing BQL in pt fast
 path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Peter Xu <peterx@redhat.com>

In vtd_switch_address_space() we did the memory region switch, however
it's possible that the caller of it has not taken the BQL at all. Make
sure we have it.

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Jason Wang <jasowang@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST
