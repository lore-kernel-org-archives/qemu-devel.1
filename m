Received: from eggs.gnu.org ([2001:4830:134:3::10]:39558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxDe-0003aP-Jd
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxDX-0004g9-L1
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:52:58 -0400
Received: from 9.mo177.mail-out.ovh.net ([46.105.72.238]:49037)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQxDX-0004ew-0g
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:52:51 -0400
Received: from player169.ha.ovh.net (unknown [10.109.120.81])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 93053B59EE
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 17:52:49 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Jun 2018 17:50:03 +0200
Message-Id: <20180607155003.1580-29-clg@kaod.org>
In-Reply-To: <20180607155003.1580-1-clg@kaod.org>
References: <20180607155003.1580-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 28/28] ppc/pnv: add XIVE support
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

This is simple model of the POWER9 XIVE interrupt controller for the
PowerNV machine. XIVE for baremetal is a complex controller and the
model only addresses the needs of the skiboot firmware.

* Overall architecture

              XIVE Interrupt Controller
              +-------------------------------------+       IPIs
              | +---------+ +---------+ +---------+ |    +--------+
              | |VC       | |CQ       | |PC       |----> | CORES  |
              | |     esb | |         | |         |----> |        |
              | |     ive | |  Bridge | |         |----> |        |
              | |SC   eqd | |         | |     vpd | |    |        |
+------+      | +---------+ +----+----+ +---------+ |    +--+-+-+-+
| RAM  |      +------------------|------------------+       | | |
|      |                         |                          | | |
|      |                         |                          | | |
|      |   +---------------------v--------------------------v-v-v---+    =
  other
|      <---+                       Power Bus                        +----=
> chips
|  esb |   +-----------+-----------------------+--------------------+
|  ive |               |                       |
|  eqd |               |                       |
|  vpd |           +---+----+              +---+----+
+------+           |SC      |              |SC      |
                   |        |              |        |
                   | 2-bits |              | 2-bits |
                   | local  |              |   VC   |
                   +--------+              +--------+
                     PCIe                  NX,NPU,CAPI

                  SC: Source Controller (aka. IVSE)
                  VC: Virtualization Controller (aka. IVRE)
                  CQ: Common Queue (Bridge)
                  PC: Presentation Controller (aka. IVPE)

              2-bits: source state machine
                 esb: Event State Buffer (Array of PQ bits in an IVSE)
                 ive: Interrupt Virtualization Entry
                 eqd: Event Queue Descriptor
                 vpd: Virtual Processor Descriptor

It is composed of three sub-engines :

  - Interrupt Virtualization Source Engine (IVSE), or Source
    Controller (SC). These are found in PCI PHBs, in the PSI host
    bridge controller, but also inside the main controller for the
    core IPIs and other sub-chips (NX, CAP, NPU) of the
    chip/processor. They are configured to feed the IVRE with events.

  - Interrupt Virtualization Routing Engine (IVRE) or Virtualization
    Controller (VC). Its job is to match an event source with an Event
    Queue (EQ).

  - Interrupt Virtualization Presentation Engine (IVPE) or Presentation
    Controller (PC). It maintains the interrupt context state of each
    thread and handles the delivery of the external exception to the
    thread.

* XIVE internal tables

Each of the sub-engines uses a set of tables to redirect exceptions
from event sources to CPU threads.

                                             +-------+
   User or OS                                |  EQ   |
       or                            +------>|entries|
   Hypervisor                        |       |  ..   |
     Memory                          |       +-------+
                                     |           ^
                                     |           |
               +--------------------------------------------------+
                                     |           |
   Hypervisor        +------+    +---+--+    +---+--+   +------+
     Memory          | ESB  |    | IVT  |    | EQDT |   | VPDT |
    (skiboot)        +----+-+    +----+-+    +----+-+   +------+
                       ^  |        ^  |        ^  |       ^
                       |  |        |  |        |  |       |
               +--------------------------------------------------+
                       |  |        |  |        |  |       |
                       |  |        |  |        |  |       |
                 +-----|--|--------|--|--------|--|-+   +-|-----+    +---=
---+
                 |     |  |        |  |        |  | |   | | tctx|    |Thr=
ead|
    IPI or   ----+     +  v        +  v        +  v |---| +  .. |----->  =
   |
   HW events     |                                  |   |       |    |   =
   |
                 |              IVRE                |   | IVPE  |    +---=
---+
                 +----------------------------------+   +-------+

The IVSE have a 2-bits, P for pending and Q for queued, state machine
for each source that allows events to be triggered. They are stored in
an array, the Event State Buffer (ESB) and controlled by MMIOs.

If the event is let through, the IVRE looks up in the Interrupt
Virtualization Entry (IVE) table for an Event Queue Descriptor (EQD)
configured for the source. Each Event Queue Descriptor defines a
notification path to a CPU and an in-memory Event Queue, in which will
be pushed an EQ data for the OS to pull.

The IVPE determines if a Virtual Processor (VP) can handle the event
by scanning the thread contexts of the VPs dispatched on the processor
HW threads. It maintains the interrupt context state of each thread in
a Virtual Processor Descriptor (VPD) table.

* QEMU model for PowerNV

The PowerNV model reuses the common XIVE framework developed for sPAPR
and the fundamentals aspects are quite the same. The difference are
outlined below.

The controller initial BAR configuration is performed using the XSCOM
bus from there, MMIO are used for further configuration.

The MMIO regions exposed are :

 - Interrupt controller registers
 - ESB pages for IPIs and EQs
 - Presenter MMIO (Not used)
 - Thread Interrupt Management Area MMIO, direct and indirect

Virtualization Controller MMIO region containing the IPI ESB pages and
EQ ESB pages is sub-divided into "sets" which map portions of the VC
region to the different ESB pages. It is configured at runtime through
the EDT set translation table to let the firmware decide how to split
the address space between IPI ESB pages and EQ ESB pages.

The XIVE tables are now in the machine RAM and not in the hypervisor
anymore. The firmware (skiboot) configures these tables using Virtual
Structure Descriptor defining the characteristics of each table : SBE,
IVE, EQD and VPD. These are later used to access the virtual interrupt
entries. The internal cache of these tables in the interrupt controller
is updated and invalidated using a set of registers.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/pnv_xive_regs.h    |  314 ++++++++++
 include/hw/ppc/pnv.h       |   22 +
 include/hw/ppc/pnv_xive.h  |   92 +++
 include/hw/ppc/pnv_xscom.h |    3 +
 include/hw/ppc/xive.h      |    1 +
 hw/intc/pnv_xive.c         | 1485 ++++++++++++++++++++++++++++++++++++++=
++++++
 hw/intc/xive.c             |   63 +-
 hw/ppc/pnv.c               |   42 +-
 hw/ppc/pnv_core.c          |   28 +-
 hw/intc/Makefile.objs      |    2 +-
 10 files changed, 2034 insertions(+), 18 deletions(-)
 create mode 100644 hw/intc/pnv_xive_regs.h
 create mode 100644 include/hw/ppc/pnv_xive.h
 create mode 100644 hw/intc/pnv_xive.c

diff --git a/hw/intc/pnv_xive_regs.h b/hw/intc/pnv_xive_regs.h
new file mode 100644
index 000000000000..509d5a18cdde
--- /dev/null
+++ b/hw/intc/pnv_xive_regs.h
@@ -0,0 +1,314 @@
+/*
+ * QEMU PowerPC XIVE interrupt controller model
+ *
+ * Copyright (c) 2017-2018, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef PPC_PNV_XIVE_REGS_H
+#define PPC_PNV_XIVE_REGS_H
+
+/* IC register offsets 0x0 - 0x400 */
+#define CQ_SWI_CMD_HIST         0x020
+#define CQ_SWI_CMD_POLL         0x028
+#define CQ_SWI_CMD_BCAST        0x030
+#define CQ_SWI_CMD_ASSIGN       0x038
+#define CQ_SWI_CMD_BLK_UPD      0x040
+#define CQ_SWI_RSP              0x048
+#define X_CQ_CFG_PB_GEN         0x0a
+#define CQ_CFG_PB_GEN           0x050
+#define   CQ_INT_ADDR_OPT       PPC_BITMASK(14, 15)
+#define X_CQ_IC_BAR             0x10
+#define X_CQ_MSGSND             0x0b
+#define CQ_MSGSND               0x058
+#define CQ_CNPM_SEL             0x078
+#define CQ_IC_BAR               0x080
+#define   CQ_IC_BAR_VALID       PPC_BIT(0)
+#define   CQ_IC_BAR_64K         PPC_BIT(1)
+#define X_CQ_TM1_BAR            0x12
+#define CQ_TM1_BAR              0x90
+#define X_CQ_TM2_BAR            0x014
+#define CQ_TM2_BAR              0x0a0
+#define   CQ_TM_BAR_VALID       PPC_BIT(0)
+#define   CQ_TM_BAR_64K         PPC_BIT(1)
+#define X_CQ_PC_BAR             0x16
+#define CQ_PC_BAR               0x0b0
+#define  CQ_PC_BAR_VALID        PPC_BIT(0)
+#define X_CQ_PC_BARM            0x17
+#define CQ_PC_BARM              0x0b8
+#define  CQ_PC_BARM_MASK        PPC_BITMASK(26, 38)
+#define X_CQ_VC_BAR             0x18
+#define CQ_VC_BAR               0x0c0
+#define  CQ_VC_BAR_VALID        PPC_BIT(0)
+#define X_CQ_VC_BARM            0x19
+#define CQ_VC_BARM              0x0c8
+#define  CQ_VC_BARM_MASK        PPC_BITMASK(21, 37)
+#define X_CQ_TAR                0x1e
+#define CQ_TAR                  0x0f0
+#define  CQ_TAR_TBL_AUTOINC     PPC_BIT(0)
+#define  CQ_TAR_TSEL            PPC_BITMASK(12, 15)
+#define  CQ_TAR_TSEL_BLK        PPC_BIT(12)
+#define  CQ_TAR_TSEL_MIG        PPC_BIT(13)
+#define  CQ_TAR_TSEL_VDT        PPC_BIT(14)
+#define  CQ_TAR_TSEL_EDT        PPC_BIT(15)
+#define  CQ_TAR_TSEL_INDEX      PPC_BITMASK(26, 31)
+#define X_CQ_TDR                0x1f
+#define CQ_TDR                  0x0f8
+#define  CQ_TDR_VDT_VALID       PPC_BIT(0)
+#define  CQ_TDR_VDT_BLK         PPC_BITMASK(11, 15)
+#define  CQ_TDR_VDT_INDEX       PPC_BITMASK(28, 31)
+#define  CQ_TDR_EDT_TYPE        PPC_BITMASK(0, 1)
+#define  CQ_TDR_EDT_INVALID     0
+#define  CQ_TDR_EDT_IPI         1
+#define  CQ_TDR_EDT_EQ          2
+#define  CQ_TDR_EDT_BLK         PPC_BITMASK(12, 15)
+#define  CQ_TDR_EDT_INDEX       PPC_BITMASK(26, 31)
+#define X_CQ_PBI_CTL            0x20
+#define CQ_PBI_CTL              0x100
+#define  CQ_PBI_PC_64K          PPC_BIT(5)
+#define  CQ_PBI_VC_64K          PPC_BIT(6)
+#define  CQ_PBI_LNX_TRIG        PPC_BIT(7)
+#define  CQ_PBI_FORCE_TM_LOCAL  PPC_BIT(22)
+#define CQ_PBO_CTL              0x108
+#define CQ_AIB_CTL              0x110
+#define X_CQ_RST_CTL            0x23
+#define CQ_RST_CTL              0x118
+#define X_CQ_FIRMASK            0x33
+#define CQ_FIRMASK              0x198
+#define X_CQ_FIRMASK_AND        0x34
+#define CQ_FIRMASK_AND          0x1a0
+#define X_CQ_FIRMASK_OR         0x35
+#define CQ_FIRMASK_OR           0x1a8
+
+/* PC LBS1 register offsets 0x400 - 0x800 */
+#define X_PC_TCTXT_CFG          0x100
+#define PC_TCTXT_CFG            0x400
+#define  PC_TCTXT_CFG_BLKGRP_EN         PPC_BIT(0)
+#define  PC_TCTXT_CFG_TARGET_EN         PPC_BIT(1)
+#define  PC_TCTXT_CFG_LGS_EN            PPC_BIT(2)
+#define  PC_TCTXT_CFG_STORE_ACK         PPC_BIT(3)
+#define  PC_TCTXT_CFG_HARD_CHIPID_BLK   PPC_BIT(8)
+#define  PC_TCTXT_CHIPID_OVERRIDE       PPC_BIT(9)
+#define  PC_TCTXT_CHIPID                PPC_BITMASK(12, 15)
+#define  PC_TCTXT_INIT_AGE              PPC_BITMASK(30, 31)
+#define X_PC_TCTXT_TRACK        0x101
+#define PC_TCTXT_TRACK          0x408
+#define  PC_TCTXT_TRACK_EN              PPC_BIT(0)
+#define X_PC_TCTXT_INDIR0       0x104
+#define PC_TCTXT_INDIR0         0x420
+#define  PC_TCTXT_INDIR_VALID           PPC_BIT(0)
+#define  PC_TCTXT_INDIR_THRDID          PPC_BITMASK(9, 15)
+#define X_PC_TCTXT_INDIR1       0x105
+#define PC_TCTXT_INDIR1         0x428
+#define X_PC_TCTXT_INDIR2       0x106
+#define PC_TCTXT_INDIR2         0x430
+#define X_PC_TCTXT_INDIR3       0x107
+#define PC_TCTXT_INDIR3         0x438
+#define X_PC_THREAD_EN_REG0     0x108
+#define PC_THREAD_EN_REG0       0x440
+#define X_PC_THREAD_EN_REG0_SET 0x109
+#define PC_THREAD_EN_REG0_SET   0x448
+#define X_PC_THREAD_EN_REG0_CLR 0x10a
+#define PC_THREAD_EN_REG0_CLR   0x450
+#define X_PC_THREAD_EN_REG1     0x10c
+#define PC_THREAD_EN_REG1       0x460
+#define X_PC_THREAD_EN_REG1_SET 0x10d
+#define PC_THREAD_EN_REG1_SET   0x468
+#define X_PC_THREAD_EN_REG1_CLR 0x10e
+#define PC_THREAD_EN_REG1_CLR   0x470
+#define X_PC_GLOBAL_CONFIG      0x110
+#define PC_GLOBAL_CONFIG        0x480
+#define  PC_GCONF_INDIRECT      PPC_BIT(32)
+#define  PC_GCONF_CHIPID_OVR    PPC_BIT(40)
+#define  PC_GCONF_CHIPID        PPC_BITMASK(44, 47)
+#define X_PC_VSD_TABLE_ADDR     0x111
+#define PC_VSD_TABLE_ADDR       0x488
+#define X_PC_VSD_TABLE_DATA     0x112
+#define PC_VSD_TABLE_DATA       0x490
+#define X_PC_AT_KILL            0x116
+#define PC_AT_KILL              0x4b0
+#define  PC_AT_KILL_VALID       PPC_BIT(0)
+#define  PC_AT_KILL_BLOCK_ID    PPC_BITMASK(27, 31)
+#define  PC_AT_KILL_OFFSET      PPC_BITMASK(48, 60)
+#define X_PC_AT_KILL_MASK       0x117
+#define PC_AT_KILL_MASK         0x4b8
+
+/* PC LBS2 register offsets */
+#define X_PC_VPC_CACHE_ENABLE   0x161
+#define PC_VPC_CACHE_ENABLE     0x708
+#define  PC_VPC_CACHE_EN_MASK   PPC_BITMASK(0, 31)
+#define X_PC_VPC_SCRUB_TRIG     0x162
+#define PC_VPC_SCRUB_TRIG       0x710
+#define X_PC_VPC_SCRUB_MASK     0x163
+#define PC_VPC_SCRUB_MASK       0x718
+#define  PC_SCRUB_VALID         PPC_BIT(0)
+#define  PC_SCRUB_WANT_DISABLE  PPC_BIT(1)
+#define  PC_SCRUB_WANT_INVAL    PPC_BIT(2)
+#define  PC_SCRUB_BLOCK_ID      PPC_BITMASK(27, 31)
+#define  PC_SCRUB_OFFSET        PPC_BITMASK(45, 63)
+#define X_PC_VPC_CWATCH_SPEC    0x167
+#define PC_VPC_CWATCH_SPEC      0x738
+#define  PC_VPC_CWATCH_CONFLICT PPC_BIT(0)
+#define  PC_VPC_CWATCH_FULL     PPC_BIT(8)
+#define  PC_VPC_CWATCH_BLOCKID  PPC_BITMASK(27, 31)
+#define  PC_VPC_CWATCH_OFFSET   PPC_BITMASK(45, 63)
+#define X_PC_VPC_CWATCH_DAT0    0x168
+#define PC_VPC_CWATCH_DAT0      0x740
+#define X_PC_VPC_CWATCH_DAT1    0x169
+#define PC_VPC_CWATCH_DAT1      0x748
+#define X_PC_VPC_CWATCH_DAT2    0x16a
+#define PC_VPC_CWATCH_DAT2      0x750
+#define X_PC_VPC_CWATCH_DAT3    0x16b
+#define PC_VPC_CWATCH_DAT3      0x758
+#define X_PC_VPC_CWATCH_DAT4    0x16c
+#define PC_VPC_CWATCH_DAT4      0x760
+#define X_PC_VPC_CWATCH_DAT5    0x16d
+#define PC_VPC_CWATCH_DAT5      0x768
+#define X_PC_VPC_CWATCH_DAT6    0x16e
+#define PC_VPC_CWATCH_DAT6      0x770
+#define X_PC_VPC_CWATCH_DAT7    0x16f
+#define PC_VPC_CWATCH_DAT7      0x778
+
+/* VC0 register offsets 0x800 - 0xFFF */
+#define X_VC_GLOBAL_CONFIG      0x200
+#define VC_GLOBAL_CONFIG        0x800
+#define  VC_GCONF_INDIRECT      PPC_BIT(32)
+#define X_VC_VSD_TABLE_ADDR     0x201
+#define VC_VSD_TABLE_ADDR       0x808
+#define X_VC_VSD_TABLE_DATA     0x202
+#define VC_VSD_TABLE_DATA       0x810
+#define VC_IVE_ISB_BLOCK_MODE   0x818
+#define VC_EQD_BLOCK_MODE       0x820
+#define VC_VPS_BLOCK_MODE       0x828
+#define X_VC_IRQ_CONFIG_IPI     0x208
+#define VC_IRQ_CONFIG_IPI       0x840
+#define  VC_IRQ_CONFIG_MEMB_EN  PPC_BIT(45)
+#define  VC_IRQ_CONFIG_MEMB_SZ  PPC_BITMASK(46, 51)
+#define VC_IRQ_CONFIG_HW        0x848
+#define VC_IRQ_CONFIG_CASCADE1  0x850
+#define VC_IRQ_CONFIG_CASCADE2  0x858
+#define VC_IRQ_CONFIG_REDIST    0x860
+#define VC_IRQ_CONFIG_IPI_CASC  0x868
+#define X_VC_AIB_TX_ORDER_TAG2  0x22d
+#define  VC_AIB_TX_ORDER_TAG2_REL_TF    PPC_BIT(20)
+#define VC_AIB_TX_ORDER_TAG2    0x890
+#define X_VC_AT_MACRO_KILL      0x23e
+#define VC_AT_MACRO_KILL        0x8b0
+#define X_VC_AT_MACRO_KILL_MASK 0x23f
+#define VC_AT_MACRO_KILL_MASK   0x8b8
+#define  VC_KILL_VALID          PPC_BIT(0)
+#define  VC_KILL_TYPE           PPC_BITMASK(14, 15)
+#define   VC_KILL_IRQ   0
+#define   VC_KILL_IVC   1
+#define   VC_KILL_SBC   2
+#define   VC_KILL_EQD   3
+#define  VC_KILL_BLOCK_ID       PPC_BITMASK(27, 31)
+#define  VC_KILL_OFFSET         PPC_BITMASK(48, 60)
+#define X_VC_EQC_CACHE_ENABLE   0x211
+#define VC_EQC_CACHE_ENABLE     0x908
+#define  VC_EQC_CACHE_EN_MASK   PPC_BITMASK(0, 15)
+#define X_VC_EQC_SCRUB_TRIG     0x212
+#define VC_EQC_SCRUB_TRIG       0x910
+#define X_VC_EQC_SCRUB_MASK     0x213
+#define VC_EQC_SCRUB_MASK       0x918
+#define X_VC_EQC_CWATCH_SPEC    0x215
+#define VC_EQC_CONFIG           0x920
+#define X_VC_EQC_CONFIG         0x214
+#define  VC_EQC_CONF_SYNC_IPI           PPC_BIT(32)
+#define  VC_EQC_CONF_SYNC_HW            PPC_BIT(33)
+#define  VC_EQC_CONF_SYNC_ESC1          PPC_BIT(34)
+#define  VC_EQC_CONF_SYNC_ESC2          PPC_BIT(35)
+#define  VC_EQC_CONF_SYNC_REDI          PPC_BIT(36)
+#define  VC_EQC_CONF_EQP_INTERLEAVE     PPC_BIT(38)
+#define  VC_EQC_CONF_ENABLE_END_s_BIT   PPC_BIT(39)
+#define  VC_EQC_CONF_ENABLE_END_u_BIT   PPC_BIT(40)
+#define  VC_EQC_CONF_ENABLE_END_c_BIT   PPC_BIT(41)
+#define  VC_EQC_CONF_ENABLE_MORE_QSZ    PPC_BIT(42)
+#define  VC_EQC_CONF_SKIP_ESCALATE      PPC_BIT(43)
+#define VC_EQC_CWATCH_SPEC      0x928
+#define  VC_EQC_CWATCH_CONFLICT PPC_BIT(0)
+#define  VC_EQC_CWATCH_FULL     PPC_BIT(8)
+#define  VC_EQC_CWATCH_BLOCKID  PPC_BITMASK(28, 31)
+#define  VC_EQC_CWATCH_OFFSET   PPC_BITMASK(40, 63)
+#define X_VC_EQC_CWATCH_DAT0    0x216
+#define VC_EQC_CWATCH_DAT0      0x930
+#define X_VC_EQC_CWATCH_DAT1    0x217
+#define VC_EQC_CWATCH_DAT1      0x938
+#define X_VC_EQC_CWATCH_DAT2    0x218
+#define VC_EQC_CWATCH_DAT2      0x940
+#define X_VC_EQC_CWATCH_DAT3    0x219
+#define VC_EQC_CWATCH_DAT3      0x948
+#define X_VC_IVC_SCRUB_TRIG     0x222
+#define VC_IVC_SCRUB_TRIG       0x990
+#define X_VC_IVC_SCRUB_MASK     0x223
+#define VC_IVC_SCRUB_MASK       0x998
+#define X_VC_SBC_SCRUB_TRIG     0x232
+#define VC_SBC_SCRUB_TRIG       0xa10
+#define X_VC_SBC_SCRUB_MASK     0x233
+#define VC_SBC_SCRUB_MASK       0xa18
+#define  VC_SCRUB_VALID         PPC_BIT(0)
+#define  VC_SCRUB_WANT_DISABLE  PPC_BIT(1)
+#define  VC_SCRUB_WANT_INVAL    PPC_BIT(2) /* EQC and SBC only */
+#define  VC_SCRUB_BLOCK_ID      PPC_BITMASK(28, 31)
+#define  VC_SCRUB_OFFSET        PPC_BITMASK(40, 63)
+#define X_VC_IVC_CACHE_ENABLE   0x221
+#define VC_IVC_CACHE_ENABLE     0x988
+#define  VC_IVC_CACHE_EN_MASK   PPC_BITMASK(0, 15)
+#define X_VC_SBC_CACHE_ENABLE   0x231
+#define VC_SBC_CACHE_ENABLE     0xa08
+#define  VC_SBC_CACHE_EN_MASK   PPC_BITMASK(0, 15)
+#define VC_IVC_CACHE_SCRUB_TRIG 0x990
+#define VC_IVC_CACHE_SCRUB_MASK 0x998
+#define VC_SBC_CACHE_ENABLE     0xa08
+#define VC_SBC_CACHE_SCRUB_TRIG 0xa10
+#define VC_SBC_CACHE_SCRUB_MASK 0xa18
+#define VC_SBC_CONFIG           0xa20
+#define X_VC_SBC_CONFIG         0x234
+#define  VC_SBC_CONF_CPLX_CIST  PPC_BIT(44)
+#define  VC_SBC_CONF_CIST_BOTH  PPC_BIT(45)
+#define  VC_SBC_CONF_NO_UPD_PRF PPC_BIT(59)
+
+/* VC1 register offsets */
+
+/* VSD Table address register definitions (shared) */
+#define VST_ADDR_AUTOINC        PPC_BIT(0)
+#define VST_TABLE_SELECT        PPC_BITMASK(13, 15)
+#define  VST_TSEL_IVT   0
+#define  VST_TSEL_SBE   1
+#define  VST_TSEL_EQDT  2
+#define  VST_TSEL_VPDT  3
+#define  VST_TSEL_IRQ   4       /* VC only */
+#define VST_TABLE_BLOCK        PPC_BITMASK(27, 31)
+
+/* Number of queue overflow pages */
+#define VC_QUEUE_OVF_COUNT      6
+
+/* Bits in a VSD entry.
+ *
+ * Note: the address is naturally aligned,  we don't use a PPC_BITMASK,
+ *       but just a mask to apply to the address before OR'ing it in.
+ *
+ * Note: VSD_FIRMWARE is a SW bit ! It hijacks an unused bit in the
+ *       VSD and is only meant to be used in indirect mode !
+ */
+#define VSD_MODE                PPC_BITMASK(0, 1)
+#define  VSD_MODE_SHARED        1
+#define  VSD_MODE_EXCLUSIVE     2
+#define  VSD_MODE_FORWARD       3
+#define VSD_ADDRESS_MASK        0x0ffffffffffff000ull
+#define VSD_MIGRATION_REG       PPC_BITMASK(52, 55)
+#define VSD_INDIRECT            PPC_BIT(56)
+#define VSD_TSIZE               PPC_BITMASK(59, 63)
+#define VSD_FIRMWARE            PPC_BIT(2) /* Read warning above */
+
+#define VC_EQC_SYNC_MASK         \
+        (VC_EQC_CONF_SYNC_IPI  | \
+         VC_EQC_CONF_SYNC_HW   | \
+         VC_EQC_CONF_SYNC_ESC1 | \
+         VC_EQC_CONF_SYNC_ESC2 | \
+         VC_EQC_CONF_SYNC_REDI)
+
+
+#endif /* PPC_PNV_XIVE_REGS_H */
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index ffa4a0899705..cf86ab816f22 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -25,6 +25,7 @@
 #include "hw/ppc/pnv_lpc.h"
 #include "hw/ppc/pnv_psi.h"
 #include "hw/ppc/pnv_occ.h"
+#include "hw/ppc/pnv_xive.h"
=20
 #define TYPE_PNV_CHIP "pnv-chip"
 #define PNV_CHIP(obj) OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP)
@@ -61,6 +62,8 @@ typedef struct PnvChip {
     PnvLpcController lpc;
     PnvPsi       psi;
     PnvOCC       occ;
+
+    PnvXive      *xive;
 } PnvChip;
=20
 typedef enum PnvPhysMapType {
@@ -68,6 +71,10 @@ typedef enum PnvPhysMapType {
     PNV_MAP_ICP,
     PNV_MAP_PSIHB,
     PNV_MAP_PSIHB_FSP,
+    PNV_MAP_XIVE_VC,
+    PNV_MAP_XIVE_PC,
+    PNV_MAP_XIVE_IC,
+    PNV_MAP_XIVE_TM,
 } PnvPhysMapType;
=20
 typedef struct PnvPhysMapEntry {
@@ -210,4 +217,19 @@ static inline uint64_t pnv_map_base(const PnvChip *c=
hip, PnvPhysMapType type)
 #define PNV_PSIHB_FSP_SIZE(chip)     pnv_map_size(chip, PNV_MAP_PSIHB_FS=
P)
 #define PNV_PSIHB_FSP_BASE(chip)     pnv_map_base(chip, PNV_MAP_PSIHB_FS=
P)
=20
+/*
+ * POWER9 MMIO base addresses
+ */
+#define PNV_XIVE_VC_SIZE(chip)       pnv_map_size(chip, PNV_MAP_XIVE_VC)
+#define PNV_XIVE_VC_BASE(chip)       pnv_map_base(chip, PNV_MAP_XIVE_VC)
+
+#define PNV_XIVE_PC_SIZE(chip)       pnv_map_size(chip, PNV_MAP_XIVE_PC)
+#define PNV_XIVE_PC_BASE(chip)       pnv_map_base(chip, PNV_MAP_XIVE_PC)
+
+#define PNV_XIVE_IC_SIZE(chip)       pnv_map_size(chip, PNV_MAP_XIVE_IC)
+#define PNV_XIVE_IC_BASE(chip)       pnv_map_base(chip, PNV_MAP_XIVE_IC)
+
+#define PNV_XIVE_TM_SIZE(chip)       pnv_map_size(chip, PNV_MAP_XIVE_TM)
+#define PNV_XIVE_TM_BASE(chip)       pnv_map_base(chip, PNV_MAP_XIVE_TM)
+
 #endif /* _PPC_PNV_H */
diff --git a/include/hw/ppc/pnv_xive.h b/include/hw/ppc/pnv_xive.h
new file mode 100644
index 000000000000..573be7b16065
--- /dev/null
+++ b/include/hw/ppc/pnv_xive.h
@@ -0,0 +1,92 @@
+/*
+ * QEMU PowerPC XIVE interrupt controller model
+ *
+ * Copyright (c) 2017-2018, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef PPC_PNV_XIVE_H
+#define PPC_PNV_XIVE_H
+
+#include "hw/sysbus.h"
+#include "hw/ppc/xive.h"
+
+#define TYPE_PNV_XIVE "pnv-xive"
+#define PNV_XIVE(obj) OBJECT_CHECK(PnvXive, (obj), TYPE_PNV_XIVE)
+
+#define XIVE_BLOCK_MAX 16
+
+typedef struct PnvXive {
+    XiveRouter   parent_obj;
+
+    /* Can be overridden by XIVE configuration */
+    uint32_t     thread_chip_id;
+    uint32_t     chip_id;
+
+    /* Interrupt controller regs */
+    uint64_t     regs[0x300];
+    MemoryRegion xscom_regs;
+
+    /* For IPIs and accelerator interrupts */
+    uint32_t     nr_irqs;
+    XiveSource   source;
+
+    uint32_t     nr_eqs;
+    XiveEQSource eq_source;
+
+    /* Cache update registers */
+    uint64_t     eqc_watch[4];
+    uint64_t     vpc_watch[8];
+
+    /* Virtual Structure Table Descriptors : IVT, SBE, EQDT, VPDT, IRQ *=
/
+    uint64_t     vsds[5][XIVE_BLOCK_MAX];
+
+    /* Set Translation tables */
+    bool         set_xlate_autoinc;
+    uint64_t     set_xlate_index;
+    uint64_t     set_xlate;
+    uint64_t     set_xlate_blk[16]; /* Block Scope Table (0-15) */
+    uint64_t     set_xlate_mig[16]; /* Migration Register Table (1-15) *=
/
+    uint64_t     set_xlate_vdt[16]; /* VDT Domain Table (0-15) */
+    uint64_t     set_xlate_edt[64]; /* EDT Domain Table (0-63) */
+
+    /* Interrupt controller MMIO */
+    hwaddr       ic_base;
+    uint32_t     ic_shift;
+    MemoryRegion ic_mmio;
+    MemoryRegion ic_reg_mmio;
+    MemoryRegion ic_notify_mmio;
+
+    /* VC memory regions */
+    hwaddr       vc_base;
+    uint64_t     vc_size;
+    uint32_t     vc_shift;
+    MemoryRegion vc_mmio;
+    hwaddr       ipi_base;
+    hwaddr       eq_base;
+
+    /* PC memory regions */
+    hwaddr       pc_base;
+    uint64_t     pc_size;
+    uint32_t     pc_shift;
+    MemoryRegion pc_mmio;
+
+    /* TIMA memory regions */
+    hwaddr       tm_base;
+    uint32_t     tm_shift;
+    MemoryRegion tm_mmio;
+    MemoryRegion tm_mmio_indirect;
+
+    /* CPU for indirect TIMA access */
+    PowerPCCPU   *cpu_ind;
+} PnvXive;
+
+void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon);
+
+typedef struct PnvChip PnvChip;
+
+void pnv_chip_xive_realize(PnvChip *chip, Error **errp);
+
+#endif /* PPC_PNV_XIVE_H */
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 255b26a5aaf6..f4b1649ffffa 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -73,6 +73,9 @@ typedef struct PnvXScomInterfaceClass {
 #define PNV_XSCOM_OCC_BASE        0x0066000
 #define PNV_XSCOM_OCC_SIZE        0x6000
=20
+#define PNV_XSCOM_XIVE_BASE       0x5013000
+#define PNV_XSCOM_XIVE_SIZE       0x300
+
 extern void pnv_xscom_realize(PnvChip *chip, Error **errp);
 extern int pnv_dt_xscom(PnvChip *chip, void *fdt, int offset);
=20
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index a2c1cc6b5126..29c780605c33 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -235,6 +235,7 @@ int xive_router_get_vp(XiveRouter *xrtr, uint8_t vp_b=
lk, uint32_t vp_idx,
                        XiveVP *vp);
 int xive_router_set_vp(XiveRouter *xrtr, uint8_t vp_blk, uint32_t vp_idx=
,
                        XiveVP *vp);
+void xive_router_notify(XiveFabric *xf, uint32_t lisn);
=20
 /*
  * XIVE EQ ESBs
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
new file mode 100644
index 000000000000..43b7fea8a0f2
--- /dev/null
+++ b/hw/intc/pnv_xive.c
@@ -0,0 +1,1485 @@
+/*
+ * QEMU PowerPC XIVE interrupt controller model
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
+#include "target/ppc/cpu.h"
+#include "sysemu/cpus.h"
+#include "sysemu/dma.h"
+#include "monitor/monitor.h"
+#include "hw/ppc/fdt.h"
+#include "hw/ppc/pnv.h"
+#include "hw/ppc/pnv_xscom.h"
+#include "hw/ppc/pnv_xive.h"
+#include "hw/ppc/xive_regs.h"
+#include "hw/ppc/ppc.h"
+
+#include <libfdt.h>
+
+#include "pnv_xive_regs.h"
+
+#define GIRQ_TO_BLK(__g)          (((__g) >> 20) & 0xf)
+#define GIRQ_TO_IDX(__g)          ((__g) & 0x000fffff)
+#define BLKIDX_TO_GIRQ(__b, __i)  (((uint32_t)(__b)) << 20 | (__i))
+
+/*
+ * Virtual structures table accessors
+ */
+typedef struct XiveVstInfo {
+    const char *name;
+    uint32_t    size;
+    uint32_t    max_blocks;
+} XiveVstInfo;
+
+static const XiveVstInfo vst_infos[] =3D {
+    [VST_TSEL_IVT]  =3D { "IVT",  sizeof(XiveIVE), 16 },
+    [VST_TSEL_SBE]  =3D { "SBE",  0,               16 },
+    [VST_TSEL_EQDT] =3D { "EQDT", sizeof(XiveEQ),  16 },
+    [VST_TSEL_VPDT] =3D { "VPDT", sizeof(XiveVP),  32 },
+
+    /* Interrupt fifo backing store table :
+     *
+     * 0 - IPI,
+     * 1 - HWD,
+     * 2 - First escalate,
+     * 3 - Second escalate,
+     * 4 - Redistribution,
+     * 5 - IPI cascaded queue ?
+     */
+    [VST_TSEL_IRQ]  =3D { "IRQ",  0,               6  },
+};
+
+/*
+ * Find a remote XIVE IC. The VST accesses are done through MMIO but
+ * this is much simpler and it is not a strong model violation.
+ */
+static PnvXive *pnv_xive_get_ic(uint8_t blk)
+{
+    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
+    int i;
+
+    for (i =3D 0; i < pnv->num_chips; i++) {
+        PnvXive *xive =3D pnv->chips[i]->xive;
+        bool chip_override =3D
+            xive->regs[PC_GLOBAL_CONFIG >> 3] & PC_GCONF_CHIPID_OVR;
+
+        if (chip_override) {
+            if (xive->chip_id =3D=3D blk) {
+                return xive;
+            }
+        } else {
+            ; /* TODO: Block scope support */
+        }
+    }
+    qemu_log_mask(LOG_GUEST_ERROR, "XIVE: unknown chip with block id %d =
!?\n",
+                  blk);
+    return NULL;
+}
+
+static uint64_t pnv_xive_vst_addr(PnvXive *xive, uint8_t type, uint8_t b=
lk,
+                                  uint32_t idx)
+{
+    uint64_t vs_per_page =3D  (1ull << (xive->vc_shift + 1)) /
+        vst_infos[type].size;
+    uint64_t vsd;
+    uint64_t vst_addr;
+    uint64_t vsd_addr;
+    uint64_t page_addr;
+
+    if (blk >=3D vst_infos[type].max_blocks) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid block id %d for VS=
T"
+                      " %s %d !?\n", blk, vst_infos[type].name, idx);
+        return 0;
+    }
+
+    vsd =3D xive->vsds[type][blk];
+    vst_addr =3D vsd & VSD_ADDRESS_MASK;
+
+    /* Remote VST accesses */
+    if (GETFIELD(VSD_MODE, vsd) =3D=3D VSD_MODE_FORWARD) {
+        PnvXive *xive =3D pnv_xive_get_ic(blk);
+
+        return xive ? pnv_xive_vst_addr(xive, type, blk, idx) : 0;
+    }
+
+    if (!(VSD_INDIRECT & vsd)) {
+        return vst_addr + idx * vst_infos[type].size;
+    }
+
+    vsd_addr =3D vst_addr + (idx / vs_per_page);
+    vsd =3D ldq_be_dma(&address_space_memory, vsd_addr);
+
+    /* We don't support nested indirect tables */
+    if (VSD_INDIRECT & vsd) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: found a nested indirect"
+                      " table at index %d\n", idx);
+        return 0;
+    }
+
+    page_addr =3D vsd & VSD_ADDRESS_MASK;
+    if (!page_addr) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid %s entry %x/%x !?\=
n",
+                      vst_infos[type].name, blk, idx);
+        return 0;
+    }
+
+    return page_addr + (idx % vs_per_page) * vst_infos[type].size;
+}
+
+static int pnv_xive_get_eq(XiveRouter *xrtr, uint8_t blk, uint32_t idx,
+                           XiveEQ *eq)
+{
+    PnvXive *xive =3D PNV_XIVE(xrtr);
+    uint64_t eq_addr =3D pnv_xive_vst_addr(xive, VST_TSEL_EQDT, blk, idx=
);
+
+    if (!eq_addr) {
+        return -1;
+    }
+
+    cpu_physical_memory_read(eq_addr, eq, sizeof(XiveEQ));
+    eq->w0 =3D be32_to_cpu(eq->w0);
+    eq->w1 =3D be32_to_cpu(eq->w1);
+    eq->w2 =3D be32_to_cpu(eq->w2);
+    eq->w3 =3D be32_to_cpu(eq->w3);
+    eq->w4 =3D be32_to_cpu(eq->w4);
+    eq->w5 =3D be32_to_cpu(eq->w5);
+    eq->w6 =3D be32_to_cpu(eq->w6);
+    eq->w7 =3D be32_to_cpu(eq->w7);
+
+    return 0;
+}
+
+static int pnv_xive_set_eq(XiveRouter *xrtr, uint8_t blk, uint32_t idx,
+                           XiveEQ *in_eq)
+{
+    PnvXive *xive =3D PNV_XIVE(xrtr);
+    XiveEQ eq;
+    uint64_t eq_addr =3D pnv_xive_vst_addr(xive, VST_TSEL_EQDT, blk, idx=
);
+
+    if (!eq_addr) {
+        return -1;
+    }
+
+    eq.w0 =3D cpu_to_be32(in_eq->w0);
+    eq.w1 =3D cpu_to_be32(in_eq->w1);
+    eq.w2 =3D cpu_to_be32(in_eq->w2);
+    eq.w3 =3D cpu_to_be32(in_eq->w3);
+    eq.w4 =3D cpu_to_be32(in_eq->w4);
+    eq.w5 =3D cpu_to_be32(in_eq->w5);
+    eq.w6 =3D cpu_to_be32(in_eq->w6);
+    eq.w7 =3D cpu_to_be32(in_eq->w7);
+    cpu_physical_memory_write(eq_addr, &eq, sizeof(XiveEQ));
+    return 0;
+}
+
+static int pnv_xive_eq_update(PnvXive *xive, uint8_t blk, uint32_t idx)
+{
+    uint64_t eq_addr =3D pnv_xive_vst_addr(xive, VST_TSEL_EQDT, blk, idx=
);
+
+    if (!eq_addr) {
+        return -1;
+    }
+
+    cpu_physical_memory_write(eq_addr, xive->eqc_watch, sizeof(XiveEQ));
+    return 0;
+}
+
+static int pnv_xive_get_vp(XiveRouter *xrtr, uint8_t blk, uint32_t idx,
+                           XiveVP *vp)
+{
+    PnvXive *xive =3D PNV_XIVE(xrtr);
+    uint64_t vp_addr =3D pnv_xive_vst_addr(xive, VST_TSEL_VPDT, blk, idx=
);
+
+    if (!vp_addr) {
+        return -1;
+    }
+
+    cpu_physical_memory_read(vp_addr, vp, sizeof(XiveVP));
+    vp->w0 =3D cpu_to_be32(vp->w0);
+    vp->w1 =3D cpu_to_be32(vp->w1);
+    vp->w2 =3D cpu_to_be32(vp->w2);
+    vp->w3 =3D cpu_to_be32(vp->w3);
+    vp->w4 =3D cpu_to_be32(vp->w4);
+    vp->w5 =3D cpu_to_be32(vp->w5);
+    vp->w6 =3D cpu_to_be32(vp->w6);
+    vp->w7 =3D cpu_to_be32(vp->w7);
+
+    return 0;
+}
+
+static int pnv_xive_set_vp(XiveRouter *xrtr, uint8_t blk, uint32_t idx,
+                           XiveVP *in_vp)
+{
+    PnvXive *xive =3D PNV_XIVE(xrtr);
+    XiveVP vp;
+    uint64_t vp_addr =3D pnv_xive_vst_addr(xive, VST_TSEL_VPDT, blk, idx=
);
+
+    if (!vp_addr) {
+        return -1;
+    }
+
+    vp.w0 =3D cpu_to_be32(in_vp->w0);
+    vp.w1 =3D cpu_to_be32(in_vp->w1);
+    vp.w2 =3D cpu_to_be32(in_vp->w2);
+    vp.w3 =3D cpu_to_be32(in_vp->w3);
+    vp.w4 =3D cpu_to_be32(in_vp->w4);
+    vp.w5 =3D cpu_to_be32(in_vp->w5);
+    vp.w6 =3D cpu_to_be32(in_vp->w6);
+    vp.w7 =3D cpu_to_be32(in_vp->w7);
+    cpu_physical_memory_write(vp_addr, &vp, sizeof(XiveVP));
+    return 0;
+}
+
+static int pnv_xive_vp_update(PnvXive *xive, uint8_t blk, uint32_t idx)
+{
+    uint64_t vp_addr =3D pnv_xive_vst_addr(xive, VST_TSEL_VPDT, blk, idx=
);
+
+    if (!vp_addr) {
+        return -1;
+    }
+
+    cpu_physical_memory_write(vp_addr, xive->vpc_watch, sizeof(XiveVP));
+    return 0;
+}
+
+static int pnv_xive_get_ive(XiveRouter *xrtr, uint32_t lisn, XiveIVE *iv=
e)
+{
+    PnvXive *xive =3D PNV_XIVE(xrtr);
+    uint8_t  blk =3D GIRQ_TO_BLK(lisn);
+    uint32_t idx =3D GIRQ_TO_IDX(lisn);
+    uint64_t ive_addr;
+
+    /* TODO: check when are remote IVE lookups needed */
+    if (pnv_xive_get_ic(blk) !=3D xive) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Remote IVE %x lookup not "
+                      "supported\n", lisn);
+        return -1;
+    }
+
+    ive_addr =3D pnv_xive_vst_addr(xive, VST_TSEL_IVT, blk, idx);
+    if (!ive_addr) {
+        return -1;
+    }
+
+    ive->w &=3D ~IVE_VALID;
+    *((uint64_t *) ive) =3D ldq_be_dma(&address_space_memory, ive_addr);
+    return 0;
+}
+
+static int pnv_xive_set_ive(XiveRouter *xrtr, uint32_t lisn, XiveIVE *iv=
e)
+{
+    /* All done. We don't use the state bit table in memory */
+    return 0;
+}
+
+static int pnv_xive_ive_update(PnvXive *xive, uint32_t idx)
+{
+    /* All done. We don't use the state bit table in memory */
+    return 0;
+}
+
+
+/*
+ * Virtual Structure Tables (VST) configuration
+ */
+static void pnv_xive_table_set_exclusive(PnvXive *xive, uint8_t type,
+                                         uint8_t blk, uint64_t vsd)
+{
+    uint32_t size =3D 1 << (GETFIELD(VSD_TSIZE, vsd) + 12);
+
+    if (!size) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid %s table\n",
+                      vst_infos[type].name);
+        return;
+    }
+
+    switch (type) {
+    case VST_TSEL_IVT:
+        break;
+
+    case VST_TSEL_EQDT:
+        /*
+         * FIXME: skiboot sets the EQDT as indirect with 64K subpages,
+         * which is too big for the VC MMIO region. I believe this is
+         * an indexing error.
+         */
+        vsd &=3D ~VSD_TSIZE;
+        vsd |=3D SETFIELD(VSD_TSIZE, 0ull, 0);
+        break;
+
+    case VST_TSEL_VPDT:
+        /* FIXME: skiboot sets the VPDT as indirect with 64K subpages. *=
/
+        vsd &=3D ~VSD_TSIZE;
+        vsd |=3D SETFIELD(VSD_TSIZE, 0ull, 0);
+        break;
+
+    case VST_TSEL_SBE:
+        /*
+         * contains the backing store pages for the source state
+         * bits. The XiveSource model does not use it.
+         */
+        break;
+
+    case VST_TSEL_IRQ: /* VC only */
+        /*
+         * These tables contains the backing store pages for the
+         * interrupt fifos of the VC sub-engine in case of overflow
+         * but we don't model the fifos.
+         */
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid table type %d\n", =
type);
+        return;
+    }
+
+    /* Keep the VSD for later use */
+    xive->vsds[type][blk] =3D vsd;
+}
+
+/*
+ * Both PC and VC sub-engines are configured as each use the Virtual
+ * Structure Tables : SBE, IVE, EQD and VPD.
+ */
+static void pnv_xive_table_set_data(PnvXive *xive, uint64_t vsd, bool pc=
_engine)
+{
+    uint8_t mode =3D GETFIELD(VSD_MODE, vsd);
+    uint8_t type =3D GETFIELD(VST_TABLE_SELECT,
+                            xive->regs[VC_VSD_TABLE_ADDR >> 3]);
+    uint8_t blk =3D GETFIELD(VST_TABLE_BLOCK,
+                             xive->regs[VC_VSD_TABLE_ADDR >> 3]);
+    bool gconf_indirect =3D pc_engine ?
+        xive->regs[VC_GLOBAL_CONFIG >> 3] & VC_GCONF_INDIRECT :
+        xive->regs[PC_GLOBAL_CONFIG >> 3] & PC_GCONF_INDIRECT;
+
+    if (type > VST_TSEL_IRQ) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE/IC: invalid table type %d\n=
",
+                      type);
+        return;
+    }
+
+    if (blk >=3D vst_infos[type].max_blocks) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE/IC: invalid block id %d for=
"
+                      " %s table", blk, vst_infos[type].name);
+        return;
+    }
+
+    if ((VSD_INDIRECT & vsd) && !gconf_indirect) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE/IC: invalid %s indirect tab=
le\n",
+                      vst_infos[type].name);
+        return;
+    }
+
+    /*
+     * Only take the VC configuration into account because the
+     * XiveRouter model combines both VC and PC sub-engines
+     */
+    if  (pc_engine) {
+        return;
+    }
+
+    switch (mode) {
+    case VSD_MODE_FORWARD:
+        /* Only record the descriptor for remote ICs. */
+        xive->vsds[type][blk] =3D vsd;
+        break;
+
+    case VSD_MODE_EXCLUSIVE:
+        pnv_xive_table_set_exclusive(xive, type, blk, vsd);
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE/IC: invalid table mode %d\n=
",
+                      mode);
+        return;
+    }
+}
+
+/*
+ * IPI and EQ sources realize routines
+ *
+ * The setting of the MMIO regions of the IPIs and EQs ESB pages make
+ * the assumption that the EDT set translation table defines
+ * contiguous range for each but this is not true.
+ *
+ * Instead we should be using a top level VC MMIO region dispatching
+ * on two different address space depending on the EDT set translation
+ * table. For later.
+ */
+#define PNV_XIVE_SET_XLATE_SIZE  (8ull << 30)
+
+static uint64_t pnv_xive_set_xlate_edt_size(PnvXive *xive, uint64_t type=
)
+{
+    uint64_t size =3D 0;
+    int i;
+
+    for (i =3D 0; i < ARRAY_SIZE(xive->set_xlate_edt); i++) {
+        uint64_t edt_type =3D GETFIELD(CQ_TDR_EDT_TYPE, xive->set_xlate_=
edt[i]);
+
+        if (edt_type =3D=3D type) {
+            size +=3D PNV_XIVE_SET_XLATE_SIZE;
+        }
+    }
+
+    return size;
+}
+
+static void pnv_xive_source_realize(PnvXive *xive, Error **errp)
+{
+    XiveSource *xsrc =3D &xive->source;
+    Error *local_err =3D NULL;
+    uint64_t ipi_mmio_size =3D pnv_xive_set_xlate_edt_size(xive, CQ_TDR_=
EDT_IPI);
+
+    /* Two pages per IRQ */
+    xive->nr_irqs =3D ipi_mmio_size / (1ull << (xive->vc_shift + 1));
+    xive->ipi_base =3D xive->vc_base;
+
+    object_property_set_int(OBJECT(xsrc), xive->nr_irqs, "nr-irqs",
+                            &error_fatal);
+    object_property_add_const_link(OBJECT(xsrc), "xive", OBJECT(xive),
+                                   &error_fatal);
+    object_property_set_bool(OBJECT(xsrc), true, "realized", &local_err)=
;
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    qdev_set_parent_bus(DEVICE(xsrc), sysbus_get_default());
+
+    /*
+     * Install the ESB MMIO region in the overall VC region.
+     *
+     * TODO: Use an IPI ESB address_space
+     */
+    memory_region_add_subregion(&xive->vc_mmio, 0, &xsrc->esb_mmio);
+
+    /* Start in clean state */
+    device_reset(DEVICE(&xive->source));
+}
+
+static void pnv_xive_eq_source_realize(PnvXive *xive, Error **errp)
+{
+    XiveEQSource *eq_xsrc =3D &xive->eq_source;
+    Error *local_err =3D NULL;
+    uint64_t ipi_mmio_size =3D pnv_xive_set_xlate_edt_size(xive, CQ_TDR_=
EDT_IPI);
+    uint64_t eq_mmio_size =3D pnv_xive_set_xlate_edt_size(xive, CQ_TDR_E=
DT_EQ);
+
+    /* Two pages per EQ: ESn and ESe */
+    xive->nr_eqs  =3D eq_mmio_size / (1ull << (xive->vc_shift + 1));
+    xive->eq_base =3D xive->vc_base + ipi_mmio_size;
+
+    object_property_set_int(OBJECT(eq_xsrc), xive->nr_eqs, "nr-eqs",
+                            &error_fatal);
+    object_property_add_const_link(OBJECT(eq_xsrc), "xive", OBJECT(xive)=
,
+                                   &error_fatal);
+    object_property_set_bool(OBJECT(eq_xsrc), true, "realized", &local_e=
rr);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    qdev_set_parent_bus(DEVICE(eq_xsrc), sysbus_get_default());
+
+    /*
+     * Install the EQ ESB MMIO region in the overall VC region
+     *
+     * TODO: Use an EQ ESB address_space
+     */
+    memory_region_add_subregion(&xive->vc_mmio, ipi_mmio_size,
+                                &eq_xsrc->esb_mmio);
+}
+
+/*
+ * XIVE Set Translation Table configuration
+ */
+static int pnv_xive_set_xlate_update(PnvXive *xive, uint64_t val)
+{
+    uint8_t index =3D xive->set_xlate_autoinc ?
+        xive->set_xlate_index++ : xive->set_xlate_index;
+    uint8_t max_index;
+    uint64_t *xlate_table;
+
+    switch (xive->set_xlate) {
+    case CQ_TAR_TSEL_BLK:
+        max_index =3D ARRAY_SIZE(xive->set_xlate_blk);
+        xlate_table =3D xive->set_xlate_blk;
+        break;
+    case CQ_TAR_TSEL_MIG:
+        max_index =3D ARRAY_SIZE(xive->set_xlate_mig);
+        xlate_table =3D xive->set_xlate_mig;
+        break;
+    case CQ_TAR_TSEL_EDT:
+        max_index =3D ARRAY_SIZE(xive->set_xlate_edt);
+        xlate_table =3D xive->set_xlate_edt;
+        break;
+    case CQ_TAR_TSEL_VDT:
+        max_index =3D ARRAY_SIZE(xive->set_xlate_vdt);
+        xlate_table =3D xive->set_xlate_vdt;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid xlate table set %d=
\n",
+                      (int) xive->set_xlate);
+        return -1;
+    }
+
+    if (index >=3D max_index) {
+        return -1;
+    }
+
+    xlate_table[index] =3D val;
+
+    /*
+     * When we are done setting the EDT set translation table, create
+     * the source objects for PnvXive.
+     */
+    if (xive->set_xlate =3D=3D CQ_TAR_TSEL_EDT && index =3D=3D max_index=
 - 1) {
+        pnv_xive_source_realize(xive, &error_fatal);
+        pnv_xive_eq_source_realize(xive, &error_fatal);
+    }
+
+    return 0;
+}
+
+static int pnv_xive_set_xlate_select(PnvXive *xive, uint64_t val)
+{
+    xive->set_xlate_autoinc =3D val & CQ_TAR_TBL_AUTOINC;
+    xive->set_xlate =3D val & CQ_TAR_TSEL;
+    xive->set_xlate_index =3D GETFIELD(CQ_TAR_TSEL_INDEX, val);
+
+    return 0;
+}
+
+/*
+ * Accesses to the TIMA can be done from the indirect range and the
+ * thread id (PIR) has to be configured in the IC. Used For resets.
+ */
+static void pnv_xive_thread_indirect_set(PnvXive *xive, uint64_t val)
+{
+    int pir =3D GETFIELD(PC_TCTXT_INDIR_THRDID, xive->regs[PC_TCTXT_INDI=
R0 >> 3]);
+
+    if (val & PC_TCTXT_INDIR_VALID) {
+        if (xive->cpu_ind) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE/IC: indirect access alr=
eady"
+                          " set for invalid PIR %d", pir);
+        }
+
+        pir =3D GETFIELD(PC_TCTXT_INDIR_THRDID, val) & 0xff;
+        xive->cpu_ind =3D ppc_get_vcpu_by_pir(pir);
+        if (!xive->cpu_ind) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE/IC: invalid PIR %d for"
+                          " indirect access\n", pir);
+        }
+    } else {
+        xive->cpu_ind =3D NULL;
+    }
+}
+
+/*
+ * Interrupt Controller registers MMIO
+ */
+static void pnv_xive_ic_reg_write(PnvXive *xive, uint32_t offset, uint64=
_t val,
+                                  bool mmio)
+{
+    MemoryRegion *sysmem =3D get_system_memory();
+    uint32_t reg =3D offset >> 3;
+
+    switch (offset) {
+
+    /*
+     * XIVE CQ (PowerBus bridge) settings
+     */
+    case CQ_MSGSND:     /* msgsnd for doorbells */
+    case CQ_FIRMASK_OR: /* FIR error reporting */
+    case CQ_PBI_CTL:
+        if (val & CQ_PBI_PC_64K) {
+            xive->pc_shift =3D 16;
+        }
+        if (val & CQ_PBI_VC_64K) {
+            xive->vc_shift =3D 16;
+        }
+        break;
+    case CQ_CFG_PB_GEN: /* PowerBus General Configuration */
+        /*
+         * TODO: CQ_INT_ADDR_OPT for 1-block-per-chip mode
+         */
+        xive->regs[reg] =3D val;
+        break;
+
+    /*
+     * XIVE Virtualization Controller settings
+     */
+    case VC_GLOBAL_CONFIG:
+        xive->regs[reg] =3D val;
+        break;
+
+    /*
+     * XIVE Presenter Controller settings
+     */
+    case PC_GLOBAL_CONFIG:
+        /* Overrides Int command Chip ID with the Chip ID field */
+        if (val & PC_GCONF_CHIPID_OVR) {
+            xive->chip_id =3D GETFIELD(PC_GCONF_CHIPID, val);
+        }
+        xive->regs[reg] =3D val;
+        break;
+    case PC_TCTXT_CFG:
+        /*
+         * TODO: PC_TCTXT_CFG_BLKGRP_EN for block group support
+         * TODO: PC_TCTXT_CFG_HARD_CHIPID_BLK
+         */
+
+        /*
+         * Moves the chipid into block field for hardwired CAM
+         * compares Block offset value is adjusted to 0b0..01 & ThrdId
+         */
+        if (val & PC_TCTXT_CHIPID_OVERRIDE) {
+            xive->thread_chip_id =3D GETFIELD(PC_TCTXT_CHIPID, val);
+        }
+        break;
+    case PC_TCTXT_TRACK: /* Enable block tracking (DD2) */
+        xive->regs[reg] =3D val;
+        break;
+
+    /*
+     * Misc settings
+     */
+    case VC_EQC_CONFIG: /* enable silent escalation */
+    case VC_SBC_CONFIG: /* Store EOI configuration */
+    case VC_AIB_TX_ORDER_TAG2:
+        xive->regs[reg] =3D val;
+        break;
+
+    /*
+     * XIVE BAR settings (XSCOM only)
+     */
+    case CQ_RST_CTL:
+        /* resets all bars */
+        break;
+    case CQ_IC_BAR: /* IC BAR and page size. 8 * 64k */
+        xive->ic_shift =3D val & CQ_IC_BAR_64K ? 16 : 12;
+        if (!(val & CQ_IC_BAR_VALID)) {
+            xive->ic_base =3D 0;
+            if (xive->regs[reg] & CQ_IC_BAR_VALID) {
+                memory_region_del_subregion(&xive->ic_mmio,
+                                            &xive->ic_reg_mmio);
+                memory_region_del_subregion(&xive->ic_mmio,
+                                            &xive->ic_notify_mmio);
+                memory_region_del_subregion(sysmem, &xive->ic_mmio);
+                memory_region_del_subregion(sysmem, &xive->tm_mmio_indir=
ect);
+            }
+        } else {
+            xive->ic_base  =3D val & ~(CQ_IC_BAR_VALID | CQ_IC_BAR_64K);
+            if (!(xive->regs[reg] & CQ_IC_BAR_VALID)) {
+                memory_region_add_subregion(sysmem, xive->ic_base,
+                                            &xive->ic_mmio);
+                memory_region_add_subregion(&xive->ic_mmio,  0,
+                                            &xive->ic_reg_mmio);
+                memory_region_add_subregion(&xive->ic_mmio,
+                                            1ul << xive->ic_shift,
+                                            &xive->ic_notify_mmio);
+                memory_region_add_subregion(sysmem,
+                                   xive->ic_base + (4ull << xive->ic_shi=
ft),
+                                   &xive->tm_mmio_indirect);
+            }
+        }
+        xive->regs[reg] =3D val;
+        break;
+    case CQ_TM1_BAR: /* TM BAR and page size. 4 * 64k */
+    case CQ_TM2_BAR: /* second TM BAR is for hotplug use */
+        xive->tm_shift =3D val & CQ_TM_BAR_64K ? 16 : 12;
+        if (!(val & CQ_TM_BAR_VALID)) {
+            xive->tm_base =3D 0;
+            if (xive->regs[reg] & CQ_TM_BAR_VALID) {
+                memory_region_del_subregion(sysmem, &xive->tm_mmio);
+            }
+        } else {
+            xive->tm_base  =3D val & ~(CQ_TM_BAR_VALID | CQ_TM_BAR_64K);
+            if (!(xive->regs[reg] & CQ_TM_BAR_VALID)) {
+                memory_region_add_subregion(sysmem, xive->tm_base,
+                                            &xive->tm_mmio);
+            }
+        }
+        xive->regs[reg] =3D val;
+       break;
+    case CQ_PC_BAR:
+        if (!(val & CQ_PC_BAR_VALID)) {
+            xive->pc_base =3D 0;
+            if (xive->regs[reg] & CQ_PC_BAR_VALID) {
+                memory_region_del_subregion(sysmem, &xive->pc_mmio);
+            }
+        } else {
+            xive->pc_base =3D val & ~(CQ_PC_BAR_VALID);
+            if (!(xive->regs[reg] & CQ_PC_BAR_VALID)) {
+                memory_region_add_subregion(sysmem, xive->pc_base,
+                                            &xive->pc_mmio);
+            }
+        }
+        xive->regs[reg] =3D val;
+        break;
+    case CQ_PC_BARM: /* TODO: PC BAR size */
+        xive->pc_size =3D  (~val + 1) & CQ_PC_BARM_MASK;
+        xive->regs[reg] =3D val;
+        break;
+    case CQ_VC_BAR:
+        if (!(val & CQ_VC_BAR_VALID)) {
+            xive->vc_base =3D 0;
+            if (xive->regs[reg] & CQ_VC_BAR_VALID) {
+                memory_region_del_subregion(sysmem, &xive->vc_mmio);
+            }
+        } else {
+            xive->vc_base =3D val & ~(CQ_VC_BAR_VALID);
+            if (!(xive->regs[reg] & CQ_VC_BAR_VALID)) {
+                memory_region_add_subregion(sysmem, xive->vc_base,
+                                            &xive->vc_mmio);
+            }
+        }
+        xive->regs[reg] =3D val;
+        break;
+    case CQ_VC_BARM: /* TODO: VC BAR size */
+        xive->vc_size =3D  (~val + 1) & CQ_VC_BARM_MASK;
+        xive->regs[reg] =3D val;
+        break;
+
+
+    /*
+     * XIVE Set Translation Table settings. Defines the MMIO regions
+     * for the ESB pages of the IPIs and of the EQs
+     */
+    case CQ_TAR: /* Set Translation Table Address */
+        pnv_xive_set_xlate_select(xive, val);
+        break;
+    case CQ_TDR: /* Set Translation Table Data */
+        pnv_xive_set_xlate_update(xive, val);
+        break;
+
+    /*
+     * XIVE VC and PC virtual structure table settings
+     */
+    case VC_VSD_TABLE_ADDR:
+    case PC_VSD_TABLE_ADDR: /* Virtual table selector */
+        xive->regs[reg] =3D val;
+        break;
+    case VC_VSD_TABLE_DATA: /* Virtual table setting */
+    case PC_VSD_TABLE_DATA:
+        pnv_xive_table_set_data(xive, val, offset =3D=3D PC_VSD_TABLE_DA=
TA);
+        break;
+
+    /*
+     * Interrupt fifo overflow in memory backing store. We don't model
+     * the VC interrupt fifos. Just ignore.
+     */
+    case VC_IRQ_CONFIG_IPI:
+    case VC_IRQ_CONFIG_HW:
+    case VC_IRQ_CONFIG_CASCADE1:
+    case VC_IRQ_CONFIG_CASCADE2:
+    case VC_IRQ_CONFIG_REDIST:
+    case VC_IRQ_CONFIG_IPI_CASC:
+        xive->regs[reg] =3D val;
+        break;
+
+    /*
+     * XIVE hardware thread enablement
+     */
+    case PC_THREAD_EN_REG0_SET: /* Physical Thread Enable */
+    case PC_THREAD_EN_REG1_SET: /* Physical Thread Enable (fused core) *=
/
+        xive->regs[reg] |=3D val;
+        break;
+    case PC_THREAD_EN_REG0_CLR:
+        xive->regs[PC_THREAD_EN_REG0_SET >> 3] &=3D ~val;
+        break;
+    case PC_THREAD_EN_REG1_CLR:
+        xive->regs[PC_THREAD_EN_REG1_SET >> 3] &=3D ~val;
+        break;
+
+    /*
+     * Indirect TIMA access set up. Defines the CPU to use.
+     */
+    case PC_TCTXT_INDIR0:
+        pnv_xive_thread_indirect_set(xive, val);
+        xive->regs[reg] =3D val;
+        break;
+    case PC_TCTXT_INDIR1:
+    case PC_TCTXT_INDIR2:
+    case PC_TCTXT_INDIR3:
+        /* TODO: check what PC_TCTXT_INDIR[123] are for */
+        xive->regs[reg] =3D val;
+        break;
+
+    /*
+     * XIVE PC & VC cache updates for IVE, VPD and EQD
+     */
+    case PC_VPC_SCRUB_MASK:
+    case PC_VPC_CWATCH_SPEC:
+    case VC_EQC_SCRUB_MASK:
+    case VC_EQC_CWATCH_SPEC:
+    case VC_IVC_SCRUB_MASK:
+        xive->regs[reg] =3D val;
+        break;
+    case VC_IVC_SCRUB_TRIG:
+        pnv_xive_ive_update(xive, GETFIELD(VC_SCRUB_OFFSET, val));
+        break;
+    case PC_VPC_CWATCH_DAT0:
+    case PC_VPC_CWATCH_DAT1:
+    case PC_VPC_CWATCH_DAT2:
+    case PC_VPC_CWATCH_DAT3:
+    case PC_VPC_CWATCH_DAT4:
+    case PC_VPC_CWATCH_DAT5:
+    case PC_VPC_CWATCH_DAT6:
+    case PC_VPC_CWATCH_DAT7:
+        xive->vpc_watch[(offset - PC_VPC_CWATCH_DAT0) / 8] =3D cpu_to_be=
64(val);
+        break;
+    case PC_VPC_SCRUB_TRIG:
+        pnv_xive_vp_update(xive, GETFIELD(PC_SCRUB_BLOCK_ID, val),
+                           GETFIELD(PC_SCRUB_OFFSET, val));
+        break;
+    case VC_EQC_CWATCH_DAT0:
+    case VC_EQC_CWATCH_DAT1:
+    case VC_EQC_CWATCH_DAT2:
+    case VC_EQC_CWATCH_DAT3:
+        xive->eqc_watch[(offset - VC_EQC_CWATCH_DAT0) / 8] =3D cpu_to_be=
64(val);
+        break;
+    case VC_EQC_SCRUB_TRIG:
+        pnv_xive_eq_update(xive, GETFIELD(VC_SCRUB_BLOCK_ID, val),
+                           GETFIELD(VC_SCRUB_OFFSET, val));
+        break;
+
+    /*
+     * XIVE PC & VC cache invalidation
+     */
+    case PC_AT_KILL:
+        xive->regs[reg] |=3D val;
+        break;
+    case VC_AT_MACRO_KILL:
+        xive->regs[reg] |=3D val;
+        break;
+    case PC_AT_KILL_MASK:
+    case VC_AT_MACRO_KILL_MASK:
+        xive->regs[reg] =3D val;
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE/IC: invalid writing to reg=3D=
0x%08x"
+                      " mmio=3D%d\n", offset, mmio);
+    }
+}
+
+static uint64_t pnv_xive_ic_reg_read(PnvXive *xive, uint32_t offset, boo=
l mmio)
+{
+    uint64_t val =3D 0;
+    uint32_t reg =3D offset >> 3;
+
+    switch (offset) {
+    case CQ_CFG_PB_GEN:
+    case CQ_IC_BAR:
+    case CQ_TM1_BAR:
+    case CQ_TM2_BAR:
+    case CQ_PC_BAR:
+    case CQ_PC_BARM:
+    case CQ_VC_BAR:
+    case CQ_VC_BARM:
+    case CQ_TAR:
+    case CQ_TDR:
+    case CQ_PBI_CTL:
+
+    case PC_TCTXT_CFG:
+    case PC_TCTXT_TRACK:
+    case PC_TCTXT_INDIR0:
+    case PC_TCTXT_INDIR1:
+    case PC_TCTXT_INDIR2:
+    case PC_TCTXT_INDIR3:
+    case PC_GLOBAL_CONFIG:
+
+    case PC_VPC_SCRUB_MASK:
+    case PC_VPC_CWATCH_SPEC:
+    case PC_VPC_CWATCH_DAT0:
+    case PC_VPC_CWATCH_DAT1:
+    case PC_VPC_CWATCH_DAT2:
+    case PC_VPC_CWATCH_DAT3:
+    case PC_VPC_CWATCH_DAT4:
+    case PC_VPC_CWATCH_DAT5:
+    case PC_VPC_CWATCH_DAT6:
+    case PC_VPC_CWATCH_DAT7:
+
+    case VC_GLOBAL_CONFIG:
+    case VC_AIB_TX_ORDER_TAG2:
+
+    case VC_IRQ_CONFIG_IPI:
+    case VC_IRQ_CONFIG_HW:
+    case VC_IRQ_CONFIG_CASCADE1:
+    case VC_IRQ_CONFIG_CASCADE2:
+    case VC_IRQ_CONFIG_REDIST:
+    case VC_IRQ_CONFIG_IPI_CASC:
+
+    case VC_EQC_SCRUB_MASK:
+    case VC_EQC_CWATCH_DAT0:
+    case VC_EQC_CWATCH_DAT1:
+    case VC_EQC_CWATCH_DAT2:
+    case VC_EQC_CWATCH_DAT3:
+
+    case VC_EQC_CWATCH_SPEC:
+    case VC_IVC_SCRUB_MASK:
+    case VC_SBC_CONFIG:
+    case VC_AT_MACRO_KILL_MASK:
+    case VC_VSD_TABLE_ADDR:
+    case PC_VSD_TABLE_ADDR:
+    case VC_VSD_TABLE_DATA:
+    case PC_VSD_TABLE_DATA:
+        val =3D xive->regs[reg];
+        break;
+
+    case CQ_MSGSND: /* Identifies which cores have msgsnd enabled.
+                     * Say all have. */
+        val =3D 0xffffff0000000000;
+        break;
+
+    /*
+     * XIVE PC & VC cache updates for IVE, VPD and EQD
+     */
+    case PC_VPC_SCRUB_TRIG:
+    case VC_IVC_SCRUB_TRIG:
+    case VC_EQC_SCRUB_TRIG:
+        xive->regs[reg] &=3D ~VC_SCRUB_VALID;
+        val =3D xive->regs[reg];
+        break;
+
+    /*
+     * XIVE PC & VC cache invalidation
+     */
+    case PC_AT_KILL:
+        xive->regs[reg] &=3D ~PC_AT_KILL_VALID;
+        val =3D xive->regs[reg];
+        break;
+    case VC_AT_MACRO_KILL:
+        xive->regs[reg] &=3D ~VC_KILL_VALID;
+        val =3D xive->regs[reg];
+        break;
+
+    /*
+     * XIVE synchronisation
+     */
+    case VC_EQC_CONFIG:
+        val =3D VC_EQC_SYNC_MASK;
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE/IC: invalid read reg=3D0x%0=
8x"
+                      " mmio=3D%d\n", offset, mmio);
+    }
+
+    return val;
+}
+
+static void pnv_xive_ic_reg_write_mmio(void *opaque, hwaddr addr,
+                                       uint64_t val, unsigned size)
+{
+    pnv_xive_ic_reg_write(opaque, addr, val, true);
+}
+
+static uint64_t pnv_xive_ic_reg_read_mmio(void *opaque, hwaddr addr,
+                                      unsigned size)
+{
+    return pnv_xive_ic_reg_read(opaque, addr, true);
+}
+
+static const MemoryRegionOps pnv_xive_ic_reg_ops =3D {
+    .read =3D pnv_xive_ic_reg_read_mmio,
+    .write =3D pnv_xive_ic_reg_write_mmio,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 8,
+        .max_access_size =3D 8,
+    },
+    .impl =3D {
+        .min_access_size =3D 8,
+        .max_access_size =3D 8,
+    },
+};
+
+/*
+ * Interrupt Controller MMIO: Notify port page (write only)
+ */
+#define PNV_XIVE_FORWARD_IPI        0x800 /* Forward IPI */
+#define PNV_XIVE_FORWARD_HW         0x880 /* Forward HW */
+#define PNV_XIVE_FORWARD_OS_ESC     0x900 /* Forward OS escalation */
+#define PNV_XIVE_FORWARD_HW_ESC     0x980 /* Forward Hyp escalation */
+#define PNV_XIVE_FORWARD_REDIS      0xa00 /* Forward Redistribution */
+#define PNV_XIVE_RESERVED5          0xa80 /* Cache line 5 PowerBUS opera=
tion */
+#define PNV_XIVE_RESERVED6          0xb00 /* Cache line 6 PowerBUS opera=
tion */
+#define PNV_XIVE_RESERVED7          0xb80 /* Cache line 7 PowerBUS opera=
tion */
+
+/* VC synchronisation */
+#define PNV_XIVE_SYNC_IPI           0xc00 /* Sync IPI */
+#define PNV_XIVE_SYNC_HW            0xc80 /* Sync HW */
+#define PNV_XIVE_SYNC_OS_ESC        0xd00 /* Sync OS escalation */
+#define PNV_XIVE_SYNC_HW_ESC        0xd80 /* Sync Hyp escalation */
+#define PNV_XIVE_SYNC_REDIS         0xe00 /* Sync Redistribution */
+
+/* PC synchronisation */
+#define PNV_XIVE_SYNC_PULL          0xe80 /* Sync pull context */
+#define PNV_XIVE_SYNC_PUSH          0xf00 /* Sync push context */
+#define PNV_XIVE_SYNC_VPC           0xf80 /* Sync remove VPC store */
+
+static void pnv_xive_ic_hw_trigger(PnvXive *xive, hwaddr addr, uint64_t =
val)
+{
+    XiveFabricClass *xfc =3D XIVE_FABRIC_GET_CLASS(xive);
+    uint32_t ive_idx, ive_blk;
+
+    /* The block Encoding on the PowerBUS is in a different bit range */
+    ive_idx =3D GIRQ_TO_IDX(val);
+    ive_blk =3D (val >> 28) & 0xf;
+    val =3D BLKIDX_TO_GIRQ(ive_blk, ive_idx);
+
+    xfc->notify(XIVE_FABRIC(xive), val);
+}
+
+static void pnv_xive_ic_notify_write(void *opaque, hwaddr addr, uint64_t=
 val,
+                                     unsigned size)
+{
+    /* VC: HW triggers */
+    switch (addr) {
+    case 0x000 ... 0x7FF:
+        pnv_xive_ic_hw_trigger(opaque, addr, val);
+        break;
+
+    /* VC: Forwarded IRQs */
+    case PNV_XIVE_FORWARD_IPI:
+    case PNV_XIVE_FORWARD_HW:
+    case PNV_XIVE_FORWARD_OS_ESC:
+    case PNV_XIVE_FORWARD_HW_ESC:
+    case PNV_XIVE_FORWARD_REDIS:
+        /* TODO: forwarded IRQs. Should be like HW triggers */
+        qemu_log_mask(LOG_UNIMP, "XIVE/IC: forwarded at @0x%"HWADDR_PRIx
+                      " IRQ 0x%"PRIx64"\n", addr, val);
+        break;
+
+    /* VC syncs */
+    case PNV_XIVE_SYNC_IPI:
+    case PNV_XIVE_SYNC_HW:
+    case PNV_XIVE_SYNC_OS_ESC:
+    case PNV_XIVE_SYNC_HW_ESC:
+    case PNV_XIVE_SYNC_REDIS:
+        break;
+
+    /* PC sync */
+    case PNV_XIVE_SYNC_PULL:
+    case PNV_XIVE_SYNC_PUSH:
+    case PNV_XIVE_SYNC_VPC:
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE/IC: invalid sync @%"
+                      HWADDR_PRIx"\n", addr);
+    }
+}
+
+static uint64_t pnv_xive_ic_notify_read(void *opaque, hwaddr addr,
+                                        unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "XIVE/IC: invalid notify read @%"
+                  HWADDR_PRIx"\n", addr);
+    return -1;
+}
+
+static const MemoryRegionOps pnv_xive_ic_notify_ops =3D {
+    .read =3D pnv_xive_ic_notify_read,
+    .write =3D pnv_xive_ic_notify_write,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 8,
+        .max_access_size =3D 8,
+    },
+    .impl =3D {
+        .min_access_size =3D 8,
+        .max_access_size =3D 8,
+    },
+};
+
+/*
+ * Interrupt controller MMIO region. The layout is compatible between
+ * 4K and 64K pages :
+ *
+ * Page 0           sub-engine BARs
+ *  0x000 - 0x3FF   IC registers
+ *  0x400 - 0x7FF   PC registers
+ *  0x800 - 0xFFF   VC registers
+ *
+ * Page 1           Notify page
+ *  0x000 - 0x7FF   HW interrupt triggers (PSI, PHB)
+ *  0x800 - 0xFFF   forwards and syncs
+ *
+ * Page 2           LSI Trigger page (writes only) (not modeled)
+ * Page 3           LSI SB EOI page (reads only) (not modeled)
+ *
+ * Page 4-7         indirect TIMA (aliased to TIMA region)
+ */
+static void pnv_xive_ic_write(void *opaque, hwaddr addr,
+                              uint64_t val, unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "XIVE/IC: invalid write @%"
+                  HWADDR_PRIx"\n", addr);
+}
+
+static uint64_t pnv_xive_ic_read(void *opaque, hwaddr addr, unsigned siz=
e)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "XIVE/IC: invalid read @%"
+                  HWADDR_PRIx"\n", addr);
+    return -1;
+}
+
+static const MemoryRegionOps pnv_xive_ic_ops =3D {
+    .read =3D pnv_xive_ic_read,
+    .write =3D pnv_xive_ic_write,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 8,
+        .max_access_size =3D 8,
+    },
+    .impl =3D {
+        .min_access_size =3D 8,
+        .max_access_size =3D 8,
+    },
+};
+
+/*
+ * Interrupt controller XSCOM region. Load accesses are nearly all
+ * done all through the MMIO region.
+ */
+static uint64_t pnv_xive_xscom_read(void *opaque, hwaddr addr, unsigned =
size)
+{
+    switch (addr >> 3) {
+    case X_VC_EQC_CONFIG:
+        /*
+         * This is the only XSCOM load done in skiboot. Bizarre. To be
+         * checked.
+         */
+        return VC_EQC_SYNC_MASK;
+    default:
+        return pnv_xive_ic_reg_read(opaque, addr, false);
+    }
+}
+
+static void pnv_xive_xscom_write(void *opaque, hwaddr addr,
+                                uint64_t val, unsigned size)
+{
+    pnv_xive_ic_reg_write(opaque, addr, val, false);
+}
+
+static const MemoryRegionOps pnv_xive_xscom_ops =3D {
+    .read =3D pnv_xive_xscom_read,
+    .write =3D pnv_xive_xscom_write,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 8,
+        .max_access_size =3D 8,
+    },
+    .impl =3D {
+        .min_access_size =3D 8,
+        .max_access_size =3D 8,
+    }
+};
+
+/*
+ * Virtualization Controller MMIO region containing the IPI ESB pages
+ * and EQ ESB pages. The region is sub-divided into "sets" which map
+ * portions of the VC region to the different ESB pages. It is
+ * configured at runtime through the EDT set translation table to let
+ * the firmware decide how to split the address space between IPI ESB
+ * pages and EQ ESB pages.
+ */
+static uint64_t pnv_xive_vc_read(void *opaque, hwaddr offset,
+                                   unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "XIVE/VC: invalid read @%"
+                  HWADDR_PRIx"\n", offset);
+
+    /* if out of scope, specs says to return all ones */
+    return -1;
+}
+
+static void pnv_xive_vc_write(void *opaque, hwaddr offset,
+                                uint64_t value, unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "XIVE/VC: invalid write @%"
+                  HWADDR_PRIx" val=3D0x%"PRIx64"\n", offset, value);
+}
+
+static const MemoryRegionOps pnv_xive_vc_ops =3D {
+    .read =3D pnv_xive_vc_read,
+    .write =3D pnv_xive_vc_write,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 8,
+        .max_access_size =3D 8,
+    },
+    .impl =3D {
+        .min_access_size =3D 8,
+        .max_access_size =3D 8,
+    },
+};
+
+/*
+ * Presenter Controller MMIO region. This is used by the Virtualization
+ * Controller to update the IPB in the VPD table when required. Not
+ * implemented yet.
+ */
+static uint64_t pnv_xive_pc_read(void *opaque, hwaddr addr,
+                                 unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "XIVE/PC: invalid read @%"HWADDR_PRIx=
"\n",
+                  addr);
+    return -1;
+}
+
+static void pnv_xive_pc_write(void *opaque, hwaddr addr,
+                              uint64_t value, unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP, "XIVE/PC: invalid write to VC @%"HWADDR_PRI=
x"\n",
+                  addr);
+}
+
+static const MemoryRegionOps pnv_xive_pc_ops =3D {
+    .read =3D pnv_xive_pc_read,
+    .write =3D pnv_xive_pc_write,
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
+void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon)
+{
+    int i;
+    XiveRouter *xrtr =3D XIVE_ROUTER(xive);
+
+    monitor_printf(mon, "IVE Table\n");
+    for (i =3D 0; i < xive->nr_irqs; i++) {
+        XiveIVE ive;
+        uint32_t lisn =3D BLKIDX_TO_GIRQ(xive->chip_id, i);
+
+        xive_router_get_ive(xrtr, lisn, &ive);
+        xive_router_print_ive(xrtr, lisn, &ive, mon);
+    }
+
+    xive_source_pic_print_info(&xive->source,
+                               BLKIDX_TO_GIRQ(xive->chip_id, 0), mon);
+}
+
+static void pnv_xive_reset(DeviceState *dev)
+{
+    PnvXive *xive =3D PNV_XIVE(dev);
+    PnvChip *chip =3D PNV_CHIP(object_property_get_link(OBJECT(dev), "ch=
ip",
+                                                      &error_fatal));
+
+    /*
+     * Use the chip id to identify the XIVE interrupt controller. It
+     * can be overriden by configuration at runtime.
+     */
+    xive->chip_id =3D xive->thread_chip_id =3D chip->chip_id;
+
+    /* Default page size. Should be changed at runtime to 64k */
+    xive->ic_shift =3D xive->vc_shift =3D xive->pc_shift =3D 12;
+
+    /*
+     * PowerNV XIVE sources are realized at runtime when the set
+     * translation tables are configured.
+     */
+    if (DEVICE(&xive->source)->realized) {
+        object_property_set_bool(OBJECT(&xive->source), false, "realized=
",
+                                 &error_fatal);
+    }
+
+    if (DEVICE(&xive->eq_source)->realized) {
+        object_property_set_bool(OBJECT(&xive->eq_source), false, "reali=
zed",
+                                 &error_fatal);
+    }
+}
+
+/*
+ * The VC sub-engine incorporates a source controller for the IPIs
+ * which forward event notification to the router.
+ */
+static void pnv_xive_notify(XiveFabric *xf, uint32_t srcno)
+{
+    PnvXive *xive =3D PNV_XIVE(xf);
+
+    xive_router_notify(xf, BLKIDX_TO_GIRQ(xive->chip_id, srcno));
+}
+
+static void pnv_xive_init(Object *obj)
+{
+    PnvXive *xive =3D PNV_XIVE(obj);
+
+    object_initialize(&xive->source, sizeof(xive->source), TYPE_XIVE_SOU=
RCE);
+    object_property_add_child(obj, "source", OBJECT(&xive->source), NULL=
);
+
+    object_initialize(&xive->eq_source, sizeof(xive->eq_source),
+                      TYPE_XIVE_EQ_SOURCE);
+    object_property_add_child(obj, "eq_source", OBJECT(&xive->eq_source)=
, NULL);
+}
+
+static void pnv_xive_realize(DeviceState *dev, Error **errp)
+{
+    PnvXive *xive =3D PNV_XIVE(dev);
+    Object *obj;
+    Error *err =3D NULL;
+    PnvChip *chip;
+
+    obj =3D object_property_get_link(OBJECT(dev), "chip", &err);
+    if (!obj) {
+        error_propagate(errp, err);
+        error_prepend(errp, "required link 'chip' not found: ");
+        return;
+    }
+    chip =3D PNV_CHIP(obj);
+
+    /* Default page size. Should be changed at runtime to 64k */
+    xive->ic_shift =3D xive->vc_shift =3D xive->pc_shift =3D 12;
+
+    /* XSCOM region, used for initial configuration of the BARs */
+    memory_region_init_io(&xive->xscom_regs, OBJECT(dev), &pnv_xive_xsco=
m_ops,
+                          xive, "xscom-xive", PNV_XSCOM_XIVE_SIZE << 3);
+
+    /* Interrupt controller MMIO region */
+    memory_region_init_io(&xive->ic_mmio, OBJECT(dev), &pnv_xive_ic_ops,=
 xive,
+                          "xive.ic", PNV_XIVE_IC_SIZE(chip));
+    memory_region_init_io(&xive->ic_reg_mmio, OBJECT(dev), &pnv_xive_ic_=
reg_ops,
+                          xive, "xive.ic.reg", 1 << xive->ic_shift);
+    memory_region_init_io(&xive->ic_notify_mmio, OBJECT(dev),
+                          &pnv_xive_ic_notify_ops,
+                          xive, "xive.ic.notify", 1 << xive->ic_shift);
+
+    /* The Pervasive LSI trigger and EOI pages are not modeled */
+
+    /*
+     * Overall Virtualization Controller MMIO region containing the
+     * IPI ESB pages and EQ ESB pages. The layout is defined by the
+     * EDT set translation table.
+     */
+    memory_region_init_io(&xive->vc_mmio, OBJECT(xive), &pnv_xive_vc_ops=
, xive,
+                          "xive.vc", PNV_XIVE_VC_SIZE(chip));
+
+    /* Presenter Controller MMIO region (not used for the moment) */
+    memory_region_init_io(&xive->pc_mmio, OBJECT(xive), &pnv_xive_pc_ops=
, xive,
+                          "xive.pc", PNV_XIVE_PC_SIZE(chip));
+
+    /* Thread Interrupt Management Area, direct an indirect */
+    memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_ops,
+                          &xive->cpu_ind, "xive.tima", PNV_XIVE_TM_SIZE(=
chip));
+    memory_region_init_alias(&xive->tm_mmio_indirect, OBJECT(xive),
+                             "xive.tima.indirect",
+                             &xive->tm_mmio, 0, PNV_XIVE_TM_SIZE(chip));
+}
+
+static int pnv_xive_dt_xscom(PnvXScomInterface *dev, void *fdt,
+                             int xscom_offset)
+{
+    const char compat[] =3D "ibm,power9-xive-x";
+    char *name;
+    int offset;
+    uint32_t lpc_pcba =3D PNV_XSCOM_XIVE_BASE;
+    uint32_t reg[] =3D {
+        cpu_to_be32(lpc_pcba),
+        cpu_to_be32(PNV_XSCOM_XIVE_SIZE)
+    };
+
+    name =3D g_strdup_printf("xive@%x", lpc_pcba);
+    offset =3D fdt_add_subnode(fdt, xscom_offset, name);
+    _FDT(offset);
+    g_free(name);
+
+    _FDT((fdt_setprop(fdt, offset, "reg", reg, sizeof(reg))));
+    _FDT((fdt_setprop(fdt, offset, "compatible", compat,
+                      sizeof(compat))));
+    return 0;
+}
+
+static Property pnv_xive_properties[] =3D {
+    DEFINE_PROP_UINT64("ic-bar", PnvXive, ic_base, 0),
+    DEFINE_PROP_UINT64("vc-bar", PnvXive, vc_base, 0),
+    DEFINE_PROP_UINT64("pc-bar", PnvXive, pc_base, 0),
+    DEFINE_PROP_UINT64("tm-bar", PnvXive, tm_base, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void pnv_xive_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    PnvXScomInterfaceClass *xdc =3D PNV_XSCOM_INTERFACE_CLASS(klass);
+    XiveRouterClass *xrc =3D XIVE_ROUTER_CLASS(klass);
+    XiveFabricClass *xfc =3D XIVE_FABRIC_CLASS(klass);
+
+    xdc->dt_xscom =3D pnv_xive_dt_xscom;
+
+    dc->desc =3D "PowerNV XIVE Interrupt Controller";
+    dc->realize =3D pnv_xive_realize;
+    dc->props =3D pnv_xive_properties;
+    dc->reset =3D pnv_xive_reset;
+
+    xrc->get_ive =3D pnv_xive_get_ive;
+    xrc->set_ive =3D pnv_xive_set_ive;
+    xrc->get_eq  =3D pnv_xive_get_eq;
+    xrc->set_eq  =3D pnv_xive_set_eq;
+    xrc->get_vp  =3D pnv_xive_get_vp;
+    xrc->set_vp  =3D pnv_xive_set_vp;
+
+    xfc->notify  =3D pnv_xive_notify;
+};
+
+static const TypeInfo pnv_xive_info =3D {
+    .name          =3D TYPE_PNV_XIVE,
+    .parent        =3D TYPE_XIVE_ROUTER,
+    .instance_init =3D pnv_xive_init,
+    .instance_size =3D sizeof(PnvXive),
+    .class_init    =3D pnv_xive_class_init,
+    .interfaces    =3D (InterfaceInfo[]) {
+        { TYPE_PNV_XSCOM_INTERFACE },
+        { }
+    }
+};
+
+static void pnv_xive_register_types(void)
+{
+    type_register_static(&pnv_xive_info);
+}
+
+type_init(pnv_xive_register_types)
+
+void pnv_chip_xive_realize(PnvChip *chip, Error **errp)
+{
+    Object *obj;
+    Error *local_err =3D NULL;
+
+    obj =3D object_new(TYPE_PNV_XIVE);
+    qdev_set_parent_bus(DEVICE(obj), sysbus_get_default());
+
+    object_property_add_child(OBJECT(chip), "xive", obj, &error_abort);
+    object_property_add_const_link(obj, "chip", OBJECT(chip), &error_abo=
rt);
+    object_property_set_int(obj, PNV_XIVE_IC_BASE(chip), "ic-bar",
+                            &error_fatal);
+    object_property_set_int(obj, PNV_XIVE_VC_BASE(chip), "vc-bar",
+                            &error_fatal);
+    object_property_set_int(obj, PNV_XIVE_PC_BASE(chip), "pc-bar",
+                            &error_fatal);
+    object_property_set_int(obj, PNV_XIVE_TM_BASE(chip), "tm-bar",
+                            &error_fatal);
+    object_property_set_bool(obj, true, "realized", &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    chip->xive =3D PNV_XIVE(obj);
+
+    pnv_xscom_add_subregion(chip, PNV_XSCOM_XIVE_BASE,
+                            &chip->xive->xscom_regs);
+}
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 4d073c37bbda..66141028ef80 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -51,6 +51,8 @@ static uint8_t exception_mask(uint8_t ring)
     switch (ring) {
     case TM_QW1_OS:
         return TM_QW1_NSR_EO;
+    case TM_QW3_HV_PHYS:
+        return TM_QW3_NSR_HE;
     default:
         g_assert_not_reached();
     }
@@ -85,7 +87,17 @@ static void xive_tctx_notify(XiveTCTX *tctx, uint8_t r=
ing)
     uint8_t *regs =3D &tctx->regs[ring];
=20
     if (regs[TM_PIPR] < regs[TM_CPPR]) {
-        regs[TM_NSR] |=3D exception_mask(ring);
+        switch (ring) {
+        case TM_QW1_OS:
+            regs[TM_NSR] |=3D TM_QW1_NSR_EO;
+            break;
+        case TM_QW3_HV_PHYS:
+            regs[TM_NSR] |=3D SETFIELD(TM_QW3_NSR_HE, regs[TM_NSR],
+                                     TM_QW3_NSR_HE_PHYS);
+            break;
+        default:
+            g_assert_not_reached();
+        }
         qemu_irq_raise(tctx->output);
     }
 }
@@ -116,6 +128,38 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8=
_t ring, uint8_t cppr)
 #define XIVE_TM_OS_PAGE   0x2
 #define XIVE_TM_USER_PAGE 0x3
=20
+static void xive_tm_set_hv_cppr(XiveTCTX *tctx, hwaddr offset,
+                                uint64_t value, unsigned size)
+{
+    xive_tctx_set_cppr(tctx, TM_QW3_HV_PHYS, value & 0xff);
+}
+
+static uint64_t xive_tm_ack_hv_reg(XiveTCTX *tctx, hwaddr offset, unsign=
ed size)
+{
+    return xive_tctx_accept(tctx, TM_QW3_HV_PHYS);
+}
+
+static uint64_t xive_tm_pull_pool_ctx(XiveTCTX *tctx, hwaddr offset,
+                                      unsigned size)
+{
+    uint64_t ret;
+
+    ret =3D tctx->regs[TM_QW2_HV_POOL + TM_WORD2] & TM_QW2W2_POOL_CAM;
+    tctx->regs[TM_QW2_HV_POOL + TM_WORD2] &=3D ~TM_QW2W2_POOL_CAM;
+    return ret;
+}
+
+static void xive_tm_vt_push(XiveTCTX *tctx, hwaddr offset,
+                            uint64_t value, unsigned size)
+{
+    tctx->regs[TM_QW3_HV_PHYS + TM_WORD2] =3D value & 0xff;
+}
+
+static uint64_t xive_tm_vt_poll(XiveTCTX *tctx, hwaddr offset, unsigned =
size)
+{
+    return tctx->regs[TM_QW3_HV_PHYS + TM_WORD2] & 0xff;
+}
+
 /*
  * Define an access map for each page of the TIMA that we will use in
  * the memory region ops to filter values when doing loads and stores
@@ -295,10 +339,16 @@ static const XiveTmOp xive_tm_operations[] =3D {
      * effects
      */
     { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,   1, xive_tm_set_os_cppr, NU=
LL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR, 1, xive_tm_set_hv_cppr,=
 NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push, NU=
LL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL, xive_tm_vt_po=
ll },
=20
     /* MMIOs above 2K : special operations with side effects */
     { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,     2, NULL, xive_tm_ack_os_re=
g },
     { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING, 1, xive_tm_set_os_pending,=
 NULL },
+    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,     2, NULL, xive_tm_ack_hv_re=
g },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,  4, NULL, xive_tm_pull_pool=
_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,  8, NULL, xive_tm_pull_pool=
_ctx },
 };
=20
 static const XiveTmOp *xive_tm_find_op(hwaddr offset, unsigned size, boo=
l write)
@@ -327,7 +377,8 @@ static const XiveTmOp *xive_tm_find_op(hwaddr offset,=
 unsigned size, bool write)
 static void xive_tm_write(void *opaque, hwaddr offset,
                           uint64_t value, unsigned size)
 {
-    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
+    PowerPCCPU **cpuptr =3D opaque;
+    PowerPCCPU *cpu =3D *cpuptr ? *cpuptr : POWERPC_CPU(current_cpu);
     XiveTCTX *tctx =3D XIVE_TCTX(cpu->intc);
     const XiveTmOp *xto;
=20
@@ -366,7 +417,8 @@ static void xive_tm_write(void *opaque, hwaddr offset=
,
=20
 static uint64_t xive_tm_read(void *opaque, hwaddr offset, unsigned size)
 {
-    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
+    PowerPCCPU **cpuptr =3D opaque;
+    PowerPCCPU *cpu =3D *cpuptr ? *cpuptr : POWERPC_CPU(current_cpu);
     XiveTCTX *tctx =3D XIVE_TCTX(cpu->intc);
     const XiveTmOp *xto;
=20
@@ -508,6 +560,9 @@ static void xive_tctx_reset(void *dev)
      */
     tctx->regs[TM_QW1_OS + TM_PIPR] =3D
         ipb_to_pipr(tctx->regs[TM_QW1_OS + TM_IPB]);
+    tctx->regs[TM_QW3_HV_PHYS + TM_PIPR] =3D
+        ipb_to_pipr(tctx->regs[TM_QW3_HV_PHYS + TM_IPB]);
+
=20
     /* The OS CAM is pushed by the hypervisor when the VP is scheduled
      * to run on a HW thread. On QEMU, when running a pseries machine,
@@ -1488,7 +1543,7 @@ static void xive_router_eq_notify(XiveRouter *xrtr,=
 uint8_t eq_blk,
     /* TODO: Auto EOI. */
 }
=20
-static void xive_router_notify(XiveFabric *xf, uint32_t lisn)
+void xive_router_notify(XiveFabric *xf, uint32_t lisn)
 {
     XiveRouter *xrtr =3D XIVE_ROUTER(xf);
     XiveIVE ive;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index e7bc4534e63d..447480558fdb 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -301,7 +301,10 @@ static void pnv_dt_chip(PnvChip *chip, void *fdt)
         pnv_dt_core(chip, pnv_core, fdt);
=20
         /* Interrupt Control Presenters (ICP). One per core. */
-        pnv_dt_icp(chip, fdt, pnv_core->pir, CPU_CORE(pnv_core)->nr_thre=
ads);
+        if (!pnv_chip_is_power9(chip)) {
+            pnv_dt_icp(chip, fdt, pnv_core->pir,
+                       CPU_CORE(pnv_core)->nr_threads);
+        }
     }
=20
     if (chip->ram_size) {
@@ -777,6 +780,10 @@ static void pnv_chip_power8nvl_class_init(ObjectClas=
s *klass, void *data)
  */
 static const PnvPhysMapEntry pnv_chip_power9_phys_map[] =3D {
     [PNV_MAP_XSCOM]     =3D { 0x000603fc00000000ull, 0x0000000400000000u=
ll },
+    [PNV_MAP_XIVE_VC]   =3D { 0x0006010000000000ull, 0x0000008000000000u=
ll },
+    [PNV_MAP_XIVE_PC]   =3D { 0x0006018000000000ull, 0x0000001000000000u=
ll },
+    [PNV_MAP_XIVE_IC]   =3D { 0x0006030203100000ull, 0x0000000000080000u=
ll },
+    [PNV_MAP_XIVE_TM]   =3D { 0x0006030203180000ull, 0x0000000000040000u=
ll },
 };
=20
 /* Each chip has a 4TB range for its MMIOs */
@@ -908,6 +915,15 @@ static void pnv_chip_realize(DeviceState *dev, Error=
 **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(chip), 0, PNV_XSCOM_BASE(chip));
=20
+    /* XIVE Interrupt Controller on P9 (before the cores) */
+    if (pnv_chip_is_power9(chip)) {
+        pnv_chip_xive_realize(chip, &error);
+        if (error) {
+            error_propagate(errp, error);
+            return;
+        }
+    }
+
     /* Cores */
     pnv_chip_core_sanitize(chip, &error);
     if (error) {
@@ -940,6 +956,8 @@ static void pnv_chip_realize(DeviceState *dev, Error =
**errp)
                                 "pir", &error_fatal);
         object_property_add_const_link(OBJECT(pnv_core), "xics",
                                        qdev_get_machine(), &error_fatal)=
;
+        object_property_add_const_link(OBJECT(pnv_core), "chip",
+                                       OBJECT(chip), &error_fatal);
         object_property_set_bool(OBJECT(pnv_core), true, "realized",
                                  &error_fatal);
         object_unref(OBJECT(pnv_core));
@@ -963,10 +981,12 @@ static void pnv_chip_realize(DeviceState *dev, Erro=
r **errp)
=20
     /* Interrupt Management Area. This is the memory region holding
      * all the Interrupt Control Presenter (ICP) registers */
-    pnv_chip_icp_realize(chip, &error);
-    if (error) {
-        error_propagate(errp, error);
-        return;
+    if (!pnv_chip_is_power9(chip)) {
+        pnv_chip_icp_realize(chip, &error);
+        if (error) {
+            error_propagate(errp, error);
+            return;
+        }
     }
=20
     /* Processor Service Interface (PSI) Host Bridge */
@@ -1047,11 +1067,19 @@ static void pnv_pic_print_info(InterruptStatsProv=
ider *obj,
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
=20
-        icp_pic_print_info(ICP(cpu->intc), mon);
+        if (!pnv_is_power9(pnv)) {
+            icp_pic_print_info(ICP(cpu->intc), mon);
+        } else {
+            xive_tctx_pic_print_info(XIVE_TCTX(cpu->intc), mon);
+        }
     }
=20
     for (i =3D 0; i < pnv->num_chips; i++) {
-        ics_pic_print_info(&pnv->chips[i]->psi.ics, mon);
+        if (!pnv_is_power9(pnv)) {
+            ics_pic_print_info(&pnv->chips[i]->psi.ics, mon);
+        } else {
+            pnv_xive_pic_print_info(pnv->chips[i]->xive, mon);
+        }
     }
 }
=20
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index cbb64ad9e7e0..3a8d55342308 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -121,11 +121,13 @@ static const MemoryRegionOps pnv_core_xscom_ops =3D=
 {
     .endianness =3D DEVICE_BIG_ENDIAN,
 };
=20
-static void pnv_core_realize_child(Object *child, XICSFabric *xi, Error =
**errp)
+static void pnv_core_realize_child(Object *child, XICSFabric *xi, PnvChi=
p *chip,
+                                   Error **errp)
 {
     Error *local_err =3D NULL;
     CPUState *cs =3D CPU(child);
     PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+    PnvMachineState *pnv =3D PNV_MACHINE(xi);
=20
     object_property_set_bool(child, true, "realized", &local_err);
     if (local_err) {
@@ -133,13 +135,18 @@ static void pnv_core_realize_child(Object *child, X=
ICSFabric *xi, Error **errp)
         return;
     }
=20
-    cpu->intc =3D icp_create(child, TYPE_PNV_ICP, xi, &local_err);
+    pnv_cpu_init(cpu, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
=20
-    pnv_cpu_init(cpu, &local_err);
+    if (!pnv_is_power9(pnv)) {
+        cpu->intc =3D icp_create(child, TYPE_PNV_ICP, xi, &local_err);
+    } else {
+        cpu->intc =3D xive_tctx_create(child, TYPE_XIVE_TCTX,
+                                     XIVE_ROUTER(chip->xive), &local_err=
);
+    }
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -157,11 +164,19 @@ static void pnv_core_realize(DeviceState *dev, Erro=
r **errp)
     int i, j;
     char name[32];
     Object *xi;
+    Object *chip;
=20
     xi =3D object_property_get_link(OBJECT(dev), "xics", &local_err);
     if (!xi) {
-        error_setg(errp, "%s: required link 'xics' not found: %s",
-                   __func__, error_get_pretty(local_err));
+        error_propagate(errp, local_err);
+        error_prepend(errp, "required link 'xics' not found: ");
+        return;
+    }
+
+    chip =3D object_property_get_link(OBJECT(dev), "chip", &local_err);
+    if (!chip) {
+        error_propagate(errp, local_err);
+        error_prepend(errp, "required link 'chip' not found: ");
         return;
     }
=20
@@ -184,7 +199,8 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
     for (j =3D 0; j < cc->nr_threads; j++) {
         obj =3D pc->threads + j * size;
=20
-        pnv_core_realize_child(obj, XICS_FABRIC(xi), &local_err);
+        pnv_core_realize_child(obj, XICS_FABRIC(xi), PNV_CHIP(chip),
+                               &local_err);
         if (local_err) {
             goto err;
         }
diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index dd4d69db2bdd..145bfaf44014 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -40,7 +40,7 @@ obj-$(CONFIG_XICS_KVM) +=3D xics_kvm.o
 obj-$(CONFIG_XIVE) +=3D xive.o
 obj-$(CONFIG_XIVE_SPAPR) +=3D spapr_xive.o spapr_xive_hcall.o
 obj-$(CONFIG_XIVE_KVM) +=3D spapr_xive_kvm.o
-obj-$(CONFIG_POWERNV) +=3D xics_pnv.o
+obj-$(CONFIG_POWERNV) +=3D xics_pnv.o pnv_xive.o
 obj-$(CONFIG_ALLWINNER_A10_PIC) +=3D allwinner-a10-pic.o
 obj-$(CONFIG_S390_FLIC) +=3D s390_flic.o
 obj-$(CONFIG_S390_FLIC_KVM) +=3D s390_flic_kvm.o
--=20
2.13.6
