Received: from eggs.gnu.org ([2001:4830:134:3::10]:51242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZTRd-0007wa-Lk
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 23:26:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZTML-0006Mz-3E
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 23:21:25 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZTMJ-0006Km-Iy
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 23:21:23 -0500
Received: by mail-pl1-x642.google.com with SMTP id u6so8851156plm.8
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 20:21:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 18 Dec 2018 20:21:08 -0800
Message-Id: <20181219042113.7364-4-richard.henderson@linaro.org>
In-Reply-To: <20181219042113.7364-1-richard.henderson@linaro.org>
References: <20181219042113.7364-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 3/8] linux-user: Reduce regpairs_aligned &
 target_offset64 ifdefs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 54 ++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7118f07441..d4c11c3e93 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -474,37 +474,38 @@ static inline int next_free_host_timer(void)
 }
 #endif
 
-/* ARM EABI and MIPS expect 64bit types aligned even on pairs or registers */
+/*
+ * Returns true if syscall NUM expects 64bit types aligned even
+ * on pairs of registers.
+ */
+static inline bool regpairs_aligned(void *cpu_env, int num)
+{
 #ifdef TARGET_ARM
-static inline int regpairs_aligned(void *cpu_env, int num)
-{
-    return ((((CPUARMState *)cpu_env)->eabi) == 1) ;
-}
-#elif defined(TARGET_MIPS) && (TARGET_ABI_BITS == 32)
-static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
+    return ((CPUARMState *)cpu_env)->eabi;
+#elif defined(TARGET_MIPS) && TARGET_ABI_BITS == 32
+    return true;
 #elif defined(TARGET_PPC) && !defined(TARGET_PPC64)
-/* SysV AVI for PPC32 expects 64bit parameters to be passed on odd/even pairs
- * of registers which translates to the same as ARM/MIPS, because we start with
- * r3 as arg1 */
-static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
+    /*
+     * SysV AVI for PPC32 expects 64bit parameters to be passed on
+     * odd/even pairs of registers which translates to the same as
+     * we start with r3 as arg1.
+     */
+    return true;
 #elif defined(TARGET_SH4)
-/* SH4 doesn't align register pairs, except for p{read,write}64 */
-static inline int regpairs_aligned(void *cpu_env, int num)
-{
+    /* SH4 doesn't align register pairs, except for p{read,write}64.  */
     switch (num) {
     case TARGET_NR_pread64:
     case TARGET_NR_pwrite64:
-        return 1;
-
+        return true;
     default:
-        return 0;
+        return false;
     }
-}
 #elif defined(TARGET_XTENSA)
-static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
+    return true;
 #else
-static inline int regpairs_aligned(void *cpu_env, int num) { return 0; }
+    return false;
 #endif
+}
 
 #define ERRNO_TABLE_SIZE 1200
 
@@ -6066,21 +6067,16 @@ void syscall_init(void)
     }
 }
 
-#if TARGET_ABI_BITS == 32
-static inline uint64_t target_offset64(uint32_t word0, uint32_t word1)
+static inline uint64_t target_offset64(abi_ulong word0, abi_ulong word1)
 {
-#ifdef TARGET_WORDS_BIGENDIAN
+#if TARGET_ABI_BITS == 64
+    return word0;
+#elif defined(TARGET_WORDS_BIGENDIAN)
     return ((uint64_t)word0 << 32) | word1;
 #else
     return ((uint64_t)word1 << 32) | word0;
 #endif
 }
-#else /* TARGET_ABI_BITS == 32 */
-static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
-{
-    return word0;
-}
-#endif /* TARGET_ABI_BITS != 32 */
 
 #ifdef TARGET_NR_truncate64
 static inline abi_long target_truncate64(void *cpu_env, const char *arg1,
-- 
2.17.2
