Received: from eggs.gnu.org ([2001:4830:134:3::10]:39783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f80Gq-0003vu-74
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f80Gn-0004wl-17
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:17:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60154 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f80Gm-0004te-Sh
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:17:52 -0400
Date: Mon, 16 Apr 2018 17:17:32 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180416091732.GB21143@xz-mi>
References: <20180412061108.10875-1-peterx@redhat.com>
	<20180416083748.GD28904@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180416083748.GD28904@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v3] monitor: let cur_mon be per-thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Apr 16, 2018 at 04:37:48PM +0800, Stefan Hajnoczi wrote:
> On Thu, Apr 12, 2018 at 02:11:08PM +0800, Peter Xu wrote:
> > In the future the monitor iothread may be accessing the cur_mon as
> > well (via monitor_qmp_dispatch_one()).  Before we introduce a real
> > Out-Of-Band command, let's convert the cur_mon variable to be a
> > per-thread variable to make sure there won't be a race between threads.
> >
> > Note that thread variables are not initialized to a valid value when new
> > thread is created.  However for our case we don't need to set it up,
> > since the cur_mon variable is only used in such a pattern:
> > 
> >   old_mon = cur_mon;
> >   cur_mon = xxx;
> >   (do something, read cur_mon if necessary in the stack)
> >   cur_mon = old_mon;
> > 
> > It plays a role as stack variable, so no need to be initialized at all.
> > We only need to make sure the variable won't be changed unexpectedly by
> > other threads.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> > v3:
> > - fix code style warning from patchew
> > v2:
> > - drop qemu-thread changes
> > ---
> >  include/monitor/monitor.h | 2 +-
> >  monitor.c                 | 2 +-
> >  stubs/monitor.c           | 2 +-
> >  tests/test-util-sockets.c | 2 +-
> >  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> The Monitor object is not fully thread-safe, so although the correct
> cur_mon is now accessible, code may still be unsafe.  For example,
> monitor_get_fd(cur_mon, ...) is not thread-safe and must not be used by
> OOB commands.

IMHO things like monitor_get_fd() should only be called in QMP
context, so there should always be a monitor_qmp_dispatch_one() in the
stack already (no matter whether it is in main thread or the monitor
iothread), which means that cur_mon should have been setup.  So IMHO
it's a programming error if monitor_get_fd() is called without correct
cur_mon setup after this patch.

> 
> Future OOB commands need to know which monitor.h APIs are safe to call,
> otherwise bugs are likely.  Please send a follow up patch to address
> this (e.g. doc comments, locking where needed, etc).
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks for reviewing,

-- 
Peter Xu
