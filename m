Received: from eggs.gnu.org ([2001:4830:134:3::10]:37963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1f9y7t-0008TP-CA
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 15:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1f9y7o-00027A-BE
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 15:24:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bala24@linux.vnet.ibm.com>)
	id 1f9y7o-00025x-0n
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 15:24:44 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3LJNxCc090868
	for <qemu-devel@nongnu.org>; Sat, 21 Apr 2018 15:24:42 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hg1tm72tr-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 21 Apr 2018 15:24:41 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Sat, 21 Apr 2018 20:24:39 +0100
Date: Sun, 22 Apr 2018 00:54:28 +0530
From: Balamuruhan S <bala24@linux.vnet.ibm.com>
References: <20180417132317.6910-1-bala24@linux.vnet.ibm.com>
	<20180417132317.6910-2-bala24@linux.vnet.ibm.com>
	<20180418005550.GC2317@umbus.fritz.box>
	<20180418005726.GD2317@umbus.fritz.box>
	<20180418064641.GA12871@9.122.211.20>
	<20180418083632.GB2710@work-vm>
	<20180419044452.GA11708@9.122.211.20>
	<20180419112404.GC2730@work-vm>
	<20180420054712.GH2434@umbus.fritz.box>
	<20180420102803.GF2533@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420102803.GF2533@work-vm>
Message-Id: <20180421192428.GB775@9.122.211.20>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: quintela@redhat.com, qemu-devel@nongnu.org

On Fri, Apr 20, 2018 at 11:28:04AM +0100, Dr. David Alan Gilbert wrote:
> * David Gibson (david@gibson.dropbear.id.au) wrote:
> > On Thu, Apr 19, 2018 at 12:24:04PM +0100, Dr. David Alan Gilbert wrote:
> > > * Balamuruhan S (bala24@linux.vnet.ibm.com) wrote:
> > > > On Wed, Apr 18, 2018 at 09:36:33AM +0100, Dr. David Alan Gilbert wrote:
> > > > > * Balamuruhan S (bala24@linux.vnet.ibm.com) wrote:
> > > > > > On Wed, Apr 18, 2018 at 10:57:26AM +1000, David Gibson wrote:
> > > > > > > On Wed, Apr 18, 2018 at 10:55:50AM +1000, David Gibson wrote:
> > > > > > > > On Tue, Apr 17, 2018 at 06:53:17PM +0530, Balamuruhan S wrote:
> > > > > > > > > expected_downtime value is not accurate with dirty_pages_rate * page_size,
> > > > > > > > > using ram_bytes_remaining would yeild it correct.
> > > > > > > > 
> > > > > > > > This commit message hasn't been changed since v1, but the patch is
> > > > > > > > doing something completely different.  I think most of the info from
> > > > > > > > your cover letter needs to be in here.
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> > > > > > > > > ---
> > > > > > > > >  migration/migration.c | 6 +++---
> > > > > > > > >  migration/migration.h | 1 +
> > > > > > > > >  2 files changed, 4 insertions(+), 3 deletions(-)
> > > > > > > > > 
> > > > > > > > > diff --git a/migration/migration.c b/migration/migration.c
> > > > > > > > > index 52a5092add..4d866bb920 100644
> > > > > > > > > --- a/migration/migration.c
> > > > > > > > > +++ b/migration/migration.c
> > > > > > > > > @@ -614,7 +614,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
> > > > > > > > >      }
> > > > > > > > >  
> > > > > > > > >      if (s->state != MIGRATION_STATUS_COMPLETED) {
> > > > > > > > > -        info->ram->remaining = ram_bytes_remaining();
> > > > > > > > > +        info->ram->remaining = s->ram_bytes_remaining;
> > > > > > > > >          info->ram->dirty_pages_rate = ram_counters.dirty_pages_rate;
> > > > > > > > >      }
> > > > > > > > >  }
> > > > > > > > > @@ -2227,6 +2227,7 @@ static void migration_update_counters(MigrationState *s,
> > > > > > > > >      transferred = qemu_ftell(s->to_dst_file) - s->iteration_initial_bytes;
> > > > > > > > >      time_spent = current_time - s->iteration_start_time;
> > > > > > > > >      bandwidth = (double)transferred / time_spent;
> > > > > > > > > +    s->ram_bytes_remaining = ram_bytes_remaining();
> > > > > > > > >      s->threshold_size = bandwidth * s->parameters.downtime_limit;
> > > > > > > > >  
> > > > > > > > >      s->mbps = (((double) transferred * 8.0) /
> > > > > > > > > @@ -2237,8 +2238,7 @@ static void migration_update_counters(MigrationState *s,
> > > > > > > > >       * recalculate. 10000 is a small enough number for our purposes
> > > > > > > > >       */
> > > > > > > > >      if (ram_counters.dirty_pages_rate && transferred > 10000) {
> > > > > > > > > -        s->expected_downtime = ram_counters.dirty_pages_rate *
> > > > > > > > > -            qemu_target_page_size() / bandwidth;
> > > > > > > > > +        s->expected_downtime = s->ram_bytes_remaining / bandwidth;
> > > > > > > > >      }
> > > > > > > 
> > > > > > > ..but more importantly, I still think this change is bogus.  expected
> > > > > > > downtime is not the same thing as remaining ram / bandwidth.
> > > > > > 
> > > > > > I tested precopy migration of 16M HP backed P8 guest from P8 to 1G P9 host
> > > > > > and observed precopy migration was infinite with expected_downtime set as
> > > > > > downtime-limit.
> > > > > 
> > > > > Did you debug why it was infinite? Which component of the calculation
> > > > > had gone wrong and why?
> > > > > 
> > > > > > During the discussion for Bug RH1560562, Michael Roth quoted that
> > > > > > 
> > > > > > One thing to note: in my testing I found that the "expected downtime" value
> > > > > > seems inaccurate in this scenario. To find a max downtime that allowed
> > > > > > migration to complete I had to divide "remaining ram" by "throughput" from
> > > > > > "info migrate" (after the initial pre-copy pass through ram, i.e. once
> > > > > > "dirty pages" value starts getting reported and we're just sending dirtied
> > > > > > pages).
> > > > > > 
> > > > > > Later by trying it precopy migration could able to complete with this
> > > > > > approach.
> > > > > > 
> > > > > > adding Michael Roth in cc.
> > > > > 
> > > > > We should try and _understand_ the rational for the change, not just go
> > > > > with it.  Now, remember that whatever we do is just an estimate and
> > > > 
> > > > I have made the change based on my understanding,
> > > > 
> > > > Currently the calculation is,
> > > > 
> > > > expected_downtime = (dirty_pages_rate * qemu_target_page_size) / bandwidth
> > > > 
> > > > dirty_pages_rate = No of dirty pages / time =>  its unit (1 / seconds)
> > > > qemu_target_page_size => its unit (bytes)
> > > > 
> > > > dirty_pages_rate * qemu_target_page_size => bytes/seconds
> > > > 
> > > > bandwidth = bytes transferred / time => bytes/seconds
> > > > 
> > > > dividing this would not be a measurement of time.
> > > 
> > > OK, that argument makes sense to me about why it feels broken; but see
> > > below.
> > > 
> > > > > there will be lots of cases where it's bad - so be careful what you're
> > > > > using it for - you definitely should NOT use the value in any automated
> > > > > system.
> > > > 
> > > > I agree with it and I would not use it in automated system.
> > > > 
> > > > > My problem with just using ram_bytes_remaining is that it doesn't take
> > > > > into account the rate at which the guest is changing RAM - which feels
> > > > > like it's the important measure for expected downtime.
> > > > 
> > > > ram_bytes_remaining = ram_state->migration_dirty_pages * TARGET_PAGE_SIZE
> > > > 
> > > > This means ram_bytes_remaining is proportional to guest changing RAM, so
> > > > we can consider this change would yield expected_downtime
> > > 
> > > ram_bytes_remaining comes from the *current* number of dirty pages, so it
> > > tells you how much you have to transmit, but if the guest wasn't
> > > changing RAM, then that just tells you how much longer you have to keep
> > > going - not the amount of downtime required.  e.g. right at the start of
> > > migration you might have 16G of dirty-pages, but you don't need downtime
> > > to transmit them all.
> > > 
> > > It's actually slightly different, because migration_update_counters is
> > > called in the main iteration loop after an iteration and I think that
> > > means it only ends up there either at the end of migration OR when
> > > qemu_file_rate_limit(f) causes ram_save_iterate to return to the main
> > > loop; so you've got the number of dirty pages when it's interrupted by
> > > rate limiting.
> > > 
> > > So I don't think the use of ram_bytes_remaining is right either.
> > > 
> > > What is the right answer?
> > > I'm not sure; but:
> > > 
> > >    a) If the bandwidth is lower then you can see the downtime should be
> > > longer; so  having x/bandwidth  makes sense
> > >    b) If the guest is dirtying RAM faster then you can see the downtime
> > > should be longer;  so having  dirty_pages_rate on the top seems right.
> > > 
> > > So you can kind of see where the calculation above comes from.
> > > 
> > > I can't convince myself of any calculation that actually works!
> > > 
> > > Lets imagine a setup with a guest dirtying memory at 'Dr' Bytes/s
> > > with the bandwidth (Bw), and we enter an iteration with
> > > 'Db' bytes dirty:
> > > 
> > >   The time for that iteration is:
> > >      It   = Db / Bw
> > > 
> > >   during that time we've dirtied 'Dr' more RAM, so at the end of
> > > it we have:
> > >      Db' = Dr * It
> > >          = Dr * Db
> > >            -------
> > >               Bw
> > > 
> > > But then if you follow that, in any case where Dr < Bw that iterates
> > > down to Db' being ~0  irrespective of what that ration is - but that
> > > makes no sense.
> > 
> > So, as per our IRC discussion, this is pretty hard.
> > 
> > That said, I think Bala's proposed patch is better than what we have
> > now.  It will initially be a gross over-estimate, but for for
> > non-converging migrations it should approach a reasonable estimate
> > later on.  What we have now can never really be right.
> > 
> > So while it would be nice to have some better modelling of this long
> > term, in the short term I think it makes sense to apply Bala's patch.
> 
> I'd like to see where the original one was going wrong for Bala; my
> problem is that for me, the old code (which logically is wrong) is
> giving sensible results here, within a factor of 2 of the actual
> downtime I needed to set.  The code maybe wrong, but the results are
> reasonably right.
> 

Thanks for considering the patch, can I send another version with
changes asked by David to fix commit msg explaining well about the new
changes ?

-- Bala

> iDave
> 
> > 
> > -- 
> > David Gibson			| I'll have my music baroque, and my code
> > david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> > 				| _way_ _around_!
> > http://www.ozlabs.org/~dgibson
> 
> 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
