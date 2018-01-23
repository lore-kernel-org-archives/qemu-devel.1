Received: from eggs.gnu.org ([2001:4830:134:3::10]:43201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edpeo-0001si-3h
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:53:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edpen-000469-AG
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:53:58 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:34287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1edpen-00045T-3y
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:53:57 -0500
Received: by mail-pf0-x243.google.com with SMTP id e76so8775074pfk.1
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 19:53:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 22 Jan 2018 19:53:46 -0800
Message-Id: <20180123035349.24538-3-richard.henderson@linaro.org>
In-Reply-To: <20180123035349.24538-1-richard.henderson@linaro.org>
References: <20180123035349.24538-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 2/5] target/arm: Add predicate registers for
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1854fe51a8..3f4f6b6144 100644
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
2.14.3
