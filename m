Received: from eggs.gnu.org ([209.51.188.92]:57582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkh-0004sw-N1
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkd-00024D-Ef
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:53:58 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:23 +1100
Message-Id: <20190226045304.25618-10-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/50] target/ppc: Add POWER9 external interrupt
 model
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

Adds support for the Hypervisor directed interrupts in addition to the
OS ones.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
[clg: - modified the icp_realize() and xive_tctx_realize() to take
        into account explicitely the POWER9 interrupt model
      - introduced a specific power9_set_irq for POWER9 ]
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190215161648.9600-10-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c                  |  3 +++
 hw/intc/xive.c                  |  3 +++
 hw/ppc/ppc.c                    | 42 +++++++++++++++++++++++++++++++++
 include/hw/ppc/ppc.h            |  2 ++
 target/ppc/cpu-qom.h            |  2 ++
 target/ppc/cpu.h                |  7 ++++++
 target/ppc/translate_init.inc.c |  4 ++--
 7 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 3009fa7472..767fdeb829 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -338,6 +338,9 @@ static void icp_realize(DeviceState *dev, Error **err=
p)
     case PPC_FLAGS_INPUT_POWER7:
         icp->output =3D env->irq_inputs[POWER7_INPUT_INT];
         break;
+    case PPC_FLAGS_INPUT_POWER9: /* For SPAPR xics emulation */
+        icp->output =3D env->irq_inputs[POWER9_INPUT_INT];
+        break;
=20
     case PPC_FLAGS_INPUT_970:
         icp->output =3D env->irq_inputs[PPC970_INPUT_INT];
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 2e9b8efd43..425aa97ef9 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -484,6 +484,9 @@ static void xive_tctx_realize(DeviceState *dev, Error=
 **errp)
     case PPC_FLAGS_INPUT_POWER7:
         tctx->output =3D env->irq_inputs[POWER7_INPUT_INT];
         break;
+    case PPC_FLAGS_INPUT_POWER9:
+        tctx->output =3D env->irq_inputs[POWER9_INPUT_INT];
+        break;
=20
     default:
         error_setg(errp, "XIVE interrupt controller does not support "
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 12439dbe5d..d1e3d4cd20 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -306,6 +306,48 @@ void ppcPOWER7_irq_init(PowerPCCPU *cpu)
     env->irq_inputs =3D (void **)qemu_allocate_irqs(&power7_set_irq, cpu=
,
                                                   POWER7_INPUT_NB);
 }
+
+/* POWER9 internal IRQ controller */
+static void power9_set_irq(void *opaque, int pin, int level)
+{
+    PowerPCCPU *cpu =3D opaque;
+    CPUPPCState *env =3D &cpu->env;
+
+    LOG_IRQ("%s: env %p pin %d level %d\n", __func__,
+                env, pin, level);
+
+    switch (pin) {
+    case POWER9_INPUT_INT:
+        /* Level sensitive - active high */
+        LOG_IRQ("%s: set the external IRQ state to %d\n",
+                __func__, level);
+        ppc_set_irq(cpu, PPC_INTERRUPT_EXT, level);
+        break;
+    case POWER9_INPUT_HINT:
+        /* Level sensitive - active high */
+        LOG_IRQ("%s: set the external IRQ state to %d\n",
+                __func__, level);
+        ppc_set_irq(cpu, PPC_INTERRUPT_HVIRT, level);
+        break;
+    default:
+        /* Unknown pin - do nothing */
+        LOG_IRQ("%s: unknown IRQ pin %d\n", __func__, pin);
+        return;
+    }
+    if (level) {
+        env->irq_input_state |=3D 1 << pin;
+    } else {
+        env->irq_input_state &=3D ~(1 << pin);
+    }
+}
+
+void ppcPOWER9_irq_init(PowerPCCPU *cpu)
+{
+    CPUPPCState *env =3D &cpu->env;
+
+    env->irq_inputs =3D (void **)qemu_allocate_irqs(&power9_set_irq, cpu=
,
+                                                  POWER9_INPUT_NB);
+}
 #endif /* defined(TARGET_PPC64) */
=20
 void ppc40x_core_reset(PowerPCCPU *cpu)
diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index 298ec354a8..746170f635 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -73,6 +73,7 @@ static inline void ppc40x_irq_init(PowerPCCPU *cpu) {}
 static inline void ppc6xx_irq_init(PowerPCCPU *cpu) {}
 static inline void ppc970_irq_init(PowerPCCPU *cpu) {}
 static inline void ppcPOWER7_irq_init(PowerPCCPU *cpu) {}
+static inline void ppcPOWER9_irq_init(PowerPCCPU *cpu) {}
 static inline void ppce500_irq_init(PowerPCCPU *cpu) {}
 #else
 void ppc40x_irq_init(PowerPCCPU *cpu);
@@ -80,6 +81,7 @@ void ppce500_irq_init(PowerPCCPU *cpu);
 void ppc6xx_irq_init(PowerPCCPU *cpu);
 void ppc970_irq_init(PowerPCCPU *cpu);
 void ppcPOWER7_irq_init(PowerPCCPU *cpu);
+void ppcPOWER9_irq_init(PowerPCCPU *cpu);
 #endif
=20
 /* PPC machines for OpenBIOS */
diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index 904ee694ac..ae51fe754e 100644
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
index 7d37d85ac5..ececad9f1f 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2327,6 +2327,13 @@ enum {
      * them */
     POWER7_INPUT_NB,
 };
+
+enum {
+    /* POWER9 input pins */
+    POWER9_INPUT_INT        =3D 0,
+    POWER9_INPUT_HINT       =3D 1,
+    POWER9_INPUT_NB,
+};
 #endif
=20
 /* Hardware exceptions definitions */
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index 6062163d85..9d84164915 100644
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
