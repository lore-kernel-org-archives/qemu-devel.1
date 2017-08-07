Received: from eggs.gnu.org ([2001:4830:134:3::10]:34161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1debz7-0007Tt-6M
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 02:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1debz4-00064z-4n
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 02:57:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1debz3-00064e-S0
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 02:57:50 -0400
Date: Mon, 7 Aug 2017 14:57:41 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170807065741.GW5561@pxdev.xzpeter.org>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-30-git-send-email-peterx@redhat.com>
	<20170803135434.GB3673@work-vm>
	<20170804085216.GO5561@pxdev.xzpeter.org>
	<20170804095226.GE2805@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170804095226.GE2805@work-vm>
Subject: Re: [Qemu-devel] [RFC 29/29] migration: reset migrate thread vars
 when resumed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Fri, Aug 04, 2017 at 10:52:27AM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Thu, Aug 03, 2017 at 02:54:35PM +0100, Dr. David Alan Gilbert wrote:

[...]

> > > > @@ -2319,6 +2327,7 @@ static void *migration_thread(void *opaque)
> > > >      /* The active state we expect to be in; ACTIVE or POSTCOPY_ACTIVE */
> > > >      enum MigrationStatus current_active_state = MIGRATION_STATUS_ACTIVE;
> > > >      bool enable_colo = migrate_colo_enabled();
> > > > +    MigThrError thr_error;
> > > >  
> > > >      rcu_register_thread();
> > > >  
> > > > @@ -2395,8 +2404,17 @@ static void *migration_thread(void *opaque)
> > > >           * Try to detect any kind of failures, and see whether we
> > > >           * should stop the migration now.
> > > >           */
> > > > -        if (migration_detect_error(s)) {
> > > > +        thr_error = migration_detect_error(s);
> > > > +        if (thr_error == MIG_THR_ERR_FATAL) {
> > > > +            /* Stop migration */
> > > >              break;
> > > > +        } else if (thr_error == MIG_THR_ERR_RECOVERED) {
> > > > +            /*
> > > > +             * Just recovered from a e.g. network failure, reset all
> > > > +             * the local variables.
> > > > +             */
> > > > +            initial_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> > > > +            initial_bytes = 0;
> > > 
> > > They don't seem that important to reset?
> > 
> > The problem is that we have this in migration_thread():
> > 
> >         if (current_time >= initial_time + BUFFER_DELAY) {
> >             uint64_t transferred_bytes = qemu_ftell(s->to_dst_file) -
> >                                          initial_bytes;
> >             uint64_t time_spent = current_time - initial_time;
> >             double bandwidth = (double)transferred_bytes / time_spent;
> >             threshold_size = bandwidth * s->parameters.downtime_limit;
> >             ...
> >         }
> > 
> > Here qemu_ftell() would possibly be very small since we have just
> > resumed... and then transferred_bytes will be extremely huge since
> > "qemu_ftell(s->to_dst_file) - initial_bytes" is actually negative...
> > Then, with luck, we'll got extremely huge "bandwidth" as well.
> 
> Ah yes that's a good reason to reset it then; add a comment like
> 'important to avoid breaking transferred_bytes and bandwidth
> calculation'

Will do.

-- 
Peter Xu
