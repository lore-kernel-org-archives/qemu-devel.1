Received: from eggs.gnu.org ([2001:4830:134:3::10]:41621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqU-0008PS-9g
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqS-0001qo-4p
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:30 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:37870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpcqR-0001pP-U7
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:28 -0400
Received: by mail-pg0-x232.google.com with SMTP id d8so15974341pgt.4
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 09:06:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Sep 2017 09:05:49 -0700
Message-Id: <20170906160612.22769-10-richard.henderson@linaro.org>
In-Reply-To: <20170906160612.22769-1-richard.henderson@linaro.org>
References: <20170906160612.22769-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/32] target/i386: [tcg] Port to insn_start
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
Reviewed-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Alex Benneé <alex.benee@linaro.org>
Message-Id: <150002146647.22386.13380064201042141261.stgit@frigg.lan>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/i386/translate.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 4281e9bc56..b7e5854513 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8449,6 +8449,13 @@ static int i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu,
     return max_insns;
 }
 
+static void i386_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+
+    tcg_gen_insn_start(dc->base.pc_next, dc->cc_op);
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
@@ -8476,7 +8483,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     num_insns = 0;
     gen_tb_start(tb);
     for(;;) {
-        tcg_gen_insn_start(dc->base.pc_next, dc->cc_op);
+        i386_tr_insn_start(&dc->base, cs);
         num_insns++;
 
         /* If RF is set, suppress an internally generated breakpoint.  */
-- 
2.13.5
