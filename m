Received: from eggs.gnu.org ([2001:4830:134:3::10]:33869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP41q-0002Ul-6i
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 05:40:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP41n-0001YI-4u
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 05:40:26 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:40628 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP41m-0001Y5-Kv
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 05:40:23 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 25 Jun 2017 12:40:14 +0300
Message-Id: <149838361402.6497.4595687907654582323.stgit@frigg.lan>
In-Reply-To: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 14/26] target: [tcg,
 i386] Replace DISAS_* with DJ_*
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
 target/i386/translate.c |   27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 5e426de947..c7bb6efbf5 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -71,6 +71,9 @@
     case (2 << 6) | (OP << 3) | 0 ... (2 << 6) | (OP << 3) | 7: \
     case (3 << 6) | (OP << 3) | 0 ... (3 << 6) | (OP << 3) | 7
=20
+#define DJ_JUMP (DJ_TARGET + 0)         /* end of block due to call/jump=
 */
+#define DJ_MISC (DJ_TARGET + 1)         /* some other reason */
+
 //#define MACRO_TEST   1
=20
 /* global register indexes */
@@ -2180,7 +2183,7 @@ static inline void gen_jcc(DisasContext *s, int b,
=20
         gen_set_label(l1);
         gen_goto_tb(s, 1, val);
-        s->base.is_jmp =3D DISAS_TB_JUMP;
+        s->base.is_jmp =3D DJ_JUMP;
     } else {
         l1 =3D gen_new_label();
         l2 =3D gen_new_label();
@@ -2253,11 +2256,11 @@ static void gen_movl_seg_T0(DisasContext *s, int =
seg_reg)
            stop as a special handling must be done to disable hardware
            interrupts for the next instruction */
         if (seg_reg =3D=3D R_SS || (s->code32 && seg_reg < R_FS))
-            b->is_jmp =3D DISAS_TB_JUMP;
+            b->is_jmp =3D DJ_JUMP;
     } else {
         gen_op_movl_seg_T0_vm(seg_reg);
         if (seg_reg =3D=3D R_SS)
-            b->is_jmp =3D DISAS_TB_JUMP;
+            b->is_jmp =3D DJ_JUMP;
     }
 }
=20
@@ -2431,7 +2434,7 @@ static void gen_exception(DisasContext *s, int trap=
no, target_ulong cur_eip)
     gen_update_cc_op(s);
     gen_jmp_im(cur_eip);
     gen_helper_raise_exception(cpu_env, tcg_const_i32(trapno));
-    b->is_jmp =3D DISAS_TB_JUMP;
+    b->is_jmp =3D DJ_JUMP;
 }
=20
 /* Generate #UD for the current instruction.  The assumption here is tha=
t
@@ -2471,7 +2474,7 @@ static void gen_interrupt(DisasContext *s, int intn=
o,
     gen_jmp_im(cur_eip);
     gen_helper_raise_interrupt(cpu_env, tcg_const_i32(intno),
                                tcg_const_i32(next_eip - cur_eip));
-    b->is_jmp =3D DISAS_TB_JUMP;
+    b->is_jmp =3D DJ_JUMP;
 }
=20
 static void gen_debug(DisasContext *s, target_ulong cur_eip)
@@ -2481,7 +2484,7 @@ static void gen_debug(DisasContext *s, target_ulong=
 cur_eip)
     gen_update_cc_op(s);
     gen_jmp_im(cur_eip);
     gen_helper_debug(cpu_env);
-    b->is_jmp =3D DISAS_TB_JUMP;
+    b->is_jmp =3D DJ_JUMP;
 }
=20
 static void gen_set_hflag(DisasContext *s, uint32_t mask)
@@ -2558,7 +2561,7 @@ do_gen_eob_worker(DisasContext *s, bool inhibit, bo=
ol recheck_tf, TCGv jr)
     } else {
         tcg_gen_exit_tb(0);
     }
-    b->is_jmp =3D DISAS_TB_JUMP;
+    b->is_jmp =3D DJ_JUMP;
 }
=20
 static inline void
@@ -2599,7 +2602,7 @@ static void gen_jmp_tb(DisasContext *s, target_ulon=
g eip, int tb_num)
     set_cc_op(s, CC_OP_DYNAMIC);
     if (s->jmp_opt) {
         gen_goto_tb(s, tb_num, eip);
-        b->is_jmp =3D DISAS_TB_JUMP;
+        b->is_jmp =3D DJ_JUMP;
     } else {
         gen_jmp_im(eip);
         gen_eob(s);
@@ -6963,7 +6966,7 @@ static target_ulong disas_insn(DisasContextBase *db=
, CPUState *cpu)
             gen_update_cc_op(s);
             gen_jmp_im(pc_start - s->cs_base);
             gen_helper_pause(cpu_env, tcg_const_i32(s->pc - pc_start));
-            db->is_jmp =3D DISAS_TB_JUMP;
+            db->is_jmp =3D DJ_JUMP;
         }
         break;
     case 0x9b: /* fwait */
@@ -7208,7 +7211,7 @@ static target_ulong disas_insn(DisasContextBase *db=
, CPUState *cpu)
             gen_update_cc_op(s);
             gen_jmp_im(pc_start - s->cs_base);
             gen_helper_hlt(cpu_env, tcg_const_i32(s->pc - pc_start));
-            db->is_jmp =3D DISAS_TB_JUMP;
+            db->is_jmp =3D DJ_JUMP;
         }
         break;
     case 0x100:
@@ -7391,7 +7394,7 @@ static target_ulong disas_insn(DisasContextBase *db=
, CPUState *cpu)
             gen_helper_vmrun(cpu_env, tcg_const_i32(s->aflag - 1),
                              tcg_const_i32(s->pc - pc_start));
             tcg_gen_exit_tb(0);
-            db->is_jmp =3D DISAS_TB_JUMP;
+            db->is_jmp =3D DJ_JUMP;
             break;
=20
         case 0xd9: /* VMMCALL */
@@ -8567,7 +8570,7 @@ void gen_intermediate_code(CPUState *cpu, Translati=
onBlock *tb)
     /* generate intermediate code */
     db->singlestep_enabled =3D cpu->singlestep_enabled;
     db->tb =3D tb;
-    db->is_jmp =3D DISAS_NEXT;
+    db->is_jmp =3D DJ_NEXT;
     db->pc_first =3D tb->pc;
     db->pc_next =3D db->pc_first;
     i386_trblock_init_disas_context(db, cpu);
