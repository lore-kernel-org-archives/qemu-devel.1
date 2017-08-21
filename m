Received: from eggs.gnu.org ([2001:4830:134:3::10]:36412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1djifP-0004Aw-2S
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:06:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1djifL-000128-Tz
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:06:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1djifL-0000wq-Mk
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:06:35 -0400
Date: Mon, 21 Aug 2017 16:58:51 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170821085851.GA4371@lemon>
References: <1503301464-27886-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1503301464-27886-1-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC 0/6] monitor: allow per-monitor thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, 08/21 15:44, Peter Xu wrote:
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

I think this is like saying we expect the user to understand the internals of
QEMU, unless the "rules" are clearly documented.  Taking this into account,
does it make sense to make the per-monitor thread only allow BQL-free commands?

Fam
