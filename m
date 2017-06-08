Received: from eggs.gnu.org ([2001:4830:134:3::10]:57299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dIrUX-0000V0-Fv
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dIrUW-0007eT-GU
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:04:25 -0400
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Thu,  8 Jun 2017 17:03:50 +1000
Message-Id: <20170608070351.1434-5-sjitindarsingh@gmail.com>
In-Reply-To: <20170608070351.1434-1-sjitindarsingh@gmail.com>
References: <20170608070351.1434-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [PATCH 4/5] target/ppc: Enable the large decrementer
 for TCG and KVM guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, agraf@suse.de, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Let the guest use the large decrementer.

We have support for TCG and KVM guests to use the large decrementer and
to migrate guests using the large decrementer, so add the final bits to
indicate this capability to the guest.

The guest will use the large decrementer if the cpu model is >= POWER9
and the ibm,dec-bits device-tree property of the cpu node is present.
Add the ibm,dec-bits property to the device-tree when the hypervisor can
support it. After CAS enable the large decrementer if the guest is going
to use it, this means setting the LPCR_LD bit.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr.c       | 18 ++++++++++++++++++
 hw/ppc/spapr_hcall.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6ba869a..6f38939 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -554,6 +554,19 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
                           pcc->radix_page_info->count *
                           sizeof(radix_AP_encodings[0]))));
     }
+
+    /*
+     * We set this property to let the guest know that it can use the large
+     * decrementer and its width in bits. This means we must be on a processor
+     * with a large decrementer and the hypervisor must support it. In TCG the
+     * large decrementer is always supported, in KVM we check the hypervisor
+     * capability.
+     */
+    if (pcc->large_decr_bits && ((!kvm_enabled()) ||
+                                 kvmppc_has_cap_large_decr())) {
+        _FDT((fdt_setprop_u32(fdt, offset, "ibm,dec-bits",
+                              pcc->large_decr_bits)));
+    }
 }
 
 static void spapr_populate_cpus_dt_node(void *fdt, sPAPRMachineState *spapr)
@@ -1328,6 +1341,11 @@ static void ppc_spapr_reset(void)
         spapr_setup_hpt_and_vrma(spapr);
     }
 
+    /* We have to do this after vcpus are created since it calls ioctls */
+    if (kvm_enabled()) {
+        kvmppc_check_cap_large_decr();
+    }
+
     qemu_devices_reset();
 
     /*
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index aae5a62..c06421b 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1091,6 +1091,37 @@ static uint32_t cas_check_pvr(PowerPCCPU *cpu, target_ulong *addr,
     return best_compat;
 }
 
+static void cas_enable_large_decr(PowerPCCPU *cpu, sPAPRMachineState *spapr)
+{
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    bool guest_large_decr = false;
+
+    if (cpu->compat_pvr) {
+        guest_large_decr = cpu->compat_pvr >= CPU_POWERPC_LOGICAL_3_00;
+    } else {
+        guest_large_decr = (cpu->env.spr[SPR_PVR] & CPU_POWERPC_POWER_SERVER_MASK)
+                           >= CPU_POWERPC_POWER9_BASE;
+    }
+
+    if (guest_large_decr && ((!kvm_enabled()) ||
+                             kvmppc_has_cap_large_decr())) {
+        CPUState *cs;
+
+        CPU_FOREACH(cs) {
+            if (kvm_enabled()) {
+                kvmppc_configure_large_decrementer(cs, true);
+            } else {
+                set_spr(cs, SPR_LPCR, LPCR_LD, LPCR_LD);
+            }
+        }
+
+        spapr->large_decr_bits = pcc->large_decr_bits;
+    } else {
+        /* By default the large decrementer is already disabled */
+        spapr->large_decr_bits = 0;
+    }
+}
+
 static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
                                                   sPAPRMachineState *spapr,
                                                   target_ulong opcode,
@@ -1166,6 +1197,9 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     }
     spapr->cas_legacy_guest_workaround = !spapr_ovec_test(ov1_guest,
                                                           OV1_PPC_3_00);
+
+    cas_enable_large_decr(cpu, spapr);
+
     if (!spapr->cas_reboot) {
         spapr->cas_reboot =
             (spapr_h_cas_compose_response(spapr, args[1], args[2],
-- 
2.9.4
