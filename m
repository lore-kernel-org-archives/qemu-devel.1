Received: from eggs.gnu.org ([2001:4830:134:3::10]:41660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1edWyF-0007cD-Pz
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 02:56:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1edWyB-0005wf-QW
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 02:56:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1edWyB-0005wF-ID
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 02:56:43 -0500
Date: Mon, 22 Jan 2018 15:56:24 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180122075624.GD29532@xz-mi>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-16-peterx@redhat.com>
	<20171221112738.GL10812@lemon> <20171225032613.GD2443@xz-mi>
	<20180108164936.GG11758@stefanha-x1.localdomain>
	<20180112045149.GH2551@xz-mi>
	<20180112142832.GE11423@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180112142832.GE11423@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v6 15/27] monitor: let suspend/resume work
 even with QMPs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Jan 12, 2018 at 02:28:32PM +0000, Stefan Hajnoczi wrote:
> On Fri, Jan 12, 2018 at 12:51:49PM +0800, Peter Xu wrote:
> > On Mon, Jan 08, 2018 at 04:49:36PM +0000, Stefan Hajnoczi wrote:
> > > On Mon, Dec 25, 2017 at 11:26:13AM +0800, Peter Xu wrote:
> > > > On Thu, Dec 21, 2017 at 07:27:38PM +0800, Fam Zheng wrote:
> > > > > On Tue, 12/19 16:45, Peter Xu wrote:
> > > > > > One thing to mention is that for QMPs that are using IOThreads, we need
> > > > > > an explicit kick for the IOThread in case it is sleeping.
> > > > > > 
> > > > > > Since at it, add traces for the operations.
> > > > > > 
> > > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > > > ---
> > > > > >  monitor.c    | 26 +++++++++++++++++++++-----
> > > > > >  trace-events |  1 +
> > > > > >  2 files changed, 22 insertions(+), 5 deletions(-)
> > > > > > 
> > > > > > diff --git a/monitor.c b/monitor.c
> > > > > > index 844508d134..5f05f2e9da 100644
> > > > > > --- a/monitor.c
> > > > > > +++ b/monitor.c
> > > > > > @@ -3992,19 +3992,35 @@ static void monitor_command_cb(void *opaque, const char *cmdline,
> > > > > >  
> > > > > >  int monitor_suspend(Monitor *mon)
> > > > > >  {
> > > > > > -    if (!mon->rs)
> > > > > > -        return -ENOTTY;
> > > > > 
> > > > > Please add to the commit message why the mon->rs check is dropped, for this and
> > > > > the other one.
> > > > 
> > > > I thought it would be clear enough since mon->rs is only used by HMP
> > > > and the subject tells us that this patch is adding support for QMP.
> > > > But... sure I can add one more sentence for that!
> > > 
> > > This change breaks hmp.c:hmp_migrate():
> > > 
> > >   if (monitor_suspend(mon) < 0) {
> > >       monitor_printf(mon, "terminal does not allow synchronous "
> > >                      "migration, continuing detached\n");
> > >       return;
> > >   }
> > > 
> > > mon->rs is used by HMP code to determine whether this is an interactive
> > > terminal.  Both live migration and password prompting rely on this
> > > because they must be forbidden when doing so would be impossible (e.g.
> > > GDB stub tunneling HMP commands).
> > > 
> > > Suspending the QMP monitor is useful, but please don't break the HMP
> > > code.
> > 
> > Could you elaborate a bit on how this patch breaks anything?
> > 
> > IMHO HMP monitors always have Monitor.rs setup, so here in
> > hmp_migrate() I don't really understand why we need this check, since
> > IIUC monitor_suspend() for a HMP monitor will never fail before.
> 
> No, HMP monitors do not always have ->rs.  I mentioned that the GDB stub
> uses a non-interactive HMP monitor.
> 
> Here is the code from gdbstub.c:
> 
>   /* Initialize a monitor terminal for gdb */
>   mon_chr = qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
>                              NULL, &error_abort);
>   monitor_init(mon_chr, 0);
> 
> flags=0 means !MONITOR_USE_CONTROL (HMP) and !MONITOR_USE_READLINE
> (non-interactive).
> 
> Your patch breaks this feature.

Ah I see the point.  I'll fix that up.  So Fam's questioning is valid,
mon->rs needs to be checked.

Even, I would prefer to check the flags - they are more understandable
than checking against mon->rs.

Thanks for explaining.

-- 
Peter Xu
