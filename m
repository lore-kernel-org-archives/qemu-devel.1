Received: from eggs.gnu.org ([2001:4830:134:3::10]:34127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQ4Ip-0003t5-80
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 23:42:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQ4Ik-0002Yt-9T
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 23:42:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eQ4Ij-0002XH-V5
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 23:42:18 -0500
Date: Sat, 16 Dec 2017 12:42:00 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171216044200.GV7780@xz-mi>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-10-peterx@redhat.com>
	<20171213162022.GJ7173@stefanha-x1.localdomain>
	<20171215083108.GO7780@xz-mi>
	<20171215132142.GG26982@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171215132142.GG26982@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v5 09/26] monitor: create monitor dedicate
 iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Dec 15, 2017 at 01:21:42PM +0000, Stefan Hajnoczi wrote:
> On Fri, Dec 15, 2017 at 04:31:08PM +0800, Peter Xu wrote:
> > On Wed, Dec 13, 2017 at 04:20:22PM +0000, Stefan Hajnoczi wrote:
> > > On Tue, Dec 05, 2017 at 01:51:43PM +0800, Peter Xu wrote:
> > > > @@ -208,6 +209,12 @@ struct Monitor {
> > > >      QTAILQ_ENTRY(Monitor) entry;
> > > >  };
> > > >  
> > > > +struct MonitorGlobal {
> > > > +    IOThread *mon_iothread;
> > > > +};
> > > > +
> > > > +static struct MonitorGlobal mon_global;
> > > 
> > > structs can be anonymous.  That avoids the QEMU coding style violation
> > > (structs must be typedefed):
> > > 
> > >   static struct {
> > >       IOThread *mon_iothread;
> > >   } mon_global;
> > 
> > Will fix this up.  Thanks.
> > 
> > > 
> > > In general global variables are usually top-level variables in QEMU.
> > > I'm not sure why wrapping globals in a struct is useful.
> > 
> > Because I see too many global variables for monitor code, and from
> > this patch I wanted to start moving them altogether into this global
> > struct.  I didn't really do that in current series because it's more
> > like a clean up, but if you see future patches,
> 
> You cannot expect reviewers to jump around a 26 patch series to check
> for possible future changes.  Each patch must be self-contained and the
> changes need to be justified.

Noted.

> 
> > I can add a comment in the commit message, like: "Let's start to
> > create a struct to keep monitor global variables together".  Would
> > that help?
> 
> It's better to add a comment in the code:
> 
> /* Add monitor global variables to this struct */
> 
> so that other people modifying the code know what this is about and can
> participate.

Will do.

> 
> Other people might not want to do it since it leads to repetitive and
> long names like mon_global.mon_iothread.  Or they might just not see the
> struct when defining a global.
> 
> The chance of the struct being used consistently is low and therefore I
> wouldn't do it.
> 
> > > 
> > > > @@ -4117,6 +4136,16 @@ void monitor_cleanup(void)
> > > >  {
> > > >      Monitor *mon, *next;
> > > >  
> > > > +    /*
> > > > +     * We need to explicitly stop the iothread (but not destroy it),
> > > > +     * cleanup the monitor resources, then destroy the iothread.  See
> > > > +     * again on the glib bug mentioned in 2b316774f6 for a reason.
> > > > +     *
> > > > +     * TODO: the bug is fixed in glib 2.28, so we can remove this hack
> > > > +     * as long as we won't support glib versions older than it.
> > > > +     */
> > > 
> > > I find this comment confusing.  There is no GSource .finalize() in
> > > monitor.c so why does monitor_cleanup() need to work around the bug?
> > > 
> > > I see that monitor_data_destroy() is not thread-safe so the IOThread
> > > must be stopped first.  That is unrelated to glib.
> > 
> > Yeah actually that's a suggestion by Dave and Dan in previous review
> > comments which makes sense to me:
> > 
> >   http://lists.gnu.org/archive/html/qemu-devel/2017-11/msg04344.html
> > 
> > I'm fine with either way: keep it as it is,
> 
> The meaning of the comment is unclear to me and you haven't been able to
> explain it.  Therefore, merging this comment isn't justified.

(Please see below)

> 
> > or instead saying
> > "monitor_data_destroy() is not thread-safe" (which finally will still
> > root cause to that glib bug).
> 
> This is incorrect.  The problem is that the IOThread may run chardev
> handler functions while the main loop thread invokes
> monitor_data_destroy().  There is nothing protecting the chardev itself
> (it's not thread-safe!) nor the monitor state that is being freed, so a
> running chardev handler function could crash.

It's only about a single line of comment, but since we are at this, I
think it would still be good to discuss it in case I was wrong.

Firstly, I agree that chardevs are not thread-safe.  But IMHO monitors
are thread-safe.  There is the big monitor_lock to protect.  There can
be bug though, but generally speaking that lock should be doing the
thread safety work.

Next, basically when destroying the monitors logically we should never
touch the chardev if without that glib bug.  Or say, if without the
bug we should not call qemu_chr_fe_deinit() in monitor_data_destroy().
And if so, monitor does not really touch chardev at all.  Then, I do
think that we can destroy the monitor even without stopping the
iothread, and it is pretty safe.  Note that again that should be
ensured by the monitor_lock.

Now the problem is that to support the old glib versions we must call
qemu_chr_fe_deinit().  So the comment may help if one day that is not
true any more, and I do think we can remove the iothread_stop()
without any crashes.

(but I agree even keeping it forever it's not a big matter... same
 thing to the comment itself...)

As I said, I may be wrong.  Please correct me if necessary.  Thanks,

> 
> This means that even without the glib bug, it's not safe to call
> monitor_data_destroy() while the chardev is still attached to the
> IOThread event loop.
> 
> > But how about we just keep it in case
> > it may be helpful some day?
> 
> Please see above.
> 
> Stefan

-- 
Peter Xu
