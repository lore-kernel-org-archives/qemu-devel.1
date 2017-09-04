Received: from eggs.gnu.org ([2001:4830:134:3::10]:47313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dozDT-00040q-2d
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 17:47:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dozDO-0003DF-9U
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 17:47:35 -0400
Received: from 3.mo178.mail-out.ovh.net ([46.105.44.197]:59569)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dozDO-0003C9-3L
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 17:47:30 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id BE85A512D6
	for <qemu-devel@nongnu.org>; Mon,  4 Sep 2017 23:47:28 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 04 Sep 2017 23:47:24 +0200
Message-ID: <150456164425.17000.14656319266821117631.stgit@bahia.lan>
In-Reply-To: <150456160452.17000.3290192176290246589.stgit@bahia.lan>
References: <150456160452.17000.3290192176290246589.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 4/4] ppc: kvm: update HPT pointer in KVM PR
 after migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Thomas Huth <thuth@redhat.com>

When running with KVM PR, a pseries machine needs to allocate an HPT in
userspace and pass its address to KVM. This is done by hijacking the SDR1
slot.

It is very likely that the destination QEMU will allocate the HPT at
a different address, ie, the SDR1 value we get from the migration
stream is wrong and the guest ends up badly broken.

Let's fix this by re-computing the appropriate value for SDR1 and pushing
it to KVM at CPU post load. This is achieved by extending the PPC virtual
hypervisor interface.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c       |    6 ++++++
 target/ppc/cpu.h     |    1 +
 target/ppc/machine.c |    7 +++++++
 3 files changed, 14 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index bf24c26b756d..11c65563bb6e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1299,6 +1299,11 @@ target_ulong spapr_get_hpt_pointer(sPAPRMachineState *spapr)
     return (target_ulong)(uintptr_t)spapr->htab | (spapr->htab_shift - 18);
 }
 
+static target_ulong get_spapr_hpt_pointer(PPCVirtualHypervisor *vhyp)
+{
+    return spapr_get_hpt_pointer(SPAPR_MACHINE(vhyp));
+}
+
 int spapr_hpt_shift_for_ramsize(uint64_t ramsize)
 {
     int shift;
@@ -3613,6 +3618,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     vhc->unmap_hptes = spapr_unmap_hptes;
     vhc->store_hpte = spapr_store_hpte;
     vhc->get_patbe = spapr_get_patbe;
+    vhc->get_hpt_pointer = get_spapr_hpt_pointer;
     xic->ics_get = spapr_ics_get;
     xic->ics_resend = spapr_ics_resend;
     xic->icp_get = spapr_icp_get;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index c9d3ffa89bcb..bb1d61c9358c 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1243,6 +1243,7 @@ struct PPCVirtualHypervisorClass {
     void (*store_hpte)(PPCVirtualHypervisor *vhyp, hwaddr ptex,
                        uint64_t pte0, uint64_t pte1);
     uint64_t (*get_patbe)(PPCVirtualHypervisor *vhyp);
+    target_ulong (*get_hpt_pointer)(PPCVirtualHypervisor *vhyp);
 };
 
 #define TYPE_PPC_VIRTUAL_HYPERVISOR "ppc-virtual-hypervisor"
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index e36b7100cb66..6ec4b3214a2d 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -294,6 +294,13 @@ static int cpu_post_load(void *opaque, int version_id)
 
     if (!cpu->vhyp) {
         ppc_store_sdr1(env, env->spr[SPR_SDR1]);
+    } else if (kvm_enabled()) {
+        PPCVirtualHypervisorClass *vhc =
+            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+        target_ulong sdr1 = vhc->get_hpt_pointer(cpu->vhyp);
+        if (sdr1) {
+            kvmppc_update_sdr1(cpu, sdr1);
+        }
     }
 
     /* Invalidate all msr bits except MSR_TGPR/MSR_HVB before restoring */
