Received: from eggs.gnu.org ([2001:4830:134:3::10]:46173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fDR8Y-0003Yx-Rn
	for qemu-devel@nongnu.org; Tue, 01 May 2018 04:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fDR8X-0007tN-VN
	for qemu-devel@nongnu.org; Tue, 01 May 2018 04:59:50 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fDR8X-0007sf-On
	for qemu-devel@nongnu.org; Tue, 01 May 2018 04:59:49 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  1 May 2018 09:59:38 +0100
Message-Id: <20180501085939.6201-12-peter.maydell@linaro.org>
In-Reply-To: <20180501085939.6201-1-peter.maydell@linaro.org>
References: <20180501085939.6201-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [RFC PATCH v2 11/12] Make flatview_do_translate() take
 a MemTxAttrs argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>

As part of plumbing MemTxAttrs down to the IOMMU translate method,
add MemTxAttrs as an argument to flatview_do_translate().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 exec.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/exec.c b/exec.c
index c29bf47ce2..9c6d9aae28 100644
--- a/exec.c
+++ b/exec.c
@@ -476,6 +476,7 @@ address_space_translate_internal(AddressSpaceDispatch *d, hwaddr addr, hwaddr *x
  *            would tell. It can be @NULL if we don't care about it.
  * @is_write: whether the translation operation is for write
  * @is_mmio: whether this can be MMIO, set true if it can
+ * @attrs: memory transaction attributes
  *
  * This function is called from RCU critical section
  */
@@ -486,7 +487,8 @@ static MemoryRegionSection flatview_do_translate(FlatView *fv,
                                                  hwaddr *page_mask_out,
                                                  bool is_write,
                                                  bool is_mmio,
-                                                 AddressSpace **target_as)
+                                                 AddressSpace **target_as,
+                                                 MemTxAttrs attrs)
 {
     IOMMUTLBEntry iotlb;
     MemoryRegionSection *section;
@@ -557,7 +559,8 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
      * but page mask.
      */
     section = flatview_do_translate(address_space_to_flatview(as), addr, &xlat,
-                                    NULL, &page_mask, is_write, false, &as);
+                                    NULL, &page_mask, is_write, false, &as,
+                                    attrs);
 
     /* Illegal translation */
     if (section.mr == &io_mem_unassigned) {
@@ -592,7 +595,7 @@ MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
 
     /* This can be MMIO, so setup MMIO bit. */
     section = flatview_do_translate(fv, addr, xlat, plen, NULL,
-                                    is_write, true, &as);
+                                    is_write, true, &as, attrs);
     mr = section.mr;
 
     if (xen_enabled() && memory_access_is_direct(mr, is_write)) {
-- 
2.17.0
