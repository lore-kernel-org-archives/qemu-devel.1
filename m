Received: from eggs.gnu.org ([2001:4830:134:3::10]:47277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTWu2-0004zz-R4
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTWtx-0005Ut-S2
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:18:50 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865776960.17063.4875279139522061160.stgit@frigg.lan>
	<2bfdb883-f19b-7fcf-c28b-7ce39115937e@twiddle.net>
	<87podcebyi.fsf@frigg.lan>
	<3745ae02-3fb0-1503-9c99-98dce369f697@twiddle.net>
Date: Fri, 07 Jul 2017 19:18:28 +0200
In-Reply-To: <3745ae02-3fb0-1503-9c99-98dce369f697@twiddle.net> (Richard
	Henderson's message of "Fri, 7 Jul 2017 05:26:03 -1000")
Message-ID: <87lgo0cgij.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 23/29] target/arm: [tcg] Port to
 translate_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>, "open list:ARM" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

Richard Henderson writes:

> On 07/07/2017 01:13 AM, Llu=C3=ADs Vilanova wrote:
>>>> +    if (dc->ss_active && !dc->pstate_ss) {
>>>> +        /* Singlestep state is Active-pending.
>>>> +         * If we're in this state at the start of a TB then either
>>>> +         *  a) we just took an exception to an EL which is being debu=
gged
>>>> +         *     and this is the first insn in the exception handler
>>>> +         *  b) debug exceptions were masked and we just unmasked them
>>>> +         *     without changing EL (eg by clearing PSTATE.D)
>>>> +         * In either case we're going to take a swstep exception in t=
he
>>>> +         * "did not step an insn" case, and so the syndrome ISV and EX
>>>> +         * bits should be zero.
>>>> +         */
>>>> +        assert(dc->base.num_insns =3D=3D 1);
>>>> +        gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
>>>> +                      default_exception_el(dc));
>>>> +        dc->base.is_jmp =3D DISAS_SKIP;
>>=20
>>> This is surely DISAS_EXC -- see gen_step_complete_exception.
>>> Why introduce a new name?
>>=20
>> The original code goes straight to done_generating here, and that's the =
purpose
>> of DISAS_SKIP (skip the code executed between the end of the loop and the
>> done_generating label).

> That is the purpose of DISAS_EXC too.  We've called a noreturn helper to =
raise
> an exception and all following code is unreached.  If there *was* any cod=
e being
> emitted afterward, that is arguably a bug.

There was no code being generated after this specific case, but I haven't
checked if DISAS_EXC is set in any other place that is not immediately foll=
owed
by a "goto done_generating".

Does this mean DISAS_EXC should be on the generic code and do a "goto
done_generating" whenever it is found? And if so, what are the correct plac=
es to
check for this? After ops->insn_start, ops->translate_insn, ops->tb_stop?


Thanks,
  Lluis
