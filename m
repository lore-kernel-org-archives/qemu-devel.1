Received: from eggs.gnu.org ([209.51.188.92]:46845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hIsYj-0003ZY-QA
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:21:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hIsYg-0005sr-RY
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:21:51 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Apr 2019 12:21:44 +0200
Message-Id: <20190423102145.14812-2-f4bug@amsat.org>
In-Reply-To: <20190423102145.14812-1-f4bug@amsat.org>
References: <20190423102145.14812-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/2] target/ppc: Use tcg_gen_abs_i32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, David Hildenbrand <david@redhat.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-ppc@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/ppc/translate/spe-impl.inc.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/target/ppc/translate/spe-impl.inc.c b/target/ppc/translate/spe-impl.inc.c
index 8c1c16c63e..41da7fab97 100644
--- a/target/ppc/translate/spe-impl.inc.c
+++ b/target/ppc/translate/spe-impl.inc.c
@@ -125,19 +125,7 @@ static inline void gen_##name(DisasContext *ctx)                              \
     tcg_temp_free_i32(t0);                                                    \
 }
 
-static inline void gen_op_evabs(TCGv_i32 ret, TCGv_i32 arg1)
-{
-    TCGLabel *l1 = gen_new_label();
-    TCGLabel *l2 = gen_new_label();
-
-    tcg_gen_brcondi_i32(TCG_COND_GE, arg1, 0, l1);
-    tcg_gen_neg_i32(ret, arg1);
-    tcg_gen_br(l2);
-    gen_set_label(l1);
-    tcg_gen_mov_i32(ret, arg1);
-    gen_set_label(l2);
-}
-GEN_SPEOP_ARITH1(evabs, gen_op_evabs);
+GEN_SPEOP_ARITH1(evabs, tcg_gen_abs_i32);
 GEN_SPEOP_ARITH1(evneg, tcg_gen_neg_i32);
 GEN_SPEOP_ARITH1(evextsb, tcg_gen_ext8s_i32);
 GEN_SPEOP_ARITH1(evextsh, tcg_gen_ext16s_i32);
-- 
2.19.1
