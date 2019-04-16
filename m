Received: from eggs.gnu.org ([209.51.188.92]:34259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNes-0004MJ-Jw
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNep-00010k-Kz
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:57:53 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNeo-0000zR-04
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:57:50 -0400
Received: by mail-wr1-x442.google.com with SMTP id y7so26891092wrn.11
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:57:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2019 13:57:19 +0100
Message-Id: <20190416125744.27770-2-peter.maydell@linaro.org>
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 01/26] target/arm: Make sure M-profile FPSCR
 RES0 bits are not settable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org

Enforce that for M-profile various FPSCR bits which are RES0 there
but have defined meanings on A-profile are never settable. This
ensures that M-profile code can't enable the A-profile behaviour
(notably vector length/stride handling) by accident.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/vfp_helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 2468fc16294..7a46d991486 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -105,6 +105,14 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
         val &= ~FPCR_FZ16;
     }
 
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        /*
+         * M profile FPSCR is RES0 for the QC, STRIDE, FZ16, LEN bits
+         * and also for the trapped-exception-handling bits IxE.
+         */
+        val &= 0xf7c0009f;
+    }
+
     /*
      * We don't implement trapped exception handling, so the
      * trap enable bits, IDE|IXE|UFE|OFE|DZE|IOE are all RAZ/WI (not RES0!)
-- 
2.20.1
