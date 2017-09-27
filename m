Received: from eggs.gnu.org ([2001:4830:134:3::10]:56524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70N-0001RK-1t
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70L-00043v-MC
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:39 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 27 Sep 2017 17:43:01 +1000
Message-Id: <20170927074316.4454-12-david@gibson.dropbear.id.au>
In-Reply-To: <20170927074316.4454-1-david@gibson.dropbear.id.au>
References: <20170927074316.4454-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 11/26] ppc: Fix OpenPIC model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mark.cave-ayland@ilande.co.uk, balaton@eik.bme.hu, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Apple uses an IBM MPIC2A without timers, it has 64 sources.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/openpic.c        | 35 +++++++++++++++++++++++++++++++++++
 hw/ppc/mac_newworld.c    |  2 +-
 include/hw/ppc/openpic.h |  1 +
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index 9dd285b923..10d6e871fb 100644
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
index 6a2bce181a..6d0ace20ca 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -342,7 +342,7 @@ static void ppc_core99_init(MachineState *machine)
     pic = g_new0(qemu_irq, 64);
 
     dev = qdev_create(NULL, TYPE_OPENPIC);
-    qdev_prop_set_uint32(dev, "model", OPENPIC_MODEL_RAVEN);
+    qdev_prop_set_uint32(dev, "model", OPENPIC_MODEL_KEYLARGO);
     qdev_init_nofail(dev);
     s = SYS_BUS_DEVICE(dev);
     pic_mem = s->mmio[0].memory;
diff --git a/include/hw/ppc/openpic.h b/include/hw/ppc/openpic.h
index 6137e2d7a2..e55ce546aa 100644
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
2.13.5
