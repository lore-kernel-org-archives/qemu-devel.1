Received: from eggs.gnu.org ([2001:4830:134:3::10]:50380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlk-000307-GZ
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlj-0004DP-R8
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:28 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fRGlj-0004D2-Jj
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:27 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGli-0003fM-Hr
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:45:26 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Jun 2018 13:44:57 +0100
Message-Id: <20180608124517.29475-12-peter.maydell@linaro.org>
In-Reply-To: <20180608124517.29475-1-peter.maydell@linaro.org>
References: <20180608124517.29475-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/31] ftgmac100: fix multicast hash routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Cédric Le Goater <clg@kaod.org>

Based on the multicast hash calculation of the FTGMAC100 Linux driver.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180530061711.23673-4-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/ftgmac100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index abf80655f28..8a7f274dc11 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -776,8 +776,8 @@ static int ftgmac100_filter(FTGMAC100State *s, const uint8_t *buf, size_t len)
                 return 0;
             }
 
-            /* TODO: this does not seem to work for ftgmac100 */
-            mcast_idx = net_crc32(buf, ETH_ALEN) >> 26;
+            mcast_idx = net_crc32_le(buf, ETH_ALEN);
+            mcast_idx = (~(mcast_idx >> 2)) & 0x3f;
             if (!(s->math[mcast_idx / 32] & (1 << (mcast_idx % 32)))) {
                 return 0;
             }
-- 
2.17.1
