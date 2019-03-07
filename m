Received: from eggs.gnu.org ([209.51.188.92]:34120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h21d4-0007Jf-V4
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:36:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h21d2-000322-Ms
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:36:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50988
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h21cx-0001ya-W0
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:36:36 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x27MIlmg018646
	for <qemu-devel@nongnu.org>; Thu, 7 Mar 2019 17:36:00 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r39urxmjt-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 17:36:00 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Thu, 7 Mar 2019 22:35:58 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Mar 2019 23:35:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190307223548.20516-1-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/15] ppc: add POWER9 support to the
 PowerNV platform
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

Here is the second round of the patchset adding support for the POWER9
processor to the PowerNV machine. It includes POWER9 models for the
PSI host bridge, the LPC controller, and a minimalist OCC, some
extensions of the CPU core model to support POWER9 XSCOM addresses and
a new PnvQuad model controlling the power management state of group of
four cores on a POWER9 processor.

It should bring the POWER9 PowerNV platform to the same level as
POWER8, that is without PHBs.

A new skiboot image is not provided yet because I would like first to
have a tagged version of skiboot including the recent changes removing
support for DD1. Will come later.

Hopefully, this is good enough for QEMU 4.0.

Thanks,

C.

Changes in v2 :

 - introduced Pnv8Psi (XICS) and Pnv9Psi (XIVE) models
 - wrote a commit log for the changes in the LPC register ranges
 - added a 'dt_isa_nodename' to the chip
 - added new attributes to define XSCOM operations per CPU family and=20
   a PSI IRQ number in the OCC class model
 - added a new attribute to define XSCOM operations per CPU family
   in the CPU core class model

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

C=C3=A9dric Le Goater (15):
  ppc/pnv: add a PSI bridge class model
  ppc/pnv: add a PSI bridge model for POWER9
  ppc/pnv: lpc: fix OPB address ranges
  ppc/pnv: add a LPC Controller class model
  ppc/pnv: add a 'dt_isa_nodename' to the chip
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

 include/hw/ppc/pnv.h            |  19 +-
 include/hw/ppc/pnv_core.h       |  12 +
 include/hw/ppc/pnv_lpc.h        |  26 ++
 include/hw/ppc/pnv_occ.h        |  17 ++
 include/hw/ppc/pnv_psi.h        |  59 ++++-
 include/hw/ppc/pnv_xscom.h      |  18 +-
 hw/ppc/pnv.c                    | 134 +++++++++--
 hw/ppc/pnv_core.c               | 187 ++++++++++++++-
 hw/ppc/pnv_lpc.c                | 306 +++++++++++++++++++++---
 hw/ppc/pnv_occ.c                | 127 ++++++++--
 hw/ppc/pnv_psi.c                | 404 ++++++++++++++++++++++++++++++--
 hw/ppc/pnv_xscom.c              |  33 ++-
 target/ppc/translate_init.inc.c |   3 +-
 tests/pnv-xscom-test.c          |   2 -
 14 files changed, 1231 insertions(+), 116 deletions(-)

--=20
2.20.1
