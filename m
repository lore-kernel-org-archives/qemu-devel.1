Received: from eggs.gnu.org ([2001:4830:134:3::10]:38186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJbe-0003rd-LL
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJbc-0003K7-1j
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:22 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:36176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWJbb-0003Jx-Rn
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:19 -0400
Received: by mail-pg0-x242.google.com with SMTP id y129so13365547pgy.3
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 02:43:19 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 14 Jul 2017 23:42:23 -1000
Message-Id: <20170715094243.28371-15-rth@twiddle.net>
In-Reply-To: <20170715094243.28371-1-rth@twiddle.net>
References: <20170715094243.28371-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v14 14/34] target/i386: [tcg] Port to tb_stop
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
Message-Id: <150002219289.22386.17959138704858928730.stgit@frigg.lan>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/i386/translate.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index d350699..8238533 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8487,8 +8487,6 @@ static void i386_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
         /* if irq were inhibited with HF_INHIBIT_IRQ_MASK, we clear
            the flag and abort the translation to give the irqs a
            chance to happen */
-        gen_jmp_im(pc_next - dc->cs_base);
-        gen_eob(dc);
         dc->base.is_jmp = DISAS_TOO_MANY;
     } else if ((dc->base.tb->cflags & CF_USE_ICOUNT)
                && ((dc->base.pc_next & TARGET_PAGE_MASK)
@@ -8501,18 +8499,24 @@ static void i386_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
            If current instruction already crossed the bound - it's ok,
            because an exception hasn't stopped this code.
          */
-        gen_jmp_im(pc_next - dc->cs_base);
-        gen_eob(dc);
         dc->base.is_jmp = DISAS_TOO_MANY;
     } else if ((pc_next - dc->base.pc_first) >= (TARGET_PAGE_SIZE - 32)) {
-        gen_jmp_im(pc_next - dc->cs_base);
-        gen_eob(dc);
         dc->base.is_jmp = DISAS_TOO_MANY;
     }
 
     dc->base.pc_next = pc_next;
 }
 
+static void i386_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+
+    if (dc->base.is_jmp == DISAS_TOO_MANY) {
+        gen_jmp_im(dc->base.pc_next - dc->cs_base);
+        gen_eob(dc);
+    }
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
@@ -8569,23 +8573,21 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         /* if single step mode, we generate only one instruction and
            generate an exception */
         if (dc->base.singlestep_enabled) {
-            gen_jmp_im(dc->base.pc_next - dc->cs_base);
-            gen_eob(dc);
+            dc->base.is_jmp = DISAS_TOO_MANY;
             break;
         }
         /* if too long translation, stop generation too */
         if (tcg_op_buf_full() ||
             num_insns >= max_insns) {
-            gen_jmp_im(dc->base.pc_next - dc->cs_base);
-            gen_eob(dc);
+            dc->base.is_jmp = DISAS_TOO_MANY;
             break;
         }
         if (singlestep) {
-            gen_jmp_im(dc->base.pc_next - dc->cs_base);
-            gen_eob(dc);
+            dc->base.is_jmp = DISAS_TOO_MANY;
             break;
         }
     }
+    i386_tr_tb_stop(&dc->base, cs);
     if (tb->cflags & CF_LAST_IO)
         gen_io_end();
     gen_tb_end(tb, num_insns);
-- 
2.9.4
