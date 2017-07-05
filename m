Received: from eggs.gnu.org ([2001:4830:134:3::10]:41885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnu0-0004ZC-8j
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:15:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSntv-0003qd-Mn
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:15:48 -0400
Received: from 13.mo3.mail-out.ovh.net ([188.165.33.202]:40792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dSntv-0003pD-9b
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:15:43 -0400
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 20651FCCD6
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 19:15:42 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Jul 2017 19:13:30 +0200
Message-Id: <1499274819-15607-18-git-send-email-clg@kaod.org>
In-Reply-To: <1499274819-15607-1-git-send-email-clg@kaod.org>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 17/26] ppc/xive: add hcalls support
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

A set of Hypervisor's call are used to configure the interrupt sources
and the event/notification queues of the guest:

   H_INT_GET_SOURCE_INFO
   H_INT_SET_SOURCE_CONFIG
   H_INT_GET_SOURCE_CONFIG
   H_INT_GET_QUEUE_INFO
   H_INT_SET_QUEUE_CONFIG
   H_INT_GET_QUEUE_CONFIG
   H_INT_RESET
   H_INT_ESB

Calls that still need to be addressed :

   H_INT_SET_OS_REPORTING_LINE
   H_INT_GET_OS_REPORTING_LINE
   H_INT_SYNC

See below for the documentation on each hcall.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 default-configs/ppc64-softmmu.mak |   1 +
 hw/intc/Makefile.objs             |   1 +
 hw/intc/xive_spapr.c              | 745 ++++++++++++++++++++++++++++++++=
++++++
 include/hw/ppc/spapr.h            |  17 +-
 include/hw/ppc/xive.h             |   4 +
 5 files changed, 767 insertions(+), 1 deletion(-)
 create mode 100644 hw/intc/xive_spapr.c

diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-so=
ftmmu.mak
index 1179c07e6e9f..3888168adf95 100644
--- a/default-configs/ppc64-softmmu.mak
+++ b/default-configs/ppc64-softmmu.mak
@@ -57,6 +57,7 @@ CONFIG_XICS=3D$(CONFIG_PSERIES)
 CONFIG_XICS_SPAPR=3D$(CONFIG_PSERIES)
 CONFIG_XICS_KVM=3D$(and $(CONFIG_PSERIES),$(CONFIG_KVM))
 CONFIG_XIVE=3D$(CONFIG_PSERIES)
+CONFIG_XIVE_SPAPR=3D$(CONFIG_PSERIES)
 # For PReP
 CONFIG_SERIAL_ISA=3Dy
 CONFIG_MC146818RTC=3Dy
diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index 28b83456bfcc..31b4fae2d1a8 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -36,6 +36,7 @@ obj-$(CONFIG_XICS) +=3D xics.o
 obj-$(CONFIG_XICS_SPAPR) +=3D xics_spapr.o
 obj-$(CONFIG_XICS_KVM) +=3D xics_kvm.o
 obj-$(CONFIG_XIVE) +=3D xive.o
+obj-$(CONFIG_XIVE_SPAPR) +=3D xive_spapr.o
 obj-$(CONFIG_POWERNV) +=3D xics_pnv.o
 obj-$(CONFIG_ALLWINNER_A10_PIC) +=3D allwinner-a10-pic.o
 obj-$(CONFIG_S390_FLIC) +=3D s390_flic.o
diff --git a/hw/intc/xive_spapr.c b/hw/intc/xive_spapr.c
new file mode 100644
index 000000000000..b634d1f28f10
--- /dev/null
+++ b/hw/intc/xive_spapr.c
@@ -0,0 +1,745 @@
+/*
+ * QEMU PowerPC XIVE model for pSeries
+ *
+ * Copyright (c) 2017, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "hw/ppc/spapr.h"
+#include "hw/ppc/xive.h"
+#include "hw/ppc/fdt.h"
+#include "monitor/monitor.h"
+
+#include "xive-internal.h"
+
+static XiveICSState *xive_ics_find(sPAPRMachineState *spapr, uint32_t li=
sn)
+{
+    XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(spapr);
+    ICSState *ics =3D xic->ics_get(XICS_FABRIC(spapr), lisn);
+
+    return ICS_XIVE(ics);
+}
+
+static bool priority_is_valid(int priority)
+{
+    return priority >=3D 0 && priority < 8;
+}
+
+/*
+ * The H_INT_GET_SOURCE_INFO hcall() is used to obtain the logical
+ * real address of the MMIO page through which the Event State Buffer
+ * entry associated with the value of the "lisn" parameter is managed.
+ *
+ * Parameters:
+ * Input
+ * - "flags"
+ *       Bits 0-63 reserved
+ * - "lisn" is per "interrupts", "interrupt-map", or
+ *       "ibm,xive-lisn-ranges" properties, or as returned by the
+ *       ibm,query-interrupt-source-number RTAS call, or as returned
+ *       by the H_ALLOCATE_VAS_WINDOW hcall
+ *
+ * Output
+ * - R4: "flags"
+ *       Bits 0-59: Reserved
+ *       Bit 60: H_INT_ESB must be used for Event State Buffer
+ *               management
+ *       Bit 61: 1 =3D=3D LSI  0 =3D=3D MSI
+ *       Bit 62: the full function page supports trigger
+ *       Bit 63: Store EOI Supported
+ * - R5: Logical Real address of full function Event State Buffer
+ *       management page, -1 if ESB hcall flag is set to 1.
+ * - R6: Logical Real Address of trigger only Event State Buffer
+ *       management page or -1.
+ * - R7: Power of 2 page size for the ESB management pages returned in
+ *       R5 and R6.
+ */
+static target_ulong h_int_get_source_info(PowerPCCPU *cpu,
+                                          sPAPRMachineState *spapr,
+                                          target_ulong opcode,
+                                          target_ulong *args)
+{
+    target_ulong flags  =3D args[0];
+    target_ulong lisn   =3D args[1];
+    XiveICSState *xs;
+    uint32_t srcno;
+    uint64_t mmio_base;
+    ICSIRQState *irq;
+
+    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        return H_FUNCTION;
+    }
+
+    if (flags) {
+        return H_PARAMETER;
+    }
+
+    xs =3D xive_ics_find(spapr, lisn);
+    if (!xs) {
+        return H_P2;
+    }
+
+    srcno =3D lisn - ICS_BASE(xs)->offset;
+    mmio_base =3D (uint64_t)xs->esb_base + (1ull << xs->esb_shift) * src=
no;
+    irq =3D &ICS_BASE(xs)->irqs[srcno];
+
+    args[0] =3D 0;
+    if (irq->flags & XICS_FLAGS_IRQ_LSI) {
+        args[0] |=3D XIVE_SRC_LSI;
+    }
+    if (xs->flags & XIVE_SRC_TRIGGER) {
+        args[0] |=3D XIVE_SRC_TRIGGER;
+    }
+
+    /* never used in QEMU  */
+    if (xs->flags & XIVE_SRC_H_INT_ESB) {
+        args[1] =3D -1;
+    } else {
+        args[1] =3D mmio_base;
+        if (xs->flags & XIVE_SRC_TRIGGER) {
+            args[2] =3D -1; /* No specific trigger page */
+        } else {
+            args[2] =3D -1; /* TODO: support for specific trigger page *=
/
+        }
+    }
+
+    args[3] =3D xs->esb_shift;
+
+    return H_SUCCESS;
+}
+
+/*
+ * The H_INT_SET_SOURCE_CONFIG hcall() is used to assign a Logical
+ * Interrupt Source to a target. The Logical Interrupt Source is
+ * designated with the "lisn" parameter and the target is designated
+ * with the "target" and "priority" parameters.  Upon return from the
+ * hcall(), no additional interrupts will be directed to the old EQ.
+ * The old EQ should be investigated for interrupts that occurred
+ * prior to or during the hcall().
+ *
+ * Parameters:
+ * Input:
+ * - "flags"
+ *      Bits 0-61: Reserved
+ *      Bit 62: set the "eisn" in the EA
+ *      Bit 63: masks the interrupt source in the hardware interrupt
+ *      control structure. An interrupt masked by this mechanism will
+ *      be dropped, but it's source state bits will still be
+ *      set. There is no race-free way of unmasking and restoring the
+ *      source. Thus this should only be used in interrupts that are
+ *      also masked at the source, and only in cases where the
+ *      interrupt is not meant to be used for a large amount of time
+ *      because no valid target exists for it for example
+ * - "lisn" is per "interrupts", "interrupt-map", or
+ *      "ibm,xive-lisn-ranges" properties, or as returned by the
+ *      ibm,query-interrupt-source-number RTAS call, or as returned by
+ *      the H_ALLOCATE_VAS_WINDOW hcall
+ * - "target" is per "ibm,ppc-interrupt-server#s" or
+ *      "ibm,ppc-interrupt-gserver#s"
+ * - "priority" is a valid priority not in
+ *      "ibm,plat-res-int-priorities"
+ * - "eisn" is the guest EISN associated with the "lisn"
+ *
+ * Output:
+ * - None
+ */
+
+#define XIVE_SRC_SET_EISN (1ull << (63 - 62))
+#define XIVE_SRC_MASK     (1ull << (63 - 63))
+
+static target_ulong h_int_set_source_config(PowerPCCPU *cpu,
+                                            sPAPRMachineState *spapr,
+                                            target_ulong opcode,
+                                            target_ulong *args)
+{
+    XiveIVE *ive;
+    uint64_t new_ive;
+    target_ulong flags    =3D args[0];
+    target_ulong lisn     =3D args[1];
+    target_ulong target   =3D args[2];
+    target_ulong priority =3D args[3];
+    target_ulong eisn     =3D args[4];
+    uint32_t eq_idx;
+
+    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        return H_FUNCTION;
+    }
+
+    if (flags & ~(XIVE_SRC_SET_EISN | XIVE_SRC_MASK)) {
+        return H_PARAMETER;
+    }
+
+    ive =3D xive_get_ive(spapr->xive, lisn);
+    if (!ive || !(ive->w & IVE_VALID)) {
+        return H_P2;
+    }
+    new_ive =3D ive->w;
+
+    /* Let's handle 0xff priority as if the interrupt was masked */
+    if (priority =3D=3D 0xff || (flags & XIVE_SRC_MASK)) {
+        new_ive |=3D IVE_MASKED;
+        priority =3D 7;
+    } else {
+        new_ive =3D ive->w & ~IVE_MASKED;
+    }
+
+    if (!priority_is_valid(priority)) {
+        return H_P4;
+    }
+
+    /* First find the EQ corresponding to the target */
+    if (!xive_eq_for_target(spapr->xive, target, priority, &eq_idx)) {
+        return H_P3;
+    }
+
+    /* And update */
+    new_ive =3D SETFIELD(IVE_EQ_BLOCK, new_ive, 0ul);
+    new_ive =3D SETFIELD(IVE_EQ_INDEX, new_ive, eq_idx);
+
+    if (flags & XIVE_SRC_SET_EISN) {
+        new_ive =3D SETFIELD(IVE_EQ_DATA, new_ive, eisn);
+    }
+
+    ive->w =3D new_ive;
+
+    return H_SUCCESS;
+}
+
+/*
+ * The H_INT_GET_SOURCE_CONFIG hcall() is used to determine to which
+ * target/priority pair is assigned to the specified Logical Interrupt
+ * Source.
+ *
+ * Parameters:
+ * Input:
+ * - "flags"
+ *      Bits 0-63 Reserved
+ * - "lisn" is per "interrupts", "interrupt-map", or
+ *      "ibm,xive-lisn-ranges" properties, or as returned by the
+ *      ibm,query-interrupt-source-number RTAS call, or as
+ *      returned by the H_ALLOCATE_VAS_WINDOW hcall
+ *
+ * Output:
+ * - R4: Target to which the specified Logical Interrupt Source is
+ *       assigned
+ * - R5: Priority to which the specified Logical Interrupt Source is
+ *       assigned
+ */
+static target_ulong h_int_get_source_config(PowerPCCPU *cpu,
+                                            sPAPRMachineState *spapr,
+                                            target_ulong opcode,
+                                            target_ulong *args)
+{
+    target_ulong flags =3D args[0];
+    target_ulong lisn =3D args[1];
+    XiveIVE *ive;
+    XiveEQ *eq;
+    uint32_t eq_idx;
+
+    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        return H_FUNCTION;
+    }
+
+    if (flags) {
+        return H_PARAMETER;
+    }
+
+    ive =3D xive_get_ive(spapr->xive, lisn);
+    if (!ive || !(ive->w & IVE_VALID)) {
+        return H_P2;
+    }
+
+    eq_idx =3D GETFIELD(IVE_EQ_INDEX, ive->w);
+    eq =3D xive_get_eq(spapr->xive, eq_idx);
+    if (!eq) {
+        return H_P2;
+    }
+
+    if (ive->w & IVE_MASKED) {
+        args[1] =3D 0xff;
+    } else {
+        args[1] =3D GETFIELD(EQ_W7_F0_PRIORITY, eq->w7);
+    }
+
+    args[0] =3D GETFIELD(EQ_W6_NVT_INDEX, eq->w6);
+
+    return H_SUCCESS;
+}
+
+/*
+ * The H_INT_GET_QUEUE_INFO hcall() is used to get the logical real
+ * address of the notification management page associated with the
+ * specified target and priority.
+ *
+ * Parameters:
+ * Input:
+ * - "flags"
+ *       Bits 0-63 Reserved
+ * - "target" is per "ibm,ppc-interrupt-server#s" or
+ *       "ibm,ppc-interrupt-gserver#s"
+ * - "priority" is a valid priority not in
+ *       "ibm,plat-res-int-priorities"
+ *
+ * Output:
+ * - R4: Logical real address of notification page
+ * - R5: Power of 2 page size of the notification page
+ */
+static target_ulong h_int_get_queue_info(PowerPCCPU *cpu,
+                                         sPAPRMachineState *spapr,
+                                         target_ulong opcode,
+                                         target_ulong *args)
+{
+    target_ulong flags    =3D args[0];
+    target_ulong target   =3D args[1];
+    target_ulong priority =3D args[2];
+    uint32_t eq_idx;
+    XiveEQ *eq;
+
+    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        return H_FUNCTION;
+    }
+
+    if (flags) {
+        return H_PARAMETER;
+    }
+
+    if (!priority_is_valid(priority)) {
+        return H_P3;
+    }
+
+    if (!xive_eq_for_target(spapr->xive, target, priority, &eq_idx)) {
+        return H_P2;
+    }
+
+    eq =3D xive_get_eq(spapr->xive, eq_idx);
+    if (!eq)  {
+        return H_PARAMETER;
+    }
+
+    args[0] =3D -1; /* TODO: return ESn page */
+    if (eq->w0 & EQ_W0_ENQUEUE) {
+        args[1] =3D GETFIELD(EQ_W0_QSIZE, eq->w0) + 12;
+    } else {
+        args[1] =3D 0;
+    }
+
+    return H_SUCCESS;
+}
+
+/*
+ * The H_INT_SET_QUEUE_CONFIG hcall() is used to set or reset a EQ for
+ * a given "target" and "priority".  It is also used to set the
+ * notification config associated with the EQ.  An EQ size of 0 is
+ * used to reset the EQ config for a given target and priority. If
+ * resetting the EQ config, the END associated with the given "target"
+ * and "priority" will be changed to disable queueing.
+ *
+ * Upon return from the hcall(), no additional interrupts will be
+ * directed to the old EQ (if one was set).  The old EQ (if one was
+ * set) should be investigated for interrupts that occurred prior to
+ * or during the hcall().
+ *
+ * Parameters:
+ * Input:
+ * - "flags"
+ *      Bits 0-62: Reserved
+ *      Bit 63: Unconditional Notify (n) per the XIVE spec
+ * - "target" is per "ibm,ppc-interrupt-server#s" or
+ *       "ibm,ppc-interrupt-gserver#s"
+ * - "priority" is a valid priority not in
+ *       "ibm,plat-res-int-priorities"
+ * - "eventQueue": The logical real address of the start of the EQ
+ * - "eventQueueSize": The power of 2 EQ size per "ibm,xive-eq-sizes"
+ *
+ * Output:
+ * - None
+ */
+
+#define XIVE_EQ_ALWAYS_NOTIFY (1ull << (63 - 63))
+
+static target_ulong h_int_set_queue_config(PowerPCCPU *cpu,
+                                           sPAPRMachineState *spapr,
+                                           target_ulong opcode,
+                                           target_ulong *args)
+{
+    target_ulong flags    =3D args[0];
+    target_ulong target   =3D args[1];
+    target_ulong priority =3D args[2];
+    target_ulong qpage    =3D args[3];
+    target_ulong qsize    =3D args[4];
+    uint32_t eq_idx;
+    XiveEQ *old_eq;
+    XiveEQ eq;
+    uint32_t qdata;
+
+    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        return H_FUNCTION;
+    }
+
+    if (flags & ~XIVE_EQ_ALWAYS_NOTIFY) {
+        return H_PARAMETER;
+    }
+
+    if (!priority_is_valid(priority)) {
+        return H_P3;
+    }
+
+    if (!xive_eq_for_target(spapr->xive, target, priority, &eq_idx)) {
+        return H_P2;
+    }
+
+    old_eq =3D xive_get_eq(spapr->xive, eq_idx);
+    if (!old_eq)  {
+        return H_HARDWARE;
+    }
+
+    eq =3D *old_eq;
+
+    /* Let's validate the EQ address with a read of first EQ entry */
+    if (address_space_read(&address_space_memory, qpage, MEMTXATTRS_UNSP=
ECIFIED,
+                           (uint8_t *) &qdata, sizeof(qdata))) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to read EQ data @0x%"
+                      HWADDR_PRIx "\n", __func__, qpage);
+        return H_P4;
+    }
+
+    switch (qsize) {
+    case 12:
+    case 16:
+    case 21:
+    case 24:
+        eq.w3 =3D ((uint64_t)qpage) & 0xffffffff;
+        eq.w2 =3D (((uint64_t)qpage)) >> 32 & 0x0fffffff;
+        eq.w0 |=3D EQ_W0_ENQUEUE;
+        eq.w0 =3D SETFIELD(EQ_W0_QSIZE, eq.w0, qsize - 12);
+        break;
+    case 0:
+        eq.w2 =3D eq.w3 =3D 0;
+        eq.w0 &=3D ~EQ_W0_ENQUEUE;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid EQ size %"PRIx64"\n"=
,
+                      __func__, qsize);
+        return H_P5;
+    }
+
+    /* Ensure the priority and target are correctly set (they will not
+     * be right after allocation
+     */
+    eq.w6 =3D SETFIELD(EQ_W6_NVT_BLOCK, 0ul, 0ul) |
+        SETFIELD(EQ_W6_NVT_INDEX, 0ul, target);
+    eq.w7 =3D SETFIELD(EQ_W7_F0_PRIORITY, 0ul, priority);
+
+    /* TODO: depends on notitification page (ESn) from H_INT_GET_QUEUE_I=
NFO */
+    if (flags & XIVE_EQ_ALWAYS_NOTIFY) {
+        eq.w0 |=3D EQ_W0_UCOND_NOTIFY;
+    }
+
+    eq.w1 =3D EQ_W1_GENERATION | SETFIELD(EQ_W1_PAGE_OFF, 0ul, 0ul);
+    eq.w0 |=3D EQ_W0_VALID;
+
+    /* Update EQ */
+    *old_eq =3D eq;
+
+    return H_SUCCESS;
+}
+
+/*
+ * The H_INT_GET_QUEUE_CONFIG hcall() is used to get a EQ for a given
+ * target and priority.
+ *
+ * Parameters:
+ * Input:
+ * - "flags"
+ *      Bits 0-63: Reserved
+ * - "target" is per "ibm,ppc-interrupt-server#s" or
+ *       "ibm,ppc-interrupt-gserver#s"
+ * - "priority" is a valid priority not in
+ *       "ibm,plat-res-int-priorities"
+ *
+ * Output:
+ * - R4: "flags":
+ *       Bits 0-62: Reserved
+ *       Bit 63: The value of Unconditional Notify (n) per the XIVE spec=
 *
+ * - R5: The logical real address of the start of the EQ
+ * - R6: The power of 2 EQ size per "ibm,xive-eq-sizes"
+ */
+static target_ulong h_int_get_queue_config(PowerPCCPU *cpu,
+                                           sPAPRMachineState *spapr,
+                                           target_ulong opcode,
+                                           target_ulong *args)
+{
+    target_ulong flags    =3D args[0];
+    target_ulong target   =3D args[1];
+    target_ulong priority =3D args[2];
+    uint32_t eq_idx;
+    XiveEQ *eq;
+
+    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        return H_FUNCTION;
+    }
+
+    if (flags) {
+        return H_PARAMETER;
+    }
+
+    if (!priority_is_valid(priority)) {
+        return H_P3;
+    }
+
+    if (!xive_eq_for_target(spapr->xive, target, priority, &eq_idx)) {
+        return H_P2;
+    }
+
+    eq =3D xive_get_eq(spapr->xive, eq_idx);
+    if (!eq)  {
+        return H_HARDWARE;
+    }
+
+    if (eq->w0 & EQ_W0_UCOND_NOTIFY) {
+        args[0] =3D XIVE_EQ_ALWAYS_NOTIFY;
+    } else {
+        args[0] =3D 0;
+    }
+
+    if (eq->w0 & EQ_W0_ENQUEUE) {
+        args[1] =3D
+            (((uint64_t)(eq->w2 & 0x0fffffff)) << 32) | eq->w3;
+        args[2] =3D GETFIELD(EQ_W0_QSIZE, eq->w0) + 12;
+    } else {
+        args[1] =3D 0;
+        args[2] =3D 0;
+    }
+
+    return H_SUCCESS;
+}
+
+/*
+ * The H_INT_SET_OS_REPORTING_LINE hcall() is used to set the
+ * reporting cache line pair for the input "target".  The reporting
+ * cache lines will contain the OS interrupt context when the OS
+ * issues a CI store byte to @TIMA+0xC10 to acknowledge the OS
+ * interrupt. The reporting cache lines can be reset by inputting -1
+ * in "reportingLine".  Issuing the CI store byte without reporting
+ * cache lines registered will result in the data not being accessible
+ * to the OS.
+ *
+ * Parameters:
+ * Input:
+ * - "flags"
+ *      Bits 0-63: Reserved
+ * - "target" is per "ibm,ppc-interrupt-server#s" or
+ *       "ibm,ppc-interrupt-gserver#s"
+ * - "reportingLine": The logical real address of the reporting cache
+ *    line pair
+ *
+ * Output:
+ * - None
+ */
+static target_ulong h_int_set_os_reporting_line(PowerPCCPU *cpu,
+                                                sPAPRMachineState *spapr=
,
+                                                target_ulong opcode,
+                                                target_ulong *args)
+{
+    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        return H_FUNCTION;
+    }
+
+    /* TODO: H_INT_SET_OS_REPORTING_LINE */
+    return H_FUNCTION;
+}
+
+/*
+ * The H_INT_GET_OS_REPORTING_LINE hcall() is used to get the logical
+ * real address of the reporting cache line pair set for the input
+ * "target".  If no reporting cache line pair has been set, -1 is
+ * returned.
+ *
+ * Parameters:
+ * Input:
+ * - "flags"
+ *      Bits 0-63: Reserved
+ * - "target" is per "ibm,ppc-interrupt-server#s" or
+ *       "ibm,ppc-interrupt-gserver#s"
+ * - "reportingLine": The logical real address of the reporting cache
+ *   line pair
+ *
+ * Output:
+ * - R4: The logical real address of the reporting line if set, else -1
+ */
+static target_ulong h_int_get_os_reporting_line(PowerPCCPU *cpu,
+                                                sPAPRMachineState *spapr=
,
+                                                target_ulong opcode,
+                                                target_ulong *args)
+{
+    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        return H_FUNCTION;
+    }
+
+    /* TODO: H_INT_GET_OS_REPORTING_LINE */
+    return H_FUNCTION;
+}
+
+/*
+ * The H_INT_ESB hcall() is used to issue a load or store to the ESB
+ * page for the input "lisn".  This hcall is only supported for LISNs
+ * that have the ESB hcall flag set to 1 when returned from hcall()
+ * H_INT_GET_SOURCE_INFO.
+ *
+ * Parameters:
+ * Input:
+ * - "flags"
+ *      Bits 0-62: Reserved
+ *      bit 63: Store: Store=3D1, store operation, else load operation
+ * - "lisn" is per "interrupts", "interrupt-map", or
+ *          "ibm,xive-lisn-ranges" properties, or as returned by the
+ *          ibm,query-interrupt-source-number RTAS call, or as
+ *          returned by the H_ALLOCATE_VAS_WINDOW hcall
+ * - "esbOffset" is the offset into the ESB page for the load or store o=
peration
+ * - "storeData" is the data to write for a store operation
+ *
+ * Output:
+ * - R4: R4: The value of the load if load operation, else -1
+ */
+
+#define XIVE_ESB_STORE (1ull << (63 - 63))
+
+static target_ulong h_int_esb(PowerPCCPU *cpu,
+                              sPAPRMachineState *spapr,
+                              target_ulong opcode,
+                              target_ulong *args)
+{
+    target_ulong flags   =3D args[0];
+    target_ulong lisn    =3D args[1];
+    target_ulong offset  =3D args[2];
+    target_ulong data    =3D args[3];
+    XiveICSState *xs;
+    uint32_t srcno;
+    uint64_t esb_base;
+
+    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        return H_FUNCTION;
+    }
+
+    if (flags & ~XIVE_ESB_STORE) {
+        return H_PARAMETER;
+    }
+
+    xs =3D xive_ics_find(spapr, lisn);
+    if (!xs) {
+        return H_P2;
+    }
+
+    if (offset > (1ull << xs->esb_shift)) {
+        return H_P3;
+    }
+
+    srcno =3D lisn - ICS_BASE(xs)->offset;
+    esb_base =3D (uint64_t)xs->esb_base + (1ull << xs->esb_shift) * srcn=
o;
+    esb_base +=3D offset;
+
+    if (dma_memory_rw(&address_space_memory, esb_base, &data, 8,
+                      (flags & XIVE_ESB_STORE))) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to rw data @0x%"
+                      HWADDR_PRIx "\n", __func__, esb_base);
+        return H_HARDWARE;
+    }
+    args[0] =3D (flags & XIVE_ESB_STORE) ? -1 : data;
+    return H_SUCCESS;
+}
+
+/*
+ * The H_INT_SYNC hcall() is used to issue syncs.  Is this IPI sync
+ * and HW sync?  Need the OS teams to let us know what syncs need to
+ * be provided.
+ *
+ * Parameters:
+ * Input:
+ * - "flags"
+ *      Bits 0-63: Reserved
+ *
+ * Output:
+ * - None
+ */
+static target_ulong h_int_sync(PowerPCCPU *cpu,
+                               sPAPRMachineState *spapr,
+                               target_ulong opcode,
+                               target_ulong *args)
+{
+    target_ulong flags   =3D args[0];
+
+    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        return H_FUNCTION;
+    }
+
+    if (flags) {
+        return H_PARAMETER;
+    }
+
+    /* TODO: H_INT_SYNC, I have no idea what needs to be done */
+    return H_FUNCTION;
+}
+
+/*
+ * The H_INT_RESET hcall() is used to reset all of the partition's
+ * interrupt exploitation structures to their initial state.  This
+ * means losing all previously set interrupt state set via
+ * H_INT_SET_SOURCE_CONFIG and H_INT_SET_QUEUE_CONFIG.
+ *
+ * Parameters:
+ * Input:
+ * - "flags"
+ *      Bits 0-63: Reserved
+ *
+ * Output:
+ * - None
+ */
+static target_ulong h_int_reset(PowerPCCPU *cpu,
+                                sPAPRMachineState *spapr,
+                                target_ulong opcode,
+                                target_ulong *args)
+{
+    target_ulong flags   =3D args[0];
+
+    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        return H_FUNCTION;
+    }
+
+    if (flags) {
+        return H_PARAMETER;
+    }
+
+    xive_reset(spapr->xive);
+    return H_SUCCESS;
+}
+
+void xive_spapr_init(sPAPRMachineState *spapr)
+{
+    spapr_register_hypercall(H_INT_GET_SOURCE_INFO, h_int_get_source_inf=
o);
+    spapr_register_hypercall(H_INT_SET_SOURCE_CONFIG, h_int_set_source_c=
onfig);
+    spapr_register_hypercall(H_INT_GET_SOURCE_CONFIG, h_int_get_source_c=
onfig);
+    spapr_register_hypercall(H_INT_GET_QUEUE_INFO, h_int_get_queue_info)=
;
+    spapr_register_hypercall(H_INT_SET_QUEUE_CONFIG, h_int_set_queue_con=
fig);
+    spapr_register_hypercall(H_INT_GET_QUEUE_CONFIG, h_int_get_queue_con=
fig);
+    spapr_register_hypercall(H_INT_SET_OS_REPORTING_LINE,
+                             h_int_set_os_reporting_line);
+    spapr_register_hypercall(H_INT_GET_OS_REPORTING_LINE,
+                             h_int_get_os_reporting_line);
+    spapr_register_hypercall(H_INT_ESB, h_int_esb);
+    spapr_register_hypercall(H_INT_SYNC, h_int_sync);
+    spapr_register_hypercall(H_INT_RESET, h_int_reset);
+}
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index a66bbac35242..dd69c084baa6 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -13,6 +13,7 @@ struct sPAPRPHBState;
 struct sPAPRNVRAM;
 typedef struct sPAPREventLogEntry sPAPREventLogEntry;
 typedef struct sPAPREventSource sPAPREventSource;
+typedef struct XIVE XIVE;
=20
 #define HPTE64_V_HPTE_DIRTY     0x0000000000000040ULL
 #define SPAPR_ENTRY_POINT       0x100
@@ -115,6 +116,7 @@ struct sPAPRMachineState {
     MemoryHotplugState hotplug_memory;
=20
     const char *icp_type;
+    XIVE    *xive;
 };
=20
 #define H_SUCCESS         0
@@ -371,7 +373,20 @@ struct sPAPRMachineState {
 #define H_INVALIDATE_PID        0x378
 #define H_REGISTER_PROC_TBL     0x37C
 #define H_SIGNAL_SYS_RESET      0x380
-#define MAX_HCALL_OPCODE        H_SIGNAL_SYS_RESET
+
+#define H_INT_GET_SOURCE_INFO   0x3A8
+#define H_INT_SET_SOURCE_CONFIG 0x3AC
+#define H_INT_GET_SOURCE_CONFIG 0x3B0
+#define H_INT_GET_QUEUE_INFO    0x3B4
+#define H_INT_SET_QUEUE_CONFIG  0x3B8
+#define H_INT_GET_QUEUE_CONFIG  0x3BC
+#define H_INT_SET_OS_REPORTING_LINE 0x3C0
+#define H_INT_GET_OS_REPORTING_LINE 0x3C4
+#define H_INT_ESB               0x3C8
+#define H_INT_SYNC              0x3CC
+#define H_INT_RESET             0x3D0
+
+#define MAX_HCALL_OPCODE        H_INT_RESET
=20
 /* The hcalls above are standardized in PAPR and implemented by pHyp
  * as well.
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index f87df8107dd9..af48d62cc776 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -63,4 +63,8 @@ struct XiveICPState {
     uint8_t *tima_os;
 };
=20
+typedef struct sPAPRMachineState sPAPRMachineState;
+
+void xive_spapr_init(sPAPRMachineState *spapr);
+
 #endif /* PPC_XIVE_H */
--=20
2.7.5
