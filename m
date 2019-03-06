Received: from eggs.gnu.org ([209.51.188.92]:54729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SGU-0005zP-GR
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SGQ-0001J1-7V
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55926
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h1SGP-0001CI-NF
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:50:58 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x268mkLn030551
	for <qemu-devel@nongnu.org>; Wed, 6 Mar 2019 03:50:47 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r29dadr77-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 03:50:47 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Wed, 6 Mar 2019 08:50:45 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  6 Mar 2019 09:50:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190306085032.15744-1-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/27] ppc: add POWER9 support to the PowerNV
 platform
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

Here is a series adding support for the POWER9 processor to the
PowerNV machine. It includes models for the baremetal POWER9 Interrupt
controller (XIVE), the PSI host bridge, the LPC controller, and a
minimalist OCC. It should bring the POWER9 PowerNV platform to the
same level as POWER8, that is without PHBs.

A new skiboot image is not provided yet because I would like first to
have a tagged version of skiboot including the recent changes removing
support for DD1. Will come later.

Thanks,

C.

Changes in v1 (since PnvXive was last sent) :

 - fixed compilation on clang (forward declarations)
=20
 - simplified the hardwiring of the Physical CAM line. removed the
   'hw-cam' property.=20
 - removed 'hwaddr offset' from the get_tctx() XiveRouter handler. It
   was a misunderstanding of the PC_THREAD_EN_REGx registers.
 - changed the CPU machine_data presenter type to 'Object *' to accept
   XiveTCTX
 - introduced a new dt_populate() operation to the chip model
 - introduced a new pic_print_info() operation to the chip model
 - removed 'chip_id' from PnvXive.
 - removed 'nr_irqs' and 'nr_ends' from PnvXive. Values are now
   calculated from the VST settings done by FW.  =20
 - removed 'type' field from the XiveVstInfo struct describing the VSTs
 - simplified pnv_xive_get_ic() grabbing a remote IC
 - introduced a pnv_xive_vst_size() helper computing the size of a VST
   table, direct or indirect. Used to computed the number of virtual
   structures entries provisioned by FW.
 - reworked pnv_xive_vst_addr_*() helpers. Fixed a bug when multiple
   pages are in use.
 - took into account the word_number when doing stores of the virtual
   structures.
 - the IPI and the END sub memory regions of the VC BAR are now
   resized and mapped when the EDT is configured, depending on how the
   VC region was segmented.
 - the XiveSource and the XiveENDSource memory regions are now resized
   and mapped when the VST are configured, depending on how much
   virtual structures entries were provisioned by FW.
 - removed PC_GCONF_CHIPID_OVR handling. Was for debug according to HW
   designers. xive->chip->chip_id is now used as the block id when
   needed.
 - reworked pic_print_info() to use the number of virtual structures
   entries provisioned by FW.

What has not changed (since PnvXive was sent) :

 - GETFIELD/SETFIELD macros. It would break the compatibility with
   skiboot in the register definitions. Still needs some thinking to
   find a common ground. P10 material for QEMU and skiboot probably.
 - The HW interface of XIVE is still bound to the register array. P10
   support will determine which is the best approach.
=20
Benjamin Herrenschmidt (1):
  ppc/xive: Make XIVE generate the proper interrupt types

C=C3=A9dric Le Goater (26):
  ppc/xive: hardwire the Physical CAM line of the thread context
  ppc: externalize ppc_get_vcpu_by_pir()
  ppc/xive: export the TIMA memory accessors
  ppc/pnv: export the xive_router_notify() routine
  ppc/pnv: change the CPU machine_data presenter type to Object *
  ppc/pnv: add a XIVE interrupt controller model for POWER9
  ppc/pnv: introduce a new dt_populate() operation to the chip model
  ppc/pnv: introduce a new pic_print_info() operation to the chip model
  ppc/xive: activate HV support
  ppc/pnv: fix logging primitives using Ox
  ppc/pnv: psi: add a PSIHB_REG macro
  ppc/pnv: psi: add a reset handler
  ppc/pnv: add a PSI bridge model class
  ppc/pnv: add a PSI bridge model for POWER9
  ppc/pnv: lpc: fix OPB address ranges
  ppc/pnv: add a LPC Controller model class
  ppc/pnv: add a LPC Controller model for POWER9
  ppc/pnv: add SerIRQ routing registers
  ppc/pnv: add a OCC model class
  ppc/pnv: add a OCC model for POWER9
  ppc/pnv: extend XSCOM core support for POWER9
  ppc/pnv: POWER9 XSCOM quad support
  ppc/pnv: activate XSCOM tests for POWER9
  ppc/pnv: add more dummy XSCOM addresses
  ppc/pnv: add a "ibm,opal/power-mgt" device tree node on POWER9
  target/ppc: add HV support for POWER9

 hw/intc/pnv_xive_regs.h         |  248 +++++
 include/hw/ppc/pnv.h            |   38 +
 include/hw/ppc/pnv_core.h       |   12 +-
 include/hw/ppc/pnv_lpc.h        |   28 +
 include/hw/ppc/pnv_occ.h        |   18 +
 include/hw/ppc/pnv_psi.h        |   45 +-
 include/hw/ppc/pnv_xive.h       |   93 ++
 include/hw/ppc/pnv_xscom.h      |   21 +-
 include/hw/ppc/ppc.h            |    1 +
 include/hw/ppc/xive.h           |    7 +-
 hw/intc/pnv_xive.c              | 1753 +++++++++++++++++++++++++++++++
 hw/intc/xive.c                  |  135 ++-
 hw/ppc/pnv.c                    |  236 ++++-
 hw/ppc/pnv_core.c               |  111 +-
 hw/ppc/pnv_lpc.c                |  316 +++++-
 hw/ppc/pnv_occ.c                |   63 +-
 hw/ppc/pnv_psi.c                |  414 +++++++-
 hw/ppc/pnv_xscom.c              |   33 +-
 hw/ppc/ppc.c                    |   16 +
 target/ppc/translate_init.inc.c |    3 +-
 tests/pnv-xscom-test.c          |    2 -
 hw/intc/Makefile.objs           |    2 +-
 22 files changed, 3471 insertions(+), 124 deletions(-)
 create mode 100644 hw/intc/pnv_xive_regs.h
 create mode 100644 include/hw/ppc/pnv_xive.h
 create mode 100644 hw/intc/pnv_xive.c

--=20
2.20.1
