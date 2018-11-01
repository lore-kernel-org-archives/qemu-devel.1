Received: from eggs.gnu.org ([2001:4830:134:3::10]:44601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gIJdt-0000MC-LJ
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 16:32:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gIJXu-0001He-Jc
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 16:26:31 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gIJXr-0001Dc-4g
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 16:26:23 -0400
Received: by mail-wr1-x443.google.com with SMTP id y16so21340278wrw.3
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 13:26:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  1 Nov 2018 20:26:17 +0000
Message-Id: <20181101202617.6437-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] softfloat: Don't execute divdeu without power7
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

The divdeu instruction was added to ISA 2.06 (Power7).
Exclude this block from older cpus.

Fixes: 27ae5109a2ba (softfloat: Specialize udiv_qrnnd for ppc64)
Reported-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-macros.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
index c86687fa5e..b1d772e6d4 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -647,8 +647,8 @@ static inline uint64_t udiv_qrnnd(uint64_t *r, uint64_t n1,
     asm("dlgr %0, %1" : "+r"(n) : "r"(d));
     *r = n >> 64;
     return n;
-#elif defined(_ARCH_PPC64)
-    /* From Power ISA 3.0B, programming note for divdeu.  */
+#elif defined(_ARCH_PPC64) && defined(_ARCH_PWR7)
+    /* From Power ISA 2.06, programming note for divdeu.  */
     uint64_t q1, q2, Q, r1, r2, R;
     asm("divdeu %0,%2,%4; divdu %1,%3,%4"
         : "=&r"(q1), "=r"(q2)
-- 
2.17.2
