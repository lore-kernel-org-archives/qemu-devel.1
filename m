Received: from eggs.gnu.org ([2001:4830:134:3::10]:51711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJB-0005dP-3z
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJA-0000aK-8Q
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:49 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fEeJA-0000ZJ-0V
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:48 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJ9-00032x-2I
	for qemu-devel@nongnu.org; Fri, 04 May 2018 18:15:47 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  4 May 2018 18:15:24 +0100
Message-Id: <20180504171540.25813-9-peter.maydell@linaro.org>
In-Reply-To: <20180504171540.25813-1-peter.maydell@linaro.org>
References: <20180504171540.25813-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/24] target/arm: Tidy condition in
 disas_simd_two_reg_misc
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

Path analysis shows that size == 3 && !is_q has been eliminated.

Fixes: Coverity CID1385853
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20180501180455.11214-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 97950dce1a..6d49f30b4a 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11473,7 +11473,11 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         /* All 64-bit element operations can be shared with scalar 2misc */
         int pass;
 
-        for (pass = 0; pass < (is_q ? 2 : 1); pass++) {
+        /* Coverity claims (size == 3 && !is_q) has been eliminated
+         * from all paths leading to here.
+         */
+        tcg_debug_assert(is_q);
+        for (pass = 0; pass < 2; pass++) {
             TCGv_i64 tcg_op = tcg_temp_new_i64();
             TCGv_i64 tcg_res = tcg_temp_new_i64();
 
-- 
2.17.0
