Received: from eggs.gnu.org ([2001:4830:134:3::10]:39166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxCe-0002hk-B1
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:52:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxCZ-00049V-9Q
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:51:56 -0400
Received: from 6.mo6.mail-out.ovh.net ([87.98.177.69]:43585)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQxCY-00048i-LF
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:51:51 -0400
Received: from player169.ha.ovh.net (unknown [10.109.105.97])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 27678162444
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 17:51:49 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Jun 2018 17:49:52 +0200
Message-Id: <20180607155003.1580-18-clg@kaod.org>
In-Reply-To: <20180607155003.1580-1-clg@kaod.org>
References: <20180607155003.1580-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 17/28] spapr: add hcalls support for the
 XIVE exploitation interrupt mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The different XIVE virtualization engines (sources and event queues)
are configured with a set of Hypervisor calls :

 - H_INT_GET_SOURCE_INFO

   used to obtain the address of the MMIO page of the Event State
   Buffer (PQ bits) entry associated with the source.

 - H_INT_SET_SOURCE_CONFIG

   assigns a source to a "target".

 - H_INT_GET_SOURCE_CONFIG

   determines which "target" and "priority" is assigned to a source

 - H_INT_GET_QUEUE_INFO

   returns the address of the notification management page associated
   with the specified "target" and "priority".

 - H_INT_SET_QUEUE_CONFIG

   sets or resets the event queue for a given "target" and "priority".
   It is also used to set the notification configuration associated
   with the queue, only unconditional notification is supported for
   the moment. Reset is performed with a queue size of 0 and queueing
   is disabled in that case.

 - H_INT_GET_QUEUE_CONFIG

   returns the queue settings for a given "target" and "priority".

 - H_INT_RESET

   resets all of the guest's internal interrupt structures to their
   initial state, losing all configuration set via the hcalls
   H_INT_SET_SOURCE_CONFIG and H_INT_SET_QUEUE_CONFIG.

 - H_INT_SYNC

   issue a synchronisation on a source to make sure all notifications
   have reached their queue.

Calls that still need to be addressed :

   H_INT_SET_OS_REPORTING_LINE
   H_INT_GET_OS_REPORTING_LINE

See the code for more documentation on each hcall.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr.h      |  15 +-
 include/hw/ppc/spapr_xive.h |   5 +
 hw/intc/spapr_xive_hcall.c  | 887 ++++++++++++++++++++++++++++++++++++++=
++++++
 hw/ppc/spapr_irq.c          |   2 +
 hw/intc/Makefile.objs       |   2 +-
 5 files changed, 909 insertions(+), 2 deletions(-)
 create mode 100644 hw/intc/spapr_xive_hcall.c

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index fd0e32c4b32c..3c7bae874f91 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -444,7 +444,20 @@ struct sPAPRMachineState {
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
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index be1163a8f272..5dedb9e5c7c0 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -57,5 +57,10 @@ int spapr_xive_target_to_eq(XiveRouter *xrtr, uint32_t=
 target, uint8_t prio,
                             uint8_t *out_eq_blk, uint32_t *out_eq_idx);
 int spapr_xive_cpu_to_eq(XiveRouter *xrtr, PowerPCCPU *cpu, uint8_t prio=
,
                          uint8_t *out_eq_blk, uint32_t *out_eq_idx);
+bool spapr_xive_eq_is_valid(uint8_t priority);
+
+typedef struct sPAPRMachineState sPAPRMachineState;
+
+void spapr_xive_hcall_init(sPAPRMachineState *spapr);
=20
 #endif /* PPC_SPAPR_XIVE_H */
diff --git a/hw/intc/spapr_xive_hcall.c b/hw/intc/spapr_xive_hcall.c
new file mode 100644
index 000000000000..376ff7ba00f9
--- /dev/null
+++ b/hw/intc/spapr_xive_hcall.c
@@ -0,0 +1,887 @@
+/*
+ * QEMU PowerPC sPAPR XIVE interrupt controller model
+ *
+ * Copyright (c) 2017-2018, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "hw/ppc/fdt.h"
+#include "hw/ppc/spapr.h"
+#include "hw/ppc/spapr_xive.h"
+#include "hw/ppc/xive_regs.h"
+#include "monitor/monitor.h"
+
+/*
+ * OPAL uses the priority 7 EQ to automatically escalate interrupts
+ * for all other queues (DD2.X POWER9). So only priorities [0..6] are
+ * available for the guest.
+ */
+bool spapr_xive_eq_is_valid(uint8_t priority)
+{
+    switch (priority) {
+    case 0 ... 6:
+        return true;
+    case 7: /* OPAL escalation queue */
+    default:
+        return false;
+    }
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
+
+#define SPAPR_XIVE_SRC_H_INT_ESB     PPC_BIT(60) /* ESB manage with H_IN=
T_ESB */
+#define SPAPR_XIVE_SRC_LSI           PPC_BIT(61) /* Virtual LSI type */
+#define SPAPR_XIVE_SRC_TRIGGER       PPC_BIT(62) /* Trigger and manageme=
nt
+                                                    on same page */
+#define SPAPR_XIVE_SRC_STORE_EOI     PPC_BIT(63) /* Store EOI support */
+
+static target_ulong h_int_get_source_info(PowerPCCPU *cpu,
+                                          sPAPRMachineState *spapr,
+                                          target_ulong opcode,
+                                          target_ulong *args)
+{
+    sPAPRXive *xive =3D spapr->xive;
+    XiveIVE ive;
+    target_ulong flags  =3D args[0];
+    target_ulong lisn   =3D args[1];
+    XiveSource *xsrc =3D &xive->source;
+
+    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        return H_FUNCTION;
+    }
+
+    if (flags) {
+        return H_PARAMETER;
+    }
+
+    if (xive_router_get_ive(XIVE_ROUTER(spapr->xive), lisn, &ive)) {
+        return H_P2;
+    }
+
+    if (!(ive.w & IVE_VALID)) {
+        return H_P2;
+    }
+
+    /* All sources are emulated under the main XIVE object and share
+     * the same characteristics.
+     */
+    args[0] =3D 0;
+    if (!xive_source_esb_has_2page(xsrc)) {
+        args[0] |=3D SPAPR_XIVE_SRC_TRIGGER;
+    }
+    if (xsrc->esb_flags & XIVE_SRC_STORE_EOI) {
+        args[0] |=3D SPAPR_XIVE_SRC_STORE_EOI;
+    }
+    if (xsrc->esb_flags & XIVE_SRC_H_INT_ESB) {
+        args[0] |=3D SPAPR_XIVE_SRC_H_INT_ESB;
+    }
+
+    if (xive_source_irq_is_lsi(xsrc, lisn)) {
+        args[0] |=3D SPAPR_XIVE_SRC_LSI;
+    }
+
+    if (!(xsrc->esb_flags & XIVE_SRC_H_INT_ESB)) {
+        args[1] =3D xive->vc_base +
+            xive_source_esb_mgmt(xsrc, lisn);
+    } else {
+        args[1] =3D -1;
+    }
+
+    if (xive_source_esb_has_2page(xsrc)) {
+        args[2] =3D xive->vc_base +
+            xive_source_esb_page(xsrc, lisn);
+    } else {
+        args[2] =3D -1;
+    }
+
+    args[3] =3D xsrc->esb_shift;
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
+ *
+ * TODO: The old EQ should be investigated for interrupts that
+ * occurred prior to or during the hcall().
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
+#define SPAPR_XIVE_SRC_SET_EISN PPC_BIT(62)
+#define SPAPR_XIVE_SRC_MASK     PPC_BIT(63)
+
+static target_ulong h_int_set_source_config(PowerPCCPU *cpu,
+                                            sPAPRMachineState *spapr,
+                                            target_ulong opcode,
+                                            target_ulong *args)
+{
+    XiveRouter *xrtr      =3D XIVE_ROUTER(spapr->xive);
+    XiveIVE ive, new_ive;
+    target_ulong flags    =3D args[0];
+    target_ulong lisn     =3D args[1];
+    target_ulong target   =3D args[2];
+    target_ulong priority =3D args[3];
+    target_ulong eisn     =3D args[4];
+    uint8_t eq_blk;
+    uint32_t eq_idx;
+
+    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        return H_FUNCTION;
+    }
+
+    if (flags & ~(SPAPR_XIVE_SRC_SET_EISN | SPAPR_XIVE_SRC_MASK)) {
+        return H_PARAMETER;
+    }
+
+    if (xive_router_get_ive(XIVE_ROUTER(spapr->xive), lisn, &ive)) {
+        return H_P2;
+    }
+
+    if (!(ive.w & IVE_VALID)) {
+        return H_P2;
+    }
+
+    /* priority 0xff is used to reset the IVE */
+    if (priority =3D=3D 0xff) {
+        new_ive.w =3D IVE_VALID | IVE_MASKED;
+        goto out;
+    }
+
+    if (flags & SPAPR_XIVE_SRC_MASK) {
+        new_ive.w =3D ive.w | IVE_MASKED;
+    } else {
+        new_ive.w =3D ive.w & ~IVE_MASKED;
+    }
+
+    if (!spapr_xive_eq_is_valid(priority)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid priority %ld reque=
sted\n",
+                      priority);
+        return H_P4;
+    }
+
+    /* Validate that "target" is part of the list of threads allocated
+     * to the partition. For that, find the EQ corresponding to the
+     * target.
+     */
+    if (spapr_xive_target_to_eq(xrtr, target, priority, &eq_blk, &eq_idx=
)) {
+        return H_P3;
+    }
+
+    new_ive.w =3D SETFIELD(IVE_EQ_BLOCK, new_ive.w, eq_blk);
+    new_ive.w =3D SETFIELD(IVE_EQ_INDEX, new_ive.w, eq_idx);
+
+    if (flags & SPAPR_XIVE_SRC_SET_EISN) {
+        new_ive.w =3D SETFIELD(IVE_EQ_DATA, new_ive.w, eisn);
+    }
+
+out:
+    if (xive_router_set_ive(XIVE_ROUTER(spapr->xive), lisn, &new_ive)) {
+        return H_HARDWARE;
+    }
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
+ * - R6: EISN for the specified Logical Interrupt Source (this will be
+ *       equivalent to the LISN if not changed by H_INT_SET_SOURCE_CONFI=
G)
+ */
+static target_ulong h_int_get_source_config(PowerPCCPU *cpu,
+                                            sPAPRMachineState *spapr,
+                                            target_ulong opcode,
+                                            target_ulong *args)
+{
+    target_ulong flags =3D args[0];
+    target_ulong lisn =3D args[1];
+    XiveIVE ive;
+    XiveEQ eq;
+    uint8_t eq_blk, vp_blk;
+    uint32_t eq_idx, vp_idx;
+
+    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        return H_FUNCTION;
+    }
+
+    if (flags) {
+        return H_PARAMETER;
+    }
+
+    if (xive_router_get_ive(XIVE_ROUTER(spapr->xive), lisn, &ive)) {
+        return H_P2;
+    }
+
+    if (!(ive.w & IVE_VALID)) {
+        return H_P2;
+    }
+
+    eq_blk =3D GETFIELD(IVE_EQ_BLOCK, ive.w);
+    eq_idx =3D GETFIELD(IVE_EQ_INDEX, ive.w);
+    if (xive_router_get_eq(XIVE_ROUTER(spapr->xive), eq_blk, eq_idx, &eq=
)) {
+        /* Not sure what to return here */
+        return H_HARDWARE;
+    }
+
+    vp_blk =3D GETFIELD(EQ_W6_NVT_BLOCK, eq.w6);
+    vp_idx =3D GETFIELD(EQ_W6_NVT_INDEX, eq.w6);
+    args[0] =3D spapr_xive_vp_to_target(spapr->xive, vp_blk, vp_idx);
+
+    if (ive.w & IVE_MASKED) {
+        args[1] =3D 0xff;
+    } else {
+        args[1] =3D GETFIELD(EQ_W7_F0_PRIORITY, eq.w7);
+    }
+
+    args[2] =3D GETFIELD(IVE_EQ_DATA, ive.w);
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
+    sPAPRXive *xive       =3D spapr->xive;
+    XiveEQSource *eq_xsrc =3D &xive->eq_source;
+    XiveRouter *xrtr      =3D XIVE_ROUTER(xive);
+    target_ulong flags    =3D args[0];
+    target_ulong target   =3D args[1];
+    target_ulong priority =3D args[2];
+    XiveEQ eq;
+    uint8_t eq_blk;
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
+    /*
+     * H_STATE should be returned if a H_INT_RESET is in progress.
+     * This is not needed when running the emulation under QEMU
+     */
+
+    if (!spapr_xive_eq_is_valid(priority)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid priority %ld reque=
sted\n",
+                      priority);
+        return H_P3;
+    }
+
+    /* Validate that "target" is part of the list of threads allocated
+     * to the partition. For that, find the EQ corresponding to the
+     * target.
+     */
+    if (spapr_xive_target_to_eq(xrtr, target, priority, &eq_blk, &eq_idx=
)) {
+        return H_P2;
+    }
+
+    if (xive_router_get_eq(xrtr, eq_blk, eq_idx, &eq)) {
+        return H_HARDWARE;
+    }
+
+    args[0] =3D xive->eq_base + (1ull << (eq_xsrc->esb_shift + 1)) * eq_=
idx;
+    if (eq.w0 & EQ_W0_ENQUEUE) {
+        args[1] =3D GETFIELD(EQ_W0_QSIZE, eq.w0) + 12;
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
+ * directed to the old EQ (if one was set). The old EQ (if one was
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
+#define SPAPR_XIVE_EQ_ALWAYS_NOTIFY PPC_BIT(63)
+
+static target_ulong h_int_set_queue_config(PowerPCCPU *cpu,
+                                           sPAPRMachineState *spapr,
+                                           target_ulong opcode,
+                                           target_ulong *args)
+{
+    XiveRouter *xrtr      =3D XIVE_ROUTER(spapr->xive);
+    target_ulong flags    =3D args[0];
+    target_ulong target   =3D args[1];
+    target_ulong priority =3D args[2];
+    target_ulong qpage    =3D args[3];
+    target_ulong qsize    =3D args[4];
+    XiveEQ eq;
+    uint8_t eq_blk, vp_blk;
+    uint32_t eq_idx, vp_idx;
+    uint32_t qdata;
+
+    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        return H_FUNCTION;
+    }
+
+    if (flags & ~SPAPR_XIVE_EQ_ALWAYS_NOTIFY) {
+        return H_PARAMETER;
+    }
+
+    /*
+     * H_STATE should be returned if a H_INT_RESET is in progress.
+     * This is not needed when running the emulation under QEMU
+     */
+
+    if (!spapr_xive_eq_is_valid(priority)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid priority %ld reque=
sted\n",
+                      priority);
+        return H_P3;
+    }
+
+    /* Validate that "target" is part of the list of threads allocated
+     * to the partition. For that, find the EQ corresponding to the
+     * target.
+     */
+
+    if (spapr_xive_target_to_eq(xrtr, target, priority, &eq_blk, &eq_idx=
)) {
+        return H_P2;
+    }
+
+    if (xive_router_get_eq(xrtr, eq_blk, eq_idx, &eq)) {
+        return H_HARDWARE;
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
+        /* reset queue and disable queueing */
+        xive_eq_reset(&eq);
+        goto out;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid EQ size %"PRIx64"\=
n",
+                      qsize);
+        return H_P5;
+    }
+
+    if (qsize) {
+        /*
+         * Let's validate the EQ address with a read of the first EQ
+         * entry. We could also check that the full queue has been
+         * zeroed by the OS.
+         */
+        if (address_space_read(&address_space_memory, qpage,
+                               MEMTXATTRS_UNSPECIFIED,
+                               (uint8_t *) &qdata, sizeof(qdata))) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: failed to read EQ data=
 @0x%"
+                          HWADDR_PRIx "\n", qpage);
+            return H_P4;
+        }
+    }
+
+    if (spapr_xive_target_to_vp(xrtr, target, &vp_blk, &vp_idx)) {
+        return H_HARDWARE;
+    }
+
+    /* Ensure the priority and target are correctly set (they will not
+     * be right after allocation)
+     */
+    eq.w6 =3D SETFIELD(EQ_W6_NVT_BLOCK, 0ul, vp_blk) |
+        SETFIELD(EQ_W6_NVT_INDEX, 0ul, vp_idx);
+    eq.w7 =3D SETFIELD(EQ_W7_F0_PRIORITY, 0ul, priority);
+
+    if (flags & SPAPR_XIVE_EQ_ALWAYS_NOTIFY) {
+        eq.w0 |=3D EQ_W0_UCOND_NOTIFY;
+    } else {
+        eq.w0 &=3D ~EQ_W0_UCOND_NOTIFY;
+    }
+
+    /* The generation bit for the EQ starts at 1 and The EQ page
+     * offset counter starts at 0.
+     */
+    eq.w1 =3D EQ_W1_GENERATION | SETFIELD(EQ_W1_PAGE_OFF, 0ul, 0ul);
+    eq.w0 |=3D EQ_W0_VALID;
+
+    /* TODO: issue syncs required to ensure all in-flight interrupts
+     * are complete on the old EQ */
+out:
+    /* Update EQ */
+    if (xive_router_set_eq(xrtr, eq_blk, eq_idx, &eq)) {
+        return H_HARDWARE;
+    }
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
+ *      Bits 0-62: Reserved
+ *      Bit 63: Debug: Return debug data
+ * - "target" is per "ibm,ppc-interrupt-server#s" or
+ *       "ibm,ppc-interrupt-gserver#s"
+ * - "priority" is a valid priority not in
+ *       "ibm,plat-res-int-priorities"
+ *
+ * Output:
+ * - R4: "flags":
+ *       Bits 0-61: Reserved
+ *       Bit 62: The value of Event Queue Generation Number (g) per
+ *              the XIVE spec if "Debug" =3D 1
+ *       Bit 63: The value of Unconditional Notify (n) per the XIVE spec
+ * - R5: The logical real address of the start of the EQ
+ * - R6: The power of 2 EQ size per "ibm,xive-eq-sizes"
+ * - R7: The value of Event Queue Offset Counter per XIVE spec
+ *       if "Debug" =3D 1, else 0
+ *
+ */
+
+#define SPAPR_XIVE_EQ_DEBUG     PPC_BIT(63)
+
+static target_ulong h_int_get_queue_config(PowerPCCPU *cpu,
+                                           sPAPRMachineState *spapr,
+                                           target_ulong opcode,
+                                           target_ulong *args)
+{
+    XiveRouter *xrtr      =3D XIVE_ROUTER(spapr->xive);
+    target_ulong flags    =3D args[0];
+    target_ulong target   =3D args[1];
+    target_ulong priority =3D args[2];
+    XiveEQ eq;
+    uint8_t eq_blk;
+    uint32_t eq_idx;
+
+    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        return H_FUNCTION;
+    }
+
+    if (flags & ~SPAPR_XIVE_EQ_DEBUG) {
+        return H_PARAMETER;
+    }
+
+    /*
+     * H_STATE should be returned if a H_INT_RESET is in progress.
+     * This is not needed when running the emulation under QEMU
+     */
+
+    if (!spapr_xive_eq_is_valid(priority)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid priority %ld reque=
sted\n",
+                      priority);
+        return H_P3;
+    }
+
+    /* Validate that "target" is part of the list of threads allocated
+     * to the partition. For that, find the EQ corresponding to the
+     * target.
+     */
+    if (spapr_xive_target_to_eq(xrtr, target, priority, &eq_blk, &eq_idx=
)) {
+        return H_P2;
+    }
+
+    if (xive_router_get_eq(xrtr, eq_blk, eq_idx, &eq)) {
+        return H_HARDWARE;
+    }
+
+    args[0] =3D 0;
+    if (eq.w0 & EQ_W0_UCOND_NOTIFY) {
+        args[0] |=3D SPAPR_XIVE_EQ_ALWAYS_NOTIFY;
+    }
+
+    if (eq.w0 & EQ_W0_ENQUEUE) {
+        args[1] =3D
+            (((uint64_t)(eq.w2 & 0x0fffffff)) << 32) | eq.w3;
+        args[2] =3D GETFIELD(EQ_W0_QSIZE, eq.w0) + 12;
+    } else {
+        args[1] =3D 0;
+        args[2] =3D 0;
+    }
+
+    /* TODO: do we need any locking on the EQ ? */
+    if (flags & SPAPR_XIVE_EQ_DEBUG) {
+        /* Load the event queue generation number into the return flags =
*/
+        args[0] |=3D (uint64_t)GETFIELD(EQ_W1_GENERATION, eq.w1) << 62;
+
+        /* Load R7 with the event queue offset counter */
+        args[3] =3D GETFIELD(EQ_W1_PAGE_OFF, eq.w1);
+    } else {
+        args[3] =3D 0;
+    }
+
+    return H_SUCCESS;
+}
+
+/*
+ * The H_INT_SET_OS_REPORTING_LINE hcall() is used to set the
+ * reporting cache line pair for the calling thread.  The reporting
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
+    /*
+     * H_STATE should be returned if a H_INT_RESET is in progress.
+     * This is not needed when running the emulation under QEMU
+     */
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
+    /*
+     * H_STATE should be returned if a H_INT_RESET is in progress.
+     * This is not needed when running the emulation under QEMU
+     */
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
+ *      "ibm,xive-lisn-ranges" properties, or as returned by the
+ *      ibm,query-interrupt-source-number RTAS call, or as
+ *      returned by the H_ALLOCATE_VAS_WINDOW hcall
+ * - "esbOffset" is the offset into the ESB page for the load or store o=
peration
+ * - "storeData" is the data to write for a store operation
+ *
+ * Output:
+ * - R4: R4: The value of the load if load operation, else -1
+ */
+
+#define SPAPR_XIVE_ESB_STORE PPC_BIT(63)
+
+static target_ulong h_int_esb(PowerPCCPU *cpu,
+                              sPAPRMachineState *spapr,
+                              target_ulong opcode,
+                              target_ulong *args)
+{
+    sPAPRXive *xive =3D spapr->xive;
+    XiveIVE ive;
+    target_ulong flags   =3D args[0];
+    target_ulong lisn    =3D args[1];
+    target_ulong offset  =3D args[2];
+    target_ulong data    =3D args[3];
+    hwaddr mmio_addr;
+    XiveSource *xsrc =3D &xive->source;
+
+    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        return H_FUNCTION;
+    }
+
+    if (flags & ~SPAPR_XIVE_ESB_STORE) {
+        return H_PARAMETER;
+    }
+
+    if (xive_router_get_ive(XIVE_ROUTER(spapr->xive), lisn, &ive)) {
+        return H_P2;
+    }
+
+    if (!(ive.w & IVE_VALID)) {
+        return H_P2;
+    }
+
+    if (offset > (1ull << xsrc->esb_shift)) {
+        return H_P3;
+    }
+
+    mmio_addr =3D xive->vc_base + xive_source_esb_page(xsrc, lisn) + off=
set;
+
+    if (dma_memory_rw(&address_space_memory, mmio_addr, &data, 8,
+                      (flags & SPAPR_XIVE_ESB_STORE))) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: failed to access ESB @0x%"
+                      HWADDR_PRIx "\n", mmio_addr);
+        return H_HARDWARE;
+    }
+    args[0] =3D (flags & SPAPR_XIVE_ESB_STORE) ? -1 : data;
+    return H_SUCCESS;
+}
+
+/*
+ * The H_INT_SYNC hcall() is used to issue hardware syncs that will
+ * ensure any in flight events for the input lisn are in the event
+ * queue.
+ *
+ * Parameters:
+ * Input:
+ * - "flags"
+ *      Bits 0-63: Reserved
+ * - "lisn" is per "interrupts", "interrupt-map", or
+ *      "ibm,xive-lisn-ranges" properties, or as returned by the
+ *      ibm,query-interrupt-source-number RTAS call, or as
+ *      returned by the H_ALLOCATE_VAS_WINDOW hcall
+ *
+ * Output:
+ * - None
+ */
+static target_ulong h_int_sync(PowerPCCPU *cpu,
+                               sPAPRMachineState *spapr,
+                               target_ulong opcode,
+                               target_ulong *args)
+{
+    XiveIVE ive;
+    target_ulong flags   =3D args[0];
+    target_ulong lisn    =3D args[1];
+
+    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        return H_FUNCTION;
+    }
+
+    if (flags) {
+        return H_PARAMETER;
+    }
+
+    if (xive_router_get_ive(XIVE_ROUTER(spapr->xive), lisn, &ive)) {
+        return H_P2;
+    }
+
+    if (!(ive.w & IVE_VALID)) {
+        return H_P2;
+    }
+
+    /*
+     * H_STATE should be returned if a H_INT_RESET is in progress.
+     * This is not needed when running the emulation under QEMU
+     */
+
+    /* This is not real hardware. Nothing to be done */
+    return H_SUCCESS;
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
+    device_reset(DEVICE(spapr->xive));
+    return H_SUCCESS;
+}
+
+void spapr_xive_hcall_init(sPAPRMachineState *spapr)
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
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index b5c3e7b197b6..c9a3c9694a91 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -564,6 +564,8 @@ static void spapr_irq_init_xive(sPAPRMachineState *sp=
apr, uint32_t nr_servers,
     for (i =3D 0; i < nr_servers; ++i) {
         spapr_irq_alloc(spapr, SPAPR_IRQ_IPI, i, errp);
     }
+
+    spapr_xive_hcall_init(spapr);
 }
=20
 /*
diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index 301a8e972d91..eacd26836ebf 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -38,7 +38,7 @@ obj-$(CONFIG_XICS) +=3D xics.o
 obj-$(CONFIG_XICS_SPAPR) +=3D xics_spapr.o
 obj-$(CONFIG_XICS_KVM) +=3D xics_kvm.o
 obj-$(CONFIG_XIVE) +=3D xive.o
-obj-$(CONFIG_XIVE_SPAPR) +=3D spapr_xive.o
+obj-$(CONFIG_XIVE_SPAPR) +=3D spapr_xive.o spapr_xive_hcall.o
 obj-$(CONFIG_POWERNV) +=3D xics_pnv.o
 obj-$(CONFIG_ALLWINNER_A10_PIC) +=3D allwinner-a10-pic.o
 obj-$(CONFIG_S390_FLIC) +=3D s390_flic.o
--=20
2.13.6
