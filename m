Received: from eggs.gnu.org ([2001:4830:134:3::10]:40968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fTPvc-0007hC-0O
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:56:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fTPvY-0001W1-3P
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:56:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60106 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fTPvX-0001Uf-TO
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:56:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5352C9BB46
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 10:56:26 +0000 (UTC)
Date: Thu, 14 Jun 2018 18:56:21 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180614105621.GB14019@xz-mi>
References: <20180613102642.23995-1-dgilbert@redhat.com>
	<20180613102642.23995-3-dgilbert@redhat.com>
	<20180614022130.GQ15344@xz-mi> <20180614085035.GB2616@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180614085035.GB2616@work-vm>
Subject: Re: [Qemu-devel] [PATCH 2/3] migration: Wake rate limiting for
 urgent requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, jdenemar@redhat.com

On Thu, Jun 14, 2018 at 09:50:35AM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Wed, Jun 13, 2018 at 11:26:41AM +0100, Dr. David Alan Gilbert (git) wrote:
> > 
> > [...]
> > 
> > > @@ -2932,10 +2943,24 @@ static void *migration_thread(void *opaque)
> > >  
> > >          migration_update_counters(s, current_time);
> > >  
> > > +        urgent = false;
> > >          if (qemu_file_rate_limit(s->to_dst_file)) {
> > > -            /* usleep expects microseconds */
> > > -            g_usleep((s->iteration_start_time + BUFFER_DELAY -
> > > -                      current_time) * 1000);
> > > +            /* Wait for a delay to do rate limiting OR
> > > +             * something urgent to post the semaphore.
> > > +             */
> > > +            int ms = s->iteration_start_time + BUFFER_DELAY - current_time;
> > > +            trace_migration_thread_ratelimit_pre(ms);
> > > +            if (qemu_sem_timedwait(&s->rate_limit_sem, ms) == 0) {
> > > +                /* We were worken by one or more urgent things but
> > > +                 * the timedwait will have consumed one of them.
> > > +                 * The service routine for the urgent wake will dec
> > > +                 * the semaphore itself for each item it consumes,
> > > +                 * so add this one we just eat back.
> > > +                 */
> > > +                qemu_sem_post(&s->rate_limit_sem);
> > 
> > Is it possible that we just avoid eating that in the next patch?  Then
> > we only provide a helper to "trigger an urgent request" but we only
> > consume the point here?
> 
> I think it's harder;
> This code is generic in migration.c where as the next patch is all
> specific in ram.c; so we'd have to push a flag all the way down.
> Also, the code later is very simple - every request it adds/removes
> it posts/waits the semaphore - it's nice to keep that simple.

So what I meant above was to remove this post() meanwhile remove the
wait() in unqueue_page() in the next page.  Then it'll be a
single-direction message telling that "we have some urgent work to do"
without any ACK.  That'll possibly work but we might need to run the
loop even if we don't really have postcopy pages to send (e.g., when 2
continuous postcopy requests come, we'll handle the two pages in the
first loop, but we'll run the whole iteration twice while in the 2nd
loop we'll see that the postcopy queue is empty).

The ideal solution I can think of is to use a semaphore that only with
max value equals to 1.  I suppose that can be emulated by an eventfd
but I think it's fine now with current approach; we just need to make
sure the post() and wait() are "very" paired up well when calling the
new APIs.

As a summary:

Reviewed-by: Peter Xu <peterx@redhat.com>

(One important reason for the r-b is that I see Dave's graph when
 testing the series; it's very beautiful!)

Thanks,

-- 
Peter Xu
