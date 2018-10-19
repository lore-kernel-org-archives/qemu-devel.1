Received: from eggs.gnu.org ([2001:4830:134:3::10]:47445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY5n-0001Lv-Rf
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:57:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY5m-0001qp-Sz
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:57:43 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gDY5m-0001mu-LY
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:57:42 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY5l-0006g3-D1
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 17:57:41 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 17:56:54 +0100
Message-Id: <20181019165735.22511-5-peter.maydell@linaro.org>
In-Reply-To: <20181019165735.22511-1-peter.maydell@linaro.org>
References: <20181019165735.22511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/45] target/arm: V8M should not imply V7VE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Instantiating mps2-an505 (cortex-m33) will fail make check when
V7VE asserts that ID_ISAR0.Divide includes ARM division.  It is
also wrong to include ARM_FEATURE_LPAE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181016223115.24100-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 4f6756a4e2e..12e6273d603 100644
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
2.19.1
