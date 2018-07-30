Received: from eggs.gnu.org ([2001:4830:134:3::10]:53170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fkBo9-0005Kr-Cb
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 13:18:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fkBo4-00080t-26
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 13:18:08 -0400
Received: from 4.mo3.mail-out.ovh.net ([178.33.46.10]:42840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fkBo3-00080Y-RG
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 13:18:03 -0400
Received: from player795.ha.ovh.net (unknown [10.109.146.240])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 1D0A01C3554
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 19:18:02 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 30 Jul 2018 19:17:47 +0200
Message-Id: <20180730171748.18562-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/1] ppc/pnv: Add model for Power8 PHB3 PCIe
 Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Andrea Bolognani <abologna@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

This is a model of the PCIe Host Bridge (PHB3) controller found on a
Power8 processor. The Power8 processor comes in different flavors:
Venice, Murano, Naple, each having a different number of PHBs. Multi
chip is supported, each chip adding its set of PHB3 controllers.

There is no default device layout and PCI devices should be added to
the machine using command line options such as :

  -device e1000e,netdev=3Dnet0,mac=3DC0:FF:EE:00:00:02,bus=3Dpcie.0,addr=3D=
0x0
  -netdev bridge,id=3Dnet0,helper=3D/usr/libexec/qemu-bridge-helper,br=3D=
virbr0,id=3Dhostnet0

  -device megasas,id=3Dscsi0,bus=3Dpcie.1,addr=3D0x0
  -drive file=3D$disk,if=3Dnone,id=3Ddrive-scsi0-0-0-0,format=3Dqcow2,cac=
he=3Dnone
  -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=3Dd=
rive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D2

Git tree available here for testing, based on David's branch:

	https://github.com/legoater/qemu/tree/phb3-3.0

Thanks,

C.

Changes since v2 :

 - kept user creatable PHB3 for later.
 - machine: the default number of PHBs is set to 3 per chip.
 - refreshed the PnvPHB3 object hierarchy with PCIe objects
 - introduced a static PCIe Root Port object under the PHB3 host
   bridge object
 - cleanup the register definitions to fit skiboot current ones
 - introduced a phb3_error() helper routine
 - fixed mask in pnv_phb3_config_write()
 - reworked init and realize routine of PnvPHB3
 - removed the creation of a default PCI bridge under the Root Port
 - simplified the PnvPHB3 properties using the DEFINE_PROP_UINT32 macros
 - MSI: fixed a resend error when P|Q was set
=20
What did not change since v2 :

 - the MMIO ops are still the same. The controller has many registers,
   more or less 150, and the current model works well enough not to
   pollute the read/write ops.

Changes since v1 :

 - removed duplication of macros for the register definitions
 - fixed multi chip support
 - introduced a chip class attribute to create all possible PHB3
   devices
 - introduced property handlers to check the validity of the phb index
   and the chip id
 - explored user creatable PHB3 devices


Benjamin Herrenschmidt (1):
  ppc/pnv: Add model for Power8 PHB3 PCIe Host bridge

 default-configs/ppc64-softmmu.mak   |    1 +
 include/hw/pci-host/pnv_phb3.h      |  171 ++++
 include/hw/pci-host/pnv_phb3_regs.h |  432 ++++++++++
 include/hw/ppc/pnv.h                |   22 +
 include/hw/ppc/pnv_xscom.h          |    9 +
 include/hw/ppc/xics.h               |    1 +
 hw/intc/xics.c                      |    2 +-
 hw/pci-host/pnv_phb3.c              | 1146 +++++++++++++++++++++++++++
 hw/pci-host/pnv_phb3_msi.c          |  318 ++++++++
 hw/pci-host/pnv_phb3_pbcq.c         |  347 ++++++++
 hw/ppc/pnv.c                        |   75 +-
 hw/ppc/pnv_xscom.c                  |    6 +-
 hw/pci-host/Makefile.objs           |    1 +
 13 files changed, 2526 insertions(+), 5 deletions(-)
 create mode 100644 include/hw/pci-host/pnv_phb3.h
 create mode 100644 include/hw/pci-host/pnv_phb3_regs.h
 create mode 100644 hw/pci-host/pnv_phb3.c
 create mode 100644 hw/pci-host/pnv_phb3_msi.c
 create mode 100644 hw/pci-host/pnv_phb3_pbcq.c

--=20
2.17.1
