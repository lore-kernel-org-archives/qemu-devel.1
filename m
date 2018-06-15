Received: from eggs.gnu.org ([2001:4830:134:3::10]:32888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfk-0001wH-1J
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfj-0006RD-1S
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:52 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfi-0006Qc-R0
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:50 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfh-0003qv-Qw
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:49 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:25:15 +0100
Message-Id: <20180615142521.19143-38-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 37/43] aspeed_scu: Implement RNG register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Joel Stanley <joel@jms.id.au>

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
Message-id: 20180613114836.9265-1-joel@jms.id.au
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/aspeed_scu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 5e6d5744eec..59315010db9 100644
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
