Received: from eggs.gnu.org ([2001:4830:134:3::10]:59663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzaN-0001xm-HL
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzaM-0002Dr-8K
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:35 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:21:11 +1000
Message-Id: <20180427092126.24812-35-david@gibson.dropbear.id.au>
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 34/49] target/ppc: Avoid taking "env" parameter
 to mmu-hash64 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

In most cases we prefer to pass a PowerPCCPU rather than the (embedded)
CPUPPCState.

For ppc_hash64_update_{rmls,vrma}() change to take "cpu" instead of "env"=
.
For ppc_hash64_set_{dsi,isi}() remove the redundant "env" parameter.

In theory this makes more work for the functions, but since "cs", "cpu"
and "env" are related by at most constant offsets, the compiler should be
able to optimize out the difference at effectively zero cost.

helper_*() functions are left alone - since they're more closely tied to
the TCG generated code, passing "env" is still the standard there.

While we're there, fix an incorrect indentation.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/mmu-hash64.c     | 35 +++++++++++++++++++----------------
 target/ppc/mmu-hash64.h     |  4 ++--
 target/ppc/translate_init.c |  4 ++--
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index c9b72b7429..a87fa7c83f 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -633,9 +633,9 @@ unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCCPU =
*cpu,
     return 0;
 }
=20
-static void ppc_hash64_set_isi(CPUState *cs, CPUPPCState *env,
-                               uint64_t error_code)
+static void ppc_hash64_set_isi(CPUState *cs, uint64_t error_code)
 {
+    CPUPPCState *env =3D &POWERPC_CPU(cs)->env;
     bool vpm;
=20
     if (msr_ir) {
@@ -659,9 +659,9 @@ static void ppc_hash64_set_isi(CPUState *cs, CPUPPCSt=
ate *env,
     env->error_code =3D error_code;
 }
=20
-static void ppc_hash64_set_dsi(CPUState *cs, CPUPPCState *env, uint64_t =
dar,
-                               uint64_t dsisr)
+static void ppc_hash64_set_dsi(CPUState *cs, uint64_t dar, uint64_t dsis=
r)
 {
+    CPUPPCState *env =3D &POWERPC_CPU(cs)->env;
     bool vpm;
=20
     if (msr_dr) {
@@ -741,13 +741,13 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, va=
ddr eaddr,
             } else {
                 /* The access failed, generate the approriate interrupt =
*/
                 if (rwx =3D=3D 2) {
-                    ppc_hash64_set_isi(cs, env, SRR1_PROTFAULT);
+                    ppc_hash64_set_isi(cs, SRR1_PROTFAULT);
                 } else {
                     int dsisr =3D DSISR_PROTFAULT;
                     if (rwx =3D=3D 1) {
                         dsisr |=3D DSISR_ISSTORE;
                     }
-                    ppc_hash64_set_dsi(cs, env, eaddr, dsisr);
+                    ppc_hash64_set_dsi(cs, eaddr, dsisr);
                 }
                 return 1;
             }
@@ -783,7 +783,7 @@ skip_slb_search:
=20
     /* 3. Check for segment level no-execute violation */
     if ((rwx =3D=3D 2) && (slb->vsid & SLB_VSID_N)) {
-        ppc_hash64_set_isi(cs, env, SRR1_NOEXEC_GUARD);
+        ppc_hash64_set_isi(cs, SRR1_NOEXEC_GUARD);
         return 1;
     }
=20
@@ -791,13 +791,13 @@ skip_slb_search:
     ptex =3D ppc_hash64_htab_lookup(cpu, slb, eaddr, &pte, &apshift);
     if (ptex =3D=3D -1) {
         if (rwx =3D=3D 2) {
-            ppc_hash64_set_isi(cs, env, SRR1_NOPTE);
+            ppc_hash64_set_isi(cs, SRR1_NOPTE);
         } else {
             int dsisr =3D DSISR_NOPTE;
             if (rwx =3D=3D 1) {
                 dsisr |=3D DSISR_ISSTORE;
             }
-            ppc_hash64_set_dsi(cs, env, eaddr, dsisr);
+            ppc_hash64_set_dsi(cs, eaddr, dsisr);
         }
         return 1;
     }
@@ -824,7 +824,7 @@ skip_slb_search:
             if (PAGE_EXEC & ~amr_prot) {
                 srr1 |=3D SRR1_IAMR; /* Access violates virt pg class ke=
y prot */
             }
-            ppc_hash64_set_isi(cs, env, srr1);
+            ppc_hash64_set_isi(cs, srr1);
         } else {
             int dsisr =3D 0;
             if (need_prot[rwx] & ~pp_prot) {
@@ -836,7 +836,7 @@ skip_slb_search:
             if (need_prot[rwx] & ~amr_prot) {
                 dsisr |=3D DSISR_AMR;
             }
-            ppc_hash64_set_dsi(cs, env, eaddr, dsisr);
+            ppc_hash64_set_dsi(cs, eaddr, dsisr);
         }
         return 1;
     }
@@ -942,8 +942,9 @@ void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu, targe=
t_ulong ptex,
     cpu->env.tlb_need_flush =3D TLB_NEED_GLOBAL_FLUSH | TLB_NEED_LOCAL_F=
LUSH;
 }
=20
-void ppc_hash64_update_rmls(CPUPPCState *env)
+void ppc_hash64_update_rmls(PowerPCCPU *cpu)
 {
+    CPUPPCState *env =3D &cpu->env;
     uint64_t lpcr =3D env->spr[SPR_LPCR];
=20
     /*
@@ -976,8 +977,9 @@ void ppc_hash64_update_rmls(CPUPPCState *env)
     }
 }
=20
-void ppc_hash64_update_vrma(CPUPPCState *env)
+void ppc_hash64_update_vrma(PowerPCCPU *cpu)
 {
+    CPUPPCState *env =3D &cpu->env;
     const struct ppc_one_seg_page_size *sps =3D NULL;
     target_ulong esid, vsid, lpcr;
     ppc_slb_t *slb =3D &env->vrma_slb;
@@ -1002,7 +1004,7 @@ void ppc_hash64_update_vrma(CPUPPCState *env)
     vsid |=3D (vrmasd << 4) & (SLB_VSID_L | SLB_VSID_LP);
     esid =3D SLB_ESID_V;
=20
-   for (i =3D 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
+    for (i =3D 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
         const struct ppc_one_seg_page_size *sps1 =3D &env->sps.sps[i];
=20
         if (!sps1->page_shift) {
@@ -1028,6 +1030,7 @@ void ppc_hash64_update_vrma(CPUPPCState *env)
=20
 void helper_store_lpcr(CPUPPCState *env, target_ulong val)
 {
+    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
     uint64_t lpcr =3D 0;
=20
     /* Filter out bits */
@@ -1089,6 +1092,6 @@ void helper_store_lpcr(CPUPPCState *env, target_ulo=
ng val)
         ;
     }
     env->spr[SPR_LPCR] =3D lpcr;
-    ppc_hash64_update_rmls(env);
-    ppc_hash64_update_vrma(env);
+    ppc_hash64_update_rmls(cpu);
+    ppc_hash64_update_vrma(cpu);
 }
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index d297b97d37..95a8c330d6 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -17,8 +17,8 @@ void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu,
                                target_ulong pte0, target_ulong pte1);
 unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCCPU *cpu,
                                           uint64_t pte0, uint64_t pte1);
-void ppc_hash64_update_vrma(CPUPPCState *env);
-void ppc_hash64_update_rmls(CPUPPCState *env);
+void ppc_hash64_update_vrma(PowerPCCPU *cpu);
+void ppc_hash64_update_rmls(PowerPCCPU *cpu);
 #endif
=20
 /*
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 2ae718242a..29bd6f3654 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8975,8 +8975,8 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHy=
pervisor *vhyp)
     env->spr[SPR_AMOR] =3D amor->default_value =3D 0xffffffffffffffffull=
;
=20
     /* Update some env bits based on new LPCR value */
-    ppc_hash64_update_rmls(env);
-    ppc_hash64_update_vrma(env);
+    ppc_hash64_update_rmls(cpu);
+    ppc_hash64_update_vrma(cpu);
=20
     /* Tell KVM that we're in PAPR mode */
     if (kvm_enabled()) {
--=20
2.14.3
