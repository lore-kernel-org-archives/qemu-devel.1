Received: from eggs.gnu.org ([2001:4830:134:3::10]:47710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYflP-0000HC-9R
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 18:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYflM-0008Ne-4B
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 18:51:43 -0400
Received: from mail-pl0-x22f.google.com ([2607:f8b0:400e:c01::22f]:33276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYflL-0008MH-IB
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 18:51:40 -0400
Received: by mail-pl0-x22f.google.com with SMTP id 6-v6so3470481plb.0
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 15:51:39 -0700 (PDT)
References: <BN7PR08MB4868A12171F6E86D64E8CB3CC64F0@BN7PR08MB4868.namprd08.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3223752a-7827-03fd-c554-1103d572b718@linaro.org>
Date: Thu, 28 Jun 2018 15:51:35 -0700
MIME-Version: 1.0
In-Reply-To: <BN7PR08MB4868A12171F6E86D64E8CB3CC64F0@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] some thoughts on nanoMIPS solution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Petar Jovanovic <pjovanovic@wavecomp.com>, qemu-devel <qemu-devel@nongnu.org>

On 06/28/2018 01:07 PM, Aleksandar Markovic wrote:
> Therefore, I think it makes sense to (more or less) split translate.c into,
> let's say, following set of files:
> 
>   * translate_cmn_chk.h - definitions of (typically inlined) functions check_XXX()
>   * translate_cmn_gen.h - declarations of gen_XXX() family of functions, and
>     definitions of such functions among them that are inlined
>   * translate_cmn_gen.c - definitions of non-inlined gen_XXX() functions
>     (including all their callees)
> 
>   * translate.h - common structure definitions such as DisasContext
>   * translate.c - the rest of code after splitting
> 
> 
> The nanoMIPS code would be, in such organization, in a separate file:
> 
>   * translate_nanomips.c

This sounds fine.  Thanks for being willing to tackle this.


> Let me explain in some additional details what I have in mind. Consider, for
> example, the function gen_logic(). It currently expects one argument to be
> OPC_ADD, OPC_OR, OPC_NOR, or OPC_XOR. Note that those are pre-nanoMIPS opcodes.
> nanoMIPS may or may not have the same respective opcodes. In order to break
> dependency of such functions on particular opcode tables, I propose introducing
> new enum types, independant on any opcode organization. For example, for
> gen_logic(), the new corresponding enum would be:
> 
> 
> enum LogicOp {
>     opLogic_AND             = 1000,
>     opLogic_OR,
>     opLogic_NOR,
>     opLogic_XOR,
> };
> 
> and the new declaration of gen_logic() would be:
> 
> 
> extern void gen_logic(DisasContext *ctx, LogicOp op, int rd, int rs, int rt);


I would suggest an alternative in which the enum is removed, and split each
case into a separate function.  There is a small amount of code that is shared
between the cases, and that can be handled via subroutines.

I suggest "gen_insn_<opcode>" as the prefix for this because there are quite a
number of "gen_foo" functions that are not in the form to implement an
architectural instruction exactly.  Naming provides an easy way to distinguish
the two cases, especially during transition.

For example,

/* Expand an operation on 3 integer registers.
 * The given operation must have no side effects
 * other than setting the destination.
 */
static void gen_rrr(DisasContext *ctx, int rd, int rs, int rt,
                    void (*gen_fn)(TCGv, TCGv, TCGv))
{
    TCGv reg_s = cpu_gpr[rs];
    TCGv reg_t = cpu_gpr[rt];
    TCGv zero = NULL;

    if (unlikely(rd == 0)) {
        return;
    }
    if (unlikely(rs == 0 || rt == 0)) {
        zero = tcg_const_tl(0);
        if (rs == 0) {
            reg_s = zero;
        }
        if (rt == 0) {
            reg_t = zero;
        }
    }

    gen_fn(cpu_gpr[rd], reg_s, reg_t);

    if (unlikely(zero != NULL)) {
        tcg_temp_free(zero);
    }
}

void gen_insn_and(DisasContext *ctx, int rd, int rs, int rt)
{
    gen_rrr(ctx, rd, rs, rt, tcg_gen_and_tl);
}

void gen_insn_xor(DisasContext *ctx, int rd, int rs, int rt)
{
    gen_rrr(ctx, rd, rs, rt, tcg_gen_xor_tl);
}

void gen_insn_nor(DisasContext *ctx, int rd, int rs, int rt)
{
    if (rd != 0) {
        /* NOT is a special case of NOR D,S,0.  */
        if (rs != 0 && rt == 0) {
            tcg_gen_not_tl(cpu_gpr[rd], cpu_gpr[rs]);
        } else {
            gen_rrr(ctx, rd, rs, rt, tcg_gen_nor_tl);
        }
    }
}

void gen_insn_or(DisasContext *ctx, int rd, int rs, int rt)
{
    if (rd != 0) {
        /* MOVE is a special case of OR D,S,0.  */
        if (rt == 0) {
            if (rs == 0) {
                tcg_gen_movi_tl(cpu_gpr[rd], 0);
            } else {
                tcg_gen_mov_tl(cpu_gpr[rd], cpu_gpr[rs]);
            }
        } else {
            gen_rrr(ctx, rd, rs, rt, tcg_gen_or_tl);
        }
    }
}

static void gen_addu(TCGv reg_d, TCGv reg_s, TCGv reg_t)
{
    tcg_gen_add_tl(reg_d, reg_s, reg_t);
    tcg_gen_ext32s_tl(reg_d, reg_d);
}

void gen_insn_addu(DisasContext *ctx, int rd, int rs, int rt)
{
    if (rd != 0) {
        /* Old assemblers expand MOVE with ADDU D,S,0.  */
        if (rt == 0) {
            if (rs == 0) {
                tcg_gen_movi_tl(cpu_gpr[rd], 0);
            } else {
                tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rs]);
            }
        } else {
            gen_rrr(ctx, rd, rs, rt, gen_addu);
        }
    }
}

While making this transformation, please bear in mind

(1) The simplifications, particularly with constant arguments,
    that are already made by tcg/tcg-op.c.

    E.g. d = s|s -> d = s, and d = s+0 -> d = s.

    There is no point in checking for these again in target/mips/.

(2) The likelihood of r0 appearing in a given argument.

    E.g. while it is possible to encode mul d,s,0, it will probably
    never appear as a set of arguments, and so it is not worth
    handling specially.

    So long as d, s and a temporary containing 0 are passed to the
    proper tcg expander, you will emulate the edge case correctly.

    The approach that we have taken for other targets, e.g. AArch64
    and Alpha, is to only recognize as special cases those pseudo
    instructions that are called out in the manual.  Or failing that,
    the pseudo instructions that are defined by the assembler.

    E.g. for mips, I see in gas:
    move	or     d,s,0
    move	daddu  d,s,0
    move        addu   d,s,0

    so above, I check for "or d,s,0" but not "or d,0,t".

(3) The simplifications that are made during tcg optimization.

    Even when we do not special case as per point 2, we may still
    produce optimal results out of the constant folding stage of
    tcg optimization.

    The balancing act based on total emulation time.

    Common operand combinations like the official NOP or MOVE are
    special-cased in the translator in order to produce fewer
    opcodes, which requires less processing further down the line.

    Uncommon operand combinations require more processing up front,
    but since they are (by definition) uncommon there is no payoff
    and merely introduces more branches during translation.


> The pseudocode of invoking gen_logic() for existing platforms would be:
> 
> case OPC_ADD:
>     gen_logic(opLogic_AND); break;
> case OPC_OR:
>     gen_logic(opLogic_OR); break;
> case OPC_NOR:
>     gen_logic(opLogic_NOR); break;
> case OPC_XOR:
>     gen_logic(opLogic_XOR); break;


  case OPC_ADD:
      gen_insn_and(...);
      break;
  case OPC_OR:
      gen_insn_or(...);
      break;
  case OPC_NOR:
      gen_insn_nor(...);
      break;
  case OPC_XOR:
      gen_insn_xor(...);
      break;

You can see that there's no difference in complexity between these two
solutions at the source-code level.


r~
