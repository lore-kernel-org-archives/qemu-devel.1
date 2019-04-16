Received: from eggs.gnu.org ([209.51.188.92]:34667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfJ-0004r7-PC
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfH-0001Lw-TS
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:21 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNfF-0001I5-Qd
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:19 -0400
Received: by mail-wr1-x441.google.com with SMTP id k17so22247627wrx.10
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:58:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2019 13:57:31 +0100
Message-Id: <20190416125744.27770-14-peter.maydell@linaro.org>
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 13/26] target/arm: Clean excReturn bits when
 tail chaining
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org

The TailChain() pseudocode specifies that a tail chaining
exception should sanitize the excReturn all-ones bits and
(if there is no FPU) the excReturn FType bits; we weren't
doing this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8e72e1097ce..fe8e78fe36d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8081,6 +8081,14 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
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
