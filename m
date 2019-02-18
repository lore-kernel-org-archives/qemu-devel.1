Received: from eggs.gnu.org ([209.51.188.92]:39370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxv-0006bK-3S
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxt-0003Ax-3B
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:15 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:30 +1100
Message-Id: <20190218143049.17142-25-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 24/43] xics: Handle KVM interrupt presentation
 from "simple" ICS code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

We want to use the "simple" ICS type in both KVM and non-KVM setups.
Teach the "simple" ICS how to present interrupts to KVM and adapt
sPAPR accordingly.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155023082996.1011724.16237920586343905010.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c        | 5 +++++
 hw/intc/xics_kvm.c    | 3 +--
 hw/ppc/spapr_irq.c    | 7 +------
 include/hw/ppc/xics.h | 2 +-
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 49401745c4..3009fa7472 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -466,6 +466,11 @@ void ics_simple_set_irq(void *opaque, int srcno, int=
 val)
 {
     ICSState *ics =3D (ICSState *)opaque;
=20
+    if (kvm_irqchip_in_kernel()) {
+        ics_kvm_set_irq(ics, srcno, val);
+        return;
+    }
+
     if (ics->irqs[srcno].flags & XICS_FLAGS_IRQ_LSI) {
         ics_simple_set_irq_lsi(ics, srcno, val);
     } else {
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index e7b8d4c29c..f34eacda03 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -259,9 +259,8 @@ int ics_set_kvm_state(ICSState *ics)
     return 0;
 }
=20
-void ics_kvm_set_irq(void *opaque, int srcno, int val)
+void ics_kvm_set_irq(ICSState *ics, int srcno, int val)
 {
-    ICSState *ics =3D opaque;
     struct kvm_irq_level args;
     int rc;
=20
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index e6893df61e..9f43b7b3bf 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -222,13 +222,8 @@ static int spapr_irq_post_load_xics(sPAPRMachineStat=
e *spapr, int version_id)
 static void spapr_irq_set_irq_xics(void *opaque, int srcno, int val)
 {
     sPAPRMachineState *spapr =3D opaque;
-    MachineState *machine =3D MACHINE(opaque);
=20
-    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
-        ics_kvm_set_irq(spapr->ics, srcno, val);
-    } else {
-        ics_simple_set_irq(spapr->ics, srcno, val);
-    }
+    ics_simple_set_irq(spapr->ics, srcno, val);
 }
=20
 static void spapr_irq_reset_xics(sPAPRMachineState *spapr, Error **errp)
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 06e87128f8..61bd0fb978 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -180,7 +180,6 @@ void icp_eoi(ICPState *icp, uint32_t xirr);
 void ics_simple_write_xive(ICSState *ics, int nr, int server,
                            uint8_t priority, uint8_t saved_priority);
 void ics_simple_set_irq(void *opaque, int srcno, int val);
-void ics_kvm_set_irq(void *opaque, int srcno, int val);
=20
 void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
 void icp_pic_print_info(ICPState *icp, Monitor *mon);
@@ -201,5 +200,6 @@ void icp_kvm_realize(DeviceState *dev, Error **errp);
 void ics_get_kvm_state(ICSState *ics);
 int ics_set_kvm_state(ICSState *ics);
 void ics_synchronize_state(ICSState *ics);
+void ics_kvm_set_irq(ICSState *ics, int srcno, int val);
=20
 #endif /* XICS_H */
--=20
2.20.1
