Received: from eggs.gnu.org ([2001:4830:134:3::10]:42267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gIGwT-0007lM-7T
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:39:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gIGwH-0004H0-K6
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:39:33 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:51917)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gIGw9-0004Cb-B2
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:39:20 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  1 Nov 2018 18:38:52 +0100
Message-Id: <20181101173852.27257-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH] softfloat: don't execute ppc64 ISA 3.0B
 instruction if it is not supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>

commit 27ae5109a2 has introduced an assembly instruction only supported
by ISA 3.0B and it fails to execute on previous versions of the POWER
CPU (like PowerPC G5).

This patch fixes that by checking the ISA level, and falls back to
the default C function if the instruction is not supported.

Fixes: 27ae5109a2ba8b6b679cce3e03e16570a34390a0
       (softfloat: Specialize udiv_qrnnd for ppc64)
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/fpu/softfloat-macros.h | 39 ++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
index c86687fa5e..fe98b33df9 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -78,6 +78,9 @@ this code that are retained.
 /* Portions of this work are licensed under the terms of the GNU GPL,
  * version 2 or later. See the COPYING file in the top-level directory.
  */
+#if defined(_ARCH_PPC64)
+extern bool have_isa_3_00;
+#endif
 
 /*----------------------------------------------------------------------------
 | Shifts `a' right by the number of bits given in `count'.  If any nonzero
@@ -647,25 +650,29 @@ static inline uint64_t udiv_qrnnd(uint64_t *r, uint64_t n1,
     asm("dlgr %0, %1" : "+r"(n) : "r"(d));
     *r = n >> 64;
     return n;
-#elif defined(_ARCH_PPC64)
-    /* From Power ISA 3.0B, programming note for divdeu.  */
-    uint64_t q1, q2, Q, r1, r2, R;
-    asm("divdeu %0,%2,%4; divdu %1,%3,%4"
-        : "=&r"(q1), "=r"(q2)
-        : "r"(n1), "r"(n0), "r"(d));
-    r1 = -(q1 * d);         /* low part of (n1<<64) - (q1 * d) */
-    r2 = n0 - (q2 * d);
-    Q = q1 + q2;
-    R = r1 + r2;
-    if (R >= d || R < r2) { /* overflow implies R > d */
-        Q += 1;
-        R -= d;
-    }
-    *r = R;
-    return Q;
 #else
     uint64_t d0, d1, q0, q1, r1, r0, m;
 
+#if defined(_ARCH_PPC64)
+    if (have_isa_3_00) {
+        /* From Power ISA 3.0B, programming note for divdeu.  */
+        uint64_t q1, q2, Q, r1, r2, R;
+        asm("divdeu %0,%2,%4; divdu %1,%3,%4"
+            : "=&r"(q1), "=r"(q2)
+            : "r"(n1), "r"(n0), "r"(d));
+        r1 = -(q1 * d);         /* low part of (n1<<64) - (q1 * d) */
+        r2 = n0 - (q2 * d);
+        Q = q1 + q2;
+        R = r1 + r2;
+        if (R >= d || R < r2) { /* overflow implies R > d */
+            Q += 1;
+            R -= d;
+        }
+        *r = R;
+        return Q;
+    }
+#endif
+
     d0 = (uint32_t)d;
     d1 = d >> 32;
 
-- 
2.17.2
