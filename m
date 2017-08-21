Received: from eggs.gnu.org ([2001:4830:134:3::10]:55619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1djokp-0004nl-5O
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 11:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1djokm-0005eM-IQ
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 11:36:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1djokm-0005cf-8l
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 11:36:36 -0400
Date: Mon, 21 Aug 2017 16:36:23 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170821153622.GG2231@work-vm>
References: <1503301464-27886-1-git-send-email-peterx@redhat.com>
	<20170821085851.GA4371@lemon>
	<20170821100555.GC30356@pxdev.xzpeter.org>
	<20170821135743.GC4371@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170821135743.GC4371@lemon>
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
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

* Fam Zheng (famz@redhat.com) wrote:
> On Mon, 08/21 18:05, Peter Xu wrote:
> > On Mon, Aug 21, 2017 at 04:58:51PM +0800, Fam Zheng wrote:
> > > On Mon, 08/21 15:44, Peter Xu wrote:
> > > > This is an extended work for migration postcopy recovery. This series
> > > > is tested with the following series to make sure it solves the monitor
> > > > hang problem that we have encountered for postcopy recovery:
> > > > 
> > > >   [RFC 00/29] Migration: postcopy failure recovery
> > > >   [RFC 0/6] migration: re-use migrate_incoming for postcopy recovery
> > > > 
> > > > The root problem is that, monitor commands are all handled in main
> > > > loop thread now, no matter how many monitors we specify. And, if main
> > > > loop thread hangs due to some reason, all monitors will be stuck.
> > > > This can be done in reversed order as well: if any of the monitor
> > > > hangs, it will hang the main loop, and the rest of the monitors (if
> > > > there is any).
> > > > 
> > > > That affects postcopy recovery, since the recovery requires user input
> > > > on destination side.  If monitors hang, the destination VM dies and
> > > > lose hope for even a final recovery.
> > > > 
> > > > So, sometimes we need to make sure the monitor be alive, at least one
> > > > of them.
> > > > 
> > > > The whole idea of this series is that instead if handling monitor
> > > > commands all in main loop thread, we do it separately in per-monitor
> > > > threads.  Then, even if main loop thread hangs at any point by any
> > > > reason, per-monitor thread can still survive.  Further, we add hint in
> > > > QMP/HMP to show whether a command can be executed without QMP, if so,
> > > > we avoid taking BQL when running that command.  It greatly reduced
> > > > contention of BQL.  Now the only user of that new parameter (currently
> > > > I call it "without-bql") is "migrate-incoming" command, which is the
> > > > only command to rescue a paused postcopy migration.
> > > > 
> > > > However, even with the series, it does not mean that per-monitor
> > > > threads will never hang.  One example is that we can still run "info
> > > > vcpus" in per-monitor threads during a paused postcopy (in that state,
> > > > page faults are never handled, and "info cpus" will never return since
> > > > it tries to sync every vcpus).  So to make sure it does not hang, we
> > > > not only need the per-monitor thread, the user should be careful as
> > > > well on how to use it.
> > > 
> > > I think this is like saying we expect the user to understand the internals of
> > > QEMU, unless the "rules" are clearly documented.  Taking this into account,
> > > does it make sense to make the per-monitor thread only allow BQL-free commands?
> > 
> > I don't think users need to know the internals - they just need to be
> > careful on using them.  Just take the example of "info cpus": during
> > paused postcopy it will hang, but IMHO it does not mean that it's
> > illegal for user to send that command.  It's "by-design" that it'll be
> > stuck if one of the vcpus is stuck somewhere; it's just not the
> > correct way to use it when the monitor is prepared for postcopy
> > recovery.
> 
> They still need to know "what" is the correct way to use the monitor, and what
> I'm saying is there doesn't seem to be an easy way for users to know exactly
> what is correct. See below.
> 
> > 
> > And IMHO we should not treat threaded monitors special - it should be
> > exactly the same monitor service when used with main loop thread.  It
> > just has its own thread to handle the requests, so it is less
> > dependent on main loop thread, and that's all.
> 
> It's not that simple, I think all non-trivial commands need very careful audit
> before assuming they're safe. For example many block related commands
> (qmp_trasaction, for example) indirectly calls BDRV_POLL_WHILE(), which, if
> called from a per-monitor thread, will enter the else branch then fail the first
> assert.

OK, that's interesting - I'd assumed that as long as we actually held
the bql we were reasonably safe.
Can you explain what that assert is actually asserting?

Dave

> Fam
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
