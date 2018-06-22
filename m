Received: from eggs.gnu.org ([2001:4830:134:3::10]:43011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fWGwW-0006RN-6g
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 03:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fWGwT-0008Ku-4b
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 03:57:16 -0400
Received: from 7.mo6.mail-out.ovh.net ([46.105.59.196]:60212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fWGwS-0008KK-Tc
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 03:57:13 -0400
Received: from player168.ha.ovh.net (unknown [10.109.105.54])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 0A12B1644D3
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 09:57:10 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 22 Jun 2018 09:56:57 +0200
Message-Id: <20180622075700.5923-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/3] aspeed: introduce the APB clock settings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

The Aspeed SoC clocks are driven by an input source clock which can
have different frequencies : 24MHz or 25MHz, and also, on the Aspeed
AST2400 SoC, 48MHz. The H-PLL (CPU) clock is defined from a calculation
using parameters in the H-PLL Parameter register or from a predefined
set of frequencies if the setting is strapped by hardware (Aspeed
AST2400 SoC). The other clocks of the SoC are then defined from the
H-PLL using dividers.

We first introduce the APB clock because it drives the timer model.
This fixes a slowdown issue on the palmetto machine (AST2400) when
running Linux. The latest Linux versions take into account more
precisely the SoC settings for the clocks and the APB freq is set to
48MHz but modeled at 24MHz by QEMU.

Thanks,

C.

Changes since v1:

- fixed AST2400 HPLL calculation when CLKIN is 25MHz=20

C=C3=A9dric Le Goater (3):
  aspeed/scu: introduce clock frequencies
  aspeed: initialize the SCU controller first
  aspeed/timer: use the APB frequency from the SCU

 include/hw/misc/aspeed_scu.h    |  70 ++++++++++++++++++++++++--
 include/hw/timer/aspeed_timer.h |   4 ++
 hw/arm/aspeed_soc.c             |  42 ++++++++--------
 hw/misc/aspeed_scu.c            | 106 ++++++++++++++++++++++++++++++++++=
++++++
 hw/timer/aspeed_timer.c         |  19 +++++--
 5 files changed, 213 insertions(+), 28 deletions(-)

--=20
2.13.6
