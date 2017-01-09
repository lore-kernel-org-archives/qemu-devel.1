Received: from eggs.gnu.org ([2001:4830:134:3::10]:45157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cQckw-0000Dc-9h
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:25:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cQcks-0003za-9l
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:25:10 -0500
Received: from 10.mo178.mail-out.ovh.net ([46.105.76.150]:53431)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cQcks-0003yy-3F
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:25:06 -0500
Received: from player714.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 51298CA03
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 17:25:03 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  9 Jan 2017 17:24:36 +0100
Message-Id: <1483979087-32663-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/11] Aspeed SMC controller fixes and
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Marcin Krzeminski <marcin.krzeminski@nokia.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

I have reduced the patchset size to focus on some improvements of the
SMC (Flash) controller model only and will address the watchdog and
network models in other patchset.

The main benefit of this series is to enable booting directly from a
flash image containing U-Boot. It adds :

 - some minor fixes and code rearrangements=20
 - Command mode support. Flash contents is accessed directly on the
   AHB bus
 - auto strapping of configuration for boot flash
 - use CE0 as a boot ROM. Today, qemu can not boot from a MMIO region.
   As this is complex to do (TCG layer modification), we use a ROM
   region in which we copy the flash contents. Hopefully, I got it
   right this time.
 - dummy bytes support for Command mode only

Still in the pipe for the SMC controller are :

 - DMA support
 - dummy bytes support in user mode (hacky)

which I will send later.

Thanks,

C.

C=C3=A9dric Le Goater (11):
  aspeed/smc: remove call to reset in realize function
  aspeed/smc: remove call to aspeed_smc_update_cs() in reset function
  aspeed/smc: rework the prototype of the AspeedSMCFlash helper routines
  aspeed/smc: autostrap CE0/1 configuration
  aspeed/smc: unfold the AspeedSMCController array
  aspeed/smc: adjust the size of the register region
  aspeed/smc: handle SPI flash Command mode
  aspeed/smc: reset flash after each test
  aspeed/smc: extend tests for Command mode
  aspeed: use first SPI flash as a boot ROM
  aspeed/smc: handle dummy bytes when doing fast reads in command mode

 hw/arm/aspeed.c             |  41 ++++++
 hw/ssi/aspeed_smc.c         | 352 +++++++++++++++++++++++++++++++++++---=
------
 include/hw/ssi/aspeed_smc.h |   4 +-
 tests/m25p80-test.c         | 133 +++++++++++++++++
 4 files changed, 456 insertions(+), 74 deletions(-)

--=20
2.7.4
