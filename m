Received: from eggs.gnu.org ([2001:4830:134:3::10]:41672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnth-0004K2-9f
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:15:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSntd-0003LK-56
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:15:29 -0400
Received: from 6.mo3.mail-out.ovh.net ([188.165.43.173]:38992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dSntc-0003KT-Rv
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:15:25 -0400
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 93C0BFCADA
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 19:15:23 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Jul 2017 19:13:27 +0200
Message-Id: <1499274819-15607-15-git-send-email-clg@kaod.org>
In-Reply-To: <1499274819-15607-1-git-send-email-clg@kaod.org>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 14/26] ppc/xive: add MMIO handlers to the
 XIVE interrupt presenter model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The Thread Interrupt Management Area for the OS is mostly used to
acknowledge interrupts and set the CPPR of the CPU.

The TIMA is mapped at the same address for each CPU. 'current_cpu' is
used to retrieve the targeted interrupt presenter object.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xive-internal.h |   4 ++
 hw/intc/xive.c          | 187 ++++++++++++++++++++++++++++++++++++++++++=
++++++
 2 files changed, 191 insertions(+)

diff --git a/hw/intc/xive-internal.h b/hw/intc/xive-internal.h
index ba5e648a5258..5e8b78a1ea6a 100644
--- a/hw/intc/xive-internal.h
+++ b/hw/intc/xive-internal.h
@@ -200,6 +200,10 @@ struct XIVE {
     /* ESB and TIMA memory location */
     hwaddr       vc_base;
     MemoryRegion esb_iomem;
+
+    uint32_t     tm_shift;
+    hwaddr       tm_base;
+    MemoryRegion tm_iomem;
 };
=20
 void xive_reset(void *dev);
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index c08a4f8efb58..82b2f0dcda0b 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -26,6 +26,180 @@
=20
 #include "xive-internal.h"
=20
+static uint8_t priority_to_ipb(uint8_t priority)
+{
+    return priority < XIVE_EQ_PRIORITY_COUNT ? 1 << (7 - priority) : 0;
+}
+
+static uint64_t xive_icp_accept(XiveICPState *xicp)
+{
+    ICPState *icp =3D ICP(xicp);
+    uint8_t nsr =3D xicp->tima_os[TM_NSR];
+
+    qemu_irq_lower(icp->output);
+
+    if (xicp->tima_os[TM_NSR] & TM_QW1_NSR_EO) {
+        uint8_t cppr =3D xicp->tima_os[TM_PIPR];
+
+        xicp->tima_os[TM_CPPR] =3D cppr;
+
+        /* Reset the pending buffer bit */
+        xicp->tima_os[TM_IPB] &=3D ~priority_to_ipb(cppr);
+
+        /* Drop Exception bit for OS */
+        xicp->tima_os[TM_NSR] &=3D ~TM_QW1_NSR_EO;
+    }
+
+    return (nsr << 8) | xicp->tima_os[TM_CPPR];
+}
+
+static void xive_icp_set_cppr(XiveICPState *xicp, uint8_t cppr)
+{
+    if (cppr > XIVE_PRIORITY_MAX) {
+        cppr =3D 0xff;
+    }
+
+    xicp->tima_os[TM_CPPR] =3D cppr;
+}
+
+/*
+ * Thread Interrupt Management Area MMIO
+ */
+static uint64_t xive_tm_read_special(XiveICPState *icp, hwaddr offset,
+                                     unsigned size)
+{
+    uint64_t ret =3D -1;
+
+    if (offset =3D=3D TM_SPC_ACK_OS_REG && size =3D=3D 2) {
+        ret =3D xive_icp_accept(icp);
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid TIMA read @%"
+                      HWADDR_PRIx" size %d\n", offset, size);
+    }
+
+    return ret;
+}
+
+static uint64_t xive_tm_read(void *opaque, hwaddr offset, unsigned size)
+{
+    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
+    XiveICPState *icp =3D XIVE_ICP(cpu->intc);
+    uint64_t ret =3D -1;
+    int i;
+
+    if (offset >=3D TM_SPC_ACK_EBB) {
+        return xive_tm_read_special(icp, offset, size);
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
+static bool xive_tm_is_readonly(uint8_t index)
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
+static void xive_tm_write_special(XiveICPState *xicp, hwaddr offset,
+                                  uint64_t value, unsigned size)
+{
+    if (offset =3D=3D TM_SPC_SET_OS_PENDING && size =3D=3D 1) {
+        xicp->tima_os[TM_IPB] |=3D priority_to_ipb(value & 0xff);
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid TIMA write @%"
+                      HWADDR_PRIx" size %d\n", offset, size);
+    }
+
+    /* TODO: support TM_SPC_ACK_OS_EL */
+}
+
+static void xive_tm_write(void *opaque, hwaddr offset,
+                           uint64_t value, unsigned size)
+{
+    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
+    XiveICPState *icp =3D XIVE_ICP(cpu->intc);
+    int i;
+
+    if (offset >=3D TM_SPC_ACK_EBB) {
+        xive_tm_write_special(icp, offset, value, size);
+        return;
+    }
+
+    if (offset & TM_QW1_OS) {
+        switch (size) {
+        case 1:
+            if (offset =3D=3D TM_QW1_OS + TM_CPPR) {
+                xive_icp_set_cppr(icp, value & 0xff);
+            }
+            break;
+        case 4:
+        case 8:
+            if (QEMU_IS_ALIGNED(offset, size)) {
+                for (i =3D 0; i < size; i++) {
+                    if (!xive_tm_is_readonly(offset + i)) {
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
+static const MemoryRegionOps xive_tm_ops =3D {
+    .read =3D xive_tm_read,
+    .write =3D xive_tm_write,
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
 static void xive_icp_reset(ICPState *icp)
 {
     XiveICPState *xicp =3D XIVE_ICP(icp);
@@ -453,6 +627,11 @@ static const TypeInfo xive_ics_info =3D {
 #define P9_MMIO_BASE     0x006000000000000ull
 #define P9_CHIP_BASE(id) (P9_MMIO_BASE | (0x40000000000ull * (uint64_t) =
(id)))
=20
+/* Thread Interrupt Management Area MMIO */
+#define TM_BAR_DEFAULT   0x30203180000ull
+#define TM_SHIFT         16
+#define TM_BAR_SIZE      (XIVE_TM_RING_COUNT * (1 << TM_SHIFT))
+
 static uint64_t xive_esb_default_read(void *p, hwaddr offset, unsigned s=
ize)
 {
     qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " [%u]\n",
@@ -541,6 +720,14 @@ static void xive_realize(DeviceState *dev, Error **e=
rrp)
                           NULL, "xive.esb", VC_BAR_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &x->esb_iomem);
=20
+    /* TM BAR. Same address for each chip */
+    x->tm_base =3D (P9_MMIO_BASE | TM_BAR_DEFAULT);
+    x->tm_shift =3D TM_SHIFT;
+
+    memory_region_init_io(&x->tm_iomem, OBJECT(x), &xive_tm_ops, x,
+                          "xive.tm", TM_BAR_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &x->tm_iomem);
+
     qemu_register_reset(xive_reset, dev);
 }
=20
--=20
2.7.5
