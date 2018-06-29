Received: from eggs.gnu.org ([2001:4830:134:3::10]:34336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYunB-0007vh-GO
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYunA-0007sH-5K
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:33 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYun9-0007lI-TB
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:32 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun8-0004qL-Lr
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:54:30 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:53:43 +0100
Message-Id: <20180629145347.652-52-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 51/55] target/arm: Fix SVE signed division vs
 x86 overflow exception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

We already check for the same condition within the normal integer
sdiv and sdiv64 helpers.  Use a slightly different formation that
does not require deducing the expression type.

Fixes: f97cfd596ed
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180629001538.11415-2-richard.henderson@linaro.org
[PMM: reworded a comment]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/sve_helper.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 790cbacd146..a03ca773542 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -369,7 +369,17 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *vg, uint32_t desc) \
 #define DO_MIN(N, M)  ((N) >= (M) ? (M) : (N))
 #define DO_ABD(N, M)  ((N) >= (M) ? (N) - (M) : (M) - (N))
 #define DO_MUL(N, M)  (N * M)
-#define DO_DIV(N, M)  (M ? N / M : 0)
+
+
+/*
+ * We must avoid the C undefined behaviour cases: division by
+ * zero and signed division of INT_MIN by -1. Both of these
+ * have architecturally defined required results for Arm.
+ * We special case all signed divisions by -1 to avoid having
+ * to deduce the minimum integer for the type involved.
+ */
+#define DO_SDIV(N, M) (unlikely(M == 0) ? 0 : unlikely(M == -1) ? -N : N / M)
+#define DO_UDIV(N, M) (unlikely(M == 0) ? 0 : N / M)
 
 DO_ZPZZ(sve_and_zpzz_b, uint8_t, H1, DO_AND)
 DO_ZPZZ(sve_and_zpzz_h, uint16_t, H1_2, DO_AND)
@@ -477,11 +487,11 @@ DO_ZPZZ(sve_umulh_zpzz_h, uint16_t, H1_2, do_mulh_h)
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
