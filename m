Received: from eggs.gnu.org ([209.51.188.92]:46383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1h1PhS-0006FM-Ir
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 01:06:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1h1PhO-000519-Mh
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 01:06:42 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Wed,  6 Mar 2019 17:06:08 +1100
Message-Id: <20190306060608.19935-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH] target/ppc/spapr: Enable
 H_PAGE_INIT in-kernel handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The H_CALL H_PAGE_INIT can be used to zero or copy a page of guest
memory. Enable the in-kernel H_PAGE_INIT handler.

The in-kernel handler takes half the time to complete compared to
handling the H_CALL in userspace.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr.c       | 3 +++
 target/ppc/kvm.c     | 5 +++++
 target/ppc/kvm_ppc.h | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index cf1ef9ebd4..8ce97ff1e7 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2822,6 +2822,9 @@ static void spapr_machine_init(MachineState *machine)
 
         /* H_CLEAR_MOD/_REF are mandatory in PAPR, but off by default */
         kvmppc_enable_clear_ref_mod_hcalls();
+
+        /* Enable H_PAGE_INIT */
+        kvmppc_enable_h_page_init();
     }
 
     /* allocate RAM */
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 4e3f1e4b78..d0bfb076df 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2043,6 +2043,11 @@ void kvmppc_enable_clear_ref_mod_hcalls(void)
     kvmppc_enable_hcall(kvm_state, H_CLEAR_MOD);
 }
 
+void kvmppc_enable_h_page_init(void)
+{
+    kvmppc_enable_hcall(kvm_state, H_PAGE_INIT);
+}
+
 void kvmppc_set_papr(PowerPCCPU *cpu)
 {
     CPUState *cs = CPU(cpu);
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 2937b36cae..2c2ea30e87 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -23,6 +23,7 @@ int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq, int level);
 void kvmppc_enable_logical_ci_hcalls(void);
 void kvmppc_enable_set_mode_hcall(void);
 void kvmppc_enable_clear_ref_mod_hcalls(void);
+void kvmppc_enable_h_page_init(void);
 void kvmppc_set_papr(PowerPCCPU *cpu);
 int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
 void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
@@ -138,6 +139,10 @@ static inline void kvmppc_enable_clear_ref_mod_hcalls(void)
 {
 }
 
+static inline void kvmppc_enable_h_page_init(void)
+{
+}
+
 static inline void kvmppc_set_papr(PowerPCCPU *cpu)
 {
 }
-- 
2.13.6
