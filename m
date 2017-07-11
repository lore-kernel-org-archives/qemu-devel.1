Received: from eggs.gnu.org ([2001:4830:134:3::10]:43368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ricardo.ribalda@gmail.com>) id 1dUuz6-0000ed-V8
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ricardo.ribalda@gmail.com>) id 1dUuz2-0002ch-Fy
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:13:48 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:37336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ricardo.ribalda@gmail.com>)
	id 1dUuz2-0002cT-A4
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:13:44 -0400
Received: by mail-it0-f43.google.com with SMTP id m84so19566261ita.0
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 06:13:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d4dc76c1-ea7a-1e11-0070-2685c970db3e@twiddle.net>
References: <CAPybu_28Fi-QEpoCP2APs+FdEuEOmSJnEK==ubJimE907-WLYw@mail.gmail.com>
	<d4dc76c1-ea7a-1e11-0070-2685c970db3e@twiddle.net>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Tue, 11 Jul 2017 15:12:23 +0200
Message-ID: <CAPybu_3i1GhettT-7eYEPFyQvjjVSKpPiefr3D4jB4hymHeJDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] qemu-x86_64: Error processing bextr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Blue Swirl <blauwirbel@gmail.com>

Hi Richard

Thanks for the fast response!

I have added support for the tbm bextr instruction and now I am
getting SIGSEGV on another part of the program, seems like the stack
is smashed at some point :(. My guess is that it is another
instruction that is not properly handled.

Are you aware of anyone working on adding support for the AMD
Bulldozer v4? Does AMD care about its support?

Best regards!


PS:
In case someone cares about support for bextr tbm, here is a very poor
implementation (seems to work ok, but requries much more testing).

diff --git a/target-i386/cpu.c b/target-i386/cpu.c
index de1f30eeda63..347c7f35f1ca 100644
--- a/target-i386/cpu.c
+++ b/target-i386/cpu.c
@@ -1475,6 +1475,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_MISALIGNSSE |
             CPUID_EXT3_SSE4A | CPUID_EXT3_ABM | CPUID_EXT3_SVM |
             CPUID_EXT3_LAHF_LM,
+        .features[FEAT_7_0_EBX] = CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_BMI2,
         /* no xsaveopt! */
         .xlevel = 0x8000001A,
         .model_id = "AMD Opteron 63xx class CPU",
diff --git a/target-i386/translate.c b/target-i386/translate.c
index 324103c88521..2345135c4138 100644
--- a/target-i386/translate.c
+++ b/target-i386/translate.c
@@ -38,6 +38,7 @@
 #define PREFIX_DATA   0x08
 #define PREFIX_ADR    0x10
 #define PREFIX_VEX    0x20
+#define PREFIX_XOP    0x40

 #ifdef TARGET_X86_64
 #define CODE64(s) ((s)->code64)
@@ -3580,7 +3581,8 @@ static void gen_sse(CPUX86State *env,
DisasContext *s, int b,
         case 0x138:
         case 0x038:
             b = modrm;
-            if ((b & 0xf0) == 0xf0) {
+            if (((b & 0xf0) == 0xf0) || (b == 0x10)) {
+ fprintf(stderr, "%s:%d modrm %x\n",__FILE__,__LINE__, modrm);
                 goto do_0f_38_fx;
             }
             modrm = cpu_ldub_code(env, s->pc++);
@@ -3772,6 +3774,54 @@ static void gen_sse(CPUX86State *env,
DisasContext *s, int b,
                 }
                 break;

+            case 0x010: /* bextr Gy, Ey, By */
+ fprintf(stderr, "bextr!\n");
+                if (!(s->prefix & PREFIX_XOP)
+                    || s->vex_l != 0
+    ) {
+                    goto illegal_op;
+                }
+                ot = mo_64_32(s->dflag);
+                {
+    uint32_t aux;
+                    TCGv bound, zero;
+
+    aux = cpu_ldl_code(env, s->pc);
+    s->pc += 4;
+
+                    gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
+                    /* Extract START, and shift the operand.
+                       Shifts larger than operand size get zeros.  */
+    tcg_gen_movi_tl(cpu_A0, aux);
+                    tcg_gen_ext8u_tl(cpu_A0, cpu_A0);
+                    tcg_gen_shr_tl(cpu_T0, cpu_T0, cpu_A0);
+
+                    bound = tcg_const_tl(ot == MO_64 ? 63 : 31);
+                    zero = tcg_const_tl(0);
+                    tcg_gen_movcond_tl(TCG_COND_LEU, cpu_T0, cpu_A0, bound,
+                                       cpu_T0, zero);
+                    tcg_temp_free(zero);
+
+                    /* Extract the LEN into a mask.  Lengths larger than
+                       operand size get all ones.  */
+    tcg_gen_movi_tl(cpu_A0, aux);
+                    tcg_gen_shri_tl(cpu_A0, cpu_A0, 8);
+                    tcg_gen_ext8u_tl(cpu_A0, cpu_A0);
+                    tcg_gen_movcond_tl(TCG_COND_LEU, cpu_A0, cpu_A0, bound,
+                                       cpu_A0, bound);
+                    tcg_temp_free(bound);
+                    tcg_gen_movi_tl(cpu_T1, 1);
+                    tcg_gen_shl_tl(cpu_T1, cpu_T1, cpu_A0);
+                    tcg_gen_subi_tl(cpu_T1, cpu_T1, 1);
+                    tcg_gen_and_tl(cpu_T0, cpu_T0, cpu_T1);
+
+                    gen_op_mov_reg_v(ot, reg, cpu_T0);
+                    gen_op_update1_cc();
+                    set_cc_op(s, CC_OP_LOGICB + ot);
+                }
+ fprintf(stderr, "bextr end!\n");
+                break;
+
             case 0x0f5: /* bzhi Gy, Ey, By */
                 if (!(s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_BMI2)
                     || !(s->prefix & PREFIX_VEX)
@@ -4509,6 +4559,48 @@ static target_ulong disas_insn(CPUX86State
*env, DisasContext *s,
             prefixes |= pp_prefix[vex3 & 3] | PREFIX_VEX;
         }
         break;
+    case 0x8f: /* 7-byte XOP */
+ fprintf(stderr, "XOP!\n");
+        /* XOP prefixes cannot be used except in 32-bit mode.
+           Otherwise the instruction is LES or LDS.  */
+        if (s->code32 && !s->vm86) {
+            static const int pp_prefix[4] = {
+                0, PREFIX_DATA, PREFIX_REPZ, PREFIX_REPNZ
+            };
+            int vex3, vex2 = cpu_ldub_code(env, s->pc);
+
+            if (!CODE64(s) && (vex2 & 0xc0) != 0xc0) {
+                /* 4.1.4.6: In 32-bit mode, bits [7:6] must be 11b,
+                   otherwise the instruction is LES or LDS.  */
+                break;
+            }
+            s->pc++;
+
+            /* 4.1.1-4.1.3: No preceding lock, 66, f2, f3, or rex prefixes. */
+            if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ
+                            | PREFIX_LOCK | PREFIX_DATA)) {
+                goto illegal_op;
+            }
+#ifdef TARGET_X86_64
+            if (x86_64_hregs) {
+                goto illegal_op;
+            }
+#endif
+#ifdef TARGET_X86_64
+    s->rex_x = (~vex2 >> 3) & 8;
+    s->rex_b = (~vex2 >> 2) & 8;
+#endif
+    vex3 = cpu_ldub_code(env, s->pc++);
+    rex_w = (vex3 >> 7) & 1;
+    if ((vex2 & 0x1f) != 0xA)
+ goto unknown_op;
+    b = 0x138;
+            s->vex_v = (~vex3 >> 3) & 0xf;
+            s->vex_l = (vex3 >> 2) & 1;
+            prefixes |= pp_prefix[vex3 & 3] | PREFIX_XOP;
+        }
+    fprintf(stderr, "XOP end!\n");
+        break;
     }

     /* Post-process prefixes.  */

On Tue, Jul 11, 2017 at 1:54 AM, Richard Henderson <rth@twiddle.net> wrote:
> On 07/10/2017 01:17 PM, Ricardo Ribalda Delgado wrote:
>>
>>     0x00000040008179bf <+31>: 8f ea 78 10 d0 08 04 00 00 bextr
>> $0x408,%eax,%edx
>
> ...
>>
>> It seems that, bextr is not supported by the emulator/cpu, althoug I
>> have launched the emualtor with -cpu Haswell, that should support bmi1
>> (https://en.wikipedia.org/wiki/Bit_Manipulation_Instruction_Sets#BMI1)
>
>
> This is not the BMI1 version of bextr, it's the TBM version of bextr.
>
> https://en.wikipedia.org/wiki/Bit_Manipulation_Instruction_Sets#TBM_.28Trailing_Bit_Manipulation.29
>
> TBM is not implemented in qemu yet.
>
>
> r~



-- 
Ricardo Ribalda
