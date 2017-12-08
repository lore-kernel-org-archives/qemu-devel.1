Received: from eggs.gnu.org ([2001:4830:134:3::10]:55967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eNAFi-0007sZ-OX
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 23:27:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eNAFh-0005T8-OL
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 23:27:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eNAFh-0005Sv-FW
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 23:27:09 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A64EF883C2
	for <qemu-devel@nongnu.org>; Fri,  8 Dec 2017 04:27:08 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri,  8 Dec 2017 12:26:53 +0800
Message-Id: <20171208042654.10910-2-peterx@redhat.com>
In-Reply-To: <20171208042654.10910-1-peterx@redhat.com>
References: <20171208042654.10910-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] intel_iommu: remove X86_IOMMU_PCI_DEVFN_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

We have PCI_DEVFN_MAX now.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c       | 10 +++++-----
 include/hw/i386/x86-iommu.h |  1 -
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 3a5bb0bc2e..c1fa08d205 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -186,7 +186,7 @@ static void vtd_reset_context_cache(IntelIOMMUState *s)
     g_hash_table_iter_init(&bus_it, s->vtd_as_by_busptr);
 
     while (g_hash_table_iter_next (&bus_it, NULL, (void**)&vtd_bus)) {
-        for (devfn_it = 0; devfn_it < X86_IOMMU_PCI_DEVFN_MAX; ++devfn_it) {
+        for (devfn_it = 0; devfn_it < PCI_DEVFN_MAX; ++devfn_it) {
             vtd_as = vtd_bus->dev_as[devfn_it];
             if (!vtd_as) {
                 continue;
@@ -1002,7 +1002,7 @@ static void vtd_switch_address_space_all(IntelIOMMUState *s)
 
     g_hash_table_iter_init(&iter, s->vtd_as_by_busptr);
     while (g_hash_table_iter_next(&iter, NULL, (void **)&vtd_bus)) {
-        for (i = 0; i < X86_IOMMU_PCI_DEVFN_MAX; i++) {
+        for (i = 0; i < PCI_DEVFN_MAX; i++) {
             if (!vtd_bus->dev_as[i]) {
                 continue;
             }
@@ -1294,7 +1294,7 @@ static void vtd_context_device_invalidate(IntelIOMMUState *s,
     vtd_bus = vtd_find_as_from_bus_num(s, bus_n);
     if (vtd_bus) {
         devfn = VTD_SID_TO_DEVFN(source_id);
-        for (devfn_it = 0; devfn_it < X86_IOMMU_PCI_DEVFN_MAX; ++devfn_it) {
+        for (devfn_it = 0; devfn_it < PCI_DEVFN_MAX; ++devfn_it) {
             vtd_as = vtd_bus->dev_as[devfn_it];
             if (vtd_as && ((devfn_it & mask) == (devfn & mask))) {
                 trace_vtd_inv_desc_cc_device(bus_n, VTD_PCI_SLOT(devfn_it),
@@ -2699,7 +2699,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
         *new_key = (uintptr_t)bus;
         /* No corresponding free() */
         vtd_bus = g_malloc0(sizeof(VTDBus) + sizeof(VTDAddressSpace *) * \
-                            X86_IOMMU_PCI_DEVFN_MAX);
+                            PCI_DEVFN_MAX);
         vtd_bus->bus = bus;
         g_hash_table_insert(s->vtd_as_by_busptr, new_key, vtd_bus);
     }
@@ -2982,7 +2982,7 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     IntelIOMMUState *s = opaque;
     VTDAddressSpace *vtd_as;
 
-    assert(0 <= devfn && devfn < X86_IOMMU_PCI_DEVFN_MAX);
+    assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
 
     vtd_as = vtd_find_add_as(s, bus, devfn);
     return &vtd_as->as;
diff --git a/include/hw/i386/x86-iommu.h b/include/hw/i386/x86-iommu.h
index ef89c0c646..7c71fc7470 100644
--- a/include/hw/i386/x86-iommu.h
+++ b/include/hw/i386/x86-iommu.h
@@ -31,7 +31,6 @@
 #define  X86_IOMMU_GET_CLASS(obj) \
     OBJECT_GET_CLASS(X86IOMMUClass, obj, TYPE_X86_IOMMU_DEVICE)
 
-#define X86_IOMMU_PCI_DEVFN_MAX           256
 #define X86_IOMMU_SID_INVALID             (0xffff)
 
 typedef struct X86IOMMUState X86IOMMUState;
-- 
2.14.3
