Received: from eggs.gnu.org ([2001:4830:134:3::10]:35740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eOVf7-0000j3-8F
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 16:30:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eOVf6-0004AW-BN
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 16:30:57 -0500
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 11 Dec 2017 13:29:54 -0800
Message-Id: <20171211213007.7353-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/13] i.MX FEC and SD changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, yurovsky@gmail.com

Hi everyone,

This patchset is a spin-off from original i.MX7 support submission
found here [1], containing all of the patchest that are more or less
agreed upon and are ready (hopefully!) for inclusion.

Changes since [1]:

	- Rx buffer in FEC was moved from stack to heap to allow
          worry-free expansion to 16K limit.

 	- Added more comments explaining rather convoluted bit-moving
          in eSHDC emuation code

	- Triple Tx ring DMA "VMState" code was changed to follow
          Peter's recommendations (avoiding the need to incrememnt the
          version_id)

	- FSL_IMX25_FEC_SIZE is used as a size of FEC's register file

	- Removed leftover code from "imx_fec: Change queue flushing
          heuristics"

[1] https://lists.gnu.org/archive/html/qemu-arm/2017-11/msg00045.html


Andrey Smirnov (13):
  imx_fec: Do not link to netdev
  imx_fec: Refactor imx_eth_enable_rx()
  imx_fec: Change queue flushing heuristicsw
  imx_fec: Move Tx frame buffer away from the stack
  imx_fec: Use ENET_FTRL to determine truncation length
  imx_fec: Use MIN instead of explicit ternary operator
  imx_fec: Emulate SHIFT16 in ENETx_RACC
  imx_fec: Add support for multiple Tx DMA rings
  imx_fec: Use correct length for packet size
  imx_fec: Fix a typo in imx_enet_receive()
  imx_fec: Reserve full FSL_IMX25_FEC_SIZE page for the register file
  sdhci: Add i.MX specific subtype of SDHCI
  sdhci: Implement write method of ACMD12ERRSTS register

 hw/arm/fsl-imx6.c          |   1 +
 hw/net/imx_fec.c           | 210 ++++++++++++++++++++++++++++++++---------
 hw/sd/sdhci-internal.h     |  19 ++++
 hw/sd/sdhci.c              | 231 ++++++++++++++++++++++++++++++++++++++++++++-
 include/hw/arm/fsl-imx25.h |   1 -
 include/hw/net/imx_fec.h   |  27 +++++-
 include/hw/sd/sdhci.h      |   8 ++
 7 files changed, 444 insertions(+), 53 deletions(-)

-- 
2.14.3
