Received: from eggs.gnu.org ([2001:4830:134:3::10]:49691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFcB-00023Z-90
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFcA-00040H-9G
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:11 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ccFcA-0003zU-36
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:10 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFc9-0007ec-7x
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 18:08:09 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 18:08:01 +0000
Message-Id: <1486750082-12324-12-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486750082-12324-1-git-send-email-peter.maydell@linaro.org>
References: <1486750082-12324-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/12] aspeed/smc: handle dummies only in fast
 read mode
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

HW works fine in normal read mode with dummy bytes being set. So let's
check this case to not transfer bytes.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 1486648058-520-4-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/aspeed_smc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 087b29e..7017707 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -536,10 +536,13 @@ static uint64_t aspeed_smc_flash_read(void *opaque, hwaddr addr, unsigned size)
         /*
          * Use fake transfers to model dummy bytes. The value should
          * be configured to some non-zero value in fast read mode and
-         * zero in read mode.
+         * zero in read mode. But, as the HW allows inconsistent
+         * settings, let's check for fast read mode.
          */
-        for (i = 0; i < aspeed_smc_flash_dummies(fl); i++) {
-            ssi_transfer(fl->controller->spi, 0xFF);
+        if (aspeed_smc_flash_mode(fl) == CTRL_FREADMODE) {
+            for (i = 0; i < aspeed_smc_flash_dummies(fl); i++) {
+                ssi_transfer(fl->controller->spi, 0xFF);
+            }
         }
 
         for (i = 0; i < size; i++) {
-- 
2.7.4
