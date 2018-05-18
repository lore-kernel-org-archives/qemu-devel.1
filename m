Received: from eggs.gnu.org ([2001:4830:134:3::10]:48300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJcPx-0002Tp-K1
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJcPu-0002Bb-AT
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:15:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57818 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fJcPt-0002B1-Ui
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:15:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5F07779D36
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 10:15:17 +0000 (UTC)
Date: Fri, 18 May 2018 18:15:07 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180518101507.GN2569@xz-mi>
References: <20180509041734.14135-1-peterx@redhat.com>
	<20180509041734.14135-2-peterx@redhat.com>
	<877eo2mpi5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877eo2mpi5.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v5 1/4] monitor: rename out_lock to mon_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Thu, May 17, 2018 at 02:32:34PM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > The out_lock was only protecting a few Monitor fields.  In the future
> 
> "was protecting"?  When?  Or do you mean "is protecting"?

Yes - "is protecting".

> 
> > the monitor code will start to run in multiple threads.  We turn it into
> > a bigger lock to protect not only the out buffer but also all the rest.
> 
> "We turn it into a bigger lock"?  If this patch does what its title
> claims, it can't "turn" anything.  Do you perhaps mean "We're going to
> turn it into a bigger lock"?

Yes - "are going to".

> 
> > For now we share the lock.  We can split the lock when needed.
> 
> What exactly do you mean by "we share the lock"?

I was trying to say that for now we will use a big lock for the whole
Monitor struct, then in the future we can split the big lock into
smaller ones when necessary.  It seems that it's actually bringing
misunderstanding instead of clearness.  So I think I will kill this
sentence directly.

>  > Since at it, arrange the Monitor struct a bit.  "Since we're at
> it, rearrange".  Can touch up on commit.

I guess I'll after all tune the commit message above and resend, I'll
just fix this too.

> 
> >
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

(though I'll keep the r-b for Stefan when repost; I hope it's fine)

> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  monitor.c | 53 +++++++++++++++++++++++++++++------------------------
> >  1 file changed, 29 insertions(+), 24 deletions(-)
> >
> > diff --git a/monitor.c b/monitor.c
> > index 46814af533..14c681dc8a 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -207,15 +207,6 @@ struct Monitor {
> >      int suspend_cnt;            /* Needs to be accessed atomically */
> >      bool skip_flush;
> >      bool use_io_thr;
> > -
> > -    /* We can't access guest memory when holding the lock */
> > -    QemuMutex out_lock;
> > -    QString *outbuf;
> > -    guint out_watch;
> > -
> > -    /* Read under either BQL or out_lock, written with BQL+out_lock.  */
> > -    int mux_out;
> > -
> >      ReadLineState *rs;
> >      MonitorQMP qmp;
> >      gchar *mon_cpu_path;
> > @@ -224,6 +215,20 @@ struct Monitor {
> >      mon_cmd_t *cmd_table;
> >      QLIST_HEAD(,mon_fd_t) fds;
> >      QTAILQ_ENTRY(Monitor) entry;
> > +
> > +    /*
> > +     * The per-monitor lock. We can't access guest memory when holding
> > +     * the lock.
> > +     */
> > +    QemuMutex mon_lock;
> > +
> > +    /*
> > +     * Fields that are protected by the per-monitor lock.
> > +     */
> > +    QString *outbuf;
> > +    guint out_watch;
> > +    /* Read under either BQL or mon_lock, written with BQL+mon_lock.  */
> > +    int mux_out;
> 
> This is an improvement.
> 
> >  };
> >  
> >  /* Let's add monitor global variables to this struct. */
> [Remainder of patch snipped; it looks completely mechanical]

Yes, it is.  Thanks,

-- 
Peter Xu
