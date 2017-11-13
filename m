Received: from eggs.gnu.org ([2001:4830:134:3::10]:50692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eEKdA-0002UZ-17
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 14:42:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eEKd5-0001Yx-8T
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 14:42:52 -0500
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:33042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eEKd4-0001Y1-Ve
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 14:42:47 -0500
Received: from player718.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 5F120CCB86
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 20:42:44 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 13 Nov 2017 20:42:39 +0100
Message-ID: <151060215918.17804.5898929119312944124.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH for-2.11] xics/kvm: synchonize state before
 'info pic'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

When using the emulated XICS, the 'info pic' monitor command shows:

CPU 0 XIRR=ff000000 ((nil)) PP=ff MFRR=ff
ICS 1000..13ff 0x10040060340
  1000 MSI 05 00
  1001 MSI 05 00
  1002 MSI 05 00
  1003 MSI ff 00
  1004 LSI ff 00
  1005 LSI ff 00
  1006 LSI ff 00
  1007 LSI ff 00
  1008 MSI 05 00
  1009 MSI 05 00
  100a MSI 05 00
  100b MSI 05 00
  100c MSI 05 00

but when using the in-kernel XICS with the very same guest, we get:

CPU 0 XIRR=00000000 ((nil)) PP=ff MFRR=ff
ICS 1000..13ff 0x10032e00340
  1000 MSI ff 00
  1001 MSI ff 00
  1002 MSI ff 00
  1003 MSI ff 00
  1004 LSI ff 00
  1005 LSI ff 00
  1006 LSI ff 00
  1007 LSI ff 00
  1008 MSI ff 00
  1009 MSI ff 00
  100a MSI ff 00
  100b MSI ff 00
  100c MSI ff 00

ie, all irqs are masked and XIRR is null, while we should get the
same output as with the emulated XICS.

If the guest is then migrated, 'info pic' shows the expected values
on both source and destination.

The problem is that QEMU doesn't synchronize with KVM before printing
the XICS state. Migration happens to fix the output because it enforces
synchronization with KVM.

To fix the invalid output of 'info pic', this patch introduces a new
synchronize_state operation for both ICPStateClass and ICSStateClass.
The ICP operation relies on run_on_cpu() in order to kick the vCPU
and avoid sleeping on KVM_GET_ONE_REG.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics.c        |   11 +++++++++++
 hw/intc/xics_kvm.c    |   19 +++++++++++++++++++
 include/hw/ppc/xics.h |    2 ++
 3 files changed, 32 insertions(+)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index cc9816e7f204..a1cc0e420c98 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -40,11 +40,17 @@
 
 void icp_pic_print_info(ICPState *icp, Monitor *mon)
 {
+    ICPStateClass *icpc = ICP_GET_CLASS(icp);
     int cpu_index = icp->cs ? icp->cs->cpu_index : -1;
 
     if (!icp->output) {
         return;
     }
+
+    if (icpc->synchronize_state) {
+        icpc->synchronize_state(icp);
+    }
+
     monitor_printf(mon, "CPU %d XIRR=%08x (%p) PP=%02x MFRR=%02x\n",
                    cpu_index, icp->xirr, icp->xirr_owner,
                    icp->pending_priority, icp->mfrr);
@@ -52,6 +58,7 @@ void icp_pic_print_info(ICPState *icp, Monitor *mon)
 
 void ics_pic_print_info(ICSState *ics, Monitor *mon)
 {
+    ICSStateClass *icsc = ICS_BASE_GET_CLASS(ics);
     uint32_t i;
 
     monitor_printf(mon, "ICS %4x..%4x %p\n",
@@ -61,6 +68,10 @@ void ics_pic_print_info(ICSState *ics, Monitor *mon)
         return;
     }
 
+    if (icsc->synchronize_state) {
+        icsc->synchronize_state(ics);
+    }
+
     for (i = 0; i < ics->nr_irqs; i++) {
         ICSIRQState *irq = ics->irqs + i;
 
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 3091ad3ac2c8..89fb20e2c55c 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -81,6 +81,18 @@ static void icp_get_kvm_state(ICPState *icp)
         & KVM_REG_PPC_ICP_PPRI_MASK;
 }
 
+static void do_icp_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
+{
+    icp_get_kvm_state(arg.host_ptr);
+}
+
+static void icp_synchronize_state(ICPState *icp)
+{
+    if (icp->cs) {
+        run_on_cpu(icp->cs, do_icp_synchronize_state, RUN_ON_CPU_HOST_PTR(icp));
+    }
+}
+
 static int icp_set_kvm_state(ICPState *icp, int version_id)
 {
     uint64_t state;
@@ -156,6 +168,7 @@ static void icp_kvm_class_init(ObjectClass *klass, void *data)
     icpc->post_load = icp_set_kvm_state;
     icpc->realize = icp_kvm_realize;
     icpc->reset = icp_kvm_reset;
+    icpc->synchronize_state = icp_synchronize_state;
 }
 
 static const TypeInfo icp_kvm_info = {
@@ -234,6 +247,11 @@ static void ics_get_kvm_state(ICSState *ics)
     }
 }
 
+static void ics_synchronize_state(ICSState *ics)
+{
+    ics_get_kvm_state(ics);
+}
+
 static int ics_set_kvm_state(ICSState *ics, int version_id)
 {
     uint64_t state;
@@ -347,6 +365,7 @@ static void ics_kvm_class_init(ObjectClass *klass, void *data)
     icsc->realize = ics_kvm_realize;
     icsc->pre_save = ics_get_kvm_state;
     icsc->post_load = ics_set_kvm_state;
+    icsc->synchronize_state = ics_synchronize_state;
 }
 
 static const TypeInfo ics_kvm_info = {
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 28d248abad61..2df99be111ce 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -69,6 +69,7 @@ struct ICPStateClass {
     void (*pre_save)(ICPState *icp);
     int (*post_load)(ICPState *icp, int version_id);
     void (*reset)(ICPState *icp);
+    void (*synchronize_state)(ICPState *icp);
 };
 
 struct ICPState {
@@ -119,6 +120,7 @@ struct ICSStateClass {
     void (*reject)(ICSState *s, uint32_t irq);
     void (*resend)(ICSState *s);
     void (*eoi)(ICSState *s, uint32_t irq);
+    void (*synchronize_state)(ICSState *s);
 };
 
 struct ICSState {
