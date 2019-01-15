Received: from eggs.gnu.org ([209.51.188.92]:55316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gjUs3-000462-1l
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:59:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gjUs0-0006r3-1Z
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:59:34 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:36671)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gjUrw-0006mu-8j
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:59:29 -0500
Date: Tue, 15 Jan 2019 14:59:24 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190115195924.GA7844@flamenco>
References: <20190102141603.3681-1-lvivier@redhat.com>
	<ea341cde-f1d6-1a25-e64f-3426adc10c3b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea341cde-f1d6-1a25-e64f-3426adc10c3b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] cpus: ignore ESRCH in
 qemu_cpu_kick_thread()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

On Tue, Jan 08, 2019 at 00:02:36 +0100, Paolo Bonzini wrote:
> On 02/01/19 15:16, Laurent Vivier wrote:
> > We can have a race condition between qemu_cpu_kick_thread() and
> > qemu_kvm_cpu_thread_fn() when we hotunplug a CPU. In this case,
> > qemu_cpu_kick_thread() can try to kick a thread that is exiting.
> > pthread_kill() returns an error and qemu is stopped by an exit(1).
> > 
> >    qemu:qemu_cpu_kick_thread: No such process
> > 
> > We can ignore safely this error.
> > 
> > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > ---
> >  cpus.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/cpus.c b/cpus.c
> > index 0ddeeefc14..4717490bd0 100644
> > --- a/cpus.c
> > +++ b/cpus.c
> > @@ -1778,7 +1778,7 @@ static void qemu_cpu_kick_thread(CPUState *cpu)
> >      }
> >      cpu->thread_kicked = true;
> >      err = pthread_kill(cpu->thread->thread, SIG_IPI);
> > -    if (err) {
> > +    if (err && err != ESRCH) {
> >          fprintf(stderr, "qemu:%s: %s", __func__, strerror(err));
> >          exit(1);
> >      }
> > 
> 
> You could in principle be sending the signal to another thread, so the
> fix is a bit hackish.  However, I don't have a better idea that is not
> racy. :(
> 
> The problem is that qemu_cpu_kick does not use any spinlock or mutex to
> synchronize against cpu_remove_sync's qemu_thread_join.  I think once
> the you reach qemu_cpu_kick in cpu_remove_sync (so if cpu->unplug) you
> do not need to reset cpu->thread_kicked anymore, but I don't think
> that's enough to fix it.

I think the per-cpu lock series[1] can help here. For instance, in
qemu_cpu_kick_thread we can acquire the CPU lock, then check cpu->unplug.
If it's set, then we don't send the signal, because the thread is on its
way out. If it isn't set, then we send the signal while still holding the
CPU lock. This guarantees that the thread exists, since cpu_remove_sync
will acquire the CPU lock to set cpu->unplug.

Thanks,

		Emilio

[1] https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg02979.html
