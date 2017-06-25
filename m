Received: from eggs.gnu.org ([2001:4830:134:3::10]:32937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP3u4-0007xS-Tt
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 05:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP3u1-0006HF-RD
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 05:32:24 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:36429 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP3u1-0006Gc-G6
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 05:32:21 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 25 Jun 2017 12:32:10 +0300
Message-Id: <149838312996.6497.2215207449313720373.stgit@frigg.lan>
In-Reply-To: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 12/26] target: [tcg,i386] Refactor tb_stop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Incrementally paves the way towards using the generic instruction transla=
tion
loop.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 target/i386/translate.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 34e7cf6788..e7b46d282a 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8510,8 +8510,6 @@ static target_ulong i386_trblock_disas_insn(DisasCo=
ntextBase *db, CPUState *cpu)
         /* if irq were inhibited with HF_INHIBIT_IRQ_MASK, we clear
            the flag and abort the translation to give the irqs a
            change to be happen */
-        gen_jmp_im(pc_next - dc->cs_base);
-        gen_eob(dc);
         db->is_jmp =3D DJ_TOO_MANY;
     } else if ((db->tb->cflags & CF_USE_ICOUNT)
                && ((db->pc_next & TARGET_PAGE_MASK)
@@ -8524,18 +8522,24 @@ static target_ulong i386_trblock_disas_insn(Disas=
ContextBase *db, CPUState *cpu)
            If current instruction already crossed the bound - it's ok,
            because an exception hasn't stopped this code.
          */
-        gen_jmp_im(pc_next - dc->cs_base);
-        gen_eob(dc);
         db->is_jmp =3D DJ_TOO_MANY;
     } else if ((pc_next - db->pc_first) >=3D (TARGET_PAGE_SIZE - 32)) {
-        gen_jmp_im(pc_next - dc->cs_base);
-        gen_eob(dc);
         db->is_jmp =3D DJ_TOO_MANY;
     }
=20
     return pc_next;
 }
=20
+static void i386_trblock_tb_stop(DisasContextBase *db, CPUState *cpu)
+{
+    DisasContext *dc =3D container_of(db, DisasContext, base);
+
+    if (db->is_jmp =3D=3D DJ_TOO_MANY) {
+        gen_jmp_im(db->pc_next - dc->cs_base);
+        gen_eob(dc);
+    }
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
 {
@@ -8596,23 +8600,21 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
         /* if single step mode, we generate only one instruction and
            generate an exception */
         if (db->singlestep_enabled) {
-            gen_jmp_im(db->pc_next - dc->cs_base);
-            gen_eob(dc);
+            db->is_jmp =3D DJ_TOO_MANY;
             break;
         }
         /* if too long translation, stop generation too */
         if (tcg_op_buf_full() ||
             num_insns >=3D max_insns) {
-            gen_jmp_im(db->pc_next - dc->cs_base);
-            gen_eob(dc);
+            db->is_jmp =3D DJ_TOO_MANY;
             break;
         }
         if (singlestep) {
-            gen_jmp_im(db->pc_next - dc->cs_base);
-            gen_eob(dc);
+            db->is_jmp =3D DJ_TOO_MANY;
             break;
         }
     }
+    i386_trblock_tb_stop(db, cpu);
     if (tb->cflags & CF_LAST_IO)
         gen_io_end(cpu_env);
 done_generating:
