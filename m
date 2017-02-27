Received: from eggs.gnu.org ([2001:4830:134:3::10]:52241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfk-0002Rb-GT
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfh-0001xI-Ho
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:20 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ciPfh-0001lG-6m
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:17 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfR-0002If-DA
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:05:01 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 18:04:31 +0000
Message-Id: <1488218699-31035-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1488218699-31035-1-git-send-email-peter.maydell@linaro.org>
References: <1488218699-31035-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 02/30] bcm2835_rng: Use qcrypto_random_bytes()
 rather than rand()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Switch to using qcrypto_random_bytes() rather than rand() as
our source of randomness for the BCM2835 RNG.

If qcrypto_random_bytes() fails, we don't want to return the guest a
non-random value in case they're really using it for cryptographic
purposes, so the best we can do is a fatal error.  This shouldn't
happen unless something's broken, though.

In theory we could implement this device's full FIFO and interrupt
semantics and then just stop filling the FIFO.  That's a lot of work,
though, and doesn't really give a very nice diagnostic to the user
since the guest will just seem to hang.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
---
 hw/misc/bcm2835_rng.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/hw/misc/bcm2835_rng.c b/hw/misc/bcm2835_rng.c
index 2242bc5..4d62143 100644
--- a/hw/misc/bcm2835_rng.c
+++ b/hw/misc/bcm2835_rng.c
@@ -9,8 +9,33 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qapi/error.h"
+#include "crypto/random.h"
 #include "hw/misc/bcm2835_rng.h"
 
+static uint32_t get_random_bytes(void)
+{
+    uint32_t res;
+    Error *err = NULL;
+
+    if (qcrypto_random_bytes((uint8_t *)&res, sizeof(res), &err) < 0) {
+        /* On failure we don't want to return the guest a non-random
+         * value in case they're really using it for cryptographic
+         * purposes, so the best we can do is die here.
+         * This shouldn't happen unless something's broken.
+         * In theory we could implement this device's full FIFO
+         * and interrupt semantics and then just stop filling the
+         * FIFO. That's a lot of work, though, so we assume any
+         * errors are systematic problems and trust that if we didn't
+         * fail as the guest inited then we won't fail later on
+         * mid-run.
+         */
+        error_report_err(err);
+        exit(1);
+    }
+    return res;
+}
+
 static uint64_t bcm2835_rng_read(void *opaque, hwaddr offset,
                                  unsigned size)
 {
@@ -27,7 +52,7 @@ static uint64_t bcm2835_rng_read(void *opaque, hwaddr offset,
         res = s->rng_status | (1 << 24);
         break;
     case 0x8:    /* rng_data */
-        res = rand();
+        res = get_random_bytes();
         break;
 
     default:
-- 
2.7.4
