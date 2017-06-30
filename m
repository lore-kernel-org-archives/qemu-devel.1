Received: from eggs.gnu.org ([2001:4830:134:3::10]:54966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQjOY-0006Z2-Nh
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 20:02:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQjOU-0002Uf-1b
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 20:02:46 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:40553)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dQjOT-0002UE-NY
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 20:02:41 -0400
Date: Thu, 29 Jun 2017 20:02:40 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170630000240.GF13979@flamenco>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865316837.17063.1608754834009945976.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <149865316837.17063.1608754834009945976.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v11 04/29] target: [tcg] Add generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Jun 28, 2017 at 15:32:48 +0300, Lluís Vilanova wrote:
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> ---
>  accel/tcg/Makefile.objs   |    1 
>  accel/tcg/translator.c    |  153 +++++++++++++++++++++++++++++++++++++++++++++
>  include/exec/gen-icount.h |    2 -
>  include/exec/translator.h |  104 +++++++++++++++++++++++++++++++
(snip)
> +/**
> + * BreakpointCheckType:
> + * @BC_MISS: No hit
> + * @BC_HIT_INSN: Hit, but continue translating TB
> + * @BC_HIT_TB: Hit, stop translating TB
> + *
> + * How to react to a breakpoint. A hit means no more breakpoints will be checked
> + * for the current instruction.
> + *
> + * Not all breakpoints associated to an address are necessarily raised by
> + * targets (e.g., due to conditions encoded in their flags), so tey can decide
s/tey/they/

> + * that a breakpoint missed the address (@BP_MISS).
> + */
> +typedef enum BreakpointCheckType {
> +    BC_MISS,
> +    BC_HIT_INSN,
> +    BC_HIT_TB,
> +} BreakpointCheckType;
> +
>  /**
>   * DisasJumpType:
>   * @DISAS_NEXT: Next instruction in program order.
> @@ -33,6 +65,78 @@ typedef enum DisasJumpType {
>      DISAS_TARGET_9,
>      DISAS_TARGET_10,
>      DISAS_TARGET_11,
> +    DISAS_TARGET_12,
> +    DISAS_TARGET_13,
> +    DISAS_TARGET_14,
>  } DisasJumpType;
>  
> +/**
> + * DisasContextBase:
> + * @tb: Translation block for this disassembly.
> + * @pc_first: Address of first guest instruction in this TB.
> + * @pc_next: Address of next guest instruction in this TB (current during
> + *           disassembly).
> + * @is_jmp: What instruction to disassemble next.
> + * @num_insns: Number of translated instructions (including current).
> + * @singlestep_enabled: "Hardware" single stepping enabled.
> + *
> + * Architecture-agnostic disassembly context.
> + */
> +typedef struct DisasContextBase {
> +    TranslationBlock *tb;
> +    target_ulong pc_first;
> +    target_ulong pc_next;
> +    DisasJumpType is_jmp;
> +    unsigned int num_insns;
> +    bool singlestep_enabled;
> +} DisasContextBase;
> +
> +/**
> + * TranslatorOps:
> + * @init_disas_context: Initialize a DisasContext struct (DisasContextBase has
> + *                      already been initialized).
> + * @init_globals: Initialize global variables.
> + * @tb_start: Start translating a new TB.
> + * @insn_start: Start translating a new instruction.
> + * @breakpoint_check: Check if a breakpoint did hit. When called, the breakpoint
> + *                    has already been checked to match the PC.
> + * @disas_insn: Disassemble one instruction an return the PC for the next

s/disas_insn/translate_insn/
s/an return/and return/

> + *              one. Can set db->is_jmp to DJ_TARGET or above to stop

s/DJ_TARGET/DISAS_TARGET/

> + *              translation.
> + * @tb_stop: Stop translating a TB.
> + * @disas_flags: Get flags argument for log_target_disas().

s/disas_flags/disas_log/

> + *
> + * Target-specific operations for the generic translator loop.
> + */
> +typedef struct TranslatorOps {
> +    void (*init_disas_context)(DisasContextBase *db, CPUState *cpu);
> +    void (*init_globals)(DisasContextBase *db, CPUState *cpu);
> +    void (*tb_start)(DisasContextBase *db, CPUState *cpu);
> +    void (*insn_start)(DisasContextBase *db, CPUState *cpu);
> +    BreakpointCheckType (*breakpoint_check)(DisasContextBase *db, CPUState *cpu,
> +                                            const CPUBreakpoint *bp);
> +    target_ulong (*translate_insn)(DisasContextBase *db, CPUState *cpu);
> +    void (*tb_stop)(DisasContextBase *db, CPUState *cpu);
> +    void (*disas_log)(const DisasContextBase *db, CPUState *cpu);
> +} TranslatorOps;
> +
> +/**
> + * translate_block:
> + * @ops: Target-specific operations.
> + * @db: Disassembly context.
> + * @cpu: Target vCPU.
> + * @tb: Translation block.
> + *
> + * Generic translator loop.
> + *
> + * Translation will stop in the following cases (in order):
> + * - When set by #TranslatorOps::insn_start.
> + * - When set by #TranslatorOps::translate_insn.
> + * - When the TCG operation buffer is full.
> + * - When single-stepping is enabled (system-wide or on the current vCPU).
> + * - When too many instructions have been translated.
> + */
> +void translate_block(const TranslatorOps *ops, DisasContextBase *db,
> +                     CPUState *cpu, TranslationBlock *tb);

I'd rather avoid "block" here. Some alternatives:

- tb_translate()
- translate_tb()
- translate()
- translator_gen()
- translator_loop()

		E.
