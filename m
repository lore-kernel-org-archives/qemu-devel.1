Received: from eggs.gnu.org ([2001:4830:134:3::10]:39803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1djUKy-000455-HB
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 13:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1djUKv-00053U-Fj
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 13:48:36 -0400
Message-Id: <cover.1503249785.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun, 20 Aug 2017 19:23:05 +0200
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/15] Sam460ex emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Francois Revol <revol@free.fr>

This is the revised version of my series described in the cover letter
of the RFC series:
http://lists.nongnu.org/archive/html/qemu-ppc/2017-08/msg00112.html

This contains reorganisation and fixes suggested by review comments.

Even though I think I haven't changed anything (apart from mostly
moving code around) with this series the problem described here:

http://lists.nongnu.org/archive/html/qemu-ppc/2017-08/msg00227.html

also happens with just the u-boot-sam460-20100605-fixed.bin while the
unfixed original firmware does not show this problem (but does not
work as it has the problems that are fixed in my version). There's
definitely some QEMU bug here (client code should not be able to crash
QEMU) but I have no idea how to find it because it is triggered from
TCG generated code so I'd need some help to debug that.

BALATON Zoltan (15):
  ppc4xx: Move MAL from ppc405_uc to ppc4xx_devs
  ppc4xx: Make MAL emulation more generic
  ohci: Allow sysbus version to be used as a companion
  ehci: Add ppc4xx-ehci for the USB 2.0 controller in embedded PPC SoCs
  ppc4xx: Split off 4xx I2C emulation from ppc405_uc to its own file
  ppc4xx_i2c: QOMify
  ppc4xx_i2c: Move to hw/i2c
  ppc4xx_i2c: Implement basic I2C functions
  hw/ide: Emulate SiI3112 SATA controller
  ppc440: Add emulation of plb-pcix controller found in some 440 SoCs
  ppc: Add 460EX embedded CPU
  ppc4xx: Export ECB and PLB emulation
  ppc4xx: Add more PLB registers
  ppc4xx: Add device models found in PPC440 core SoCs
  ppc: Add aCube Sam460ex board

 default-configs/ppc-softmmu.mak    |    1 +
 default-configs/ppc64-softmmu.mak  |    1 +
 default-configs/ppcemb-softmmu.mak |    4 +
 hw/i2c/Makefile.objs               |    1 +
 hw/i2c/ppc4xx_i2c.c                |  368 ++++++++++
 hw/ide/Makefile.objs               |    1 +
 hw/ide/sii3112.c                   |  369 ++++++++++
 hw/ppc/Makefile.objs               |    4 +-
 hw/ppc/ppc405.h                    |    3 +
 hw/ppc/ppc405_uc.c                 |  527 +--------------
 hw/ppc/ppc440.h                    |   26 +
 hw/ppc/ppc440_pcix.c               |  516 ++++++++++++++
 hw/ppc/ppc440_uc.c                 | 1305 ++++++++++++++++++++++++++++++=
++++++
 hw/ppc/ppc4xx_devs.c               |  227 +++++++
 hw/ppc/sam460ex.c                  |  611 +++++++++++++++++
 hw/usb/hcd-ehci-sysbus.c           |   25 +
 hw/usb/hcd-ehci.h                  |    1 +
 hw/usb/hcd-ohci.c                  |   15 +-
 include/hw/i2c/ppc4xx_i2c.h        |   64 ++
 include/hw/pci/pcie_host.h         |    2 +-
 include/hw/ppc/ppc4xx.h            |    3 +
 target/ppc/cpu-models.c            |    3 +
 target/ppc/cpu-models.h            |    1 +
 target/ppc/translate_init.c        |   38 ++
 24 files changed, 3599 insertions(+), 517 deletions(-)
 create mode 100644 hw/i2c/ppc4xx_i2c.c
 create mode 100644 hw/ide/sii3112.c
 create mode 100644 hw/ppc/ppc440.h
 create mode 100644 hw/ppc/ppc440_pcix.c
 create mode 100644 hw/ppc/ppc440_uc.c
 create mode 100644 hw/ppc/sam460ex.c
 create mode 100644 include/hw/i2c/ppc4xx_i2c.h

--=20
2.7.6
