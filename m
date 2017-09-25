Received: from eggs.gnu.org ([2001:4830:134:3::10]:42776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dwLrq-0002st-LJ
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 01:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dwLrn-000733-Hc
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 01:23:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dwLrn-00072d-BD
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 01:23:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0C4CB10F74
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 05:23:38 +0000 (UTC)
Date: Mon, 25 Sep 2017 13:23:30 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170925052330.GC19505@pxdev.xzpeter.org>
References: <1506070572-7549-1-git-send-email-peterx@redhat.com>
	<1506070572-7549-4-git-send-email-peterx@redhat.com>
	<20170922130922.GF32000@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170922130922.GF32000@lemon>
Subject: Re: [Qemu-devel] [PATCH 3/3] iothread: delay the context release to
 finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Sep 22, 2017 at 09:09:22PM +0800, Fam Zheng wrote:
> On Fri, 09/22 16:56, Peter Xu wrote:
> > When gcontext is used with iothread, the context will be destroyed
> > during iothread_stop().  That's not good since sometimes we would like
> > to keep the resources until iothread is destroyed, but we may want to
> > stop the thread before that point.
> 
> Would be nice if you can also mention the glib bug that "required" this in the
> commit message.

I can add it, but I am not sure it's very closely related (and I'm
afraid that may confuse more people).  Say, even without that bug, I
would still think it not a good idea to free the context in the loop,
especially considering that we have the finalize function there.  Thanks,

> 
> Reviewed-by: Fam Zheng <famz@redhat.com>
> 
> > 
> > Delay the destruction of gcontext to iothread finalize.  Then we can do:
> > 
> >   iothread_stop(thread);
> >   some_cleanup_on_resources();
> >   iothread_destroy(thread);
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  iothread.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/iothread.c b/iothread.c
> > index 894756b..b95369b 100644
> > --- a/iothread.c
> > +++ b/iothread.c
> > @@ -71,8 +71,6 @@ static void *iothread_run(void *opaque)
> >              g_main_loop_unref(loop);
> >  
> >              g_main_context_pop_thread_default(iothread->worker_context);
> > -            g_main_context_unref(iothread->worker_context);
> > -            iothread->worker_context = NULL;
> >          }
> >      }
> >  
> > @@ -117,6 +115,10 @@ static void iothread_instance_finalize(Object *obj)
> >      IOThread *iothread = IOTHREAD(obj);
> >  
> >      iothread_stop(iothread);
> > +    if (iothread->worker_context) {
> > +        g_main_context_unref(iothread->worker_context);
> > +        iothread->worker_context = NULL;
> > +    }
> >      qemu_cond_destroy(&iothread->init_done_cond);
> >      qemu_mutex_destroy(&iothread->init_done_lock);
> >      if (!iothread->ctx) {
> > -- 
> > 2.7.4
> > 
> > 

-- 
Peter Xu
