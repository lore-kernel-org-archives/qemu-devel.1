Received: from eggs.gnu.org ([2001:4830:134:3::10]:47583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cbp61-0004jd-98
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:49:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cbp5y-0001kE-5K
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:49:13 -0500
Received: from 4.mo53.mail-out.ovh.net ([188.165.36.167]:42610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cbp5x-0001jH-Vu
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:49:10 -0500
Received: from player158.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo53.mail-out.ovh.net (Postfix) with ESMTP id 8E22B384A2
	for <qemu-devel@nongnu.org>; Thu,  9 Feb 2017 14:49:08 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  9 Feb 2017 14:47:38 +0100
Message-Id: <1486648058-520-5-git-send-email-clg@kaod.org>
In-Reply-To: <1486648058-520-1-git-send-email-clg@kaod.org>
References: <1486648058-520-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/4] aspeed/smc: use a modulo to check segment
 limits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The size of a segment is not necessarily a power of 2.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ssi/aspeed_smc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 70177078a8f2..cb515730c5ad 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -475,15 +475,15 @@ static uint32_t aspeed_smc_check_segment_addr(const=
 AspeedSMCFlash *fl,
     AspeedSegments seg;
=20
     aspeed_smc_reg_to_segment(s->regs[R_SEG_ADDR0 + fl->id], &seg);
-    if ((addr & (seg.size - 1)) !=3D addr) {
+    if ((addr % seg.size) !=3D addr) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: invalid address 0x%08x for CS%d segment : "
                       "[ 0x%"HWADDR_PRIx" - 0x%"HWADDR_PRIx" ]\n",
                       s->ctrl->name, addr, fl->id, seg.addr,
                       seg.addr + seg.size);
+        addr %=3D seg.size;
     }
=20
-    addr &=3D seg.size - 1;
     return addr;
 }
=20
--=20
2.7.4
