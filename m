Received: from eggs.gnu.org ([2001:4830:134:3::10]:56150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dUyDQ-0002dL-7y
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dUyDN-0003YU-41
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:40:48 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:46334 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dUyDM-0003VY-63
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:40:44 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
	<149942859571.8972.4761014660099212028.stgit@frigg.lan>
	<65f59b75-08c3-3872-6906-20060b5b4a28@twiddle.net>
Date: Tue, 11 Jul 2017 19:40:27 +0300
In-Reply-To: <65f59b75-08c3-3872-6906-20060b5b4a28@twiddle.net> (Richard
	Henderson's message of "Fri, 7 Jul 2017 08:42:41 -1000")
Message-ID: <87eftnhqpw.fsf@frigg.lan>
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
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

Richard Henderson writes:

> On 07/07/2017 01:56 AM, Llu=C3=ADs Vilanova wrote:
[...]
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

> As I mentioned, we need some way to modify max_insns before the loop star=
t.

> (For the ultimate in max_insns modifying needs, see the sh4 patch set I p=
osted
> this morning, wherein I may *extend* max_insns in order to force it to co=
ver a
> region to be executed atomically within one TB, within the lock held by
> cpu_exec_step_atomic.)

> Based on that, I recommend

>     DisasJumpType status;
>     status =3D ops->tb_start(db, cpu, &max_insns);

> Because in my sh4 case, tb_start might itself decide that the only way to=
 handle
> the code is to raise the EXCP_ATOMIC exception and try again within
> cpu_exec_step_atomic.  Which means that we would not enter the while loop=
 at
> all.  Thus,

>> +    while (true) {

>     while (status =3D=3D DISAS_NEXT) {

>> +        db->num_insns++;
>> +        ops->insn_start(db, cpu);
>> +
>> +        /* Early exit before breakpoint checks */

> Better comment maybe?  "The insn_start hook may request early exit..."

> And, indeed, perhaps

>     status =3D ops->insn_start(db, cpu);
>     if (unlikely(status !=3D DISAS_NEXT)) {
>         break;
>     }

Since other hooks can set db->is_jmp and return values (breakpoint_check), =
I'll
stick with db->is_jmp instead. Then tb_start can return max_insns, and gene=
ric
code can refine it with checks like single-stepping.


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
>> +
>> +        /* Accept I/O on last instruction */
>> +        if (db->num_insns =3D=3D max_insns && (db->tb->cflags & CF_LAST=
_IO)) {
>> +            gen_io_start();
>> +        }
>> +
>> +        /* Disassemble one instruction */
>> +        db->pc_next =3D ops->translate_insn(db, cpu);

> I think it would be better to assign to pc_next within the hook.  We don'=
t use
> the value otherwise within the rest of the loop.

> But we do use is_jmp, immediately.  So maybe better to follow the changes=
 to
> tb_start and insn_start above.

As before, for consistency I prefer to set is_jmp instead of returning it on
hooks, since breakpoint_check() already has a return value and can set is_j=
mp.

Then, a future series adding tracing events to this loop uses db->pc_next i=
n the
generic loop, so it is going to be used.


>> +    }
>> +
>> +    ops->tb_stop(db, cpu);
>> +
>> +    if (db->tb->cflags & CF_LAST_IO) {
>> +        gen_io_end();
>> +    }

> You can't place this after tb_stop, as it'll never be executed.  We will =
have
> for certain emitted the exit_tb for all paths by now.

> Just place it before tb_stop where it usually resides.  In the case where=
 some
> is_jmp value implies unreached code, and we're using icount, we'll accept=
 the
> dead code.  But in all other cases it will get executed.

Ok!


Thanks,
  Lluis
