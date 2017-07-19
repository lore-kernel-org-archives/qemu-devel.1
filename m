Received: from eggs.gnu.org ([2001:4830:134:3::10]:38304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXgmm-000161-KB
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:40:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXgmj-0003ji-A2
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:40:32 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:35713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXgmi-0003is-Vp
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:40:29 -0400
Received: by mail-pg0-x241.google.com with SMTP id d193so5373350pgc.2
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 21:40:28 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 18:40:18 -1000
Message-Id: <20170719044018.18063-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH for-2.10] util: Introduce include/qemu/cpuid.h
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

Clang 3.9 passes the CONFIG_AVX2_OPT configure test.  However, the
supplied <cpuid.h> does not contain the bit_AVX2 define that we use
when detecting whether the routine can be enabled.

Introduce a qemu-specific header that uses the compiler's definition
of __cpuid et al, but supplies any missing bit_* definitions needed.
This avoids introducing any extra ifdefs to util/bufferiszero.c, and
allows quite a few to be removed from tcg/i386/tcg-target.inc.c.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---

Peter, this is the clang 3.9 problem I mentioned the other day,
when attempting to reproduce the other clang 3.8 problem.


r~

---
 include/qemu/cpuid.h      | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 tcg/i386/tcg-target.inc.c | 36 +++++++-----------------------
 util/bufferiszero.c       |  7 +++---
 configure                 | 43 +++++++++++++++++++----------------
 4 files changed, 92 insertions(+), 51 deletions(-)
 create mode 100644 include/qemu/cpuid.h

diff --git a/include/qemu/cpuid.h b/include/qemu/cpuid.h
new file mode 100644
index 0000000..6930170
--- /dev/null
+++ b/include/qemu/cpuid.h
@@ -0,0 +1,57 @@
+/* cpuid.h: Macros to identify the properties of an x86 host.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_CPUID_H
+#define QEMU_CPUID_H
+
+#ifndef CONFIG_CPUID_H
+# error "<cpuid.h> is unusable with this compiler"
+#endif
+
+#include <cpuid.h>
+
+/* Cover the uses that we have within qemu.  */
+/* ??? Irritating that we have the same information in target/i386/.  */
+
+/* Leaf 1, %edx */
+#ifndef bit_CMOV
+#define bit_CMOV        (1 << 15)
+#endif
+#ifndef bit_SSE2
+#define bit_SSE2        (1 << 26)
+#endif
+
+/* Leaf 1, %ecx */
+#ifndef bit_SSE4_1
+#define bit_SSE4_1      (1 << 19)
+#endif
+#ifndef bit_MOVBE
+#define bit_MOVBE       (1 << 22)
+#endif
+#ifndef bit_OSXSAVE
+#define bit_OSXSAVE     (1 << 27)
+#endif
+#ifndef bit_AVX
+#define bit_AVX         (1 << 28)
+#endif
+
+/* Leaf 7, %ebx */
+#ifndef bit_BMI
+#define bit_BMI         (1 << 3)
+#endif
+#ifndef bit_AVX2
+#define bit_AVX2        (1 << 5)
+#endif
+#ifndef bit_BMI2
+#define bit_BMI2        (1 << 8)
+#endif
+
+/* Leaf 0x80000001, %ecx */
+#ifndef bit_LZCNT
+#define bit_LZCNT       (1 << 5)
+#endif
+
+#endif /* QEMU_CPUID_H */
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 01e3b4e..e4b120a 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -109,40 +109,30 @@ static const int tcg_target_call_oarg_regs[] = {
    detection, as we're not going to go so far as our own inline assembly.
    If not available, default values will be assumed.  */
 #if defined(CONFIG_CPUID_H)
-#include <cpuid.h>
+#include "qemu/cpuid.h"
 #endif
 
-/* For 32-bit, we are going to attempt to determine at runtime whether cmov
-   is available.  */
+/* For 64-bit, we always know that CMOV is available.  */
 #if TCG_TARGET_REG_BITS == 64
 # define have_cmov 1
-#elif defined(CONFIG_CPUID_H) && defined(bit_CMOV)
+#elif defined(CONFIG_CPUID_H)
 static bool have_cmov;
 #else
 # define have_cmov 0
 #endif
 
-/* If bit_MOVBE is defined in cpuid.h (added in GCC version 4.6), we are
-   going to attempt to determine at runtime whether movbe is available.  */
-#if defined(CONFIG_CPUID_H) && defined(bit_MOVBE)
-static bool have_movbe;
-#else
-# define have_movbe 0
-#endif
-
 /* We need these symbols in tcg-target.h, and we can't properly conditionalize
    it there.  Therefore we always define the variable.  */
 bool have_bmi1;
 bool have_popcnt;
 
-#if defined(CONFIG_CPUID_H) && defined(bit_BMI2)
+#ifdef CONFIG_CPUID_H
+static bool have_movbe;
 static bool have_bmi2;
-#else
-# define have_bmi2 0
-#endif
-#if defined(CONFIG_CPUID_H) && defined(bit_LZCNT)
 static bool have_lzcnt;
 #else
+# define have_movbe 0
+# define have_bmi2 0
 # define have_lzcnt 0
 #endif
 
@@ -2619,36 +2609,26 @@ static void tcg_target_init(TCGContext *s)
            available, we'll use a small forward branch.  */
         have_cmov = (d & bit_CMOV) != 0;
 #endif
-#ifndef have_movbe
         /* MOVBE is only available on Intel Atom and Haswell CPUs, so we
            need to probe for it.  */
         have_movbe = (c & bit_MOVBE) != 0;
-#endif
-#ifdef bit_POPCNT
         have_popcnt = (c & bit_POPCNT) != 0;
-#endif
     }
 
     if (max >= 7) {
         /* BMI1 is available on AMD Piledriver and Intel Haswell CPUs.  */
         __cpuid_count(7, 0, a, b, c, d);
-#ifdef bit_BMI
         have_bmi1 = (b & bit_BMI) != 0;
-#endif
-#ifndef have_bmi2
         have_bmi2 = (b & bit_BMI2) != 0;
-#endif
     }
-#endif
 
-#ifndef have_lzcnt
     max = __get_cpuid_max(0x8000000, 0);
     if (max >= 1) {
         __cpuid(0x80000001, a, b, c, d);
         /* LZCNT was introduced with AMD Barcelona and Intel Haswell CPUs.  */
         have_lzcnt = (c & bit_LZCNT) != 0;
     }
-#endif
+#endif /* CONFIG_CPUID_H */
 
     if (TCG_TARGET_REG_BITS == 64) {
         tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_I32], 0, 0xffff);
diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index eb974b7..2178d8a 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -197,7 +197,7 @@ buffer_zero_avx2(const void *buf, size_t len)
 
 /* Make sure that these variables are appropriately initialized when
  * SSE2 is enabled on the compiler command-line, but the compiler is
- * too old to support <cpuid.h>.
+ * too old to support CONFIG_AVX2_OPT.
  */
 #ifdef CONFIG_AVX2_OPT
 # define INIT_CACHE 0
@@ -231,7 +231,8 @@ static void init_accel(unsigned cache)
 }
 
 #ifdef CONFIG_AVX2_OPT
-#include <cpuid.h>
+#include "qemu/cpuid.h"
+
 static void __attribute__((constructor)) init_cpuid_cache(void)
 {
     int max = __get_cpuid_max(0, NULL);
@@ -243,7 +244,6 @@ static void __attribute__((constructor)) init_cpuid_cache(void)
         if (d & bit_SSE2) {
             cache |= CACHE_SSE2;
         }
-#ifdef CONFIG_AVX2_OPT
         if (c & bit_SSE4_1) {
             cache |= CACHE_SSE4;
         }
@@ -257,7 +257,6 @@ static void __attribute__((constructor)) init_cpuid_cache(void)
                 cache |= CACHE_AVX2;
             }
         }
-#endif
     }
     cpuid_cache = cache;
     init_accel(cache);
diff --git a/configure b/configure
index e8798ce..63a890e 100755
--- a/configure
+++ b/configure
@@ -358,6 +358,7 @@ libusb=""
 usb_redir=""
 opengl=""
 opengl_dmabuf="no"
+cpuid_h="no"
 avx2_opt="no"
 zlib="yes"
 lzo=""
@@ -1932,24 +1933,6 @@ EOF
   fi
 fi
 
-##########################################
-# avx2 optimization requirement check
-
-cat > $TMPC << EOF
-#pragma GCC push_options
-#pragma GCC target("avx2")
-#include <cpuid.h>
-#include <immintrin.h>
-static int bar(void *a) {
-    __m256i x = *(__m256i *)a;
-    return _mm256_testz_si256(x, x);
-}
-int main(int argc, char *argv[]) { return bar(argv[0]); }
-EOF
-if compile_object "" ; then
-  avx2_opt="yes"
-fi
-
 #########################################
 # zlib check
 
@@ -4629,7 +4612,6 @@ fi
 ########################################
 # check if cpuid.h is usable.
 
-cpuid_h=no
 cat > $TMPC << EOF
 #include <cpuid.h>
 int main(void) {
@@ -4651,6 +4633,29 @@ if compile_prog "" "" ; then
     cpuid_h=yes
 fi
 
+##########################################
+# avx2 optimization requirement check
+#
+# There is no point enabling this if cpuid.h is not usable,
+# since we won't be able to select the new routines.
+
+if test $cpuid_h = yes; then
+  cat > $TMPC << EOF
+#pragma GCC push_options
+#pragma GCC target("avx2")
+#include <cpuid.h>
+#include <immintrin.h>
+static int bar(void *a) {
+    __m256i x = *(__m256i *)a;
+    return _mm256_testz_si256(x, x);
+}
+int main(int argc, char *argv[]) { return bar(argv[0]); }
+EOF
+  if compile_object "" ; then
+    avx2_opt="yes"
+  fi
+fi
+
 ########################################
 # check if __[u]int128_t is usable.
 
-- 
2.9.4
