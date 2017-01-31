Received: from eggs.gnu.org ([2001:4830:134:3::10]:43945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cYb5A-00023F-Sf
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:15:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cYb59-0007j0-Jt
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:15:00 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Jan 2017 16:14:47 +0000
Message-Id: <1485879287-12548-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] Drop QEMU_GNUC_PREREQ() checks for gcc older
 than 4.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

We already require gcc 4.1 or newer (for the atomic
support), so the fallback codepaths for older gcc
versions than that are now dead code and we can
just delete them.

NB: clang reports itself as gcc 4.2 (regardless of
clang version), so clang won't be using the fallbacks
either.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
For compatibility with clang we should probably try to avoid
using QEMU_GNUC_PREREQ() and instead have something in
compiler.h that abstracts away whether the test for "does
the compiler support feature foo" is via a GCC version
check or a clang __has_feature or whatever.


 include/qemu/compiler.h   |   8 ---
 include/qemu/host-utils.h | 121 ----------------------------------------------
 tcg/arm/tcg-target.h      |   7 ---
 3 files changed, 136 deletions(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 157698b..fc12e49 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -24,17 +24,9 @@
 
 #define QEMU_NORETURN __attribute__ ((__noreturn__))
 
-#if QEMU_GNUC_PREREQ(3, 4)
 #define QEMU_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
-#else
-#define QEMU_WARN_UNUSED_RESULT
-#endif
 
-#if QEMU_GNUC_PREREQ(4, 0)
 #define QEMU_SENTINEL __attribute__((sentinel))
-#else
-#define QEMU_SENTINEL
-#endif
 
 #if QEMU_GNUC_PREREQ(4, 3)
 #define QEMU_ARTIFICIAL __attribute__((always_inline, artificial))
diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index 96288d0..e0d5b0e 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -115,37 +115,7 @@ static inline uint64_t muldiv64(uint64_t a, uint32_t b, uint32_t c)
  */
 static inline int clz32(uint32_t val)
 {
-#if QEMU_GNUC_PREREQ(3, 4)
     return val ? __builtin_clz(val) : 32;
-#else
-    /* Binary search for the leading one bit.  */
-    int cnt = 0;
-
-    if (!(val & 0xFFFF0000U)) {
-        cnt += 16;
-        val <<= 16;
-    }
-    if (!(val & 0xFF000000U)) {
-        cnt += 8;
-        val <<= 8;
-    }
-    if (!(val & 0xF0000000U)) {
-        cnt += 4;
-        val <<= 4;
-    }
-    if (!(val & 0xC0000000U)) {
-        cnt += 2;
-        val <<= 2;
-    }
-    if (!(val & 0x80000000U)) {
-        cnt++;
-        val <<= 1;
-    }
-    if (!(val & 0x80000000U)) {
-        cnt++;
-    }
-    return cnt;
-#endif
 }
 
 /**
@@ -168,19 +138,7 @@ static inline int clo32(uint32_t val)
  */
 static inline int clz64(uint64_t val)
 {
-#if QEMU_GNUC_PREREQ(3, 4)
     return val ? __builtin_clzll(val) : 64;
-#else
-    int cnt = 0;
-
-    if (!(val >> 32)) {
-        cnt += 32;
-    } else {
-        val >>= 32;
-    }
-
-    return cnt + clz32(val);
-#endif
 }
 
 /**
@@ -203,39 +161,7 @@ static inline int clo64(uint64_t val)
  */
 static inline int ctz32(uint32_t val)
 {
-#if QEMU_GNUC_PREREQ(3, 4)
     return val ? __builtin_ctz(val) : 32;
-#else
-    /* Binary search for the trailing one bit.  */
-    int cnt;
-
-    cnt = 0;
-    if (!(val & 0x0000FFFFUL)) {
-        cnt += 16;
-        val >>= 16;
-    }
-    if (!(val & 0x000000FFUL)) {
-        cnt += 8;
-        val >>= 8;
-    }
-    if (!(val & 0x0000000FUL)) {
-        cnt += 4;
-        val >>= 4;
-    }
-    if (!(val & 0x00000003UL)) {
-        cnt += 2;
-        val >>= 2;
-    }
-    if (!(val & 0x00000001UL)) {
-        cnt++;
-        val >>= 1;
-    }
-    if (!(val & 0x00000001UL)) {
-        cnt++;
-    }
-
-    return cnt;
-#endif
 }
 
 /**
@@ -258,19 +184,7 @@ static inline int cto32(uint32_t val)
  */
 static inline int ctz64(uint64_t val)
 {
-#if QEMU_GNUC_PREREQ(3, 4)
     return val ? __builtin_ctzll(val) : 64;
-#else
-    int cnt;
-
-    cnt = 0;
-    if (!((uint32_t)val)) {
-        cnt += 32;
-        val >>= 32;
-    }
-
-    return cnt + ctz32(val);
-#endif
 }
 
 /**
@@ -322,15 +236,7 @@ static inline int clrsb64(uint64_t val)
  */
 static inline int ctpop8(uint8_t val)
 {
-#if QEMU_GNUC_PREREQ(3, 4)
     return __builtin_popcount(val);
-#else
-    val = (val & 0x55) + ((val >> 1) & 0x55);
-    val = (val & 0x33) + ((val >> 2) & 0x33);
-    val = (val + (val >> 4)) & 0x0f;
-
-    return val;
-#endif
 }
 
 /**
@@ -339,16 +245,7 @@ static inline int ctpop8(uint8_t val)
  */
 static inline int ctpop16(uint16_t val)
 {
-#if QEMU_GNUC_PREREQ(3, 4)
     return __builtin_popcount(val);
-#else
-    val = (val & 0x5555) + ((val >> 1) & 0x5555);
-    val = (val & 0x3333) + ((val >> 2) & 0x3333);
-    val = (val + (val >> 4)) & 0x0f0f;
-    val = (val + (val >> 8)) & 0x00ff;
-
-    return val;
-#endif
 }
 
 /**
@@ -357,16 +254,7 @@ static inline int ctpop16(uint16_t val)
  */
 static inline int ctpop32(uint32_t val)
 {
-#if QEMU_GNUC_PREREQ(3, 4)
     return __builtin_popcount(val);
-#else
-    val = (val & 0x55555555) + ((val >> 1) & 0x55555555);
-    val = (val & 0x33333333) + ((val >> 2) & 0x33333333);
-    val = (val + (val >> 4)) & 0x0f0f0f0f;
-    val = (val * 0x01010101) >> 24;
-
-    return val;
-#endif
 }
 
 /**
@@ -375,16 +263,7 @@ static inline int ctpop32(uint32_t val)
  */
 static inline int ctpop64(uint64_t val)
 {
-#if QEMU_GNUC_PREREQ(3, 4)
     return __builtin_popcountll(val);
-#else
-    val = (val & 0x5555555555555555ULL) + ((val >> 1) & 0x5555555555555555ULL);
-    val = (val & 0x3333333333333333ULL) + ((val >> 2) & 0x3333333333333333ULL);
-    val = (val + (val >> 4)) & 0x0f0f0f0f0f0f0f0fULL;
-    val = (val * 0x0101010101010101ULL) >> 56;
-
-    return val;
-#endif
 }
 
 /**
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 09a19c6..75ea247 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -130,14 +130,7 @@ enum {
 
 static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
 {
-#if QEMU_GNUC_PREREQ(4, 1)
     __builtin___clear_cache((char *) start, (char *) stop);
-#else
-    register uintptr_t _beg __asm("a1") = start;
-    register uintptr_t _end __asm("a2") = stop;
-    register uintptr_t _flg __asm("a3") = 0;
-    __asm __volatile__ ("swi 0x9f0002" : : "r" (_beg), "r" (_end), "r" (_flg));
-#endif
 }
 
 #endif
-- 
2.7.4
