Received: from eggs.gnu.org ([2001:4830:134:3::10]:37317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpXqb-00066t-Dn
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 06:46:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpXqX-0003BI-GV
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 06:46:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dpXqX-0003Al-81
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 06:46:13 -0400
Date: Wed, 6 Sep 2017 11:46:03 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170906104603.GK15510@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<20170829110357.GG3783@redhat.com> <20170906094846.GA2215@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170906094846.GA2215@work-vm>
Subject: Re: [Qemu-devel] [RFC v2 0/8] monitor: allow per-monitor thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Wed, Sep 06, 2017 at 10:48:46AM +0100, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrange (berrange@redhat.com) wrote:
> > On Wed, Aug 23, 2017 at 02:51:03PM +0800, Peter Xu wrote:
> > > v2:
> > > - fixed "make check" error that patchew reported
> > > - moved the thread_join upper in monitor_data_destroy(), before
> > >   resources are released
> > > - added one new patch (current patch 3) that fixes a nasty risk
> > >   condition with IOWatchPoll.  Please see commit message for more
> > >   information.
> > > - added a g_main_context_wakeup() to make sure the separate loop
> > >   thread can be kicked always when we want to destroy the per-monitor
> > >   threads.
> > > - added one new patch (current patch 8) to introduce migration mgmt
> > >   lock for migrate_incoming.
> > > 
> > > This is an extended work for migration postcopy recovery. This series
> > > is tested with the following series to make sure it solves the monitor
> > > hang problem that we have encountered for postcopy recovery:
> > > 
> > >   [RFC 00/29] Migration: postcopy failure recovery
> > >   [RFC 0/6] migration: re-use migrate_incoming for postcopy recovery
> > > 
> > > The root problem is that, monitor commands are all handled in main
> > > loop thread now, no matter how many monitors we specify. And, if main
> > > loop thread hangs due to some reason, all monitors will be stuck.
> > > This can be done in reversed order as well: if any of the monitor
> > > hangs, it will hang the main loop, and the rest of the monitors (if
> > > there is any).
> > > 
> > > That affects postcopy recovery, since the recovery requires user input
> > > on destination side.  If monitors hang, the destination VM dies and
> > > lose hope for even a final recovery.
> > > 
> > > So, sometimes we need to make sure the monitor be alive, at least one
> > > of them.
> > > 
> > > The whole idea of this series is that instead if handling monitor
> > > commands all in main loop thread, we do it separately in per-monitor
> > > threads.  Then, even if main loop thread hangs at any point by any
> > > reason, per-monitor thread can still survive.  Further, we add hint in
> > > QMP/HMP to show whether a command can be executed without QMP, if so,
> > > we avoid taking BQL when running that command.  It greatly reduced
> > > contention of BQL.  Now the only user of that new parameter (currently
> > > I call it "without-bql") is "migrate-incoming" command, which is the
> > > only command to rescue a paused postcopy migration.
> > > 
> > > However, even with the series, it does not mean that per-monitor
> > > threads will never hang.  One example is that we can still run "info
> > > vcpus" in per-monitor threads during a paused postcopy (in that state,
> > > page faults are never handled, and "info cpus" will never return since
> > > it tries to sync every vcpus).  So to make sure it does not hang, we
> > > not only need the per-monitor thread, the user should be careful as
> > > well on how to use it.
> > > 
> > > For postcopy recovery, we may need dedicated monitor channel for
> > > recovery.  In other words, a destination VM that supports postcopy
> > > recovery would possibly need:
> > > 
> > >   -qmp MAIN_CHANNEL -qmp RECOVERY_CHANNEL
> > 
> > I think this is a really horrible thing to expose to management applications.
> > They should not need to be aware of fact that QEMU is buggy and thus requires
> > that certain commands be run on different monitors to work around the bug.
> 
> It's unfortunately baked in way too deep to fix in the near term; the
> BQL is just too cantagious and we have a fundamental design of running
> all the main IO emulation in one thread.
> 
> > I'd much prefer to see the problem described handled transparently inside
> > QEMU. One approach is have a dedicated thread in QEMU responsible for all
> > monitor I/O. This thread should never actually execute monitor commands
> > though, it would simply parse the command request and put data onto a queue
> > of pending commands, thus it could never hang. The command queue could be
> > processed by the main thread, or by another thread that is interested.
> > eg the migration thread could process any queued commands related to
> > migration directly.
> 
> That requires a change in the current API to allow async command
> completion (OK that is something Marc-Andre's world has) so that
> from the one connection you can have multiple outstanding commands.
> Hmm unless....
> 
> We've also got problems that some commands don't like being run outside
> of the main thread (see Fam's reply on the 21st pointing out that a lot
> of block commands would assert).
> 
> I think the way to move to what you describe would be:
>   a) A separate thread for monitor IO
>       This seems a separate problem
>       How hard is that?  Will all the current IO mechanisms used
>       for monitors just work if we run them in a separate thread?
>       What about mux?
> 
>   b) Initially all commands get dispatched to the main thread
>      so nothing changes about the API.
> 
>   c) We create a new thread for the lock-free commands, and route
>       lock-free commands down it.
> 
>   d) We start with a rule that on any one monitor connection we
>   don't allow you to start a command until the previous one has
>   finished
> 
> (d) allows us to avoid any API changes, but allows us to do lock-free
> stuff on a separate connection like Peter's world.
> We can drop (d) once we have a way of doing async commands.
> We can add dispatching to more threads once someone describes
> what they want from those threads.
> 
> Does that work for you Dan?

It would *provided* that we do (c) for the commands Peter wants for
this migration series.  IOW, I don't want to have to have logic in
libvirt that either needs to add a 2nd monitor server, or open a 2nd
monitor connection, to deal with migration post-copy recovery in some
versions of QEMU.  So whatever is needed to make post-copy recovery
work has to be done for (c).

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
