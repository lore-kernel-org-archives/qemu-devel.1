Received: from eggs.gnu.org ([2001:4830:134:3::10]:54626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cED72-00076e-5T
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:36:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cED71-0001us-CE
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:36:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cED71-0001uo-6P
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:36:39 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue,  6 Dec 2016 18:36:16 +0800
Message-Id: <1481020588-4245-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1481020588-4245-1-git-send-email-peterx@redhat.com>
References: <1481020588-4245-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 01/13] intel_iommu: allocate new key when
 creating new address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, peterx@redhat.com, alex.williamson@redhat.com, jasowang@redhat.com

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
index 708770e..92e4064 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2426,12 +2426,13 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
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
