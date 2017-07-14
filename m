Received: from eggs.gnu.org ([2001:4830:134:3::10]:50472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVwIa-0001r9-NK
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:50:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVwIV-0007Xr-RS
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:50:08 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:45593 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVwIV-0007Xc-Ef
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:50:03 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Fri, 14 Jul 2017 11:49:53 +0300
Message-Id: <150002219289.22386.17959138704858928730.stgit@frigg.lan>
In-Reply-To: <150002001195.22386.4679134058536830996.stgit@frigg.lan>
References: <150002001195.22386.4679134058536830996.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 09/26] target/i386: [tcg] Port to tb_stop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Incrementally paves the way towards using the generic instruction transla=
tion
loop.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target/i386/translate.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 3518d3a78e..fe95340daf 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8491,8 +8491,6 @@ static target_ulong i386_tr_translate_insn(DisasCon=
textBase *dcbase,
         /* if irq were inhibited with HF_INHIBIT_IRQ_MASK, we clear
            the flag and abort the translation to give the irqs a
            chance to happen */
-        gen_jmp_im(pc_next - dc->cs_base);
-        gen_eob(dc);
         dc->base.is_jmp =3D DISAS_TOO_MANY;
     } else if ((dc->base.tb->cflags & CF_USE_ICOUNT)
                && ((dc->base.pc_next & TARGET_PAGE_MASK)
@@ -8505,18 +8503,24 @@ static target_ulong i386_tr_translate_insn(DisasC=
ontextBase *dcbase,
            If current instruction already crossed the bound - it's ok,
            because an exception hasn't stopped this code.
          */
-        gen_jmp_im(pc_next - dc->cs_base);
-        gen_eob(dc);
         dc->base.is_jmp =3D DISAS_TOO_MANY;
     } else if ((pc_next - dc->base.pc_first) >=3D (TARGET_PAGE_SIZE - 32=
)) {
-        gen_jmp_im(pc_next - dc->cs_base);
-        gen_eob(dc);
         dc->base.is_jmp =3D DISAS_TOO_MANY;
     }
=20
     return pc_next;
 }
=20
+static void i386_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *dc =3D container_of(dcbase, DisasContext, base);
+
+    if (dc->base.is_jmp =3D=3D DISAS_TOO_MANY) {
+        gen_jmp_im(dc->base.pc_next - dc->cs_base);
+        gen_eob(dc);
+    }
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
@@ -8573,23 +8577,21 @@ void gen_intermediate_code(CPUState *cs, Translat=
ionBlock *tb)
         /* if single step mode, we generate only one instruction and
            generate an exception */
         if (dc->base.singlestep_enabled) {
-            gen_jmp_im(dc->base.pc_next - dc->cs_base);
-            gen_eob(dc);
+            dc->base.is_jmp =3D DISAS_TOO_MANY;
             break;
         }
         /* if too long translation, stop generation too */
         if (tcg_op_buf_full() ||
             num_insns >=3D max_insns) {
-            gen_jmp_im(dc->base.pc_next - dc->cs_base);
-            gen_eob(dc);
+            dc->base.is_jmp =3D DISAS_TOO_MANY;
             break;
         }
         if (singlestep) {
-            gen_jmp_im(dc->base.pc_next - dc->cs_base);
-            gen_eob(dc);
+            dc->base.is_jmp =3D DISAS_TOO_MANY;
             break;
         }
     }
+    i386_tr_tb_stop(&dc->base, cs);
     if (tb->cflags & CF_LAST_IO)
         gen_io_end();
     gen_tb_end(tb, num_insns);
