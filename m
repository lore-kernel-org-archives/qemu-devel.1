Received: from eggs.gnu.org ([2001:4830:134:3::10]:56369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cywhM-00051d-PT
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 04:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cywhH-00077l-PC
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 04:35:20 -0400
Received: from 9.mo178.mail-out.ovh.net ([46.105.75.45]:59290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cywhH-00077T-J9
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 04:35:15 -0400
Received: from player715.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 8347F317B8
	for <qemu-devel@nongnu.org>; Fri, 14 Apr 2017 10:35:13 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 14 Apr 2017 10:34:58 +0200
Message-Id: <1492158903-8016-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/5] FTGMAC100 nic model for the Aspeed SoCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hi,

The Aspeed SoCs AST2400 and AST2500 have two FTGMAC100 ethernet
controllers. This series proposes a model for this device and a way to
customize the bit definitions which are slightly different from the
Faraday definitions.

The last patch adds a fake NC-SI (Network Controller Sideband
Interface) backend to pretend a NIC is being managed. This is only
usable with the slirp stack for the moment.

The model has been tested on the 'palmetto', 'romulus' and
'ast2500-evb' machines using different implementations of the Linux
driver and with U-Boot. It has been stressed with iperf.

The full patchset is available here, based on QEMU v2.9.0-rc4 :

  https://github.com/legoater/qemu/commits/aspeed

To test, grab a palmetto or a romulus BMC firmware image :

  https://openpower.xyz/job/openbmc-build/distro=3Dubuntu,target=3Dpalmet=
to/lastSuccessfulBuild/artifact/images/palmetto/flash-palmetto
  https://openpower.xyz/job/openbmc-build/distro=3Dubuntu,target=3Dromulu=
s/lastSuccessfulBuild/artifact/images/romulus/flash-romulus

and start the machines with  :

  qemu-system-arm -m 512 -M romulus-bmc  -drive file=3Dflash-romulus,form=
at=3Draw,if=3Dmtd  -nographic
  qemu-system-arm -m 512 -M palmetto-bmc -drive file=3Dflash-palmetto,for=
mat=3Draw,if=3Dmtd -nographic

the fake NC-SI NIC should come up :

  ftgmac100 1e660000.ethernet eth0: NCSI interface up

and to log, use credentials root/0penBmc

Thanks,

C.=20

Changes since v2:
 - rebased on QEMU v2.9.0-rc4
 - modified the 'ncsi-pkt.h' file to add its location under the Linux
   tree=20
 - removed useless zeroing of the 'reserved' fields=20
 - introduced a ncsi_rsp_handlers array to hold the payload size and
   a specific handler routine for each command  =20
 - fixed the output size of the frame to match the command payload
   size

Changes since v1:
 - removed TODO comments and used LOG_UNIMP in the read/write ops
 - used camelcase for struct names and typedefs.=20
 - removed the useless struct definitions for ring descriptors and
   the alignment pragma  =20
 - introduced a frame buffer at the machine level to reduce stack
   usage in the tx path.
 - introduced symbolic constants for PHY values.
 - introduced rtl8211e PHY chip specific registers=20
 - removed qemu_set_irq() in reset path=20
 - checked for dma_memory_read() errors. Also for write but that was
   less important as the descriptor is first read so it should be
   valid for the write.
 - removed the irq state
 - removed the weird hack to catch a first valid descriptor.
 - fixed the read of the mac address=20

C=C3=A9dric Le Goater (5):
  hw/net: add MII definitions
  net: add FTGMAC100 support
  net/ftgmac100: add a 'aspeed' property
  aspeed: add a FTGMAC100 nic
  slirp: add a fake NC-SI backend

 default-configs/arm-softmmu.mak |    1 +
 hw/arm/aspeed_soc.c             |   21 +
 hw/net/Makefile.objs            |    1 +
 hw/net/ftgmac100.c              | 1016 +++++++++++++++++++++++++++++++++=
++++++
 include/hw/arm/aspeed_soc.h     |    2 +
 include/hw/net/ftgmac100.h      |   64 +++
 include/hw/net/mii.h            |   71 ++-
 include/net/eth.h               |    1 +
 slirp/Makefile.objs             |    2 +-
 slirp/ncsi-pkt.h                |  419 ++++++++++++++++
 slirp/ncsi.c                    |  130 +++++
 slirp/slirp.c                   |    4 +
 slirp/slirp.h                   |    3 +
 13 files changed, 1716 insertions(+), 19 deletions(-)
 create mode 100644 hw/net/ftgmac100.c
 create mode 100644 include/hw/net/ftgmac100.h
 create mode 100644 slirp/ncsi-pkt.h
 create mode 100644 slirp/ncsi.c

--=20
2.7.4
