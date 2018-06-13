Received: from eggs.gnu.org ([2001:4830:134:3::10]:34421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fT4Gn-0000Ec-IP
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 07:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fT4Gi-00069u-Tm
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 07:48:57 -0400
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 13 Jun 2018 21:18:36 +0930
Message-Id: <20180613114836.9265-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4] aspeed_scu: Implement RNG register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Andrew Jeffery <andrew@aj.id.au>

The ASPEED SoCs contain a single register that returns random data when
read. This models that register so that guests can use it.

The random number data register has a corresponding control register,
however it returns data regardless of the state of the enabled bit, so
the model follows this behaviour.

When the qcrypto call fails we exit as the guest uses the random number
device to feed it's entropy pool, which is used for cryptographic
purposes.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2:
 - Remove call to qcrypto_random_init as this is done in main()
v3:
 - Add Cédric's reviewed-by
 - Add a comment about why we don't check for the rng enable bit
v4:
 - Bail out when random number api fails
---
 hw/misc/aspeed_scu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 5e6d5744eeca..59315010db9a 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -16,6 +16,7 @@
 #include "qapi/visitor.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
+#include "crypto/random.h"
 #include "trace.h"
 
 #define TO_REG(offset) ((offset) >> 2)
@@ -154,6 +155,19 @@ static const uint32_t ast2500_a1_resets[ASPEED_SCU_NR_REGS] = {
      [BMC_DEV_ID]      = 0x00002402U
 };
 
+static uint32_t aspeed_scu_get_random(void)
+{
+    Error *err = NULL;
+    uint32_t num;
+
+    if (qcrypto_random_bytes((uint8_t *)&num, sizeof(num), &err)) {
+        error_report_err(err);
+        exit(1);
+    }
+
+    return num;
+}
+
 static uint64_t aspeed_scu_read(void *opaque, hwaddr offset, unsigned size)
 {
     AspeedSCUState *s = ASPEED_SCU(opaque);
@@ -167,6 +181,12 @@ static uint64_t aspeed_scu_read(void *opaque, hwaddr offset, unsigned size)
     }
 
     switch (reg) {
+    case RNG_DATA:
+        /* On hardware, RNG_DATA works regardless of
+         * the state of the enable bit in RNG_CTRL
+         */
+        s->regs[RNG_DATA] = aspeed_scu_get_random();
+        break;
     case WAKEUP_EN:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Read of write-only offset 0x%" HWADDR_PRIx "\n",
-- 
2.17.1
