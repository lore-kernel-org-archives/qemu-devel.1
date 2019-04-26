Received: from eggs.gnu.org ([209.51.188.92]:60474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu12-00065T-1s
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0y-00056S-4c
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:19 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:06:11 +1000
Message-Id: <20190426060627.18153-21-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/36] target/ppc: Style fixes for mmu_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/mmu_helper.c | 137 ++++++++++++++++++++++++----------------
 1 file changed, 84 insertions(+), 53 deletions(-)

diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index ab72473eeb..d226b35739 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -33,11 +33,11 @@
 #include "mmu-book3s-v3.h"
 #include "mmu-radix64.h"
=20
-//#define DEBUG_MMU
-//#define DEBUG_BATS
-//#define DEBUG_SOFTWARE_TLB
-//#define DUMP_PAGE_TABLES
-//#define FLUSH_ALL_TLBS
+/* #define DEBUG_MMU */
+/* #define DEBUG_BATS */
+/* #define DEBUG_SOFTWARE_TLB */
+/* #define DUMP_PAGE_TABLES */
+/* #define FLUSH_ALL_TLBS */
=20
 #ifdef DEBUG_MMU
 #  define LOG_MMU_STATE(cpu) log_cpu_state_mask(CPU_LOG_MMU, (cpu), 0)
@@ -152,7 +152,8 @@ static int check_prot(int prot, int rw, int access_ty=
pe)
 }
=20
 static inline int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0=
,
-                                       target_ulong pte1, int h, int rw,=
 int type)
+                                       target_ulong pte1, int h,
+                                       int rw, int type)
 {
     target_ulong ptem, mmask;
     int access, ret, pteh, ptev, pp;
@@ -332,7 +333,8 @@ static inline int ppc6xx_tlb_check(CPUPPCState *env, =
mmu_ctx_t *ctx,
                   pte_is_valid(tlb->pte0) ? "valid" : "inval",
                   tlb->EPN, eaddr, tlb->pte1,
                   rw ? 'S' : 'L', access_type =3D=3D ACCESS_CODE ? 'I' :=
 'D');
-        switch (ppc6xx_tlb_pte_check(ctx, tlb->pte0, tlb->pte1, 0, rw, a=
ccess_type)) {
+        switch (ppc6xx_tlb_pte_check(ctx, tlb->pte0, tlb->pte1,
+                                     0, rw, access_type)) {
         case -3:
             /* TLB inconsistency */
             return -1;
@@ -347,9 +349,11 @@ static inline int ppc6xx_tlb_check(CPUPPCState *env,=
 mmu_ctx_t *ctx,
             break;
         case 0:
             /* access granted */
-            /* XXX: we should go on looping to check all TLBs consistenc=
y
-             *      but we can speed-up the whole thing as the
-             *      result would be undefined if TLBs are not consistent=
.
+            /*
+             * XXX: we should go on looping to check all TLBs
+             *      consistency but we can speed-up the whole thing as
+             *      the result would be undefined if TLBs are not
+             *      consistent.
              */
             ret =3D 0;
             best =3D nr;
@@ -550,14 +554,18 @@ static inline int get_segment_6xx_tlb(CPUPPCState *=
env, mmu_ctx_t *ctx,
         qemu_log_mask(CPU_LOG_MMU, "direct store...\n");
         /* Direct-store segment : absolutely *BUGGY* for now */
=20
-        /* Direct-store implies a 32-bit MMU.
+        /*
+         * Direct-store implies a 32-bit MMU.
          * Check the Segment Register's bus unit ID (BUID).
          */
         sr =3D env->sr[eaddr >> 28];
         if ((sr & 0x1FF00000) >> 20 =3D=3D 0x07f) {
-            /* Memory-forced I/O controller interface access */
-            /* If T=3D1 and BUID=3Dx'07F', the 601 performs a memory acc=
ess
-             * to SR[28-31] LA[4-31], bypassing all protection mechanism=
s.
+            /*
+             * Memory-forced I/O controller interface access
+             *
+             * If T=3D1 and BUID=3Dx'07F', the 601 performs a memory
+             * access to SR[28-31] LA[4-31], bypassing all protection
+             * mechanisms.
              */
             ctx->raddr =3D ((sr & 0xF) << 28) | (eaddr & 0x0FFFFFFF);
             ctx->prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
@@ -578,9 +586,11 @@ static inline int get_segment_6xx_tlb(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
             /* lwarx, ldarx or srwcx. */
             return -4;
         case ACCESS_CACHE:
-            /* dcba, dcbt, dcbtst, dcbf, dcbi, dcbst, dcbz, or icbi */
-            /* Should make the instruction do no-op.
-             * As it already do no-op, it's quite easy :-)
+            /*
+             * dcba, dcbt, dcbtst, dcbf, dcbi, dcbst, dcbz, or icbi
+             *
+             * Should make the instruction do no-op.  As it already do
+             * no-op, it's quite easy :-)
              */
             ctx->raddr =3D eaddr;
             return 0;
@@ -942,12 +952,14 @@ static uint32_t mmubooke206_esr(int mmu_idx, bool r=
w)
     return esr;
 }
=20
-/* Get EPID register given the mmu_idx. If this is regular load,
- * construct the EPID access bits from current processor state  */
-
-/* Get the effective AS and PR bits and the PID. The PID is returned onl=
y if
- * EPID load is requested, otherwise the caller must detect the correct =
EPID.
- * Return true if valid EPID is returned. */
+/*
+ * Get EPID register given the mmu_idx. If this is regular load,
+ * construct the EPID access bits from current processor state
+ *
+ * Get the effective AS and PR bits and the PID. The PID is returned
+ * only if EPID load is requested, otherwise the caller must detect
+ * the correct EPID.  Return true if valid EPID is returned.
+ */
 static bool mmubooke206_get_as(CPUPPCState *env,
                                int mmu_idx, uint32_t *epid_out,
                                bool *as_out, bool *pr_out)
@@ -1369,8 +1381,9 @@ static inline int check_physical(CPUPPCState *env, =
mmu_ctx_t *ctx,
=20
     case POWERPC_MMU_SOFT_4xx_Z:
         if (unlikely(msr_pe !=3D 0)) {
-            /* 403 family add some particular protections,
-             * using PBL/PBU registers for accesses with no translation.
+            /*
+             * 403 family add some particular protections, using
+             * PBL/PBU registers for accesses with no translation.
              */
             in_plb =3D
                 /* Check PLB validity */
@@ -1453,7 +1466,8 @@ static int get_physical_address_wtlb(
         if (real_mode) {
             ret =3D check_physical(env, ctx, eaddr, rw);
         } else {
-            cpu_abort(CPU(cpu), "PowerPC in real mode do not do any tran=
slation\n");
+            cpu_abort(CPU(cpu),
+                      "PowerPC in real mode do not do any translation\n"=
);
         }
         return -1;
     default:
@@ -1498,9 +1512,10 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs, v=
addr addr)
=20
     if (unlikely(get_physical_address(env, &ctx, addr, 0, ACCESS_INT) !=3D=
 0)) {
=20
-        /* Some MMUs have separate TLBs for code and data. If we only tr=
y an
-         * ACCESS_INT, we may not be able to read instructions mapped by=
 code
-         * TLBs, so we also try a ACCESS_CODE.
+        /*
+         * Some MMUs have separate TLBs for code and data. If we only
+         * try an ACCESS_INT, we may not be able to read instructions
+         * mapped by code TLBs, so we also try a ACCESS_CODE.
          */
         if (unlikely(get_physical_address(env, &ctx, addr, 0,
                                           ACCESS_CODE) !=3D 0)) {
@@ -1834,8 +1849,9 @@ void helper_store_ibatu(CPUPPCState *env, uint32_t =
nr, target_ulong value)
 #if !defined(FLUSH_ALL_TLBS)
         do_invalidate_BAT(env, env->IBAT[0][nr], mask);
 #endif
-        /* When storing valid upper BAT, mask BEPI and BRPN
-         * and invalidate all TLBs covered by this BAT
+        /*
+         * When storing valid upper BAT, mask BEPI and BRPN and
+         * invalidate all TLBs covered by this BAT
          */
         mask =3D (value << 15) & 0x0FFE0000UL;
         env->IBAT[0][nr] =3D (value & 0x00001FFFUL) |
@@ -1865,8 +1881,9 @@ void helper_store_dbatu(CPUPPCState *env, uint32_t =
nr, target_ulong value)
=20
     dump_store_bat(env, 'D', 0, nr, value);
     if (env->DBAT[0][nr] !=3D value) {
-        /* When storing valid upper BAT, mask BEPI and BRPN
-         * and invalidate all TLBs covered by this BAT
+        /*
+         * When storing valid upper BAT, mask BEPI and BRPN and
+         * invalidate all TLBs covered by this BAT
          */
         mask =3D (value << 15) & 0x0FFE0000UL;
 #if !defined(FLUSH_ALL_TLBS)
@@ -1913,8 +1930,9 @@ void helper_store_601_batu(CPUPPCState *env, uint32=
_t nr, target_ulong value)
             do_inval =3D 1;
 #endif
         }
-        /* When storing valid upper BAT, mask BEPI and BRPN
-         * and invalidate all TLBs covered by this BAT
+        /*
+         * When storing valid upper BAT, mask BEPI and BRPN and
+         * invalidate all TLBs covered by this BAT
          */
         env->IBAT[0][nr] =3D (value & 0x00001FFFUL) |
             (value & ~0x0001FFFFUL & ~mask);
@@ -2027,7 +2045,8 @@ void ppc_tlb_invalidate_one(CPUPPCState *env, targe=
t_ulong addr)
 #if defined(TARGET_PPC64)
     if (env->mmu_model & POWERPC_MMU_64) {
         /* tlbie invalidate TLBs for all segments */
-        /* XXX: given the fact that there are too many segments to inval=
idate,
+        /*
+         * XXX: given the fact that there are too many segments to inval=
idate,
          *      and we still don't have a tlb_flush_mask(env, n, mask) i=
n QEMU,
          *      we just invalidate all TLBs
          */
@@ -2044,10 +2063,11 @@ void ppc_tlb_invalidate_one(CPUPPCState *env, tar=
get_ulong addr)
         break;
     case POWERPC_MMU_32B:
     case POWERPC_MMU_601:
-        /* Actual CPUs invalidate entire congruence classes based on the
-         * geometry of their TLBs and some OSes take that into account,
-         * we just mark the TLB to be flushed later (context synchronizi=
ng
-         * event or sync instruction on 32-bit).
+        /*
+         * Actual CPUs invalidate entire congruence classes based on
+         * the geometry of their TLBs and some OSes take that into
+         * account, we just mark the TLB to be flushed later (context
+         * synchronizing event or sync instruction on 32-bit).
          */
         env->tlb_need_flush |=3D TLB_NEED_LOCAL_FLUSH;
         break;
@@ -2152,8 +2172,10 @@ void helper_store_sr(CPUPPCState *env, target_ulon=
g srnum, target_ulong value)
 #endif
     if (env->sr[srnum] !=3D value) {
         env->sr[srnum] =3D value;
-/* Invalidating 256MB of virtual memory in 4kB pages is way longer than
-   flusing the whole TLB. */
+        /*
+         * Invalidating 256MB of virtual memory in 4kB pages is way
+         * longer than flusing the whole TLB.
+         */
 #if !defined(FLUSH_ALL_TLBS) && 0
         {
             target_ulong page, end;
@@ -2264,10 +2286,12 @@ target_ulong helper_rac(CPUPPCState *env, target_=
ulong addr)
     int nb_BATs;
     target_ulong ret =3D 0;
=20
-    /* We don't have to generate many instances of this instruction,
+    /*
+     * We don't have to generate many instances of this instruction,
      * as rac is supervisor only.
+     *
+     * XXX: FIX THIS: Pretend we have no BAT
      */
-    /* XXX: FIX THIS: Pretend we have no BAT */
     nb_BATs =3D env->nb_BATs;
     env->nb_BATs =3D 0;
     if (get_physical_address(env, &ctx, addr, 0, ACCESS_INT) =3D=3D 0) {
@@ -2422,7 +2446,8 @@ void helper_4xx_tlbwe_hi(CPUPPCState *env, target_u=
long entry,
     }
     tlb->size =3D booke_tlb_to_page_size((val >> PPC4XX_TLBHI_SIZE_SHIFT=
)
                                        & PPC4XX_TLBHI_SIZE_MASK);
-    /* We cannot handle TLB size < TARGET_PAGE_SIZE.
+    /*
+     * We cannot handle TLB size < TARGET_PAGE_SIZE.
      * If this ever occurs, we should implement TARGET_PAGE_BITS_VARY
      */
     if ((val & PPC4XX_TLBHI_V) && tlb->size < TARGET_PAGE_SIZE) {
@@ -2742,7 +2767,8 @@ void helper_booke206_tlbwe(CPUPPCState *env)
     }
=20
     if (tlb->mas1 & MAS1_VALID) {
-        /* Invalidate the page in QEMU TLB if it was a valid entry.
+        /*
+         * Invalidate the page in QEMU TLB if it was a valid entry.
          *
          * In "PowerPC e500 Core Family Reference Manual, Rev. 1",
          * Section "12.4.2 TLB Write Entry (tlbwe) Instruction":
@@ -2751,7 +2777,8 @@ void helper_booke206_tlbwe(CPUPPCState *env)
          * "Note that when an L2 TLB entry is written, it may be displac=
ing an
          * already valid entry in the same L2 TLB location (a victim). I=
f a
          * valid L1 TLB entry corresponds to the L2 MMU victim entry, th=
at L1
-         * TLB entry is automatically invalidated." */
+         * TLB entry is automatically invalidated."
+         */
         flush_page(env, tlb);
     }
=20
@@ -2777,8 +2804,9 @@ void helper_booke206_tlbwe(CPUPPCState *env)
     mask |=3D MAS2_ACM | MAS2_VLE | MAS2_W | MAS2_I | MAS2_M | MAS2_G | =
MAS2_E;
=20
     if (!msr_cm) {
-        /* Executing a tlbwe instruction in 32-bit mode will set
-         * bits 0:31 of the TLB EPN field to zero.
+        /*
+         * Executing a tlbwe instruction in 32-bit mode will set bits
+         * 0:31 of the TLB EPN field to zero.
          */
         mask &=3D 0xffffffff;
     }
@@ -3022,10 +3050,13 @@ void helper_check_tlb_flush_global(CPUPPCState *e=
nv)
=20
 /***********************************************************************=
******/
=20
-/* try to fill the TLB and return an exception if error. If retaddr is
-   NULL, it means that the function was called in C code (i.e. not
-   from generated code or from helper.c) */
-/* XXX: fix it to restore all registers */
+/*
+ * try to fill the TLB and return an exception if error. If retaddr is
+ * NULL, it means that the function was called in C code (i.e. not
+ * from generated code or from helper.c)
+ *
+ * XXX: fix it to restore all registers
+ */
 void tlb_fill(CPUState *cs, target_ulong addr, int size,
               MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
--=20
2.20.1
