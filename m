Received: from eggs.gnu.org ([2001:4830:134:3::10]:44396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duJH4-0005WL-I0
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:13:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duJGy-0004Bz-RC
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:13:18 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 19 Sep 2017 09:13:07 -0500
Message-Id: <20170919141307.23113-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] mips: Improve macro parenthesization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>

Although none of the existing macro call-sites were broken,
it's always better to write macros that properly parenthesize
arguments that can be complex expressions, so that the intended
order of operations is not broken.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 target/mips/dsp_helper.c | 56 ++++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/target/mips/dsp_helper.c b/target/mips/dsp_helper.c
index dc707934ea..f152fea34a 100644
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
2.13.5
