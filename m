Received: from eggs.gnu.org ([2001:4830:134:3::10]:49583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gREtS-0007t1-50
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 06:17:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gREtO-0004ei-Tp
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 06:17:34 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:45149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gREtO-0004dQ-Eo
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 06:17:30 -0500
Received: by mail-wr1-x42f.google.com with SMTP id v6so18445213wrr.12
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 03:17:30 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-23-cota@braap.org>
	<87mupzhg82.fsf@linaro.org> <20181123234840.GA17229@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181123234840.GA17229@flamenco>
Date: Mon, 26 Nov 2018 11:17:27 +0000
Message-ID: <87sgzo3x6g.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 22/48] cpu: hook plugin vcpu events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>


Emilio G. Cota <cota@braap.org> writes:

> On Fri, Nov 23, 2018 at 17:10:53 +0000, Alex Benn=C3=A9e wrote:
>> Emilio G. Cota <cota@braap.org> writes:
> (snip)
>> > @@ -1322,12 +1323,21 @@ static void qemu_tcg_rr_wait_io_event(CPUState=
 *cpu)
>> >
>> >  static void qemu_wait_io_event(CPUState *cpu)
>> >  {
>> > +    bool asleep =3D false;
>> > +
>>
>> slept?
>
> Changed to slept, thanks.
>
>> >      g_assert(cpu_mutex_locked(cpu));
>> >      g_assert(!qemu_mutex_iothread_locked());
>> >
>> >      while (cpu_thread_is_idle(cpu)) {
>> > +        if (!asleep) {
>> > +            asleep =3D true;
>> > +            qemu_plugin_vcpu_idle_cb(cpu);
>> > +        }
>> >          qemu_cond_wait(&cpu->halt_cond, &cpu->lock);
>> >      }
>> > +    if (asleep) {
>> > +        qemu_plugin_vcpu_resume_cb(cpu);
>> > +    }
>>
>> I wonder if having two hooks is too much? What might a plugin want to do
>> before we go into idle sleep?
>>
>> It feels like we are exposing too much of the guts of TCG to the plugin
>> here as wait_io could be for any number of internal reasons other than
>> the actual emulation blocking for IO through a WFI or something. If a
>> plugin really wants to track such things shouldn't it be hooking to the
>> guest sleep points?
>>
>> If idle sleeps really are that important maybe we could just report our
>> sleep time on resume - so a single hook but passing a bit more
>> information?
>
> I don't have all the use cases for this figured out. For now I'm using
> this in plugins as a way to know when a vCPU is for sure idle, which
> is used in memory reclamation schemes such as RCU.

Couldn't we achieve the same by scheduling async or safe async work on
the vCPU? Maybe we would expose this to the plugin as a "run callback
when idle" function.

> What are the "guest sleep points" you mention? Are they
> target-agnostic?

I mean we can arrive here for a variety of reasons - not all of which
are triggered by the guest going to sleep. But that isn't your current
use case.

They aren't target agnostic as not all guests try to fully model their
"sleeping" instructions. Some just end up busy spinning until the event
they should have been sleeping until happens.

>
> Thanks,
>
> 		Emilio


--
Alex Benn=C3=A9e
