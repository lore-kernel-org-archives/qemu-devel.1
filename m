Received: from eggs.gnu.org ([2001:4830:134:3::10]:49546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3nz-0001Ze-Ud
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3nv-0004UV-D5
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:23 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Mar 2018 15:01:41 +1100
Message-Id: <20180306040154.3669-18-david@gibson.dropbear.id.au>
In-Reply-To: <20180306040154.3669-1-david@gibson.dropbear.id.au>
References: <20180306040154.3669-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 17/30] openpic: move OpenPIC state and related
 definitions to openpic.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, groug@kaod.org
Cc: agraf@suse.de, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This is to faciliate access to OpenPICState when wiring up the PIC to the macio
controller.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/openpic.c        | 157 ----------------------------------------------
 include/hw/ppc/openpic.h | 159 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 158 insertions(+), 158 deletions(-)

diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index 9159a06f07..811cee9b26 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -63,10 +63,6 @@ static int get_current_cpu(void);
         } \
     } while (0)
 
-#define MAX_CPU     32
-#define MAX_MSI     8
-#define VID         0x03 /* MPIC version ID */
-
 /* OpenPIC capability flags */
 #define OPENPIC_FLAG_IDR_CRIT     (1 << 0)
 #define OPENPIC_FLAG_ILR          (2 << 0)
@@ -85,35 +81,6 @@ static int get_current_cpu(void);
 #define OPENPIC_CPU_REG_START        0x20000
 #define OPENPIC_CPU_REG_SIZE         0x100 + ((MAX_CPU - 1) * 0x1000)
 
-/* Raven */
-#define RAVEN_MAX_CPU      2
-#define RAVEN_MAX_EXT     48
-#define RAVEN_MAX_IRQ     64
-#define RAVEN_MAX_TMR      OPENPIC_MAX_TMR
-#define RAVEN_MAX_IPI      OPENPIC_MAX_IPI
-
-/* KeyLargo */
-#define KEYLARGO_MAX_CPU  4
-#define KEYLARGO_MAX_EXT  64
-#define KEYLARGO_MAX_IPI  4
-#define KEYLARGO_MAX_IRQ  (64 + KEYLARGO_MAX_IPI)
-#define KEYLARGO_MAX_TMR  0
-#define KEYLARGO_IPI_IRQ  (KEYLARGO_MAX_EXT) /* First IPI IRQ */
-/* Timers don't exist but this makes the code happy... */
-#define KEYLARGO_TMR_IRQ  (KEYLARGO_IPI_IRQ + KEYLARGO_MAX_IPI)
-
-/* Interrupt definitions */
-#define RAVEN_FE_IRQ     (RAVEN_MAX_EXT)     /* Internal functional IRQ */
-#define RAVEN_ERR_IRQ    (RAVEN_MAX_EXT + 1) /* Error IRQ */
-#define RAVEN_TMR_IRQ    (RAVEN_MAX_EXT + 2) /* First timer IRQ */
-#define RAVEN_IPI_IRQ    (RAVEN_TMR_IRQ + RAVEN_MAX_TMR) /* First IPI IRQ */
-/* First doorbell IRQ */
-#define RAVEN_DBL_IRQ    (RAVEN_IPI_IRQ + (RAVEN_MAX_CPU * RAVEN_MAX_IPI))
-
-typedef struct FslMpicInfo {
-    int max_ext;
-} FslMpicInfo;
-
 static FslMpicInfo fsl_mpic_20 = {
     .max_ext = 12,
 };
@@ -211,55 +178,6 @@ static void openpic_cpu_write_internal(void *opaque, hwaddr addr,
                                        uint32_t val, int idx);
 static void openpic_reset(DeviceState *d);
 
-typedef enum IRQType {
-    IRQ_TYPE_NORMAL = 0,
-    IRQ_TYPE_FSLINT,        /* FSL internal interrupt -- level only */
-    IRQ_TYPE_FSLSPECIAL,    /* FSL timer/IPI interrupt, edge, no polarity */
-} IRQType;
-
-/* Round up to the nearest 64 IRQs so that the queue length
- * won't change when moving between 32 and 64 bit hosts.
- */
-#define IRQQUEUE_SIZE_BITS ((OPENPIC_MAX_IRQ + 63) & ~63)
-
-typedef struct IRQQueue {
-    unsigned long *queue;
-    int32_t queue_size; /* Only used for VMSTATE_BITMAP */
-    int next;
-    int priority;
-} IRQQueue;
-
-typedef struct IRQSource {
-    uint32_t ivpr;  /* IRQ vector/priority register */
-    uint32_t idr;   /* IRQ destination register */
-    uint32_t destmask; /* bitmap of CPU destinations */
-    int last_cpu;
-    int output;     /* IRQ level, e.g. OPENPIC_OUTPUT_INT */
-    int pending;    /* TRUE if IRQ is pending */
-    IRQType type;
-    bool level:1;   /* level-triggered */
-    bool nomask:1;  /* critical interrupts ignore mask on some FSL MPICs */
-} IRQSource;
-
-#define IVPR_MASK_SHIFT       31
-#define IVPR_MASK_MASK        (1U << IVPR_MASK_SHIFT)
-#define IVPR_ACTIVITY_SHIFT   30
-#define IVPR_ACTIVITY_MASK    (1U << IVPR_ACTIVITY_SHIFT)
-#define IVPR_MODE_SHIFT       29
-#define IVPR_MODE_MASK        (1U << IVPR_MODE_SHIFT)
-#define IVPR_POLARITY_SHIFT   23
-#define IVPR_POLARITY_MASK    (1U << IVPR_POLARITY_SHIFT)
-#define IVPR_SENSE_SHIFT      22
-#define IVPR_SENSE_MASK       (1U << IVPR_SENSE_SHIFT)
-
-#define IVPR_PRIORITY_MASK     (0xFU << 16)
-#define IVPR_PRIORITY(_ivprr_) ((int)(((_ivprr_) & IVPR_PRIORITY_MASK) >> 16))
-#define IVPR_VECTOR(opp, _ivprr_) ((_ivprr_) & (opp)->vector_mask)
-
-/* IDR[EP/CI] are only for FSL MPIC prior to v4.0 */
-#define IDR_EP      0x80000000  /* external pin */
-#define IDR_CI      0x40000000  /* critical interrupt */
-
 /* Convert between openpic clock ticks and nanosecs.  In the hardware the clock
    frequency is driven by board inputs to the PIC which the PIC would then
    divide by 4 or 8.  For now hard code to 25MZ.
@@ -275,81 +193,6 @@ static inline uint64_t ticks_to_ns(uint64_t ticks)
     return ticks * OPENPIC_TIMER_NS_PER_TICK;
 }
 
-typedef struct OpenPICTimer {
-    uint32_t tccr;  /* Global timer current count register */
-    uint32_t tbcr;  /* Global timer base count register */
-    int                   n_IRQ;
-    bool                  qemu_timer_active; /* Is the qemu_timer is running? */
-    struct QEMUTimer     *qemu_timer;
-    struct OpenPICState  *opp;          /* Device timer is part of. */
-    /* The QEMU_CLOCK_VIRTUAL time (in ns) corresponding to the last
-       current_count written or read, only defined if qemu_timer_active. */
-    uint64_t              origin_time;
-} OpenPICTimer;
-
-typedef struct OpenPICMSI {
-    uint32_t msir;   /* Shared Message Signaled Interrupt Register */
-} OpenPICMSI;
-
-typedef struct IRQDest {
-    int32_t ctpr; /* CPU current task priority */
-    IRQQueue raised;
-    IRQQueue servicing;
-    qemu_irq *irqs;
-
-    /* Count of IRQ sources asserting on non-INT outputs */
-    uint32_t outputs_active[OPENPIC_OUTPUT_NB];
-} IRQDest;
-
-#define OPENPIC(obj) OBJECT_CHECK(OpenPICState, (obj), TYPE_OPENPIC)
-
-typedef struct OpenPICState {
-    /*< private >*/
-    SysBusDevice parent_obj;
-    /*< public >*/
-
-    MemoryRegion mem;
-
-    /* Behavior control */
-    FslMpicInfo *fsl;
-    uint32_t model;
-    uint32_t flags;
-    uint32_t nb_irqs;
-    uint32_t vid;
-    uint32_t vir; /* Vendor identification register */
-    uint32_t vector_mask;
-    uint32_t tfrr_reset;
-    uint32_t ivpr_reset;
-    uint32_t idr_reset;
-    uint32_t brr1;
-    uint32_t mpic_mode_mask;
-
-    /* Sub-regions */
-    MemoryRegion sub_io_mem[6];
-
-    /* Global registers */
-    uint32_t frr; /* Feature reporting register */
-    uint32_t gcr; /* Global configuration register  */
-    uint32_t pir; /* Processor initialization register */
-    uint32_t spve; /* Spurious vector register */
-    uint32_t tfrr; /* Timer frequency reporting register */
-    /* Source registers */
-    IRQSource src[OPENPIC_MAX_IRQ];
-    /* Local registers per output pin */
-    IRQDest dst[MAX_CPU];
-    uint32_t nb_cpus;
-    /* Timer registers */
-    OpenPICTimer timers[OPENPIC_MAX_TMR];
-    uint32_t max_tmr;
-
-    /* Shared MSI registers */
-    OpenPICMSI msi[MAX_MSI];
-    uint32_t max_irq;
-    uint32_t irq_ipi0;
-    uint32_t irq_tim0;
-    uint32_t irq_msi;
-} OpenPICState;
-
 static inline void IRQ_setbit(IRQQueue *q, int n_IRQ)
 {
     set_bit(n_IRQ, q->queue);
diff --git a/include/hw/ppc/openpic.h b/include/hw/ppc/openpic.h
index 693e981965..5eb982197d 100644
--- a/include/hw/ppc/openpic.h
+++ b/include/hw/ppc/openpic.h
@@ -2,10 +2,13 @@
 #define OPENPIC_H
 
 #include "qemu-common.h"
+#include "hw/sysbus.h"
 #include "hw/qdev-core.h"
 #include "qom/cpu.h"
 
-#define TYPE_OPENPIC "openpic"
+#define MAX_CPU     32
+#define MAX_MSI     8
+#define VID         0x03 /* MPIC version ID */
 
 /* OpenPIC have 5 outputs per CPU connected and one IRQ out single output */
 enum {
@@ -28,4 +31,158 @@ enum {
 #define OPENPIC_MAX_IRQ     (OPENPIC_MAX_SRC + OPENPIC_MAX_IPI + \
                              OPENPIC_MAX_TMR)
 
+/* Raven */
+#define RAVEN_MAX_CPU      2
+#define RAVEN_MAX_EXT     48
+#define RAVEN_MAX_IRQ     64
+#define RAVEN_MAX_TMR      OPENPIC_MAX_TMR
+#define RAVEN_MAX_IPI      OPENPIC_MAX_IPI
+
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
+/* Interrupt definitions */
+#define RAVEN_FE_IRQ     (RAVEN_MAX_EXT)     /* Internal functional IRQ */
+#define RAVEN_ERR_IRQ    (RAVEN_MAX_EXT + 1) /* Error IRQ */
+#define RAVEN_TMR_IRQ    (RAVEN_MAX_EXT + 2) /* First timer IRQ */
+#define RAVEN_IPI_IRQ    (RAVEN_TMR_IRQ + RAVEN_MAX_TMR) /* First IPI IRQ */
+/* First doorbell IRQ */
+#define RAVEN_DBL_IRQ    (RAVEN_IPI_IRQ + (RAVEN_MAX_CPU * RAVEN_MAX_IPI))
+
+typedef struct FslMpicInfo {
+    int max_ext;
+} FslMpicInfo;
+
+typedef enum IRQType {
+    IRQ_TYPE_NORMAL = 0,
+    IRQ_TYPE_FSLINT,        /* FSL internal interrupt -- level only */
+    IRQ_TYPE_FSLSPECIAL,    /* FSL timer/IPI interrupt, edge, no polarity */
+} IRQType;
+
+/* Round up to the nearest 64 IRQs so that the queue length
+ * won't change when moving between 32 and 64 bit hosts.
+ */
+#define IRQQUEUE_SIZE_BITS ((OPENPIC_MAX_IRQ + 63) & ~63)
+
+typedef struct IRQQueue {
+    unsigned long *queue;
+    int32_t queue_size; /* Only used for VMSTATE_BITMAP */
+    int next;
+    int priority;
+} IRQQueue;
+
+typedef struct IRQSource {
+    uint32_t ivpr;  /* IRQ vector/priority register */
+    uint32_t idr;   /* IRQ destination register */
+    uint32_t destmask; /* bitmap of CPU destinations */
+    int last_cpu;
+    int output;     /* IRQ level, e.g. OPENPIC_OUTPUT_INT */
+    int pending;    /* TRUE if IRQ is pending */
+    IRQType type;
+    bool level:1;   /* level-triggered */
+    bool nomask:1;  /* critical interrupts ignore mask on some FSL MPICs */
+} IRQSource;
+
+#define IVPR_MASK_SHIFT       31
+#define IVPR_MASK_MASK        (1U << IVPR_MASK_SHIFT)
+#define IVPR_ACTIVITY_SHIFT   30
+#define IVPR_ACTIVITY_MASK    (1U << IVPR_ACTIVITY_SHIFT)
+#define IVPR_MODE_SHIFT       29
+#define IVPR_MODE_MASK        (1U << IVPR_MODE_SHIFT)
+#define IVPR_POLARITY_SHIFT   23
+#define IVPR_POLARITY_MASK    (1U << IVPR_POLARITY_SHIFT)
+#define IVPR_SENSE_SHIFT      22
+#define IVPR_SENSE_MASK       (1U << IVPR_SENSE_SHIFT)
+
+#define IVPR_PRIORITY_MASK     (0xFU << 16)
+#define IVPR_PRIORITY(_ivprr_) ((int)(((_ivprr_) & IVPR_PRIORITY_MASK) >> 16))
+#define IVPR_VECTOR(opp, _ivprr_) ((_ivprr_) & (opp)->vector_mask)
+
+/* IDR[EP/CI] are only for FSL MPIC prior to v4.0 */
+#define IDR_EP      0x80000000  /* external pin */
+#define IDR_CI      0x40000000  /* critical interrupt */
+
+typedef struct OpenPICTimer {
+    uint32_t tccr;  /* Global timer current count register */
+    uint32_t tbcr;  /* Global timer base count register */
+    int                   n_IRQ;
+    bool                  qemu_timer_active; /* Is the qemu_timer is running? */
+    struct QEMUTimer     *qemu_timer;
+    struct OpenPICState  *opp;          /* Device timer is part of. */
+    /* The QEMU_CLOCK_VIRTUAL time (in ns) corresponding to the last
+       current_count written or read, only defined if qemu_timer_active. */
+    uint64_t              origin_time;
+} OpenPICTimer;
+
+typedef struct OpenPICMSI {
+    uint32_t msir;   /* Shared Message Signaled Interrupt Register */
+} OpenPICMSI;
+
+typedef struct IRQDest {
+    int32_t ctpr; /* CPU current task priority */
+    IRQQueue raised;
+    IRQQueue servicing;
+    qemu_irq *irqs;
+
+    /* Count of IRQ sources asserting on non-INT outputs */
+    uint32_t outputs_active[OPENPIC_OUTPUT_NB];
+} IRQDest;
+
+#define TYPE_OPENPIC "openpic"
+#define OPENPIC(obj) OBJECT_CHECK(OpenPICState, (obj), TYPE_OPENPIC)
+
+typedef struct OpenPICState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion mem;
+
+    /* Behavior control */
+    FslMpicInfo *fsl;
+    uint32_t model;
+    uint32_t flags;
+    uint32_t nb_irqs;
+    uint32_t vid;
+    uint32_t vir; /* Vendor identification register */
+    uint32_t vector_mask;
+    uint32_t tfrr_reset;
+    uint32_t ivpr_reset;
+    uint32_t idr_reset;
+    uint32_t brr1;
+    uint32_t mpic_mode_mask;
+
+    /* Sub-regions */
+    MemoryRegion sub_io_mem[6];
+
+    /* Global registers */
+    uint32_t frr; /* Feature reporting register */
+    uint32_t gcr; /* Global configuration register  */
+    uint32_t pir; /* Processor initialization register */
+    uint32_t spve; /* Spurious vector register */
+    uint32_t tfrr; /* Timer frequency reporting register */
+    /* Source registers */
+    IRQSource src[OPENPIC_MAX_IRQ];
+    /* Local registers per output pin */
+    IRQDest dst[MAX_CPU];
+    uint32_t nb_cpus;
+    /* Timer registers */
+    OpenPICTimer timers[OPENPIC_MAX_TMR];
+    uint32_t max_tmr;
+
+    /* Shared MSI registers */
+    OpenPICMSI msi[MAX_MSI];
+    uint32_t max_irq;
+    uint32_t irq_ipi0;
+    uint32_t irq_tim0;
+    uint32_t irq_msi;
+} OpenPICState;
+
 #endif /* OPENPIC_H */
-- 
2.14.3
