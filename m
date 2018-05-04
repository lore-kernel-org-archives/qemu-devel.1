Received: from eggs.gnu.org ([2001:4830:134:3::10]:43177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fETkr-00062V-AG
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fETkn-0007He-Fm
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:59:41 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  4 May 2018 15:59:17 +1000
Message-Id: <20180504055930.3786-5-david@gibson.dropbear.id.au>
In-Reply-To: <20180504055930.3786-1-david@gibson.dropbear.id.au>
References: <20180504055930.3786-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/17] target/ppc: Add ppc_store_lpcr() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

There are some fields in the cpu state which need to be updated when the
LPCR register is changed, which is done by ppc_hash64_update_rmls() and
ppc_hash64_update_vrma().  Code which alters env->spr[SPR_LPCR] needs to
call them afterwards to make sure the state is up to date.

That's easy to get wrong.  The normal way of dealing with sitautions like
that is to use a helper which both updates the basic register value and t=
he
derived state.

So, do that.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/mmu-hash64.c     | 15 +++++++++++----
 target/ppc/mmu-hash64.h     |  3 +--
 target/ppc/translate_init.c |  6 +-----
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 7e0adecfd9..a1db20e3a8 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -942,7 +942,7 @@ void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu, targe=
t_ulong ptex,
     cpu->env.tlb_need_flush =3D TLB_NEED_GLOBAL_FLUSH | TLB_NEED_LOCAL_F=
LUSH;
 }
=20
-void ppc_hash64_update_rmls(PowerPCCPU *cpu)
+static void ppc_hash64_update_rmls(PowerPCCPU *cpu)
 {
     CPUPPCState *env =3D &cpu->env;
     uint64_t lpcr =3D env->spr[SPR_LPCR];
@@ -977,7 +977,7 @@ void ppc_hash64_update_rmls(PowerPCCPU *cpu)
     }
 }
=20
-void ppc_hash64_update_vrma(PowerPCCPU *cpu)
+static void ppc_hash64_update_vrma(PowerPCCPU *cpu)
 {
     CPUPPCState *env =3D &cpu->env;
     const PPCHash64SegmentPageSizes *sps =3D NULL;
@@ -1028,9 +1028,9 @@ void ppc_hash64_update_vrma(PowerPCCPU *cpu)
     slb->sps =3D sps;
 }
=20
-void helper_store_lpcr(CPUPPCState *env, target_ulong val)
+void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val)
 {
-    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
+    CPUPPCState *env =3D &cpu->env;
     uint64_t lpcr =3D 0;
=20
     /* Filter out bits */
@@ -1096,6 +1096,13 @@ void helper_store_lpcr(CPUPPCState *env, target_ul=
ong val)
     ppc_hash64_update_vrma(cpu);
 }
=20
+void helper_store_lpcr(CPUPPCState *env, target_ulong val)
+{
+    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
+
+    ppc_store_lpcr(cpu, val);
+}
+
 void ppc_hash64_init(PowerPCCPU *cpu)
 {
     CPUPPCState *env =3D &cpu->env;
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index f6349ccdb3..53dcec5b93 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -17,8 +17,7 @@ void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu,
                                target_ulong pte0, target_ulong pte1);
 unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCCPU *cpu,
                                           uint64_t pte0, uint64_t pte1);
-void ppc_hash64_update_vrma(PowerPCCPU *cpu);
-void ppc_hash64_update_rmls(PowerPCCPU *cpu);
+void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val);
 void ppc_hash64_init(PowerPCCPU *cpu);
 void ppc_hash64_finalize(PowerPCCPU *cpu);
 #endif
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index c83c910a29..3fd380dad6 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8940,15 +8940,11 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtual=
Hypervisor *vhyp)
     /* We should be followed by a CPU reset but update the active value
      * just in case...
      */
-    env->spr[SPR_LPCR] =3D lpcr->default_value;
+    ppc_store_lpcr(cpu, lpcr->default_value);
=20
     /* Set a full AMOR so guest can use the AMR as it sees fit */
     env->spr[SPR_AMOR] =3D amor->default_value =3D 0xffffffffffffffffull=
;
=20
-    /* Update some env bits based on new LPCR value */
-    ppc_hash64_update_rmls(cpu);
-    ppc_hash64_update_vrma(cpu);
-
     /* Tell KVM that we're in PAPR mode */
     if (kvm_enabled()) {
         kvmppc_set_papr(cpu);
--=20
2.17.0
