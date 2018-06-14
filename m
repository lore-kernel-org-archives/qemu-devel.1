Received: from eggs.gnu.org ([2001:4830:134:3::10]:42099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTNxq-0007HP-Bm
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTNxn-0005zf-Jr
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:50:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51534 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fTNxn-0005yd-Ex
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:50:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05D3C4023334
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 08:50:39 +0000 (UTC)
Date: Thu, 14 Jun 2018 09:50:35 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180614085035.GB2616@work-vm>
References: <20180613102642.23995-1-dgilbert@redhat.com>
	<20180613102642.23995-3-dgilbert@redhat.com>
	<20180614022130.GQ15344@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614022130.GQ15344@xz-mi>
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
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, jdenemar@redhat.com

* Peter Xu (peterx@redhat.com) wrote:
> On Wed, Jun 13, 2018 at 11:26:41AM +0100, Dr. David Alan Gilbert (git) wrote:
> 
> [...]
> 
> > @@ -2932,10 +2943,24 @@ static void *migration_thread(void *opaque)
> >  
> >          migration_update_counters(s, current_time);
> >  
> > +        urgent = false;
> >          if (qemu_file_rate_limit(s->to_dst_file)) {
> > -            /* usleep expects microseconds */
> > -            g_usleep((s->iteration_start_time + BUFFER_DELAY -
> > -                      current_time) * 1000);
> > +            /* Wait for a delay to do rate limiting OR
> > +             * something urgent to post the semaphore.
> > +             */
> > +            int ms = s->iteration_start_time + BUFFER_DELAY - current_time;
> > +            trace_migration_thread_ratelimit_pre(ms);
> > +            if (qemu_sem_timedwait(&s->rate_limit_sem, ms) == 0) {
> > +                /* We were worken by one or more urgent things but
> > +                 * the timedwait will have consumed one of them.
> > +                 * The service routine for the urgent wake will dec
> > +                 * the semaphore itself for each item it consumes,
> > +                 * so add this one we just eat back.
> > +                 */
> > +                qemu_sem_post(&s->rate_limit_sem);
> 
> Is it possible that we just avoid eating that in the next patch?  Then
> we only provide a helper to "trigger an urgent request" but we only
> consume the point here?

I think it's harder;
This code is generic in migration.c where as the next patch is all
specific in ram.c; so we'd have to push a flag all the way down.
Also, the code later is very simple - every request it adds/removes
it posts/waits the semaphore - it's nice to keep that simple.

Dave

> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
