Received: from eggs.gnu.org ([2001:4830:134:3::10]:38913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrbp-0001g5-6T
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrbl-00028P-Vu
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:05 -0500
Received: from 11.mo3.mail-out.ovh.net ([87.98.184.158]:56342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eHrbl-00025U-LE
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:01 -0500
Received: from player797.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 2B35E175AC7
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 14:32:00 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 23 Nov 2017 14:29:42 +0100
Message-Id: <20171123132955.1261-13-clg@kaod.org>
In-Reply-To: <20171123132955.1261-1-clg@kaod.org>
References: <20171123132955.1261-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 12/25] spapr: introduce a XIVE interrupt
 presenter model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The XIVE interrupt presenter exposes a set of rings, also called
Thread Interrupt Management Areas (TIMA), to handle priority
management and interrupt acknowledgment among other things. There is
one ring per level of privilege, four in all. The one we are
interested in for the sPAPR machine is the OS ring.

The TIMA is mapped at the same address for each CPU. 'current_cpu' is
used to retrieve the targeted interrupt presenter object holding the
cache data of the registers the model use.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c        | 271 ++++++++++++++++++++++++++++++++++++++=
++++++
 hw/intc/xive-internal.h     |  89 +++++++++++++++
 include/hw/ppc/spapr_xive.h |  11 ++
 3 files changed, 371 insertions(+)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index b1e3f8710cff..554b25e0884c 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -23,9 +23,166 @@
 #include "sysemu/dma.h"
 #include "monitor/monitor.h"
 #include "hw/ppc/spapr_xive.h"
+#include "hw/ppc/xics.h"
=20
 #include "xive-internal.h"
=20
+struct sPAPRXiveICP {
+    DeviceState parent_obj;
+
+    CPUState  *cs;
+    uint8_t   tima[TM_RING_COUNT * 0x10];
+    uint8_t   *tima_os;
+    qemu_irq  output;
+};
+
+static uint64_t spapr_xive_icp_accept(sPAPRXiveICP *icp)
+{
+    return 0;
+}
+
+static void spapr_xive_icp_set_cppr(sPAPRXiveICP *icp, uint8_t cppr)
+{
+    if (cppr > XIVE_PRIORITY_MAX) {
+        cppr =3D 0xff;
+    }
+
+    icp->tima_os[TM_CPPR] =3D cppr;
+}
+
+/*
+ * Thread Interrupt Management Area MMIO
+ */
+static uint64_t spapr_xive_tm_read_special(sPAPRXiveICP *icp, hwaddr off=
set,
+                                     unsigned size)
+{
+    uint64_t ret =3D -1;
+
+    if (offset =3D=3D TM_SPC_ACK_OS_REG && size =3D=3D 2) {
+        ret =3D spapr_xive_icp_accept(icp);
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid TIMA read @%"
+                      HWADDR_PRIx" size %d\n", offset, size);
+    }
+
+    return ret;
+}
+
+static uint64_t spapr_xive_tm_read(void *opaque, hwaddr offset, unsigned=
 size)
+{
+    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
+    sPAPRXiveICP *icp =3D SPAPR_XIVE_ICP(cpu->intc);
+    uint64_t ret =3D -1;
+    int i;
+
+    if (offset >=3D TM_SPC_ACK_EBB) {
+        return spapr_xive_tm_read_special(icp, offset, size);
+    }
+
+    if ((offset & 0xf0) =3D=3D TM_QW1_OS) {
+        switch (size) {
+        case 1:
+        case 2:
+        case 4:
+        case 8:
+            if (QEMU_IS_ALIGNED(offset, size)) {
+                ret =3D 0;
+                for (i =3D 0; i < size; i++) {
+                    ret |=3D icp->tima[offset + i] << (8 * i);
+                }
+            } else {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "XIVE: invalid TIMA read alignment @%"
+                              HWADDR_PRIx" size %d\n", offset, size);
+            }
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    } else {
+        qemu_log_mask(LOG_UNIMP, "XIVE: does handle non-OS TIMA ring @%"
+                      HWADDR_PRIx"\n", offset);
+    }
+
+    return ret;
+}
+
+static bool spapr_xive_tm_is_readonly(uint8_t offset)
+{
+    /* Let's be optimistic and prepare ground for HV mode support */
+    switch (offset) {
+    case TM_QW1_OS + TM_CPPR:
+        return false;
+    default:
+        return true;
+    }
+}
+
+static void spapr_xive_tm_write_special(sPAPRXiveICP *icp, hwaddr offset=
,
+                                  uint64_t value, unsigned size)
+{
+    /* TODO: support TM_SPC_SET_OS_PENDING */
+
+    /* TODO: support TM_SPC_ACK_OS_EL */
+}
+
+static void spapr_xive_tm_write(void *opaque, hwaddr offset,
+                           uint64_t value, unsigned size)
+{
+    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
+    sPAPRXiveICP *icp =3D SPAPR_XIVE_ICP(cpu->intc);
+    int i;
+
+    if (offset >=3D TM_SPC_ACK_EBB) {
+        spapr_xive_tm_write_special(icp, offset, value, size);
+        return;
+    }
+
+    if ((offset & 0xf0) =3D=3D TM_QW1_OS) {
+        switch (size) {
+        case 1:
+            if (offset =3D=3D TM_QW1_OS + TM_CPPR) {
+                spapr_xive_icp_set_cppr(icp, value & 0xff);
+            }
+            break;
+        case 4:
+        case 8:
+            if (QEMU_IS_ALIGNED(offset, size)) {
+                for (i =3D 0; i < size; i++) {
+                    if (!spapr_xive_tm_is_readonly(offset + i)) {
+                        icp->tima[offset + i] =3D (value >> (8 * i)) & 0=
xff;
+                    }
+                }
+            } else {
+                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid TIMA write=
 @%"
+                              HWADDR_PRIx" size %d\n", offset, size);
+            }
+            break;
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid TIMA write @%"
+                          HWADDR_PRIx" size %d\n", offset, size);
+        }
+    } else {
+        qemu_log_mask(LOG_UNIMP, "XIVE: does handle non-OS TIMA ring @%"
+                      HWADDR_PRIx"\n", offset);
+    }
+}
+
+
+static const MemoryRegionOps spapr_xive_tm_ops =3D {
+    .read =3D spapr_xive_tm_read,
+    .write =3D spapr_xive_tm_write,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 1,
+        .max_access_size =3D 8,
+    },
+    .impl =3D {
+        .min_access_size =3D 1,
+        .max_access_size =3D 8,
+    },
+};
+
 static void spapr_xive_irq(sPAPRXive *xive, int lisn)
 {
=20
@@ -287,6 +444,11 @@ static void spapr_xive_source_set_irq(void *opaque, =
int lisn, int val)
 #define VC_BAR_SIZE      0x08000000000ull
 #define ESB_SHIFT        16 /* One 64k page. OPAL has two */
=20
+/* Thread Interrupt Management Area MMIO */
+#define TM_BAR_DEFAULT   0x30203180000ull
+#define TM_SHIFT         16
+#define TM_BAR_SIZE      (TM_RING_COUNT * (1 << TM_SHIFT))
+
 static uint64_t spapr_xive_esb_default_read(void *p, hwaddr offset,
                                             unsigned size)
 {
@@ -392,6 +554,14 @@ static void spapr_xive_realize(DeviceState *dev, Err=
or **errp)
                           (1ull << xive->esb_shift) * xive->nr_irqs);
     memory_region_add_subregion(&xive->esb_mr, 0, &xive->esb_iomem);
=20
+    /* TM BAR. Same address for each chip */
+    xive->tm_base =3D (P9_MMIO_BASE | TM_BAR_DEFAULT);
+    xive->tm_shift =3D TM_SHIFT;
+
+    memory_region_init_io(&xive->tm_iomem, OBJECT(xive), &spapr_xive_tm_=
ops,
+                          xive, "xive.tm", TM_BAR_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &xive->tm_iomem);
+
     qemu_register_reset(spapr_xive_reset, dev);
 }
=20
@@ -448,9 +618,110 @@ static const TypeInfo spapr_xive_info =3D {
     .class_init =3D spapr_xive_class_init,
 };
=20
+void spapr_xive_icp_pic_print_info(sPAPRXiveICP *xicp, Monitor *mon)
+{
+    int cpu_index =3D xicp->cs ? xicp->cs->cpu_index : -1;
+
+    monitor_printf(mon, "CPU %d CPPR=3D%02x IPB=3D%02x PIPR=3D%02x NSR=3D=
%02x\n",
+                   cpu_index, xicp->tima_os[TM_CPPR], xicp->tima_os[TM_I=
PB],
+                   xicp->tima_os[TM_PIPR], xicp->tima_os[TM_NSR]);
+}
+
+static void spapr_xive_icp_reset(void *dev)
+{
+    sPAPRXiveICP *xicp =3D SPAPR_XIVE_ICP(dev);
+
+    memset(xicp->tima, 0, sizeof(xicp->tima));
+}
+
+static void spapr_xive_icp_realize(DeviceState *dev, Error **errp)
+{
+    sPAPRXiveICP *xicp =3D SPAPR_XIVE_ICP(dev);
+    PowerPCCPU *cpu;
+    CPUPPCState *env;
+    Object *obj;
+    Error *err =3D NULL;
+
+    obj =3D object_property_get_link(OBJECT(dev), ICP_PROP_CPU, &err);
+    if (!obj) {
+        error_propagate(errp, err);
+        error_prepend(errp, "required link '" ICP_PROP_CPU "' not found:=
 ");
+        return;
+    }
+
+    cpu =3D POWERPC_CPU(obj);
+    xicp->cs =3D CPU(obj);
+
+    env =3D &cpu->env;
+    switch (PPC_INPUT(env)) {
+    case PPC_FLAGS_INPUT_POWER7:
+        xicp->output =3D env->irq_inputs[POWER7_INPUT_INT];
+        break;
+
+    case PPC_FLAGS_INPUT_970:
+        xicp->output =3D env->irq_inputs[PPC970_INPUT_INT];
+        break;
+
+    default:
+        error_setg(errp, "XIVE interrupt controller does not support "
+                   "this CPU bus model");
+        return;
+    }
+
+    qemu_register_reset(spapr_xive_icp_reset, dev);
+}
+
+static void spapr_xive_icp_unrealize(DeviceState *dev, Error **errp)
+{
+    qemu_unregister_reset(spapr_xive_icp_reset, dev);
+}
+
+static void spapr_xive_icp_init(Object *obj)
+{
+    sPAPRXiveICP *xicp =3D SPAPR_XIVE_ICP(obj);
+
+    xicp->tima_os =3D &xicp->tima[TM_QW1_OS];
+}
+
+static bool vmstate_spapr_xive_icp_needed(void *opaque)
+{
+    /* TODO check machine XIVE support */
+    return true;
+}
+
+static const VMStateDescription vmstate_spapr_xive_icp =3D {
+    .name =3D TYPE_SPAPR_XIVE_ICP,
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .needed =3D vmstate_spapr_xive_icp_needed,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_BUFFER(tima, sPAPRXiveICP),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void spapr_xive_icp_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D spapr_xive_icp_realize;
+    dc->unrealize =3D spapr_xive_icp_unrealize;
+    dc->desc =3D "sPAPR XIVE Interrupt Presenter";
+    dc->vmsd =3D &vmstate_spapr_xive_icp;
+}
+
+static const TypeInfo xive_icp_info =3D {
+    .name          =3D TYPE_SPAPR_XIVE_ICP,
+    .parent        =3D TYPE_DEVICE,
+    .instance_size =3D sizeof(sPAPRXiveICP),
+    .instance_init =3D spapr_xive_icp_init,
+    .class_init    =3D spapr_xive_icp_class_init,
+};
+
 static void spapr_xive_register_types(void)
 {
     type_register_static(&spapr_xive_info);
+    type_register_static(&xive_icp_info);
 }
=20
 type_init(spapr_xive_register_types)
diff --git a/hw/intc/xive-internal.h b/hw/intc/xive-internal.h
index bea88d82992c..7d329f203a9b 100644
--- a/hw/intc/xive-internal.h
+++ b/hw/intc/xive-internal.h
@@ -24,6 +24,93 @@
 #define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
                                  PPC_BIT32(bs))
=20
+/*
+ * Thread Management (aka "TM") registers
+ */
+
+/* Number of Thread Management Interrupt Areas */
+#define TM_RING_COUNT 4
+
+/* TM register offsets */
+#define TM_QW0_USER             0x000 /* All rings */
+#define TM_QW1_OS               0x010 /* Ring 0..2 */
+#define TM_QW2_HV_POOL          0x020 /* Ring 0..1 */
+#define TM_QW3_HV_PHYS          0x030 /* Ring 0..1 */
+
+/* Byte offsets inside a QW             QW0 QW1 QW2 QW3 */
+#define TM_NSR                  0x0  /*  +   +   -   +  */
+#define TM_CPPR                 0x1  /*  -   +   -   +  */
+#define TM_IPB                  0x2  /*  -   +   +   +  */
+#define TM_LSMFB                0x3  /*  -   +   +   +  */
+#define TM_ACK_CNT              0x4  /*  -   +   -   -  */
+#define TM_INC                  0x5  /*  -   +   -   +  */
+#define TM_AGE                  0x6  /*  -   +   -   +  */
+#define TM_PIPR                 0x7  /*  -   +   -   +  */
+
+#define TM_WORD0                0x0
+#define TM_WORD1                0x4
+
+/*
+ * QW word 2 contains the valid bit at the top and other fields
+ * depending on the QW.
+ */
+#define TM_WORD2                0x8
+#define   TM_QW0W2_VU           PPC_BIT32(0)
+#define   TM_QW0W2_LOGIC_SERV   PPC_BITMASK32(1, 31) /* XX 2,31 ? */
+#define   TM_QW1W2_VO           PPC_BIT32(0)
+#define   TM_QW1W2_OS_CAM       PPC_BITMASK32(8, 31)
+#define   TM_QW2W2_VP           PPC_BIT32(0)
+#define   TM_QW2W2_POOL_CAM     PPC_BITMASK32(8, 31)
+#define   TM_QW3W2_VT           PPC_BIT32(0)
+#define   TM_QW3W2_LP           PPC_BIT32(6)
+#define   TM_QW3W2_LE           PPC_BIT32(7)
+#define   TM_QW3W2_T            PPC_BIT32(31)
+
+/*
+ * In addition to normal loads to "peek" and writes (only when invalid)
+ * using 4 and 8 bytes accesses, the above registers support these
+ * "special" byte operations:
+ *
+ *   - Byte load from QW0[NSR] - User level NSR (EBB)
+ *   - Byte store to QW0[NSR] - User level NSR (EBB)
+ *   - Byte load/store to QW1[CPPR] and QW3[CPPR] - CPPR access
+ *   - Byte load from QW3[TM_WORD2] - Read VT||00000||LP||LE on thrd 0
+ *                                    otherwise VT||0000000
+ *   - Byte store to QW3[TM_WORD2] - Set VT bit (and LP/LE if present)
+ *
+ * Then we have all these "special" CI ops at these offset that trigger
+ * all sorts of side effects:
+ */
+#define TM_SPC_ACK_EBB          0x800   /* Load8 ack EBB to reg*/
+#define TM_SPC_ACK_OS_REG       0x810   /* Load16 ack OS irq to reg */
+#define TM_SPC_PUSH_USR_CTX     0x808   /* Store32 Push/Validate user co=
ntext */
+#define TM_SPC_PULL_USR_CTX     0x808   /* Load32 Pull/Invalidate user
+                                         * context */
+#define TM_SPC_SET_OS_PENDING   0x812   /* Store8 Set OS irq pending bit=
 */
+#define TM_SPC_PULL_OS_CTX      0x818   /* Load32/Load64 Pull/Invalidate=
 OS
+                                         * context to reg */
+#define TM_SPC_PULL_POOL_CTX    0x828   /* Load32/Load64 Pull/Invalidate=
 Pool
+                                         * context to reg*/
+#define TM_SPC_ACK_HV_REG       0x830   /* Load16 ack HV irq to reg */
+#define TM_SPC_PULL_USR_CTX_OL  0xc08   /* Store8 Pull/Inval usr ctx to =
odd
+                                         * line */
+#define TM_SPC_ACK_OS_EL        0xc10   /* Store8 ack OS irq to even lin=
e */
+#define TM_SPC_ACK_HV_POOL_EL   0xc20   /* Store8 ack HV evt pool to eve=
n
+                                         * line */
+#define TM_SPC_ACK_HV_EL        0xc30   /* Store8 ack HV irq to even lin=
e */
+/* XXX more... */
+
+/* NSR fields for the various QW ack types */
+#define TM_QW0_NSR_EB           PPC_BIT8(0)
+#define TM_QW1_NSR_EO           PPC_BIT8(0)
+#define TM_QW3_NSR_HE           PPC_BITMASK8(0, 1)
+#define  TM_QW3_NSR_HE_NONE     0
+#define  TM_QW3_NSR_HE_POOL     1
+#define  TM_QW3_NSR_HE_PHYS     2
+#define  TM_QW3_NSR_HE_LSI      3
+#define TM_QW3_NSR_I            PPC_BIT8(2)
+#define TM_QW3_NSR_GRP_LVL      PPC_BIT8(3, 7)
+
 /* IVE/EAS
  *
  * One per interrupt source. Targets that interrupt to a given EQ
@@ -44,6 +131,8 @@ typedef struct XiveIVE {
 #define IVE_EQ_DATA     PPC_BITMASK(33, 63)      /* Data written to the =
EQ */
 } XiveIVE;
=20
+#define XIVE_PRIORITY_MAX  7
+
 void spapr_xive_reset(void *dev);
 XiveIVE *spapr_xive_get_ive(sPAPRXive *xive, uint32_t lisn);
=20
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 7a308fb4db2b..6e8a189e723f 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -23,10 +23,15 @@
=20
 typedef struct sPAPRXive sPAPRXive;
 typedef struct XiveIVE XiveIVE;
+typedef struct sPAPRXiveICP sPAPRXiveICP;
=20
 #define TYPE_SPAPR_XIVE "spapr-xive"
 #define SPAPR_XIVE(obj) OBJECT_CHECK(sPAPRXive, (obj), TYPE_SPAPR_XIVE)
=20
+#define TYPE_SPAPR_XIVE_ICP "spapr-xive-icp"
+#define SPAPR_XIVE_ICP(obj) \
+    OBJECT_CHECK(sPAPRXiveICP, (obj), TYPE_SPAPR_XIVE_ICP)
+
 struct sPAPRXive {
     SysBusDevice parent;
=20
@@ -57,6 +62,11 @@ struct sPAPRXive {
     hwaddr       esb_base;
     MemoryRegion esb_mr;
     MemoryRegion esb_iomem;
+
+    /* TIMA memory region */
+    uint32_t     tm_shift;
+    hwaddr       tm_base;
+    MemoryRegion tm_iomem;
 };
=20
 static inline bool spapr_xive_irq_is_lsi(sPAPRXive *xive, int lisn)
@@ -67,5 +77,6 @@ static inline bool spapr_xive_irq_is_lsi(sPAPRXive *xiv=
e, int lisn)
 bool spapr_xive_irq_set(sPAPRXive *xive, uint32_t lisn, bool lsi);
 bool spapr_xive_irq_unset(sPAPRXive *xive, uint32_t lisn);
 void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
+void spapr_xive_icp_pic_print_info(sPAPRXiveICP *xicp, Monitor *mon);
=20
 #endif /* PPC_SPAPR_XIVE_H */
--=20
2.13.6
