Received: from eggs.gnu.org ([2001:4830:134:3::10]:52135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gJFb9-0005Dh-Qk
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 05:25:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gJFKk-0007Am-Qn
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 05:08:47 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:42641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gJFKh-000755-40
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 05:08:40 -0500
Received: by mail-wr1-x42a.google.com with SMTP id y15-v6so6232110wru.9
	for <qemu-devel@nongnu.org>; Sun, 04 Nov 2018 02:08:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun,  4 Nov 2018 10:08:26 +0000
Message-Id: <20181104100826.15143-2-richard.henderson@linaro.org>
In-Reply-To: <20181104100826.15143-1-richard.henderson@linaro.org>
References: <20181104100826.15143-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 1/1] softfloat: Don't execute divdeu without
 power7
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
