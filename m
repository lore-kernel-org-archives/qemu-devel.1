Received: from eggs.gnu.org ([2001:4830:134:3::10]:44733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQCHK-0005H6-MJ
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:41:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQCHH-0005kf-Jo
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:41:06 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:57809)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQCHH-0005jc-5I
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:41:03 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 28 Jun 2017 15:40:52 +0300
Message-Id: <149865365245.17063.7830070270971603805.stgit@frigg.lan>
In-Reply-To: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v11 06/29] target/i386: [tcg] Refactor
 init_disas_context
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
---
 target/i386/translate.c |   43 ++++++++++++++++++++++++-----------------=
--
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 8cf2485e2c..04453ce48a 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8379,20 +8379,12 @@ void tcg_x86_init(void)
     }
 }
=20
-/* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
+static void i386_trblock_init_disas_context(DisasContextBase *dcbase, CP=
UState *cpu)
 {
+    DisasContext *dc =3D container_of(dcbase, DisasContext, base);
     CPUX86State *env =3D cpu->env_ptr;
-    DisasContext dc1, *dc =3D &dc1;
-    uint32_t flags;
-    target_ulong cs_base;
-    int num_insns;
-    int max_insns;
-
-    /* generate intermediate code */
-    dc->base.pc_first =3D tb->pc;
-    cs_base =3D tb->cs_base;
-    flags =3D tb->flags;
+    uint32_t flags =3D dc->base.tb->flags;
+    target_ulong cs_base =3D dc->base.tb->cs_base;
=20
     dc->pe =3D (flags >> HF_PE_SHIFT) & 1;
     dc->code32 =3D (flags >> HF_CS32_SHIFT) & 1;
@@ -8403,11 +8395,9 @@ void gen_intermediate_code(CPUState *cpu, Translat=
ionBlock *tb)
     dc->cpl =3D (flags >> HF_CPL_SHIFT) & 3;
     dc->iopl =3D (flags >> IOPL_SHIFT) & 3;
     dc->tf =3D (flags >> TF_SHIFT) & 1;
-    dc->base.singlestep_enabled =3D cpu->singlestep_enabled;
     dc->cc_op =3D CC_OP_DYNAMIC;
     dc->cc_op_dirty =3D false;
     dc->cs_base =3D cs_base;
-    dc->base.tb =3D tb;
     dc->popl_esp_hack =3D 0;
     /* select memory access functions */
     dc->mem_index =3D 0;
@@ -8425,7 +8415,7 @@ void gen_intermediate_code(CPUState *cpu, Translati=
onBlock *tb)
     dc->code64 =3D (flags >> HF_CS64_SHIFT) & 1;
 #endif
     dc->flags =3D flags;
-    dc->jmp_opt =3D !(dc->tf || cpu->singlestep_enabled ||
+    dc->jmp_opt =3D !(dc->tf || dc->base.singlestep_enabled ||
                     (flags & HF_INHIBIT_IRQ_MASK));
     /* Do not optimize repz jumps at all in icount mode, because
        rep movsS instructions are execured with different paths
@@ -8437,12 +8427,29 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
        record/replay modes and there will always be an
        additional step for ecx=3D0 when icount is enabled.
      */
-    dc->repz_opt =3D !dc->jmp_opt && !(tb->cflags & CF_USE_ICOUNT);
+    dc->repz_opt =3D !dc->jmp_opt && !(dc->base.tb->cflags & CF_USE_ICOU=
NT);
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
+    int num_insns;
+    int max_insns;
+
+    /* generate intermediate code */
+    dc->base.singlestep_enabled =3D cpu->singlestep_enabled;
+    dc->base.tb =3D tb;
+    dc->base.is_jmp =3D DISAS_NEXT;
+    dc->base.pc_first =3D tb->pc;
+    dc->base.pc_next =3D dc->base.pc_first;
+    i386_trblock_init_disas_context(&dc->base, cpu);
=20
     cpu_T0 =3D tcg_temp_new();
     cpu_T1 =3D tcg_temp_new();
@@ -8457,8 +8464,6 @@ void gen_intermediate_code(CPUState *cpu, Translati=
onBlock *tb)
     cpu_ptr1 =3D tcg_temp_new_ptr();
     cpu_cc_srcT =3D tcg_temp_local_new();
=20
-    dc->base.is_jmp =3D DISAS_NEXT;
-    dc->base.pc_next =3D dc->base.pc_first;
     num_insns =3D 0;
     max_insns =3D tb->cflags & CF_COUNT_MASK;
     if (max_insns =3D=3D 0) {
@@ -8500,7 +8505,7 @@ void gen_intermediate_code(CPUState *cpu, Translati=
onBlock *tb)
            the flag and abort the translation to give the irqs a
            change to be happen */
         if (dc->tf || dc->base.singlestep_enabled ||
-            (flags & HF_INHIBIT_IRQ_MASK)) {
+            (dc->base.tb->flags & HF_INHIBIT_IRQ_MASK)) {
             gen_jmp_im(dc->base.pc_next - dc->cs_base);
             gen_eob(dc);
             break;
