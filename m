Received: from eggs.gnu.org ([2001:4830:134:3::10]:32770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g87sH-0006Ds-AF
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 13:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g87s5-0005k9-H9
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 13:57:14 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g87s5-0005jo-BR
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 13:57:09 -0400
Received: by mail-ot1-x342.google.com with SMTP id j9-v6so10076093otl.2
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 10:57:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  4 Oct 2018 12:56:58 -0500
Message-Id: <20181004175700.20847-3-richard.henderson@linaro.org>
In-Reply-To: <20181004175700.20847-1-richard.henderson@linaro.org>
References: <20181004175700.20847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 2/4] softfloat: Specialize udiv_qrnnd for
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

Tested-by: Emilio G. Cota <cota@braap.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-macros.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
index a1d99c730d..39eb08b4f1 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -637,6 +637,11 @@ static inline uint64_t estimateDiv128To64(uint64_t a0, uint64_t a1, uint64_t b)
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
@@ -676,6 +681,7 @@ static inline uint64_t udiv_qrnnd(uint64_t *r, uint64_t n1,
 
     *r = r0;
     return (q1 << 32) | q0;
+#endif
 }
 
 /*----------------------------------------------------------------------------
-- 
2.17.1
