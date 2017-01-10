Received: from eggs.gnu.org ([2001:4830:134:3::10]:33378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQp9p-0007EQ-0g
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:39:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQp9o-0005Pq-9a
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:39:41 -0500
Received: from mail.kernel.org ([198.145.29.136]:47656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQp9o-0005PO-2a
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:39:40 -0500
Date: Tue, 10 Jan 2017 07:39:35 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484026704-28027-7-git-send-email-mst@redhat.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484026704-28027-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 06/41] intel_iommu: allocate new key when
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>

From: Jason Wang <jasowang@redhat.com>

We use the pointer to stack for key for new address space, this will break hash
table searching, fixing by g_malloc() a new key instead.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 0dd1c8f..e39b764 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2347,12 +2347,13 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
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
MST
