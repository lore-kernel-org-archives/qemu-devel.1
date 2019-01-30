Received: from eggs.gnu.org ([209.51.188.92]:35370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1golz8-00024s-PO
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:16:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1golz6-0004cd-Es
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:16:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bala24@linux.vnet.ibm.com>)
	id 1golz4-0004a0-9a
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:16:40 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0U9AoUZ132370
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 04:16:33 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qb6vqp6fs-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 04:16:33 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Wed, 30 Jan 2019 09:16:31 -0000
Date: Wed, 30 Jan 2019 14:46:20 +0530
From: Balamuruhan S <bala24@linux.vnet.ibm.com>
References: <20190122150543.16889-1-bala24@linux.vnet.ibm.com>
	<20190122150543.16889-2-bala24@linux.vnet.ibm.com>
	<875zuf9vt4.fsf@trasno.org> <20190124071822.GK18231@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124071822.GK18231@xz-x1>
Message-Id: <20190130091620.GA27001@dhcp-9-109-195-155.in.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] migration: calculate expected_downtime
 considering redirtied ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, Jan 24, 2019 at 03:18:22PM +0800, Peter Xu wrote:
> On Wed, Jan 23, 2019 at 05:35:03PM +0100, Juan Quintela wrote:
> > bala24@linux.vnet.ibm.com wrote:
> > > From: Balamuruhan S <bala24@linux.vnet.ibm.com>
> > >
> > > currently we calculate expected_downtime by time taken to transfer
> > > remaining ram, but during the time we had transferred remaining ram
> > > few pages of ram might be redirtied and we need to retransfer it,
> > > so it is better to consider them for calculating expected_downtime
> > > for getting more accurate values.
> > >
> > > Total ram to be transferred = remaining ram + (redirtied ram at the
> > >                                                time when the remaining
> > >                                                ram gets transferred)
> > >
> > > redirtied ram = dirty_pages_rate * time taken to transfer remaining ram
> > >
> > > redirtied ram = dirty_pages_rate * (remaining ram / bandwidth)
> > >
> > > expected_downtime = (remaining ram + redirtied ram) / bandwidth
> > >
> > > Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> > > Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> > > ---
> > >  migration/migration.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index ffc4d9e556..dc38e9a380 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -2903,7 +2903,13 @@ static void migration_update_counters(MigrationState *s,
> > >       * recalculate. 10000 is a small enough number for our purposes
> > >       */
> > >      if (ram_counters.dirty_pages_rate && transferred > 10000) {
> > > -        s->expected_downtime = ram_counters.remaining / bandwidth;
> > > +        /* Time required to transfer remaining ram */
> > > +        remaining_ram_transfer_time = ram_counters.remaining / bandwidth
> > 
> > missing semicolon
> > 
> > > +
> > > +        /* redirty of ram at the time remaining ram gets transferred*/
> > > +        newly_dirtied_ram = ram_counters.dirty_pages_rate * remaining_ram_transfer_time
> > 
> > the same.
> > 
> > Declaration of the new variables is also missing.
> > 
> > > +        s->expected_downtime = (ram_counters.remaining + newly_dirtied_ram) / bandwidth;
> > >      }
> > >  
> > >      qemu_file_reset_rate_limit(s->to_dst_file);
> > 
> > About the numbers, I am not against it.  It is an heuristic.  Without
> > numbers (and it is very load dependent) it is not clear that this one is
> > going to be much worse/better than previous one (this should be a bit
> > better, though).
> 
> Actually I have had a question on how expected_downtime is defined and
> how it will be used by users.
> 
> My understanding is that the expected_downtime is defined as: how long
> time the guest will be down if we stop the VM right now and migrate
> all the rest of pages.
> 
> This definition makes sense in that it helps the customer to
> dynamically decide whether it's a good point to go into the last phase
> of migration.  Currently we should be able to achieve that by setting
> a very high target downtime.
> 
> And if that definition is the thing we want, the current calculation
> seems exactly the number we want, since if we stop the VM right now
> then there won't be any more data to be dirtied as well.

Thank you Peter, I thought about your definition and it makes sense
with your definition that existing calculation is appropriate and
correct.

-- Bala
> 
> Regards,
> 
> -- 
> Peter Xu
> 
