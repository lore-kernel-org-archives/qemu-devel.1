Received: from eggs.gnu.org ([2001:4830:134:3::10]:44283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fLPQZ-0006SO-3d
	for qemu-devel@nongnu.org; Wed, 23 May 2018 04:47:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fLPQT-0001u9-Us
	for qemu-devel@nongnu.org; Wed, 23 May 2018 04:47:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56140 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fLPQT-0001tb-Op
	for qemu-devel@nongnu.org; Wed, 23 May 2018 04:47:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 00BD24022909
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 08:47:17 +0000 (UTC)
Date: Wed, 23 May 2018 16:47:12 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180523084712.GA2540@xz-mi>
References: <20180509041734.14135-1-peterx@redhat.com>
	<20180509041734.14135-4-peterx@redhat.com>
	<87zi0ylaab.fsf@dusky.pond.sub.org> <20180518102143.GO2569@xz-mi>
	<87muwqixla.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87muwqixla.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v5 3/4] monitor: more comments on lock-free
 fleids/funcs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, May 23, 2018 at 10:29:37AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, May 17, 2018 at 02:46:36PM +0200, Markus Armbruster wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > Add some explicit comment for both Readline and cpu_set/cpu_get helpers
> >> > that they do not need the mon_lock protection.
> >> 
> >> Appreciated!
> >> 
> >> > Signed-off-by: Peter Xu <peterx@redhat.com>
> >> > ---
> >> >  monitor.c | 5 +++--
> >> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/monitor.c b/monitor.c
> >> > index d6c3c08932..ae5bca9d7c 100644
> >> > --- a/monitor.c
> >> > +++ b/monitor.c
> >> > @@ -207,7 +207,7 @@ struct Monitor {
> >> >      int suspend_cnt;            /* Needs to be accessed atomically */
> >> >      bool skip_flush;
> >> >      bool use_io_thr;
> >> > -    ReadLineState *rs;
> >> > +    ReadLineState *rs;   /* Only used in parser, so no lock needed. */
> >> 
> >> Pardon the ignorant question: why does "only used in parser" imply "no
> >> lock needed"?
> >
> > Since even if the monitors can be run in multiple threads now, the
> > monitor parser of a specific Monitor will still only be run in either
> > the main thread or the monitor iothread.  My fault to be unclear on
> > the comment.  Maybe this one is better:
> >
> >   It is only used in parser, and the parser of a monitor will only be
> >   run either in main thread or monitor IOThread but never both, so no
> >   lock is needed when accessing ReadLineState.
> 
> One further question, just to help me understand how this stuff works:
> what are the conditions for the parser running in the main thread, and
> what are the conditions for it running in the monitor IOThread?

For QMP parsers, the place is decided by Monitor.use_io_thr.  If set,
the parser runs in monitor IOThread; otherwise it still runs in main
thread.

For HMP parsers, they should always been run in the main thread.

After replying I just noticed that ReadLineState should only be used
by HMP, or to be more explicit, when MONITOR_USE_READLINE is set.  So
maybe the comment is not really accurate above - actually it never
runs in monitor iothread!  However the conclusion is still the same -
we don't need to protect it.

Thanks,

-- 
Peter Xu
