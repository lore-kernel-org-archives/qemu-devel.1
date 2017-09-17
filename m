Received: from eggs.gnu.org ([2001:4830:134:3::10]:45729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dtdB0-00065i-Q6
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 13:16:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dtdAx-0006CL-2B
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 13:16:14 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 17 Sep 2017 18:15:46 +0100
Message-Id: <1505668548-16616-7-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1505668548-16616-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1505668548-16616-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 6/8] ppc: Fix OpenPIC model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, benh@kernel.crashing.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Apple uses an IBM MPIC2A without timers, it has 64 sources.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 hw/intc/openpic.c        |   35 +++++++++++++++++++++++++++++++++++
 hw/ppc/mac_newworld.c    |    2 +-
 include/hw/ppc/openpic.h |    1 +
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index 9dd285b..10d6e87 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -92,6 +92,16 @@ static int get_current_cpu(void);
 #define RAVEN_MAX_TMR      OPENPIC_MAX_TMR
 #define RAVEN_MAX_IPI      OPENPIC_MAX_IPI
 
+/* KeyLargo */
+#define KEYLARGO_MAX_CPU  4
+#define KEYLARGO_MAX_EXT  64
+#define KEYLARGO_MAX_IPI  4
+#define KEYLARGO_MAX_IRQ  (64 + KEYLARGO_MAX_IPI)
+#define KEYLARGO_MAX_TMR  0
+#define KEYLARGO_IPI_IRQ  (KEYLARGO_MAX_EXT) /* First IPI IRQ */
+/* Timers don't exist but this makes the code happy... */
+#define KEYLARGO_TMR_IRQ  (KEYLARGO_IPI_IRQ + KEYLARGO_MAX_IPI)
+
 /* Interrupt definitions */
 #define RAVEN_FE_IRQ     (RAVEN_MAX_EXT)     /* Internal functional IRQ */
 #define RAVEN_ERR_IRQ    (RAVEN_MAX_EXT + 1) /* Error IRQ */
@@ -120,6 +130,7 @@ static FslMpicInfo fsl_mpic_42 = {
 #define VID_REVISION_1_3   3
 
 #define VIR_GENERIC      0x00000000 /* Generic Vendor ID */
+#define VIR_MPIC2A       0x00004614 /* IBM MPIC-2A */
 
 #define GCR_RESET        0x80000000
 #define GCR_MODE_PASS    0x00000000
@@ -329,6 +340,8 @@ typedef struct OpenPICState {
     uint32_t nb_cpus;
     /* Timer registers */
     OpenPICTimer timers[OPENPIC_MAX_TMR];
+    uint32_t max_tmr;
+
     /* Shared MSI registers */
     OpenPICMSI msi[MAX_MSI];
     uint32_t max_irq;
@@ -1717,6 +1730,28 @@ static void openpic_realize(DeviceState *dev, Error **errp)
 
         map_list(opp, list_le, &list_count);
         break;
+
+    case OPENPIC_MODEL_KEYLARGO:
+        opp->nb_irqs = KEYLARGO_MAX_EXT;
+        opp->vid = VID_REVISION_1_2;
+        opp->vir = VIR_GENERIC;
+        opp->vector_mask = 0xFF;
+        opp->tfrr_reset = 4160000;
+        opp->ivpr_reset = IVPR_MASK_MASK | IVPR_MODE_MASK;
+        opp->idr_reset = 0;
+        opp->max_irq = KEYLARGO_MAX_IRQ;
+        opp->irq_ipi0 = KEYLARGO_IPI_IRQ;
+        opp->irq_tim0 = KEYLARGO_TMR_IRQ;
+        opp->brr1 = -1;
+        opp->mpic_mode_mask = GCR_MODE_MIXED;
+
+        if (opp->nb_cpus != 1) {
+            error_setg(errp, "Only UP supported today");
+            return;
+        }
+
+        map_list(opp, list_le, &list_count);
+        break;
     }
 
     for (i = 0; i < opp->nb_cpus; i++) {
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index c581d96..62bd8d3 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -351,7 +351,7 @@ static void ppc_core99_init(MachineState *machine)
     pic = g_new0(qemu_irq, 64);
 
     dev = qdev_create(NULL, TYPE_OPENPIC);
-    qdev_prop_set_uint32(dev, "model", OPENPIC_MODEL_RAVEN);
+    qdev_prop_set_uint32(dev, "model", OPENPIC_MODEL_KEYLARGO);
     qdev_init_nofail(dev);
     s = SYS_BUS_DEVICE(dev);
     pic_mem = s->mmio[0].memory;
diff --git a/include/hw/ppc/openpic.h b/include/hw/ppc/openpic.h
index 6137e2d..e55ce54 100644
--- a/include/hw/ppc/openpic.h
+++ b/include/hw/ppc/openpic.h
@@ -20,6 +20,7 @@ enum {
 #define OPENPIC_MODEL_RAVEN       0
 #define OPENPIC_MODEL_FSL_MPIC_20 1
 #define OPENPIC_MODEL_FSL_MPIC_42 2
+#define OPENPIC_MODEL_KEYLARGO    3
 
 #define OPENPIC_MAX_SRC     256
 #define OPENPIC_MAX_TMR     4
-- 
1.7.10.4
