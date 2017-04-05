Received: from eggs.gnu.org ([2001:4830:134:3::10]:41575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cvkGL-0007v9-E1
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cvkGH-0000yY-Fc
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:42:13 -0400
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:35917)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cvkGH-0000xT-69
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:42:09 -0400
Received: from player688.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 9108049B83
	for <qemu-devel@nongnu.org>; Wed,  5 Apr 2017 14:42:07 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Apr 2017 14:41:25 +0200
Message-Id: <1491396106-26376-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/21] pnv: PSI, OCC, IPMI and PCI models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

Hello,

Now that we have support for the interrupt controller in the PowerNV
machine, we can start adding controllers depending on it. First of
these, is the Processor Service Interface (PSI), which handles the
external interrupt, and then a minimal model for the OCC. They have
been reviewed a couple of time and should be ready to be merged.
These first two patches give us a usable PCI-less PowerNV machine,
which is an important step to complete the overall model.

Some fixes improving support for the POWER8NVL (nvlink) and multichip
follow.

Next, we add IPMI support to the machine which is required to power
off and reboot a PowerNV system. To make use of it, a BT device and an
BMC simulator need to be defined on the command line:

    -device ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D1=
0

To improve the sensor and FRU support, one can use the following
options for the simulator:

    sdrfile=3D./palmetto-SDR.bin,fruareasize=3D256,frudatafile=3D./palmet=
to-FRU.bin

Most of the IPMI patches have been discussed already on the list and
some should go through Corey Minyard's tree or Michael S. Tsirkin's if
considered ready.

Last is a PCIe host bridge model (PHB3) as found on the Power8
machines. Power9 will use a PHB4 which is very close. Nevertheless, it
is a large model and it depends on a few helpers in the PCI core which
need to be discussed. (I would need some help here)


To test, grab a kernel and a rootfs image here :

  https://openpower.xyz/job/openpower-op-build/distro=3Dubuntu,target=3Dp=
almetto/lastSuccessfulBuild/artifact/images/zImage.epapr
  https://openpower.xyz/job/openpower-op-build/distro=3Dubuntu,target=3Dp=
almetto/lastSuccessfulBuild/artifact/images/rootfs.cpio.xz

The full patchset is available here :

   https://github.com/legoater/qemu/commits/powernv-ipmi-2.9

Thanks,

C.

Benjamin Herrenschmidt (7):
  ppc/pnv: Add OCC model stub with interrupt support
  ppc/pnv: Add support for POWER8+ LPC Controller
  qdev: Add a hook for a bus to device if it can add devices
  pci: Use the new pci_can_add_device() to enforce devfn_min/max
  pci: Don't call pci_irq_handler() for a negative intx
  ppc/pnv: Add model for Power8 PHB3 PCIe Host bridge
  ppc/pnv: Create a default PCI layout

C=C3=A9dric Le Goater (14):
  ppc/pnv: Add cut down PSI bridge model and hookup external interrupt
  ppc/pnv: enable only one LPC bus
  ppc: add IPMI support
  ipmi: use a file to load SDRs
  ipmi: provide support for FRUs
  ipmi: introduce an ipmi_bmc_sdr_find() API
  ipmi: introduce an ipmi_bmc_gen_event() API
  ipmi: add SET_SENSOR_READING command
  ppc/pnv: scan ISA bus to populate device tree
  ppc/pnv: populate device tree for RTC devices
  ppc/pnv: populate device tree for serial devices
  ppc/pnv: populate device tree for IPMI BT devices
  ppc/pnv: add initial IPMI sensors for the BMC simulator
  ppc/pnv: generate an OEM SEL event on shutdown

 default-configs/ppc64-softmmu.mak   |    4 +
 hw/intc/xics.c                      |    2 +-
 hw/ipmi/ipmi_bmc_sim.c              |  324 ++++++++++-
 hw/pci-host/Makefile.objs           |    1 +
 hw/pci-host/pnv_phb3.c              | 1052 +++++++++++++++++++++++++++++=
++++++
 hw/pci-host/pnv_phb3_msi.c          |  304 ++++++++++
 hw/pci-host/pnv_phb3_pbcq.c         |  361 ++++++++++++
 hw/pci-host/pnv_phb3_rc.c           |  134 +++++
 hw/pci/pci.c                        |   26 +-
 hw/ppc/Makefile.objs                |    2 +-
 hw/ppc/pnv.c                        |  435 ++++++++++++++-
 hw/ppc/pnv_bmc.c                    |  123 ++++
 hw/ppc/pnv_lpc.c                    |   67 ++-
 hw/ppc/pnv_occ.c                    |  136 +++++
 hw/ppc/pnv_psi.c                    |  571 +++++++++++++++++++
 hw/ppc/pnv_xscom.c                  |    5 +-
 include/hw/ipmi/ipmi.h              |    4 +
 include/hw/pci-host/pnv_phb3.h      |  156 ++++++
 include/hw/pci-host/pnv_phb3_regs.h |  506 +++++++++++++++++
 include/hw/pci/pci_bus.h            |    1 +
 include/hw/ppc/pnv.h                |   31 ++
 include/hw/ppc/pnv_lpc.h            |   11 +
 include/hw/ppc/pnv_occ.h            |   38 ++
 include/hw/ppc/pnv_psi.h            |   67 +++
 include/hw/ppc/pnv_xscom.h          |   15 +
 include/hw/ppc/xics.h               |    1 +
 include/hw/qdev-core.h              |    1 +
 qdev-monitor.c                      |   14 +-
 qemu-options.hx                     |   15 +-
 29 files changed, 4378 insertions(+), 29 deletions(-)
 create mode 100644 hw/pci-host/pnv_phb3.c
 create mode 100644 hw/pci-host/pnv_phb3_msi.c
 create mode 100644 hw/pci-host/pnv_phb3_pbcq.c
 create mode 100644 hw/pci-host/pnv_phb3_rc.c
 create mode 100644 hw/ppc/pnv_bmc.c
 create mode 100644 hw/ppc/pnv_occ.c
 create mode 100644 hw/ppc/pnv_psi.c
 create mode 100644 include/hw/pci-host/pnv_phb3.h
 create mode 100644 include/hw/pci-host/pnv_phb3_regs.h
 create mode 100644 include/hw/ppc/pnv_occ.h
 create mode 100644 include/hw/ppc/pnv_psi.h

--=20
2.7.4
