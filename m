Received: from eggs.gnu.org ([2001:4830:134:3::10]:38138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJbW-0003lX-QV
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJbW-0003Ha-1n
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:14 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:36163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWJbV-0003HP-SU
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:13 -0400
Received: by mail-pg0-x241.google.com with SMTP id y129so13365339pgy.3
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 02:43:13 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 14 Jul 2017 23:42:20 -1000
Message-Id: <20170715094243.28371-12-rth@twiddle.net>
In-Reply-To: <20170715094243.28371-1-rth@twiddle.net>
References: <20170715094243.28371-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v14 11/34] target/i386: [tcg] Port to insn_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vilanova@ac.upc.edu, cota@braap.org, alex.bennee@linaro.org, crosthwaite.peter@gmail.com, pbonzini@redhat.com

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
index 651abca..6e1243a 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8448,6 +8448,13 @@ static int i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu,
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
@@ -8475,7 +8482,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     num_insns = 0;
     gen_tb_start(tb);
     for(;;) {
-        tcg_gen_insn_start(dc->base.pc_next, dc->cc_op);
+        i386_tr_insn_start(&dc->base, cs);
         num_insns++;
 
         /* If RF is set, suppress an internally generated breakpoint.  */
-- 
2.9.4
