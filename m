Received: from eggs.gnu.org ([2001:4830:134:3::10]:34258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f9bEA-0007kg-Ft
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:57:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f9bE7-0003jq-FS
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:57:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42406 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f9bE7-0003jZ-90
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:57:43 -0400
Date: Fri, 20 Apr 2018 19:57:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180420185733.GG2533@work-vm>
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Balamuruhan S <bala24@linux.vnet.ibm.com>, quintela@redhat.com, qemu-devel@nongnu.org

* David Gibson (david@gibson.dropbear.id.au) wrote:

<snip>

> So.  AFAICT the estimate of page dirty rate is based on the assumption
> that page dirties are independent of each other - one page is as
> likely to be dirtied as any other.  If we don't make that assumption,
> I don't see how we can really have an estimate as a single number.

I don't think that's entirely true; at the moment we're calculating
it by looking at the number of bits that become set during a sync
operation, and the time since the last time we did the same calculation.
Multiple writes to that page in that period will only count it once.
Since it only counts it once I don't think it quite meets that
statement.  Except see the bit at the bottom.

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

I don't think it needs to be a working set - it can be gently scribbling
all over ram at a low rate and still satisfy the termination; but yes
if what you're trying to do is estimate the working set it makes sense.
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

It's complicated a bit by the fact we redo the calculations when we
limit the bandwidth, so it's not always calculated at the end of a full
dirty sync set.
But I do wonder about whether using this value after a few iterations
makes sense - when as you say it's settling into a working set.

> An estimate that would get closer, quicker would be (ram dirtied in
> interval) / bandwidth.  Where (ram dirtied in interval) is a measure
> of total ram dirtied over some measurement interval - only counting a
> page once if its dirtied multiple times during the interval.  And
> obviously you'd want some sort of averaging on that.  I think that
> would be a bit of a pain to measure, though.

If you look at the code in ram.c it has:

    /* more than 1 second = 1000 millisecons */
    if (end_time > rs->time_last_bitmap_sync + 1000) {
        /* calculate period counters */
        ram_counters.dirty_pages_rate = rs->num_dirty_pages_period * 1000
            / (end_time - rs->time_last_bitmap_sync);


  what I think that means is that, when we get stuck near the end with
lots of iterations, we do get some averaging over short iterations.
But the iterations that are long, does it need any averaging - that
depends whether you think 'one second' is over the period you want to
average over.

Dave
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
