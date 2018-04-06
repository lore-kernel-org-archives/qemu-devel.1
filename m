Received: from eggs.gnu.org ([2001:4830:134:3::10]:56984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f4Fjv-00023I-SM
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 21:00:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f4Fju-0000D4-A6
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 21:00:27 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:45840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f4Fju-0000Bj-0w
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 21:00:26 -0400
Received: by mail-pl0-x244.google.com with SMTP id v18-v6so19636367ply.12
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 18:00:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  6 Apr 2018 11:00:15 +1000
Message-Id: <20180406010015.16979-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] tcg: Fix out-of-line generic vector compares
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G . Cota" <cota@braap.org>, thuth@redhat.com, alex.bennee@linaro.org

A mistake in the type passed to sizeof, that happens to work
when the out-of-line fallback itself is using host vectors,
but fails when using only the base types.

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
