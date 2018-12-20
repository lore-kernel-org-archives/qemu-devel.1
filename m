Received: from eggs.gnu.org ([2001:4830:134:3::10]:60775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ga3Fi-0006DZ-HP
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ga3FZ-0002cw-ST
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:40:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ga3FL-00022A-HZ
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:40:41 -0500
Date: Thu, 20 Dec 2018 13:40:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181220183059.20726-44-mst@redhat.com>
References: <20181220183059.20726-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220183059.20726-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v3 43/44] x86-iommu: switch intr_supported to
 OnOffAuto type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Peter Xu <peterx@redhat.com>

Switch the intr_supported variable from a boolean to OnOffAuto type so
that we can know whether the user specified it or not.  With that
we'll have a chance to help the user to choose more wisely where
possible.  Introduce x86_iommu_ir_supported() to mask these changes.

No functional change at all.

Signed-off-by: Peter Xu <peterx@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/x86-iommu.h |  4 +++-
 hw/i386/acpi-build.c        |  6 +++---
 hw/i386/amd_iommu.c         |  2 +-
 hw/i386/intel_iommu.c       |  6 +++---
 hw/i386/pc.c                |  2 +-
 hw/i386/x86-iommu.c         | 15 +++++++++++++--
 6 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/include/hw/i386/x86-iommu.h b/include/hw/i386/x86-iommu.h
index 2b22a579a3..dcd9719a2c 100644
--- a/include/hw/i386/x86-iommu.h
+++ b/include/hw/i386/x86-iommu.h
@@ -74,13 +74,15 @@ typedef struct IEC_Notifier IEC_Notifier;
 
 struct X86IOMMUState {
     SysBusDevice busdev;
-    bool intr_supported;        /* Whether vIOMMU supports IR */
+    OnOffAuto intr_supported;   /* Whether vIOMMU supports IR */
     bool dt_supported;          /* Whether vIOMMU supports DT */
     bool pt_supported;          /* Whether vIOMMU supports pass-through */
     IommuType type;             /* IOMMU type - AMD/Intel     */
     QLIST_HEAD(, IEC_Notifier) iec_notifiers; /* IEC notify list */
 };
 
+bool x86_iommu_ir_supported(X86IOMMUState *s);
+
 /* Generic IRQ entry information when interrupt remapping is enabled */
 struct X86IOMMUIrq {
     /* Used by both IOAPIC/MSI interrupt remapping */
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9891b6913b..14f757fc36 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2426,7 +2426,7 @@ build_dmar_q35(GArray *table_data, BIOSLinker *linker)
     IntelIOMMUState *intel_iommu = INTEL_IOMMU_DEVICE(iommu);
 
     assert(iommu);
-    if (iommu->intr_supported) {
+    if (x86_iommu_ir_supported(iommu)) {
         dmar_flags |= 0x1;      /* Flags: 0x1: INT_REMAP */
     }
 
@@ -2499,7 +2499,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
      * When interrupt remapping is supported, we add a special IVHD device
      * for type IO-APIC.
      */
-    if (x86_iommu_get_default()->intr_supported) {
+    if (x86_iommu_ir_supported(x86_iommu_get_default())) {
         ivhd_table_len += 8;
     }
     /* IVHD length */
@@ -2535,7 +2535,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
      * Linux IOMMU driver checks for the special IVHD device (type IO-APIC).
      * See Linux kernel commit 'c2ff5cf5294bcbd7fa50f7d860e90a66db7e5059'
      */
-    if (x86_iommu_get_default()->intr_supported) {
+    if (x86_iommu_ir_supported(x86_iommu_get_default())) {
         build_append_int_noprefix(table_data,
                                  (0x1ull << 56) |           /* type IOAPIC */
                                  (IOAPIC_SB_DEVID << 40) |  /* IOAPIC devid */
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 353a810e6b..8ad707aba0 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1233,7 +1233,7 @@ static int amdvi_int_remap_msi(AMDVIState *iommu,
     }
 
     /* validate that we are configure with intremap=on */
-    if (!X86_IOMMU_DEVICE(iommu)->intr_supported) {
+    if (!x86_iommu_ir_supported(X86_IOMMU_DEVICE(iommu))) {
         trace_amdvi_err("Interrupt remapping is enabled in the guest but "
                         "not in the host. Use intremap=on to enable interrupt "
                         "remapping in amd-iommu.");
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 96ef31eb7e..8b72735650 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3169,7 +3169,7 @@ static void vtd_init(IntelIOMMUState *s)
     vtd_paging_entry_rsvd_field[7] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits);
     vtd_paging_entry_rsvd_field[8] = VTD_SPTE_LPAGE_L4_RSVD_MASK(s->aw_bits);
 
-    if (x86_iommu->intr_supported) {
+    if (x86_iommu_ir_supported(x86_iommu)) {
         s->ecap |= VTD_ECAP_IR | VTD_ECAP_MHMV;
         if (s->intr_eim == ON_OFF_AUTO_ON) {
             s->ecap |= VTD_ECAP_EIM;
@@ -3270,14 +3270,14 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
 {
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
-    if (s->intr_eim == ON_OFF_AUTO_ON && !x86_iommu->intr_supported) {
+    if (s->intr_eim == ON_OFF_AUTO_ON && !x86_iommu_ir_supported(x86_iommu)) {
         error_setg(errp, "eim=on cannot be selected without intremap=on");
         return false;
     }
 
     if (s->intr_eim == ON_OFF_AUTO_AUTO) {
         s->intr_eim = (kvm_irqchip_in_kernel() || s->buggy_eim)
-                      && x86_iommu->intr_supported ?
+                      && x86_iommu_ir_supported(x86_iommu) ?
                                               ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
     }
     if (s->intr_eim == ON_OFF_AUTO_ON && !s->buggy_eim) {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 470cc5daf9..f248662e97 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1244,7 +1244,7 @@ void pc_machine_done(Notifier *notifier, void *data)
     if (pcms->apic_id_limit > 255 && !xen_enabled()) {
         IntelIOMMUState *iommu = INTEL_IOMMU_DEVICE(x86_iommu_get_default());
 
-        if (!iommu || !iommu->x86_iommu.intr_supported ||
+        if (!iommu || !x86_iommu_ir_supported(X86_IOMMU_DEVICE(iommu)) ||
             iommu->intr_eim != ON_OFF_AUTO_ON) {
             error_report("current -smp configuration requires "
                          "Extended Interrupt Mode enabled. "
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index abc3c03158..61ee0f1eaa 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -119,8 +119,13 @@ static void x86_iommu_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /* If the user didn't specify IR, choose a default value for it */
+    if (x86_iommu->intr_supported == ON_OFF_AUTO_AUTO) {
+        x86_iommu->intr_supported = ON_OFF_AUTO_OFF;
+    }
+
     /* Both Intel and AMD IOMMU IR only support "kernel-irqchip={off|split}" */
-    if (x86_iommu->intr_supported && kvm_irqchip_in_kernel() &&
+    if (x86_iommu_ir_supported(x86_iommu) && kvm_irqchip_in_kernel() &&
         !kvm_irqchip_is_split()) {
         error_setg(errp, "Interrupt Remapping cannot work with "
                          "kernel-irqchip=on, please use 'split|off'.");
@@ -135,7 +140,8 @@ static void x86_iommu_realize(DeviceState *dev, Error **errp)
 }
 
 static Property x86_iommu_properties[] = {
-    DEFINE_PROP_BOOL("intremap", X86IOMMUState, intr_supported, false),
+    DEFINE_PROP_ON_OFF_AUTO("intremap", X86IOMMUState,
+                            intr_supported, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("device-iotlb", X86IOMMUState, dt_supported, false),
     DEFINE_PROP_BOOL("pt", X86IOMMUState, pt_supported, true),
     DEFINE_PROP_END_OF_LIST(),
@@ -148,6 +154,11 @@ static void x86_iommu_class_init(ObjectClass *klass, void *data)
     dc->props = x86_iommu_properties;
 }
 
+bool x86_iommu_ir_supported(X86IOMMUState *s)
+{
+    return s->intr_supported == ON_OFF_AUTO_ON;
+}
+
 static const TypeInfo x86_iommu_info = {
     .name          = TYPE_X86_IOMMU_DEVICE,
     .parent        = TYPE_SYS_BUS_DEVICE,
-- 
MST
