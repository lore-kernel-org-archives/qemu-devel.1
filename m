Received: from eggs.gnu.org ([209.51.188.92]:38788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3Vy-0005cZ-Ct
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:47:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3Vt-0003qo-6T
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:47:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44956
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1go3Vl-00034w-6N
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:47:29 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0S9ie7m123199
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:47:01 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q9x9su18n-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:47:01 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Mon, 28 Jan 2019 09:46:59 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 28 Jan 2019 10:46:22 +0100
In-Reply-To: <20190128094625.4428-1-clg@kaod.org>
References: <20190128094625.4428-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190128094625.4428-17-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 16/19] target/ppc: Add Hypervisor
 Virtualization Interrupt on POWER9
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

This adds support for delivering that exception

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/cpu.h                |  5 ++++-
 target/ppc/excp_helper.c        | 17 ++++++++++++++++-
 target/ppc/translate_init.inc.c | 16 +++++++++++++++-
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index b69410ea2541..385d33bd37ff 100644
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
@@ -2344,6 +2346,7 @@ enum {
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
index 1a2f469a5fa2..d171a5eb6236 100644
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
index c1719c46a383..6ffa4a8fe0fa 100644
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
