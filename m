Received: from eggs.gnu.org ([2001:4830:134:3::10]:58690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ecOhg-0002FA-2j
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 23:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ecOhf-0000Ik-7A
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 23:55:00 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:39721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ecOhf-0000Gg-1s
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 23:54:59 -0500
Received: by mail-pg0-x244.google.com with SMTP id w17so547151pgv.6
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 20:54:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 18 Jan 2018 20:54:31 -0800
Message-Id: <20180119045438.28582-10-richard.henderson@linaro.org>
In-Reply-To: <20180119045438.28582-1-richard.henderson@linaro.org>
References: <20180119045438.28582-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 09/16] target/arm: Add predicate registers
 for SVE
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 57d805b5d8..132da359b5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -186,6 +186,15 @@ typedef struct ARMVectorReg {
     uint64_t d[2 * ARM_MAX_VQ] QEMU_ALIGNED(16);
 } ARMVectorReg;
 
+/* In AArch32 mode, predicate registers do not exist at all.  */
+typedef struct ARMPredicateReg {
+#ifdef TARGET_AARCH64
+    uint64_t p[2 * ARM_MAX_VQ / 8] QEMU_ALIGNED(16);
+#else
+    uint64_t p[0];
+#endif
+} ARMPredicateReg;
+
 
 typedef struct CPUARMState {
     /* Regs for current mode.  */
@@ -513,6 +522,9 @@ typedef struct CPUARMState {
     struct {
         ARMVectorReg zregs[32];
 
+        /* Store FFR as pregs[16] to make it easier to treat as any other.  */
+        ARMPredicateReg pregs[17];
+
         uint32_t xregs[16];
         /* We store these fpcsr fields separately for convenience.  */
         int vec_len;
-- 
2.14.3
