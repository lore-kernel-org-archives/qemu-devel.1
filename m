Received: from eggs.gnu.org ([2001:4830:134:3::10]:41369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYh4k-00041N-0g
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 20:15:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYh4h-0006dI-Km
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 20:15:45 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:42625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYh4h-0006bo-F7
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 20:15:43 -0400
Received: by mail-pf0-x22a.google.com with SMTP id v9-v6so2217450pff.9
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 17:15:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Jun 2018 17:15:33 -0700
Message-Id: <20180629001538.11415-2-richard.henderson@linaro.org>
In-Reply-To: <20180629001538.11415-1-richard.henderson@linaro.org>
References: <20180629001538.11415-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/6] target/arm: Fix SVE signed division vs x86
 overflow exception
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

We already check for the same condition within the normal integer
sdiv and sdiv64 helpers.  Use a slightly different formation that
does not require deducing the expression type.

Fixes: f97cfd596ed
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 790cbacd14..7d7fc90566 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -369,7 +369,13 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *vg, uint32_t desc) \
 #define DO_MIN(N, M)  ((N) >= (M) ? (M) : (N))
 #define DO_ABD(N, M)  ((N) >= (M) ? (N) - (M) : (M) - (N))
 #define DO_MUL(N, M)  (N * M)
-#define DO_DIV(N, M)  (M ? N / M : 0)
+
+/* The zero divisor case is architectural; the -1 divisor case works
+ * around the x86 INT_MIN / -1 overflow exception without having to
+ * deduce the minimum integer for the type of the expression.
+ */
+#define DO_SDIV(N, M) (unlikely(M == 0) ? 0 : unlikely(M == -1) ? -N : N / M)
+#define DO_UDIV(N, M) (unlikely(M == 0) ? 0 : N / M)
 
 DO_ZPZZ(sve_and_zpzz_b, uint8_t, H1, DO_AND)
 DO_ZPZZ(sve_and_zpzz_h, uint16_t, H1_2, DO_AND)
@@ -477,11 +483,11 @@ DO_ZPZZ(sve_umulh_zpzz_h, uint16_t, H1_2, do_mulh_h)
 DO_ZPZZ(sve_umulh_zpzz_s, uint32_t, H1_4, do_mulh_s)
 DO_ZPZZ_D(sve_umulh_zpzz_d, uint64_t, do_umulh_d)
 
-DO_ZPZZ(sve_sdiv_zpzz_s, int32_t, H1_4, DO_DIV)
-DO_ZPZZ_D(sve_sdiv_zpzz_d, int64_t, DO_DIV)
+DO_ZPZZ(sve_sdiv_zpzz_s, int32_t, H1_4, DO_SDIV)
+DO_ZPZZ_D(sve_sdiv_zpzz_d, int64_t, DO_SDIV)
 
-DO_ZPZZ(sve_udiv_zpzz_s, uint32_t, H1_4, DO_DIV)
-DO_ZPZZ_D(sve_udiv_zpzz_d, uint64_t, DO_DIV)
+DO_ZPZZ(sve_udiv_zpzz_s, uint32_t, H1_4, DO_UDIV)
+DO_ZPZZ_D(sve_udiv_zpzz_d, uint64_t, DO_UDIV)
 
 /* Note that all bits of the shift are significant
    and not modulo the element size.  */
-- 
2.17.1
