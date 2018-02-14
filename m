Received: from eggs.gnu.org ([2001:4830:134:3::10]:41458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elyT0-0001zR-IN
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:55:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elySz-0001TP-9L
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:55:26 -0500
Date: Wed, 14 Feb 2018 15:55:00 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180214145500.GE4766@localhost.localdomain>
References: <20180213202701.15858-1-eblake@redhat.com>
	<20180213202701.15858-10-eblake@redhat.com>
	<20180214120525.GB4766@localhost.localdomain>
	<a2842a3d-158b-14a1-fdd8-679cd919c655@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2842a3d-158b-14a1-fdd8-679cd919c655@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 09/21] null: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 14.02.2018 um 15:44 hat Eric Blake geschrieben:
> On 02/14/2018 06:05 AM, Kevin Wolf wrote:
> > Am 13.02.2018 um 21:26 hat Eric Blake geschrieben:
> > > We are gradually moving away from sector-based interfaces, towards
> > > byte-based.  Update the null driver accordingly.
> > > 
> > > Signed-off-by: Eric Blake <eblake@redhat.com>
> > > Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > > Reviewed-by: Fam Zheng <famz@redhat.com>
> > > 
> 
> > >       if (s->read_zeroes) {
> > > -        return BDRV_BLOCK_OFFSET_VALID | start | BDRV_BLOCK_ZERO;
> > > -    } else {
> > > -        return BDRV_BLOCK_OFFSET_VALID | start;
> > > +        ret |= BDRV_BLOCK_ZERO;
> > >       }
> > > +    return ret;
> > >   }
> > 
> > Preexisting, but I think this return value is wrong. OFFSET_VALID
> > without DATA is to documented to have the following semantics:
> > 
> >   * DATA ZERO OFFSET_VALID
> >   *  f    t        t       sectors preallocated, read as zero, returned file not
> >   *                        necessarily zero at offset
> >   *  f    f        t       sectors preallocated but read from backing_hd,
> >   *                        returned file contains garbage at offset
> > 
> > I'm not sure what OFFSET_VALID is even supposed to mean for null.
> 
> Yeah, and I was even thinking about that a bit yesterday when figuring out
> what to do with nvme.  It does highlight the fact that you get garbage when
> reading from the null driver (unless the zero option was enabled, then ZERO
> is set and you know you read zeros instead) - but there no pointer that is
> preallocated (whether it contains garbage or otherwise) that you can
> actually dereference to read what the guest would see.
> 
> > 
> > Or in fact, what it is supposed to mean for any protocol driver, because
> > normally it just means I can use this offset for accessing bs->file. But
> > protocol drivers don't have a bs->file, so it's interesting to see that
> > they still all set this flag.
> > 
> > OFFSET_VALID | DATA might be excusable because I can see that it's
> > convenient that a protocol driver refers to itself as *file instead of
> > returning NULL there and then the offset is valid (though it would be
> > pointless to actually follow the file pointer), but OFFSET_VALID without
> > DATA probably isn't.
> 
> Hmm, you're probably right.  Maybe that means I should tweak the
> documentation to be more explicit: for a format driver, OFFSET_VALID can
> always be used (and *file will be set to the underlying protocol driver);
> but for a protocol driver, OFFSET_VALID only makes sense if *file is the BDS
> itself and there is an actual buffer to read (that is, the protocol driver
> must also be returning DATA and/or ZERO).  Or maybe we can indeed state that
> protocol drivers always set *file to NULL (there is no further backing file
> to reference), and thus never need to return OFFSET_VALID (but I'm not sure
> whether that will accidentally propagate back up the call stack and
> negatively affect status queries of format drivers).
> 
> Since it is pre-existing, should I respin to address the issue in a separate
> patch, or should that be a followup after this series?

It's a more fundamental question that shouldn't hold up this series. I
just wanted to raise it while I was looking at it. So yes, a followup is
fine.

Kevin
