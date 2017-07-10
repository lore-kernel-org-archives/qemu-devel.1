Received: from eggs.gnu.org ([2001:4830:134:3::10]:50370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dUZ2c-00076N-T8
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dUZ2X-0002eL-S3
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:47:58 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865776960.17063.4875279139522061160.stgit@frigg.lan>
	<2bfdb883-f19b-7fcf-c28b-7ce39115937e@twiddle.net>
	<87podcebyi.fsf@frigg.lan>
	<3745ae02-3fb0-1503-9c99-98dce369f697@twiddle.net>
	<87lgo0cgij.fsf@frigg.lan>
	<260addd5-45fe-ad10-5208-35906fd3f197@twiddle.net>
Date: Mon, 10 Jul 2017 16:47:38 +0300
In-Reply-To: <260addd5-45fe-ad10-5208-35906fd3f197@twiddle.net> (Richard
	Henderson's message of "Fri, 7 Jul 2017 07:38:26 -1000")
Message-ID: <87k23gl7yd.fsf@frigg.lan>
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

> On 07/07/2017 07:18 AM, Llu=C3=ADs Vilanova wrote:
>> There was no code being generated after this specific case, but I haven't
>> checked if DISAS_EXC is set in any other place that is not immediately f=
ollowed
>> by a "goto done_generating".

> Typically we haven't actually done a goto, but simply exit the loop and e=
mit
> nothing within the final cleanup (tb_stop?).

The case handled by DISAS_SKIP ignores tb_stop() (the target code can simply
return when DISAS_EXC is found instead of DISAS_SKIP) *and* gen_io_end(); t=
his
last one is never omitted when DISAS_EXC is found now, and theoretically
DISAS_EXC can be set by any target-specific hook. Thus my question if the
generic call to gen_io_end() should check for DISAS_EXC too (I have no idea=
 if
it would be an error to call it with DISAS_EXC set, or whether it makes sen=
se to
for a target to set it so that gen_io_start() is called but gen_io_end() is=
 then
skipped by a DISAS_EXC set in ops->translate_insn()).


>> Does this mean DISAS_EXC should be on the generic code and do a "goto
>> done_generating" whenever it is found? And if so, what are the correct p=
laces to
>> check for this? After ops->insn_start, ops->translate_insn, ops->tb_stop?

> Yes, this should be handled generically, since all targets need it.

> That said, I would prefer a better name like DISAS_NORETURN, which does n=
ot
> imply that an actual exception has been raised, but explicitly says that =
all
> following code is dead.

I can use that name.

And in fact, generalizing DISAS_NORETURN will allow dropping the enum resul=
t of
breakpoint_check(), and instead simply return a bool (whether a breakpoint =
did
hit). Targets can then set DISAS_NORETURN and return true instead of return=
ing
BC_HIT_TB (simply returning true is equivalent to the previous BC_HIT_INSN).


Cheers,
  Lluis
