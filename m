Received: from eggs.gnu.org ([2001:4830:134:3::10]:48465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpdA-00050V-RP
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpd9-0000qj-GW
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:28 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fGpd9-0000qF-93
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:27 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpd8-0003WN-6j
	for qemu-devel@nongnu.org; Thu, 10 May 2018 18:45:26 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 18:45:06 +0100
Message-Id: <20180510174519.11264-9-peter.maydell@linaro.org>
In-Reply-To: <20180510174519.11264-1-peter.maydell@linaro.org>
References: <20180510174519.11264-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 08/21] tcg: Introduce helpers for integer min/max
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

These operations are re-invented by several targets so far.
Several supported hosts have insns for these, so place the
expanders out-of-line for a future introduction of tcg opcodes.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180508151437.4232-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tcg/tcg-op.h | 16 ++++++++++++++++
 tcg/tcg-op.c | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 5d2c91a1b6..0451e2752e 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -324,6 +324,10 @@ void tcg_gen_ext8u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
+void tcg_gen_smin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
+void tcg_gen_smax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
+void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
+void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 
 static inline void tcg_gen_discard_i32(TCGv_i32 arg)
 {
@@ -517,6 +521,10 @@ void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
+void tcg_gen_smin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
+void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
+void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
+void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 
 #if TCG_TARGET_REG_BITS == 64
 static inline void tcg_gen_discard_i64(TCGv_i64 arg)
@@ -1025,6 +1033,10 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
 #define tcg_gen_mulu2_tl tcg_gen_mulu2_i64
 #define tcg_gen_muls2_tl tcg_gen_muls2_i64
 #define tcg_gen_mulsu2_tl tcg_gen_mulsu2_i64
+#define tcg_gen_smin_tl tcg_gen_smin_i64
+#define tcg_gen_umin_tl tcg_gen_umin_i64
+#define tcg_gen_smax_tl tcg_gen_smax_i64
+#define tcg_gen_umax_tl tcg_gen_umax_i64
 #define tcg_gen_atomic_cmpxchg_tl tcg_gen_atomic_cmpxchg_i64
 #define tcg_gen_atomic_xchg_tl tcg_gen_atomic_xchg_i64
 #define tcg_gen_atomic_fetch_add_tl tcg_gen_atomic_fetch_add_i64
@@ -1123,6 +1135,10 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
 #define tcg_gen_mulu2_tl tcg_gen_mulu2_i32
 #define tcg_gen_muls2_tl tcg_gen_muls2_i32
 #define tcg_gen_mulsu2_tl tcg_gen_mulsu2_i32
+#define tcg_gen_smin_tl tcg_gen_smin_i32
+#define tcg_gen_umin_tl tcg_gen_umin_i32
+#define tcg_gen_smax_tl tcg_gen_smax_i32
+#define tcg_gen_umax_tl tcg_gen_umax_i32
 #define tcg_gen_atomic_cmpxchg_tl tcg_gen_atomic_cmpxchg_i32
 #define tcg_gen_atomic_xchg_tl tcg_gen_atomic_xchg_i32
 #define tcg_gen_atomic_fetch_add_tl tcg_gen_atomic_fetch_add_i32
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 34b96d68f3..5b82c3be8d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1033,6 +1033,26 @@ void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
+void tcg_gen_smin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
+{
+    tcg_gen_movcond_i32(TCG_COND_LT, ret, a, b, a, b);
+}
+
+void tcg_gen_umin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
+{
+    tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, a, b);
+}
+
+void tcg_gen_smax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
+{
+    tcg_gen_movcond_i32(TCG_COND_LT, ret, a, b, b, a);
+}
+
+void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
+{
+    tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, b, a);
+}
+
 /* 64-bit ops */
 
 #if TCG_TARGET_REG_BITS == 32
@@ -2438,6 +2458,26 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t2);
 }
 
+void tcg_gen_smin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
+{
+    tcg_gen_movcond_i64(TCG_COND_LT, ret, a, b, a, b);
+}
+
+void tcg_gen_umin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
+{
+    tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, a, b);
+}
+
+void tcg_gen_smax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
+{
+    tcg_gen_movcond_i64(TCG_COND_LT, ret, a, b, b, a);
+}
+
+void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
+{
+    tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, b, a);
+}
+
 /* Size changing operations.  */
 
 void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
-- 
2.17.0
