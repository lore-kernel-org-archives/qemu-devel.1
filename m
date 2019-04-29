Received: from eggs.gnu.org ([209.51.188.92]:34360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9er-0004r3-3L
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eo-0006kV-BP
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:35 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:41684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9eo-0006R7-08
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:34 -0400
Received: by mail-wr1-x42d.google.com with SMTP id c12so17089247wrt.8
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.51
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 18:00:04 +0100
Message-Id: <20190429170030.11323-17-peter.maydell@linaro.org>
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/42] target/arm: Clean excReturn bits when
 tail chaining
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The TailChain() pseudocode specifies that a tail chaining
exception should sanitize the excReturn all-ones bits and
(if there is no FPU) the excReturn FType bits; we weren't
doing this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-14-peter.maydell@linaro.org
---
 target/arm/helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 088852ceb96..da0b6202400 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8076,6 +8076,14 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
     qemu_log_mask(CPU_LOG_INT, "...taking pending %s exception %d\n",
                   targets_secure ? "secure" : "nonsecure", exc);
 
+    if (dotailchain) {
+        /* Sanitize LR FType and PREFIX bits */
+        if (!arm_feature(env, ARM_FEATURE_VFP)) {
+            lr |= R_V7M_EXCRET_FTYPE_MASK;
+        }
+        lr = deposit32(lr, 24, 8, 0xff);
+    }
+
     if (arm_feature(env, ARM_FEATURE_V8)) {
         if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
             (lr & R_V7M_EXCRET_S_MASK)) {
-- 
2.20.1
