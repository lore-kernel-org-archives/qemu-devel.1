Received: from eggs.gnu.org ([209.51.188.92]:57399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkC-0004Sl-2r
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:53:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUjz-0000fn-9J
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:53:18 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:17 +1100
Message-Id: <20190226045304.25618-4-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/50] target/ppc: Fix support for "STOP light"
 states on POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

STOP must act differently based on PSSCR:EC on POWER9. When set, it
acts like the P7/P8 power management instructions and wake up at 0x100
based on the wakeup conditions in LPCR.

When PSSCR:EC is clear however it will wakeup at the next instruction
after STOP (if EE is clear) or take the corresponding interrupts (if
EE is set).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20190215161648.9600-4-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu-qom.h            |  1 +
 target/ppc/cpu.h                | 12 +++++++++---
 target/ppc/excp_helper.c        |  8 ++++++--
 target/ppc/translate.c          | 13 ++++++++++++-
 target/ppc/translate_init.inc.c |  7 +++++++
 5 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index 3130802304..e9cb158423 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -122,6 +122,7 @@ typedef enum {
     PPC_PM_NAP,
     PPC_PM_SLEEP,
     PPC_PM_RVWINKLE,
+    PPC_PM_STOP,
 } powerpc_pm_insn_t;
=20
 /***********************************************************************=
******/
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 325ebbeb98..5b1899bfc9 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -414,6 +414,10 @@ struct ppc_slb_t {
 #define LPCR_HVICE        PPC_BIT(62) /* HV Virtualisation Int Enable */
 #define LPCR_HDICE        PPC_BIT(63)
=20
+/* PSSCR bits */
+#define PSSCR_ESL         PPC_BIT(42) /* Enable State Loss */
+#define PSSCR_EC          PPC_BIT(43) /* Exit Criterion */
+
 #define msr_sf   ((env->msr >> MSR_SF)   & 1)
 #define msr_isf  ((env->msr >> MSR_ISF)  & 1)
 #define msr_shv  ((env->msr >> MSR_SHV)  & 1)
@@ -1110,9 +1114,11 @@ struct CPUPPCState {
      * instructions and SPRs are diallowed if MSR:HV is 0
      */
     bool has_hv_mode;
-    /* On P7/P8, set when in PM state, we need to handle resume
-     * in a special way (such as routing some resume causes to
-     * 0x100), so flag this here.
+
+    /*
+     * On P7/P8/P9, set when in PM state, we need to handle resume in
+     * a special way (such as routing some resume causes to 0x100), so
+     * flag this here.
      */
     bool in_pm_state;
 #endif
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 7c7c8d1b9d..97503193ef 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -97,7 +97,10 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int e=
xcp_model, int excp)
     asrr0 =3D -1;
     asrr1 =3D -1;
=20
-    /* check for special resume at 0x100 from doze/nap/sleep/winkle on P=
7/P8 */
+    /*
+     * check for special resume at 0x100 from doze/nap/sleep/winkle on
+     * P7/P8/P9
+     */
     if (env->in_pm_state) {
         env->in_pm_state =3D false;
=20
@@ -960,7 +963,8 @@ void helper_pminsn(CPUPPCState *env, powerpc_pm_insn_=
t insn)
     env->pending_interrupts &=3D ~(1 << PPC_INTERRUPT_HDECR);
=20
     /* Condition for waking up at 0x100 */
-    env->in_pm_state =3D true;
+    env->in_pm_state =3D (insn !=3D PPC_PM_STOP) ||
+        (env->spr[SPR_PSSCR] & PSSCR_EC);
 }
 #endif /* defined(TARGET_PPC64) */
=20
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index bffdbd9687..fde7ead7b7 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3589,7 +3589,18 @@ static void gen_nap(DisasContext *ctx)
=20
 static void gen_stop(DisasContext *ctx)
 {
-    gen_nap(ctx);
+#if defined(CONFIG_USER_ONLY)
+    GEN_PRIV;
+#else
+    TCGv_i32 t;
+
+    CHK_HV;
+    t =3D tcg_const_i32(PPC_PM_STOP);
+    gen_helper_pminsn(cpu_env, t);
+    tcg_temp_free_i32(t);
+    /* Stop translation, as the CPU is supposed to sleep from now */
+    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
+#endif /* defined(CONFIG_USER_ONLY) */
 }
=20
 static void gen_sleep(DisasContext *ctx)
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index d884906004..8b1d324b3b 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8801,9 +8801,16 @@ static bool cpu_has_work_POWER9(CPUState *cs)
     CPUPPCState *env =3D &cpu->env;
=20
     if (cs->halted) {
+        uint64_t psscr =3D env->spr[SPR_PSSCR];
+
         if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
             return false;
         }
+
+        /* If EC is clear, just return true on any pending interrupt */
+        if (!(psscr & PSSCR_EC)) {
+            return true;
+        }
         /* External Exception */
         if ((env->pending_interrupts & (1u << PPC_INTERRUPT_EXT)) &&
             (env->spr[SPR_LPCR] & LPCR_EEE)) {
--=20
2.20.1
