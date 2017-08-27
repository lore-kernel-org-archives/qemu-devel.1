Received: from eggs.gnu.org ([2001:4830:134:3::10]:47430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pullmoll@t-online.de>) id 1dm0cO-0000YL-Ng
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 12:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pullmoll@t-online.de>) id 1dm0cL-0003fb-He
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 12:41:00 -0400
Received: from mailout07.t-online.de ([194.25.134.83]:54986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pullmoll@t-online.de>)
	id 1dm0cL-0003ee-67
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 12:40:57 -0400
Received: from fwd14.aul.t-online.de (fwd14.aul.t-online.de [172.20.26.242])
	by mailout07.t-online.de (Postfix) with SMTP id B7E1242727E6
	for <qemu-devel@nongnu.org>; Sun, 27 Aug 2017 18:40:54 +0200 (CEST)
Message-ID: <1503852052.23207.2.camel@t-online.de>
From: =?ISO-8859-1?Q?J=FCrgen_Buchm=FCller?= <pullmoll@t-online.de>
Date: Sun, 27 Aug 2017 18:40:52 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] i386: fix 0x66 prefix in disassembler and
 translator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The opcodes 0xe8 (call) and 0xe9 (jump), when prefixed by 0x66, do not
use a 16 bit offset, but still 32 bits, just like conditional relative
jumps. To distinguish between conditional jumps and the unconditional
call/jump add a new call_jump_mode and a call_jump_flag. This
prerevents data size changes for both, call_jump_mode and
cond_jump_mode when using the Intel syntax.

In the translator respect data size changes only, if the CPU is not
and Intel type. Otherwise the size of the call/jmp is always 32 bits.

See https://github.com/xoreaxeaxeax/sandsifter/blob/master/references/d
omas_breaking_the_x86_isa_wp.pdf
for the details and reasoning.

Signed-off-by: J=C3=BCrgen Buchm=C3=BCller <pullmoll@t-online.de>
---
 disas/i386.c            | 31 ++++++++++++++-------------
 target/i386/translate.c | 56 ++++++++++++++++++++++++++++++++---------
--------
 2 files changed, 54 insertions(+), 33 deletions(-)

diff --git a/disas/i386.c b/disas/i386.c
index f1e376ca4a..2b18285fb8 100644
--- a/disas/i386.c
+++ b/disas/i386.c
@@ -464,6 +464,7 @@ fetch_data(struct disassemble_info *info, bfd_byte
*addr)
 #define ALr { REP_Fixup, al_reg }
 #define eAXr { REP_Fixup, eAX_reg }
=20
+#define call_jump_flag { NULL, call_jump_mode }
 #define cond_jump_flag { NULL, cond_jump_mode }
 #define loop_jcxz_flag { NULL, loop_jcxz_mode }
=20
@@ -480,17 +481,18 @@ fetch_data(struct disassemble_info *info,
bfd_byte *addr)
 #define t_mode 6  /* ten-byte operand */
 #define x_mode 7  /* 16-byte XMM operand */
 #define m_mode 8  /* d_mode in 32bit, q_mode in 64bit mode.  */
-#define cond_jump_mode 9
-#define loop_jcxz_mode 10
-#define dq_mode 11 /* operand size depends on REX prefixes.  */
-#define dqw_mode 12 /* registers like dq_mode, memory like w_mode.  */
-#define f_mode 13 /* 4- or 6-byte pointer operand */
-#define const_1_mode 14
-#define stack_v_mode 15 /* v_mode for stack-related opcodes.  */
-#define z_mode 16 /* non-quad operand size depends on prefixes */
-#define o_mode 17  /* 16-byte operand */
-#define dqb_mode 18 /* registers like dq_mode, memory like b_mode.  */
-#define dqd_mode 19 /* registers like dq_mode, memory like d_mode.  */
+#define call_jump_mode 9
+#define cond_jump_mode 10
+#define loop_jcxz_mode 11
+#define dq_mode 12 /* operand size depends on REX prefixes.  */
+#define dqw_mode 13 /* registers like dq_mode, memory like w_mode.  */
+#define f_mode 14 /* 4- or 6-byte pointer operand */
+#define const_1_mode 15
+#define stack_v_mode 16 /* v_mode for stack-related opcodes.  */
+#define z_mode 17 /* non-quad operand size depends on prefixes */
+#define o_mode 18  /* 16-byte operand */
+#define dqb_mode 19 /* registers like dq_mode, memory like b_mode.  */
+#define dqd_mode 20 /* registers like dq_mode, memory like d_mode.  */
=20
 #define es_reg 100
 #define cs_reg 101
@@ -1007,8 +1009,8 @@ static const struct dis386 dis386[] =3D {
   { "outB",		{ Ib, AL } },
   { "outG",		{ Ib, zAX } },
   /* e8 */
-  { "callT",		{ Jv } },
-  { "jmpT",		{ Jv } },
+  { "callT",		{ Jv, XX, call_jump_flag } },
+  { "jmpT",		{ Jv, XX, call_jump_flag } },
   { "Jjmp{T|}",		{ Ap } },
   { "jmp",		{ Jb } },
   { "inB",		{ AL, indirDX } },
@@ -3968,7 +3970,8 @@ print_insn (bfd_vma pc, disassemble_info *info)
   if (!uses_DATA_prefix && (prefixes & PREFIX_DATA))
     {
       sizeflag ^=3D DFLAG;
-      if (dp->op[2].bytemode =3D=3D cond_jump_mode
+      if ((dp->op[2].bytemode =3D=3D call_jump_mode
+           || dp->op[2].bytemode =3D=3D cond_jump_mode)
 	  && dp->op[0].bytemode =3D=3D v_mode
 	  && !intel_syntax)
 	{
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 5fdadf98cf..a97cc9496f 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -6480,17 +6480,26 @@ static target_ulong disas_insn(CPUX86State
*env, DisasContext *s,
         break;
     case 0xe8: /* call im */
         {
-            if (dflag !=3D MO_16) {
-                tval =3D (int32_t)insn_get(env, s, MO_32);
+            if (env->cpuid_vendor1 !=3D CPUID_VENDOR_INTEL_1) {
+                if (dflag !=3D MO_16) {
+                    tval =3D (int32_t)insn_get(env, s, MO_32);
+                } else {
+                    tval =3D (int16_t)insn_get(env, s, MO_16);
+                }
+                next_eip =3D s->pc - s->cs_base;
+                tval +=3D next_eip;
+                if (dflag =3D=3D MO_16) {
+                    tval &=3D 0xffff;
+                } else if (!CODE64(s)) {
+                    tval &=3D 0xffffffff;
+                }
             } else {
-                tval =3D (int16_t)insn_get(env, s, MO_16);
-            }
-            next_eip =3D s->pc - s->cs_base;
-            tval +=3D next_eip;
-            if (dflag =3D=3D MO_16) {
-                tval &=3D 0xffff;
-            } else if (!CODE64(s)) {
-                tval &=3D 0xffffffff;
+                tval =3D (int32_t)insn_get(env, s, MO_32);
+                next_eip =3D s->pc - s->cs_base;
+                tval +=3D next_eip;
+                if (!CODE64(s)) {
+                    tval &=3D 0xffffffff;
+                }
             }
             tcg_gen_movi_tl(cpu_T0, next_eip);
             gen_push_v(s, cpu_T0);
@@ -6513,16 +6522,25 @@ static target_ulong disas_insn(CPUX86State
*env, DisasContext *s,
         }
         goto do_lcall;
     case 0xe9: /* jmp im */
-        if (dflag !=3D MO_16) {
-            tval =3D (int32_t)insn_get(env, s, MO_32);
+        if (env->cpuid_vendor1 !=3D CPUID_VENDOR_INTEL_1) {
+            if (dflag !=3D MO_16) {
+                tval =3D (int32_t)insn_get(env, s, MO_32);
+            } else {
+                tval =3D (int16_t)insn_get(env, s, MO_16);
+            }
+            next_eip =3D s->pc - s->cs_base;
+            tval +=3D next_eip;
+            if (dflag =3D=3D MO_16) {
+                tval &=3D 0xffff;
+            } else if (!CODE64(s)) {
+                tval &=3D 0xffffffff;
+            }
         } else {
-            tval =3D (int16_t)insn_get(env, s, MO_16);
-        }
-        tval +=3D s->pc - s->cs_base;
-        if (dflag =3D=3D MO_16) {
-            tval &=3D 0xffff;
-        } else if (!CODE64(s)) {
-            tval &=3D 0xffffffff;
+            tval =3D (int32_t)insn_get(env, s, MO_32);
+            tval +=3D s->pc - s->cs_base;
+            if (!CODE64(s)) {
+                tval &=3D 0xffffffff;
+            }
         }
         gen_bnd_jmp(s);
         gen_jmp(s, tval);
--=20
2.14.1
