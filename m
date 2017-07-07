Received: from eggs.gnu.org ([2001:4830:134:3::10]:48139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTRDQ-0004gO-8A
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 07:14:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTRDL-0000De-2L
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 07:14:27 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865776960.17063.4875279139522061160.stgit@frigg.lan>
	<2bfdb883-f19b-7fcf-c28b-7ce39115937e@twiddle.net>
Date: Fri, 07 Jul 2017 13:13:57 +0200
In-Reply-To: <2bfdb883-f19b-7fcf-c28b-7ce39115937e@twiddle.net> (Richard
	Henderson's message of "Sat, 1 Jul 2017 18:34:17 -0700")
Message-ID: <87podcebyi.fsf@frigg.lan>
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

> On 06/28/2017 06:49 AM, Llu=C3=ADs Vilanova wrote:
>> +        /* We want to stop the TB if the next insn starts in a new page,
>> +         * or if it spans between this page and the next. This means th=
at
>> +         * if we're looking at the last halfword in the page we need to
>> +         * see if it's a 16-bit Thumb insn (which will fit in this TB)
>> +         * or a 32-bit Thumb insn (which won't).
>> +         * This is to avoid generating a silly TB with a single 16-bit =
insn
>> +         * in it at the end of this page (which would execute correctly
>> +         * but isn't very efficient).
>> +         */
>> +        return DISAS_PAGE_CROSS;

> Any reason to introduce a new name as opposed to TOO_MANY?  As far as I c=
an tell
> they're the same....

Yes, DISAS_SS and DISAS_PAGE_CROSS turned out to be remnants of previous se=
ries.


>> +    if (dc->ss_active && !dc->pstate_ss) {
>> +        /* Singlestep state is Active-pending.
>> +         * If we're in this state at the start of a TB then either
>> +         *  a) we just took an exception to an EL which is being debugg=
ed
>> +         *     and this is the first insn in the exception handler
>> +         *  b) debug exceptions were masked and we just unmasked them
>> +         *     without changing EL (eg by clearing PSTATE.D)
>> +         * In either case we're going to take a swstep exception in the
>> +         * "did not step an insn" case, and so the syndrome ISV and EX
>> +         * bits should be zero.
>> +         */
>> +        assert(dc->base.num_insns =3D=3D 1);
>> +        gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
>> +                      default_exception_el(dc));
>> +        dc->base.is_jmp =3D DISAS_SKIP;

> This is surely DISAS_EXC -- see gen_step_complete_exception.
> Why introduce a new name?

The original code goes straight to done_generating here, and that's the pur=
pose
of DISAS_SKIP (skip the code executed between the end of the loop and the
done_generating label).


Thanks,
  Lluis
