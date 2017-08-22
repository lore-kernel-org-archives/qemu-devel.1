Received: from eggs.gnu.org ([2001:4830:134:3::10]:45192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1djzNL-0007rJ-W4
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 22:57:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1djzNI-0001YR-PD
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 22:57:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1djzNI-0001YG-Fz
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 22:57:04 -0400
Date: Tue, 22 Aug 2017 10:56:54 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170822025654.GE30356@pxdev.xzpeter.org>
References: <1503301464-27886-1-git-send-email-peterx@redhat.com>
	<20170821085851.GA4371@lemon>
	<20170821100555.GC30356@pxdev.xzpeter.org>
	<20170821135743.GC4371@lemon> <20170821153622.GG2231@work-vm>
	<20170821165450.GE4371@lemon> <20170821172852.GA3236@work-vm>
	<20170822021556.GA2146@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170822021556.GA2146@lemon>
Subject: Re: [Qemu-devel] [RFC 0/6] monitor: allow per-monitor thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Aug 22, 2017 at 10:15:56AM +0800, Fam Zheng wrote:
> On Mon, 08/21 18:28, Dr. David Alan Gilbert wrote:
> > > It's not much more than asserting qemu_mutex_iothread_locked(), the problem is
> > > the new monitor thread breaks certain assumptions that was true.
> > > 
> > > What is interesting in this is that block layer's nested aio_poll() now not only
> > > run in the main thread but also in the monitor thread. Bugs may hide there.  :)
> > > 
> > > That's why I suggested a "safe by default" strategy.
> > 
> > OK, that's going to need some more flags somewhere; we've now
> > effectively got three types of command:
> >    a) Commands that can only run in the main thread
> >    b) Commands that can run in other monitor threads, but must have the bql
> >    c) Commands that can run in other monitor threads but don't take the
> >    bql
> > 
> >    The class (a) that you point out are a pain; arguably if we have to
> > split them up then perhaps we should initially only allow (c).

Good to know that this series may break something; That's really what
I want to know for this RFC post. :-)

I agree with Dave that if we assume (a) unchangable, then the only way
to go is only allow (c) in threaded monitors.

However before that, I am curious about whether we can replace the
assertion with something else like locks?  And how hard would it be?

(Paolo?)

> > 
> > > One step back, is it possible to "unblock" main thread even upon network issue?
> > > What is the scenario that causes main thread hang? Is there a backtrace?
> > 
> > There are at least 3 scenarious I know of:
> > 
> >   a) Postcopy: An IO operation takes the lock and accesses guest memory;
> >      the guest memory is missing due to userfault'd memory.
> >      Unfortunately the network connection to the source happens to fail;
> >       so we never receive that page and the thread stays stuck in the userfault.
> >      We can't issue a recovery command to reopen a network connection
> >      because the monitor is blocked.
> >   b) Postcopy: A monitor command either accesses guest memory or has
> >      to wait on another thread that is doing; e.g. info cpu  waits
> >      for the CPU threads to exit the loop, but they might be blocked
> >      waiting on userfault.
> >   c) COLO or migration: The network fails during the critical bit
> >      at the end of migration when we have the bql held.  You can't
> >      issue a migration_cancel or a colo-failover via the monitor
> >      because it's blocked.
> 
> Thanks for explainaing!
> 
> What commands are in class (c)? From the cover letter it seems migrate-incoming
> is the only one in mind, I'm not sure how it resolves any of the three
> scenarios?

I haven't really encountered (c), but I think it's the migrate_cancel
command that matters, which should not need BQL as well.  For (a) and
(b), they should both need the other migrate_incoming command.

Thanks,

> 
> > 
> > There are other advantages of being able to do bql'less commands;
> > things like an 'info status' or the like should be doable without bql,
> > so just avoding taking the bql when the management layer is doing
> > stuff (or alternatively getting faster replies on management)
> > are both useful.
> 
> Agreed. It is very useful not just for migration.
> 
> Fam

-- 
Peter Xu
