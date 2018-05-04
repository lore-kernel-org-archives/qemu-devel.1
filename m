Received: from eggs.gnu.org ([2001:4830:134:3::10]:51694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJA-0005ca-Dw
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJ9-0000ZT-Jk
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:48 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fEeJ9-0000Q4-Aq
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:47 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJ8-000320-CT
	for qemu-devel@nongnu.org; Fri, 04 May 2018 18:15:46 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  4 May 2018 18:15:23 +0100
Message-Id: <20180504171540.25813-8-peter.maydell@linaro.org>
In-Reply-To: <20180504171540.25813-1-peter.maydell@linaro.org>
References: <20180504171540.25813-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/24] target/arm: Tidy conditions in
 handle_vec_simd_shri
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

The (size > 3 && !is_q) condition is identical to the preceeding test
of bit 3 in immh; eliminate it.  For the benefit of Coverity, assert
that size is within the bounds we expect.

Fixes: Coverity CID1385846
Fixes: Coverity CID1385849
Fixes: Coverity CID1385852
Fixes: Coverity CID1385857
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20180501180455.11214-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index bff4e13bf6..97950dce1a 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -9019,11 +9019,7 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
         unallocated_encoding(s);
         return;
     }
-
-    if (size > 3 && !is_q) {
-        unallocated_encoding(s);
-        return;
-    }
+    tcg_debug_assert(size <= 3);
 
     if (!fp_access_check(s)) {
         return;
-- 
2.17.0
