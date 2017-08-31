Received: from eggs.gnu.org ([2001:4830:134:3::10]:53606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dnGDF-00042o-Ko
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 23:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dnGDC-0006uG-7g
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 23:32:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dnGDB-0006tt-V3
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 23:32:10 -0400
Date: Thu, 31 Aug 2017 11:31:55 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170831033155.GI5920@pxdev.xzpeter.org>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<20170829110357.GG3783@redhat.com>
	<877exllekz.fsf@dusky.pond.sub.org>
	<20170830101311.GB18526@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170830101311.GB18526@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 0/8] monitor: allow per-monitor thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Wed, Aug 30, 2017 at 11:13:11AM +0100, Daniel P. Berrange wrote:
> On Wed, Aug 30, 2017 at 09:06:20AM +0200, Markus Armbruster wrote:
> > "Daniel P. Berrange" <berrange@redhat.com> writes:
> > 
> > > On Wed, Aug 23, 2017 at 02:51:03PM +0800, Peter Xu wrote:
> > 
> > >> However, even with the series, it does not mean that per-monitor
> > >> threads will never hang.  One example is that we can still run "info
> > >> vcpus" in per-monitor threads during a paused postcopy (in that state,
> > >> page faults are never handled, and "info cpus" will never return since
> > >> it tries to sync every vcpus).  So to make sure it does not hang, we
> > >> not only need the per-monitor thread, the user should be careful as
> > >> well on how to use it.
> > >> 
> > >> For postcopy recovery, we may need dedicated monitor channel for
> > >> recovery.  In other words, a destination VM that supports postcopy
> > >> recovery would possibly need:
> > >> 
> > >>   -qmp MAIN_CHANNEL -qmp RECOVERY_CHANNEL
> > 
> > Where RECOVERY_CHANNEL isn't necessarily just for postcopy, but for any
> > "emergency" QMP access.  If you use it only for commands that cannot
> > hang (i.e. terminate in bounded time), then you'll always be able to get
> > commands accepted there in bounded time.
> > 
> > > I think this is a really horrible thing to expose to management applications.
> > > They should not need to be aware of fact that QEMU is buggy and thus requires
> > > that certain commands be run on different monitors to work around the bug.
> > 
> > These are (serious) design limitations, not bugs in the narrow sense of
> > the word.
> > 
> > However, I quite agree that the need for clients to know whether a
> > monitor command can hang is impractical for the general case.  What
> > might be practical is a QMP monitor mode that accepts only known
> > hang-free commands.  Hang-free could be introspectable.
> > 
> > In case you consider that ugly: it's best to explore the design space
> > first, and recoil from "ugly" second.
> 
> Actually you slightly mis-interpreted me there. I think it is ok for
> applications to have knowledge about whether a particular command
> may hang or not. Given that knowledge it should *not*, however, require
> that the application issue such commands on separate monitor channels.
> It is entirely possible to handle hang-free commands on the existing
> channel.
> 
> > > I'd much prefer to see the problem described handled transparently inside
> > > QEMU. One approach is have a dedicated thread in QEMU responsible for all
> > > monitor I/O. This thread should never actually execute monitor commands
> > > though, it would simply parse the command request and put data onto a queue
> > > of pending commands, thus it could never hang. The command queue could be
> > > processed by the main thread, or by another thread that is interested.
> > > eg the migration thread could process any queued commands related to
> > > migration directly.
> > 
> > The monitor itself can't hang then, but the thread(s) dequeuing parsed
> > commands can.
> 
> If certain commands are hang-free then you can have a dedicated thread
> that only de-queues & processes the hang-free commands. The approach I
> outlined is exactly how libvirt deals with its own RPC dispatch. We have
> certain commands that are guaranteed to not hang, which are processed by
> a dedicated pool of threads. So even if all normal RPC commands have
> hung, you can still run a subset of hang-free RPC commands.
> 
> > 
> > To maintain commands' synchronous semantics, their replies need to be
> > sent in order, which of course reintroduces the hangs.
> 
> The requirement for such ordering is just an arbitrary restriction that
> QEMU currently imposes. It is reasonable to allow arbitrary ordering of
> responses (which is what libvirt does in its RPC layer). Admittedly at
> this stage though, we would likely require some "opt in" handshake when
> initializing QMP for the app to tell QEMU it can cope with out of order
> replies. It would require that each command request has a unique serial
> number, which is included in the associated reply, so apps can match
> them up. We used to have that but iirc it was then removed.
> 
> There's other ways to deal with this, such as the job starting idea you
> mention below.
> 
> The key point though is that I don't think creating multiple monitor
> servers is a desirable approach - it is just a hack to avoid dealing
> with the root cause problems. 

Yeah I kindly agree.  It's not the root problem, but AFAIU that's the
simplest way for now to solve the problem.  But I think I understand
the major problem here - an extra channel is an interface change, and
it affects users of monitors.  So I agree we'd better be patient on
choosing a good enough interface, looks like we have two:

- dedicated "hang-able" and "hang-free" channel, or,

- async command handling, then we will have one single dedicated
  command parser (possibly as well in separate thread rather than main
  thread), per-command ID, and possibly slightly more work.  For this
  one, I believe there are different implementations.

So looks like what we need to do is firstly choose an interface, and
if we choose the 2nd, we need to further choose the implementaion.

Before getting to an conclusion, just want to make sure we have got a
consensus on that at least we should start to move the monitor command
handling into a separate thread rather than main thread, am I correct?

Thanks,

> 
> > Let's take a step back from the implementation, and talk about
> > *behavior* instead.
> > 
> > You prefer to have "the problem described handled transparently inside
> > QEMU".  I read that as "QEMU must ensure the QMP monitor is available at
> > all times".  "Available" means it accepts commands in bounded time.
> > Some commands will always finish in bounded time once accepted, others
> > may not, and whether they do may depend on the commands currently in
> > flight.
> > 
> > Commands that can always start and always terminate in bounded time are
> > no problem.
> > 
> > All the other commands have to become "job-starting": the QMP command
> > kicks off a "job", which runs concurrently with the QMP monitor for some
> > (possibly unbounded) time, then finishes.  Jobs can be examined (say to
> > monitor progress, if the job supports that) and controlled (say to
> > cancel, if the job supports that).
> > 
> > A few commands are already job-starting: migrate, the block job family,
> > dump-guest-memory with detach=true.  Whether they're already hang-free I
> > can't say; they could do risky work in their synchronous part.
> > 
> > Many commands that can hang are not job-starting.
> > 
> > Changing a command from "do the job" to "merely start the job" is a
> > compatibility break.
> > 
> > We could make the change opt-in to preserve compatibility.  But is
> > preserving a compatible QMP monitor that is prone to hang wortwhile?
> > 
> > If no, we may choose to use the resulting compatibility break to also
> > switch the packaging of jobs from the current "synchronous command +
> > broadcast message when done" to some variation of asynchronous command.
> > But that should be discussed in a separate thread, and only after we
> > know how we plan to ensure monitor availability.
> 
> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

-- 
Peter Xu
