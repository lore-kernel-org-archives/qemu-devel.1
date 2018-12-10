Received: from eggs.gnu.org ([2001:4830:134:3::10]:51974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWJZ2-0003Gl-Dc
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 06:17:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWJZ0-0008Ox-MM
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 06:17:28 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:41972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gWJZ0-0008OG-EC
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 06:17:26 -0500
Received: by mail-oi1-x244.google.com with SMTP id j21so8633665oii.8
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 03:17:26 -0800 (PST)
MIME-Version: 1.0
References: <20181207155911.12710-1-peter.maydell@linaro.org>
	<87wooh1w21.fsf@linaro.org>
In-Reply-To: <87wooh1w21.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Dec 2018 11:17:13 +0000
Message-ID: <CAFEAcA8x6Xv0dL_zZRzMENhixBFw2xd5=0hYwpDF86FiH_WkSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Jaap Crezee <jaap@jcz.nl>, "patches@linaro.org" <patches@linaro.org>

On Mon, 10 Dec 2018 at 11:06, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> > We discussed this a little while back:
> > https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00154.html
> > and Jaap reported a bug which I suspect of being the same thing:
> > https://lists.gnu.org/archive/html/qemu-discuss/2018-10/msg00014.html
> >
> > Annoyingly I have lost the test case that demonstrated this
> > race, but I analysed it at the time and this should definitely
> > fix it. I have opted not to try to address any of the other
> > possible cleanup here (eg vm_stop() has a potential similar
> > race if called from a vcpu thread I suspect), since it gets
> > pretty tangled.
> >
> > Jaap: could you test whether this patch fixes the issue you
> > were seeing, please?
> > ---
> >  cpus.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/cpus.c b/cpus.c
> > index 0ddeeefc14f..b09b7027126 100644
> > --- a/cpus.c
> > +++ b/cpus.c
> > @@ -2100,7 +2100,8 @@ void qemu_init_vcpu(CPUState *cpu)
> >  void cpu_stop_current(void)
> >  {
> >      if (current_cpu) {
> > -        qemu_cpu_stop(current_cpu, true);
> > +        current_cpu->stop =3D true;
> > +        cpu_exit(current_cpu);
>
> Should the FIXME in vm_stop also be fixed?
>
>         /*
>          * FIXME: should not return to device code in case
>          * vm_stop() has been requested.
>          */
>         cpu_stop_current();
>         return 0;

This is one of the things I had in mind with:
> > I have opted not to try to address any of the other
> > possible cleanup here (eg vm_stop() has a potential similar
> > race if called from a vcpu thread I suspect), since it gets
> > pretty tangled.

though I might actually have meant pause_all_vcpus().
(For pause_all_vcpus() I think the correct thing is to
fix the hw/i386/kvmvapic.c code to work in some other way,
and then assert that pause_all_vcpus() is never called from
the VCPU thread.)

At any rate, this code is quite complicated, so I think
it's worth just fixing this specific race without getting
tangled up in everything else we could potentially refactor.

I'm not even sure how we would arrange for vm_stop() to
avoid returning to device emulation code if it has been
called from there -- I would favour instead changing/defining
the semantics to be like the shutdown-request and reset-request
where the device code expects that control will return but
the VM stop happens at the next opportunity, ie as soon
as the execution of the insn which wrote to the device
register has completed.

thanks
-- PMM
