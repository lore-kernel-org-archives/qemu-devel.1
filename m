Received: from eggs.gnu.org ([2001:4830:134:3::10]:45039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWKdY-0000R7-6F
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 07:26:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWKTg-0006HF-UC
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 07:16:05 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:37060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gWKTg-0006Gg-ID
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 07:16:00 -0500
Received: by mail-wr1-x42b.google.com with SMTP id j10so10240392wru.4
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 04:16:00 -0800 (PST)
References: <20181207155911.12710-1-peter.maydell@linaro.org>
	<87wooh1w21.fsf@linaro.org>
	<CAFEAcA8x6Xv0dL_zZRzMENhixBFw2xd5=0hYwpDF86FiH_WkSQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA8x6Xv0dL_zZRzMENhixBFw2xd5=0hYwpDF86FiH_WkSQ@mail.gmail.com>
Date: Mon, 10 Dec 2018 12:15:57 +0000
Message-ID: <87va411ssi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] cpus.c: Fix race condition in
 cpu_stop_current()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Jaap Crezee <jaap@jcz.nl>, "patches@linaro.org" <patches@linaro.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 10 Dec 2018 at 11:06, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>> > We discussed this a little while back:
>> > https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00154.html
>> > and Jaap reported a bug which I suspect of being the same thing:
>> > https://lists.gnu.org/archive/html/qemu-discuss/2018-10/msg00014.html
>> >
>> > Annoyingly I have lost the test case that demonstrated this
>> > race, but I analysed it at the time and this should definitely
>> > fix it. I have opted not to try to address any of the other
>> > possible cleanup here (eg vm_stop() has a potential similar
>> > race if called from a vcpu thread I suspect), since it gets
>> > pretty tangled.
>> >
>> > Jaap: could you test whether this patch fixes the issue you
>> > were seeing, please?
>> > ---
>> >  cpus.c | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/cpus.c b/cpus.c
>> > index 0ddeeefc14f..b09b7027126 100644
>> > --- a/cpus.c
>> > +++ b/cpus.c
>> > @@ -2100,7 +2100,8 @@ void qemu_init_vcpu(CPUState *cpu)
>> >  void cpu_stop_current(void)
>> >  {
>> >      if (current_cpu) {
>> > -        qemu_cpu_stop(current_cpu, true);
>> > +        current_cpu->stop =3D true;
>> > +        cpu_exit(current_cpu);
>>
>> Should the FIXME in vm_stop also be fixed?
>>
>>         /*
>>          * FIXME: should not return to device code in case
>>          * vm_stop() has been requested.
>>          */
>>         cpu_stop_current();
>>         return 0;
>
> This is one of the things I had in mind with:
>> > I have opted not to try to address any of the other
>> > possible cleanup here (eg vm_stop() has a potential similar
>> > race if called from a vcpu thread I suspect), since it gets
>> > pretty tangled.
>
> though I might actually have meant pause_all_vcpus().
> (For pause_all_vcpus() I think the correct thing is to
> fix the hw/i386/kvmvapic.c code to work in some other way,
> and then assert that pause_all_vcpus() is never called from
> the VCPU thread.)

I thought we had already fixed this, but it is yet another case. See the
patch_instruction code in the same file. The only niggle is ensuring
that either the helper is called from last instruction in the block or
forcing a cpu_exit after queuing the work.

The i386 helpers are tricky because they seem to be very deeply nested
so its hard to be sure everything really is done.

But yes I agree that pause_all_vcpus() should be reserved for non-vCPU
contexts only.

> At any rate, this code is quite complicated, so I think
> it's worth just fixing this specific race without getting
> tangled up in everything else we could potentially refactor.

Fair enough.

>
> I'm not even sure how we would arrange for vm_stop() to
> avoid returning to device emulation code if it has been
> called from there -- I would favour instead changing/defining
> the semantics to be like the shutdown-request and reset-request
> where the device code expects that control will return but
> the VM stop happens at the next opportunity, ie as soon
> as the execution of the insn which wrote to the device
> register has completed.

Is there anyway we can assert we are in a helper that has caused all
globals to be saved before the call? Otherwise we need to make similar
guarantees that the ARM TLB flushes have that they are always the last
in a block of instructions.

prep_port0092_write in PPC seems to do a similar thing. Perhaps we need
to expose some common helpers for vcpus?

--
Alex Benn=C3=A9e
