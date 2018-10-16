Received: from eggs.gnu.org ([2001:4830:134:3::10]:53611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCXsA-0001Tk-GY
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 18:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCXs8-0005Na-1r
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 18:31:30 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCXs6-000579-BH
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 18:31:26 -0400
Received: by mail-pl1-x644.google.com with SMTP id 1-v6so11674383plv.7
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 15:31:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 16 Oct 2018 15:31:09 -0700
Message-Id: <20181016223115.24100-3-richard.henderson@linaro.org>
In-Reply-To: <20181016223115.24100-1-richard.henderson@linaro.org>
References: <20181016223115.24100-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 2/8] target/arm: V8M should not imply V7VE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Instantiating mps2-an505 (cortex-m33) will fail make check when
V7VE asserts that ID_ISAR0.Divide includes ARM division.  It is
also wrong to include ARM_FEATURE_LPAE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 4f6756a4e2..12e6273d60 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -814,7 +814,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
     /* Some features automatically imply others: */
     if (arm_feature(env, ARM_FEATURE_V8)) {
-        set_feature(env, ARM_FEATURE_V7VE);
+        if (arm_feature(env, ARM_FEATURE_M)) {
+            set_feature(env, ARM_FEATURE_V7);
+        } else {
+            set_feature(env, ARM_FEATURE_V7VE);
+        }
     }
     if (arm_feature(env, ARM_FEATURE_V7VE)) {
         /* v7 Virtualization Extensions. In real hardware this implies
-- 
2.17.2
