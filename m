Received: from eggs.gnu.org ([2001:4830:134:3::10]:54503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dWHmi-0005BQ-7b
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 03:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dWHmf-00055x-2p
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 03:46:40 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150002001195.22386.4679134058536830996.stgit@frigg.lan>
	<150002437386.22386.7745855254236101855.stgit@frigg.lan>
	<584dade6-5ce0-4950-c0e3-03128bae119e@twiddle.net>
Date: Sat, 15 Jul 2017 10:46:22 +0300
In-Reply-To: <584dade6-5ce0-4950-c0e3-03128bae119e@twiddle.net> (Richard
	Henderson's message of "Fri, 14 Jul 2017 07:26:01 -1000")
Message-ID: <87k23ab0s1.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v13 18/26] target/arm: [tcg] Port to
 breakpoint_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

Richard Henderson writes:

> On 07/13/2017 11:26 PM, Llu=C3=ADs Vilanova wrote:
>> Incrementally paves the way towards using the generic instruction transl=
ation
>> loop.
>>=20
>> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> Reviewed-by: Richard Henderson <rth@twiddle.net>
>> ---
>> target/arm/translate.c |   53 +++++++++++++++++++++++++++++++-----------=
------
>> 1 file changed, 34 insertions(+), 19 deletions(-)
>>=20
>> diff --git a/target/arm/translate.c b/target/arm/translate.c
>> index b9183fc511..55bef09739 100644
>> --- a/target/arm/translate.c
>> +++ b/target/arm/translate.c
>> @@ -11917,6 +11917,33 @@ static void arm_tr_insn_start(DisasContextBase =
*dcbase, CPUState *cpu)
>> #endif
>> }
>> +static bool arm_tr_breakpoint_check(DisasContextBase *dcbase, CPUState
>> *cpu,
>> +                                    const CPUBreakpoint *bp)
>> +{
>> +    DisasContext *dc =3D container_of(dcbase, DisasContext, base);
>> +
>> +    if (bp->flags & BP_CPU) {
>> +        gen_set_condexec(dc);
>> +        gen_set_pc_im(dc, dc->pc);
>> +        gen_helper_check_breakpoints(cpu_env);
>> +        /* End the TB early; it's likely not going to be executed */
>> +        dc->base.is_jmp =3D DISAS_UPDATE;
>> +    } else {
>> +        gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
>> +        /* The address covered by the breakpoint must be
>> +           included in [tb->pc, tb->pc + tb->size) in order
>> +           to for it to be properly cleared -- thus we
>> +           increment the PC here so that the logic setting
>> +           tb->size below does the right thing.  */
>> +        /* TODO: Advance PC by correct instruction length to
>> +         * avoid disassembler error messages */
>> +        dc->pc +=3D 2;
>> +        dc->base.is_jmp =3D DISAS_NORETURN;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>> /* generate intermediate code for basic block 'tb'.  */
>> void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
>> {
>> @@ -11965,28 +11992,16 @@ void gen_intermediate_code(CPUState *cs, Trans=
lationBlock *tb)
>> if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
>> CPUBreakpoint *bp;
>> QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
>> -                if (bp->pc =3D=3D dc->pc) {
>> -                    if (bp->flags & BP_CPU) {
>> -                        gen_set_condexec(dc);
>> -                        gen_set_pc_im(dc, dc->pc);
>> -                        gen_helper_check_breakpoints(cpu_env);
>> -                        /* End the TB early; it's likely not going to b=
e executed */
>> -                        dc->base.is_jmp =3D DISAS_UPDATE;

> Oh I see what you're doing there in the main loop.
> And I see that you're copying existing behaviour.

> That said, I do wonder if there's a better way.

> Looking back at the original patch (5d98bf8f), there do not
> seem to have been any other side effects intended; simply
> "single step" any insn for which this bp condition is met.

> Another way to handle this would be if we could adjust max_insns =3D num_=
insns.
> That would cause the loop to exit after the current insn, with DISAS_TOO_=
MANY if
> nothing else.

But adjusting num_insns (I guess passed as a pointer to breakpoint_check())=
 will
stop *after* translating the instructions, instead of before as some target=
s do
currently.

I'd really prefer to keep the current behaviour, and if in the end we see t=
hat
the use of DISAS_NORETURN in all targets is safe to switch into DISAS_TOO_M=
ANY,
we can do so in a future patch.

Cheers,
  Lluis
