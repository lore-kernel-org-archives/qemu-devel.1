Received: from eggs.gnu.org ([209.51.188.92]:34374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9er-0004re-HB
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eo-0006kj-HI
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:36 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:39766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9eo-0006A7-2D
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:34 -0400
Received: by mail-wm1-x333.google.com with SMTP id n25so161295wmk.4
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.36
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 17:59:52 +0100
Message-Id: <20190429170030.11323-5-peter.maydell@linaro.org>
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/42] target/arm: Make sure M-profile FPSCR
 RES0 bits are not settable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Enforce that for M-profile various FPSCR bits which are RES0 there
but have defined meanings on A-profile are never settable. This
ensures that M-profile code can't enable the A-profile behaviour
(notably vector length/stride handling) by accident.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-2-peter.maydell@linaro.org
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
