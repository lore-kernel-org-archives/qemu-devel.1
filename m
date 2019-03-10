Received: from eggs.gnu.org ([209.51.188.92]:43364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tot-0001jo-OA
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tos-0001qY-FW
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:31 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:36 +1100
Message-Id: <20190310082703.1245-34-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 33/60] spapr_iommu: Do not replay mappings from
 just created DMA window
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

On sPAPR vfio_listener_region_add() is called in 2 situations:
1. a new listener is registered from vfio_connect_container();
2. a new IOMMU Memory Region is added from rtas_ibm_create_pe_dma_window(=
).

In both cases vfio_listener_region_add() calls
memory_region_iommu_replay() to notify newly registered IOMMU notifiers
about existing mappings which is totally desirable for case 1.

However for case 2 it is nothing but noop as the window has just been
created and has no valid mappings so replaying those does not do anything=
.
It is barely noticeable with usual guests but if the window happens to be
really big, such no-op replay might take minutes and trigger RCU stall
warnings in the guest.

For example, a upcoming GPU RAM memory region mapped at 64TiB (right
after SPAPR_PCI_LIMIT) causes a 64bit DMA window to be at least 128TiB
which is (128<<40)/0x10000=3D2.147.483.648 TCEs to replay.

This mitigates the problem by adding an "skipping_replay" flag to
sPAPRTCETable and defining sPAPR own IOMMU MR replay() hook which does
exactly the same thing as the generic one except it returns early if
@skipping_replay=3D=3Dtrue.

Another way of fixing this would be delaying replay till the very first
H_PUT_TCE but this does not work if in-kernel H_PUT_TCE handler is
enabled (a likely case).

When "ibm,create-pe-dma-window" is complete, the guest will map only
required regions of the huge DMA window.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20190307050518.64968-2-aik@ozlabs.ru>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_iommu.c    | 31 +++++++++++++++++++++++++++++++
 hw/ppc/spapr_rtas_ddw.c | 10 ++++++++++
 include/hw/ppc/spapr.h  |  1 +
 3 files changed, 42 insertions(+)

diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 37e98f9321..8f231799b2 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -141,6 +141,36 @@ static IOMMUTLBEntry spapr_tce_translate_iommu(IOMMU=
MemoryRegion *iommu,
     return ret;
 }
=20
+static void spapr_tce_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier =
*n)
+{
+    MemoryRegion *mr =3D MEMORY_REGION(iommu_mr);
+    IOMMUMemoryRegionClass *imrc =3D IOMMU_MEMORY_REGION_GET_CLASS(iommu=
_mr);
+    hwaddr addr, granularity;
+    IOMMUTLBEntry iotlb;
+    sPAPRTCETable *tcet =3D container_of(iommu_mr, sPAPRTCETable, iommu)=
;
+
+    if (tcet->skipping_replay) {
+        return;
+    }
+
+    granularity =3D memory_region_iommu_get_min_page_size(iommu_mr);
+
+    for (addr =3D 0; addr < memory_region_size(mr); addr +=3D granularit=
y) {
+        iotlb =3D imrc->translate(iommu_mr, addr, IOMMU_NONE, n->iommu_i=
dx);
+        if (iotlb.perm !=3D IOMMU_NONE) {
+            n->notify(n, &iotlb);
+        }
+
+        /*
+         * if (2^64 - MR size) < granularity, it's possible to get an
+         * infinite loop here.  This should catch such a wraparound.
+         */
+        if ((addr + granularity) < addr) {
+            break;
+        }
+    }
+}
+
 static int spapr_tce_table_pre_save(void *opaque)
 {
     sPAPRTCETable *tcet =3D SPAPR_TCE_TABLE(opaque);
@@ -659,6 +689,7 @@ static void spapr_iommu_memory_region_class_init(Obje=
ctClass *klass, void *data)
     IOMMUMemoryRegionClass *imrc =3D IOMMU_MEMORY_REGION_CLASS(klass);
=20
     imrc->translate =3D spapr_tce_translate_iommu;
+    imrc->replay =3D spapr_tce_replay;
     imrc->get_min_page_size =3D spapr_tce_get_min_page_size;
     imrc->notify_flag_changed =3D spapr_tce_notify_flag_changed;
     imrc->get_attr =3D spapr_tce_get_attr;
diff --git a/hw/ppc/spapr_rtas_ddw.c b/hw/ppc/spapr_rtas_ddw.c
index cb8a410359..cc9d1f5c1c 100644
--- a/hw/ppc/spapr_rtas_ddw.c
+++ b/hw/ppc/spapr_rtas_ddw.c
@@ -171,8 +171,18 @@ static void rtas_ibm_create_pe_dma_window(PowerPCCPU=
 *cpu,
     }
=20
     win_addr =3D (windows =3D=3D 0) ? sphb->dma_win_addr : sphb->dma64_w=
in_addr;
+    /*
+     * We have just created a window, we know for the fact that it is em=
pty,
+     * use a hack to avoid iterating over the table as it is quite possi=
ble
+     * to have billions of TCEs, all empty.
+     * Note that we cannot delay this to the first H_PUT_TCE as this hca=
ll is
+     * mostly likely to be handled in KVM so QEMU just does not know if =
it
+     * happened.
+     */
+    tcet->skipping_replay =3D true;
     spapr_tce_table_enable(tcet, page_shift, win_addr,
                            1ULL << (window_shift - page_shift));
+    tcet->skipping_replay =3D false;
     if (!tcet->nb_table) {
         goto hw_error_exit;
     }
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 1311ebe28e..f117a7ce6e 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -723,6 +723,7 @@ struct sPAPRTCETable {
     uint64_t *mig_table;
     bool bypass;
     bool need_vfio;
+    bool skipping_replay;
     int fd;
     MemoryRegion root;
     IOMMUMemoryRegion iommu;
--=20
2.20.1
