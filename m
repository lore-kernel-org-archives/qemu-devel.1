Received: from eggs.gnu.org ([2001:4830:134:3::10]:50933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cMu8P-00018P-UH
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 05:10:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cMu8K-0005ay-5R
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 05:09:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cMu8K-0005aq-0B
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 05:09:56 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 30 Dec 2016 18:09:12 +0800
Message-Id: <1483092559-24488-4-git-send-email-jasowang@redhat.com>
In-Reply-To: <1483092559-24488-1-git-send-email-jasowang@redhat.com>
References: <1483092559-24488-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH V4 03/10] intel_iommu: allocate new key when
 creating new address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peterx@redhat.com, cornelia.huck@de.ibm.com, wexu@redhat.com, vkaplans@redhat.com, Jason Wang <jasowang@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

We use the pointer to stack for key for new address space, this will break hash
table searching, fixing by g_malloc() a new key instead.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/i386/intel_iommu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index bf25e04..58ab143 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2327,12 +2327,13 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
     char name[128];
 
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
