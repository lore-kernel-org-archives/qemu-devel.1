Received: from eggs.gnu.org ([2001:4830:134:3::10]:33511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dv1gg-0007iY-Ia
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:38:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dv1ga-0006rB-Py
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:38:42 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:24141)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dv1ga-0006qZ-Ja
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:38:36 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Thu, 21 Sep 2017 14:38:11 +0100
Message-ID: <1506001091-8296-8-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1506001091-8296-1-git-send-email-yongbok.kim@imgtec.com>
References: <1506001091-8296-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 7/7] mips: Improve macro parenthesization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>

From: Eric Blake <eblake@redhat.com>

Although none of the existing macro call-sites were broken,
it's always better to write macros that properly parenthesize
arguments that can be complex expressions, so that the intended
order of operations is not broken.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 target/mips/dsp_helper.c | 56 ++++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/target/mips/dsp_helper.c b/target/mips/dsp_helper.c
index dc70793..f152fea 100644
--- a/target/mips/dsp_helper.c
+++ b/target/mips/dsp_helper.c
@@ -45,9 +45,9 @@ typedef union {
 } DSP64Value;
 
 /*** MIPS DSP internal functions begin ***/
-#define MIPSDSP_ABS(x) (((x) >= 0) ? x : -x)
-#define MIPSDSP_OVERFLOW_ADD(a, b, c, d) (~(a ^ b) & (a ^ c) & d)
-#define MIPSDSP_OVERFLOW_SUB(a, b, c, d) ((a ^ b) & (a ^ c) & d)
+#define MIPSDSP_ABS(x) (((x) >= 0) ? (x) : -(x))
+#define MIPSDSP_OVERFLOW_ADD(a, b, c, d) (~((a) ^ (b)) & ((a) ^ (c)) & (d))
+#define MIPSDSP_OVERFLOW_SUB(a, b, c, d) (((a) ^ (b)) & ((a) ^ (c)) & (d))
 
 static inline void set_DSPControl_overflow_flag(uint32_t flag, int position,
                                                 CPUMIPSState *env)
@@ -1047,47 +1047,47 @@ static inline int32_t mipsdsp_cmpu_lt(uint32_t a, uint32_t b)
 
 #define MIPSDSP_SPLIT32_8(num, a, b, c, d)  \
     do {                                    \
-        a = (num >> 24) & MIPSDSP_Q0;       \
-        b = (num >> 16) & MIPSDSP_Q0;       \
-        c = (num >> 8) & MIPSDSP_Q0;        \
-        d = num & MIPSDSP_Q0;               \
+        a = ((num) >> 24) & MIPSDSP_Q0;     \
+        b = ((num) >> 16) & MIPSDSP_Q0;     \
+        c = ((num) >> 8) & MIPSDSP_Q0;      \
+        d = (num) & MIPSDSP_Q0;             \
     } while (0)
 
 #define MIPSDSP_SPLIT32_16(num, a, b)       \
     do {                                    \
-        a = (num >> 16) & MIPSDSP_LO;       \
-        b = num & MIPSDSP_LO;               \
+        a = ((num) >> 16) & MIPSDSP_LO;     \
+        b = (num) & MIPSDSP_LO;             \
     } while (0)
 
-#define MIPSDSP_RETURN32_8(a, b, c, d)  ((target_long)(int32_t) \
-                                         (((uint32_t)a << 24) | \
-                                         (((uint32_t)b << 16) | \
-                                         (((uint32_t)c << 8) |  \
-                                          ((uint32_t)d & 0xFF)))))
-#define MIPSDSP_RETURN32_16(a, b)       ((target_long)(int32_t) \
-                                         (((uint32_t)a << 16) | \
-                                          ((uint32_t)b & 0xFFFF)))
+#define MIPSDSP_RETURN32_8(a, b, c, d)  ((target_long)(int32_t)         \
+                                         (((uint32_t)(a) << 24) |       \
+                                          ((uint32_t)(b) << 16) |       \
+                                          ((uint32_t)(c) << 8) |        \
+                                          ((uint32_t)(d) & 0xFF)))
+#define MIPSDSP_RETURN32_16(a, b)       ((target_long)(int32_t)         \
+                                         (((uint32_t)(a) << 16) |       \
+                                          ((uint32_t)(b) & 0xFFFF)))
 
 #ifdef TARGET_MIPS64
 #define MIPSDSP_SPLIT64_16(num, a, b, c, d)  \
     do {                                     \
-        a = (num >> 48) & MIPSDSP_LO;        \
-        b = (num >> 32) & MIPSDSP_LO;        \
-        c = (num >> 16) & MIPSDSP_LO;        \
-        d = num & MIPSDSP_LO;                \
+        a = ((num) >> 48) & MIPSDSP_LO;      \
+        b = ((num) >> 32) & MIPSDSP_LO;      \
+        c = ((num) >> 16) & MIPSDSP_LO;      \
+        d = (num) & MIPSDSP_LO;              \
     } while (0)
 
 #define MIPSDSP_SPLIT64_32(num, a, b)       \
     do {                                    \
-        a = (num >> 32) & MIPSDSP_LLO;      \
-        b = num & MIPSDSP_LLO;              \
+        a = ((num) >> 32) & MIPSDSP_LLO;    \
+        b = (num) & MIPSDSP_LLO;            \
     } while (0)
 
-#define MIPSDSP_RETURN64_16(a, b, c, d) (((uint64_t)a << 48) | \
-                                         ((uint64_t)b << 32) | \
-                                         ((uint64_t)c << 16) | \
-                                         (uint64_t)d)
-#define MIPSDSP_RETURN64_32(a, b)       (((uint64_t)a << 32) | (uint64_t)b)
+#define MIPSDSP_RETURN64_16(a, b, c, d) (((uint64_t)(a) << 48) |        \
+                                         ((uint64_t)(b) << 32) |        \
+                                         ((uint64_t)(c) << 16) |        \
+                                         (uint64_t)(d))
+#define MIPSDSP_RETURN64_32(a, b)       (((uint64_t)(a) << 32) | (uint64_t)(b))
 #endif
 
 /** DSP Arithmetic Sub-class insns **/
-- 
2.7.4
