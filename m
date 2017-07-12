Received: from eggs.gnu.org ([2001:4830:134:3::10]:33724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVDVC-0003ln-51
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:00:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVDV9-00037n-2X
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:00:10 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:48566 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVDV8-00036r-Hu
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:00:07 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
	<149942859571.8972.4761014660099212028.stgit@frigg.lan>
	<87h8yialdo.fsf@linaro.org>
Date: Wed, 12 Jul 2017 11:59:52 +0300
In-Reply-To: <87h8yialdo.fsf@linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9e=22's?=
	message of "Tue, 11 Jul 2017 19:17:39 +0100")
Message-ID: <87zicaf2t3.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v12 04/27] target: [tcg] Add generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

Alex Benn=C3=A9e writes:

> Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> writes:

>> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> ---
>> accel/tcg/Makefile.objs   |    1
>> accel/tcg/translator.c    |  152 +++++++++++++++++++++++++++++++++++++++=
++++++
>> include/exec/gen-icount.h |    2 -
>> include/exec/translator.h |   99 +++++++++++++++++++++++++++++
>> 4 files changed, 253 insertions(+), 1 deletion(-)
>> create mode 100644 accel/tcg/translator.c
>>=20
>> diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
>> index f173cd5397..3a5da5357c 100644
>> --- a/accel/tcg/Makefile.objs
>> +++ b/accel/tcg/Makefile.objs
>> @@ -1,3 +1,4 @@
>> obj-$(CONFIG_SOFTMMU) +=3D tcg-all.o
>> obj-$(CONFIG_SOFTMMU) +=3D cputlb.o
>> obj-y +=3D cpu-exec.o cpu-exec-common.o translate-all.o translate-common=
.o
>> +obj-y +=3D translator.o

> There is a merge conflict here with the current master.

I'll rebase for v13.


>> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
>> new file mode 100644
>> index 0000000000..9e0343cbb1
>> --- /dev/null
>> +++ b/accel/tcg/translator.c
>> @@ -0,0 +1,152 @@
>> +/*
>> + * Generic intermediate code generation.
>> + *
>> + * Copyright (C) 2016-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or l=
ater.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu-common.h"
>> +#include "qemu/error-report.h"
>> +#include "cpu.h"
>> +#include "tcg/tcg.h"
>> +#include "tcg/tcg-op.h"
>> +#include "exec/exec-all.h"
>> +#include "exec/gen-icount.h"
>> +#include "exec/log.h"
>> +#include "exec/translator.h"
>> +
>> +
>> +static inline void translate_block_tcg_check(const DisasContextBase *db)
>> +{
>> +    if (tcg_check_temp_count()) {
>> +        error_report("warning: TCG temporary leaks before "TARGET_FMT_l=
x,
>> +                     db->pc_next);
>> +    }
>> +}
>> +
>> +void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
>> +                     CPUState *cpu, TranslationBlock *tb)
>> +{
>> +    int max_insns;
>> +
>> +    /* Initialize DisasContext */
>> +    db->tb =3D tb;
>> +    db->pc_first =3D tb->pc;
>> +    db->pc_next =3D db->pc_first;
>> +    db->is_jmp =3D DISAS_NEXT;
>> +    db->num_insns =3D 0;
>> +    db->singlestep_enabled =3D cpu->singlestep_enabled;
>> +    ops->init_disas_context(db, cpu);
>> +
>> +    /* Initialize globals */
>> +    tcg_clear_temp_count();
>> +
>> +    /* Instruction counting */
>> +    max_insns =3D db->tb->cflags & CF_COUNT_MASK;
>> +    if (max_insns =3D=3D 0) {
>> +        max_insns =3D CF_COUNT_MASK;
>> +    }
>> +    if (max_insns > TCG_MAX_INSNS) {
>> +        max_insns =3D TCG_MAX_INSNS;
>> +    }
>> +    if (db->singlestep_enabled || singlestep) {
>> +        max_insns =3D 1;
>> +    }
>> +
>> +    /* Start translating */
>> +    gen_tb_start(db->tb);
>> +    ops->tb_start(db, cpu);
>> +
>> +    while (true) {
>> +        db->num_insns++;
>> +        ops->insn_start(db, cpu);
>> +
>> +        /* Early exit before breakpoint checks */
>> +        if (unlikely(db->is_jmp !=3D DISAS_NEXT)) {
>> +            break;
>> +        }
>> +
>> +        /* Pass breakpoint hits to target for further processing */
>> +        if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
>> +            CPUBreakpoint *bp;
>> +            QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
>> +                if (bp->pc =3D=3D db->pc_next) {
>> +                    BreakpointCheckType bp_check =3D
>> +                        ops->breakpoint_check(db, cpu, bp);
>> +                    switch (bp_check) {
>> +                    case BC_MISS:
>> +                        /* Target ignored this breakpoint, go to next */
>> +                        break;
>> +                    case BC_HIT_INSN:
>> +                        /* Hit, keep translating */
>> +                        /*
>> +                         * TODO: if we're never going to have more than=
 one
>> +                         *       BP in a single address, we can simply =
use a
>> +                         *       bool here.
>> +                         */
>> +                        goto done_breakpoints;
>> +                    case BC_HIT_TB:
>> +                        /* Hit, end TB */
>> +                        goto done_generating;
>> +                    default:
>> +                        g_assert_not_reached();
>> +                    }
>> +                }
>> +            }
>> +        }
>> +    done_breakpoints:

> For the sake of keeping the core loop easy to follow maybe it would be
> better to have a helper function for the breakpoint handling? Really
> there is only one result from the helper which is do we continue the
> loop or jump to done_generating.

The new v13 has a much simpler loop that will hopefully address your concer=
ns.

>> +
>> +        /* Accept I/O on last instruction */
>> +        if (db->num_insns =3D=3D max_insns && (db->tb->cflags & CF_LAST=
_IO)) {
>> +            gen_io_start();
>> +        }
>> +
>> +        /* Disassemble one instruction */
>> +        db->pc_next =3D ops->translate_insn(db, cpu);
>> +
>> +        /**************************************************/
>> +        /* Conditions to stop translation                 */
>> +        /**************************************************/
>> +
>> +        /* Target-specific conditions set by disassembly */
>> +        if (db->is_jmp !=3D DISAS_NEXT) {
>> +            break;
>> +        }
>> +
>> +        /* Too many instructions */
>> +        if (tcg_op_buf_full() || db->num_insns >=3D max_insns) {
>> +            db->is_jmp =3D DISAS_TOO_MANY;
>> +            break;
>> +        }
>> +
>> +        translate_block_tcg_check(db);
>> +    }

> This may be a personal taste thing but having while(true) {} and breaks
> is harder to follow than do { stuff } while (!done);

I think it is. I prefer to see the loop condition up-front, unless a do-whi=
le
makes the condition logic substantially simpler.


Thanks,
  Lluis
