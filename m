Received: from eggs.gnu.org ([2001:4830:134:3::10]:48215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWcm-0007hO-NF
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWcl-00053a-VA
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:44 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fcWcl-00052E-OF
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:43 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWck-0000js-Hp
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:54:42 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jul 2018 14:54:32 +0100
Message-Id: <20180709135435.836-9-peter.maydell@linaro.org>
In-Reply-To: <20180709135435.836-1-peter.maydell@linaro.org>
References: <20180709135435.836-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/11] target/arm: Fix do_predset for large VL
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

Use MAKE_64BIT_MASK instead of open-coding.  Remove an odd
vector size check that is unlikely to be more profitable
than 3 64-bit integer stores.  Correct the iteration for WORD
to avoid writing too much data.

Fixes RISU tests of PTRUE for VL 256.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20180705191929.30773-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index d41f1155f91..374051cd20a 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -1438,7 +1438,7 @@ static bool do_predset(DisasContext *s, int esz, int rd, int pat, bool setflag)
         setsz = numelem << esz;
         lastword = word = pred_esz_masks[esz];
         if (setsz % 64) {
-            lastword &= ~(-1ull << (setsz % 64));
+            lastword &= MAKE_64BIT_MASK(0, setsz % 64);
         }
     }
 
@@ -1457,19 +1457,13 @@ static bool do_predset(DisasContext *s, int esz, int rd, int pat, bool setflag)
             tcg_gen_gvec_dup64i(ofs, oprsz, maxsz, word);
             goto done;
         }
-        if (oprsz * 8 == setsz + 8) {
-            tcg_gen_gvec_dup64i(ofs, oprsz, maxsz, word);
-            tcg_gen_movi_i64(t, 0);
-            tcg_gen_st_i64(t, cpu_env, ofs + oprsz - 8);
-            goto done;
-        }
     }
 
     setsz /= 8;
     fullsz /= 8;
 
     tcg_gen_movi_i64(t, word);
-    for (i = 0; i < setsz; i += 8) {
+    for (i = 0; i < QEMU_ALIGN_DOWN(setsz, 8); i += 8) {
         tcg_gen_st_i64(t, cpu_env, ofs + i);
     }
     if (lastword != word) {
-- 
2.17.1
