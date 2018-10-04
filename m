Received: from eggs.gnu.org ([2001:4830:134:3::10]:32814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g87sM-0006Fu-JT
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 13:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g87sK-0005vW-ME
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 13:57:26 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g87sK-0005mq-4h
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 13:57:24 -0400
Received: by mail-oi1-x243.google.com with SMTP id 22-v6so7235216oiz.2
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 10:57:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  4 Oct 2018 12:57:00 -0500
Message-Id: <20181004175700.20847-5-richard.henderson@linaro.org>
In-Reply-To: <20181004175700.20847-1-richard.henderson@linaro.org>
References: <20181004175700.20847-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 4/4] softfloat: Specialize udiv_qrnnd for
 ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, cota@braap.org

The ISA has a 128/64-bit division instruction, though it assumes the
low 64-bits of the numerator are 0, and so requires a bit more fixup
than a full 128-bit division insn.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-macros.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
index eafc68932b..c86687fa5e 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -647,6 +647,22 @@ static inline uint64_t udiv_qrnnd(uint64_t *r, uint64_t n1,
     asm("dlgr %0, %1" : "+r"(n) : "r"(d));
     *r = n >> 64;
     return n;
+#elif defined(_ARCH_PPC64)
+    /* From Power ISA 3.0B, programming note for divdeu.  */
+    uint64_t q1, q2, Q, r1, r2, R;
+    asm("divdeu %0,%2,%4; divdu %1,%3,%4"
+        : "=&r"(q1), "=r"(q2)
+        : "r"(n1), "r"(n0), "r"(d));
+    r1 = -(q1 * d);         /* low part of (n1<<64) - (q1 * d) */
+    r2 = n0 - (q2 * d);
+    Q = q1 + q2;
+    R = r1 + r2;
+    if (R >= d || R < r2) { /* overflow implies R > d */
+        Q += 1;
+        R -= d;
+    }
+    *r = R;
+    return Q;
 #else
     uint64_t d0, d1, q0, q1, r1, r0, m;
 
-- 
2.17.1
