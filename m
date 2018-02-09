Received: from eggs.gnu.org ([2001:4830:134:3::10]:39934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Sv-00016k-TE
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Ss-00020r-5i
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:37 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ek6Sr-00020F-W9
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:34 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Sq-0002dd-UV
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:03:32 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Feb 2018 11:03:08 +0000
Message-Id: <20180209110314.11766-25-peter.maydell@linaro.org>
In-Reply-To: <20180209110314.11766-1-peter.maydell@linaro.org>
References: <20180209110314.11766-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 24/30] target/arm: Add predicate registers for
 SVE
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180123035349.24538-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0e3cd52aa3..966d2fdbb1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -188,6 +188,13 @@ typedef struct ARMVectorReg {
     uint64_t d[2 * ARM_MAX_VQ] QEMU_ALIGNED(16);
 } ARMVectorReg;
 
+/* In AArch32 mode, predicate registers do not exist at all.  */
+#ifdef TARGET_AARCH64
+typedef struct ARMPredicateReg {
+    uint64_t p[2 * ARM_MAX_VQ / 8] QEMU_ALIGNED(16);
+} ARMPredicateReg;
+#endif
+
 
 typedef struct CPUARMState {
     /* Regs for current mode.  */
@@ -515,6 +522,11 @@ typedef struct CPUARMState {
     struct {
         ARMVectorReg zregs[32];
 
+#ifdef TARGET_AARCH64
+        /* Store FFR as pregs[16] to make it easier to treat as any other.  */
+        ARMPredicateReg pregs[17];
+#endif
+
         uint32_t xregs[16];
         /* We store these fpcsr fields separately for convenience.  */
         int vec_len;
-- 
2.16.1
