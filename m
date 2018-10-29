Received: from eggs.gnu.org ([2001:4830:134:3::10]:57280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gH95M-0006SY-B9
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:04:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gH95H-000116-3N
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:04:06 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gH95G-00010G-H7
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:04:03 -0400
Received: by mail-wr1-x444.google.com with SMTP id d10-v6so9070391wrs.5
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 08:04:02 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<001201d45f99$4f710930$ee531b90$@ru> <87tvlvmsgg.fsf@linaro.org>
	<002501d45fab$71487f90$53d97eb0$@ru> <87sh1fmpwz.fsf@linaro.org>
	<000601d46f5b$88a3cbd0$99eb6370$@ru> <87d0rt9ei0.fsf@linaro.org>
	<000f01d46f82$552ad8d0$ff808a70$@ru>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <000f01d46f82$552ad8d0$ff808a70$@ru>
Date: Mon, 29 Oct 2018 15:03:58 +0000
Message-ID: <87a7mwaj6p.fsf@linaro.org>
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
>> > One more question about your trace points.
>> > In case of using trace point on every instruction execution, we may ne=
ed
>> > accessing vCPU registers (including the flags). Are they valid in such
>> > cases?
>>
>> They are probably valid but the tricky bit will be doing it in a way
>> that doesn't expose the internals of the TCG. Maybe we could exploit the
>> GDB interface for this or come up with a named referencex API.
>>
>> > I'm asking, because at least i386 translation optimizes writebacks.
>>
>> How so? I have to admit the i386 translation code is the most opaque to
>> me but I wouldn't have thought changing the semantics of the guests
>> load/store operations would be a sensible idea.
>
> Writeback to the registers (say EFLAGS), not to the memory.

Ahh lazy evaluation of (status) flags. Well having dug around gdbstub it
looks like we may get that wrong in for eflags anyway.

I think what is probably required is:

  - a hook in TranslatorOps, resolve_all?
  - an interface to named things registered with tcg_global_mem_new_*

And a way for the plugin to assert that any register accessed via this
is consistent at the point in the runtime the plugin hook is called.

I wonder what other front ends might have this sort of lazy/partial evaluat=
ion?

--
Alex Benn=C3=A9e
