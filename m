Received: from eggs.gnu.org ([2001:4830:134:3::10]:40544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eCmtg-0008PS-7V
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 08:29:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eCmtc-0005EE-4o
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 08:29:32 -0500
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:45162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eCmtb-0005Dv-RL
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 08:29:28 -0500
Received: from player750.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 937859BD4A
	for <qemu-devel@nongnu.org>; Thu,  9 Nov 2017 14:29:26 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  9 Nov 2017 11:14:32 +0100
Message-Id: <20171109101439.390-6-clg@kaod.org>
In-Reply-To: <20171109101439.390-1-clg@kaod.org>
References: <20171109101439.390-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.12 v2 05/12] spapr: introduce an IRQ
 allocator using a bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

On the sPAPR platform, these IRQ operations are simply backed by a
bitmap 'irq_map' in the machine.

Older pseries machines do not have a bitmap acting as a IRQ number
allocator but use the ICSIRQState array for this purpose.  This
difference between machine versions needs to be taken into account
when loading the state.

To keep in sync the bitmap with the ICSIRQState array flags, we
introduce a machine class flag 'has_irq_bitmap' set to false for older
versions only.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c         | 97 ++++++++++++++++++++++++++++++++++----------=
------
 include/hw/ppc/spapr.h |  4 +++
 2 files changed, 70 insertions(+), 31 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 481bfb0277df..70f6a96ec909 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1532,6 +1532,7 @@ static bool spapr_vga_init(PCIBus *pci_bus, Error *=
*errp)
 static int spapr_post_load(void *opaque, int version_id)
 {
     sPAPRMachineState *spapr =3D (sPAPRMachineState *)opaque;
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
     int err =3D 0;
=20
     if (!object_dynamic_cast(OBJECT(spapr->ics), TYPE_ICS_KVM)) {
@@ -1562,6 +1563,20 @@ static int spapr_post_load(void *opaque, int versi=
on_id)
         }
     }
=20
+    /*
+     * Synchronize the IRQ number bitmap with the ICSIRQState array
+     * coming from an older pseries machine
+     */
+    if (!smc->has_irq_bitmap) {
+        int srcno;
+
+        for (srcno =3D 0; srcno < spapr->ics->nr_irqs; srcno++) {
+            if (spapr->ics->irqs[srcno].flags & XICS_FLAGS_IRQ_MASK &&
+                !test_bit(srcno, spapr->irq_map)) {
+                bitmap_set(spapr->irq_map, srcno, 1);
+            }
+        }
+    }
     return err;
 }
=20
@@ -1681,6 +1696,30 @@ static const VMStateDescription vmstate_spapr_patb=
_entry =3D {
     },
 };
=20
+static bool spapr_irq_map_needed(void *opaque)
+{
+    sPAPRMachineState *spapr =3D opaque;
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
+
+    /* Never transfer the bitmap on older machines, it doesn't exist */
+    if (!smc->has_irq_bitmap) {
+        return false;
+    }
+
+    return true;
+}
+
+static const VMStateDescription vmstate_spapr_irq_map =3D {
+    .name =3D "spapr_irq_map",
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .needed =3D spapr_irq_map_needed,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_BITMAP(irq_map, sPAPRMachineState, 0, nr_irqs),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_spapr =3D {
     .name =3D "spapr",
     .version_id =3D 3,
@@ -1700,6 +1739,7 @@ static const VMStateDescription vmstate_spapr =3D {
         &vmstate_spapr_ov5_cas,
         &vmstate_spapr_patb_entry,
         &vmstate_spapr_pending_events,
+        &vmstate_spapr_irq_map,
         NULL
     }
 };
@@ -2337,8 +2377,12 @@ static void ppc_spapr_init(MachineState *machine)
     /* Setup a load limit for the ramdisk leaving room for SLOF and FDT =
*/
     load_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEAD;
=20
+    /* Initialize the IRQ allocator */
+    spapr->nr_irqs  =3D XICS_IRQS_SPAPR;
+    spapr->irq_map  =3D bitmap_new(spapr->nr_irqs);
+
     /* Set up Interrupt Controller before we create the VCPUs */
-    xics_system_init(machine, XICS_IRQS_SPAPR, &error_fatal);
+    xics_system_init(machine, spapr->nr_irqs, &error_fatal);
=20
     /* Set up containers for ibm,client-architecture-support negotiated =
options
      */
@@ -3536,50 +3580,37 @@ static ICPState *spapr_icp_get(XICSFabric *xi, in=
t vcpu_id)
     return cpu ? ICP(cpu->intc) : NULL;
 }
=20
-#define ICS_IRQ_FREE(ics, srcno)   \
-    (!((ics)->irqs[(srcno)].flags & (XICS_FLAGS_IRQ_MASK)))
-
-static int ics_find_free_block(ICSState *ics, int num, int alignnum)
-{
-    int first, i;
-
-    for (first =3D 0; first < ics->nr_irqs; first +=3D alignnum) {
-        if (num > (ics->nr_irqs - first)) {
-            return -1;
-        }
-        for (i =3D first; i < first + num; ++i) {
-            if (!ICS_IRQ_FREE(ics, i)) {
-                break;
-            }
-        }
-        if (i =3D=3D (first + num)) {
-            return first;
-        }
-    }
-
-    return -1;
-}
-
 static bool spapr_irq_test(XICSFabric *xi, int irq)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
     ICSState *ics =3D spapr->ics;
     int srcno =3D irq - ics->offset;
=20
-    return ICS_IRQ_FREE(ics, srcno);
+    return test_bit(srcno, spapr->irq_map);
 }
=20
 static int spapr_irq_alloc_block(XICSFabric *xi, int count, int align)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
     ICSState *ics =3D spapr->ics;
+    int start =3D 0;
     int srcno;
=20
-    srcno =3D ics_find_free_block(ics, count, align);
-    if (srcno =3D=3D -1) {
+    /*
+     * The 'align_mask' parameter of bitmap_find_next_zero_area()
+     * should be one less than a power of 2; 0 means no
+     * alignment. Adapt the 'align' value of the former allocator to
+     * fit the requirements of bitmap_find_next_zero_area()
+     */
+    align -=3D 1;
+
+    srcno =3D bitmap_find_next_zero_area(spapr->irq_map, spapr->nr_irqs,=
 start,
+                                       count, align);
+    if (srcno =3D=3D spapr->nr_irqs) {
         return -1;
     }
=20
+    bitmap_set(spapr->irq_map, srcno, count);
     return srcno + ics->offset;
 }
=20
@@ -3593,11 +3624,11 @@ static void spapr_irq_free_block(XICSFabric *xi, =
int irq, int num)
     if (ics_valid_irq(ics, irq)) {
         trace_spapr_irq_free(0, irq, num);
         for (i =3D srcno; i < srcno + num; ++i) {
-            if (ICS_IRQ_FREE(ics, i)) {
+            if (!test_bit(i, spapr->irq_map)) {
                 trace_spapr_irq_free_warn(0, i + ics->offset);
             }
-            memset(&ics->irqs[i], 0, sizeof(ICSIRQState));
         }
+        bitmap_clear(spapr->irq_map, srcno, num);
     }
 }
=20
@@ -3679,6 +3710,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     hc->unplug_request =3D spapr_machine_device_unplug_request;
=20
     smc->dr_lmb_enabled =3D true;
+    smc->has_irq_bitmap =3D true;
     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
     mc->has_hotpluggable_cpus =3D true;
     smc->resize_hpt_default =3D SPAPR_RESIZE_HPT_ENABLED;
@@ -3778,7 +3810,10 @@ static void spapr_machine_2_11_instance_options(Ma=
chineState *machine)
=20
 static void spapr_machine_2_11_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class *=
/
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
+
+    spapr_machine_2_12_class_options(mc);
+    smc->has_irq_bitmap =3D false;
 }
=20
 DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 9d21ca9bde3a..71faeff17a40 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -7,6 +7,7 @@
 #include "hw/ppc/spapr_drc.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/ppc/spapr_ovec.h"
+#include "qemu/bitmap.h"
=20
 struct VIOsPAPRBus;
 struct sPAPRPHBState;
@@ -61,6 +62,7 @@ struct sPAPRMachineClass {
     bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of LMB=
s */
     bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
     bool pre_2_10_has_unused_icps;
+    bool has_irq_bitmap;
     void (*phb_placement)(sPAPRMachineState *spapr, uint32_t index,
                           uint64_t *buid, hwaddr *pio,=20
                           hwaddr *mmio32, hwaddr *mmio64,
@@ -78,6 +80,8 @@ struct sPAPRMachineState {
     struct VIOsPAPRBus *vio_bus;
     QLIST_HEAD(, sPAPRPHBState) phbs;
     struct sPAPRNVRAM *nvram;
+    int32_t nr_irqs;
+    unsigned long *irq_map;
     ICSState *ics;
     sPAPRRTCState rtc;
=20
--=20
2.13.6
