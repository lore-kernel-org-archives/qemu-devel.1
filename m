Received: from eggs.gnu.org ([2001:4830:134:3::10]:50965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkl-0003Di-AK
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkh-0003uX-HT
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:31 -0500
Received: from bran.ispras.ru ([83.149.199.196]:50207 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkh-0003uE-8w
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:27 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Tue, 17 Jan 2017 12:07:49 +0300
Message-Id: <1484644078-21312-10-git-send-email-batuzovk@ispras.ru>
In-Reply-To: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
References: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH 09/18] target/arm: use vector opcode to handle
 vadd.<size> instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Kirill Batuzov <batuzovk@ispras.ru>

Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
---
 target/arm/translate.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2b81b5d..4378d44 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5666,6 +5666,37 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             return 1;
         }
 
+        /* Use vector ops to handle what we can */
+        switch (op) {
+        case NEON_3R_VADD_VSUB:
+            if (!u) {
+                void (* const gen_add_v128[])(TCGv_v128, TCGv_v128,
+                                             TCGv_v128) = {
+                    tcg_gen_add_i8x16,
+                    tcg_gen_add_i16x8,
+                    tcg_gen_add_i32x4,
+                    tcg_gen_add_i64x2
+                };
+                void (* const gen_add_v64[])(TCGv_v64, TCGv_v64,
+                                             TCGv_v64) = {
+                    tcg_gen_add_i8x8,
+                    tcg_gen_add_i16x4,
+                    tcg_gen_add_i32x2,
+                    tcg_gen_add_i64x1
+                };
+                if (q) {
+                    gen_add_v128[size](cpu_Q[rd >> 1], cpu_Q[rn >> 1],
+                                       cpu_Q[rm >> 1]);
+                } else {
+                    gen_add_v64[size](cpu_D[rd], cpu_D[rn], cpu_D[rm]);
+                }
+                return 0;
+            }
+            break;
+        default:
+            break;
+        }
+
         for (pass = 0; pass < (q ? 4 : 2); pass++) {
 
         if (pairwise) {
-- 
2.1.4
