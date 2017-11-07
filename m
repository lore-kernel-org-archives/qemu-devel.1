Received: from eggs.gnu.org ([2001:4830:134:3::10]:58859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC90P-0005TD-2N
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:53:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC90O-0003HG-3Q
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:53:49 -0500
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:49005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eC90N-0003Gr-S6
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:53:48 -0500
Received: by mail-wr0-x231.google.com with SMTP id 15so193142wrb.5
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 10:53:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87r2taq66h.fsf@linaro.org>
References: <20171107165226.22546-1-alex.bennee@linaro.org>
	<CAFEAcA-E4Tq0gi3q5z+_5JOy0-j0=59p5WiKNFP9qmKG8=r4bg@mail.gmail.com>
	<87r2taq66h.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Nov 2017 18:53:26 +0000
Message-ID: <CAFEAcA_2QhC5BRJX51n4FP7EBOZ2qyq-H3hRhoGRLMTD=gP=Nw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] accel/tcg/translate-all: expand
 cpu_restore_state retaddr check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 7 November 2017 at 18:45, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On 7 November 2017 at 16:52, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>> We are still seeing signals during translation time when we walk over
>>> a page protection boundary. This expands the check to ensure the
>>> retaddr is inside the code generation buffer. The original suggestion
>>> was to check versus tcg_ctx.code_gen_ptr but as we now segment the
>>> translation buffer we have to settle for just a general check for
>>> being inside.
>>>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Richard Henderson <rth@twiddle.net>
>>> ---
>>>  accel/tcg/translate-all.c | 20 ++++++++++++--------
>>>  1 file changed, 12 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
>>> index 34c5e28d07..eb255af402 100644
>>> --- a/accel/tcg/translate-all.c
>>> +++ b/accel/tcg/translate-all.c
>>> @@ -357,16 +357,20 @@ bool cpu_restore_state(CPUState *cpu, uintptr_t r=
etaddr)
>>>      TranslationBlock *tb;
>>>      bool r =3D false;
>>>
>>> -    /* A retaddr of zero is invalid so we really shouldn't have ended
>>> -     * up here. The target code has likely forgotten to check retaddr
>>> -     * !=3D 0 before attempting to restore state. We return early to
>>> -     * avoid blowing up on a recursive tb_lock(). The target must have
>>> -     * previously survived a failed cpu_restore_state because
>>> -     * tb_find_pc(0) would have failed anyway. It still should be
>>> -     * fixed though.
>>> +    /* The retaddr has to be in the region of current code buffer. If
>>> +     * it's not we will not be able to resolve it here. If it is zero
>>> +     * the calling code has likely forgotten to check retaddr before
>>> +     * calling here.
>>
>> This part of the comment isn't correct -- it's entirely expected
>> that we will get here with a zero retaddr, because that is
>> how the rest of the code tells this function "no state restoration
>> required".
>
> Then why call cpu_restore_state at all? We should be consistent as there
> are plenty of places that do things like:
>
>     if (pc) {
>         /* now we have a real cpu fault */
>         cpu_restore_state(cs, pc);
>     }
>
> I'm happy to make a 0 retaddr officially valid and actually document it
> in exec-all.h. It's not like most callers even bother checking the
> return code.

Hmm, there's more places than I expected that do that "don't call
if 0" check than I thought. Overall it seems better to me to officially
allow the zero, rather than having lots of callsites that all have
to remember to check.

Incidentally if retaddr is zero then
(retaddr < (uintptr_t) tcg_init_ctx.code_gen_buffer)
is always true and you don't need to explicitly check for zero, though
it might be clearer to do so if we think we might change the rest
of the condition in future.

thanks
-- PMM
