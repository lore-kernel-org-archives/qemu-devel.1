Received: from eggs.gnu.org ([2001:4830:134:3::10]:38074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erKp4-00027o-6a
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 04:48:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erKp0-0000ej-DC
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 04:48:22 -0500
Date: Thu, 1 Mar 2018 10:48:08 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180301094808.GA4862@localhost.localdomain>
References: <20180213202701.15858-1-eblake@redhat.com>
	<20180213202701.15858-10-eblake@redhat.com>
	<20180214120525.GB4766@localhost.localdomain>
	<afb56cfd-4f42-07e5-9a65-d929b2ea9916@redhat.com>
	<20180223170525.GF3470@localhost.localdomain>
	<010d7d4e-c6d1-f8fb-8c4c-7aa0b19a94b7@redhat.com>
	<20180226140518.GA5106@localhost.localdomain>
	<1724b4e9-ff78-9725-286e-6886704f7f13@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1724b4e9-ff78-9725-286e-6886704f7f13@virtuozzo.com>
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 01.03.2018 um 08:25 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 26.02.2018 17:05, Kevin Wolf wrote:
> > Essentially, assuming a simple backing chain 'base <- overlay', we got
> > these combinations to represent in NBD (with my suggestion of the flags
> > to use):
> > 
> > 1. Cluster allocated in overlay
> >     a. non-zero data                         0
> >     b. explicit zeroes                       0 or ZERO
> > 2. Cluster marked zero in overlay           HOLE | ZERO
> > 3. Cluster preallocated/zero in overlay     ZERO
> > 4. Cluster unallocated in overlay
> >     a. Cluster allocated in base (non-zero)  HOLE
> >     b. Cluster allocated in base (zero)      HOLE or HOLE | ZERO
> >     c. Cluster marked zero in base           HOLE | ZERO
> >     d. Cluster preallocated/zero in base     HOLE | ZERO
> >     e. Cluster unallocated in base           HOLE | ZERO
> > 
> > Instead of 'base' you can read 'anywhere in the backing chain' and the
> > flags should stay the same.
> 
> I think only "anywhere in the backing chain" is valid here. Otherwise,
> semantics of bdrv_is_allocated would differ for NBD and for not-NBD.

This was meant as a mapping from cases to flags, not the other way
round, so really doesn't say anything about the cases where the block is
allocated further down the chain.

But yes, it shouldn't make a difference where in the backing chain a
block is allocated, so these cases are the same as 4.

> I think, if bdrv_is_allocated returns false, it means that we can skip
> this region in copying process, am I right?

-ENOCONTEXT? Which copying process?

There are cases where you want to copy such regions, and other cases
where you want to skip them. It depends on the use case. For example,
'qemu-img convert' skips them with -B (because the backing file is
reused), but not without -B (which creates a full copy).

Kevin
