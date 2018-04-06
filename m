Received: from eggs.gnu.org ([2001:4830:134:3::10]:52802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f4RCU-0005nG-AB
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:14:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f4RCT-0001qU-Ei
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:14:42 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:40605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f4RCT-0001qD-A5
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:14:41 -0400
Received: by mail-pf0-x242.google.com with SMTP id y66so701118pfi.7
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 06:14:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  6 Apr 2018 23:14:30 +1000
Message-Id: <20180406131430.23432-2-richard.henderson@linaro.org>
In-Reply-To: <20180406131430.23432-1-richard.henderson@linaro.org>
References: <20180406131430.23432-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL for-2.12 1/1] tcg: Fix out-of-line generic
 vector compares
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

A mistake in the type passed to sizeof, that happens to work
when the out-of-line fallback itself is using host vectors,
but fails when using only the base types.

Tested-by: Emilio G. Cota <cota@braap.org>
Reported-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime-gvec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index 8bf8d63912..90340e56e0 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -705,7 +705,7 @@ void HELPER(NAME)(void *d, void *a, void *b, uint32_t desc)                \
 {                                                                          \
     intptr_t oprsz = simd_oprsz(desc);                                     \
     intptr_t i;                                                            \
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {                           \
+    for (i = 0; i < oprsz; i += sizeof(TYPE)) {                            \
         *(TYPE *)(d + i) = DO_CMP0(*(TYPE *)(a + i) OP *(TYPE *)(b + i));  \
     }                                                                      \
     clear_high(d, oprsz, desc);                                            \
-- 
2.14.3
