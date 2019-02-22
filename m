Received: from eggs.gnu.org ([209.51.188.92]:39172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gx6dy-0005SE-IA
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:57:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gx6dx-0005E9-Hj
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:57:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gx6dx-0004ds-2a
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:57:17 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BDFCA58E24
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 08:56:40 +0000 (UTC)
Date: Fri, 22 Feb 2019 16:56:33 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190222085633.GL8904@xz-x1>
References: <20190220160628.6555-1-marcandre.lureau@redhat.com>
	<20190220160628.6555-3-marcandre.lureau@redhat.com>
	<20190221080357.GC3091@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190221080357.GC3091@xz-x1>
Subject: Re: [Qemu-devel] [PATCH 2/4] chardev: make
 qemu_chr_fe_set_handlers() context switching safer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Feb 21, 2019 at 04:03:57PM +0800, Peter Xu wrote:

[...]

> > +static gboolean
> > +main_context_wait_cb(gpointer user_data)
> > +{
> > +    struct MainContextWait *w = user_data;
> > +
> > +    qemu_mutex_lock(&w->lock);
> > +    qemu_cond_signal(&w->cond);
> > +    /* wait until switching is over */
> > +    qemu_cond_wait(&w->cond, &w->lock);
> 
> Could previous signal() directly wake up itself here?  Man
> pthread_cond_broadcast says:
> 
>        The pthread_cond_signal() function shall unblock at least one
>        of the threads that are blocked on the specified condition
>        variable cond (if any threads are blocked on cond).
> 
>        If more than one thread is blocked on a condition variable, the
>        scheduling policy shall determine the order in which threads
>        are unblocked.
> 
> So AFAIU it could, because neither there's a restriction on ordering
> of how waiters are waked up, nor there's a limitation on how many
> waiters will be waked up by a single signal().
> 
> Why not simply use two semaphores?  Then locks can be avoided too.

Please feel free to skip this question.  I think when cond_signal()
right before cond_wait() this thread is not yet in the waiting list so
at least my question seems invalid.  Then cond+lock looks fine
comparing to sems.  Sorry for the noise.

Regards,

-- 
Peter Xu
