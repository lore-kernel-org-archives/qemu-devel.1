Received: from eggs.gnu.org ([2001:4830:134:3::10]:60213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1f9xwb-0004Nd-Ht
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 15:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1f9xwY-0005LS-80
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 15:13:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bala24@linux.vnet.ibm.com>)
	id 1f9xwX-0005Ik-TD
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 15:13:06 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3LJC8YM033518
	for <qemu-devel@nongnu.org>; Sat, 21 Apr 2018 15:13:03 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hg1ufepyy-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 21 Apr 2018 15:13:02 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Sat, 21 Apr 2018 20:13:00 +0100
Date: Sun, 22 Apr 2018 00:42:49 +0530
From: Balamuruhan S <bala24@linux.vnet.ibm.com>
References: <20180417132317.6910-1-bala24@linux.vnet.ibm.com>
	<20180417132317.6910-2-bala24@linux.vnet.ibm.com>
	<20180418005550.GC2317@umbus.fritz.box>
	<20180418005726.GD2317@umbus.fritz.box>
	<20180418064641.GA12871@9.122.211.20>
	<20180418083632.GB2710@work-vm>
	<20180419044452.GA11708@9.122.211.20>
	<20180419114817.GM2317@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419114817.GM2317@umbus.fritz.box>
Message-Id: <20180421191249.GA775@9.122.211.20>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] migration: calculate
 expected_downtime with ram_bytes_remaining()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: quintela@redhat.com, qemu-devel@nongnu.org

On Thu, Apr 19, 2018 at 09:48:17PM +1000, David Gibson wrote:
> On Thu, Apr 19, 2018 at 10:14:52AM +0530, Balamuruhan S wrote:
> > On Wed, Apr 18, 2018 at 09:36:33AM +0100, Dr. David Alan Gilbert wrote:
> > > * Balamuruhan S (bala24@linux.vnet.ibm.com) wrote:
> > > > On Wed, Apr 18, 2018 at 10:57:26AM +1000, David Gibson wrote:
> > > > > On Wed, Apr 18, 2018 at 10:55:50AM +1000, David Gibson wrote:
> > > > > > On Tue, Apr 17, 2018 at 06:53:17PM +0530, Balamuruhan S wrote:
> > > > > > > expected_downtime value is not accurate with dirty_pages_rate * page_size,
> > > > > > > using ram_bytes_remaining would yeild it correct.
> > > > > > 
> > > > > > This commit message hasn't been changed since v1, but the patch is
> > > > > > doing something completely different.  I think most of the info from
> > > > > > your cover letter needs to be in here.
> > > > > > 
> > > > > > > 
> > > > > > > Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> > > > > > > ---
> > > > > > >  migration/migration.c | 6 +++---
> > > > > > >  migration/migration.h | 1 +
> > > > > > >  2 files changed, 4 insertions(+), 3 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/migration/migration.c b/migration/migration.c
> > > > > > > index 52a5092add..4d866bb920 100644
> > > > > > > --- a/migration/migration.c
> > > > > > > +++ b/migration/migration.c
> > > > > > > @@ -614,7 +614,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
> > > > > > >      }
> > > > > > >  
> > > > > > >      if (s->state != MIGRATION_STATUS_COMPLETED) {
> > > > > > > -        info->ram->remaining = ram_bytes_remaining();
> > > > > > > +        info->ram->remaining = s->ram_bytes_remaining;
> > > > > > >          info->ram->dirty_pages_rate = ram_counters.dirty_pages_rate;
> > > > > > >      }
> > > > > > >  }
> > > > > > > @@ -2227,6 +2227,7 @@ static void migration_update_counters(MigrationState *s,
> > > > > > >      transferred = qemu_ftell(s->to_dst_file) - s->iteration_initial_bytes;
> > > > > > >      time_spent = current_time - s->iteration_start_time;
> > > > > > >      bandwidth = (double)transferred / time_spent;
> > > > > > > +    s->ram_bytes_remaining = ram_bytes_remaining();
> > > > > > >      s->threshold_size = bandwidth * s->parameters.downtime_limit;
> > > > > > >  
> > > > > > >      s->mbps = (((double) transferred * 8.0) /
> > > > > > > @@ -2237,8 +2238,7 @@ static void migration_update_counters(MigrationState *s,
> > > > > > >       * recalculate. 10000 is a small enough number for our purposes
> > > > > > >       */
> > > > > > >      if (ram_counters.dirty_pages_rate && transferred > 10000) {
> > > > > > > -        s->expected_downtime = ram_counters.dirty_pages_rate *
> > > > > > > -            qemu_target_page_size() / bandwidth;
> > > > > > > +        s->expected_downtime = s->ram_bytes_remaining / bandwidth;
> > > > > > >      }
> > > > > 
> > > > > ..but more importantly, I still think this change is bogus.  expected
> > > > > downtime is not the same thing as remaining ram / bandwidth.
> > > > 
> > > > I tested precopy migration of 16M HP backed P8 guest from P8 to 1G P9 host
> > > > and observed precopy migration was infinite with expected_downtime set as
> > > > downtime-limit.
> > > 
> > > Did you debug why it was infinite? Which component of the calculation
> > > had gone wrong and why?
> > > 
> > > > During the discussion for Bug RH1560562, Michael Roth quoted that
> > > > 
> > > > One thing to note: in my testing I found that the "expected downtime" value
> > > > seems inaccurate in this scenario. To find a max downtime that allowed
> > > > migration to complete I had to divide "remaining ram" by "throughput" from
> > > > "info migrate" (after the initial pre-copy pass through ram, i.e. once
> > > > "dirty pages" value starts getting reported and we're just sending dirtied
> > > > pages).
> > > > 
> > > > Later by trying it precopy migration could able to complete with this
> > > > approach.
> > > > 
> > > > adding Michael Roth in cc.
> > > 
> > > We should try and _understand_ the rational for the change, not just go
> > > with it.  Now, remember that whatever we do is just an estimate and
> > 
> > I have made the change based on my understanding,
> > 
> > Currently the calculation is,
> > 
> > expected_downtime = (dirty_pages_rate * qemu_target_page_size) / bandwidth
> > 
> > dirty_pages_rate = No of dirty pages / time =>  its unit (1 / seconds)
> > qemu_target_page_size => its unit (bytes)
> > 
> > dirty_pages_rate * qemu_target_page_size => bytes/seconds
> > 
> > bandwidth = bytes transferred / time => bytes/seconds
> > 
> > dividing this would not be a measurement of time.
> 
> Hm, that's a good point, the units are not right here.  And thinking
> about it more, it doesn't really make sense for it to be linear
you are right.

> either.  After all if the page dirty rate exceeds the bandwidth then
> the expected downtime is infinite... well size of ram over bandwidth,
> at least.
> 
> > > there will be lots of cases where it's bad - so be careful what you're
> > > using it for - you definitely should NOT use the value in any automated
> > > system.
> > 
> > I agree with it and I would not use it in automated system.
> > 
> > > My problem with just using ram_bytes_remaining is that it doesn't take
> > > into account the rate at which the guest is changing RAM - which feels
> > > like it's the important measure for expected downtime.
> > 
> > ram_bytes_remaining = ram_state->migration_dirty_pages * TARGET_PAGE_SIZE
> > 
> > This means ram_bytes_remaining is proportional to guest changing RAM, so
> > we can consider this change would yield expected_downtime
> 
> Well, just because the existing estimate is wrong doesn't mean this
> one is right.  Having the right units is a necessary but not
> sufficient condition.

I Agree it.

> 
> That said, I thought a bunch about this a bunch, and I think there is
> a case to be made for it - although it's a lot more subtle than what's
> been suggested so far.
> 
> So.  AFAICT the estimate of page dirty rate is based on the assumption
> that page dirties are independent of each other - one page is as
> likely to be dirtied as any other.  If we don't make that assumption,
> I don't see how we can really have an estimate as a single number.
> 
> But if that's the assumption, then predicting downtime based on it is
> futile: if the dirty rate is less than bandwidth, we can wait long
> enough and make the downtime as small as we want.  If the dirty rate
> is higher than bandwidth, then we don't converge and no downtime short
> of (ram size / bandwidth) will be sufficient.
> 
> The only way a predicted downtime makes any sense is if we assume that
> although the "instantaneous" dirty rate is high, the pages being
> dirtied are within a working set that's substantially smaller than the
> full RAM size.  In that case the expected down time becomes (working
> set size / bandwidth).

Thank you Dave and David for such a nice explanation and for your time.

I thought about it after the explanation given by you and Dave, so in
expected downtime we are trying to predict downtime based on some
values at that instant, so we need to use that value and integrate it.

1. we are currently using bandwidth but actually I think we have to use
rate of change of bandwidth, because bandwidth is not constant always.

2. we are using dirty_pages_rate and as Dave suggested,

when we enter an iteration with 'Db' bytes dirty we should be
considering ['Db' + Dr * iteration time of previous one], where for the first
iteration, iteration time of previous would be 0.

3. As you have said, that ram_bytes_remaining / bandwidth is the time to
transfer all RAM, so this should be the limit for our integration. when
we calculate for any instant it would be 0 to ram_bytes_remaining /
bandwidth at that instant.

Regards,
Bala

> 
> Predicting downtime as (ram_bytes_remaining / bandwidth) is
> essentially always wrong early in the migration, although it will be a
> poor upper bound - it will basically give you the time to transfer all
> RAM.
> 
> For a nicely converging migration it will also be wrong (but an upper
> bound) until it isn't: it will gradually decrease until it dips below
> the requested downtime threshold, at which point the migration
> completes.
> 
> For a diverging migration with a working set, as discussed above,
> ram_bytes_remaining will eventually converge on (roughly) the size of
> that working set - it won't dip (much) below that, because we can't
> keep up with the dirties within that working set.  At that point this
> does become a reasonable estimate of the necessary downtime in order
> to get the migration to complete, which I believe is the point of the
> value.
> 
> So the question is: for the purposes of this value, is a gross
> overestimate that gradually approaches a reasonable value good enough?
> 
> An estimate that would get closer, quicker would be (ram dirtied in
> interval) / bandwidth.  Where (ram dirtied in interval) is a measure
> of total ram dirtied over some measurement interval - only counting a
> page once if its dirtied multiple times during the interval.  And
> obviously you'd want some sort of averaging on that.  I think that
> would be a bit of a pain to measure, though.
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
