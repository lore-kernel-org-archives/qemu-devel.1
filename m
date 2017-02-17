Received: from eggs.gnu.org ([2001:4830:134:3::10]:47346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cehYm-0003lC-BS
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 07:22:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cehYl-0005SR-5A
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 07:22:48 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Feb 2017 12:22:39 +0000
Message-Id: <1487334159-19664-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] bcm2835_rng: Use qcrypto_random_bytes() rather
 than rand()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Marcin Chojnacki <marcinch7@gmail.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Daniel P . Berrange" <berrange@redhat.com>

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
---
This patch sits on top of http://patchwork.ozlabs.org/patch/726744/
(though for review purposes I think it's pretty self explanatory).
The interesting question here is the failure case handling, where
we're a bit between a rock and a hard place because we don't have
a nice way to report it to the guest, but we don't want to return
a non-random value either...

We should probably improve crypto/random-platform.c to use
getentropy() if available, which would fix the "BSD or OSX
host and not using gcrypt or gnutls" case which I think is
the most likely cause of qcrypto_random_bytes() failing.

 hw/misc/bcm2835_rng.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/hw/misc/bcm2835_rng.c b/hw/misc/bcm2835_rng.c
index 2242bc5..bbe903d 100644
--- a/hw/misc/bcm2835_rng.c
+++ b/hw/misc/bcm2835_rng.c
@@ -9,8 +9,32 @@
 
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
+         * errors are systematic problems and trust that the check
+         * on init is sufficient.
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
@@ -27,7 +51,7 @@ static uint64_t bcm2835_rng_read(void *opaque, hwaddr offset,
         res = s->rng_status | (1 << 24);
         break;
     case 0x8:    /* rng_data */
-        res = rand();
+        res = get_random_bytes();
         break;
 
     default:
-- 
2.7.4
