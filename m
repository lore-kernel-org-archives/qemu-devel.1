Received: from eggs.gnu.org ([2001:4830:134:3::10]:55141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ePUt6-0001PC-IH
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:53:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ePUt5-0000Oi-Fa
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:53:28 -0500
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 14 Dec 2017 06:52:40 -0800
Message-Id: <20171214145255.31545-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/15] i.MX FEC and SD changes
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

This patchset is v2 of a spin-off from original i.MX7 support submission
found here [1], containing all of the patchest that are more or less
agreed upon and are ready (hopefully!) for inclusion.

Changes since [v1]:

	- Collected Reviewed-by tags from Peter

	- Implemented forgotten feedback from Peter for
	  "sdhci: Add i.MX specific subtype of SDHCI"

	- "imx_fec: Move Tx frame buffer away from the stack" sent out
          properly (fingers crossed)

	- Added trivial patch to swith i.MX6 over to TYPE_IMX_USDHC

	- Added "sd: Check for READ_MULTIPLE_BLOCK size limit
          violation first" to address a small problem I was seeing
          when tesiting SD against latest vanilla kernel

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

[v1] https://lists.gnu.org/archive/html/qemu-arm/2017-12/msg00085.html
[1]  https://lists.gnu.org/archive/html/qemu-arm/2017-11/msg00045.html


Andrey Smirnov (15):
  imx_fec: Do not link to netdev
  imx_fec: Refactor imx_eth_enable_rx()
  imx_fec: Change queue flushing heuristics
  imx_fec: Move Tx frame buffer away from the stack
  imx_fec: Use ENET_FTRL to determine truncation length
  imx_fec: Use MIN instead of explicit ternary operator
  imx_fec: Emulate SHIFT16 in ENETx_RACC
  imx_fec: Add support for multiple Tx DMA rings
  imx_fec: Use correct length for packet size
  imx_fec: Fix a typo in imx_enet_receive()
  imx_fec: Reserve full FSL_IMX25_FEC_SIZE page for the register file
  sdhci: Add i.MX specific subtype of SDHCI
  hw: i.MX: Convert i.MX6 to use TYPE_IMX_USDHC
  sd: Check for READ_MULTIPLE_BLOCK size limit violation first
  sdhci: Implement write method of ACMD12ERRSTS register

 hw/arm/fsl-imx6.c          |   3 +-
 hw/net/imx_fec.c           | 210 ++++++++++++++++++++++++++++++++---------
 hw/sd/sd.c                 |  16 ++--
 hw/sd/sdhci-internal.h     |  19 ++++
 hw/sd/sdhci.c              | 231 ++++++++++++++++++++++++++++++++++++++++++++-
 include/hw/arm/fsl-imx25.h |   1 -
 include/hw/net/imx_fec.h   |  27 +++++-
 include/hw/sd/sdhci.h      |  14 +++
 8 files changed, 461 insertions(+), 60 deletions(-)

-- 
2.14.3
