Received: from eggs.gnu.org ([2001:4830:134:3::10]:39636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gRS8L-00026g-Bm
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 20:25:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gRS8G-0004OP-4Q
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 20:25:49 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:33499)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gRS8G-0004NT-0N
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 20:25:44 -0500
Date: Mon, 26 Nov 2018 20:25:41 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181127012541.GD22108@flamenco>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-23-cota@braap.org>
	<87mupzhg82.fsf@linaro.org> <20181123234840.GA17229@flamenco>
	<87sgzo3x6g.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sgzo3x6g.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC 22/48] cpu: hook plugin vcpu events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

On Mon, Nov 26, 2018 at 11:17:27 +0000, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > On Fri, Nov 23, 2018 at 17:10:53 +0000, Alex Bennée wrote:
> >> Emilio G. Cota <cota@braap.org> writes:
> > (snip)
> >> > @@ -1322,12 +1323,21 @@ static void qemu_tcg_rr_wait_io_event(CPUState *cpu)
> >> >
> >> >  static void qemu_wait_io_event(CPUState *cpu)
> >> >  {
> >> > +    bool asleep = false;
> >> > +
> >>
> >> slept?
> >
> > Changed to slept, thanks.
> >
> >> >      g_assert(cpu_mutex_locked(cpu));
> >> >      g_assert(!qemu_mutex_iothread_locked());
> >> >
> >> >      while (cpu_thread_is_idle(cpu)) {
> >> > +        if (!asleep) {
> >> > +            asleep = true;
> >> > +            qemu_plugin_vcpu_idle_cb(cpu);
> >> > +        }
> >> >          qemu_cond_wait(&cpu->halt_cond, &cpu->lock);
> >> >      }
> >> > +    if (asleep) {
> >> > +        qemu_plugin_vcpu_resume_cb(cpu);
> >> > +    }
> >>
> >> I wonder if having two hooks is too much? What might a plugin want to do
> >> before we go into idle sleep?
> >>
> >> It feels like we are exposing too much of the guts of TCG to the plugin
> >> here as wait_io could be for any number of internal reasons other than
> >> the actual emulation blocking for IO through a WFI or something. If a
> >> plugin really wants to track such things shouldn't it be hooking to the
> >> guest sleep points?
> >>
> >> If idle sleeps really are that important maybe we could just report our
> >> sleep time on resume - so a single hook but passing a bit more
> >> information?
> >
> > I don't have all the use cases for this figured out. For now I'm using
> > this in plugins as a way to know when a vCPU is for sure idle, which
> > is used in memory reclamation schemes such as RCU.
> 
> Couldn't we achieve the same by scheduling async or safe async work on
> the vCPU? Maybe we would expose this to the plugin as a "run callback
> when idle" function.

I'm not sure I understand the first question. Do you mean to schedule
regular work just to make the CPU idle every now and then?
Letting the CPU idle whenever it wants to is fine, so I don't see
the need to force those transitions.

BTW I just thought of a different use case for this. Imagine a plugin
is estimating how much power a CPU is consuming; if the CPU is idle,
the power model would bring down the voltage/freq and account for that.
Of course the model would also want to track the instructions being
executed, which is a nice segue to your point below.

> > What are the "guest sleep points" you mention? Are they
> > target-agnostic?
> 
> I mean we can arrive here for a variety of reasons - not all of which
> are triggered by the guest going to sleep. But that isn't your current
> use case.
> 
> They aren't target agnostic as not all guests try to fully model their
> "sleeping" instructions. Some just end up busy spinning until the event
> they should have been sleeping until happens.

I see, so you mean something like a "pause" instruction in the guest.
Plugins that needed such level of detail (like the imaginary power
model plugin I mentioned above) would have to track these
instructions as well. IOW, this would be orthogonal to the "idle"
callback as implemented in this series.

		Emilio
