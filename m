Received: from eggs.gnu.org ([2001:4830:134:3::10]:55403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7lYf-0002f5-VH
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:07:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7lYb-0005Am-Ta
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:07:37 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:43579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g7lYb-000478-KP
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:07:33 -0400
Received: by mail-oi1-x230.google.com with SMTP id s69-v6so5288521oie.10
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 11:07:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Oct 2018 13:07:09 -0500
Message-Id: <20181003180711.19335-3-richard.henderson@linaro.org>
In-Reply-To: <20181003180711.19335-1-richard.henderson@linaro.org>
References: <20181003180711.19335-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 2/4] softfloat: Specialize udiv_qrnnd for
 x86_64
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

The ISA has a 128/64-bit division instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-macros.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
index 03312471b2..6d58615709 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -622,6 +622,11 @@ static inline uint64_t estimateDiv128To64(uint64_t a0, uint64_t a1, uint64_t b)
 static inline uint64_t udiv_qrnnd(uint64_t *r, uint64_t n1,
                                   uint64_t n0, uint64_t d)
 {
+#if defined(__x86_64__)
+    uint64_t q;
+    asm("divq %4" : "=a"(q), "=d"(*r) : "0"(n0), "1"(n1), "rm"(d));
+    return q;
+#else
     uint64_t d0, d1, q0, q1, r1, r0, m;
 
     d0 = (uint32_t)d;
@@ -661,6 +666,7 @@ static inline uint64_t udiv_qrnnd(uint64_t *r, uint64_t n1,
 
     *r = r0;
     return (q1 << 32) | q0;
+#endif
 }
 
 /*----------------------------------------------------------------------------
-- 
2.17.1
