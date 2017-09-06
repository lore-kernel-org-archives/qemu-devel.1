Received: from eggs.gnu.org ([2001:4830:134:3::10]:41863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqk-0000JX-2p
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqf-0002Ub-TQ
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:46 -0400
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229]:35366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpcqf-0002TM-Nt
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:41 -0400
Received: by mail-pf0-x229.google.com with SMTP id g13so13483540pfm.2
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 09:06:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Sep 2017 09:05:59 -0700
Message-Id: <20170906160612.22769-20-richard.henderson@linaro.org>
In-Reply-To: <20170906160612.22769-1-richard.henderson@linaro.org>
References: <20170906160612.22769-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/32] target/arm: [tcg] Port to insn_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Richard Henderson <rth@twiddle.net>

From: Lluís Vilanova <vilanova@ac.upc.edu>

Incrementally paves the way towards using the generic instruction translation
loop.

Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Alex Benneé <alex.benee@linaro.org>
Message-Id: <150002388959.22386.12439646324427589940.stgit@frigg.lan>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 3138a23e0c..005157225c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11936,6 +11936,16 @@ static void arm_tr_tb_start(DisasContextBase *dcbase, CPUState *cpu)
     }
 }
 
+static void arm_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+
+    dc->insn_start_idx = tcg_op_buf_count();
+    tcg_gen_insn_start(dc->pc,
+                       (dc->condexec_cond << 4) | (dc->condexec_mask >> 1),
+                       0);
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
@@ -11979,10 +11989,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 
     do {
         dc->base.num_insns++;
-        dc->insn_start_idx = tcg_op_buf_count();
-        tcg_gen_insn_start(dc->pc,
-                           (dc->condexec_cond << 4) | (dc->condexec_mask >> 1),
-                           0);
+        arm_tr_insn_start(&dc->base, cs);
 
         if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
             CPUBreakpoint *bp;
-- 
2.13.5
