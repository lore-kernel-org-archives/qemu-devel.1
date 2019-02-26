Received: from eggs.gnu.org ([209.51.188.92]:57545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkd-0004oG-Ds
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:53:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkY-0001pQ-63
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:53:52 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:22 +1100
Message-Id: <20190226045304.25618-9-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/50] target/ppc: Add Hypervisor Virtualization
 Interrupt on POWER9
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

This adds support for delivering that exception

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20190215161648.9600-9-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h                |  5 ++++-
 target/ppc/excp_helper.c        | 17 ++++++++++++++++-
 target/ppc/translate_init.inc.c | 16 +++++++++++++++-
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index d2364564a0..7d37d85ac5 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -160,8 +160,10 @@ enum {
     /* Server doorbell variants */
     POWERPC_EXCP_SDOOR    =3D 99,
     POWERPC_EXCP_SDOOR_HV =3D 100,
+    /* ISA 3.00 additions */
+    POWERPC_EXCP_HVIRT    =3D 101,
     /* EOL                                                              =
     */
-    POWERPC_EXCP_NB       =3D 101,
+    POWERPC_EXCP_NB       =3D 102,
     /* QEMU exceptions: used internally during code translation         =
     */
     POWERPC_EXCP_STOP         =3D 0x200, /* stop translation            =
       */
     POWERPC_EXCP_BRANCH       =3D 0x201, /* branch instruction          =
       */
@@ -2349,6 +2351,7 @@ enum {
     PPC_INTERRUPT_PERFM,          /* Performance monitor interrupt      =
  */
     PPC_INTERRUPT_HMI,            /* Hypervisor Maintainance interrupt  =
  */
     PPC_INTERRUPT_HDOORBELL,      /* Hypervisor Doorbell interrupt      =
  */
+    PPC_INTERRUPT_HVIRT,          /* Hypervisor virtualization interrupt=
  */
 };
=20
 /* Processor Compatibility mask (PCR) */
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 1a2f469a5f..d171a5eb62 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -97,6 +97,9 @@ static int powerpc_reset_wakeup(CPUState *cs, CPUPPCSta=
te *env, int excp,
     case POWERPC_EXCP_HV_MAINT:
         *msr |=3D 0xaull << (63 - 45);
         break;
+    case POWERPC_EXCP_HVIRT:
+        *msr |=3D 0x9ull << (63 - 45);
+        break;
     default:
         cpu_abort(cs, "Unsupported exception %d in Power Save mode\n",
                   excp);
@@ -427,6 +430,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
     case POWERPC_EXCP_HISEG:     /* Hypervisor instruction segment excep=
tion */
     case POWERPC_EXCP_SDOOR_HV:  /* Hypervisor Doorbell interrupt       =
     */
     case POWERPC_EXCP_HV_EMU:
+    case POWERPC_EXCP_HVIRT:     /* Hypervisor virtualization           =
     */
         srr0 =3D SPR_HSRR0;
         srr1 =3D SPR_HSRR1;
         new_msr |=3D (target_ulong)MSR_HVB;
@@ -809,7 +813,18 @@ static void ppc_hw_interrupt(CPUPPCState *env)
             return;
         }
     }
-    /* Extermal interrupt can ignore MSR:EE under some circumstances */
+
+    /* Hypervisor virtualization interrupt */
+    if (env->pending_interrupts & (1 << PPC_INTERRUPT_HVIRT)) {
+        /* LPCR will be clear when not supported so this will work */
+        bool hvice =3D !!(env->spr[SPR_LPCR] & LPCR_HVICE);
+        if ((async_deliver || msr_hv =3D=3D 0) && hvice) {
+            powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_HVIRT);
+            return;
+        }
+    }
+
+    /* External interrupt can ignore MSR:EE under some circumstances */
     if (env->pending_interrupts & (1 << PPC_INTERRUPT_EXT)) {
         bool lpes0 =3D !!(env->spr[SPR_LPCR] & LPCR_LPES0);
         if (async_deliver || (env->has_hv_mode && msr_hv =3D=3D 0 && !lp=
es0)) {
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index 9909e58761..6062163d85 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -3313,6 +3313,15 @@ static void init_excp_POWER8(CPUPPCState *env)
 #endif
 }
=20
+static void init_excp_POWER9(CPUPPCState *env)
+{
+    init_excp_POWER8(env);
+
+#if !defined(CONFIG_USER_ONLY)
+    env->excp_vectors[POWERPC_EXCP_HVIRT]    =3D 0x00000EA0;
+#endif
+}
+
 #endif
=20
 /***********************************************************************=
******/
@@ -8783,7 +8792,7 @@ static void init_proc_POWER9(CPUPPCState *env)
     env->icache_line_size =3D 128;
=20
     /* Allocate hardware IRQ controller */
-    init_excp_POWER8(env);
+    init_excp_POWER9(env);
     ppcPOWER7_irq_init(ppc_env_get_cpu(env));
 }
=20
@@ -8836,6 +8845,11 @@ static bool cpu_has_work_POWER9(CPUState *cs)
             (env->spr[SPR_LPCR] & LPCR_HDEE)) {
             return true;
         }
+        /* Hypervisor virtualization exception */
+        if ((env->pending_interrupts & (1u << PPC_INTERRUPT_HVIRT)) &&
+            (env->spr[SPR_LPCR] & LPCR_HVEE)) {
+            return true;
+        }
         if (env->pending_interrupts & (1u << PPC_INTERRUPT_RESET)) {
             return true;
         }
--=20
2.20.1
