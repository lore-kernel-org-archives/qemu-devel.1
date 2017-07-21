Received: from eggs.gnu.org ([2001:4830:134:3::10]:55133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dYgkR-000878-4H
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 18:50:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dYgkO-0003PJ-1o
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 18:50:15 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:60590)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dYgkN-0003Op-HT
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 18:50:11 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <20170715094243.28371-1-rth@twiddle.net>
	<20170715094243.28371-9-rth@twiddle.net>
Date: Sat, 22 Jul 2017 01:49:58 +0300
In-Reply-To: <20170715094243.28371-9-rth@twiddle.net> (Richard Henderson's
	message of "Fri, 14 Jul 2017 23:42:17 -1000")
Message-ID: <871sp9iew9.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v14 08/34] tcg: Add generic translation
 framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, cota@braap.org, alex.bennee@linaro.org, crosthwaite.peter@gmail.com, pbonzini@redhat.com

Richard Henderson writes:

> From: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
> Message-Id: <150002073981.22386.9870422422367410100.stgit@frigg.lan>
> [rth: Moved max_insns adjustment from tb_start to init_disas_context.
> Removed pc_next return from translate_insn.
> Removed tcg_check_temp_count from generic loop.
> Moved gen_io_end to exactly match gen_io_start.
> Use qemu_log instead of error_report for temporary leaks.
> Moved TB size/icount assignments before disas_log.]
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  include/exec/translator.h | 101 +++++++++++++++++++++++++++++++++++
>  accel/tcg/translator.c    | 133 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  accel/tcg/Makefile.objs   |   1 +
>  3 files changed, 235 insertions(+)
>  create mode 100644 accel/tcg/translator.c

> diff --git a/include/exec/translator.h b/include/exec/translator.h
> index b51b8f8..aa84376 100644
> --- a/include/exec/translator.h
> +++ b/include/exec/translator.h
> @@ -10,6 +10,19 @@
>  #ifndef EXEC__TRANSLATOR_H
>  #define EXEC__TRANSLATOR_H
=20
> +/*
> + * Include this header from a target-specific file, and add a
> + *
> + *     DisasContextBase base;
> + *
> + * member in your target-specific DisasContext.
> + */
> +
> +
> +#include "exec/exec-all.h"
> +#include "tcg/tcg.h"
> +
> +
>  /**
>   * DisasJumpType:
>   * @DISAS_NEXT: Next instruction in program order.
> @@ -37,4 +50,92 @@ typedef enum DisasJumpType {
>      DISAS_TARGET_11,
>  } DisasJumpType;
=20
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
> + * @init_disas_context:
> + *      Initialize the target-specific portions of DisasContext struct.
> + *      The generic DisasContextBase has already been initialized.
> + *      Return max_insns, modified as necessary by db->tb->flags.
> + *
> + * @tb_start:
> + *      Emit any code required before the start of the main loop,
> + *      after the generic gen_tb_start().
> + *
> + * @insn_start:
> + *      Emit the tcg_gen_insn_start opcode.
> + *
> + * @breakpoint_check:
> + *      When called, the breakpoint has already been checked to match th=
e PC,
> + *      but the target may decide the breakpoint missed the address
> + *      (e.g., due to conditions encoded in their flags).  Return true to
> + *      indicate that the breakpoint did hit, in which case no more brea=
kpoints
> + *      are checked.  If the breakpoint did hit, emit any code required =
to
> + *      signal the exception, and set db->is_jmp as necessary to termina=
te
> + *      the main loop.
> + *
> + * @translate_insn:
> + *      Disassemble one instruction and set db->pc_next for the start
> + *      of the following instruction.  Set db->is_jmp as necessary to
> + *      terminate the main loop.
> + *
> + * @tb_stop:
> + *      Emit any opcodes required to exit the TB, based on db->is_jmp.
> + *
> + * @disas_log:
> + *      Print instruction disassembly to log.
> + */
> +typedef struct TranslatorOps {
> +    int (*init_disas_context)(DisasContextBase *db, CPUState *cpu,
> +                              int max_insns);
> +    void (*tb_start)(DisasContextBase *db, CPUState *cpu);
> +    void (*insn_start)(DisasContextBase *db, CPUState *cpu);
> +    bool (*breakpoint_check)(DisasContextBase *db, CPUState *cpu,
> +                             const CPUBreakpoint *bp);
> +    void (*translate_insn)(DisasContextBase *db, CPUState *cpu);
> +    void (*tb_stop)(DisasContextBase *db, CPUState *cpu);
> +    void (*disas_log)(const DisasContextBase *db, CPUState *cpu);
> +} TranslatorOps;
> +
> +/**
> + * translator_loop:
> + * @ops: Target-specific operations.
> + * @db: Disassembly context.
> + * @cpu: Target vCPU.
> + * @tb: Translation block.
> + *
> + * Generic translator loop.
> + *
> + * Translation will stop in the following cases (in order):
> + * - When et by #TranslatorOps::insn_start.

Seems untrue; there's a tcg_debug_assert, so this should now probably be
breakpoint_check() instead.

> + * - When set by #TranslatorOps::translate_insn.
> + * - When the TCG operation buffer is full.
> + * - When single-stepping is enabled (system-wide or on the current vCPU=
).
> + * - When too many instructions have been translated.
> + */
> +void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
> +                     CPUState *cpu, TranslationBlock *tb);

For the "When set by #TranslatorOps:..." I'd also talk about setting is_jmp=
 for
that, and describe the type of stop that different is_jmp values produce
(TOO_MANY is "delayed" and NORETURN is "immediate" when set in
breakpoint_check; all values are "immediate" when set in translate_insn()).


Thanks,
  Lluis
