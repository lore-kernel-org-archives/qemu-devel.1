Received: from eggs.gnu.org ([2001:4830:134:3::10]:45337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNakK-00012c-QX
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:44:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNakG-0006yM-Qk
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:44:32 -0500
Received: from 20.mo6.mail-out.ovh.net ([178.32.124.17]:58784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eNakG-0006wm-HW
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:44:28 -0500
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 17E9D1277C8
	for <qemu-devel@nongnu.org>; Sat,  9 Dec 2017 09:44:27 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sat,  9 Dec 2017 09:43:24 +0100
Message-Id: <20171209084338.29395-6-clg@kaod.org>
In-Reply-To: <20171209084338.29395-1-clg@kaod.org>
References: <20171209084338.29395-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 05/19] spapr: introduce a XIVE interrupt
 presenter model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kurz <groug@kaod.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Once an event has been routed by the IVRE, it reaches the XIVE
virtualization presentation engine which, simply speaking, raises one
bit in the Interrupt Pending Buffer (IBP) register corresponding to
the priority of the pending interrupt. This indicates there is an
event pending in one of the 8 priority queues and the interrupt can
then be delivered to the Virtual Processor.

The XIVE presenter engine uses a set of registers to handle priority
management and interrupt acknowledgment among other things. The most
important being :

  - Interrupt Priority Register (PIPR)
  - Interrupt Pending Buffer (IPB)
  - Current Processor Priority (CPPR)
  - Notification Source Register (NSR)

There is one set of registers per level of privilege, four in all :
HW, HV pool, OS and User. These are called rings. All registers are
accessible through a specific MMIO region called the Thread Interrupt
Management Areas (TIMA) but, depending on the privilege level of the
CPU, the view of the TIMA is filtered. The sPAPR machine runs at the
OS privilege and therefore can only accesses the OS and the User
rings. The others are for hypervisor levels.

The CPU interrupt state is modeled with a sPAPRXiveNVT object which
stores the values of the different registers. The different TIMA views
are mapped at the same address for each CPU and 'current_cpu' is used
to retrieve the sPAPRXiveNVT holding the ring registers.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes since v1:

 - renamed 'sPAPRXiveICP' to 'sPAPRXiveNVT'
 - renamed 'tima' to 'regs'=20
 - renamed 'tima_os' to 'ring_os'
 - introduced TM_RING_SIZE=20
 - removed 'tm_shift' field
 - introduced a memory region to model the User TIMA and another one
   for the OS TIMA. One page size for each.
 - removed useless checks in the memory region handlers
 - removed support for 970 ...
=20
 hw/intc/spapr_xive.c        | 281 ++++++++++++++++++++++++++++++++++++++=
++++++
 hw/intc/xive-internal.h     |  92 +++++++++++++++
 include/hw/ppc/spapr_xive.h |  11 ++
 3 files changed, 384 insertions(+)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index c772c726667f..53f0e698e135 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -15,9 +15,177 @@
 #include "sysemu/dma.h"
 #include "monitor/monitor.h"
 #include "hw/ppc/spapr_xive.h"
+#include "hw/ppc/xics.h"
=20
 #include "xive-internal.h"
=20
+struct sPAPRXiveNVT {
+    DeviceState parent_obj;
+
+    CPUState  *cs;
+    qemu_irq  output;
+
+    /* Registers for all rings but sPAPR can only access the OS ring */
+    uint8_t   regs[TM_RING_COUNT * TM_RING_SIZE];
+
+    /* Shortcut to the OS ring */
+    uint8_t   *ring_os;
+};
+
+static uint64_t spapr_xive_nvt_accept(sPAPRXiveNVT *nvt)
+{
+    return 0;
+}
+
+static void spapr_xive_nvt_set_cppr(sPAPRXiveNVT *nvt, uint8_t cppr)
+{
+    if (cppr > XIVE_PRIORITY_MAX) {
+        cppr =3D 0xff;
+    }
+
+    nvt->ring_os[TM_CPPR] =3D cppr;
+}
+
+/*
+ * Thread Interrupt Management Area MMIO
+ */
+static uint64_t spapr_xive_tm_read_special(sPAPRXiveNVT *nvt, hwaddr off=
set,
+                                           unsigned size)
+{
+    uint64_t ret =3D -1;
+
+    if (offset =3D=3D TM_SPC_ACK_OS_REG && size =3D=3D 2) {
+        ret =3D spapr_xive_nvt_accept(nvt);
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid TIMA read @%"
+                      HWADDR_PRIx" size %d\n", offset, size);
+    }
+
+    return ret;
+}
+
+#define TM_RING(offset) ((offset) & 0xf0)
+
+static uint64_t spapr_xive_tm_os_read(void *opaque, hwaddr offset,
+                                      unsigned size)
+{
+    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
+    sPAPRXiveNVT *nvt =3D SPAPR_XIVE_NVT(cpu->intc);
+    uint64_t ret =3D -1;
+    int i;
+
+    if (offset >=3D TM_SPC_ACK_EBB) {
+        return spapr_xive_tm_read_special(nvt, offset, size);
+    }
+
+    if (TM_RING(offset) !=3D TM_QW1_OS) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid access to non-OS r=
ing @%"
+                      HWADDR_PRIx"\n", offset);
+        return ret;
+    }
+
+    ret =3D 0;
+    for (i =3D 0; i < size; i++) {
+        ret |=3D nvt->regs[offset + i] << (8 * i);
+    }
+
+    return ret;
+}
+
+static bool spapr_xive_tm_is_readonly(uint8_t offset)
+{
+    return offset !=3D TM_QW1_OS + TM_CPPR;
+}
+
+static void spapr_xive_tm_write_special(sPAPRXiveNVT *nvt, hwaddr offset=
,
+                                        uint64_t value, unsigned size)
+{
+    /* TODO: support TM_SPC_SET_OS_PENDING */
+
+    /* TODO: support TM_SPC_ACK_OS_EL */
+}
+
+static void spapr_xive_tm_os_write(void *opaque, hwaddr offset,
+                                   uint64_t value, unsigned size)
+{
+    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
+    sPAPRXiveNVT *nvt =3D SPAPR_XIVE_NVT(cpu->intc);
+    int i;
+
+    if (offset >=3D TM_SPC_ACK_EBB) {
+        spapr_xive_tm_write_special(nvt, offset, value, size);
+        return;
+    }
+
+    if (TM_RING(offset) !=3D TM_QW1_OS) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid access to non-OS r=
ing @%"
+                      HWADDR_PRIx"\n", offset);
+        return;
+    }
+
+    switch (size) {
+    case 1:
+        if (offset =3D=3D TM_QW1_OS + TM_CPPR) {
+            spapr_xive_nvt_set_cppr(nvt, value & 0xff);
+        }
+        break;
+    case 4:
+    case 8:
+        for (i =3D 0; i < size; i++) {
+            if (!spapr_xive_tm_is_readonly(offset + i)) {
+                nvt->regs[offset + i] =3D (value >> (8 * i)) & 0xff;
+            }
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static const MemoryRegionOps spapr_xive_tm_os_ops =3D {
+    .read =3D spapr_xive_tm_os_read,
+    .write =3D spapr_xive_tm_os_write,
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
+static uint64_t spapr_xive_tm_user_read(void *opaque, hwaddr offset,
+                                        unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP, "XIVE: invalid access to User TIMA @%"
+                  HWADDR_PRIx"\n", offset);
+    return -1;
+}
+
+static void spapr_xive_tm_user_write(void *opaque, hwaddr offset,
+                                     uint64_t value, unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP, "XIVE: invalid access to User TIMA @%"
+                  HWADDR_PRIx"\n", offset);
+}
+
+
+static const MemoryRegionOps spapr_xive_tm_user_ops =3D {
+    .read =3D spapr_xive_tm_user_read,
+    .write =3D spapr_xive_tm_user_write,
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
@@ -358,6 +526,22 @@ static void spapr_xive_realize(DeviceState *dev, Err=
or **errp)
                           &spapr_xive_esb_ops, xive, "xive.esb",
                           (1ull << ESB_SHIFT) * xive->nr_irqs);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &xive->esb_iomem);
+
+    /* The Thread Interrupt Management Area has the same address for
+     * each chip. On sPAPR, we only need to expose the User and OS
+     * level views of the TIMA.
+     */
+    xive->tm_base =3D (P9_MMIO_BASE | TM_BAR_DEFAULT);
+
+    memory_region_init_io(&xive->tm_iomem_user, OBJECT(xive),
+                          &spapr_xive_tm_user_ops, xive, "xive.tima.user=
",
+                          1ull << TM_SHIFT);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &xive->tm_iomem_user);
+
+    memory_region_init_io(&xive->tm_iomem_os, OBJECT(xive),
+                          &spapr_xive_tm_os_ops, xive, "xive.tima.os",
+                          1ull << TM_SHIFT);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &xive->tm_iomem_os);
 }
=20
 static const VMStateDescription vmstate_spapr_xive_ive =3D {
@@ -413,9 +597,106 @@ static const TypeInfo spapr_xive_info =3D {
     .class_init =3D spapr_xive_class_init,
 };
=20
+void spapr_xive_nvt_pic_print_info(sPAPRXiveNVT *nvt, Monitor *mon)
+{
+    int cpu_index =3D nvt->cs ? nvt->cs->cpu_index : -1;
+
+    monitor_printf(mon, "CPU %d CPPR=3D%02x IPB=3D%02x PIPR=3D%02x NSR=3D=
%02x\n",
+                   cpu_index, nvt->ring_os[TM_CPPR], nvt->ring_os[TM_IPB=
],
+                   nvt->ring_os[TM_PIPR], nvt->ring_os[TM_NSR]);
+}
+
+static void spapr_xive_nvt_reset(void *dev)
+{
+    sPAPRXiveNVT *nvt =3D SPAPR_XIVE_NVT(dev);
+
+    memset(nvt->regs, 0, sizeof(nvt->regs));
+}
+
+static void spapr_xive_nvt_realize(DeviceState *dev, Error **errp)
+{
+    sPAPRXiveNVT *nvt =3D SPAPR_XIVE_NVT(dev);
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
+    nvt->cs =3D CPU(obj);
+
+    env =3D &cpu->env;
+    switch (PPC_INPUT(env)) {
+    case PPC_FLAGS_INPUT_POWER7:
+        nvt->output =3D env->irq_inputs[POWER7_INPUT_INT];
+        break;
+
+    default:
+        error_setg(errp, "XIVE interrupt controller does not support "
+                   "this CPU bus model");
+        return;
+    }
+
+    qemu_register_reset(spapr_xive_nvt_reset, dev);
+}
+
+static void spapr_xive_nvt_unrealize(DeviceState *dev, Error **errp)
+{
+    qemu_unregister_reset(spapr_xive_nvt_reset, dev);
+}
+
+static void spapr_xive_nvt_init(Object *obj)
+{
+    sPAPRXiveNVT *nvt =3D SPAPR_XIVE_NVT(obj);
+
+    nvt->ring_os =3D &nvt->regs[TM_QW1_OS];
+}
+
+static bool vmstate_spapr_xive_nvt_needed(void *opaque)
+{
+    /* TODO check machine XIVE support */
+    return true;
+}
+
+static const VMStateDescription vmstate_spapr_xive_nvt =3D {
+    .name =3D TYPE_SPAPR_XIVE_NVT,
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .needed =3D vmstate_spapr_xive_nvt_needed,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_BUFFER(regs, sPAPRXiveNVT),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void spapr_xive_nvt_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D spapr_xive_nvt_realize;
+    dc->unrealize =3D spapr_xive_nvt_unrealize;
+    dc->desc =3D "sPAPR XIVE Interrupt Presenter";
+    dc->vmsd =3D &vmstate_spapr_xive_nvt;
+}
+
+static const TypeInfo xive_nvt_info =3D {
+    .name          =3D TYPE_SPAPR_XIVE_NVT,
+    .parent        =3D TYPE_DEVICE,
+    .instance_size =3D sizeof(sPAPRXiveNVT),
+    .instance_init =3D spapr_xive_nvt_init,
+    .class_init    =3D spapr_xive_nvt_class_init,
+};
+
 static void spapr_xive_register_types(void)
 {
     type_register_static(&spapr_xive_info);
+    type_register_static(&xive_nvt_info);
 }
=20
 type_init(spapr_xive_register_types)
diff --git a/hw/intc/xive-internal.h b/hw/intc/xive-internal.h
index 872648dd96a2..49f4b7c5f393 100644
--- a/hw/intc/xive-internal.h
+++ b/hw/intc/xive-internal.h
@@ -26,6 +26,96 @@
 #define VC_BAR_SIZE      0x08000000000ull
 #define ESB_SHIFT        16 /* One 64k page. OPAL has two */
=20
+/* Thread Interrupt Management Area */
+#define TM_BAR_DEFAULT   0x30203180000ull
+#define TM_SHIFT         16
+
+/*
+ * Thread Management (aka "TM") registers
+ */
+#define TM_RING_COUNT           4
+#define TM_RING_SIZE            0x10
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
@@ -46,6 +136,8 @@ typedef struct XiveIVE {
 #define IVE_EQ_DATA     PPC_BITMASK(33, 63)      /* Data written to the =
EQ */
 } XiveIVE;
=20
+#define XIVE_PRIORITY_MAX  7
+
 XiveIVE *spapr_xive_get_ive(sPAPRXive *xive, uint32_t lisn);
=20
 #endif /* _INTC_XIVE_INTERNAL_H */
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index a7e59fd601d7..dcaa69025878 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -14,10 +14,15 @@
=20
 typedef struct sPAPRXive sPAPRXive;
 typedef struct XiveIVE XiveIVE;
+typedef struct sPAPRXiveNVT sPAPRXiveNVT;
=20
 #define TYPE_SPAPR_XIVE "spapr-xive"
 #define SPAPR_XIVE(obj) OBJECT_CHECK(sPAPRXive, (obj), TYPE_SPAPR_XIVE)
=20
+#define TYPE_SPAPR_XIVE_NVT "spapr-xive-nvt"
+#define SPAPR_XIVE_NVT(obj) \
+    OBJECT_CHECK(sPAPRXiveNVT, (obj), TYPE_SPAPR_XIVE_NVT)
+
 struct sPAPRXive {
     SysBusDevice parent;
=20
@@ -38,6 +43,11 @@ struct sPAPRXive {
     /* ESB memory region */
     hwaddr       esb_base;
     MemoryRegion esb_iomem;
+
+    /* TIMA memory regions */
+    hwaddr       tm_base;
+    MemoryRegion tm_iomem_user;
+    MemoryRegion tm_iomem_os;
 };
=20
 static inline bool spapr_xive_irq_is_lsi(sPAPRXive *xive, int lisn)
@@ -48,5 +58,6 @@ static inline bool spapr_xive_irq_is_lsi(sPAPRXive *xiv=
e, int lisn)
 bool spapr_xive_irq_enable(sPAPRXive *xive, uint32_t lisn, bool lsi);
 bool spapr_xive_irq_disable(sPAPRXive *xive, uint32_t lisn);
 void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
+void spapr_xive_nvt_pic_print_info(sPAPRXiveNVT *nvt, Monitor *mon);
=20
 #endif /* PPC_SPAPR_XIVE_H */
--=20
2.13.6
