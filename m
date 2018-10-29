Received: from eggs.gnu.org ([2001:4830:134:3::10]:50536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gH5l7-0004O6-16
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gH5l3-0001qM-MP
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:31:00 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gH5l3-0001Pu-7o
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:30:57 -0400
Received: by mail-wm1-x342.google.com with SMTP id q12-v6so4852873wmq.0
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 04:30:35 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<001201d45f99$4f710930$ee531b90$@ru> <87tvlvmsgg.fsf@linaro.org>
	<002501d45fab$71487f90$53d97eb0$@ru> <87sh1fmpwz.fsf@linaro.org>
	<000601d46f5b$88a3cbd0$99eb6370$@ru>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <000601d46f5b$88a3cbd0$99eb6370$@ru>
Date: Mon, 29 Oct 2018 11:30:31 +0000
Message-ID: <87d0rt9ei0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH  00/21] Trace updates and plugin RFC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu, cota@braap.org


Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:

>> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
>> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
>>
>> >> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
>> >> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
>> >>
>> >> >> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
>> >> >> Any serious analysis tool should allow for us to track all memory
>> >> >> accesses so I think the guest_mem_before trace point should probab=
ly
>> >> >> be split into guest_mem_before_store and guest_mem_after_load. We
>> >> >> could go the whole hog and add potential trace points for start/en=
d of
>> >> >> all memory operations.
>> >> >
>> >> > I wanted to ask about memory tracing and found this one.
>> >> > Is it possible to use tracepoints for capturing all memory accesses?
>> >> > In our implementation we insert helpers before and after tcg
>> >> > read/write operations.
>> >>
>> >> The current tracepoint isn't enough but yes I think we could. The fir=
st
>> >> thing I need to do is de-macrofy the atomic helpers a little just to
>> >> make it a bit simpler to add the before/after tracepoints.
>> >
>> > But memory accesses can use 'fast path' without the helpers.
>> > Thus you still need inserting the new helper for that case.
>>
>> trace_guest_mem_before_tcg in tcg-op.c already does this but currently
>> only before operations. That's why I want to split it and pass the
>> load/store value register values into the helpers.
>
> One more question about your trace points.
> In case of using trace point on every instruction execution, we may need
> accessing vCPU registers (including the flags). Are they valid in such
> cases?

They are probably valid but the tricky bit will be doing it in a way
that doesn't expose the internals of the TCG. Maybe we could exploit the
GDB interface for this or come up with a named referencex API.

> I'm asking, because at least i386 translation optimizes writebacks.

How so? I have to admit the i386 translation code is the most opaque to
me but I wouldn't have thought changing the semantics of the guests
load/store operations would be a sensible idea.

Of course now you mention it my thoughts about memory tracing have been
influenced by nice clean RISCy load/store architectures where it's rare
to have calculation ops working directly with memory.

>
> Pavel Dovgalyuk


--
Alex Benn=C3=A9e
