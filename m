Received: from eggs.gnu.org ([209.51.188.92]:38475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3VJ-00057D-Nw
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:46:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3VI-0002wL-12
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:46:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1go3VH-0002ud-N2
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:46:55 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0S9idZG002979
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:46:54 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q9xgjjm09-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:46:54 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Mon, 28 Jan 2019 09:46:52 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 28 Jan 2019 10:46:16 +0100
In-Reply-To: <20190128094625.4428-1-clg@kaod.org>
References: <20190128094625.4428-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190128094625.4428-11-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/19] target/ppc: Fix support for "STOP light"
 states on POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

STOP must act differently based on PSSCR:EC on POWER9. When set, it
acts like the P7/P8 power management instructions and wake up at 0x100
based on the wakeup conditions in LPCR.

When PSSCR:EC is clear however it will wakeup at the next instruction
after STOP (if EE is clear) or take the corresponding interrupts (if
EE is set).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/cpu-qom.h            |  1 +
 target/ppc/cpu.h                | 12 +++++++++---
 target/ppc/excp_helper.c        |  8 ++++++--
 target/ppc/translate.c          | 13 ++++++++++++-
 target/ppc/translate_init.inc.c |  7 +++++++
 5 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index 4ea67692e2a6..7c54093a7122 100644
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
index 2c22292e7f41..7ff65c804b57 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -413,6 +413,10 @@ struct ppc_slb_t {
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
@@ -1109,9 +1113,11 @@ struct CPUPPCState {
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
index 7c7c8d1b9dc6..97503193ef43 100644
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
index 55281a8975e0..07bedbb8f1ce 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3594,7 +3594,18 @@ static void gen_nap(DisasContext *ctx)
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
index 59e0b8676236..076d94f45755 100644
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
