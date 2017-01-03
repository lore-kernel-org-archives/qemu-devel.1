Received: from eggs.gnu.org ([2001:4830:134:3::10]:32847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cOJY1-0002wU-2u
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 02:30:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cOJXz-0008Jo-Ps
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 02:30:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cOJXz-0008Je-Jy
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 02:30:15 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue,  3 Jan 2017 15:29:41 +0800
Message-Id: <1483428594-28880-5-git-send-email-peterx@redhat.com>
In-Reply-To: <1483428594-28880-1-git-send-email-peterx@redhat.com>
References: <1483428594-28880-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v2 04/17] intel_iommu: allocate new key
 when creating new address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, peterx@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com

From: Jason Wang <jasowang@redhat.com>

We use the pointer to stack for key for new address space, this will
break hash table searching, fixing by g_malloc() a new key instead.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 6c7362a..f4d3cce 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2327,12 +2327,13 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
     VTDAddressSpace *vtd_dev_as;
 
     if (!vtd_bus) {
+        uintptr_t *new_key = g_malloc(sizeof(*new_key));
+        *new_key = (uintptr_t)bus;
         /* No corresponding free() */
         vtd_bus = g_malloc0(sizeof(VTDBus) + sizeof(VTDAddressSpace *) * \
                             X86_IOMMU_PCI_DEVFN_MAX);
         vtd_bus->bus = bus;
-        key = (uintptr_t)bus;
-        g_hash_table_insert(s->vtd_as_by_busptr, &key, vtd_bus);
+        g_hash_table_insert(s->vtd_as_by_busptr, new_key, vtd_bus);
     }
 
     vtd_dev_as = vtd_bus->dev_as[devfn];
-- 
2.7.4
