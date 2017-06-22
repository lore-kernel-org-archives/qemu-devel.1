Received: from eggs.gnu.org ([2001:4830:134:3::10]:39760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dO6C8-0001LY-PI
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dO6C4-0000oG-An
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:47:04 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:44875 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dO6C3-0000o5-V1
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:47:00 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Thu, 22 Jun 2017 20:46:50 +0300
Message-Id: <149815361027.1830.12938924682989954179.stgit@frigg.lan>
In-Reply-To: <149815338558.1830.8107719559183631163.stgit@frigg.lan>
References: <149815338558.1830.8107719559183631163.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 07/26] target: [tcg,
 i386] Refactor init_disas_context
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
 target/i386/translate.c |   43 ++++++++++++++++++++++++-----------------=
--
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 5a801766e5..84ff49030b 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8396,21 +8396,12 @@ void tcg_x86_init(void)
     }
 }
=20
-/* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
+static void i386_trblock_init_disas_context(DisasContextBase *db, CPUSta=
te *cpu)
 {
+    DisasContext *dc =3D container_of(db, DisasContext, base);
     CPUX86State *env =3D cpu->env_ptr;
-    DisasContext dc1, *dc =3D &dc1;
-    DisasContextBase *db =3D &dc1.base;
-    uint32_t flags;
-    target_ulong cs_base;
-    int num_insns;
-    int max_insns;
-
-    /* generate intermediate code */
-    db->pc_first =3D tb->pc;
-    cs_base =3D tb->cs_base;
-    flags =3D tb->flags;
+    uint32_t flags =3D db->tb->flags;
+    target_ulong cs_base =3D db->tb->cs_base;
=20
     dc->pe =3D (flags >> HF_PE_SHIFT) & 1;
     dc->code32 =3D (flags >> HF_CS32_SHIFT) & 1;
@@ -8421,11 +8412,9 @@ void gen_intermediate_code(CPUState *cpu, Translat=
ionBlock *tb)
     dc->cpl =3D (flags >> HF_CPL_SHIFT) & 3;
     dc->iopl =3D (flags >> IOPL_SHIFT) & 3;
     dc->tf =3D (flags >> TF_SHIFT) & 1;
-    db->singlestep_enabled =3D cpu->singlestep_enabled;
     dc->cc_op =3D CC_OP_DYNAMIC;
     dc->cc_op_dirty =3D false;
     dc->cs_base =3D cs_base;
-    db->tb =3D tb;
     dc->popl_esp_hack =3D 0;
     /* select memory access functions */
     dc->mem_index =3D 0;
@@ -8455,12 +8444,30 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
        record/replay modes and there will always be an
        additional step for ecx=3D0 when icount is enabled.
      */
-    dc->repz_opt =3D !dc->jmp_opt && !(tb->cflags & CF_USE_ICOUNT);
+    dc->repz_opt =3D !dc->jmp_opt && !(db->tb->cflags & CF_USE_ICOUNT);
 #if 0
     /* check addseg logic */
     if (!dc->addseg && (dc->vm86 || !dc->pe || !dc->code32))
         printf("ERROR addseg\n");
 #endif
+}
+
+/* generate intermediate code for basic block 'tb'.  */
+void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
+{
+    CPUX86State *env =3D cpu->env_ptr;
+    DisasContext dc1, *dc =3D &dc1;
+    DisasContextBase *db =3D &dc1.base;
+    int num_insns;
+    int max_insns;
+
+    /* generate intermediate code */
+    db->singlestep_enabled =3D cpu->singlestep_enabled;
+    db->tb =3D tb;
+    db->is_jmp =3D DISAS_NEXT;
+    db->pc_first =3D tb->pc;
+    db->pc_next =3D db->pc_first;
+    i386_trblock_init_disas_context(db, cpu);
=20
     cpu_T0 =3D tcg_temp_new();
     cpu_T1 =3D tcg_temp_new();
@@ -8475,8 +8482,6 @@ void gen_intermediate_code(CPUState *cpu, Translati=
onBlock *tb)
     cpu_ptr1 =3D tcg_temp_new_ptr();
     cpu_cc_srcT =3D tcg_temp_local_new();
=20
-    db->is_jmp =3D DISAS_NEXT;
-    db->pc_next =3D db->pc_first;
     num_insns =3D 0;
     max_insns =3D tb->cflags & CF_COUNT_MASK;
     if (max_insns =3D=3D 0) {
@@ -8518,7 +8523,7 @@ void gen_intermediate_code(CPUState *cpu, Translati=
onBlock *tb)
            the flag and abort the translation to give the irqs a
            change to be happen */
         if (dc->tf || db->singlestep_enabled ||
-            (flags & HF_INHIBIT_IRQ_MASK)) {
+            (db->tb->flags & HF_INHIBIT_IRQ_MASK)) {
             gen_jmp_im(db->pc_next - dc->cs_base);
             gen_eob(dc);
             break;
