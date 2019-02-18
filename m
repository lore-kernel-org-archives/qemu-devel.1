Received: from eggs.gnu.org ([209.51.188.92]:38739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjwv-0005cm-Md
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:31:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjwu-0002h7-5U
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:31:13 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:13 +1100
Message-Id: <20190218143049.17142-8-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/43] spapr: Disallow unsupported
 kernel-irqchip settings
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

Split mode doesn't make sense on pseries, neither with XICS nor XIVE. But
passing kernel-irqchip=3Dsplit silently behaves like kernel-irqchip=3Don.
Other architectures that support kernel-irqchip do terminate QEMU when
split mode is requested but not available though. Do the same with pserie=
s
for consistency.

Similarly, passing kernel-irqchip=3Don,accel=3Dtcg starts the machine wit=
h the
emulated interrupt controller, ie, behaves like kernel-irqchip=3Doff. How=
ever,
when passing  kernel-irqchip=3Don,accel=3Dkvm, if we can't initialize the=
 KVM
XICS for some reason, ie, xics_kvm_init() fails, then QEMU is terminated.
This is inconsistent. Terminate QEMU all the same when requesting the
in-kernel interrupt controller without KVM.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <154964986747.291716.2679312373018476920.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_irq.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 2d7a7c1638..80b0083b8e 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -600,6 +600,19 @@ sPAPRIrq spapr_irq_dual =3D {
  */
 void spapr_irq_init(sPAPRMachineState *spapr, Error **errp)
 {
+    MachineState *machine =3D MACHINE(spapr);
+
+    if (machine_kernel_irqchip_split(machine)) {
+        error_setg(errp, "kernel_irqchip split mode not supported on pse=
ries");
+        return;
+    }
+
+    if (!kvm_enabled() && machine_kernel_irqchip_required(machine)) {
+        error_setg(errp,
+                   "kernel_irqchip requested but only available with KVM=
");
+        return;
+    }
+
     /* Initialize the MSI IRQ allocator. */
     if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
         spapr_irq_msi_init(spapr, spapr->irq->nr_msis);
--=20
2.20.1
