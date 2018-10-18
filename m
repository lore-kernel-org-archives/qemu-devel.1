Received: from eggs.gnu.org ([2001:4830:134:3::10]:47907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gDDXn-0004cH-Ld
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 15:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gDDXj-00010i-G9
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 15:01:15 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:40881)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gDDXj-0000zH-62
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 15:01:11 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 18 Oct 2018 21:00:25 +0200
Message-Id: <20181018190026.9494-2-laurent@vivier.eu>
In-Reply-To: <20181018190026.9494-1-laurent@vivier.eu>
References: <20181018190026.9494-1-laurent@vivier.eu>
Subject: [Qemu-devel] [2 1/2] linux-user: Suppress address-of-packed-member
 warnings in __get/put_user_e
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

Our __get_user_e() and __put_user_e() macros cause newer versions
of clang to generate false-positive -Waddress-of-packed-member
warnings if they are passed the address of a member of a packed
struct (see https://bugs.llvm.org/show_bug.cgi?id=39113).
Suppress these using the _Pragma() operator. Unfortunately
_Pragma() support in gcc is broken in some gcc versions and
in some usage contexts, so we limit the pragma usage here to clang.

To put in the pragmas we need to convert the macros from
expressions to statements, but all the callsites effectively
treat them as statements already so this is OK.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20181009161814.21257-1-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/qemu.h | 74 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 53 insertions(+), 21 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index b4959e41c6..1beb6a2cfc 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -461,27 +461,59 @@ static inline int access_ok(int type, abi_ulong addr, abi_ulong size)
    These are usually used to access struct data members once the struct has
    been locked - usually with lock_user_struct.  */
 
-/* Tricky points:
-   - Use __builtin_choose_expr to avoid type promotion from ?:,
-   - Invalid sizes result in a compile time error stemming from
-     the fact that abort has no parameters.
-   - It's easier to use the endian-specific unaligned load/store
-     functions than host-endian unaligned load/store plus tswapN.  */
-
-#define __put_user_e(x, hptr, e)                                        \
-  (__builtin_choose_expr(sizeof(*(hptr)) == 1, stb_p,                   \
-   __builtin_choose_expr(sizeof(*(hptr)) == 2, stw_##e##_p,             \
-   __builtin_choose_expr(sizeof(*(hptr)) == 4, stl_##e##_p,             \
-   __builtin_choose_expr(sizeof(*(hptr)) == 8, stq_##e##_p, abort))))   \
-     ((hptr), (x)), (void)0)
-
-#define __get_user_e(x, hptr, e)                                        \
-  ((x) = (typeof(*hptr))(                                               \
-   __builtin_choose_expr(sizeof(*(hptr)) == 1, ldub_p,                  \
-   __builtin_choose_expr(sizeof(*(hptr)) == 2, lduw_##e##_p,            \
-   __builtin_choose_expr(sizeof(*(hptr)) == 4, ldl_##e##_p,             \
-   __builtin_choose_expr(sizeof(*(hptr)) == 8, ldq_##e##_p, abort))))   \
-     (hptr)), (void)0)
+/*
+ * Tricky points:
+ * - Use __builtin_choose_expr to avoid type promotion from ?:,
+ * - Invalid sizes result in a compile time error stemming from
+ *   the fact that abort has no parameters.
+ * - It's easier to use the endian-specific unaligned load/store
+ *   functions than host-endian unaligned load/store plus tswapN.
+ * - The pragmas are necessary only to silence a clang false-positive
+ *   warning: see https://bugs.llvm.org/show_bug.cgi?id=39113 .
+ * - We have to disable -Wpragmas warnings to avoid a complaint about
+ *   an unknown warning type from older compilers that don't know about
+ *   -Waddress-of-packed-member.
+ * - gcc has bugs in its _Pragma() support in some versions, eg
+ *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83256 -- so we only
+ *   include the warning-suppression pragmas for clang
+ */
+#ifdef __clang__
+#define PRAGMA_DISABLE_PACKED_WARNING                                   \
+    _Pragma("GCC diagnostic push");                                     \
+    _Pragma("GCC diagnostic ignored \"-Wpragmas\"");                    \
+    _Pragma("GCC diagnostic ignored \"-Waddress-of-packed-member\"")
+
+#define PRAGMA_REENABLE_PACKED_WARNING          \
+    _Pragma("GCC diagnostic pop")
+
+#else
+#define PRAGMA_DISABLE_PACKED_WARNING
+#define PRAGMA_REENABLE_PACKED_WARNING
+#endif
+
+#define __put_user_e(x, hptr, e)                                            \
+    do {                                                                    \
+        PRAGMA_DISABLE_PACKED_WARNING;                                      \
+        (__builtin_choose_expr(sizeof(*(hptr)) == 1, stb_p,                 \
+        __builtin_choose_expr(sizeof(*(hptr)) == 2, stw_##e##_p,            \
+        __builtin_choose_expr(sizeof(*(hptr)) == 4, stl_##e##_p,            \
+        __builtin_choose_expr(sizeof(*(hptr)) == 8, stq_##e##_p, abort))))  \
+            ((hptr), (x)), (void)0);                                        \
+        PRAGMA_REENABLE_PACKED_WARNING;                                     \
+    } while (0)
+
+#define __get_user_e(x, hptr, e)                                            \
+    do {                                                                    \
+        PRAGMA_DISABLE_PACKED_WARNING;                                      \
+        ((x) = (typeof(*hptr))(                                             \
+        __builtin_choose_expr(sizeof(*(hptr)) == 1, ldub_p,                 \
+        __builtin_choose_expr(sizeof(*(hptr)) == 2, lduw_##e##_p,           \
+        __builtin_choose_expr(sizeof(*(hptr)) == 4, ldl_##e##_p,            \
+        __builtin_choose_expr(sizeof(*(hptr)) == 8, ldq_##e##_p, abort))))  \
+            (hptr)), (void)0);                                              \
+        PRAGMA_REENABLE_PACKED_WARNING;                                     \
+    } while (0)
+
 
 #ifdef TARGET_WORDS_BIGENDIAN
 # define __put_user(x, hptr)  __put_user_e(x, hptr, be)
-- 
2.17.2
