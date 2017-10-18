Received: from eggs.gnu.org ([2001:4830:134:3::10]:35927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qy9-0003Zi-O6
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qy6-0002BG-Hg
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:21 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:44681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1e4qy6-0002AO-49
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:18 -0400
Received: by mail-wm0-x234.google.com with SMTP id 196so13113047wma.1
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 09:13:18 -0700 (PDT)
Received: from 640k.lan (94-39-155-245.adsl-ull.clienti.tiscali.it.
	[94.39.155.245])
	by smtp.gmail.com with ESMTPSA id 69sm13436794wmm.2.2017.10.18.09.13.14
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 18 Oct 2017 09:13:15 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2017 18:12:06 +0200
Message-Id: <1508343141-31835-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
References: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 14/29] target/i386: introduce x86_ld*_code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

These take care of advancing s->pc, and will provide a unified point
where to check for the 15-byte instruction length limit.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/translate.c | 228 ++++++++++++++++++++++++++----------------------
 1 file changed, 125 insertions(+), 103 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 5d61fa9..4a938c2 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -1863,6 +1863,41 @@ static void gen_shifti(DisasContext *s1, int op, TCGMemOp ot, int d, int c)
     }
 }
 
+static uint64_t advance_pc(CPUX86State *env, DisasContext *s, int num_bytes)
+{
+    uint64_t pc = s->pc;
+
+    s->pc += num_bytes;
+    return pc;
+}
+
+static inline uint8_t x86_ldub_code(CPUX86State *env, DisasContext *s)
+{
+    return cpu_ldub_code(env, advance_pc(env, s, 1));
+}
+
+static inline int16_t x86_ldsw_code(CPUX86State *env, DisasContext *s)
+{
+    return cpu_ldsw_code(env, advance_pc(env, s, 2));
+}
+
+static inline uint16_t x86_lduw_code(CPUX86State *env, DisasContext *s)
+{
+    return cpu_lduw_code(env, advance_pc(env, s, 2));
+}
+
+static inline uint32_t x86_ldl_code(CPUX86State *env, DisasContext *s)
+{
+    return cpu_ldl_code(env, advance_pc(env, s, 4));
+}
+
+#ifdef TARGET_X86_64
+static inline uint64_t x86_ldq_code(CPUX86State *env, DisasContext *s)
+{
+    return cpu_ldq_code(env, advance_pc(env, s, 8));
+}
+#endif
+
 /* Decompose an address.  */
 
 typedef struct AddressParts {
@@ -1900,7 +1935,7 @@ static AddressParts gen_lea_modrm_0(CPUX86State *env, DisasContext *s,
     case MO_32:
         havesib = 0;
         if (rm == 4) {
-            int code = cpu_ldub_code(env, s->pc++);
+            int code = x86_ldub_code(env, s);
             scale = (code >> 6) & 3;
             index = ((code >> 3) & 7) | REX_X(s);
             if (index == 4) {
@@ -1914,8 +1949,7 @@ static AddressParts gen_lea_modrm_0(CPUX86State *env, DisasContext *s,
         case 0:
             if ((base & 7) == 5) {
                 base = -1;
-                disp = (int32_t)cpu_ldl_code(env, s->pc);
-                s->pc += 4;
+                disp = (int32_t)x86_ldl_code(env, s);
                 if (CODE64(s) && !havesib) {
                     base = -2;
                     disp += s->pc + s->rip_offset;
@@ -1923,12 +1957,11 @@ static AddressParts gen_lea_modrm_0(CPUX86State *env, DisasContext *s,
             }
             break;
         case 1:
-            disp = (int8_t)cpu_ldub_code(env, s->pc++);
+            disp = (int8_t)x86_ldub_code(env, s);
             break;
         default:
         case 2:
-            disp = (int32_t)cpu_ldl_code(env, s->pc);
-            s->pc += 4;
+            disp = (int32_t)x86_ldl_code(env, s);
             break;
         }
 
@@ -1945,15 +1978,13 @@ static AddressParts gen_lea_modrm_0(CPUX86State *env, DisasContext *s,
         if (mod == 0) {
             if (rm == 6) {
                 base = -1;
-                disp = cpu_lduw_code(env, s->pc);
-                s->pc += 2;
+                disp = x86_lduw_code(env, s);
                 break;
             }
         } else if (mod == 1) {
-            disp = (int8_t)cpu_ldub_code(env, s->pc++);
+            disp = (int8_t)x86_ldub_code(env, s);
         } else {
-            disp = (int16_t)cpu_lduw_code(env, s->pc);
-            s->pc += 2;
+            disp = (int16_t)x86_lduw_code(env, s);
         }
 
         switch (rm) {
@@ -2103,19 +2134,16 @@ static inline uint32_t insn_get(CPUX86State *env, DisasContext *s, TCGMemOp ot)
 
     switch (ot) {
     case MO_8:
-        ret = cpu_ldub_code(env, s->pc);
-        s->pc++;
+        ret = x86_ldub_code(env, s);
         break;
     case MO_16:
-        ret = cpu_lduw_code(env, s->pc);
-        s->pc += 2;
+        ret = x86_lduw_code(env, s);
         break;
     case MO_32:
 #ifdef TARGET_X86_64
     case MO_64:
 #endif
-        ret = cpu_ldl_code(env, s->pc);
-        s->pc += 4;
+        ret = x86_ldl_code(env, s);
         break;
     default:
         tcg_abort();
@@ -3041,7 +3069,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
         gen_helper_enter_mmx(cpu_env);
     }
 
-    modrm = cpu_ldub_code(env, s->pc++);
+    modrm = x86_ldub_code(env, s);
     reg = ((modrm >> 3) & 7);
     if (is_xmm)
         reg |= rex_r;
@@ -3250,8 +3278,8 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
 
                 if (b1 == 1 && reg != 0)
                     goto illegal_op;
-                field_length = cpu_ldub_code(env, s->pc++) & 0x3F;
-                bit_index = cpu_ldub_code(env, s->pc++) & 0x3F;
+                field_length = x86_ldub_code(env, s) & 0x3F;
+                bit_index = x86_ldub_code(env, s) & 0x3F;
                 tcg_gen_addi_ptr(cpu_ptr0, cpu_env,
                     offsetof(CPUX86State,xmm_regs[reg]));
                 if (b1 == 1)
@@ -3380,7 +3408,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
             if (b1 >= 2) {
 	        goto unknown_op;
             }
-            val = cpu_ldub_code(env, s->pc++);
+            val = x86_ldub_code(env, s);
             if (is_xmm) {
                 tcg_gen_movi_tl(cpu_T0, val);
                 tcg_gen_st32_tl(cpu_T0, cpu_env, offsetof(CPUX86State,xmm_t0.ZMM_L(0)));
@@ -3537,7 +3565,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
         case 0x1c4:
             s->rip_offset = 1;
             gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
-            val = cpu_ldub_code(env, s->pc++);
+            val = x86_ldub_code(env, s);
             if (b1) {
                 val &= 7;
                 tcg_gen_st16_tl(cpu_T0, cpu_env,
@@ -3553,7 +3581,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
             if (mod != 3)
                 goto illegal_op;
             ot = mo_64_32(s->dflag);
-            val = cpu_ldub_code(env, s->pc++);
+            val = x86_ldub_code(env, s);
             if (b1) {
                 val &= 7;
                 rm = (modrm & 7) | REX_B(s);
@@ -3616,7 +3644,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
             if ((b & 0xf0) == 0xf0) {
                 goto do_0f_38_fx;
             }
-            modrm = cpu_ldub_code(env, s->pc++);
+            modrm = x86_ldub_code(env, s);
             rm = modrm & 7;
             reg = ((modrm >> 3) & 7) | rex_r;
             mod = (modrm >> 6) & 3;
@@ -3693,7 +3721,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
         do_0f_38_fx:
             /* Various integer extensions at 0f 38 f[0-f].  */
             b = modrm | (b1 << 8);
-            modrm = cpu_ldub_code(env, s->pc++);
+            modrm = x86_ldub_code(env, s);
             reg = ((modrm >> 3) & 7) | rex_r;
 
             switch (b) {
@@ -4054,7 +4082,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
         case 0x03a:
         case 0x13a:
             b = modrm;
-            modrm = cpu_ldub_code(env, s->pc++);
+            modrm = x86_ldub_code(env, s);
             rm = modrm & 7;
             reg = ((modrm >> 3) & 7) | rex_r;
             mod = (modrm >> 6) & 3;
@@ -4077,7 +4105,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 if (mod != 3)
                     gen_lea_modrm(env, s, modrm);
                 reg = ((modrm >> 3) & 7) | rex_r;
-                val = cpu_ldub_code(env, s->pc++);
+                val = x86_ldub_code(env, s);
                 switch (b) {
                 case 0x14: /* pextrb */
                     tcg_gen_ld8u_tl(cpu_T0, cpu_env, offsetof(CPUX86State,
@@ -4225,7 +4253,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                     gen_ldq_env_A0(s, op2_offset);
                 }
             }
-            val = cpu_ldub_code(env, s->pc++);
+            val = x86_ldub_code(env, s);
 
             if ((b & 0xfc) == 0x60) { /* pcmpXstrX */
                 set_cc_op(s, CC_OP_EFLAGS);
@@ -4244,7 +4272,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
         case 0x33a:
             /* Various integer extensions at 0f 3a f[0-f].  */
             b = modrm | (b1 << 8);
-            modrm = cpu_ldub_code(env, s->pc++);
+            modrm = x86_ldub_code(env, s);
             reg = ((modrm >> 3) & 7) | rex_r;
 
             switch (b) {
@@ -4256,7 +4284,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 }
                 ot = mo_64_32(s->dflag);
                 gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
-                b = cpu_ldub_code(env, s->pc++);
+                b = x86_ldub_code(env, s);
                 if (ot == MO_64) {
                     tcg_gen_rotri_tl(cpu_T0, cpu_T0, b & 63);
                 } else {
@@ -4351,7 +4379,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
         }
         switch(b) {
         case 0x0f: /* 3DNow! data insns */
-            val = cpu_ldub_code(env, s->pc++);
+            val = x86_ldub_code(env, s);
             sse_fn_epp = sse_op_table5[val];
             if (!sse_fn_epp) {
                 goto unknown_op;
@@ -4365,7 +4393,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
             break;
         case 0x70: /* pshufx insn */
         case 0xc6: /* pshufx insn */
-            val = cpu_ldub_code(env, s->pc++);
+            val = x86_ldub_code(env, s);
             tcg_gen_addi_ptr(cpu_ptr0, cpu_env, op1_offset);
             tcg_gen_addi_ptr(cpu_ptr1, cpu_env, op2_offset);
             /* XXX: introduce a new table? */
@@ -4374,7 +4402,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
             break;
         case 0xc2:
             /* compare insns */
-            val = cpu_ldub_code(env, s->pc++);
+            val = x86_ldub_code(env, s);
             if (val >= 8)
                 goto unknown_op;
             sse_fn_epp = sse_op_table4[val][b1];
@@ -4443,8 +4471,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     if (s->pc - pc_start > 14) {
         goto illegal_op;
     }
-    b = cpu_ldub_code(env, s->pc);
-    s->pc++;
+    b = x86_ldub_code(env, s);
     /* Collect prefixes.  */
     switch (b) {
     case 0xf3:
@@ -4501,7 +4528,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             static const int pp_prefix[4] = {
                 0, PREFIX_DATA, PREFIX_REPZ, PREFIX_REPNZ
             };
-            int vex3, vex2 = cpu_ldub_code(env, s->pc);
+            int vex3, vex2 = x86_ldub_code(env, s);
 
             if (!CODE64(s) && (vex2 & 0xc0) != 0xc0) {
                 /* 4.1.4.6: In 32-bit mode, bits [7:6] must be 11b,
@@ -4523,17 +4550,17 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             rex_r = (~vex2 >> 4) & 8;
             if (b == 0xc5) {
                 vex3 = vex2;
-                b = cpu_ldub_code(env, s->pc++);
+                b = x86_ldub_code(env, s);
             } else {
 #ifdef TARGET_X86_64
                 s->rex_x = (~vex2 >> 3) & 8;
                 s->rex_b = (~vex2 >> 2) & 8;
 #endif
-                vex3 = cpu_ldub_code(env, s->pc++);
+                vex3 = x86_ldub_code(env, s);
                 rex_w = (vex3 >> 7) & 1;
                 switch (vex2 & 0x1f) {
                 case 0x01: /* Implied 0f leading opcode bytes.  */
-                    b = cpu_ldub_code(env, s->pc++) | 0x100;
+                    b = x86_ldub_code(env, s) | 0x100;
                     break;
                 case 0x02: /* Implied 0f 38 leading opcode bytes.  */
                     b = 0x138;
@@ -4585,7 +4612,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x0f:
         /**************************/
         /* extended op code */
-        b = cpu_ldub_code(env, s->pc++) | 0x100;
+        b = x86_ldub_code(env, s) | 0x100;
         goto reswitch;
 
         /**************************/
@@ -4607,7 +4634,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
             switch(f) {
             case 0: /* OP Ev, Gv */
-                modrm = cpu_ldub_code(env, s->pc++);
+                modrm = x86_ldub_code(env, s);
                 reg = ((modrm >> 3) & 7) | rex_r;
                 mod = (modrm >> 6) & 3;
                 rm = (modrm & 7) | REX_B(s);
@@ -4628,7 +4655,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 gen_op(s, op, ot, opreg);
                 break;
             case 1: /* OP Gv, Ev */
-                modrm = cpu_ldub_code(env, s->pc++);
+                modrm = x86_ldub_code(env, s);
                 mod = (modrm >> 6) & 3;
                 reg = ((modrm >> 3) & 7) | rex_r;
                 rm = (modrm & 7) | REX_B(s);
@@ -4662,7 +4689,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
             ot = mo_b_d(b, dflag);
 
-            modrm = cpu_ldub_code(env, s->pc++);
+            modrm = x86_ldub_code(env, s);
             mod = (modrm >> 6) & 3;
             rm = (modrm & 7) | REX_B(s);
             op = (modrm >> 3) & 7;
@@ -4708,7 +4735,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xf7:
         ot = mo_b_d(b, dflag);
 
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         rm = (modrm & 7) | REX_B(s);
         op = (modrm >> 3) & 7;
@@ -4940,7 +4967,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xff: /* GRP5 */
         ot = mo_b_d(b, dflag);
 
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         rm = (modrm & 7) | REX_B(s);
         op = (modrm >> 3) & 7;
@@ -5048,7 +5075,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x85:
         ot = mo_b_d(b, dflag);
 
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | rex_r;
 
         gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
@@ -5120,7 +5147,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x69: /* imul Gv, Ev, I */
     case 0x6b:
         ot = dflag;
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | rex_r;
         if (b == 0x69)
             s->rip_offset = insn_const_size(ot);
@@ -5172,7 +5199,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x1c0:
     case 0x1c1: /* xadd Ev, Gv */
         ot = mo_b_d(b, dflag);
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | rex_r;
         mod = (modrm >> 6) & 3;
         gen_op_mov_v_reg(ot, cpu_T0, reg);
@@ -5204,7 +5231,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             TCGv oldv, newv, cmpv;
 
             ot = mo_b_d(b, dflag);
-            modrm = cpu_ldub_code(env, s->pc++);
+            modrm = x86_ldub_code(env, s);
             reg = ((modrm >> 3) & 7) | rex_r;
             mod = (modrm >> 6) & 3;
             oldv = tcg_temp_new();
@@ -5256,7 +5283,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         }
         break;
     case 0x1c7: /* cmpxchg8b */
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         if ((mod == 3) || ((modrm & 0x38) != 0x8))
             goto illegal_op;
@@ -5318,7 +5345,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         gen_push_v(s, cpu_T0);
         break;
     case 0x8f: /* pop Ev */
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         ot = gen_pop_T0(s);
         if (mod == 3) {
@@ -5337,9 +5364,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xc8: /* enter */
         {
             int level;
-            val = cpu_lduw_code(env, s->pc);
-            s->pc += 2;
-            level = cpu_ldub_code(env, s->pc++);
+            val = x86_lduw_code(env, s);
+            level = x86_ldub_code(env, s);
             gen_enter(s, val, level);
         }
         break;
@@ -5396,7 +5422,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x88:
     case 0x89: /* mov Gv, Ev */
         ot = mo_b_d(b, dflag);
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | rex_r;
 
         /* generate a generic store */
@@ -5405,7 +5431,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xc6:
     case 0xc7: /* mov Ev, Iv */
         ot = mo_b_d(b, dflag);
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         if (mod != 3) {
             s->rip_offset = insn_const_size(ot);
@@ -5422,14 +5448,14 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x8a:
     case 0x8b: /* mov Ev, Gv */
         ot = mo_b_d(b, dflag);
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | rex_r;
 
         gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
         gen_op_mov_reg_v(ot, reg, cpu_T0);
         break;
     case 0x8e: /* mov seg, Gv */
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         reg = (modrm >> 3) & 7;
         if (reg >= 6 || reg == R_CS)
             goto illegal_op;
@@ -5447,7 +5473,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         }
         break;
     case 0x8c: /* mov Gv, seg */
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         reg = (modrm >> 3) & 7;
         mod = (modrm >> 6) & 3;
         if (reg >= 6)
@@ -5472,7 +5498,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             /* s_ot is the sign+size of source */
             s_ot = b & 8 ? MO_SIGN | ot : ot;
 
-            modrm = cpu_ldub_code(env, s->pc++);
+            modrm = x86_ldub_code(env, s);
             reg = ((modrm >> 3) & 7) | rex_r;
             mod = (modrm >> 6) & 3;
             rm = (modrm & 7) | REX_B(s);
@@ -5508,7 +5534,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
 
     case 0x8d: /* lea */
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         if (mod == 3)
             goto illegal_op;
@@ -5532,8 +5558,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             switch (s->aflag) {
 #ifdef TARGET_X86_64
             case MO_64:
-                offset_addr = cpu_ldq_code(env, s->pc);
-                s->pc += 8;
+                offset_addr = x86_ldq_code(env, s);
                 break;
 #endif
             default:
@@ -5570,8 +5595,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (dflag == MO_64) {
             uint64_t tmp;
             /* 64 bit case */
-            tmp = cpu_ldq_code(env, s->pc);
-            s->pc += 8;
+            tmp = x86_ldq_code(env, s);
             reg = (b & 7) | REX_B(s);
             tcg_gen_movi_tl(cpu_T0, tmp);
             gen_op_mov_reg_v(MO_64, reg, cpu_T0);
@@ -5595,7 +5619,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x86:
     case 0x87: /* xchg Ev, Gv */
         ot = mo_b_d(b, dflag);
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | rex_r;
         mod = (modrm >> 6) & 3;
         if (mod == 3) {
@@ -5632,7 +5656,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         op = R_GS;
     do_lxx:
         ot = dflag != MO_16 ? MO_32 : MO_16;
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | rex_r;
         mod = (modrm >> 6) & 3;
         if (mod == 3)
@@ -5660,7 +5684,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     grp2:
         {
             ot = mo_b_d(b, dflag);
-            modrm = cpu_ldub_code(env, s->pc++);
+            modrm = x86_ldub_code(env, s);
             mod = (modrm >> 6) & 3;
             op = (modrm >> 3) & 7;
 
@@ -5679,7 +5703,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 gen_shift(s, op, ot, opreg, OR_ECX);
             } else {
                 if (shift == 2) {
-                    shift = cpu_ldub_code(env, s->pc++);
+                    shift = x86_ldub_code(env, s);
                 }
                 gen_shifti(s, op, ot, opreg, shift);
             }
@@ -5713,7 +5737,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         shift = 0;
     do_shiftd:
         ot = dflag;
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         rm = (modrm & 7) | REX_B(s);
         reg = ((modrm >> 3) & 7) | rex_r;
@@ -5726,7 +5750,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         gen_op_mov_v_reg(ot, cpu_T1, reg);
 
         if (shift) {
-            TCGv imm = tcg_const_tl(cpu_ldub_code(env, s->pc++));
+            TCGv imm = tcg_const_tl(x86_ldub_code(env, s));
             gen_shiftd_rm_T1(s, ot, opreg, op, imm);
             tcg_temp_free(imm);
         } else {
@@ -5743,7 +5767,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_exception(s, EXCP07_PREX, pc_start - s->cs_base);
             break;
         }
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         rm = modrm & 7;
         op = ((b & 7) << 3) | ((modrm >> 3) & 7);
@@ -6328,7 +6352,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xe4:
     case 0xe5:
         ot = mo_b_d32(b, dflag);
-        val = cpu_ldub_code(env, s->pc++);
+        val = x86_ldub_code(env, s);
         tcg_gen_movi_tl(cpu_T0, val);
         gen_check_io(s, ot, pc_start - s->cs_base,
                      SVM_IOIO_TYPE_MASK | svm_is_rep(prefixes));
@@ -6347,7 +6371,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xe6:
     case 0xe7:
         ot = mo_b_d32(b, dflag);
-        val = cpu_ldub_code(env, s->pc++);
+        val = x86_ldub_code(env, s);
         tcg_gen_movi_tl(cpu_T0, val);
         gen_check_io(s, ot, pc_start - s->cs_base,
                      svm_is_rep(prefixes));
@@ -6407,8 +6431,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         /************************/
         /* control */
     case 0xc2: /* ret im */
-        val = cpu_ldsw_code(env, s->pc);
-        s->pc += 2;
+        val = x86_ldsw_code(env, s);
         ot = gen_pop_T0(s);
         gen_stack_update(s, val + (1 << ot));
         /* Note that gen_pop_T0 uses a zero-extending load.  */
@@ -6425,8 +6448,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         gen_jr(s, cpu_T0);
         break;
     case 0xca: /* lret im */
-        val = cpu_ldsw_code(env, s->pc);
-        s->pc += 2;
+        val = x86_ldsw_code(env, s);
     do_lret:
         if (s->pe && !s->vm86) {
             gen_update_cc_op(s);
@@ -6563,7 +6585,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
 
     case 0x190 ... 0x19f: /* setcc Gv */
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         gen_setcc1(s, b, cpu_T0);
         gen_ldst_modrm(env, s, modrm, MO_8, OR_TMP0, 1);
         break;
@@ -6572,7 +6594,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             goto illegal_op;
         }
         ot = dflag;
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | rex_r;
         gen_cmovcc1(env, s, ot, b, modrm, reg);
         break;
@@ -6689,7 +6711,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         /* bit operations */
     case 0x1ba: /* bt/bts/btr/btc Gv, im */
         ot = dflag;
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         op = (modrm >> 3) & 7;
         mod = (modrm >> 6) & 3;
         rm = (modrm & 7) | REX_B(s);
@@ -6703,7 +6725,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_op_mov_v_reg(ot, cpu_T0, rm);
         }
         /* load shift */
-        val = cpu_ldub_code(env, s->pc++);
+        val = x86_ldub_code(env, s);
         tcg_gen_movi_tl(cpu_T1, val);
         if (op < 4)
             goto unknown_op;
@@ -6722,7 +6744,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         op = 3;
     do_btx:
         ot = dflag;
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | rex_r;
         mod = (modrm >> 6) & 3;
         rm = (modrm & 7) | REX_B(s);
@@ -6827,7 +6849,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x1bc: /* bsf / tzcnt */
     case 0x1bd: /* bsr / lzcnt */
         ot = dflag;
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | rex_r;
         gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
         gen_extu(ot, cpu_T0);
@@ -6907,7 +6929,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xd4: /* aam */
         if (CODE64(s))
             goto illegal_op;
-        val = cpu_ldub_code(env, s->pc++);
+        val = x86_ldub_code(env, s);
         if (val == 0) {
             gen_exception(s, EXCP00_DIVZ, pc_start - s->cs_base);
         } else {
@@ -6918,7 +6940,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xd5: /* aad */
         if (CODE64(s))
             goto illegal_op;
-        val = cpu_ldub_code(env, s->pc++);
+        val = x86_ldub_code(env, s);
         gen_helper_aad(cpu_env, tcg_const_i32(val));
         set_cc_op(s, CC_OP_LOGICB);
         break;
@@ -6952,7 +6974,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         gen_interrupt(s, EXCP03_INT3, pc_start - s->cs_base, s->pc - s->cs_base);
         break;
     case 0xcd: /* int N */
-        val = cpu_ldub_code(env, s->pc++);
+        val = x86_ldub_code(env, s);
         if (s->vm86 && s->iopl != 3) {
             gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
         } else {
@@ -7007,7 +7029,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (CODE64(s))
             goto illegal_op;
         ot = dflag;
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         reg = (modrm >> 3) & 7;
         mod = (modrm >> 6) & 3;
         if (mod == 3)
@@ -7186,7 +7208,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         }
         break;
     case 0x100:
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         op = (modrm >> 3) & 7;
         switch(op) {
@@ -7251,7 +7273,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
 
     case 0x101:
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         switch (modrm) {
         CASE_MODRM_MEM_OP(0): /* sgdt */
             gen_svm_check_intercept(s, pc_start, SVM_EXIT_GDTR_READ);
@@ -7596,7 +7618,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             /* d_ot is the size of destination */
             d_ot = dflag;
 
-            modrm = cpu_ldub_code(env, s->pc++);
+            modrm = x86_ldub_code(env, s);
             reg = ((modrm >> 3) & 7) | rex_r;
             mod = (modrm >> 6) & 3;
             rm = (modrm & 7) | REX_B(s);
@@ -7625,7 +7647,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             t1 = tcg_temp_local_new();
             t2 = tcg_temp_local_new();
             ot = MO_16;
-            modrm = cpu_ldub_code(env, s->pc++);
+            modrm = x86_ldub_code(env, s);
             reg = (modrm >> 3) & 7;
             mod = (modrm >> 6) & 3;
             rm = modrm & 7;
@@ -7670,7 +7692,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             if (!s->pe || s->vm86)
                 goto illegal_op;
             ot = dflag != MO_16 ? MO_32 : MO_16;
-            modrm = cpu_ldub_code(env, s->pc++);
+            modrm = x86_ldub_code(env, s);
             reg = ((modrm >> 3) & 7) | rex_r;
             gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
             t0 = tcg_temp_local_new();
@@ -7690,7 +7712,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         }
         break;
     case 0x118:
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         op = (modrm >> 3) & 7;
         switch(op) {
@@ -7709,7 +7731,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         }
         break;
     case 0x11a:
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         if (s->flags & HF_MPX_EN_MASK) {
             mod = (modrm >> 6) & 3;
             reg = ((modrm >> 3) & 7) | rex_r;
@@ -7799,7 +7821,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         gen_nop_modrm(env, s, modrm);
         break;
     case 0x11b:
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         if (s->flags & HF_MPX_EN_MASK) {
             mod = (modrm >> 6) & 3;
             reg = ((modrm >> 3) & 7) | rex_r;
@@ -7901,7 +7923,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         gen_nop_modrm(env, s, modrm);
         break;
     case 0x119: case 0x11c ... 0x11f: /* nop (multi byte) */
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         gen_nop_modrm(env, s, modrm);
         break;
     case 0x120: /* mov reg, crN */
@@ -7909,7 +7931,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (s->cpl != 0) {
             gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
         } else {
-            modrm = cpu_ldub_code(env, s->pc++);
+            modrm = x86_ldub_code(env, s);
             /* Ignore the mod bits (assume (modrm&0xc0)==0xc0).
              * AMD documentation (24594.pdf) and testing of
              * intel 386 and 486 processors all show that the mod bits
@@ -7966,7 +7988,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (s->cpl != 0) {
             gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
         } else {
-            modrm = cpu_ldub_code(env, s->pc++);
+            modrm = x86_ldub_code(env, s);
             /* Ignore the mod bits (assume (modrm&0xc0)==0xc0).
              * AMD documentation (24594.pdf) and testing of
              * intel 386 and 486 processors all show that the mod bits
@@ -8012,7 +8034,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (!(s->cpuid_features & CPUID_SSE2))
             goto illegal_op;
         ot = mo_64_32(dflag);
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         if (mod == 3)
             goto illegal_op;
@@ -8021,7 +8043,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         gen_ldst_modrm(env, s, modrm, ot, reg, 1);
         break;
     case 0x1ae:
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         switch (modrm) {
         CASE_MODRM_MEM_OP(0): /* fxsave */
             if (!(s->cpuid_features & CPUID_FXSR)
@@ -8219,7 +8241,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
 
     case 0x10d: /* 3DNow! prefetch(w) */
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         if (mod == 3)
             goto illegal_op;
@@ -8241,7 +8263,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (!(s->cpuid_ext_features & CPUID_EXT_POPCNT))
             goto illegal_op;
 
-        modrm = cpu_ldub_code(env, s->pc++);
+        modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | rex_r;
 
         if (s->prefix & PREFIX_DATA) {
-- 
1.8.3.1
