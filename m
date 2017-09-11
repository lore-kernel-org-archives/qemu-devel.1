Received: from eggs.gnu.org ([2001:4830:134:3::10]:35260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSHe-0001DJ-Hg
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:14:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSHa-0004Lt-4x
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:14:06 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:44991)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1drSHZ-0004Kf-Rt
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:14:02 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id DFC8FAB108
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 19:14:00 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 11 Sep 2017 19:12:24 +0200
Message-Id: <20170911171235.29331-11-clg@kaod.org>
In-Reply-To: <20170911171235.29331-1-clg@kaod.org>
References: <20170911171235.29331-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 10/21] ppc/xive: add MMIO handlers for
 the XIVE TIMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The Thread Interrupt Management Area for the OS is mostly used to
acknowledge interrupts and set the CPPR of the CPU.

The TIMA is mapped at the same address for each CPU. 'current_cpu' is
used to retrieve the targeted interrupt presenter object holding the
cache data of the registers.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c        | 161 ++++++++++++++++++++++++++++++++++++++=
++++++
 hw/intc/xive-internal.h     |  84 +++++++++++++++++++++++
 include/hw/ppc/spapr_xive.h |   5 ++
 3 files changed, 250 insertions(+)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index a1ce993d2afa..557a7e2535b5 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -27,6 +27,154 @@
=20
 #include "xive-internal.h"
=20
+
+static uint64_t spapr_xive_icp_accept(ICPState *icp)
+{
+    return 0;
+}
+
+static void spapr_xive_icp_set_cppr(ICPState *icp, uint8_t cppr)
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
+static uint64_t spapr_xive_tm_read_special(ICPState *icp, hwaddr offset,
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
+    ICPState *icp =3D ICP(cpu->intc);
+    uint64_t ret =3D -1;
+    int i;
+
+    if (offset >=3D TM_SPC_ACK_EBB) {
+        return spapr_xive_tm_read_special(icp, offset, size);
+    }
+
+    if (offset & TM_QW1_OS) {
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
+static bool spapr_xive_tm_is_readonly(uint8_t index)
+{
+    /* Let's be optimistic and prepare ground for HV mode support */
+    switch (index) {
+    case TM_QW1_OS + TM_CPPR:
+        return false;
+    default:
+        return true;
+    }
+}
+
+static void spapr_xive_tm_write_special(ICPState *icp, hwaddr offset,
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
+    ICPState *icp =3D ICP(cpu->intc);
+    int i;
+
+    if (offset >=3D TM_SPC_ACK_EBB) {
+        spapr_xive_tm_write_special(icp, offset, value, size);
+        return;
+    }
+
+    if (offset & TM_QW1_OS) {
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
 static void spapr_xive_irq(sPAPRXive *xive, int srcno)
 {
=20
@@ -293,6 +441,11 @@ static void spapr_xive_source_set_irq(void *opaque, =
int srcno, int val)
 #define VC_BAR_SIZE      0x08000000000ull
 #define ESB_SHIFT        16 /* One 64k page. OPAL has two */
=20
+/* Thread Interrupt Management Area MMIO */
+#define TM_BAR_DEFAULT   0x30203180000ull
+#define TM_SHIFT         16
+#define TM_BAR_SIZE      (XIVE_TM_RING_COUNT * (1 << TM_SHIFT))
+
 static uint64_t spapr_xive_esb_default_read(void *p, hwaddr offset,
                                             unsigned size)
 {
@@ -403,6 +556,14 @@ static void spapr_xive_realize(DeviceState *dev, Err=
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
diff --git a/hw/intc/xive-internal.h b/hw/intc/xive-internal.h
index 95184bad5c1d..c6678ec7d161 100644
--- a/hw/intc/xive-internal.h
+++ b/hw/intc/xive-internal.h
@@ -24,6 +24,90 @@
 #define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
                                  PPC_BIT32(bs))
=20
+/*
+ * Thread Management (aka "TM") registers
+ */
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
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index b46e59319236..3af01a0a4b22 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -59,6 +59,11 @@ struct sPAPRXive {
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
 #endif /* PPC_SPAPR_XIVE_H */
--=20
2.13.5
