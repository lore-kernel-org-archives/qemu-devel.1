Received: from eggs.gnu.org ([2001:4830:134:3::10]:37383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fYSQF-00047Z-N7
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 04:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fYSQB-0003bj-Pd
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 04:36:59 -0400
Received: from 6.mo173.mail-out.ovh.net ([46.105.43.93]:60833)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fYSQB-0003aV-IF
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 04:36:55 -0400
Received: from player158.ha.ovh.net (unknown [10.109.105.104])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 86939C7412
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 10:36:53 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 28 Jun 2018 10:36:31 +0200
Message-Id: <20180628083633.12413-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/2] ppc/pnv: Add model for Power8 PHB3 PCIe
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
chip is supported, each chip adding its set of PHB3 controllers and
PCI busses.

There is no default device layout and PCI devices should be added to
the machine using command line options such as :

  -device e1000,netdev=3Dnet0,mac=3DC0:FF:EE:00:00:02,bus=3Dpci.0,addr=3D=
0x2
  -netdev bridge,id=3Dnet0,helper=3D/usr/libexec/qemu-bridge-helper,br=3D=
virbr0,id=3Dhostnet0

  -device megasas,id=3Dscsi0,bus=3Dpci.0,addr=3D0x1
  -drive file=3D$disk,if=3Dnone,id=3Ddrive-scsi0-0-0-0,format=3Dqcow2,cac=
he=3Dnone
  -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=3Dd=
rive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D2

The last patch explores the possibility of user creatable PHB3
devices. Nothing complex but the QEMU powernv machine models a
baremetal system on which it does not make sense to plug such
controllers. I don't think we should allow it.

Git tree available here for testing, based on David's branch:

	https://github.com/legoater/qemu/tree/phb3-3.0

Thanks,

C.


Changes sinces v1 :

 - removed duplication of macros for the register definitions
 - fixed multi chip support
 - introduced a chip class attribute to create all possible PHB3
   devices
 - introduced property handlers to check the validity of the phb index
   and the chip id
 - explored user creatable PHB3 devices

Benjamin Herrenschmidt (1):
  ppc/pnv: Add model for Power8 PHB3 PCIe Host bridge

C=C3=A9dric Le Goater (1):
  ppc/pnv: make the PHB3 devices user creatable

 default-configs/ppc64-softmmu.mak   |    1 +
 include/hw/pci-host/pnv_phb3.h      |  163 +++++
 include/hw/pci-host/pnv_phb3_regs.h |  467 +++++++++++++
 include/hw/ppc/pnv.h                |   22 +
 include/hw/ppc/pnv_xscom.h          |    9 +
 include/hw/ppc/xics.h               |    1 +
 hw/intc/xics.c                      |    2 +-
 hw/pci-host/pnv_phb3.c              | 1242 +++++++++++++++++++++++++++++=
++++++
 hw/pci-host/pnv_phb3_msi.c          |  316 +++++++++
 hw/pci-host/pnv_phb3_pbcq.c         |  358 ++++++++++
 hw/ppc/pnv.c                        |   64 +-
 hw/ppc/pnv_xscom.c                  |    6 +-
 hw/pci-host/Makefile.objs           |    1 +
 13 files changed, 2647 insertions(+), 5 deletions(-)
 create mode 100644 include/hw/pci-host/pnv_phb3.h
 create mode 100644 include/hw/pci-host/pnv_phb3_regs.h
 create mode 100644 hw/pci-host/pnv_phb3.c
 create mode 100644 hw/pci-host/pnv_phb3_msi.c
 create mode 100644 hw/pci-host/pnv_phb3_pbcq.c

--=20
2.13.6
