Received: from eggs.gnu.org ([209.51.188.92]:38213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gtcjA-0000c5-UZ
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:24:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gtcj8-00033o-QH
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:24:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gtcj6-00031H-SS
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:24:14 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1CIJw52064181
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 13:24:11 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qm2xks6u0-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 13:24:11 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 12 Feb 2019 18:24:08 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 12 Feb 2019 19:24:00 +0100
In-Reply-To: <154999583316.690774.15072605479770041782.stgit@bahia.lan>
References: <154999583316.690774.15072605479770041782.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <154999583999.690774.9854440646408554397.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH v4 01/15] spapr_irq: Add an @xics_offset field
 to sPAPRIrq
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

Only pseries machines, either recent ones started with ic-mode=xics
or older ones using the legacy irq allocation scheme, need to set the
@offset of the ICS to XICS_IRQ_BASE. Recent pseries started with
ic-mode=dual set it to 0 and powernv machines set it to some other
value at runtime.

It thus doesn't really help to set the default value of the ICS offset
to XICS_IRQ_BASE in ics_base_instance_init().

Drop that code from XICS and let the pseries code set the offset
explicitely for clarity.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics.c             |    8 --------
 hw/ppc/spapr_irq.c         |   33 ++++++++++++++++++++-------------
 include/hw/ppc/spapr_irq.h |    1 +
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 16e8ffa2aaf7..7cac138067e2 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -638,13 +638,6 @@ static void ics_base_realize(DeviceState *dev, Error **errp)
     ics->irqs = g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
 }
 
-static void ics_base_instance_init(Object *obj)
-{
-    ICSState *ics = ICS_BASE(obj);
-
-    ics->offset = XICS_IRQ_BASE;
-}
-
 static int ics_base_dispatch_pre_save(void *opaque)
 {
     ICSState *ics = opaque;
@@ -720,7 +713,6 @@ static const TypeInfo ics_base_info = {
     .parent = TYPE_DEVICE,
     .abstract = true,
     .instance_size = sizeof(ICSState),
-    .instance_init = ics_base_instance_init,
     .class_init = ics_base_class_init,
     .class_size = sizeof(ICSStateClass),
 };
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 80b0083b8e38..8217e0215411 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -68,10 +68,11 @@ void spapr_irq_msi_reset(sPAPRMachineState *spapr)
 
 static ICSState *spapr_ics_create(sPAPRMachineState *spapr,
                                   const char *type_ics,
-                                  int nr_irqs, Error **errp)
+                                  int nr_irqs, int offset, Error **errp)
 {
     Error *local_err = NULL;
     Object *obj;
+    ICSState *ics;
 
     obj = object_new(type_ics);
     object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
@@ -86,7 +87,10 @@ static ICSState *spapr_ics_create(sPAPRMachineState *spapr,
         goto error;
     }
 
-    return ICS_BASE(obj);
+    ics = ICS_BASE(obj);
+    ics->offset = offset;
+
+    return ics;
 
 error:
     error_propagate(errp, local_err);
@@ -104,6 +108,7 @@ static void spapr_irq_init_xics(sPAPRMachineState *spapr, Error **errp)
             !xics_kvm_init(spapr, &local_err)) {
             spapr->icp_type = TYPE_KVM_ICP;
             spapr->ics = spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs,
+                                          spapr->irq->xics_offset,
                                           &local_err);
         }
         if (machine_kernel_irqchip_required(machine) && !spapr->ics) {
@@ -119,6 +124,7 @@ static void spapr_irq_init_xics(sPAPRMachineState *spapr, Error **errp)
         xics_spapr_init(spapr);
         spapr->icp_type = TYPE_ICP;
         spapr->ics = spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs,
+                                      spapr->irq->xics_offset,
                                       &local_err);
     }
 
@@ -246,6 +252,7 @@ sPAPRIrq spapr_irq_xics = {
     .nr_irqs     = SPAPR_IRQ_XICS_NR_IRQS,
     .nr_msis     = SPAPR_IRQ_XICS_NR_MSIS,
     .ov5         = SPAPR_OV5_XIVE_LEGACY,
+    .xics_offset = XICS_IRQ_BASE,
 
     .init        = spapr_irq_init_xics,
     .claim       = spapr_irq_claim_xics,
@@ -451,17 +458,6 @@ static void spapr_irq_init_dual(sPAPRMachineState *spapr, Error **errp)
         return;
     }
 
-    /*
-     * Align the XICS and the XIVE IRQ number space under QEMU.
-     *
-     * However, the XICS KVM device still considers that the IRQ
-     * numbers should start at XICS_IRQ_BASE (0x1000). Either we
-     * should introduce a KVM device ioctl to set the offset or ignore
-     * the lower 4K numbers when using the get/set ioctl of the XICS
-     * KVM device. The second option seems the least intrusive.
-     */
-    spapr->ics->offset = 0;
-
     spapr_irq_xive.init(spapr, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -582,6 +578,16 @@ sPAPRIrq spapr_irq_dual = {
     .nr_irqs     = SPAPR_IRQ_DUAL_NR_IRQS,
     .nr_msis     = SPAPR_IRQ_DUAL_NR_MSIS,
     .ov5         = SPAPR_OV5_XIVE_BOTH,
+    /*
+     * Align the XICS and the XIVE IRQ number space under QEMU.
+     *
+     * However, the XICS KVM device still considers that the IRQ
+     * numbers should start at XICS_IRQ_BASE (0x1000). Either we
+     * should introduce a KVM device ioctl to set the offset or ignore
+     * the lower 4K numbers when using the get/set ioctl of the XICS
+     * KVM device. The second option seems the least intrusive.
+     */
+    .xics_offset = 0,
 
     .init        = spapr_irq_init_dual,
     .claim       = spapr_irq_claim_dual,
@@ -712,6 +718,7 @@ sPAPRIrq spapr_irq_xics_legacy = {
     .nr_irqs     = SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
     .nr_msis     = SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
     .ov5         = SPAPR_OV5_XIVE_LEGACY,
+    .xics_offset = XICS_IRQ_BASE,
 
     .init        = spapr_irq_init_xics,
     .claim       = spapr_irq_claim_xics,
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 14b02c3aca33..5e30858dc22a 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -34,6 +34,7 @@ typedef struct sPAPRIrq {
     uint32_t    nr_irqs;
     uint32_t    nr_msis;
     uint8_t     ov5;
+    uint32_t    xics_offset;
 
     void (*init)(sPAPRMachineState *spapr, Error **errp);
     int (*claim)(sPAPRMachineState *spapr, int irq, bool lsi, Error **errp);
