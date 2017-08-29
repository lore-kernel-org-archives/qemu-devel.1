Received: from eggs.gnu.org ([2001:4830:134:3::10]:51725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dmeJY-0006rJ-4t
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 07:04:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dmeJU-0001db-VS
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 07:04:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dmeJU-0001dR-M4
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 07:04:08 -0400
Date: Tue, 29 Aug 2017 12:03:57 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170829110357.GG3783@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1503471071-2233-1-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 0/8] monitor: allow per-monitor thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Aug 23, 2017 at 02:51:03PM +0800, Peter Xu wrote:
> v2:
> - fixed "make check" error that patchew reported
> - moved the thread_join upper in monitor_data_destroy(), before
>   resources are released
> - added one new patch (current patch 3) that fixes a nasty risk
>   condition with IOWatchPoll.  Please see commit message for more
>   information.
> - added a g_main_context_wakeup() to make sure the separate loop
>   thread can be kicked always when we want to destroy the per-monitor
>   threads.
> - added one new patch (current patch 8) to introduce migration mgmt
>   lock for migrate_incoming.
> 
> This is an extended work for migration postcopy recovery. This series
> is tested with the following series to make sure it solves the monitor
> hang problem that we have encountered for postcopy recovery:
> 
>   [RFC 00/29] Migration: postcopy failure recovery
>   [RFC 0/6] migration: re-use migrate_incoming for postcopy recovery
> 
> The root problem is that, monitor commands are all handled in main
> loop thread now, no matter how many monitors we specify. And, if main
> loop thread hangs due to some reason, all monitors will be stuck.
> This can be done in reversed order as well: if any of the monitor
> hangs, it will hang the main loop, and the rest of the monitors (if
> there is any).
> 
> That affects postcopy recovery, since the recovery requires user input
> on destination side.  If monitors hang, the destination VM dies and
> lose hope for even a final recovery.
> 
> So, sometimes we need to make sure the monitor be alive, at least one
> of them.
> 
> The whole idea of this series is that instead if handling monitor
> commands all in main loop thread, we do it separately in per-monitor
> threads.  Then, even if main loop thread hangs at any point by any
> reason, per-monitor thread can still survive.  Further, we add hint in
> QMP/HMP to show whether a command can be executed without QMP, if so,
> we avoid taking BQL when running that command.  It greatly reduced
> contention of BQL.  Now the only user of that new parameter (currently
> I call it "without-bql") is "migrate-incoming" command, which is the
> only command to rescue a paused postcopy migration.
> 
> However, even with the series, it does not mean that per-monitor
> threads will never hang.  One example is that we can still run "info
> vcpus" in per-monitor threads during a paused postcopy (in that state,
> page faults are never handled, and "info cpus" will never return since
> it tries to sync every vcpus).  So to make sure it does not hang, we
> not only need the per-monitor thread, the user should be careful as
> well on how to use it.
> 
> For postcopy recovery, we may need dedicated monitor channel for
> recovery.  In other words, a destination VM that supports postcopy
> recovery would possibly need:
> 
>   -qmp MAIN_CHANNEL -qmp RECOVERY_CHANNEL

I think this is a really horrible thing to expose to management applications.
They should not need to be aware of fact that QEMU is buggy and thus requires
that certain commands be run on different monitors to work around the bug.

I'd much prefer to see the problem described handled transparently inside
QEMU. One approach is have a dedicated thread in QEMU responsible for all
monitor I/O. This thread should never actually execute monitor commands
though, it would simply parse the command request and put data onto a queue
of pending commands, thus it could never hang. The command queue could be
processed by the main thread, or by another thread that is interested.
eg the migration thread could process any queued commands related to
migration directly.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
