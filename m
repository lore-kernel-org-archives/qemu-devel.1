Received: from eggs.gnu.org ([2001:4830:134:3::10]:41213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fb9mz-0001DV-5n
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 15:19:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fb9my-0004BU-AZ
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 15:19:37 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:46470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fb9my-0004Aw-4B
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 15:19:36 -0400
Received: by mail-pl0-x242.google.com with SMTP id 30-v6so1692327pld.13
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 12:19:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  5 Jul 2018 12:19:29 -0700
Message-Id: <20180705191929.30773-3-richard.henderson@linaro.org>
In-Reply-To: <20180705191929.30773-1-richard.henderson@linaro.org>
References: <20180705191929.30773-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] target/arm: Fix do_predset for large VL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

Use MAKE_64BIT_MASK instead of open-coding.  Remove an odd
vector size check that is unlikely to be more profitable
than 3 64-bit integer stores.  Correct the iteration for WORD
to avoid writing too much data.

Fixes RISU tests of PTRUE for VL 256.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index d41f1155f9..374051cd20 100644
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
