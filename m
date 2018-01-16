Received: from eggs.gnu.org ([2001:4830:134:3::10]:56755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ebLtB-0002Eo-Gk
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 02:42:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ebLt7-0007tI-18
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 02:42:33 -0500
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:57276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ebLt6-0007rG-OV
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 02:42:28 -0500
Received: from player168.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 1F9C9916C2
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 08:42:27 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 16 Jan 2018 08:41:57 +0100
Message-Id: <20180116074157.16886-4-clg@kaod.org>
In-Reply-To: <20180116074157.16886-1-clg@kaod.org>
References: <20180116074157.16886-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] target/ppc: add support for hypervisor
 doorbells on book3s CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The hypervisor doorbells are used by skiboot and Linux on POWER9
processors to wake up secondaries.

This adds processor control support to the Server architecture by
reusing the Embedded support. They are very similar, only the bits
definition of the CPU identifier differ.

Still to be done is message broadcast to all threads of the same
processor.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/cpu.h            |  8 ++++++--
 target/ppc/excp_helper.c    | 39 ++++++++++++++++++++++++++++++++-------
 target/ppc/helper.h         |  2 +-
 target/ppc/translate.c      | 13 ++++++++++++-
 target/ppc/translate_init.c |  2 +-
 5 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index b8f4dfc1084a..603a38cae83f 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -930,7 +930,7 @@ enum {
 #define BOOKE206_MAX_TLBN      4
=20
 /***********************************************************************=
******/
-/* Embedded.Processor Control */
+/* Server and Embedded Processor Control */
=20
 #define DBELL_TYPE_SHIFT               27
 #define DBELL_TYPE_MASK                (0x1f << DBELL_TYPE_SHIFT)
@@ -940,11 +940,15 @@ enum {
 #define DBELL_TYPE_G_DBELL_CRIT        (0x03 << DBELL_TYPE_SHIFT)
 #define DBELL_TYPE_G_DBELL_MC          (0x04 << DBELL_TYPE_SHIFT)
=20
-#define DBELL_BRDCAST                  (1 << 26)
+#define DBELL_TYPE_DBELL_SERVER        (0x05 << DBELL_TYPE_SHIFT)
+
+#define DBELL_BRDCAST                  PPC_BIT(37)
 #define DBELL_LPIDTAG_SHIFT            14
 #define DBELL_LPIDTAG_MASK             (0xfff << DBELL_LPIDTAG_SHIFT)
 #define DBELL_PIRTAG_MASK              0x3fff
=20
+#define DBELL_PROCIDTAG_MASK           PPC_BITMASK(44, 63)
+
 /***********************************************************************=
******/
 /* Segment page size information, used by recent hash MMUs
  * The format of this structure mirrors kvm_ppc_smmu_info
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 4e548a448747..0f32cab1ff57 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -417,6 +417,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
     case POWERPC_EXCP_HISI:      /* Hypervisor instruction storage excep=
tion */
     case POWERPC_EXCP_HDSEG:     /* Hypervisor data segment exception   =
     */
     case POWERPC_EXCP_HISEG:     /* Hypervisor instruction segment excep=
tion */
+    case POWERPC_EXCP_SDOOR_HV:  /* Hypervisor Doorbell interrupt       =
     */
     case POWERPC_EXCP_HV_EMU:
         srr0 =3D SPR_HSRR0;
         srr1 =3D SPR_HSRR1;
@@ -846,6 +847,11 @@ static void ppc_hw_interrupt(CPUPPCState *env)
             powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_DOORI);
             return;
         }
+        if (env->pending_interrupts & (1 << PPC_INTERRUPT_HDOORBELL)) {
+            env->pending_interrupts &=3D ~(1 << PPC_INTERRUPT_HDOORBELL)=
;
+            powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_SDOOR_HV);
+            return;
+        }
         if (env->pending_interrupts & (1 << PPC_INTERRUPT_PERFM)) {
             env->pending_interrupts &=3D ~(1 << PPC_INTERRUPT_PERFM);
             powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_PERFM);
@@ -1088,8 +1094,8 @@ void helper_rfsvc(CPUPPCState *env)
     do_rfi(env, env->lr, env->ctr & 0x0000FFFF);
 }
=20
-/* Embedded.Processor Control */
-static int dbell2irq(target_ulong rb)
+/* Server and Embedded Processor Control */
+static int dbell2irq(target_ulong rb, bool book3s)
 {
     int msg =3D rb & DBELL_TYPE_MASK;
     int irq =3D -1;
@@ -1109,12 +1115,21 @@ static int dbell2irq(target_ulong rb)
         break;
     }
=20
+    /* A Directed Hypervisor Doorbell message is sent only if the
+     * message type is 5. All other types are reserved and the
+     * instruction is a no-op */
+    if (book3s && msg =3D=3D DBELL_TYPE_DBELL_SERVER) {
+        irq =3D PPC_INTERRUPT_HDOORBELL;
+    }
+
     return irq;
 }
=20
 void helper_msgclr(CPUPPCState *env, target_ulong rb)
 {
-    int irq =3D dbell2irq(rb);
+    /* 64-bit server processors compliant with arch 2.x */
+    bool book3s =3D (env->insns_flags & PPC_SEGMENT_64B);
+    int irq =3D dbell2irq(rb, book3s);
=20
     if (irq < 0) {
         return;
@@ -1123,10 +1138,11 @@ void helper_msgclr(CPUPPCState *env, target_ulong=
 rb)
     env->pending_interrupts &=3D ~(1 << irq);
 }
=20
-void helper_msgsnd(target_ulong rb)
+void helper_msgsnd(CPUPPCState *env, target_ulong rb)
 {
-    int irq =3D dbell2irq(rb);
-    int pir =3D rb & DBELL_PIRTAG_MASK;
+    /* 64-bit server processors compliant with arch 2.x */
+    bool book3s =3D (env->insns_flags & PPC_SEGMENT_64B);
+    int irq =3D dbell2irq(rb, book3s);
     CPUState *cs;
=20
     if (irq < 0) {
@@ -1137,8 +1153,17 @@ void helper_msgsnd(target_ulong rb)
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
         CPUPPCState *cenv =3D &cpu->env;
+        bool send;
=20
-        if ((rb & DBELL_BRDCAST) || (cenv->spr[SPR_BOOKE_PIR] =3D=3D pir=
)) {
+        /* TODO: broadcast message to all threads of the same  processor=
 */
+        if (book3s) {
+            int pir =3D rb & DBELL_PROCIDTAG_MASK;
+            send =3D (cenv->spr_cb[SPR_PIR].default_value =3D=3D pir);
+        } else {
+            int pir =3D rb & DBELL_PROCIDTAG_MASK;
+            send =3D (rb & DBELL_BRDCAST) || (cenv->spr[SPR_BOOKE_PIR] =3D=
=3D pir);
+        }
+        if (send) {
             cenv->pending_interrupts |=3D 1 << irq;
             cpu_interrupt(cs, CPU_INTERRUPT_HARD);
         }
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index bb6a94a8b390..3e98bd9eecb8 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -677,7 +677,7 @@ DEF_HELPER_FLAGS_2(load_sr, TCG_CALL_NO_RWG, tl, env,=
 tl)
 DEF_HELPER_FLAGS_3(store_sr, TCG_CALL_NO_RWG, void, env, tl, tl)
=20
 DEF_HELPER_FLAGS_1(602_mfrom, TCG_CALL_NO_RWG_SE, tl, tl)
-DEF_HELPER_1(msgsnd, void, tl)
+DEF_HELPER_2(msgsnd, void, env, tl)
 DEF_HELPER_2(msgclr, void, env, tl)
 #endif
=20
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index bcd36d53537f..1ad7e0fd4efd 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6180,10 +6180,19 @@ static void gen_msgsnd(DisasContext *ctx)
     GEN_PRIV;
 #else
     CHK_HV;
-    gen_helper_msgsnd(cpu_gpr[rB(ctx->opcode)]);
+    gen_helper_msgsnd(cpu_env, cpu_gpr[rB(ctx->opcode)]);
 #endif /* defined(CONFIG_USER_ONLY) */
 }
=20
+static void gen_msgsync(DisasContext *ctx)
+{
+#if defined(CONFIG_USER_ONLY)
+    GEN_PRIV;
+#else
+    CHK_HV;
+#endif /* defined(CONFIG_USER_ONLY) */
+    /* interpreted as no-op */
+}
=20
 #if defined(TARGET_PPC64)
 static void gen_maddld(DisasContext *ctx)
@@ -6664,6 +6673,8 @@ GEN_HANDLER2_E(msgsnd, "msgsnd", 0x1F, 0x0E, 0x06, =
0x03ff0001,
                PPC_NONE, PPC2_PRCNTL),
 GEN_HANDLER2_E(msgclr, "msgclr", 0x1F, 0x0E, 0x07, 0x03ff0001,
                PPC_NONE, PPC2_PRCNTL),
+GEN_HANDLER2_E(msgsync, "msgsync", 0x1F, 0x16, 0x1B, 0x00000000,
+               PPC_NONE, PPC2_PRCNTL),
 GEN_HANDLER(wrtee, 0x1F, 0x03, 0x04, 0x000FFC01, PPC_WRTEE),
 GEN_HANDLER(wrteei, 0x1F, 0x03, 0x05, 0x000E7C01, PPC_WRTEE),
 GEN_HANDLER(dlmzb, 0x1F, 0x0E, 0x02, 0x00000000, PPC_440_SPEC),
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 70ff15a51a6b..55c99c97e377 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8866,7 +8866,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
                         PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
                         PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
                         PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
-                        PPC2_TM | PPC2_PM_ISA206 | PPC2_ISA300;
+                        PPC2_TM | PPC2_PM_ISA206 | PPC2_ISA300 | PPC2_PR=
CNTL;
     pcc->msr_mask =3D (1ull << MSR_SF) |
                     (1ull << MSR_TM) |
                     (1ull << MSR_VR) |
--=20
2.13.6
