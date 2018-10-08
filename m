Received: from eggs.gnu.org ([2001:4830:134:3::10]:47067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1g9X2N-0006eV-Jx
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1g9X2K-0007cj-0y
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:01:35 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:48636 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1g9X2H-0007EY-MG
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:01:31 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon,  8 Oct 2018 16:56:35 +0200
Message-Id: <1539010596-30858-12-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539010596-30858-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539010596-30858-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 11/12] hw/mips: Add Data Scratch Pad RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, laurent@vivier.eu, riku.voipio@iki.fi

From: Yongbok Kim <yongbok.kim@mips.com>

The optional Data Scratch Pad RAM (DSPRAM) block provides a
general scratch pad RAM used for temporary storage of data. The
DSPRAM provides a connection to on-chip memory or memory-mapped
registers, which are accessed in parallel with the L1 data
cache to minimize access latency.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 default-configs/mips-softmmu-common.mak |  1 +
 hw/mips/cps.c                           |  3 ++-
 hw/mips/mips_malta.c                    | 31 +++++++++++++++++++++++++++++++
 hw/misc/Makefile.objs                   |  1 +
 include/hw/mips/cps.h                   |  2 ++
 target/mips/cpu.h                       |  5 +++++
 target/mips/internal.h                  |  1 +
 target/mips/op_helper.c                 | 10 ++++++++++
 target/mips/translate.c                 |  7 +++++++
 9 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
index fae2347..45f2cbf 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -36,3 +36,4 @@ CONFIG_EMPTY_SLOT=y
 CONFIG_MIPS_CPS=y
 CONFIG_MIPS_ITU=y
 CONFIG_I2C=y
+CONFIG_MIPS_DSPRAM=y
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index dd68795..93d3bea 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -102,7 +102,8 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
         object_property_set_bool(OBJECT(&s->itu), saar_present, "saar-present",
                                  &err);
         if (saar_present) {
-            qdev_prop_set_ptr(DEVICE(&s->itu), "saar", (void *) &env->CP0_SAAR);
+            qdev_prop_set_ptr(DEVICE(&s->itu), "saar",
+                              (void *) &env->CP0_SAAR[0]);
         }
         object_property_set_bool(OBJECT(&s->itu), true, "realized", &err);
         if (err != NULL) {
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 29b90ba..1b1bbd8 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1169,6 +1169,36 @@ static void create_cps(MaltaState *s, const char *cpu_type,
     *cbus_irq = NULL;
 }
 
+static void create_dspram(void)
+{
+    MIPSCPU *cpu = MIPS_CPU(first_cpu);
+    CPUMIPSState *env = &cpu->env;
+    bool dspram_present = (bool) env->dspramp;
+    Error *err = NULL;
+
+    env->dspram = g_new0(MIPSDSPRAMState, 1);
+
+    /* DSPRAM */
+    if (dspram_present) {
+        if (!(bool) env->saarp) {
+            error_report("%s: DSPRAM requires SAAR registers", __func__);
+            exit(1);
+        }
+        object_initialize(env->dspram, sizeof(MIPSDSPRAMState),
+                          TYPE_MIPS_DSPRAM);
+        qdev_set_parent_bus(DEVICE(env->dspram), sysbus_get_default());
+        qdev_prop_set_ptr(DEVICE(env->dspram), "saar",
+                          (void *) &env->CP0_SAAR[1]);
+        object_property_set_bool(OBJECT(env->dspram), true, "realized", &err);
+        if (err != NULL) {
+            error_report("%s: DSPRAM initialisation failed", __func__);
+            exit(1);
+        }
+        memory_region_add_subregion(get_system_memory(), 0,
+                    sysbus_mmio_get_region(SYS_BUS_DEVICE(env->dspram), 0));
+    }
+}
+
 static void mips_create_cpu(MaltaState *s, const char *cpu_type,
                             qemu_irq *cbus_irq, qemu_irq *i8259_irq)
 {
@@ -1177,6 +1207,7 @@ static void mips_create_cpu(MaltaState *s, const char *cpu_type,
     } else {
         create_cpu_without_cps(cpu_type, cbus_irq, i8259_irq);
     }
+    create_dspram();
 }
 
 static
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 6d50b03..37a1b41 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -60,6 +60,7 @@ obj-$(CONFIG_STM32F2XX_SYSCFG) += stm32f2xx_syscfg.o
 obj-$(CONFIG_MIPS_CPS) += mips_cmgcr.o
 obj-$(CONFIG_MIPS_CPS) += mips_cpc.o
 obj-$(CONFIG_MIPS_ITU) += mips_itu.o
+obj-$(CONFIG_MIPS_DSPRAM) += mips_dspram.o
 obj-$(CONFIG_MPS2_FPGAIO) += mps2-fpgaio.o
 obj-$(CONFIG_MPS2_SCC) += mps2-scc.o
 
diff --git a/include/hw/mips/cps.h b/include/hw/mips/cps.h
index aab1af9..a637036 100644
--- a/include/hw/mips/cps.h
+++ b/include/hw/mips/cps.h
@@ -25,6 +25,7 @@
 #include "hw/intc/mips_gic.h"
 #include "hw/misc/mips_cpc.h"
 #include "hw/misc/mips_itu.h"
+#include "hw/misc/mips_dspram.h"
 
 #define TYPE_MIPS_CPS "mips-cps"
 #define MIPS_CPS(obj) OBJECT_CHECK(MIPSCPSState, (obj), TYPE_MIPS_CPS)
@@ -41,6 +42,7 @@ typedef struct MIPSCPSState {
     MIPSGICState gic;
     MIPSCPCState cpc;
     MIPSITUState itu;
+    MIPSDSPRAMState dspram;
 } MIPSCPSState;
 
 qemu_irq get_cps_irq(MIPSCPSState *cps, int pin_number);
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 7bc45d5..9e2eb19 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -625,6 +625,7 @@ struct CPUMIPSState {
     uint32_t CP0_TCStatus_rw_bitmask; /* Read/write bits in CP0_TCStatus */
     int insn_flags; /* Supported instruction set */
     int saarp;
+    int dspramp;
 
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
@@ -642,6 +643,7 @@ struct CPUMIPSState {
     QEMUTimer *timer; /* Internal timer */
     struct MIPSITUState *itu;
     MemoryRegion *itc_tag; /* ITC Configuration Tags */
+    struct MIPSDSPRAMState *dspram;
     target_ulong exception_base; /* ExceptionBase input to the core */
 };
 
@@ -786,6 +788,9 @@ void cpu_mips_soft_irq(CPUMIPSState *env, int irq, int level);
 /* mips_itu.c */
 void itc_reconfigure(struct MIPSITUState *tag);
 
+/* mips_dspram.c */
+void dspram_reconfigure(struct MIPSDSPRAMState *dspram);
+
 /* helper.c */
 target_ulong exception_resume_pc (CPUMIPSState *env);
 
diff --git a/target/mips/internal.h b/target/mips/internal.h
index c0a1144..b9b3a98 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -62,6 +62,7 @@ struct mips_def_t {
     int insn_flags;
     enum mips_mmu_types mmu_type;
     int32_t SAARP;
+    int32_t DSPRAMP;
 };
 
 extern const struct mips_def_t mips_defs[];
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index eb63d20..f8510ec 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -1566,6 +1566,11 @@ void helper_mtc0_saar(CPUMIPSState *env, target_ulong arg1)
                 itc_reconfigure(env->itu);
             }
             break;
+        case 1:
+            if (env->dspram) {
+                dspram_reconfigure(env->dspram);
+            }
+            break;
         }
     }
 }
@@ -1583,6 +1588,11 @@ void helper_mthc0_saar(CPUMIPSState *env, target_ulong arg1)
                 itc_reconfigure(env->itu);
             }
             break;
+        case 1:
+            if (env->dspram) {
+                dspram_reconfigure(env->dspram);
+            }
+            break;
         }
     }
 }
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 1c51a01..a9bb448 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -25895,6 +25895,7 @@ void cpu_state_reset(CPUMIPSState *env)
     env->msair = env->cpu_model->MSAIR;
     env->insn_flags = env->cpu_model->insn_flags;
     env->saarp = env->cpu_model->SAARP;
+    env->dspramp = env->cpu_model->DSPRAMP;
 
 #if defined(CONFIG_USER_ONLY)
     env->CP0_Status = (MIPS_HFLAG_UM << CP0St_KSU);
@@ -26031,6 +26032,12 @@ void cpu_state_reset(CPUMIPSState *env)
         msa_reset(env);
     }
 
+    /* DSPRAM */
+    if (env->dspramp) {
+        /* Fixed DSPRAM size with Default Value */
+        env->CP0_SAAR[1] = 0x10 << 1;
+    }
+
     compute_hflags(env);
     restore_fp_status(env);
     restore_pamask(env);
-- 
2.7.4
