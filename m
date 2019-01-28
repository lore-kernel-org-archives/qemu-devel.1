Received: from eggs.gnu.org ([209.51.188.92]:38280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3VA-00050U-17
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:46:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3V9-0002kT-2J
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:46:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51954
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1go3V7-0002hr-U9
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:46:46 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0S9hnfM002645
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:46:44 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q9x59udmp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:46:43 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Mon, 28 Jan 2019 09:46:42 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 28 Jan 2019 10:46:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190128094625.4428-1-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/19] ppc: support for the baremetal XIVE
 interrupt controller (POWER9)
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

Here is a series adding support for the XIVE interrupt controller as
found on POWER9 PowerNV mchines. It includes models for the baremetal
IC itself and a set of fixes and extensions of the POWER9 core
provided by Ben.

Thanks,

C.

Changes in v1 (since PnvXive was last sent) :

 - made more use of the register values instead of caching them under
   PnvXive
 - generalized the VST accessors.
 - reworked indirect accesses to the TIMA with a custom get_tctx()
   method
 - fixed the translation table definitions
 - XiveSource and XiveENDSource objects are now sized to the maximum
   allowed by HW and the memory regions exposing the ESB pages are
   resized at runtime when the firmware configures the controller.
 - included changes from Ben on the POWER9 core model to fix power
   management instructions, add support for sreset and the HV
   interrupt line


Benjamin Herrenschmidt (14):
  target/ppc: Remove some #if 0'ed code
  target/ppc: Make special ORs match x86 pause and don't generate on
    mttcg
  target/ppc: Fix nip on power management instructions
  target/ppc: Don't clobber MSR:EE on PM instructions
  target/ppc: Fix support for "STOP light" states on POWER9
  target/ppc: Move "wakeup reset" code to a separate function
  target/ppc: Disable ISA 2.06 PM instructions on POWER9
  target/ppc: Rename "in_pm_state" to "resume_as_sreset"
  target/ppc: Add POWER9 exception model
  target/ppc: Detect erroneous condition in interrupt delivery
  target/ppc: Add Hypervisor Virtualization Interrupt on POWER9
  target/ppc: Add POWER9 external interrupt model
  ppc/xive: Make XIVE generate the proper interrupt types
  target/ppc: Add support for LPCR:HEIC on POWER9

C=C3=A9dric Le Goater (5):
  ppc/xive: hardwire the Physical CAM line of the thread context
  ppc: externalize ppc_get_vcpu_by_pir()
  xive: extend the XiveRouter get_tctx() method with the page offset
  ppc/pnv: xive: export the TIMA memory accessors
  ppc/pnv: add XIVE support

 hw/intc/pnv_xive_regs.h         |  315 ++++++
 include/hw/ppc/pnv.h            |   21 +
 include/hw/ppc/pnv_core.h       |    1 +
 include/hw/ppc/pnv_xive.h       |   95 ++
 include/hw/ppc/pnv_xscom.h      |    3 +
 include/hw/ppc/ppc.h            |    3 +
 include/hw/ppc/xive.h           |   12 +-
 target/ppc/cpu-qom.h            |    5 +
 target/ppc/cpu.h                |   26 +-
 hw/intc/pnv_xive.c              | 1698 +++++++++++++++++++++++++++++++
 hw/intc/spapr_xive.c            |    3 +-
 hw/intc/xics.c                  |    1 +
 hw/intc/xive.c                  |  167 ++-
 hw/ppc/pnv.c                    |   84 +-
 hw/ppc/pnv_core.c               |   16 +-
 hw/ppc/ppc.c                    |   32 +-
 target/ppc/excp_helper.c        |  176 ++--
 target/ppc/mmu_helper.c         |   12 -
 target/ppc/translate.c          |   34 +-
 target/ppc/translate_init.inc.c |   36 +-
 hw/intc/Makefile.objs           |    2 +-
 21 files changed, 2593 insertions(+), 149 deletions(-)
 create mode 100644 hw/intc/pnv_xive_regs.h
 create mode 100644 include/hw/ppc/pnv_xive.h
 create mode 100644 hw/intc/pnv_xive.c

--=20
2.20.1
