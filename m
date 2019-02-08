Received: from eggs.gnu.org ([209.51.188.92]:34359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gsDYI-0004e5-Gx
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 16:19:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gsDYH-00032T-KM
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 16:19:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gsCN9-0004fs-53
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:03:46 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x18I3qsx117011
	for <qemu-devel@nongnu.org>; Fri, 8 Feb 2019 13:17:55 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qhcqpx9ev-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 13:17:54 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 8 Feb 2019 18:17:52 -0000
From: Greg Kurz <groug@kaod.org>
Date: Fri, 08 Feb 2019 19:17:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <154964986747.291716.2679312373018476920.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH] spapr: Disallow unsupported kernel-irqchip
 settings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>

Split mode doesn't make sense on pseries, neither with XICS nor XIVE. But
passing kernel-irqchip=split silently behaves like kernel-irqchip=on.
Other architectures that support kernel-irqchip do terminate QEMU when
split mode is requested but not available though. Do the same with pseries
for consistency.

Similarly, passing kernel-irqchip=on,accel=tcg starts the machine with the
emulated interrupt controller, ie, behaves like kernel-irqchip=off. However,
when passing  kernel-irqchip=on,accel=kvm, if we can't initialize the KVM
XICS for some reason, ie, xics_kvm_init() fails, then QEMU is terminated.
This is inconsistent. Terminate QEMU all the same when requesting the
in-kernel interrupt controller without KVM.

Signed-off-by: Greg Kurz <groug@kaod.org>
---

The odds for someone to have an existing pseries setup with split mode are
very low since this is really an x86 thingy. And I guess we don't really
care to break the silly kernel-irqchip=on,accel=tcg case. But if we really
need to stay bug compatible, the errors can be turned into warnings.
---
 hw/ppc/spapr_irq.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 2d7a7c163876..80b0083b8e38 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -600,6 +600,19 @@ sPAPRIrq spapr_irq_dual = {
  */
 void spapr_irq_init(sPAPRMachineState *spapr, Error **errp)
 {
+    MachineState *machine = MACHINE(spapr);
+
+    if (machine_kernel_irqchip_split(machine)) {
+        error_setg(errp, "kernel_irqchip split mode not supported on pseries");
+        return;
+    }
+
+    if (!kvm_enabled() && machine_kernel_irqchip_required(machine)) {
+        error_setg(errp,
+                   "kernel_irqchip requested but only available with KVM");
+        return;
+    }
+
     /* Initialize the MSI IRQ allocator. */
     if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
         spapr_irq_msi_init(spapr, spapr->irq->nr_msis);
