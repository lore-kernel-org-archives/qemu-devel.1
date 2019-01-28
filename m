Received: from eggs.gnu.org ([209.51.188.92]:38832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3W1-0005gk-Ln
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:47:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3W0-00044F-Am
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:47:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1go3Vy-00035e-BM
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:47:40 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0S9i5G5074152
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:47:02 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q9vhk7aw2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:47:02 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Mon, 28 Jan 2019 09:46:59 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 28 Jan 2019 10:46:23 +0100
In-Reply-To: <20190128094625.4428-1-clg@kaod.org>
References: <20190128094625.4428-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190128094625.4428-18-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 17/19] target/ppc: Add POWER9 external
 interrupt model
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

Adds support for the Hypervisor directed interrupts in addition to the
OS ones.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/ppc.h            |  2 ++
 target/ppc/cpu-qom.h            |  2 ++
 target/ppc/cpu.h                |  7 +++++++
 hw/intc/xics.c                  |  1 +
 hw/intc/xive.c                  |  2 +-
 hw/ppc/ppc.c                    | 14 ++++++++++++++
 target/ppc/translate_init.inc.c |  4 ++--
 7 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index daaa04a22dbf..4bdcb8bacd4e 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -74,6 +74,7 @@ static inline void ppc40x_irq_init(PowerPCCPU *cpu) {}
 static inline void ppc6xx_irq_init(PowerPCCPU *cpu) {}
 static inline void ppc970_irq_init(PowerPCCPU *cpu) {}
 static inline void ppcPOWER7_irq_init(PowerPCCPU *cpu) {}
+static inline void ppcPOWER9_irq_init(PowerPCCPU *cpu) {}
 static inline void ppce500_irq_init(PowerPCCPU *cpu) {}
 #else
 void ppc40x_irq_init(PowerPCCPU *cpu);
@@ -81,6 +82,7 @@ void ppce500_irq_init(PowerPCCPU *cpu);
 void ppc6xx_irq_init(PowerPCCPU *cpu);
 void ppc970_irq_init(PowerPCCPU *cpu);
 void ppcPOWER7_irq_init(PowerPCCPU *cpu);
+void ppcPOWER9_irq_init(PowerPCCPU *cpu);
 #endif
=20
 /* PPC machines for OpenBIOS */
diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index 7ff8b2d68632..079fbb9d8718 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -142,6 +142,8 @@ enum powerpc_input_t {
     PPC_FLAGS_INPUT_970,
     /* PowerPC POWER7 bus               */
     PPC_FLAGS_INPUT_POWER7,
+    /* PowerPC POWER9 bus               */
+    PPC_FLAGS_INPUT_POWER9,
     /* PowerPC 401 bus                  */
     PPC_FLAGS_INPUT_401,
     /* Freescale RCPU bus               */
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 385d33bd37ff..cc41ae6f3017 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2322,6 +2322,13 @@ enum {
      * them */
     POWER7_INPUT_NB,
 };
+
+enum {
+    /* POWER9 input pins */
+    POWER9_INPUT_INT        =3D 0, /* Must match POWER7_INPUT_INT */
+    POWER9_INPUT_HINT       =3D 1,
+    POWER9_INPUT_NB,
+};
 #endif
=20
 /* Hardware exceptions definitions */
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 16e8ffa2aaf7..1f786175168f 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -342,6 +342,7 @@ static void icp_realize(DeviceState *dev, Error **err=
p)
     env =3D &cpu->env;
     switch (PPC_INPUT(env)) {
     case PPC_FLAGS_INPUT_POWER7:
+    case PPC_FLAGS_INPUT_POWER9: /* For SPAPR xics emulation */
         icp->output =3D env->irq_inputs[POWER7_INPUT_INT];
         break;
=20
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 0e0e1dc9c1b7..119bb02d345d 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -553,7 +553,7 @@ static void xive_tctx_realize(DeviceState *dev, Error=
 **errp)
=20
     env =3D &cpu->env;
     switch (PPC_INPUT(env)) {
-    case PPC_FLAGS_INPUT_POWER7:
+    case PPC_FLAGS_INPUT_POWER9:
         tctx->output =3D env->irq_inputs[POWER7_INPUT_INT];
         break;
=20
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 608405f6f2ca..1a5e087c9b1e 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -289,6 +289,12 @@ static void power7_set_irq(void *opaque, int pin, in=
t level)
                 __func__, level);
         ppc_set_irq(cpu, PPC_INTERRUPT_EXT, level);
         break;
+    case POWER9_INPUT_HINT:
+        /* Level sensitive - active high */
+        LOG_IRQ("%s: set the external IRQ state to %d\n",
+                __func__, level);
+        ppc_set_irq(cpu, PPC_INTERRUPT_HVIRT, level);
+        break;
     default:
         /* Unknown pin - do nothing */
         LOG_IRQ("%s: unknown IRQ pin %d\n", __func__, pin);
@@ -308,6 +314,14 @@ void ppcPOWER7_irq_init(PowerPCCPU *cpu)
     env->irq_inputs =3D (void **)qemu_allocate_irqs(&power7_set_irq, cpu=
,
                                                   POWER7_INPUT_NB);
 }
+
+void ppcPOWER9_irq_init(PowerPCCPU *cpu)
+{
+    CPUPPCState *env =3D &cpu->env;
+
+    env->irq_inputs =3D (void **)qemu_allocate_irqs(&power7_set_irq, cpu=
,
+                                                  POWER9_INPUT_NB);
+}
 #endif /* defined(TARGET_PPC64) */
=20
 /* PowerPC 40x internal IRQ controller */
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index 6ffa4a8fe0fa..7f25215f0192 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8793,7 +8793,7 @@ static void init_proc_POWER9(CPUPPCState *env)
=20
     /* Allocate hardware IRQ controller */
     init_excp_POWER9(env);
-    ppcPOWER7_irq_init(ppc_env_get_cpu(env));
+    ppcPOWER9_irq_init(ppc_env_get_cpu(env));
 }
=20
 static bool ppc_pvr_match_power9(PowerPCCPUClass *pcc, uint32_t pvr)
@@ -8920,7 +8920,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
     pcc->radix_page_info =3D &POWER9_radix_page_info;
 #endif
     pcc->excp_model =3D POWERPC_EXCP_POWER9;
-    pcc->bus_model =3D PPC_FLAGS_INPUT_POWER7;
+    pcc->bus_model =3D PPC_FLAGS_INPUT_POWER9;
     pcc->bfd_mach =3D bfd_mach_ppc64;
     pcc->flags =3D POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
                  POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
--=20
2.20.1
